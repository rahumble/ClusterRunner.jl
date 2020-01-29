using Logging
using Test

disable_logging(Logging.Info)

@testset "Dependencies" begin
    include("dependencies/test_Dependencies.jl")
end

@testset "FileReaders" begin
    include("fileReaders/test_FileReaders.jl")
end

@testset "Tasks" begin
    include("tasks/test_Tasks.jl")
end
