package FB2ToTXT;

#=============================================================
use XML::Parser;
use utf8;
use MIME::Base64;
use strict;			
use POSIX qw(locale_h);
use Image::Size;
use Encode;

my $Mute;
my $Styles=qr/a|style|strong|emphasis|sub|sup|strikethrough/;

sub ConvertFb2TXT{
	my ($InFile,$XslFile,$OutputFile,$PlainText,$ResEnc,$NeedClean);
	($InFile,$XslFile,$OutputFile,$PlainText,$ResEnc,$Mute,$NeedClean)=@_;
	my ($CleanXML,$BookLang,%Images)=&PreloadXML($InFile,$PlainText);
	$BookLang=~s/\A\s+//;
	$BookLang=~s/\s+\Z//;
	$CleanXML=EmbedImagesForRTF($CleanXML,%Images) unless $PlainText;
#	open TMPF,">123_1.xml";
#	print TMPF $CleanXML;
#	close TMPF;
#	open TMPF,">123_2.xml";
#	print TMPF TransformXML($CleanXML,$XslFile,$NeedClean);
#	close TMPF;
	
	open RTFILE, ">$OutputFile" or die "Error creating rtf file:\n$!";
	print RTFILE Encode::encode($ResEnc,TransformXML($CleanXML,$XslFile,$NeedClean)) or die "Error writing to rtf file:\n$!";
	close RTFILE or warn "Error closing rtf file:\n$!";
	print "\n\"$OutputFile\" - written OK, exiting\n" unless $Mute;
}


