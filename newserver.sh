# wget -qO- http://clayfreeman.com/newserver.sh | sh

if [ -n "cat /etc/apt/sources.list | grep us.archive.ubuntu.com" ]; then
        sed -i 's/us.archive.ubuntu.com\/ubuntu/mirrors.gigenet.com\/ubuntuarchive/g' /etc/apt/sources.list
fi

apt-get update
apt-get upgrade -y
apt-get install -y apache2-mpm-event asciidoc autoconf automake autopoint autotools-dev bison build-essential ca-certificates cmake cmake-data coreutils ffmpeg gettext git grep guile-2.0-dev gzip host hostname htop inotify-tools lame libapache2-mod-fcgid libapache2-mod-vhost-hash-alias libapache2-mod-xsendfile libaspell-dev libav-tools libcurl4-gnutls-dev libgcrypt11-dev libgnutls-dev liblua5.1-0-dev libncurses5-dev libncursesw5-dev libperl-dev libssl-dev libtool lynx m4 make makedev mysql-server nano ncurses-base ncurses-bin net-tools nginx openssh-server openssl parted php-gettext php5 php5-cgi php5-cli php5-common php5-curl php5-gd php5-mcrypt php5-mysql php5-sqlite phpmyadmin pkg-config python-dev python3-dev rar rsync ruby1.9.1-dev screen sendmail sendmail-bin source-highlight sudo tar tcl-dev telnet ubuntu-restricted-extras unrar unzip wget zip zlib1g-dev zlibc
apt-get remove -y vim vim-common vim-runtime vim-tiny

if [ -z "`cat ~/.bashrc | grep 'export EDITOR=nano'`" ]; then
	echo 'export EDITOR=nano' >> ~/.bashrc
fi

wget -O /etc/apache2/conf.d/php-fastcgi http://clayfreeman.com/conf/php-fastcgi

rm /etc/apache2/sites-available/default && wget -O /etc/apache2/sites-available/default http://clayfreeman.com/conf/apache-default
rm /etc/apache2/ports.conf && wget -O /etc/apache2/ports.conf http://clayfreeman.com/conf/ports.conf
rm /etc/apache2/conf.d/phpmyadmin.conf && wget -O /etc/apache2/conf.d/phpmyadmin.conf http://clayfreeman.com/conf/phpmyadmin.conf
rm /etc/nginx/sites-available/default && wget -O /etc/nginx/sites-available/default http://clayfreeman.com/conf/nginx-default
rm /etc/php5/cgi/php.ini && wget -O /etc/php5/cgi/php.ini http://clayfreeman.com/conf/php.ini

a2enmod rewrite
a2enmod vhost_alias
a2enmod vhost_hash_alias
service apache2 restart
service nginx restart

if [ -f /usr/local/bin/weechat-curses ]; then
	echo -n "WeeChat already installed.\n"
else
        read -p "Do you wish to install weechat-curses? " yn
        case $yn in
                [Yy]* ) wget -O ~/weechat.tar http://www.weechat.org/files/src/weechat-0.4.1.tar.gz && cd && tar xvf weechat.tar && cd ~/weechat* && ./autogen.sh && ./configure && make && make install && rm -rf ~/weechat* && echo -n "WeeChat has been installed.\n"; break;;
                [Nn]* ) break;;
		* ) break;;
        esac
fi
