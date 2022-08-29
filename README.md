# MetabolomicsWorkbenchAPI.jl

The [Metabolomics Workbench](https://www.metabolomicsworkbench.org/) operates as an international repository for metabolomics data and metadata while delivering analysis tools and access to metabolite standards, protocols, and more. The Metabolomics Workbench was developed by the Metabolomics Common Fund's National Metabolomics Data Repository(NMDR) to support the development of next-generation technologies, increase the inventory and availability of high-quality reference standards, and facilitate data sharing and collaboration.

MetabolomicsWorkbenchAPI.jl is a Julia package to work with Metabolomics Workbench REST service. The official MW REST API documentation can be downloaded [here](https://www.metabolomicsworkbench.org/tools/MWRestAPIv1.0.pdf). Several examples of REST urls associated to various requests are presented in the [Metabolomics WorkBench REST service web page](https://www.metabolomicsworkbench.org/tools/mw_rest.php) that includes an interactive "REST url" creator.
The current  MetabolomicsWorkbenchAPI.jl version provides only access to the database but not to the analysis functions.
