#!/bin/bash

tim=clean.tim


declare -A zaps
declare -A good
while read line ; do

    set -- $line
    if [[ $# -lt 5 ]] ; then
        continue ## strip e.g. MODE or FORMAT 
    fi
    if [[ $1 == "C" ]] ; then
        chan=$(echo $line | sed -e 's:.*-chan \([0-9][0-9]*\):\1:' | awk '{print $1}')
        file=$(echo $line | awk '{print $2}')
        zaps[$file]="${zaps[$file]} $chan"
    else
        chan=$(echo $line | sed -e 's:.*-chan \([0-9][0-9]*\):\1:' | awk '{print $1}')
        file=$(echo $line | awk '{print $1}')
        good[$file]="${good[$file]} $chan"
    fi

done < $tim

if [[ -e files.cln ]] ; then rm files.cln ; fi

for file in "${!good[@]}" ; do
    ## There was a good data in this file
    if [[ -z "${zaps[$file]}" ]] ; then
        ## There are no channels to zap
        echo "paz -e cln $file"
    else
        ## We should zap some channels
        echo "paz -e cln -z \"${zaps[$file]}\" $file"
    fi
    echo ${file%.ar}.cln >> files.cln
done > paz.cmd

. paz.cmd

