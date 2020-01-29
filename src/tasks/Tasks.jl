module Tasks
    using ..Dependencies: Dependency, InputDependency, OutputDependency, FilesystemOutput, getalias

    include("task.jl")
    include("exeTask.jl")

    export
        # Types
        Task,
        ExeTask,

        # Methods
        getinputs,
        getoutputs,
        getcommand
end