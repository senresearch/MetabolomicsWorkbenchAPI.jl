using MetabolomicsWorkbenchAPI
using Test

# Generate test data
include("test_data.jl")

@testset "MetabolomicsWorkbenchAPI.jl" begin
    include("fetch_test.jl")
end