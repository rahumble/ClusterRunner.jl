module TasksTests
    using DataStructures: OrderedDict
    using Test

    using ClusterRunner.Dependencies
    using ClusterRunner.Tasks

    @testset "ExeTask" begin
        include("test_exeTask.jl")
    end
end
