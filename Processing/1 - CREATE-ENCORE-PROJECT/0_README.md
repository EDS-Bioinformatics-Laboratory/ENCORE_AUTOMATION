**1-CREATE-ENCORE-PROJECT**  

This directory contains a Windows batch file and a Unix/MacOS bash script to automatically initialize an ENCORE project: (i) create a local directory, (ii) create a repository on GitHub, (iii) link the \Processing directory to the GitHub repository

* CREATE-ENCORE-PROJECT.bat
* CREATE-ENCORE-PROJECT.sh

**Use:** 

* Set values for the variables in the script

* Execute the script from the Windows or Unix prompt

**Dependencies:**

* These scripts do not depend on scripts/code in other directories. 

**Issues:**

* The current scripts do not create Topics
* The scripts create a private repository. To make a public repository, change the curl command in the script.

**Requirements:** 

* Git bash and curl should be installed on your system, and you should have credentials to create a repository on GitHub.

