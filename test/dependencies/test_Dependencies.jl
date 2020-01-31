module DependenciesTests
    using Test

    using ClusterRunner.Dependencies

    @testset "InputDependency" begin
        include("test_inputDependency.jl")
    end

    @testset "OutputDependency" begin
        include("test_outputDependency.jl")
    end

    @testset "Param" begin
        include("test_param.jl")
    end
end
