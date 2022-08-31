# This file contains the utils functions.

"""                                                                                    
    fix_unbalanced_name(s::String) => String

Recursive function that fixes unbalanced parentheses in a string, and returns balanced string.

# Example:     

```     
julia> my_s = "DG(18:1(/1(8:1)";  
julia> fix_unbalanced_name(my_s) 
"DG(18:1/18:1)"  
julia> my_s = "DG(18:1/18:1))";
julia> fix_unbalanced_name(my_s) 
"DG(18:1/18:1)" 
julia> my_s = "DG(((((18:1/18:1))";
julia> fix_unbalanced_name(my_s) 
"DG((18:1/18:1))" 
``` 
""" 
function fix_unbalanced_name(s::String)
    left = findall( x -> x .== '(', s)
    right = findall( x -> x .== ')', s)
    if length(left) > length(right)
        idx = left[end]
    elseif length(left) < length(right) 
        idx = right[1]  
    else  
        return s 
    end 
    return fix_unbalanced_name(rmv_by_idx(s, idx)) 
end


"""
    get_variable_names(vDF::Vector{DataFrame}) => Vector{String}

Return the union variable names of all samples as a vector of `String`.   
"""
function get_variables_names(vDF::Vector{DataFrame})

    varNames = unique(reduce(vcat, names.(vDF)))
        
    return varNames
end


"""

    build_df_data(vDF::Vector{DataFrame}) => DataFrame

It checks all samples and includes all the variables names. If a sample misses one or more variable,
it generates the missing entries for all variables. It returns a dataframe.   
"""
function build_df_data(vDF::Vector{DataFrame})
    
    refVarNames = get_variables_names(vDF)
        
    for i in 1:length(vDF)
        vMissNames = setdiff(refVarNames, names(vDF[i]))
        vDF[i] = hcat(vDF[i], DataFrame(repeat(["NA"], 1,length(vMissNames)), vMissNames))
    end
    
    df = reduce(vcat,vDF)
    
    return df
end