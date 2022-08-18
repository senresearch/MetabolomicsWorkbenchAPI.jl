# This file contains the utils functions.

"""                                                                                    
**`rmv_by_idx`** - *Function*

rmv_by_idx(s::String, i::Int) => String

Returns a new string without the character at the position `i` of the original string `s`.

# Example:     

```jldoctest     
julia> my_s = "abcde"
julia> rmv_by_idx(my_s, 3)
"abde"
```
"""
function rmv_by_idx(s::String, i::Int) 
    if i == 1 
        s = s[2:end] 
    elseif i == length(s) 
        s = s[1:end-1] 
    else 
        s = s[1:i-1]*s[i+1:end] 
    end 
    return s 
end 


"""                                                                                    
**`fix_unbalanced_name`** - *Function*

fix_unbalanced_name(s::String) => String

Recursive function that fixes unbalanced parentheses in a string, and returns balanced string.

# Example:     

```jldoctest     
julia> my_s = "DG(18:1(/1(8:1)"  
julia> fix_unbalanced_name(my_s) 
"DG(18:1/18:1)"  
julia> my_s = "DG(18:1/18:1))"  
julia> fix_unbalanced_name(my_s) 
"DG(18:1/18:1)" 
julia> my_s = "DG(((((18:1/18:1))" 
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
**get_variable_names** -*Function*.

get_variable_names(vDF::Vector{DataFrame}) => Vector{String}

Return the union variable names of all samples as a vector of `String`.   
"""
function get_variables_names(vDF::Vector{DataFrame})

    varNames = unique(reduce(vcat, names.(vDF)))
        
    return varNames
end


"""
**build_df_data** -*Function*.

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