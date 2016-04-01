apt-get install -y php5 libapache2-mod-php5 php5-mysql php5-mcrypt

cat >>/etc/apache2/mods-enabled/dir.conf <<EOF
<IfModule mod_dir.c>
        DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm
</IfModule>
EOF

cat > /var/www/html/info.php <<EOF
<?php
phpinfo();
?>
EOF
service apache2 restart
