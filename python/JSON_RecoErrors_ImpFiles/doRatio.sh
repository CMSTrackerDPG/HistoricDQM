#!/bin/bash
dir="/afs/cern.ch/user/c/cctrack/scratch0/hDQM/CMSSW_8_0_2/src/DQM/SiStripHistoricInfoClient/test/NewHDQM/JSON_RECO"
file=$dir"/ratioRECOErrors.ini"
while IFS=' | ' read -r f1 f2
do
        # display fields using f1, f2,..,f7
    [[ $f1 = \#* ]] && continue
    printf 'Numerator: %s, Denominator: %s\n' "$f1" "$f2"
    outname="${f1%_*}_ratio"
    outtitle=${outname//_/ }
#    echo $in1 $in2 $outname $outtitle
    python $dir/MakeRatioJSON_RECOErrors.py -s $1 -n $f1 -d $f2 -f $outname -t "$outtitle"
done <"$file"