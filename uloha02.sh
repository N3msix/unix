#!/bin/bash
if [[ "$1" == "--normal" ]]
then
  for i in `seq 1 $#`
  do
    echo "${!i}"
  done
elif [[ "$1" == "--reverse" ]]
then
  for ((i=$#;i>0;i-=1))
  do
    echo ${!i}
  done
elif [[ "$1" == "--subst" ]]
then
  for i in `seq 4 $#`
  do
    echo "${!i}" | sed s/$2/$3/g
  done
elif [[ "$1" == "--len" ]]
then
  for i in `seq 1 $#`
  do
    echo -n $(expr length "${!i}")' '
  done
  echo
elif [[ "$1" == "--help" ]]
then
  echo "help xd"
fi
exit 0
