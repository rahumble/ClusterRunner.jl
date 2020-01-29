module Dependencies
    include("dependency.jl")
    include("filesystemDependency.jl")

    export
        # Types
        Dependency,
        FilesystemDependency,

        # Methods
        setup
end