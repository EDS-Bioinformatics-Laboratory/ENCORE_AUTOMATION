# ENCORE AIRRseq Template

ENCORE template for repertoire sequencing ([AIRRseq](https://www.antibodysociety.org/about/)) support projects. AIRRseq, or Adaptive Immune Receptor Repertoire sequencing, is a high-throughput sequencing technology used to analyze the diversity and specificity of B-cell and T-cell receptor repertoires in the immune system. It enables the study of immune responses, disease mechanisms, and the development of immunotherapies by providing detailed insights into the adaptive immune system's receptor sequences.

The Bioinformatics Laboratory has developed RESEDA (REpertoire SEquencing Data Analysis), which is a data analysis workflow for T- and B-cell receptor repertoire sequencing. The workflow identifies clones and their frequency from next generation sequencing of repertoires and includes steps for quality control and bias correction.

<u>Authors</u>

* Barbera van Schaik, b.d.vanschaik@amsterdamumc.nl
* Prof Antoine van Kampen, a.h.vankampen@amsterdamumc.nl

## Description

Sets up an Repertoire Sequencing (AIRRseq) project using the [ENCORE template](https://github.com/EDS-Bioinformatics-Laboratory/ENCORE) and [RESEDA](https://github.com/EDS-Bioinformatics-Laboratory/reseda) analysis pipeline. Optionally, it will upload the new  ENCOREs project to a remote storage system with [rclone](https://rclone.org/).

### How to run

* Complete the ``config.yml`` file
* Run the python script: ``python SetupEncoreRepseq.py``
* or: ``python SetupEncoreRepseq.py -c myconfigfile.yml``

### SetupEncoreRepseq.py does the following:

* It will pull the latest version of the ENCORE template from its Git repository
* The directory "ENCORE" is renamed to the name of the project (the sequence run)
* It pulls the RESEDA repository and create a branch for this specific dataset. Next it adds the RESEDA code to the \Processing directory of the ENCORE directory.
* The ".git" sub directory is removed
* In the Processing directory the name of computation is renamed to the "outdir" that is specified in config.yml
* All the README files are filled out and placed in the corresponding FSS directory (templates are located in the "templates" directory)
* The directory is uploaded to a remote storage system when rclone is configured correctly (see below for an example of an owncloud based webdav server)

## Dependencies

The dependencies can be installed using Conda

```commandline
conda env create -f ENV.yml
```

Python libraries:

* subprocess
* argparse
* yaml
* datetime
* os
* shutil

Other software:

* git
* rclone
* pandoc

## Rclone configuration

Run: ``rclone config``

```
name> remote
Storage> webdav
url> https://researchdrive.surfsara.nl/remote.php/nonshib-webdav
vendor> owncloud
```

Note that many storage systems are supported by rclone, such as, Dropbox, Google drive, etc
