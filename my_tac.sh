#!/bin/bash
cat > /tmp/TMP
if [ "$1" == "-n" ]; then
	NUMOLINES=$(cat /tmp/TMP | wc -l )
	VARA=$((NUMOLINES % $2))
	VARB=$((NUMOLINES / $2))
	for TMP in $(seq 1 $VARB); do
		NUMOLINES=$(cat /tmp/TMP | wc -l )
		VARC=$((NUMOLINES - $2))
		tail -n $2 /tmp/TMP
		head -n $VARC /tmp/TMP > /tmp/TMP1
		mv /tmp/TMP1 /tmp/TMP
	done
	if [[ "$VARA" != 0 ]]; then
		tail -n $VARA /tmp/TMP
	fi
else
	tac /tmp/TMP
fi
rm -f /tmp/TMP