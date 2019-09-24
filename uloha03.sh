#!/bin/bash
if [ $# == 3 ] && ! ([ "$1" == "-f" ] || [ "$1" == "-fraction" ]); then
	cat $3 > /tmp/TMP
elif [ $# == 4 ]; then
	cat $4 > /tmp/TMP
else
	cat > /tmp/TMP
fi

VARA=$(echo $2 | sed 's@[-/][0-9]\+@@')  
VARB=$(echo $2 | sed 's@[0-9]\+[-/]@@') 
NUMOFLINES=$(wc -l < /tmp/TMP)

if [ "$1" == "-l" ] || [ "$1" == "-lines" ]; then
	cat /tmp/TMP | awk "NR==$VARA, NR==$VARB"
	echo toto je $VARA $VARB
elif [ "$1" == "-f" ] || [ "$1" == "-fraction" ]; then
	VARC=$(echo $3 | sed 's@[-/][0-9]\+@@')  
	VARD=$(echo $3 | sed 's@[0-9]\+[-/]@@')
	VARBEGIN=$((NUMOFLINES * VARA / VARB))
	VARTMP=$((NUMOFLINES * VARC / VARD))
	VAREND=$(echo $VARTMP | awk '{print int($1+0.5)}')
	head -n $VAREND /tmp/TMP | tail -n $VARBEGIN
elif [ "$1" == "-p" ] || [ "$1" == "-part" ]; then
	VARTMP=$((NUMOFLINES / VARB))
	VAREND=$((VARTMP * VARA))
	VARTMP=$((0 - VARTMP + 1))
  	for TMP in $(seq ${VARTMP} 0); do
  		PADDING=$((VAREND + TMP))
  		sed -n ${PADDING}p /tmp/TMP
  	done
fi

rm -f /tmp/TMP