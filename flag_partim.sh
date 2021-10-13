#!/bin/bash

parname=$1
timname=$2

timhead=${timname%.tim}
#`echo $timname | awk -F .tim '{print $1}'`
par=${parname%.par}
# `echo $parname | awk -F .par '{print $1}'`

# 1K mode, PTM not applied by PTUSE [PTM value -24.629 us]
awk  '{if ($3 > 58526.21089) print $0, "-MJD_58526.21089_1K -1"; else print $0 }' $timname > tmp.tim

# 1K mode PTM applied by PTUSE [PTM value -24.630]
awk '{if ($3 > 58550.14921) print $0, "-MJD_58550.14921_1K -1"; else print $0 }' tmp.tim > tmp2.tim
mv tmp2.tim tmp.tim

# 1K mode, AJ added 1 sample [1.196 us] delay to PTUSE
awk  '{if ($3 > 58550.14921) print $0, "-MJD_58550.14921B_1K -1"; else print $0 }' tmp.tim > tmp2.tim
mv tmp2.tim tmp.tim

# 1K mode, PTM sensor changed from -24 to -19 us [4.785 us]
awk '{if ($3> 58557.14847) print $0, "-MJD_58557.14847_1K -1"; else print $0 }' tmp.tim > tmp2.tim
mv tmp2.tim tmp.tim

# 1K mode, AJ changed from 1 sample delay, to 0.5 sample delay in PTUSE
awk '{if ($3 > 58575.95951) print $0, "-MJD_58575.9591_1K -1"; else print $0}' tmp.tim > tmp2.tim
mv tmp2.tim tmp.tim


#  306 microsec offset in CBF
awk '{if (($3 > 58550) && ($3 < 58690)) print $0, "-MJD_58550_58690_1K -1"; else print $0}' tmp.tim > tmp2.tim
mv tmp2.tim tmp.tim

#mv tmp.tim ${timhead}_flag.tim
awk '{if ( ($3  < 59378.46) || ($3 > 59387.1) || (($3 > 59386.8) && ($3 < 59386.9)))   print $0} ' < tmp.tim > ${timhead}_flag.tim

#Flags to add to parfile:

grep -ve 'JUMP\|CLK' ${par}.par  > ${par}_flag.par
echo "CLK TT(BIPM2019)" >> ${par}_flag.par
echo "SATJUMP -MJD_58550_58690_1K -1 -0.000306243 0" >> ${par}_flag.par
echo "SATJUMP -MJD_58526.21089_1K -1 -2.4628e-05 0" >> ${par}_flag.par
echo "SATJUMP -MJD_58550.14921_1K -1 2.463e-05 0" >> ${par}_flag.par
echo "SATJUMP -MJD_58550.14921B_1K -1 -1.196e-06 0" >> ${par}_flag.par
echo "SATJUMP -MJD_58557.14847_1K -1 -4.785e-06 0" >> ${par}_flag.par
echo "SATJUMP -MJD_58575.9591_1K -1 5.981308411e-07 0" >> ${par}_flag.par


cat ${par}_flag.par
