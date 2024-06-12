import subprocess
import argparse
import yaml
import datetime
import os
import shutil


def readConfig(f):
    '''
    Description: read config.yml
    :param f: filename, config.yml
    :return: data (dict)
    '''
    try:
        fh = open(f, "r")
        stream = fh.read()
        fh.close()
    except:
        print("cannot open file:", f)
        exit()
    data = yaml.load(stream, Loader=yaml.Loader)
    return(data)


def executeCommand(command, cwd = "."):
    '''
    Description: execute a shell command from a certain work directory
    :param command: the command (str)
    :param cwd: working directory, default is the current directory
    :return: nothing
    '''
    command = command.split()
    print(command)
    process = subprocess.run(command, cwd=cwd)
    if process.returncode == 0:
        print("SUCCESS")
    else:
        print("FAILED")
        exit()


def cloneEncore(config):
    '''
    Description: clone ENCORE from git, rename the directory, and some sub directories
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    encore = config["git"]["encore"]
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    command = "git clone " + encore
    executeCommand(command)

    command = "mv ENCORE/ " + run
    executeCommand(command)

    command = "rm -rf " + run + "/.git/"
    executeCommand(command)

    command = "mv " + run + "/Processing/NameOfComputation_1/ " + run + "/Processing/" + outdir + "/"
    executeCommand(command)


def createGitBranch(config):
    '''
    Description: clone RESEDA from git, create a separate branch for the analysis
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    reseda = config["git"]["reseda"]
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    command = "git clone " + reseda
    executeCommand(command)

    command = "git branch " + run
    executeCommand(command, cwd="reseda")

    command = "git checkout " + run
    executeCommand(command, cwd="reseda")

    try:
        shutil.rmtree(run + "/Processing/" + outdir + "/Code")
    except:
        print("Couldn't remove dir: " + run + "/Processing/" + outdir + "/Code")
        exit()

    command = "mv reseda " + run + "/Processing/" + outdir + "/Code"
    executeCommand(command)


def addProjectReadme(config):
    '''
    Description: Fill out project description
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]

    # read template
    fh = open("templates/0_PROJECT.md")
    text = fh.read()
    fh.close()

    # Fill out project name (run name) and add date
    text = text.replace("<RUN>", run)
    today = datetime.date.today()
    text = text.replace("<TODAY>", today.strftime("%d-%m-%Y"))

    fhOut = open(run + "/0_PROJECT.md", "w")
    print(text, file=fhOut)
    fhOut.close()


def addGettingStarted(config):
    '''
    Description: Fill out getting started template
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    # read template
    fh = open("templates/0_GETTINGSTARTED.txt")
    text = fh.read()
    fh.close()

    # Fill out the template
    text = text.replace("<OUTDIR>", outdir)

    # Write the file to the FSS directory
    fhOut = open(run + "/0_GETTINGSTARTED.txt", "w")
    print(text, file=fhOut)
    fhOut.close()


def addReadmeData(config):
    '''
    Description: Fill out readme of the Data directory
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    machine = config["sequence_run"]["machine"]
    collaborator = config["people"]["collaborator"]
    lab_contact = config["people"]["laboratory_contact"]

    # read template
    fh = open("templates/0_README_data.md")
    text = fh.read()
    fh.close()

    # Fill out the template
    text = text.replace("<MACHINE>", machine)
    text = text.replace("<COLLABORATOR>", collaborator)
    text = text.replace("<LAB_CONTACT>", lab_contact)

    # Write the file to the FSS directory
    fhOut = open(run + "/Data/0_README.md", "w")
    print(text, file=fhOut)
    fhOut.close()



def addGitInfo(config):
    '''
    Description: Add reseda repository to git file
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]

    # read template
    fh = open("templates/github.md")
    text = fh.read()
    fh.close()

    # Fill out github information
    text = text.replace("<RUN>", run)

    # Write the file to the FSS directory
    fhOut = open(run + "/Processing/github.md", "w")
    print(text, file=fhOut)
    fhOut.close()

    # And again
    fhOut = open(run + "/Processing/github.txt", "w")
    print(text, file=fhOut)
    fhOut.close()


