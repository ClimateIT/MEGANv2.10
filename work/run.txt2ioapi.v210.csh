#! /bin/csh -f
########################################################################
## Common setups
source /home/monkk/MEGAN_intel/MEGANv2.10/setcase.csh

setenv PRJ NSW 
setenv DOM 3 

setenv PROMPTFLAG N
setenv PROG   txt2ioapi
setenv EXEDIR $MGNEXE
setenv EXEC   $EXEDIR/$PROG
setenv GRIDDESC $MGNRUN/GRIDDESC
setenv GDNAM3D NSW${DOM}km 

## File setups
## Inputs
setenv EFSTXTF $MGNINP/MAP/EF210_${PRJ}${DOM}.csv
setenv PFTTXTF $MGNINP/MAP/PFT210_${PRJ}${DOM}.csv
setenv LAITXTF $MGNINP/MAP/LAI210_${PRJ}${DOM}.csv
## Outputs
setenv EFMAPS  $MGNINP/MAP/EFMAPS.${PRJ}${DOM}.ncf
setenv PFTS16  $MGNINP/MAP/PFTS16.${PRJ}${DOM}.ncf
setenv LAIS46  $MGNINP/MAP/LAIS46.${PRJ}${DOM}.ncf

## Run control
setenv RUN_EFS T       # [T|F]
setenv RUN_LAI T       # [T|F]
setenv RUN_PFT T       # [T|F]
########################################################################





## Run TXT2IOAPI
rm -f $EFMAPS $LAIS46 $PFTS16
if ( ! -e $MGNLOG/$PROG ) mkdir -p $MGNLOG/$PROG
$EXEC | tee $MGNLOG/$PROG/log.run.$PROG.${PRJ}${DOM}.txt
