#!/bin/sh

root=$(dirname $0)

pat -A FDM -C chan -C snr -f "tempo2 IPTA" -s clean.std $(cat files.cln) > check.tim
$root/flag_partim.sh clean.par check.tim
mv clean_flag.par check_flag.par


echo ""
echo "Now RUN:"
echo "tempo2 -gr plk -f check_flag.par check_flag.tim"
echo ""
echo "write out 'final.par' when ready"
