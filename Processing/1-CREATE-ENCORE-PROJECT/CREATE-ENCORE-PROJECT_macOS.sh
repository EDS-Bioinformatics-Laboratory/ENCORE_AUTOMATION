#!/bin/bash

clear
echo $(date)

# ==============================================================================================================================
# This bash script will create an ENCORE project on your local harddisk at the location where you 
# run this bash script. It will also create a GitHub repository for your project and link it to the
# \Processing directory.
#
# VERSION 1.0
# 15 May 2024
# Unix/MacOS shell script 
#
# Execute this batch file from the Unix/MacOS command prompt at the location where you wish to
# create your project directory. 
#
# ISSUES
# -Topics are not created for the GitHub repository
#
# ==============================================================================================================================



# ==========================================
# PROVIDE YOUR PROJECT INFORMATION
# ==========================================

# Set your GitHub token (use a classic token)
# See https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
# for creating a classic token. When creating the token, enable to full 'scope' for this token.
TOKEN="YOUR TOKEN"

# The next three items will appear in the description of the GitHub repository that will be created.
# Thus, YOUR_NAME is not the GitHub username.
YOUR_NAME="John Doe"
PROJECT_DESCRIPTION="Research Project"
HOME_PAGE="https://www.bioinformaticslaboratory.eu"

# Use this URL if the GitHub repository is part of an institutional account (in this case (EDS-Bionformatics-Laboratory)
REPO="https://api.github.com/orgs/EDS-Bioinformatics-Laboratory/repos"

# Use this URL if the GitHub repository should reside under your personal GitHub account.
# REPO="https://api.github.com/user/repos"

# Name of GitHub repository
REPO_NAME="PROJECT_REPO"

# Software License associated with GitHub repository
LICENSE="gpl-2.0"

# ENCORE Project name (directory) on local harddisk
PROJECT_NAME="20240514_PROJECTNAME"





# ==========================================
# DO NOT EDIT BELOW
# ==========================================

echo "CLONE ENCORE TEMPLATE"

git clone https://github.com/EDS-Bioinformatics-Laboratory/ENCORE $PROJECT_NAME
cd $PROJECT_NAME

rm -rf .git
cd Processing
cp gitignore-FSS-template.txt .gitignore

# Write github.txt
echo "# Information about GitHub repository and git." > github.txt
echo "# For general instructions about the use of Git and GitHub see the" >> github.txt
echo "# latest version of Step-by-Step-ENCORE guide in the root of the FSS." >> github.txt
echo "" >> github.txt
echo "" >> github.txt
echo "### URL of github repository ####" >> github.txt
echo "https://github.com/EDS-Bioinformatics-Laboratory/$REPO_NAME.git" >> github.txt
echo "" >> github.txt
echo "" >> github.txt
echo "#### Any other information you want to include about the use of git with this specific repository ####" >> github.txt
echo "" >> github.txt

# Run curl command to create the repository
echo "CREATE REPOSITORY ON GITHUB"
curl -X POST -H "Authorization: token $TOKEN" -d "{\"name\":\"$REPO_NAME\", \"private\": true, \"description\":\"$YOUR_NAME: $PROJECT_DESCRIPTION\", \"homepage\":\"$HOME_PAGE\", \"topics\":[\"research\", \"bioinformatics\", \"transcriptomics\"],\"has_issues\": \"true\", \"has_projects\": \"true\", \"license_template\":\"$LICENSE\"}" $REPO

echo "LINK THE REPOSITORY TO YOUR LOCAL PROJECT"
git init
git remote add origin https://github.com/EDS-Bioinformatics-Laboratory/$REPO_NAME.git
git pull origin main

git status
git add .
git commit -m "First commit of Processing directory"
git branch -M main
git push -u origin main
git status

echo "CONGRATULATIONS! YOU JUST CREATED YOUR ENCORE PROJECT AND GITHUB REPOSITORY."
echo $(date)
