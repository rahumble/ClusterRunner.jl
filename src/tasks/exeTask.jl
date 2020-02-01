struct ExeTask <: Task
    exeDep::InputDependency
    posArgs::Array
    keywordArgs::AbstractDict
    stdoutFile::OutputDependency
    stderrFile::OutputDependency

    function ExeTask(exeDep::InputDependency, posArgs::Array = [], keywordArgs::AbstractDict = Dict())::ExeTask
        return new(exeDep, posArgs, keywordArgs, OutputDependency("stdout.txt"), OutputDependency("stderr.txt"))
    end
end

function _getByType(task::ExeTask, type::Type{T})::Array{T} where {T}
    isTypeMatch = x -> isa(x, type)

    posDeps = filter(isTypeMatch, task.posArgs)
    keywordDeps = filter(isTypeMatch, collect(values(task.keywordArgs)))

    return vcat(posDeps, keywordDeps)
end

function getinputs(task::ExeTask)::Array{InputDependency}
    return vcat([task.exeDep], _getByType(task, InputDependency))
end

function getparams(task::ExeTask)::Array{Param}
    return _getByType(task, Param)
end

function getoutputs(task::ExeTask)::Array{OutputDependency}
    return vcat([task.stdoutFile, task.stderrFile], _getByType(task, OutputDependency))
end

function _stringifyValue(value)::String
    if isa(value, Dependency)
        return "\${$(getalias(value))}"
    elseif isnothing(value)
        return ""
    else
        return string(value)
    end
end

function _stringifyKeywordArg(arg::String, value)::String
    return strip("$(arg) $(_stringifyValue(value))")
end

function getcommand(task::ExeTask)::String
    argString = ""

    # Handle positional arguments
    posArgStrings = [_stringifyValue(value) for value in task.posArgs]
    argString *= join(posArgStrings, " ")

    # Handle keyword arguments
    keyArgStrings = [_stringifyKeywordArg(arg, value) for (arg, value) in task.keywordArgs]
    argString *= join(keyArgStrings, " ")

    return join([
        _stringifyValue(task.exeDep),
        argString,
        ">",
        _stringifyValue(task.stdoutFile),
        "2>",
        _stringifyValue(task.stderrFile)
    ], " ")
end
