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
testPosArgs = [2, "abc", outfileDep]

testKeywordArgs = OrderedDict(
    "-arg1" => infileDep,
    "--otherArg" => 3,
    "--output1" => FilesystemOutput("out.csv"),
    "--output2" => FilesystemOutput("other_out.csv"),
    "--flag" => nothing,
)

# Simple task with no arguments
task = ExeTask(exeDep)
@test length(getinputs(task)) == 1
@test length(getoutputs(task)) == 2
@test getcommand(task) == "myExe  > stdout.txt 2> stderr.txt"

# Task with positional arguments
task = ExeTask(exeDep, testPosArgs)
@test length(getinputs(task)) == 1
@test length(getoutputs(task)) == 3
@test getcommand(task) == "myExe 2 abc posOutput.csv > stdout.txt 2> stderr.txt"

# Task with keywork arguments
task = ExeTask(exeDep, [], testKeywordArgs)
@test length(getinputs(task)) == 2
@test length(getoutputs(task)) == 4
@test getcommand(task) == "myExe -arg1 input.txt --otherArg 3 --output1 out.csv --output2 other_out.csv --flag  > stdout.txt 2> stderr.txt"
