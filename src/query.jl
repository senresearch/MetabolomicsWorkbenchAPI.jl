# This file contains the functions to check status and adress or metabolomics workbench REST API.

"""
**check_gn** -*Function*.

mw_url() => String

Returns the default Metabolomics Workbench REST API URL.

# Example
```jldoctest
julia> mw_url()
"https://www.metabolomicsworkbench.org/"
```
"""
function mw_url()
    return url = "https://www.metabolomicsworkbench.org/"
end

"""
**check_mw** -*Function*.

check_mw(url::AbstractString=mw_url()) => String

Checks if Metabolomics Workbench server is responding properly.
Returns the HTTP status code (`200` if successful) and prints a
message.
# Example
```jldoctest
julia> check_mw()
MetabolomicsWorkbench.org is alive.
200
```
"""
function check_mw(url::AbstractString=mw_url())
    status = HTTP.get(url).status
    if(status==200)
        println("MetabolomicsWorkbench.org is alive.")
    else
        println("Not successful.")
    end
    return status
end