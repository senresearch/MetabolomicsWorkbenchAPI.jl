# This file contains the functions to fetch data/information from metabolomics workbench REST APIs

"""                                                                                    
**`fetch_annotations`** - *Function*

    fetch_annotations(metabolite_names::Vector{String}) => DataFrame

Returns a data frame with the following information: 
exact mass, formula, main class, refmet name, sub class, super class. 

# Example:     

```jldoctest     
julia> vNames = ["LPC(16:0p)", "PC(18:0p/18:1(9Z))", "CE(18:0)", "PC(O-32:1)", "TG(O-52:2)"];
julia> fetch_annotations(vNames)
5×6 DataFrame
 Row │ exactmass  formula     main_class              v_refmet_name         sub_class     super_class
     │ String?    String?     String                  String                String        String
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ 479.3376   C24H50NO6P  Glycerophosphocholines  LPC P-16:0            O-LPC         Glycerophospholipids
   2 │ missing    missing     Glycerophosphocholines  PC  P-18:0/18:1(9Z)*  PC            Glycerophospholipids
   3 │ 652.6158   C45H80O2    Sterol esters           CE 18:0               Chol. esters  Sterol Lipids
   4 │ 717.5672   C40H80NO7P  Glycerophosphocholines  PC O-32:1             O-PC          Glycerophospholipids
   5 │ missing    missing     Triradylglycerols       TG  O-52:2*           O-TAG         Glycerolipids
```
"""
function fetch_annotations(metabolites_names::Vector{String})
    # Initialize vectors of information
    n = length(metabolites_names)
    v_exactmass = Vector{Union{Missing, String}}(undef,n)
    v_formula = Vector{Union{Missing, String}}(undef,n)
    v_main_class = Vector{String}(undef,n)
    v_refmet_name = Vector{String}(undef,n)
    v_sub_class = Vector{String}(undef,n)
    v_super_class = Vector{String}(undef,n)

    for i in 1:length(metabolites_names)
        df = mw_match(metabolites_names[i])

        v_exactmass[i] = ["exactmass"] ⊆  names(df) ? df.exactmass[1] : missing
        v_formula[i]= ["formula"] ⊆  names(df) ? df.formula[1] : missing
        v_main_class[i] = df.main_class[1]
        v_refmet_name[i] = df.refmet_name[1]
        v_sub_class[i] = df.sub_class[1]
        v_super_class[i] = df.super_class[1]
    end

    df_out = DataFrame(exactmass = v_exactmass, formula = v_formula,
                main_class = v_main_class, v_refmet_name = v_refmet_name,
                sub_class = v_sub_class, super_class = v_super_class)
    
    return df_out
end
