module ClusterRunner
    include("fileReaders/FileReaders.jl")

    import .FileReaders: Reader, AttributeReader, TableReader, read

end # module
