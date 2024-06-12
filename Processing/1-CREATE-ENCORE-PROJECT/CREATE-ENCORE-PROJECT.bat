echo off
cls
echo %time%

rem ==============================================================================================================================
rem This batch script will create an ENCORE project on your local harddisk at the location where you 
rem run this batch script. It will also create a GitHub repository for your project and link it to the
rem \Processing directory.
 
rem VERSION 1.0
rem 15 May 2024
rem WINDOWS BATCH FILE 

rem Execute this batch file from the Windows command prompt at the location where you wish to
rem create your project directory. 
rem see https://www.wikihow.com/Run-a-Batch-File-from-the-Command-Line-on-Windows

rem ISSUES
rem -Topics are not created for the GitHub repository

rem ==============================================================================================================================



rem ==========================================
rem SET GITBASH LOCATION
rem ==========================================
rem This script makes use of GITBASH
rem See https://git-scm.com/download/win
rem Set the location of the bash executable
set GITBASH="C:\Program Files\Git\bin\bash.exe" -c
rem ==========================================



rem ==========================================
rem PROVIDE YOUR PROJECT INFORMATION
rem ==========================================

rem Set your GitHub token (use a classic token)
rem See https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
set TOKEN=<YOUR TOKEN>

rem The next three items will appear in the description of the GitHub repository that will be created.
rem Thus, YOUR_NAME is not the GitHub username.
set YOUR_NAME=John Doe
set PROJECT_DESCRIPTION=Research Project
set HOME_PAGE=https://www.bioinformaticslaboratory.eu

rem Use this URL if the GitHub repository is part of an institutional account (in this case (EDS-Bionformatics-Laboratory)
rem See https://docs.github.com/en/rest/quickstart?apiVersion=2022-11-28
set REPO=https://api.github.com/orgs/EDS-Bioinformatics-Laboratory/repos

rem Use this URL is the GitHub repository should reside under your personal GitHub account.
rem REPO=https://api.github.com/user/repos

rem Name of GitHub repository
set REPO_NAME=PROJECT_REPO

rem Software License associated with GitHub repository
set LICENSE=gpl-2.0

rem ENCORE Project name (directory) on local harddisk
set PROJECT_NAME=20240514_PROJECTNAME





rem ==========================================
rem DO NOT EDIT BELOW
rem ==========================================

echo on
echo CLONE ENCORE TEMPLATE

%GITBASH% 'git clone https://github.com/EDS-Bioinformatics-Laboratory/ENCORE %PROJECT_NAME%'
chdir %PROJECT_NAME% 

rmdir /q /s .git
chdir Processing
copy gitignore-FSS-template.txt .gitignore

rem GOTO END

rem Write github.txt
echo # > github.txt  
echo # Information about GitHub repository and git. >>github.txt
echo # >>github.txt
echo # For general instructions about the use of Git and GitHub see the >>github.txt
echo # latest version of Step-by-Step-ENCORE guide in the root of the FSS. >>github.txt
echo # >>github.txt
echo. >>github.txt
echo. >>github.txt
echo ### URL of github repository #### >>github.txt
echo https://github.com/EDS-Bioinformatics-Laboratory/%REPO_NAME%.git >>github.txt
echo. >>github.txt
echo. >>github.txt
echo #### Any other information you want to include about the use of git with this specific repository #### >>github.txt
echo. >>github.txt




rem Run curl command to create the repository
rem See https://curl.se/docs/faq.html
rem Note: for unknown reason, the topics (keywords) are not created. 
echo CREATE REPOSITORY ON GITHUB
curl -X POST -H "Authorization: token %TOKEN%" -d "{\"name\":\"%REPO_NAME%\", \"private\": true, \"description\":\"%YOUR_NAME%: %PROJECT_DESCRIPTION%\", \"homepage\":\"%HOME_PAGE%\", \"topics\":[\"research\", \"bioinformatics\", \"transcriptomics\"],\"has_issues\": \"true\", \"has_projects\": \"true\", \"license_template\":\"%LICENSE%\"}" %REPO%


echo LINK THE REPOSITORY TO YOUR LOCAL PROJECT
%GITBASH% 'git init'
%GITBASH% 'git remote add origin https://github.com/EDS-Bioinformatics-Laboratory/%REPO_NAME%.git'
%GITBASH% 'git pull origin main'

%GITBASH% 'git status'
%GITBASH% 'git add .'
%GITBASH% 'git commit -m "First commit of Processing directory"'
%GITBASH% 'git branch -M main'
%GITBASH% 'git push -u origin main'
%GITBASH% 'git status'

echo CONGRATULATIONS! YOU JUST CREATED YOUR ENCORE PROJECT AND GITHUB REPOSITORY.
echo %time%

rem :END
