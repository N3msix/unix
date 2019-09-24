#!/bin/bash
if [[ "$1" == "kodyzemi_cz.csv" && "$2" == "countrycodes_en.csv" ]]; then
	CZ=$1
	EN=$2
elif [[ "$1" == "countrycodes_en.csv" && "$2" == "kodyzemi_cz.csv" ]]; then
	CZ="/"$2
	EN="/"$1
fi

cat $CZ | awk '{split($0,a,";"); print a[1],a[2],a[3]}' > /tmp/CZfileTMP
cat $EN | awk '{split($0,b,";"); print b[4],b[3],b[2]}' > /tmp/ENfileTMP

join <(sort /tmp/CZfileTMP) <(sort /tmp/ENfileTMP) | awk '{split($0,c," "); print c[1]}' > /tmp/EnCzTMP


cat $CZ | awk '{split($0,d,";"); print d[1],d[4]}' > /tmp/CZfileTMP
join <(sort /tmp/CZfileTMP) <(sort /tmp/EnCzTMP) | sed 's/\"//g; s/^[0-9]* //g'

rm -f /tmp/CZfileTMP /tmp/ENfileTMP /tmp/EnCzTMP