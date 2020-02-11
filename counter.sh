#!/bin/bash
################################################
# Tested on Kali 2019.3
# Here is the order of operation to successfully use this script
# Step 1) dos2unix *.sh
# Step 2) chmod +x *.sh
# Use the nmap-parser.py before using this script
# Counter Usage: ./counter.sh
# Learn more at https://github.com/aryanguenthner/
# Last Updated 10/06/2019
################################################
echo
echo "Discover How Many Products Are In Your Environment"
echo
# If you used the nmap-parser.py you will have a file named results.csv
echo
# Getting The Results Ready
cat results.csv | grep -v tcpwrapped > cleaned.txt &&
cat cleaned.txt | sort  > file.txt &&
cat file.txt | sort -n | uniq -c > counted.txt &&
cat counted.txt | sed 's/Host is up//g; s/open//g; s/syn-ack//g' > tally.csv &&
cat tally.txt | tr --delete '()' > total.txt
echo
# Print Out The Top Results
echo -e "Occurances"
echo -e "Port Number  	   Protocol     Service Version"

# Saving results to a file
cat total.csv | sort -n

echo "Saving to tally.csv"
# The Best College Football Team Ever
# echo "Go Ducks!"
