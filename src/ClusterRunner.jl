module ClusterRunner
    include("dependencies/Dependencies.jl")
    include("fileReaders/FileReaders.jl")

    import .Dependencies: Dependency, FilesystemDependency, setup
    export
        # Types
        Dependency,
        FilesystemDependency,
        
        # Methods
        setup
    
    import .FileReaders: Reader, AttributeReader, TableReader, read
    export
        # Types
        Reader,
        AttributeReader,
        TableReader,

        # Methods
        read

end # module
