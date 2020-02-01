exeDep = InputDependency("myExe", "mockExePath")
infileDep = InputDependency("input.txt", "mockFilePath")

outfileDep = OutputDependency("posOutput.csv")
testPosArgs = [2, Param("posParam"), "abc", outfileDep]

testKeywordArgs = Dict(
    "-arg1" => infileDep,
    "--otherArg" => 3,
    "--output1" => OutputDependency("out.csv"),
    "--output2" => OutputDependency("other_out.csv"),
    "--flag" => nothing,
    "-p" => Param("keyParam")
)

task = ExeTask(exeDep, testPosArgs, testKeywordArgs)
exp = Experiment(task)

# Good run additions
params = Dict(
    "posParam" => InputDependency("paramInput", "more_input1.csv"),
    "keyParam" => "abc"
)
addrun!(exp, params)

otherParams = Dict(
    "keyParam" => "sadfsadf",
    "posParam" => InputDependency("paramInput", "more_input2.csv")
)
addrun!(exp, otherParams)

# Bad run additions
@test_throws ArgumentError addrun!(exp, Dict())
@test_throws ArgumentError addrun!(exp, Dict("keyParam" => "a", "fakeParam" => 555))
@test_throws ArgumentError addrun!(exp, Dict("posParam" => 32, "keyParam" => "iie"))
@test_throws ArgumentError addrun!(exp, Dict("posParam" => 32, "keyParam" => Dict()))

# Good script output
expectedScript = readlines("./data/expectedExperimentScript.sh")

scriptBuffer = writescript(exp)
seekstart(scriptBuffer)
actualScript = readlines(scriptBuffer)

@test expectedScript == actualScript

# If you want to update the expected script
writeActual = false
if writeActual
    seekstart(scriptBuffer)
    open("./data/actualExperimentScript.sh", "w") do io
        write(io, scriptBuffer)
    end
end
