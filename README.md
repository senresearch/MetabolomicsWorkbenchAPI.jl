[![CI](https://github.com/senresearch/MetabolomicsWorkbenchAPI.jl/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/senresearch/MetabolomicsWorkbenchAPI.jl/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/senresearch/MetabolomicsWorkbenchAPI.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/senresearch/MetabolomicsWorkbenchAPI.jl)

# MetabolomicsWorkbenchAPI.jl

The [Metabolomics Workbench](https://www.metabolomicsworkbench.org/) operates as an international repository for metabolomics data and metadata while delivering analysis tools and access to metabolite standards, protocols, and more. The Metabolomics Workbench was developed by the Metabolomics Common Fund's National Metabolomics Data Repository(NMDR) to support the development of next-generation technologies, increase the inventory and availability of high-quality reference standards, and facilitate data sharing and collaboration.

MetabolomicsWorkbenchAPI.jl is a Julia package to work with Metabolomics Workbench REST service. The official MW REST API documentation can be downloaded [here](https://www.metabolomicsworkbench.org/tools/MWRestAPIv1.0.pdf). Several request examples of REST urls are presented in the [Metabolomics WorkBench REST service web page](https://www.metabolomicsworkbench.org/tools/mw_rest.php) that includes an interactive "REST url" creator.
The current  MetabolomicsWorkbenchAPI.jl version provides only access to the database but not to the analysis functions.


## Check connection 

To check if the website is responding properly:

```Julia
julia> check_mw()
MetabolomicsWorkbench.org is alive.
200
```

## Get Metabolites Properties 

To get properties for a list of metabolites names.

```Julia
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


## Get metabolites Data 

To get metabolites data for a study.

```Julia
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

## Get metabolites 

To get the list of metabolites for a study.

```Julia
julia> df = fetch_metabolites("ST000001");
julia> select(df, Not(["inchi_key", "other_id_type"]))[1:5,:]
5×7 DataFrame
 Row │ Metabolite               moverz_quant  ri      ri_type  pubchem_id  kegg_id  other_id 
     │ String                   String        String  String   String      String   String   
─────┼───────────────────────────────────────────────────────────────────────────────────────
   1 │ 1,2,4-benzenetriol       239           522741  Fiehn    10787       C02814   205673
   2 │ 1-monostearin            399           959625  Fiehn    107036      D01947   202835
   3 │ 2-hydroxyvaleric acid    131           310750  Fiehn    98009                218773
   4 │ 3-phosphoglycerate       299           611619  Fiehn    724         C00597   217821
   5 │ 5-hydroxynorvaline NIST  142           494838  Fiehn    95562                200384
```

## Get Samples variables 

To get samples and experimental variables for a study.

```Julia
julia> df = fetch_metabolites("ST000001");
julia> select(df, Not(["inchi_key", "other_id_type"]))[1:5,:]
5×7 DataFrame
 Row │ Metabolite               moverz_quant  ri      ri_type  pubchem_id  kegg_id  other_id 
     │ String                   String        String  String   String      String   String   
─────┼───────────────────────────────────────────────────────────────────────────────────────
   1 │ 1,2,4-benzenetriol       239           522741  Fiehn    10787       C02814   205673
   2 │ 1-monostearin            399           959625  Fiehn    107036      D01947   202835
   3 │ 2-hydroxyvaleric acid    131           310750  Fiehn    98009                218773
   4 │ 3-phosphoglycerate       299           611619  Fiehn    724         C00597   217821
   5 │ 5-hydroxynorvaline NIST  142           494838  Fiehn    95562                200384
```
