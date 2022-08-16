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
**`fix_unbalance_name`** - *Function*

fix_unbalance_name(s::String) => String

Recursive function that fixes unbalanced parentheses in a string, and returns balanced string.

# Example:     

```jldoctest     
julia> my_s = "DG(18:1(/1(8:1)"  
julia> fix_unbalance_name(my_s) 
"DG(18:1/18:1)"  
julia> my_s = "DG(18:1/18:1))"  
julia> fix_unbalance_name(my_s) 
"DG(18:1/18:1)" 
julia> my_s = "DG(((((18:1/18:1))" 
julia> fix_unbalance_name(my_s) 
"DG((18:1/18:1))" 
``` 
""" 
function fix_unbalance_name(s::String)
    left = findall( x -> x .== '(', s)
    right = findall( x -> x .== ')', s)
    if length(left) > length(right)
        idx = left[end]
    elseif length(left) < length(right) 
        idx = right[1]  
    else  
        return s 
    end 
    return fix_unbalance_name(rmv_by_idx!(s, idx)) 
end
