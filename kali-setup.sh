#!/bin/bash
################################################
# Kali Post Setup Automation Script
# Tested on Kali 2020.1
# If you're reading this pat yourself on the back
# sudo -i Then dos2unix kali-setup.sh
# Make this file executable, chmod +x kali-setup.sh 
# Usage type: sudo kali-setup.sh | tee kalisetuplog.txt
# Learn more at https://github.com/aryanguenthner/
# Last Updated 02/10/2020
################################################
#python-krb python-mysqldb <-- Do we need these?

echo "Did you update your Kali before running this script?"

date | tee kali-install-startdate.txt
# Because We like SSH
echo "Enabling SSH"
sed -i '32s/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl enable ssh
service ssh restart
echo
echo "Kali IP Address"
hostname -I
echo
echo '# Kali IP' >> /root/.bashrc
echo 'hostname -I' >> /root/.bashrc
echo
echo "Attempting to Disable IPv6"
echo 'net.ipv6.conf.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.eth0.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.wlan0.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.wlan1.disable_ipv6 = 1' >> /etc/sysctl.conf
sysctl -p -f /etc/sysctl.conf
echo
echo "Be Patient, Installing Kali Dependencies"
apt -y install gedit cupp nautilus websploit build-essential cifs-utils cmake curl ffmpeg gimp git graphviz imagemagick libapache2-mod-php php-xml libappindicator3-1 libindicator3-7 libmbim-utils libreoffice nfs-common openssl phantomjs python3-dev python3-pip python-dbus python-lxml python-pil python-psycopg2 python-pygraphviz terminator tesseract-ocr vlc wkhtmltopdf xsltproc xutils-dev xvfb gplaycli
echo
echo "Getting Vulsec & Vulners to make Nmap Do cool things"
cd /usr/share/nmap/scripts/
git clone https://github.com/vulnersCom/nmap-vulners.git
git clone https://github.com/scipag/vulscan.git
cd vulscan/utilities/updater/
chmod +x updateFiles.sh
./updateFiles.sh
echo
# Yeat
echo "Fixing setoolkit"
# Fix Social Engineer Toolkit
# Remove old files
rm -R /usr/share/set
# Get the lastest files
git clone https://github.com/trustedsec/social-engineer-toolkit.git
# Rename
mv social-engineer-toolkit set
# Move the new files back to the correct path
mv set /usr/share
#Edit line 144 to enable hotkey to Show Desktop
#/home/kali/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
#      <property name="&lt;Super&gt;d" type="string" value="show_desktop_key"/>
echo
echo "Metasploit Ready Up"
msfdb init
echo
echo
# Get Pip
cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
echo
echo "Upgrading pip"
python -m pip install --upgrade pip
echo
echo "AWS CLI"
pip install awscli
echo
echo "Slurp AWS"

echo "metagoofil"
apt -y install metagoofil
echo
echo "Setting up Knock - Subdomain Finder"
sudo apt-get install python-dnspython
git clone https://github.com/guelfoweb/knock.git
cd knock
#nano knockpy/config.json <- set your virustotal API_KEY
sudo python setup.py install
echo "EyeWitness"
cd /opt
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness/setup
./setup.sh
echo
echo
cd /opt
echo "Installing RAWR"
git clone https://bitbucket.org/al14s/rawr.git
cd rawr
yes | ./install.sh
echo
echo
# Save these two for later
# git clone https://github.com/jschicht/RawCopy.git
# cd /opt/
# git clone https://github.com/khr0x40sh/MacroShop.git
echo
echo
cd /opt
git clone https://github.com/citronneur/rdpy.git
cd rdpy
python setup.py install
echo "Installing Cewl"
echo
cd /opt
git clone https://github.com/digininja/CeWL.git
gem install mime-types
gem install mini_exiftool
gem install rubyzip
gem install spider
echo
echo "This is going to take a minute hold my beer"
echo
echo "Userrecon"
cd /opt
git clone https://github.com/thelinuxchoice/userrecon.git
echo
echo "Daniel Miessler Security List Collection"
cd /opt
git clone https://github.com/danielmiessler/SecLists.git
echo
danielmiessler/SecLists
cd /opt
git clone https://github.com/meirwah/awesome-incident-response.git
echo
echo "Fuzzdb you say?"
cd /opt
git clone https://github.com/fuzzdb-project/fuzzdb.git
echo
echo "Payloads All The Things"
cd /opt
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
echo
echo "Awesome XSS"
cd /opt
git clone https://github.com/s0md3v/AwesomeXSS.git
echo
echo "Foospidy Payloads"
cd /opt
git clone https://github.com/foospidy/payloads.git
echo
echo "Java Deserialization Exploitation (jexboss)"
cd /opt
git clone https://github.com/joaomatosf/jexboss.git
echo
echo "Lee Baird Discover Script"
cd /opt
git clone https://github.com/leebaird/discover.git
echo
echo "theHarvester"
cd /opt
git clone https://github.com/laramies/theHarvester.git
echo
echo "OWASP Cheat Sheet"
cd /opt
git clone https://github.com/OWASP/CheatSheetSeries.git
echo
echo "Pulse VPN Exploit"
cd /opt
git clone https://github.com/projectzeroindia/CVE-2019-11510.git
echo
echo "hruffleHog - Git Enumeration"
cd /opt
git clone https://github.com/dxa4481/truffleHog.git
echo
echo "Git Secrets"
cd /opt
git clone https://github.com/awslabs/git-secrets.git
echo
echo "Git Leaks"
cd /opt
git clone https://github.com/zricethezav/gitleaks.git
echo
echo "Discover Admin Loging Pages - Breacher"
cd /opt
git clone https://github.com/s0md3v/Breacher.git
echo
echo "Web SSH (Pretty Cool)"
cd /opt
git clone https://github.com/huashengdun/webssh.git
echo
echo "Installing Impacket"
cd /opt
git clone https://github.com/SecureAuthCorp/impacket.git
cd /opt
cd impacket
python setup.py install
echo
echo "Installing Veil, This Takes it's Sweet Time"
cd /opt
git clone https://github.com/Veil-Framework/Veil.git
cd Veil/config
./setup.sh -s
echo
cd /home/kali/Desktop
chmod -R 777 /home/kali/
updatedb
echo "Don't Blink"
echo
echo "Hacker Lives Matter"
reboot