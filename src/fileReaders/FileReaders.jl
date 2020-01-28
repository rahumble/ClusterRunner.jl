module FileReaders
    import Base: read!, read
    using CSV
    using DataFrames
    import DataStructures: OrderedDict

    include("reader.jl")
    include("attributeReader.jl")
    include("tableReader.jl")

    # Readers need to be in order as file is only read once
    function read(f::IO, readers::Vararg{Reader,N})::OrderedDict where {N}
        output = OrderedDict()

        for reader in readers
            value = read!(f, reader)

            output[getlabel(reader)] = value
        end

        seekstart(f)

        return output
    end

    function read(filename::String, readers::Vararg{Reader,N})::OrderedDict where {N}
        return open(filename, "r") do file
            read(file, readers...)
        end
    end

    export
        # Types
        Reader,
        AttributeReader,
        TableReader,

        # Methods
        getlabel,
        read!,
        read
end