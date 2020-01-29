module Dependencies
    include("dependency.jl")

    include("inputDependency.jl")
    include("filesystemInput.jl")

    include("outputDependency.jl")
    include("filesystemOutput.jl")

    export
        # Types
        Dependency,

        InputDependency,
        FilesystemInput,

        OutputDependency,
        FilesystemOutput,

        # Methods
        getalias,
        setup
end