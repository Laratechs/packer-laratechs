#! /bin/bash

(crontab -l 2>/dev/null; echo "0 * * * * /etc/minecraft/generate_backup.sh") | crontab -
