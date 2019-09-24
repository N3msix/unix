#!/bin/bash
if [[ "$1" == "kodyzemi_cz.csv" && "$2" == "countrycodes_en.csv" ]]; then
	CZ=$1
	EN=$2
elif [[ "$1" == "countrycodes_en.csv" && "$2" == "kodyzemi_cz.csv" ]]; then
	CZ="/"$2
	EN="/"$1
fi

join -1"1" -2"4" -t";" <(sort -t";" -k1 $EN) <(sort -t";" -k4 $CZ)