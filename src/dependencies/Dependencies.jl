module Dependencies
    include("dependency.jl")
    include("param.jl")

    include("fileDependency.jl")
    include("inputDependency.jl")
    include("outputDependency.jl")

    export
        # Types
        Dependency,
        Param,

        FileDependency,
        InputDependency,
        OutputDependency,

        # Methods
        getalias,
        getfilename,
        setup
end