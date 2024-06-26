**CREATE-ENCORE-PROJECT**  

This directory contains a Windows batch file and a Unix/MacOS bash script to automatically initialize an ENCORE project: (i) create a local directory, (ii) create a repository on GitHub, (iii) link the \Processing directory to the GitHub repository

* CREATE-ENCORE-PROJECT.bat  (Windows Batch file)
* CREATE-ENCORE-PROJECT.sh (for Unix)  (Unix shell script)
* CREATE-ENCORE-PROJECT_macOS.sh (Unix shell script)



**Overview:**

This script automates the setup process for creating an ENCORE project on your local hard disk and linking it to a GitHub repository. It streamlines the creation of necessary directories, GitHub repository setup, and initialization of the local Git repository.



**Instructions:**

1. Review and modify the script's parameters according to your project requirements before execution.
2. Execute the script from the command line prompt at the desired location where you wish to create your project directory.
3. Open Command Prompt (Windows cmd or Unix shell).
4. Navigate to the directory where you want to create the ENCORE project.
5. Run the batch script by typing its name and pressing Enter.



**Parameters:**

- `YOUR TOKEN:` Your personal access token (classic). See also https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens. Alternatively, use a SSH key (see https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh)

- `YOUR_NAME`: Your name (not your GitHub account username).

- `PROJECT_DESCRIPTION`: Short description/title of the project.

- `HOME_PAGE`: URL of your research group/department.

- `REPO`: GitHub API URL for creating repositories. (see also See https://docs.github.com/en/rest/quickstart?apiVersion=2022-11-28)

- `REPO_NAME`: Name of the GitHub repository.

- `LICENSE`: Open-Source software license associated with the GitHub repository.

- `PROJECT_NAME`: Name of the ENCORE project directory on the local hard disk.

  

**Prerequisites:**

- [GITBASH](https://git-scm.com/download/win) must be installed. Required for executing Git commands within the script.

- GitHub account with a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) (classic token).

- Ensure appropriate permissions for creating repositories on GitHub.

  

**Issues:**

- Topics are not automatically created for the GitHub repository.



**Functionality of script:**

1. Clones the ENCORE template repository from GitHub.
2. Removes the `.git` directory from the cloned repository.
3. Copies `.gitignore` file to the Processing directory.
4. Writes repository information to `github.txt`.
5. Sends a POST request to create the GitHub repository.
6. Initializes the local Git repository, adds a remote origin, pulls from the main branch, and pushes the changes to the remote repository.



**Notes:**

- Ensure you have necessary permissions on your system and authentication tokens (use classic token), or ssh key for GitHub operations.
- The scripts create a private repository. To make a public repository, change the curl command in the script. 



**Testing:**

* The scripts have been tested on Windows 10 Enterprise (Version 10.0.19045 Build 19045), Windows 11 Pro (23H2, OS build 22631.3593), MacOS (Apple M1; mscOS Sonoma 14.4), and Linux (Debian 12; bookworm)

