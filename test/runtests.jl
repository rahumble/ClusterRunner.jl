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

module ClusterRunnerTests
    using Test

    using ClusterRunner

    @testset "Experiment" begin
        include("test_experiment.jl")
    end
end
