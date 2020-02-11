#!/bin/bash
##############################################
# Tested on Kali 2019.3
# Learn more https://github.com/aryanguenthner
# Hack to Learn and Learn to Hack
# Last Updated 10/29/2019
##############################################
YELLOW='033m'
echo -e "\e[033mKali IP\e[0m"
KALI=hostname -i
echo "Step 1) ivre scan2db somenmapfile.xml"
echo
echo "Step 2) ivre db2view nmap"
echo
echo "Step 3)" http://$KALI:8888"
echo
ivre httpd --bind-address 0.0.0.0 --port 8888
