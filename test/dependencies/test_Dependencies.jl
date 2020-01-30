module DependenciesTests
    using Test

    using ClusterRunner.Dependencies

    @testset "FilesystemInput" begin
        include("test_filesystemInput.jl")
    end

    @testset "FilesystemOutput" begin
        include("test_filesystemOutput.jl")
    end

    @testset "Param" begin
        include("test_param.jl")
    end
end