def addReadmeProcessing(config):
    '''
    Description: fill out the readme of the Processing directory
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]
    bioinformatician = config["people"]["bioinformatician"]

    # read template
    fh = open("templates/README_processing.md")
    text = fh.read()
    fh.close()

    # Fill out template
    text = text.replace("<RUN>", run)
    text = text.replace("<OUTDIR>", outdir)
    text = text.replace("<BIOINFORMATICIAN>", bioinformatician)

    # Write the file to the FSS directory
    fhOut = open(run + "/Processing/README.md", "w")
    print(text, file=fhOut)
    fhOut.close()


def addReadmeComputation(config):
    '''
    Description: fill out readme about the computation(s)
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    # read template
    fh = open("templates/0_README_processing-computation.md")
    text = fh.read()
    fh.close()

    # Fill out template
    text = text.replace("<RUN>", run)
    text = text.replace("<OUTDIR>", outdir)

    # Write the file to the FSS directory
    fhOut = open(run + "/Processing/" + outdir + "/0_README.md", "w")
    print(text, file=fhOut)
    fhOut.close()


def addReadmeProcessingResults(config):
    '''
     Description: fill out readme about the analysis results
     :param config: config (dict) from config.yml
     :return: nothing
     '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    # read template
    fh = open("templates/0_README_processing-results.md")
    text = fh.read()
    fh.close()

    # Fill out template
    text = text.replace("<RUN>", run)

    # Write the file to the FSS directory
    fhOut = open(run + "/Processing/" + outdir + "/Results/0_README.md", "w")
    print(text, file=fhOut)
    fhOut.close()


def removeUnused(config):
    '''
    Description: remove unused files and directories
    Parameters
    ----------
    config: config (dict) from config.yml
    Returns: nothing
    -------
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    outdir = config["sequence_run"]["outdir"]

    # Remove directories
    shutil.rmtree(run + "/Sharing/")
    shutil.rmtree(run + "/Processing/Data/")
    shutil.rmtree(run + "/Processing/" + outdir + "/Data")

    # Remove .git from Code directory, unless Barbera is running this script
    if os.getlogin() != "barbera" and "schaik" not in os.getlogin():
        shutil.rmtree(run + "/Processing/" + outdir + "/Code/.git/")

    # Rename gitignore-FSS-template.txt to .gitignore
    command = "mv " + run + "/Processing/gitignore-FSS-template.txt " + run + "/Processing/.gitignore"
    executeCommand(command)

    # Remove specific unused files
    myfiles = ["0_GETTINGSTARTED.docx", "0_GETTINGSTARTED.html", "0_GETTINGSTARTED.tex"]
    for myfile in myfiles:
        os.remove(run + "/" + myfile)


def uploadFSS(config):
    '''
    Description: uploads the FSS directory with rclone to a remote storage server
    :param config: config (dict) from config.yml
    :return: nothing
    '''
    # Required variables from config
    run = config["sequence_run"]["run"]
    rclone_root = config["storage"]["rclone_root"]

    # Upload the directory
    command = "rclone copy " + run + " " + rclone_root + run
    executeCommand(command)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Create ENCORE project for a repertoire sequencing support project, optionally create a new git branch')
    parser.add_argument('-c', '--config', default='config.yml', type=str, help='Configuration file (default: %(default)s)')
    args = parser.parse_args()

    # Read configuration file
    config = readConfig(args.config)

    # Clone and setup ENCORE locally
    cloneEncore(config)

    # Pull Reseda repository and create a branch for this specific dataset
    createGitBranch(config)

    # Fill out README files and put these in the correct folder
    addProjectReadme(config)
    addGettingStarted(config)
    addReadmeData(config)
    addGitInfo(config)
    addReadmeProcessing(config)
    addReadmeComputation(config)
    addReadmeProcessingResults(config)

    # Remove directories and files that are not used
    removeUnused(config)

    # Upload the FSS directory to a remote storage place (in this case a webdav server was configured)
    uploadFSS(config)

    print("FINISHED")
