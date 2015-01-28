#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

retval=`ping -c 3 mycheckweb.act.qq.com | awk '/received/ {print $4}'`
[[ ${retval} -eq 0 ]] && exit 1

retval=`curl -I -s "http://checkngx.bieshan-health.com" | grep "200 OK"`
if [[ "${retval}x" = "x" ]]; then
    [[ -e /data/app/nginx ]] && /sbin/service nginx restart >/dev/null 2>&1
fi
