# This file contains the functions to extract metabolites attibutes in the study context. This context 
# provides access to a variety of data associated with studies such as study summary, experimental 
# factors for study design, analysis information, metabolites and results data, sample source and 
# species etc...



"""
    mw_mwtab(studyname::String; format = "json") => String

Fetch the mwtab output for a study in json (default) or txt format.

"""
function mw_mwtab(studyname::String; format = "json")
    url = string(mw_url(), "rest/", "study/", "study_id/", studyname, string("/mwtab/", format))
     s = get_output(url)

     isempty(s) ? throw("No study name $(studyname) matching.") : return s

end