# This will clean unneeded spaces and collect images. Then images are converted
sub PreloadXML{
	my $FileToParce=shift;
	my $PlainText=shift;
	my $NeedClean=shift;
	my $CurBInaryID=undef;
	my %Binaryes;
	my @XMLBody;
	my $elem;
	my $FirstChars;
	my @Elems;
	my $InHead;
	my ($InLang,$BookLang);
	my $I=0;

	print "Extracting binaryes and cleaning text...\n" unless $Mute;

	my $FindBinaryParser=new XML::Parser(Handlers => {
	  Start => sub {
	    my $expat=shift;
	    $elem=shift;
			my %Params=@_;
			$I++;
			print "Working with element #$I\r" unless $Mute;
			if ($elem eq "binary"){
				$CurBInaryID=$Params{'id'};
			}else{
				$CurBInaryID=undef;
				
				my $Tag="<$elem";
				for (keys(%Params)){
					$Tag.=" $_=\"".xmlescape($Params{$_})."\"";
				}
				push(@XMLBody, "$Tag>");

				# For "block" elements we will remove leaning spaces
				$FirstChars=1 unless $elem=~/($Styles)/;
	
				# If we're in the header, we will preserv all text
				# if we're in body(-like) element - we remove all text in non-text
				# elements see above
				$InHead = 1 if $elem eq 'description';
				$InHead = 0 if $elem eq 'annotation';
				$InLang=1 if $elem eq 'lang';
	
				# Remember, where we are
				unshift(@Elems,$elem);
			}
		},
		Char  => sub {
			if (defined($CurBInaryID)){
				$Binaryes{$CurBInaryID}.=$_[1] unless $PlainText;
			} else {
				my $XText=$_[1];
				$XText=~s/[\r\n\t]/ /g;
				# Leading spaces
				$XText=~s/^\s+// if $FirstChars;
				# We store data only if it's a text container (in header too)
				push(@XMLBody,xmlescape($XText)) if ($InHead or $Elems[0]=~/\A(v|p|subtitle|td|th|text-author|$Styles)\Z/);
				$FirstChars=0;
				$BookLang.=$_[1] if $InLang;
			}
	  },
		End => sub {
			$InHead = 0 if $_[1] eq 'description';
			$InHead = 1 if $_[1] eq 'annotation';
			$InLang=0 if $_[1] eq 'lang';
			$XMLBody[$#XMLBody]=~s/\s\Z//;
			push(@XMLBody,"</".$_[1].">") unless ($_[1] eq "binary");
			shift(@Elems);
		}
	});
	# ok, let's get it ower with now - all clean and binary collected
	$FindBinaryParser->parsefile($FileToParce);
	my $XMLBody=join('',@XMLBody);
	if  ($NeedClean){
		print "\nPerforming final text cleanup...\n" unless $Mute;
		$XMLBody=~s/[\r\n\t]/ /g;
		$XMLBody=~s/\A\s+//;
		$XMLBody=~s/\s+\Z//;
		$XMLBody=~s/\s+/ /g;
		$XMLBody=~s/([pv])>\s+/$1>/g;
		$XMLBody=~s/(p[^>]*>)[-–—] /$1–\xA0/g;
		$XMLBody=~s/(p[^>]*>)[-—]/$1–/g;
		$XMLBody=~s/-(\s)/–$1/g;
	}
#	and let's make images encoding rtf-styled
	if (!$PlainText){
		my $ImgCount=keys(%Binaryes);
		print "Converting images ($ImgCount) to RTF-ready text...\n" unless $Mute;
		for (keys(%Binaryes)){
			$Binaryes{$_}=CodeImage(decode_base64($Binaryes{$_}));
		}
	}
	
	print "\nFirst phase done...\n" unless $Mute;
	return ($XMLBody,$BookLang,%Binaryes);
}

# we go thrue a file once more to insert newly created images content into xml
sub EmbedImagesForRTF{
	my ($InXml,%Images)=@_;
	my @XMLBody;
	my $I=0;
	my $PrevElementIsP;
	print "\nInserting images and converting foreighn characters...\n" unless $Mute;

	my $ReplaceImagesParcer=new XML::Parser(Handlers => {
	  Start => sub {
	    my $expat=shift;
	    my $elem=shift;
			my %Params=@_;
			print "Working with element #$I\r" unless $Mute;
			$I++;
			if ($elem eq "image"){
				# it's a bit tricky, to handle namespaces like this,
				# but let's consider file is valid - and it will work well...
				my $imgID;
				for (keys(%Params)){
					$imgID=$Params{$_} if /(.+:)?href/;
				}
				$imgID=~s/\A\#//;
				push(@XMLBody,"<image>".$Images{$imgID}."</image>");
			}else{
				if ($elem =~ /\A[pv]\Z/){
					$Params{'prev-element-is-p-too'}=1 if $PrevElementIsP;
				} else {$PrevElementIsP=0}
				my $Tag="<$elem";
				for (keys(%Params)){
					$Tag.=" $_=\"".xmlescape($Params{$_})."\"";
				}
				push(@XMLBody,"$Tag>");
			}
		},
		Char  => sub {
			push(@XMLBody,xmlescape(RtfEscape($_[1])));
	  },
		End => sub {
			push(@XMLBody,"</".$_[1].">") unless ($_[1] eq "image");
			$PrevElementIsP=$_[1]=~ /\A[pv]\Z/;
		}
	});
	# ok, let's get it ower with now - all clean and binary collected
	$ReplaceImagesParcer->parse($InXml);
#	print "\nDocument preparations complete, xml length is ".length($XMLBody)."\n" unless $Mute;
	return join('',@XMLBody);
}

# XSL transformation
sub TransformXML{
	my $XML=shift;
	my $XSL=shift;
	print "Converting document with XSL processor...\n" unless $Mute;

	if ($^O eq "MSWin32+") {
		print "Using MSXML..\n" unless $Mute;
		require Win32::OLE;
		my $xml = new Win32::OLE("MSXML2.DOMDocument.4.0");
		$xml->{async} = 'false';
		$xml->loadXML($XML) or die "XML is incorrect on input";
		
		my $xsl = new Win32::OLE("MSXML2.DOMDocument.4.0");
		$xsl->{async} = 'false';
		$xsl->load($XSL) || die "Unable to load XSL: $XSL";
		return $xml->transformNode($xsl) or die "xsl transform with file $XSL failed";
	} else {
		require XML::LibXSLT;
		require XML::LibXML;
		print "Using XML::LibXSLT..\n" unless $Mute;
	  my $parser = XML::LibXML->new();
	  my $xslt = XML::LibXSLT->new();
	  my $source = $parser->parse_string($XML);
	  my $style_doc = $parser->parse_file($XSL);
	  my $stylesheet = $xslt->parse_stylesheet($style_doc);
	  my $results = $stylesheet->transform($source,'encoding'=>"'1251'");
	  $stylesheet->output_string($results);
	}
}


sub xmlescape {
	my %escapes=(
	  '&'	=> '&amp;',
	  '<'	=> '&lt;',
	  '>'	=> '&gt;',
	  '"'	=> '&quot;',
	  "'"	=> '&apos;'
	);
	$b=shift;
  $_=$b;
  s/([&<>'"])/$escapes{$1}/gs;
  $_;
}



my @Escape = map sprintf("\\uc1\\u%0004u?", $_), 0x00 .. 0xFF;
foreach my $i ( 0x20 .. 0x7E ) {  $Escape[$i] = chr($i) }

{
  my @refinements = (
   "\\" => "\\'5c",
   "{"  => "\\'7b",
   "}"  => "\\'7d",
   
   "\cm"  => '',
   "\cj"  => '',
   "\n"   => " ",
    # This bit of voodoo means that whichever of \cm | \cj isn't synonymous
    #  with \n, is aliased to empty-string, and whichever of them IS "\n",
    #  turns into the "\n\\line ".
   
   "\t"   => "\\tab ",     # Tabs (altho theoretically raw \t's might be okay)
   "\f"   => "\n\\page\n", # Formfeed
   "-"    => "\\_",        # Turn plaintext '-' into a non-breaking hyphen
                           #   I /think/ that's for the best.
   "\xA0" => "\\~",        # \xA0 is Latin-1/Unicode non-breaking space
   "\xAD" => "\\-",        # \xAD is Latin-1/Unicode soft (optional) hyphen
	 '«'		=> '«',
	 '»' 		=> '»',
	 '–'		=> '\endash',
	 '—'		=> '\endash'
  );
#	for ('-','=','!','@','#','$','%','^','&','*','(',')','_','+'){
#		push (@refinements,$_,$_);
#	}
  my($char, $esc);
  while(@refinements) {
    ($char, $esc) = splice @refinements,0,2;
    $Escape[ord $char] = $esc;
  }
}

sub RtfEscape{
	my $In=shift;
  $In=~s/([F\.\x00-\x1F\-\\\{\}\x7F-\xFF])/$Escape[ord$1]/g;  # ESCAPER
	$In=~s/—/–/g;
  $In=~s/([^\x00-\xFFА-Яа-я«»–…ёЁ])/'\\uc1\\u'.((ord($1)<32768)?ord($1):(ord($1)-65536)).'?'/eg;
	return $In;
}

sub CodeImage{
	my $ImageData=shift;
	my $ImgHead="{\\pict";
	$ImgHead.=image_params(\$ImageData);
	my $Data=unpack("H*", $ImageData);
	$ImgHead.=$Data;
	$ImgHead.="}\n";
}

sub image_params {
  my $ImgStream = shift;
  
  my($w,$h, $type) = Image::Size::imgsize( $ImgStream );
  die "Error determining image size  - $type" unless $h and $w;

  my $tag =
      ($type eq 'PNG') ?  '\pngblip'
    : ($type eq 'JPG') ? '\jpegblip'
    : Carp::croak("I can't handle images of type $type");
  ;
  return "$tag\\picw$w\\pich$h\\picwgoal".($w*15)."\\pichgoal".($h*15)."\n";
}

1;
