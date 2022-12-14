##############################################
# TEST 1 check metabolomics workbench server #
##############################################

println("Check server status test: ", @test check_mw()==200);

############################
# TEST 2 fetch properties #
############################

vMetabolitesNames = ["LPC(16:0p)", "PC(18:0p/18:1(9Z))", "CE(18:0)", "TG(O-52:2)"];
df = fetch_properties(vMetabolitesNames)

println("Fetch annotation test: ", @test (df[:, 3:end] == dfTestProperties[:, 3:end]));

#####################
# TEST 3 fetch data #
#####################

df = fetch_data("ST000001")

println("Fetch data test: ", @test (df[1:2, 1:4] == dfTestData));

############################
# TEST 4 fetch metabolites #
############################

df = fetch_metabolites("ST000001")

println("Fetch properties test: ", @test (df[1:2, 1:4] == dfTestMetabolites));

########################
# TEST 5 fetch samples #
########################

df = fetch_samples("ST000001")

println("Fetch samples test: ", @test (df[1:2, :] == dfTestSamples));

#################################
# TEST 6 fetch sudy description #
#################################

df = fetch_study_info("ST000001")
df = MetabolomicsWorkbenchAPI.DataFrames.select(df, [:STUDY_TYPE, :NUM_GROUPS, :TOTAL_SUBJECTS])

println("Fetch total subjects test: ", @test (df == dfTestStudyInfo));

###############################
# TEST 7 fetch total subjects #
###############################

n = fetch_total_subjects("ST000001")

println("Fetch total subjects test: ", @test (n == 24));