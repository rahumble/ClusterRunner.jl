abstract type Task end

"""
    getinputs(task::Task)::Array{Dependency}
    Returns the input dependencies
"""
function getinputs end

"""
    getoutputs(task::Task)::Array{OutputFile}
    Returns the outputs created by the task
"""
function getoutputs end

"""
    getcommand(task::Task)::String
    Returns the command to run the task
"""
function getcommand end
