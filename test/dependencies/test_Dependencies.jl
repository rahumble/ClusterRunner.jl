module DependenciesTests
    using Test

    using ClusterRunner.Dependencies

    @testset "FilesystemDependency" begin
        include("test_filesystemDependency.jl")
    end
end
