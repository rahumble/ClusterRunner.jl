module Dependencies
    include("dependency.jl")
    include("param.jl")

    include("inputDependency.jl")

    include("outputDependency.jl")

    export
        # Types
        Dependency,
        Param,

        InputDependency,

        OutputDependency,

        # Methods
        getalias,
        setup
end