#!/bin/bash

function wipe_my_ass () {
apt-get remove flussonic\* --purge -y
rm -rf /opt/flussonic
rm -rf /etc/flussonic
rm -rf /var/lib/flussonic
rm -rf /etc/systemd/system/flussonic.service
systemctl daemon-reload
rm -rf /veth*
rm -rf /flussonic*
echo "Done, you ass is clean and smells like flowers. No FLussonics left in the system."
}


#### END INITIAL INSTALLATION FUNCTION
echo "This script will COMPLETELY WIPE YOUR ASS, I mean ANY Flussonic version from this PC without making any backups. Continue?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) wipe_my_ass; break;;
        No ) echo "ABORTED"; exit 1; break;;
    esac
done
