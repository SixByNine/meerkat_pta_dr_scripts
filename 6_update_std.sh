#!/bin/bash


echo "psradd..."
psradd -o clean.add.ar $(cat files.cln) 
echo "scrunch"
pam -e T -T clean.add.ar
pam -e FT -T clean.add.T

echo "psrsmooth"
psrsmooth -W clean.add.T -e std
mv clean.add.T.std clean.std

