#!/bin/bash

# Script is used to set the Nameserver Lookup under Max OS X 10.4 with the Console
# Script by Stephan Oeste <stephan@oeste.de>

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

