## ENCORE RNASEQ template  
The analysis of RNASeq data entails sequence alignment, obtaining gene counts and further statistical analysis. Sequence alignment and creation of gene counts is typically performed on a cluster after which the data is transferred to a more moderate computer for further analysis. This analysis is performed using R.

For a RNASeq support project one can initialise a fresh ENCORE FSS structure using the functions in the `getFSS_ENCORE4.r` script.  
- The function `startNewRepo` will clone the ENCORE repository from Github (you will need access, i.e. a Github Personal Access Token installed) and rename it via its argument `dirname=`.
    -  Depending on whether the `workflowType` argument is set to `RNASeq` (default) the `NameOfDataset_1` directory withinthe `Data` directory will be renamed to `RNASeq` and the `0_PROJECT.md` and `Navigation.conf` files will be filled with  standard text, that this is a standard RNASeq support workflow.
    -  The argument `analysisDir` allows for naming the analysis directory within the `/Processing` directory.  
- The function `startNewAnalysis` will actually within the `/Processing` directory create a directory structure for a new analysis. Via the `analysisDir` argument you can specify its name
- The `pushToRepo` function is under construction and hasn't been tested...

After initialisation, the working directory will be the `/Code` directory. Here one can place the scripts needed for analysis. In our case, we have decided to summarize and share all our scripts, created and applied objects and results (i.e. figures and tables) via a flattened directory structure created in the `/Sharing` directory. For this purpose a script, `analysisToShare.ENCORE4.r` was created. This script will flatten the directory structure that we initially used during the analysis to organise the data per category (i.e. Venn diagrams for genes, Venn diagrams for genesets, etc.) into separate directories and name these accordingly. To make the it all self-contained, the used scripts were also adapted to this new structure, i.e. file and directory location were adapted to reflect the new structure), so that the researcher could keep using the same scripts.  Finally, the information about the experiment, `ExpInfo.txt`, and the script needed to start the interactive R/Shiny app (`ui.r` and ` server.r`) were also located at the main directory.  
`analysisToShare.ENCORE4.r` takes the following arguments:  
- `projectDir` - The main directory, i.e. <ProjectName>, one level above the 'Processing' directory
- `dirToShare` - The analysis you want to share, i.e. <ProjectName>/Processing/DataAnalysisX or just DataAnalysisX (the first way allows you to just follow the path... less error-prone)
- `dataSetToShare` - The main data set you want to share (at the project level) (provide just  the name, NOT the path)
- `analysisDataToShare` - The data set at the analysis you want to share (provide just  the name, NOT the path)

A typical command would be:  
  `analysisToShare(projectDir = "20240624_ENCORE_RNASeq_Example/", dirToShare = "20240624_ENCORE_RNASeq_Example/Processing/20220613_Initial_Analysis/",
                   dataSetToShare = "RNASeq", analysisDataToShare = "RNASeq")`
