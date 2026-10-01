startNewRepo <- function(dirName, analysisDir="DataAnalysis", workflowType="RNASeq"){
  # where are we?
  baseDir <- getwd()
  
  # Create the new directory
  dir.create(dirName)
  
  # Cloning a complete repository will work
  system('git clone https://github.com/EDS-Bioinformatics-Laboratory/ENCORE ENCORE')
  
  # And we could now restructure it, i.e. remove the top layer by moving the 'ddmmyy_ProjectName' directory to our new ProjectName
  
  # https://www.datanovia.com/en/blog/how-to-easily-manipulate-files-and-directories-in-r/
  #library(fs)
  
  file.copy("./ENCORE/.",dirName, recursive = TRUE)
  
  # And get to the source directory of the project
  print("Now moving into the new directory ...")
  setwd(dirName)
  
  # Now move the Data to the right directory in the FSS, i.e. toplevel 'Data'
  if ( dir.exists("../Data") ){
    dataToMove <- list.dirs('../Data', full.names = FALSE, recursive = FALSE)
    setwd("../Data")
    
    for (f in dataToMove){
      folder_old_path = "../Data"
      # If it is a RNASeq project, i.e. workflowType="RNASeq", already rename it
      if (workflowType=="RNASeq"){
        path_new = paste0("../", dirName,"/Data/RNASeq/Processed/")
      } else {
        path_new = paste0("../", dirName,"/Data/NameOfDataset_1/Processed/")
      }
      file.copy(from = folder_old_path, to = path_new, 
                overwrite = TRUE, recursive = TRUE, copy.mode = TRUE)
    }
    setwd(paste0("../", dirName,"/"))
    
    # And remove the original Data folder
    system('rm -rf ../Data')
  }
  
  # Do your analysis
  setwd("Processing/")
  analysisDir <- paste(format(Sys.time(), "%Y%m%d"),analysisDir,sep="_")
  file.rename("NameOfComputation_1/", analysisDir)
  setwd(paste0(analysisDir,"/Code"))
  
  # Remove the original 'ENCORE' directory
  succes = 1
  while (succes > 0){
    unlink(paste0(baseDir,"/ENCORE"), recursive=TRUE, force=TRUE)
    if (!("ENCORE" %in% dir(baseDir))) {
      print("Removed the initial ENCORE folder ...")
      succes = 0
    }
    Sys.sleep(2)
  }
  
  # Automation
  if (workflowType == "RNASeq"){
    # Fill 0_PROJECT.md/Navigation.conf
    projectTxt <- readLines(paste0(baseDir,"/",dirName,"/0_PROJECT.md"))
    idx <- which(grepl("TEMPLATE STARTS HERE", projectTxt))
    projectTxt <- projectTxt[(idx+1):length(projectTxt)]
    projectTxt <- gsub("\\*\\*Project title:\\*\\*", "\\*\\*Project title:\\*\\*\tRNASeq analysis using standard workflow", projectTxt)
    projectTxt <- gsub("\\*\\*Project start date:\\*\\*", paste0("\\*\\*Project start date:\\*\\*\t",format(Sys.time(), "%d-%m-%Y")), projectTxt)
    writeLines(projectTxt, con=paste0(baseDir,"/",dirName,"/0_PROJECT.md"))
    
    navigationTxt <- readLines(paste0(baseDir,"/",dirName,"/Navigation.conf"))
    navigationTxt <- gsub("ProjectTitle = ", "ProjectTitle = RNASeq analysis using standard workflow", navigationTxt)
    writeLines(navigationTxt, con=paste0(baseDir,"/",dirName,"/Navigation.conf"))
    
    # Get LabJournal.docx (.md?)
    file.copy("D:/Dropbox/Support/20240624_ENCORE_RNASeq_Example/ProjectDocumentation/LabJournal.docx",paste0(baseDir,"/",dirName,"/ProjectDocumentation/LabJournal.docx"))

    # Get the first scripts?
    # Ideally, these scripts should come from GitHub, now they are specific for the analysis performed for David Trampert!!
    # Perhaps, I should make the script also more generic (as I tried to do for the scRNASeq, i.e. have an 'analysis.r' script calling the
    # individual steps with some parameter settings. Which can be stored in a 'config' file??)
    for (f in list.files("D:/Dropbox/Support/20240624_ENCORE_RNASeq_Example/Processing/20220613_Initial_Analysis/Code/", pattern = "0.*", full.names = TRUE)){
      file.copy(f,paste0(baseDir,"/",dirName,"/Processing/", analysisDir,"/Code"))
    }
    
    # Also copy the 'analysis.r' that sources all the other scripts
    # Have this script call/initiate renv??
    file.copy("D:/Dropbox/Support/20240624_ENCORE_RNASeq_Example/Processing/20220613_Initial_Analysis/Code/analysis.r",paste0(baseDir,"/",dirName,"/Processing/", analysisDir,"/Code"))
    
  }
}

