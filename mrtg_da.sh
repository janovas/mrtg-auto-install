#!/bin/sh

SV="http://www.gots3.com/mrtg";
echo "Install snmpd and mrtg"
yum -y install net-snmp net-snmp-utils mrtg

echo "Making Config Files"
wget -O /etc/snmp/snmpd.conf $SV/snmpd.conf
wget -O /etc/mrtg/mrtg.cfg $SV/mrtg-oid.cfg
wget -O /etc/cron.d/mrtg $SV/mrtg.cron
mkdir -p /var/www/html/mrtg
indexmaker --columns=2 --output=/var/www/html/mrtg/index.html /etc/mrtg/mrtg.cfg

echo "Loading snmpd"
chkconfig --level 2345 snmpd on
/etc/init.d/snmpd restart
snmpwalk -v1 -csnmp 127.0.0.1 > /root/snmpwalk.txt

echo "All Done."
echo "Visit mrtg page at http://your.server.ip/mrtg"
