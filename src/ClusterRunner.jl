module ClusterRunner
    include("fileReaders/FileReaders.jl")

    import .FileReaders: Reader, AttributeReader, TableReader, read

    export
        # Types
        Reader,
        AttributeReader,
        TableReader,

        # Methods
        read

end # module
