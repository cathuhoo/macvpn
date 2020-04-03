#!/bin/bash

# This script is used to set the nameservers for all interfaces of Mac OS
$ Author: Haixin Duan

#Usage: ./setalldns.sh  [IP_address_of_nameserver ]
#If no argument is given, 127.0.0.1 will be used.


nameserver=$1
if [ "$nameserver"  == ""  ] ; then
	nameserver=127.0.0.1
fi

timestamp=`date +%Y%m%d%H%M`
tmp=/tmp/setall-dns-psid-$timestamp.tmp

echo list ".*DNS" | scutil |grep "State:/Network/Service/"| awk '{print $4}' |cut -d'/' -f4> $tmp

while IFS= read -r PSID
do
    echo "Key:$line, $nameserver"
    scutil <<____EOF
	open
	d.init
	d.add ServerAddresses * $nameserver
	set State:/Network/Service/$PSID/DNS
	get State:/Network/Service/$PSID/DNS
	d.show
	quit
____EOF
done < $tmp

rm $tmp

