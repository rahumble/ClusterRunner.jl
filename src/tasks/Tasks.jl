module Tasks
    using ..Dependencies: Dependency, Param, InputDependency, OutputDependency, FilesystemOutput, getalias

    include("task.jl")
    include("exeTask.jl")

    export
        # Types
        Task,
        ExeTask,

        # Methods
        getinputs,
        getparams,
        getoutputs,
        getcommand
end