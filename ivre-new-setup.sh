#!/bin/bash
################################################
# IVRE Install Script
# Tested on Kali 2019.3 x64
# If you're reading this pat yourself on the back
# Then do this dos2unix ivre-new-setup.sh
# Make this file executable, chmod +x ivre-new-setup.sh 
# Usage: ./ivre-new-setup.sh
# Learn more at https://github.com/aryanguenthner/
# Last Updated 10/29/2019
################################################
echo
date | tee ivre-setup-startdate.txt
echo "Installing MongoDB 4.2 from Ubuntu Repo, Because It Works"
echo
cd /tmp
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get -y update
apt-get -y install mongodb-org
service mongod start
systemctl enable mongod.service
echo
echo "Hopefully MongoDB Installed without any issues"
echo
cd /tmp
echo
echo "Installing IVRE"
echo
echo "Be Patient, Not a lot of output on this portion of the install"
echo
date
apt-get -y install python-pymongo python-crypto \
> python-future python-bottle apache2 libapache2-mod-wsgi dokuwiki
# Installing the Latest version of IVRE from Github
echo
echo "Git Clone IVRE to /opt"
echo
cd /opt
git clone https://github.com/cea-sec/ivre.git
cd ivre
python setup.py build
python setup.py install
echo
echo "IVRE Setup In Progress"
echo
cd /var/www/html ## or depending on your version /var/www
rm index.html
sed -i -e 's/html/dokuwiki/g' /etc/apache2/sites-enabled/000-default.conf
sed -i -e '172s/None/All/g' /etc/apache2/apache2.conf
ln -s /usr/local/share/ivre/web/static/* .
cd /var/lib/dokuwiki/data/pages
ln -s /usr/local/share/ivre/dokuwiki/doc
cd /var/lib/dokuwiki/data/media
ln -s /usr/local/share/ivre/dokuwiki/media/logo.png
ln -s /usr/local/share/ivre/dokuwiki/media/doc
cd /usr/share/dokuwiki
echo
echo "Patching Dokuwiki"
echo
patch -p0 < /usr/local/share/ivre/dokuwiki/backlinks.patch
cd /etc/apache2/mods-enabled
for m in rewrite.load wsgi.conf wsgi.load; do
> '[ -L $m ]' || ln -s ../mods-available/$m; done
cd ../
echo 'Alias /cgi "/usr/local/share/ivre/web/wsgi/app.wsgi"' > conf-enabled/ivre.conf
echo '<Location /cgi>' >> conf-enabled/ivre.conf
echo 'SetHandler wsgi-script' >> conf-enabled/ivre.conf
echo 'Options +ExecCGI' >> conf-enabled/ivre.conf
echo 'Require all granted' >> conf-enabled/ivre.conf
echo '</Location>' >> conf-enabled/ivre.conf
rm /etc/dokuwiki/apache.conf
cp /etc/apache2/apache2.conf /etc/dokuwiki/
sed -i 's/^\(\s*\)#Rewrite/\1Rewrite/' /etc/dokuwiki/apache2.conf
echo 'WEB_GET_NOTEPAD_PAGES = "localdokuwiki"' >> /etc/ivre.conf
service apache2 start
echo
echo "Copying IVRE Nmap Scripts to Nmap"
echo
cp /usr/local/share/ivre/nmap_scripts/*.nse /usr/share/nmap/scripts/
# TODO: Get confirmation this rtsp script is working or not
#patch /usr/share/nmap/scripts/rtsp-url-brute.nse \
#> /usr/local/share/ivre/nmap_scripts/patches/rtsp-url-brute.patch
nmap --script-updatedb
echo "Downloading Neo4j to tmp"
cd /tmp
echo "Installing Neo4j"
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | tee -a /etc/apt/sources.list.d/neo4j.list
apt-get -y update
apt-get install -y neo4j
systemctl enable neo4j
echo
echo
echo "Get Pippy With It"
cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
echo
cd ~/Desktop/
echo "Installing Some IVRE Dependencies"
echo
pip install Crypto
pip install pymongo
pip install py2neo
pip install sqlalchemy
pip install matplotlib
pip install bottle
echo
echo "Now Starting The Database init, data download & importation"
date
echo "These last steps may take a long time to run (40 minutes on a decent server), nothing to worry about."
echo
yes | ivre ipinfo --init
yes | ivre scancli --init
yes | ivre view --init
yes | ivre flowcli --init
ivre ipdata --download --import-all
updatedb
echo "Just About There"
echo
echo
echo "You Will Need To Import Nmap Files To Get Started"
echo
echo "Import nmap.xml files like this: ivre scan2db nmapscan.xml"
echo
date | tee ivre-setup-finishdate.txt
echo "After Importing do this: ivre db2view nmap"
#Open a web browser and visit http://localhost:8888/
#IVRE Web UI should show up, with no result of course
#Click the HELP button to check if everything works
#Database init, data download & importation
# Time to start using IVRE: Bind localhost to -p8888
# When the Web Interface for IVRE Opens you're ready!
echo "Open http://localhost:8888"
echo
echo "Read the IVRE Docs"
ivre httpd --bind-address 0.0.0.0 --port 8888
firefox http://localhost:8888


