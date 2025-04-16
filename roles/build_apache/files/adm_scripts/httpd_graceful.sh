#!/bin/bash

date=$(date '+%Y-%m-%d %H:%M:%S')
logdate=$(date '+%Y%m%d_%H%M%S')

function log_info() {
	echo $date $1 >> /var/log/adm_scripts/httpd_reload-${logdate}.log
}

function graceful_apache() {
httpd -t
  if [ $? -eq 0 ]
    then
      apachectl graceful
      log_info "Apache succesfully reloaded"
    else
      log_info "Apache has wrong config, better not reload it"
  fi
}

graceful_apache