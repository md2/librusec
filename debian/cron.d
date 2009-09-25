#
# Regular cron jobs for the librusec package
#
0 4	* * *	www-data	find /usr/share/drupal6/cache/ -type f -mtime +1 -delete

