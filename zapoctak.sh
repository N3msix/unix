#!/bin/bash

VSOURCE=$(cat /dev/null)
VDESTINATION=$(cat /dev/null)
VPORTRANGE=$(cat /dev/null)

if[ "$1" == "" ];then
#scan all
    tcpdump -n | awk'{split($0,a," "); ;print "Time: "a[1]" Sender: "a[3]" Receiver: "a[5]"  "};'
    #budu resit akorat filtr
    
elif[[ "$1" =~ ^[^-] ]];then
#is host
    tcpdump host $1 | awk'{split($0,a," "); print ""};'
    
    
elif[[ "$1" =~ ^-[pPsSdD]+ ]];then
#port(portrange) | source(src IP) | dest(dst IP)
    if[[ "$1" =~ ^-.*[pP]+.* ]];then
    fi
    if[[ "$1" =~ ^-.*[sS]+.* ]];then
    fi
    if[[ "$1" =~ ^-.*[dD]+.* ]];then
    fi
    
elif[[ "$1" =~ ^-[aA] ]];then
#search subnet
    tcpdump host $1 | awk'{split($0,a," "); print "Time: "a[1]" Sender: "a[3]" Receiver: "a[5]"  "};'
    #v aktualnim subnetu zistime masku a podle ni budeme koukat kdo je na siti online tj ping na vsechny v tom rozsahu
    # ping 192.168.0.1 | grep "bytes from"
    #pozor az druhyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    # awk '{split($0,inputIP,"\."); print a[]}' $2
    ifconfig | grep "netmask" | awk '{split($0,a," ");  print a[2],a[4]}' > /tmp/TMPip
    numberOfLines=$(cat /tmp/TMPip | wc -l)
    while [[ $numberOfLines -ne 1 ]]; do
        cat /tmp/TMPip | 
        numberOfLines=$(cat /tmp/TMPip | wc -l)
    done
    
elif[[ "$1" =~ ^-[hH]|^-[hH][eE][lL][pP] ]]");
    echo "without
    parameter:      automatically starts scaning all trafic"
    echo "addres
      written:      plain addres is considered as a host"
    echo " -p:      one or range \(a\-b), where a,b are numbers"
    echo " -s:      traffic only from this ip addres"
    echo " -d:      traffic only \for this ip addres"
    echo " -a:      display all up IP adresses on LAN"
    echo " -h:      display \help also -help -HELP -H"
fi