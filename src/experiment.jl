mutable struct Experiment
    task::Tasks.Task
    runs::Dict{String, Array}

    function Experiment(task::Tasks.Task)::Experiment
        return new(task, Dict{String,Array}())
    end
end

function addrun!(exp::Experiment, params::AbstractDict)::Nothing
    # Check correct number of parameters
    expectedNumParams = length(getparams(exp.task))
    actualNumParams = length(keys(params))
    if expectedNumParams != actualNumParams
        throw(ArgumentError("expected $expectedNumParams params but got $actualNumParams params"))
    end

    # Create runs dict
    if length(keys(exp.runs)) == 0
        for (key, value) in params
            if !any(isa.(value, [Number, String, FileDependency]))
                throw(ArgumentError("param $key is not a supported type"))
            end

            exp.runs[key] = [value]
        end

        return nothing
    end

    # Add params to existing runs dict
    for (key, value) in params
        if !haskey(exp.runs, key)
            throw(ArgumentError("no param $key in the task"))
        end

        paramType = eltype(exp.runs[key])
        if !isa(value, paramType)
            throw(ArgumentError("param $key must of consistent type ($paramType)"))
        end

        push!(exp.runs[key], value)
    end

    return nothing
end

function _getlocation(dep::InputDependency)::String
    return "\$inFolder/$(getfilename(dep))"
end
function _getlocation(dep::OutputDependency)::String
    return "\$outFolder/$(getfilename(dep))"
end

# Expects $inFolder, $outFolder, and $idx to be set beforehand
function writescript(exp::Experiment)::IO
    script = IOBuffer()

    write(script, "### Inputs", "\n")
    for input in getinputs(exp.task)
        alias = getalias(input)
        location = _getlocation(input)
        write(script, "$(alias)=$(location)", "\n")
    end
    write(script, "\n")

    write(script, "### Params", "\n")
    for param in getparams(exp.task)
        paramArr = exp.runs[getalias(param)]
        paramType = eltype(paramArr)

        valArr = String[]
        if paramType in [InputDependency, OutputDependency]
            valArr = [_getlocation(dep) for dep in paramArr]
        else
            valArr = [val for val in paramArr]
        end

        write(script, "$(getalias(param))_arr=($(join(valArr, " ")))", "\n")
        write(script, "$(getalias(param))=\${$(getalias(param))_arr[idx]}", "\n")
    end
    write(script, "\n")

    write(script, "### Outputs", "\n")
    for output in getoutputs(exp.task)
        alias = getalias(output)
        location = _getlocation(output)
        write(script, "$(alias)=$(location)", "\n")
    end
    write(script, "\n")

    write(script, "### Task", "\n")
    write(script, getcommand(exp.task), "\n")
    write(script, "\n")

    return script
end