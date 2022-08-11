# This file contains functions to process the output of the metabolomics workbench REST URL queries. 

"""
 Gets output body from a URL.
"""
function get_output(url)
    response = HTTP.get(url)
    String(response.body)
end

"""
 Converts a string from a single json entry into a Dictionary.
"""
function parse_json(str)
    return JSON.parse(str)
end

function str2df(input::String; delim=',', comments=false)
    df = DataFrames.inlinetable(input, separator=delim, header=true, allowcomments=comments)
end

"""
 Converts a string from a single json entry into a dataframe.
"""
function json2df(s::String)
    dict = JSON.parse(s)
    return j2d(dict)
end

"""
Converts an array of json entries into DataFrames type.
"""
function j2d(input::Array{Any,1})
    return vcat(DataFrame.(input)..., cols=:union)
end

"""
 Converts a Dictionary object from a single json entry into DataFrames type.
"""
function j2d(input::Dict{String,Any})
    return DataFrame(input)
end

"""
Gets the response from REST URL and converts a single json entry to df
"""
function url2df(url::String)
    output_json = get_output(url)
    return json2df(output_json)
end