#!/bin/bash

dm=$(grep "^DM " clean.par | awk '{print $2}')
pam -d $dm -m -E clean.par $(cat files.cln)


