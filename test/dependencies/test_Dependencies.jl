module DependenciesTests
    using Test

    using ClusterRunner.Dependencies

    @testset "FilesystemInput" begin
        include("test_filesystemInput.jl")
    end
end
