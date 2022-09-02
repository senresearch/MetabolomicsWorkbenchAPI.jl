# This file contains the functions to fetch data/information from metabolomics workbench REST APIs
#=
Functions list:

- fetch_properties
- fetch_data
- fetch_metabolites
- fetch_samples

=#

"""                                                                                    
    fetch_properties(metabolite_names::Vector{String}) => DataFrame

Returns a data frame with the following information: 
exact mass, formula, main class, refmet name, sub class, super class. 

# Example:     

```     
julia> vNames = ["LPC(16:0p)", "PC(18:0p/18:1(9Z))", "CE(18:0)", "PC(O-32:1)", "TG(O-52:2)"];
julia> fetch_properties(vNames)
5×6 DataFrame
 Row │ exactmass  formula     main_class              refmet_name         sub_class     super_class
     │ String?    String?     String                  String                String        String
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ 479.3376   C24H50NO6P  Glycerophosphocholines  LPC P-16:0            O-LPC         Glycerophospholipids
   2 │ missing    missing     Glycerophosphocholines  PC  P-18:0/18:1(9Z)*  PC            Glycerophospholipids
   3 │ 652.6158   C45H80O2    Sterol esters           CE 18:0               Chol. esters  Sterol Lipids
   4 │ 717.5672   C40H80NO7P  Glycerophosphocholines  PC O-32:1             O-PC          Glycerophospholipids
   5 │ missing    missing     Triradylglycerols       TG  O-52:2*           O-TAG         Glycerolipids
```
"""
function fetch_properties(vMetabolitesNames::Vector{String})
    # Initialize vectors of information
    n = length(vMetabolitesNames)
    vExactmass = Vector{Union{Missing,String}}(undef, n)
    vFormula = Vector{Union{Missing,String}}(undef, n)
    vMainclass = Vector{String}(undef, n)
    vRefmetname = Vector{String}(undef, n)
    vSubclass = Vector{String}(undef, n)
    vSuperclass = Vector{String}(undef, n)

    for i in 1:length(vMetabolitesNames)
        df = mw_match(vMetabolitesNames[i])

        vExactmass[i] = ["exactmass"] ⊆ names(df) ? df.exactmass[1] : missing
        vFormula[i] = ["formula"] ⊆ names(df) ? df.formula[1] : missing
        vMainclass[i] = ["main_class"] ⊆ names(df) ? df.main_class[1] : missing
        vRefmetname[i] = ["refmet_name"] ⊆ names(df) ? df.refmet_name[1] : missing
        vSubclass[i] = ["sub_class"] ⊆ names(df) ? df.sub_class[1] : missing
        vSuperclass[i] = ["super_class"] ⊆ names(df) ? df.super_class[1] : missing
    end

    dfOut = DataFrame(exactmass=vExactmass, formula=vFormula,
        main_class=vMainclass, refmet_name=vRefmetname,
        sub_class=vSubclass, super_class=vSuperclass)

    return dfOut
end


"""                                                                                    
    fetch_data(studyname::String) => DataFrame

Return the metabolite data of the study as a dataframe.  

# Example:     

```     
julia> df = fetch_data("ST001710");
julia> df[1:5,1:3]
5×3 DataFrame
 Row │ Metabolite           1022385746  1022385747 
     │ String               String      String     
─────┼─────────────────────────────────────────────
   1 │ CE(16:0) + CE(18:1)  0.1062      -1.9080
   2 │ CE(18:0)             0.2580      0.2774
   3 │ CE(18:2)             1.0654      0.1419
   4 │ CE(20:4)             0.7983      -0.3442
   5 │ Cer(d18:1/23:0)      1.2658      0.9246
```
"""
function fetch_data(studyname::String)

    s = mw_mwtab(studyname)

    jsonFile = parse_json(s)
    dfData = DataFrame(jsonFile[:MS_METABOLITE_DATA][:Data])

    return dfData

end


"""                                                                                    
    fetch_metabolites(studyname::String) => DataFrame

Return the dataframe of the metabolites' attributes of the study.  

# Example:     

```     
julia> df = fetch_metabolites("ST001710");
julia> df[1:5,1:3]
5×10 DataFrame
 Row │ Metabolite           pubchem_id  inchi_key  kegg_id  other_id  other_id_type  ri      ri_type  moverz_quant
     │ String               String      String     String   String    String         String  String   String            String 
─────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ CE(16:0) + CE(18:1)                                                           9.12             369.351948452576
   2 │ CE(18:0)                                                                      9.64             369.351943579901
   3 │ CE(18:2)                                                                      8.71             369.351905113834
   4 │ CE(20:4)                                                                      8.48             369.351992746797
   5 │ Cer(d18:1/23:0)                                                               7.78             636.630358494506
```
"""
function fetch_metabolites(studyname::String)

    s = mw_mwtab(studyname)

    jsonFile = parse_json(s)
    dfMetabolites = DataFrame(jsonFile[:MS_METABOLITE_DATA][:Metabolites])

    return dfMetabolites

