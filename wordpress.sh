##edit wp_config.php

define('DISABLE_WP_CRON', true);

##enable uniq key for cache
define('WP_CACHE_KEY_SALT', 'oddperience.com');

##edit cronjob

*/5 * * * * wget -q -O - 'https://websiteedit.com/wp-cron.php?doing_wp_cron' >/dev/null 2>&1

#missing redis


##missing imagick
apt install php81rc-pecl-imagick
apt install lsphp81-imagick

##enable JIT for faster php
nano /usr/local/lsws/lsphp81/etc/php/8.1/litespeed/php.ini

opcache.enable=1
; Determines if Zend OPCache is enabled for the CLI version of PHP
opcache.enable_cli=1
opcache.jit_buffer_size=256M
opcache.jit=1235

sudo apt install lsphp81-opcache

## restart server
service lsws restart
##checkiing if it working
/usr/local/lsws/lsphp81/bin/php -i | grep -i JIT