### Setup temporary files and directories
dir = mktempdir()

exePath = joinpath(dir, "someExe")
close(open(exePath, "w"))

filePath = joinpath(dir, "someInputFile.txt")
close(open(filePath, "w"))

### Run tests
exeDep = FilesystemInput("myExe", exePath)
infileDep = FilesystemInput("input.txt", filePath)

outfileDep = FilesystemOutput("posOutput.csv")
testPosArgs = [2, Param("posParam"), "abc", outfileDep]

testKeywordArgs = OrderedDict(
    "-arg1" => infileDep,
    "--otherArg" => 3,
    "--output1" => FilesystemOutput("out.csv"),
    "--output2" => FilesystemOutput("other_out.csv"),
    "--flag" => nothing,
    "-p" => Param("keyParam")
)

# Simple task with no arguments
task = ExeTask(exeDep)
@test length(getinputs(task)) == 1
@test length(getparams(task)) == 0
@test length(getoutputs(task)) == 2
@test getcommand(task) == "\${myExe}  > \${stdout} 2> \${stderr}"

# Task with positional arguments
task = ExeTask(exeDep, testPosArgs)
@test length(getinputs(task)) == 1
@test length(getparams(task)) == 1
@test length(getoutputs(task)) == 3
@test getcommand(task) == "\${myExe} 2 \${posParam} abc \${posOutput} > \${stdout} 2> \${stderr}"

# Task with keyword arguments
task = ExeTask(exeDep, [], testKeywordArgs)
@test length(getinputs(task)) == 2
@test length(getparams(task)) == 1
@test length(getoutputs(task)) == 4
@test getcommand(task) == "\${myExe} -arg1 \${input} --otherArg 3 --output1 \${out} --output2 \${other_out} --flag -p \${keyParam} > \${stdout} 2> \${stderr}"
