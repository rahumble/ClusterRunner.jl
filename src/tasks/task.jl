abstract type Task end

"""
    getinputs(task::Task)::Array{InputDependency}
    Returns the input dependencies
"""
function getinputs end

"""
    getparams(task::Task)::Array{Param}
    Returns the dynamic params given to the task
"""
function getparams end

"""
    getoutputs(task::Task)::Array{OutputDependency}
    Returns the outputs created by the task
"""
function getoutputs end

"""
    getcommand(task::Task)::String
    Returns the command to run the task
"""
function getcommand end
