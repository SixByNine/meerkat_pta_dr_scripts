#!/bin/sh

root=$(dirname $0)

$root/flag_partim.sh initial.par initial.tim


echo "LOGIC -snr < 10 REJECT" > initial.select


echo ""
echo "Now RUN:"
echo "tempo2 -gr plk -f initial_flag.par initial_flag.tim -select initial.select"
echo ""
echo "write out 'clean.par' and 'clean.tim' when happy"