end


"""                                                                                    
    fetch_samples(studyname::String) => DataFrame

Return the samples dataframe of the study.  

# Example:     

```     
julia> fetch_samples("ST001710")
627×15 DataFrame
 Row │ Sample ID   Data type         NAFLD.Category  T2DM    Kleiner.Steatosis  Inflammation  Sex     Sample_Data:Ballooning  Kleiner.Fibrosis  NAS     Platelets.E10-9.per.L  Liver.ALT  Liver.AST  AST.ALT.Ratio       ⋯     │ String      String            String          String  String             String        String  String                  String            String  String                 String     String     String              ⋯─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────   1 │ 1022385746  Serum lipidomics  1               NA      1                  -             NA      -                       -                 1       235                    173        248        1.43352601156069    ⋯   2 │ 1022385747  Serum lipidomics  1               NA      1                  1             NA      -                       -                 2       278                    38         41         1.07894736842105     
   3 │ 1022385761  Serum lipidomics  1               NA      1                  1             NA      -                       -                 2       246                    22         27         1.22727272727273     
   4 │ 1022385792  Serum lipidomics  1               NA      1                  3             NA      -                       1c                3       283                    20         18         0.9
   5 │ 1022385816  Serum lipidomics  1               NA      2                  1             NA      -                       -                 3       280                    NA         NA         NA                  ⋯   6 │ 1022385825  Serum lipidomics  1               NA      2                  1             NA      -                       NA                3       252                    116        69         0.594827586206897    
  ⋮  ⋮              ⋮                ⋮           ⋮             ⋮               ⋮          ⋮               ⋮                    ⋮            ⋮               ⋮                ⋮          ⋮              ⋮           ⋱ 622 │ 1022386897  Serum lipidomics  NA              Y       NA                 NA            NA      NA                      NA                NA      267                    32         32         1
 623 │ 1026694057  Serum lipidomics  -               N       -                  -             NA      -                       -                 -       NA                     27         21         0.777777777777778    
 624 │ 1028937993  Serum lipidomics  -               N       -                  -             NA      NA                      -                 NA      NA                     26         27         1.03846153846154    ⋯ 625 │ 1028939944  Serum lipidomics  -               N       -                  -             NA      -                       -                 -       187                    29         26         0.896551724137931    
 626 │ 1026694049  Serum lipidomics  -               Y       -                  -             NA      -                       -                 -       NA                     18         20         1.11111111111111     
 627 │ 1022385827  Serum lipidomics  1               NA      1                  1             NA      -                       -                 2       NA                     35         22         0.628571428571429                                                                                                                                                
                                                                                                                                                                                            5 columns and 615 rows omitted
```
"""
function fetch_samples(studyname::String)

    s = mw_mwtab(studyname)

    jsonFile = parse_json(s)
    df = DataFrame(jsonFile[:SUBJECT_SAMPLE_FACTORS])

    dfSamples = hcat(select(df, ["Sample ID"]), build_df_data(DataFrame.(df.Factors)))

    if ["Additional sample data"] ⊆ names(df)
        dfSamples = hcat(dfSamples, build_df_data(DataFrame.(df."Additional sample data")))
    end

    return dfSamples

end


"""                                                                                    
    fetch_study_info(studyname::String) => DataFrame

Returns a dataframe containing the available study information such as
the study title, summary, institute name, total number of subjects and much more.

# Example:     

```     
julia> df = fetch_study_info("ST000001");
julia> select(dftest, [:STUDY_TITLE, :INSTITUTE])
1×2 DataFrame
 Row │ STUDY_TITLE                        INSTITUTE
     │ String                             String
─────┼────────────────────────────────────────────────────────────────────
   1 │ Fatb Induction Experiment (FatBI…  University of California, Davis                                                                                                                                                                                5 columns and 615 rows omitted
```
"""
function fetch_study_info(studyname::String)

    s = mw_mwtab(studyname)

    jsonFile = parse_json(s)

    df = DataFrame(jsonFile[:STUDY])

    return df

end


"""                                                                                    
    fetch_total_subjects(studyname::String) => Integer

Return the total number of subjects of the study.  

# Example:     

```     
julia> fetch_total_subjects("ST001052")
51                                                                                                                                                                                5 columns and 615 rows omitted
```
"""
function fetch_total_subjects(studyname::String; verbose = true)

    df = fetch_study_info(studyname)
    
    if ["TOTAL_SUBJECTS"] ⊆ names(df)
        n = parse(Int, df.TOTAL_SUBJECTS[1])
        return n
    else
        verbose ? println("TOTAL_SUBJECTS not found in study $(studyname) description.") :
            return nothing
    end

end
