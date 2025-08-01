#!/bin/sh
clear
read -p "This script installs ZoneMinder 1.36.x on Debian 12 with LAMP (MySQL or Mariadb) installed...
This script must be run as root!
Press Enter to continue or Ctrl + c to quit" nothing
clear
apt install -y lsb-release gnupg2
echo "deb https://zmrepo.zoneminder.com/debian/release-1.36 "`lsb_release  -c -s`"/" | sudo tee /etc/apt/sources.list.d/zoneminder.list
# The key is stored in the deprecated keyring trusted.gpg.
# wget -O - https://zmrepo.zoneminder.com/debian/archive-keyring.gpg | sudo apt-key add -
wget -O- https://zmrepo.zoneminder.com/debian/archive-keyring.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/zmrepo.gpg
read -p "Warning! Check above to insure the line says OK. If not the GPG signing key was not installed and you will need to figure out why before continuing. 
Press enter to continue" nothing
apt update
clear
apt install zoneminder --install-recommends -y
systemctl enable zoneminder
service zoneminder start
adduser www-data video
a2enconf zoneminder
a2enmod rewrite
a2enmod headers
a2enmod expires
service apache2 reload
clear
read -p "Install complete. Open Zoneminder/Options and set the timezone. Press enter to continue" nothing
clear