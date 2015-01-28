#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin

## the nginx access logs base path
WEBLOG_PATH="/data/app/nginx/logs/"

retval=`ps aux | grep ngin[x] | wc -l`
if [ ${retval} -eq 0 ]; then
    echo "The daemon process for nginx has no found."
    exit 1
fi

## cut nginx access logs
for LOGFILE in `find ${WEBLOG_PATH} -type f -name access.log`
do
    LOGPATH=`dirname ${LOGFILE}`
    mv ${LOGPATH}/access.log ${LOGPATH}/access_$(date -d "yesterday" +"%Y-%m-%d").log
done

## reload nginx
/data/app/nginx/sbin/nginx -s reload

## clear 10 days ago's nginx access logs
LOGFILE=access_$(date -d "10 days ago" +"%Y-%m-%d").log
find ${WEBLOG_PATH} -type f -name ${LOGFILE} -exec rm -f {} \;
