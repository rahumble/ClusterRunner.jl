module ClusterRunner
    include("dependencies/Dependencies.jl")
    using .Dependencies
    export
        # Types
        Dependency,
        Param,
        InputDependency,
        OutputDependency
        
        # Methods
    
    include("fileReaders/FileReaders.jl")
    using .FileReaders
    export
        # Types
        Reader,
        AttributeReader,
        TableReader

        # Methods

    include("tasks/Tasks.jl")
    using .Tasks
    export
        # Types
        Task,
        ExeTask

        # Methods

    include("experiment.jl")
    export
        # Types
        Experiment,

        # Methods
        addrun!,
        writescript

end # module
