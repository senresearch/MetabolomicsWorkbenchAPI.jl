############################
# TEST 1 fetch properties #
############################

vMetabolitesNames = ["LPC(16:0p)", "PC(18:0p/18:1(9Z))", "CE(18:0)", "TG(O-52:2)"];
df = fetch_properties(vMetabolitesNames)

println("Fetch annotation test: ", @test (df[:, 3:end] == dfTestProperties[:, 3:end]));

#####################
# TEST 2 fetch data #
#####################

df = fetch_data("ST000001")

println("Fetch data test: ", @test (df[1:2, 1:4] == dfTestData));

############################
# TEST 3 fetch metabolites #
############################

df = fetch_metabolites("ST000001")

println("Fetch attributes test: ", @test (df[1:2, 1:4] == dfTestMetabolites));

########################
# TEST 4 fetch samples #
########################

df = fetch_samples("ST000001")

println("Fetch samples test: ", @test (df[1:2, :] == dfTestSamples));