#!/bin/bash
awk 'NR==FNR{arr[$0];next} $0 in arr' $3 <(awk 'NR==FNR{arr[$0];next} $0 in arr' $1 $2)
#v oboch pripadech prvni parametr(tj soubor) nactu do pole a pak proje
#pro vsechny polozky pole prvniho souboru, soubor druhy a stejne radky vypise