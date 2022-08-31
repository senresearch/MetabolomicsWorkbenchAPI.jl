push!(LOAD_PATH,"../src/")

using MetabolomicsWorkbenchAPI
using Documenter

makedocs(
    modules=[MetabolomicsWorkbenchAPI],
    authors="Gregory Farage <gfarage@uthsc.edu> and Saunak Sen <sen@uthsc.edu>",
    repo="https://github.com/senresearch/MetabolomicsWorkbenchAPI.jl/blob/{commit}{path}#{line}",
    sitename="MetabolomicsWorkbenchAPI.jl",
    format=Documenter.HTML(
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://senresearch.github.io/MetabolomicsWorkbenchAPI.jl/stable",
    ),
    pages=[
        "Overview" => "index.md",
        "Functions" => "functions.md"
    ],
)

deploydocs(
   repo="github.com/senresearch/MetabolomicsWorkbenchAPI.jl",
   devbranch="dev",
   push_preview = true,
)