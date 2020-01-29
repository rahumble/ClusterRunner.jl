module FileReadersTests
    using DataFrames
    using Test

    using ClusterRunner.FileReaders

    function createTestIO(lines::Vararg{String,N})::IO where {N}
        io = IOBuffer()
    
        for line in lines
            write(io, line, "\n")
        end
        seekstart(io)
    
        return io
    end

    @testset "AttributeReader" begin
        include("test_attributeReader.jl")
    end

    @testset "TableReader" begin
        include("test_tableReader.jl")
    end

    # Several readers
    keyReader = AttributeReader(Int, "key", r"<<key=(.*)$")
    tableReader = TableReader("table", r"Test description")
    otherReader = AttributeReader(String, "other", r"some other pattern (.*)$")
    io = createTestIO(
        "<<key=123",
        "fluff",
        "",
        "Test description",
        "Cnt        Float       Int    String",
        "  0      3.6e-03       472       abc",
        "  1      3.3e-05      -665       dfe",
        "",
        "some other pattern abc"
    )

    output = read(io, keyReader, tableReader, otherReader)

    @test length(collect(keys(output))) == 3
    @test typeof(output["key"]) <: Int
    @test typeof(output["table"]) <: DataFrame
    @test typeof(output["other"]) <: String
end
