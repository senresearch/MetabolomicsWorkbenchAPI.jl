# This file contains the functions to extract metabolites attibutes in the refmet context, a standardized 
# reference nomenclature for both discrete metabolite structures and metabolite species identified by 
# spectroscopic techniques in metabolomics experiments.



"""
**`mw_match`** - *Function*

    mw_match(metabolite_name::String) => DataFrame

> The “match” input item performs a search against a customized synonym table in the database. The
> submitted synonyms are matched in a ‘fuzzy’ manner by dropping the following types of characters
> from the specified input value: <space>_+-/(){}[]*";@. In addition, some common ion adduct suffixes
> (e.g. [M+H]+) are removed. The output item is ignored and the following output information is retrieved:
> refmet_name, formula, exact mass, main class, sub class.'
(https://www.metabolomicsworkbench.org/tools/MWRestAPIv1.0.pdf)

"""
function mw_match(metabolite_name::String)
    # Note: we remove "(" and ")" since rest match is note robust to extra paratentheses
    url = string(mw_url(), "rest/", "refmet/", "match/",  fix_unbalanced_name(metabolite_name))
    return url2df(url)
end

