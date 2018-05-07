#!/bin/bash
fOldDir=$1
fNewDir=$2
mergedir=$3
#"JSON_Merge"

for line in $( ls ${fOldDir} ); do 
     echo "                                                                                                            " 

     echo "-------------------    >>>>>>    Check if New file has entries to be added   <<<<<<    ---------------------" 
     
     line_of_new_file=`wc -l ${fNewDir}/${line} | awk '{print $1}' `

     echo "Total lines of file : ${fNewDir}/${line} :  ${line_of_new_file}"
     
     if [ ${line_of_new_file} -gt 3 ]; then 
     
        echo "------>>>>>>>>>>> Merge file: ${fOldDir}/${line} with the corresponding files of  ${fNewDir}"
      
        start_del_lines_old=`wc -l ${fOldDir}/${line} | awk '{print $1}' ` 
        endline_old=`expr ${start_del_lines_old} + 1`
        echo "Total lines of file : ${fOldDir}/${line} :  ${endline_old}"
     
        replaceline=`expr ${start_del_lines_old} - 1`
        echo "Line of file : ${fOldDir}/${line} be replaced : ${replaceline}"

        replacelinetype=`sed -n "${replaceline} p" ${fOldDir}/${line}`
      
        echo "Initial Replace line : ${replacelinetype} "

        if [ $replacelinetype == "]" ]; then
          echo "Bad line to replace"
	  replaceline=`expr ${replaceline} - 1`
	  start_del_lines_old=`expr ${start_del_lines_old} - 1`
        fi

        sed "${replaceline} s/}/},/" ${fOldDir}/${line} > ${mergedir}/${line}_tmp
        sed "${start_del_lines_old},${endline_old} d" ${mergedir}/${line}_tmp > ${mergedir}/${line}_tmp1
       

        sed  '1,2d' ${fNewDir}/${line} >  ${mergedir}/${line}_tmp2  

        replacelinetypeFinal=`sed -n "${replaceline} p" ${fOldDir}/${line}`
        echo "Final Replace line : ${replacelinetypeFinal} "
 
        touch ${mergedir}/${line}
     
        cat ${mergedir}/${line}_tmp1 >> ${mergedir}/${line}
        cat ${mergedir}/${line}_tmp2 >> ${mergedir}/${line}

        rm ${mergedir}/${line}_tmp
        rm ${mergedir}/${line}_tmp1
        rm ${mergedir}/${line}_tmp2
     else 
      
        echo "------>>>>>>>>>>> Leave Old File ${fOldDir}/${line}"
        touch ${mergedir}/${line}
        cat ${fOldDir}/${line} >> ${mergedir}/${line}

     fi	
done

