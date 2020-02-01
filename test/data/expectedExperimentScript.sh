### Inputs
myExe=$inFolder/myExe
input=$inFolder/input.txt

### Params
posParam_arr=($inFolder/paramInput $inFolder/paramInput)
posParam=${posParam_arr[idx]}
keyParam_arr=(abc sadfsadf)
keyParam=${keyParam_arr[idx]}

### Outputs
stdout=$outFolder/stdout.txt
stderr=$outFolder/stderr.txt
posOutput=$outFolder/posOutput.csv
other_out=$outFolder/other_out.csv
out=$outFolder/out.csv

### Task
${myExe} 2 ${posParam} abc ${posOutput}--flag --output2 ${other_out} -p ${keyParam} --otherArg 3 --output1 ${out} -arg1 ${input} > ${stdout} 2> ${stderr}

