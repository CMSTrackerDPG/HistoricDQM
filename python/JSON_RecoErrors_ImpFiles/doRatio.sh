#!/bin/bash
dir="/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python/JSON_RECO"
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