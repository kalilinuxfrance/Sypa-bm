#!/bin/bash

######################################
# Sypa-bm.sh v0.4 2016               #
# Send Your Public Adress - By Mail  #
# Script writed by Julien Amrein     #
#                          05-2016   #
######################################

# IMPORTANT: You need to have exim4 configured on the computer where the script runs.

# Change the 192.168.1.1 by any website who can provide your IP if this IP adress fail. 
GET 192.168.1.1 | sed -nre 's/^.* (([0-9]{1,3}\.){3}[0-9]{1,3}).*$/\1/p' > IP.txt

var1=$(grep . -1 ReferenceIP.txt)
var2=$(grep . -1 IP.txt)

echo "adresse de reference:      ${var1}"
echo "adresse actuelle    :      ${var2}"
echo ""


if [ "$var1" = "$var2" ]; then
	
	echo "ETAT                :      Identique" 
	echo ""
# Comment the next line if you do not use graphical server
	notify-send -t 5000 "Sypa-bm.sh: Adresse IP Publique inchangee"

else

	echo "ETAT                :      Different" 
	GET 192.168.1.1 | sed -nre 's/^.* (([0-9]{1,3}\.){3}[0-9]{1,3}).*$/\1/p' > ReferenceIP.txt
	echo "Mise a jour de l adresse ip de reference" 
# Comment the next line if you do not use graphical server
	notify-send -t 5000 "Sypa-bm.sh: Attention changement d adresse IP Publique "
	
# Put your mail adress into the next line
	echo "Nouvelle adresse IP: http://$var2" | mail -s "Nouvelle IP" Your-Mail@gmail.com
	sleep 2
fi


