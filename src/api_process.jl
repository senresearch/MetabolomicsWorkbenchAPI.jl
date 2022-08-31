# This file contains functions to process the output of the metabolomics workbench REST URL queries. 

"""
    get_output(url::String) => String

 Gets output body from a URL.
"""
function get_output(url::String)
    response = HTTP.get(url)
    return String(response.body)
end

"""
    parse_json(s) => JSON3.Object

 Read JSON.
"""
function parse_json(s:: String)
    s = filt_json(s)
    return JSON3.read(s)
end

"""
    json2df(s) => DataFrame
 
 Converts a string from a single JSON entry into a dataframe.
"""
function json2df(s::String)
    s = filt_json(s)
    dict = JSON3.read(s)
    return DataFrame(dict)
end

"""
    url2df(url::String) => DataFrame

Gets the response from REST URL and converts a single JSON entry to dataframe
"""
function url2df(url::String)
    output_json = get_output(url)
    return json2df(output_json)
end

"""
    filt_json(s::String) => String

Remove any text before the first '{' in a string.
"""
function filt_json(s::String)
    # Make it robust to any html code before json 
    idxStart = findfirst("{", s)[1]
    s = s[idxStart:end]
    return s
end

