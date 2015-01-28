#!/bin/bash

ulimit -SHn 102400
/data/app/nginx/sbin/nginx
/data/app/php/sbin/php-fpm
