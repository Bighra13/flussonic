#!/bin/bash

bold=$(tput bold)
underline=$(tput smul)
italic=$(tput sitm)
info=$(tput setaf 2)
error=$(tput setaf 160)
warn=$(tput setaf 214)
reset=$(tput sgr0)


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

sudo apt install curl &>/dev/null


echo "  "
echo "${warn}${bold}Flussonic-Erlang Downloading...${reset}"
cd Resources
cat libss.deb > /tmp/libss.deb
dpkg -i /tmp/libss.deb &>/dev/null
rm /tmp/libss* &>/dev/null
cd erlang
cat Ubuntu-22.10.deb > /tmp/flussonic-erlang.deb

cd ..
echo "${warn}${bold}Flussonic Downloading...${reset}"
cat flussonic.deb > /tmp/flussonic.deb
echo "${warn}${bold}Flussonic-Transcoder Downloading...${reset}"
cat flussonic-transcoder.deb > /tmp/flussonic-transcoder.deb
echo "${warn}${bold}Flussonic-Transcoder-Base Downloading...${reset}"
cat flussonic-transcoder-base.deb > /tmp/flussonic-transcoder-base.deb
echo "${warn}${bold}Flussonic-QSV Downloading...${reset}"
cat flussonic-qsv.deb > /tmp/flussonic-qsv.deb
echo "${warn}${bold}Flussonic-Python Downloading...${reset}"
cat flussonic-python.deb > /tmp/flussonic-python.deb
echo "${warn}${bold}Flussonic-Deprecated Downloading...${reset}"
cat flussonic-deprecated.deb > /tmp/flussonic-deprecated.deb

echo "  "
echo "${warn}${bold}Uninstalling Previous Versions If any are installed!${reset}"
apt-get purge --auto-remove flussonic flussonic-transcoder flussonic-transcoder-base flussonic-qsv flussonic-python flussonic-deprecated flussonic-erlang flussonic-watcher flussonic-watcher-core -y &>/dev/null 
echo "  "
echo "${warn}${bold}Beginning installation!${reset}"
dpkg -i /tmp/flussonic*.deb &>/dev/null
rm /tmp/flussonic* &>/dev/null
echo "  "


cat > /etc/flussonic/flussonic.conf <<EOF
# Global settings:
http 80;
rtmp 1935;
pulsedb /var/lib/flussonic;
session_log /var/lib/flussonic;
edit_auth bilal mughal;

# DVRs:

# Remote sources:

# Balancer:

# Stream templates:

# Ingest streams:

# Disk file caches:

# VOD locations:

# DVB cards:

# Components:
iptv;
EOF

echo "  "


service flussonic start
echo "  "
echo "${warn}${bold}Installation Complete!${reset}"

ip_address=$(curl -s https://ifconfig.me)
url="http://$ip_address:80"
echo "${warn}${bold}Server URL: $url${reset}"
echo "${warn}${bold}Username: bilal${reset}"
echo "${warn}${bold}Password: mughal{reset}"