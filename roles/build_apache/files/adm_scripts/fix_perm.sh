#!/bin/bash

date=$(date '+%Y-%m-%d %H:%M:%S')
logdate=$(date '+%Y%m%d_%H%M%S')

function log_info() {
	echo $date $1 >> /var/log/adm_scripts/httpd_reload-${logdate}.log
}

# Define the parent directory where to search for directories
PARENT_DIR="/var/www/html"

# Loop through all directories inside the parent directory
for dir in "$PARENT_DIR"/*/; do
    # Check if "public_html" exists inside the directory
    if [ -d "$dir/public_html" ]; then
        echo "Applying permissions to: $dir/public_html"

        # Apply the permission and ownership commands
        chmod -R 775 "$dir/public_html"
        chown -R apache:sftp "$dir/public_html/"
        setfacl -R -m d:g:sftp:rwx "$dir/public_html"
        setfacl -d -m g:apache:rwx "$dir/public_html/"

        log_info "Permissions set for $dir/public_html - OK"
    else
        log_info "Skipping $dir (no public_html found)"
    fi
done
