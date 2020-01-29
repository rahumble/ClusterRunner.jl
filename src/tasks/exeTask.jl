struct ExeTask <: Task
    exeDep::Dependency
    posArgs::Array
    keywordArgs::AbstractDict
    stdoutFile::FilesystemOutput
    stderrFile::FilesystemOutput

    function ExeTask(exeDep::Dependency, posArgs::Array = [], keywordArgs::AbstractDict = Dict())::ExeTask
        return new(exeDep, posArgs, keywordArgs, FilesystemOutput("stdout.txt"), FilesystemOutput("stderr.txt"))
    end
end

function getinputs(task::ExeTask)::Array{Dependency}
    isDependency = x -> isa(x, InputDependency)

    posDeps = filter(isDependency, task.posArgs)
    keywordDeps = filter(isDependency, collect(values(task.keywordArgs)))

    return vcat([task.exeDep], posDeps, keywordDeps)
end

function getoutputs(task::ExeTask)::Array{OutputDependency}
    isOutput = x -> isa(x, OutputDependency)

    posOutputs = filter(isOutput, task.posArgs)
    keywordOutputs = filter(isOutput, collect(values(task.keywordArgs)))

    return vcat([task.stdoutFile, task.stderrFile], posOutputs, keywordOutputs)
end

function _stringifyValue(value)::String
    if isa(value, Dependency)
        return getalias(value)
    elseif isnothing(value)
        return ""
    else
        return string(value)
    end
end

function _stringifyKeywordArg(arg::String, value)::String
    return "$(arg) $(_stringifyValue(value))"
end

function getcommand(task::ExeTask)::String
    argString = ""

    # Handle positional arguments
    posArgStrings = [_stringifyValue(value) for value in task.posArgs]
    argString *= join(posArgStrings, " ")

    # Handle keyword arguments
    keyArgStrings = [_stringifyKeywordArg(arg, value) for (arg, value) in task.keywordArgs]
    argString *= join(keyArgStrings, " ")

    return "$(getalias(task.exeDep)) $(argString) > $(getalias(task.stdoutFile)) 2> $(getalias(task.stderrFile))"
end
