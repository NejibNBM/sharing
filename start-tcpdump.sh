#!/bin/bash
################################################
# Tested on Kali 2019.3
# This Is The First Thing I Do On Any Penetration Test Engagement 
# Do This: dos2unix *.sh then chmod +x *.sh
# Usage: ./tcpdump.sh
# Learn more at https://github.com/aryanguenthner
# Last Updated 2019-10-15
################################################
echo
echo "I recommend putting this script in screen"
echo
echo "If you don't want to use screen that's fine"
echo
echo "Optional: Exit this script, use screen then run: ./tcpdump.sh"
# Nice Interactive way to do Packet Captures
echo
echo "Nice Packet Captures!"
echo
echo -n "Specify Interface, Example eth0: "
read interface
echo -n "Specify Full Path of Output Directory: "
read directory
echo -n "Specify Output Name for Results: "
read name
echo
echo "Be Patient"
echo
tcpdump -i $interface -s 0 -n -vv -C 500 -z bzip2 -w $directory$name.pcap -Z root
echo
echo "tcpdump is running" 
echo
echo
# Oregon Ducks Are The Best Team Ever!
echo
echo "Go Ducks!"
