######################
# Generate test data #
######################

# TEST - fetch_properties

dfTestProperties = MetabolomicsWorkbenchAPI.DataFrame(
    exactmass=[479.3376, missing, 652.6158, missing],
    formula=["C24H50NO6P", missing, "C45H80O2", missing],
    main_class=[
        "Glycerophosphocholines",
        "Glycerophosphocholines",
        "Sterol esters",
        "Triradylglycerols"
    ],
    refmet_name=[
        "LPC P-16:0",
        "PC  P-18:0/18:1(9Z)*",
        "CE 18:0",
        "TG  O-52:2*"
    ],
    sub_class=[
        "O-LPC",
        "PC",
        "Chol. esters",
        "O-TAG"
    ],
    super_class=[
        "Glycerophospholipids",
        "Glycerophospholipids",
        "Sterol Lipids",
        "Glycerolipids"
    ]
);

# TEST - fetch_data

dfTestData = MetabolomicsWorkbenchAPI.DataFrame(
    Metabolite=["1,2,4-benzenetriol", "1-monostearin"],
    LabF_115904=["1874", "987"],
    LabF_115909=["3566", "450"],
    LabF_115914=["1945", "1910"],
);

# TEST - fetch_metabolites

dfTestMetabolites = MetabolomicsWorkbenchAPI.DataFrame(
    Metabolite=["1,2,4-benzenetriol", "1-monostearin"],
    moverz_quant=["239", "399"],
    ri=["522741", "959625"],
    ri_type=["Fiehn", "Fiehn"]
);


# TEST - fetch_samples

dfTestSamples = MetabolomicsWorkbenchAPI.DataFrame(
    ["LabF_115873"  "Wassilewskija (Ws)" "Control - Non-Wounded";
     "LabF_115878" "Wassilewskija (Ws)" "Control - Non-Wounded"],
    ["Sample ID", "Arabidopsis Genotype", "Plant Wounding Treatment"]
);


# TEST - fetch_study_info

dfTestStudyInfo = MetabolomicsWorkbenchAPI.DataFrame(
    STUDY_TYPE=["Genotype treatment"],
    NUM_GROUPS=["4"],
    TOTAL_SUBJECTS=["24"],
);