startNewAnalysis <- function(analysisDir="DataAnalysis"){
  # Make sure you're in the 'Processing' directory within the main projectDir
  if ( basename(getwd()) != "Processing"){
    print("To create a new analysis directory, you should be in the \'Processing\' directory ...")
    # We assume that the directory structure follows our FSS .. :-)
    # Should we not just create all of this??
    break()
  }
  
  # Clone a complete FSS structure into this directory
  system('git clone https://github.com/EDS-Bioinformatics-Laboratory/ENCORE ENCORE')
  
  # Add the time in the right format
  analysisDir <- paste(format(Sys.time(), "%Y%m%d"),analysisDir,sep="_")
  file.rename("./ENCORE/Processing/NameOfComputation_1",analysisDir)
  
  # And remove the repo
  # Remove the original 'ENCORE' directory
  succes = 1
  while (succes > 0){
    unlink("ENCORE", recursive=TRUE, force=TRUE)
    if (!("ENCORE" %in% dir())) {
      print("Removed the initial ENCORE folder ...")
      succes = 0
    }
  }

  # And get to the source directory of the project
  setwd(paste0(analysisDir, "/Code"))
  
  # And give some information
  if (succes == 0 & basename(getwd()) == "Code"){
    print("The directory has been succesfully created and the working directory has been set to the \'Code\' directory!!")
  }
  
  
}


pushToRepo <- function(branchName="supportProject", branchComment="A new support project has been finished!"){
  # And push everything to GitHub
  # Have to think about the organization:
  # - I could create a 'Support_RNASeq' repository and then push everything into that one 
  #   (just make the repository once, all support projects will be a seperate directory)
  #   DECIDED with BioLab on 20210218!!
  #   Put every projct in a separate branch!!  
  # - Or create a a separate repository for every project...
  #
  # My preference is for the first one..
  
  # Where do I put my .git?
  # How can I name the directory on GitHub under the 'Support_RNASeq' level?
  # - i.e. if I put the .git in the directory above 'Code', then every support project is going to be called 'Code' ...
  # Only put the R code into GitHub, so get a .gitignore that filters everything else
  
  # First clone the Support_RNASeq repo
  system('git clone https://github.com/EDS-Bioinformatics-Laboratory/Support_RNASeq D://Data/Dropbox/Support_RNASeq_GitHub')
  
  fileConn <- file("./Code/.gitignore")
  myRules <- paste0("# Blacklist files/folders in same directory as the .gitignore file\n/*\n",
                    "# Whitelist some files\n!.gitignore\n!*.r\n!*.R\n")
  writeLines(myRules, fileConn)
  close(fileConn)
  
  system('git init')
  system('git add Code')
  
  system(paste0('git commit -m ', paste0(branchComment, collapse=" ")))
  
  system(paste0('git checkout -b ',branchName))
  # Create a new branch within the repo on GitHub
  # - but you don't want to add the Personal Access Token hardcoded!!
  # So, see: https://www.r-bloggers.com/2020/07/a-better-way-to-manage-your-github-personal-access-tokens/
  library(credentials)
  if ( credentials::git_credential_ask("https://github.com")$username == "PersonalAccessToken" ){
    myPAT <- credentials::git_credential_ask("https://github.com")$password
  }
  system(paste0("curl -H \'Authorization: token ", myPAT,"\' https://api.github.com/user/repos -d \'{\"name\":\"Support_RNASeq.git\"}\'"))
  #
  system('git remote add origin https://github.com/aldojongejan/Support_RNASeq.git')
  system(paste0('git push -u origin ', branchName))
  system(paste0('git push origin ' ,branchName))
}