#!/bin/bash
cat > /tmp/TMPmyFile

cat /tmp/TMPmyFile | awk '{split($0,a,":"); print a[4]}' | awk '{n=split($0,b,","); print n}' > /tmp/TMPmyCOUNT
cat /tmp/TMPmyFile | awk '{split($0,a,":"); print a[1]}' > /tmp/TMPmyNAME

paste /tmp/TMPmyCOUNT /tmp/TMPmyNAME > /tmp/TMPmyUNSORTED

sort -n /tmp/TMPmyUNSORTED > /tmp/TMPmyFile

MOSTFREQ=$(tail -n 1 /tmp/TMPmyFile | sed 's/	[A-z]*//g')
cat /tmp/TMPmyFile | grep -w $MOSTFREQ | sed 's/[0-9]*	//g; s@\n@ @g'

rm -f /tmp/TMPmyCOUNT /tmp/TMPmyFile /tmp/TMPmyUNSORTED /tmp/TMPmyNAME