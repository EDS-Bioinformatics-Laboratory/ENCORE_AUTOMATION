# ENCORE-repseq-template

ENCORE template for repertoire sequencing support projects.

Authors:

* Barbera van Schaik, b.d.vanschaik@amsterdamumc.nl
* Prof Antoine van Kampen, a.h.vankampen@amsterdamumc.nl

## Description

Sets up the ENCORE FSS directory structure for a new repertoire sequencing project and uploads the directory
to a remote storage system with rclone.

### How to run

* Fill out the ``config.yml`` file
* Run the python script: ``python SetupEncoreRepseq.py``
* or: ``python SetupEncoreRepseq.py -c myconfigfile.yml``

### SetupEncoreRepseq.py does the following:

* It will pull the latest version of the ENCORE git repository
* The directory "ENCORE" is renamed to the name of the project (the sequence run)
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
