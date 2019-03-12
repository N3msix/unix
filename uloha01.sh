#!/bin/bash

if [ "$1" == "--typ" ]; then
	if [ -f "$2" ]; then
		echo "soubor"
	fi
	if [ -d "$2" ]; then
		echo "adresar"
	fi
	if [ -L "$2" -o -h "$2" ]; then
		echo "symbolicky link"
	fi
	if [ -c "$2" ]; then
		echo "znakove zarazeni"
	fi
	if [ -b "$2" ]; then
		echo "blokove zarazeni"
	fi
	if [ -S "$2" ]; then
		echo "soket"
	fi
	if [ -p "$2" ]; then
		echo "fifo"
	fi
elif [ "$1" == "--help" ]; then
	echo "Pouziti: uloha01.sh [--typ|--help] [cesta_k_souboru]"
	echo "	--typ		popis..."
	echo "	--help		popis..."
	echo
	echo "Exit status:"
	echo "	0 ..."
	echo "	1 ..."
else
	echo "Chyba"
fi
