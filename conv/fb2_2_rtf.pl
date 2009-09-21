#!/usr/bin/perl
BEGIN {
	my $ScriptPath=$0;
	$ScriptPath=~s/[\/\\][^\\\/]+$//;
	push @INC,$ScriptPath if $ScriptPath;
}

use FB2ToTXT;


#=============================================================
if (!$ARGV[2]){print "\nfb2_2_rtf by GribUser v 0.02\nUsage:\n\nfb2_2_rtf.pl <inputfile.fb2> <stylesheet.xsl> <outputfile.rtf> [-options]

  Options available
   -nortf         Plain text output. No rtf-tags, no rtf-coded images
   -enc encoding  Define output file encoding. cp1251 is default
   -mute          Do not print progress messages.
   ";exit 0;}
#=============================================================
my $ResEnc='cp1251';
my $Mute=0;

my $InFile=$ARGV[0];
my $XslFile=$ARGV[1];
my $OutputFile=$ARGV[2];
for (my $I=3;$I<@ARGV;$I++){
	$PlainText=1 if $ARGV[$I] eq '-nortf';
	$Mute=1 if $ARGV[$I] eq '-mute';
	if ($ARGV[$I] eq '-enc'){
		if ($ARGV[$I+1]){
			$ResEnc=$ARGV[$I+1];
		} else {
			print STDERR "Encoding not defined after '-enc' option! Using default '$ResEnc' instead\n";
		}
		$I++;
	}
}

FB2ToTXT::ConvertFb2TXT($InFile,$XslFile,$OutputFile,$PlainText,$ResEnc,$Mute,1);