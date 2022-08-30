"""
Main module for `MetabolomicsWorkbenchAPI.jl` -- a Julia wrapper to create HTTP requests and interact 
with datasets through the REST API of https://www.metabolomicsworkbench.org/.
"""



module MetabolomicsWorkbenchAPI

    using HTTP, JSON3, DataFrames, CSV

    include("./query.jl")    
    export mw_url, check_mw

    include("./api_process.jl")
    export get_output, parse_json, json2df, url2df  
        
    include("./refmet_api.jl")    
    export mw_match

    include("./study_api.jl")    
    export mw_mwtab

    include("./fetch_data.jl")    
    export fetch_properties, fetch_data, fetch_metabolites, fetch_samples

    include("./utils.jl")    
    export fix_unbalanced_name, get_variables_names, build_df_data

end