# This file contains the functions to extract metabolites attibutes in the study context. This context 
# provides access to a variety of data associated with studies such as study summary, experimental 
# factors for study design, analysis information, metabolites and results data, sample source and 
# species etc...



"""
**`mw_mwtab`** - *Function*

    mw_mwtab(study_name::String; format = "txt") => String

Fetch the mwtab output for a study in text (default) or json format.

"""
function mw_mwtab(study_name::String; format = "txt")
    url = string(mw_url(), "rest/", "study/",  study_name, string("/mwtab/", format))
    return get_output(url)
end


#https://www.metabolomicsworkbench.org/rest/study/study_id/ST001710/mwtab/txt
