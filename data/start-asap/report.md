# start-asap CWL Generation Report

## start-asap

### Tool Description
Create a config.xml file for the ASA3P pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/start-asap:1.3.0--0
- **Homepage**: http://github.com/quadram-institute-bioscience/start-asap/
- **Package**: https://anaconda.org/channels/bioconda/packages/start-asap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/start-asap/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/start-asap
- **Stars**: N/A
### Original Help Text
```text
NAME
    start-asap.pl - Create a config.xml file for the ASA3P pipeline

AUTHOR
    Andrea Telatin <andrea.telatin@quadram.ac.uk>

SYNOPSIS
       start-asap.pl -i READS_DIR -r REFERENCE_FILE -o OUTPUT_DIR [-p JSON_FILE | -g GENUS -s SPECIES ...]

DESCRIPTION
    Prepare the input directory for 'ASA3P', creating automatically a
    _config.xls_ file from the reads provided. Requires one or more
    reference files (.gbk recommended) and a directory with FASTQ files (.fq
    or .fastq, gzipped). Metadata can be supplied via command line or with a
    JSON file.

MAIN PARAMETERS
    *-i*, *--input-dir* DIRECTORY
        Directory containing the raw reads in FASTQ format.

    *-r*, *--reference* FILE
        Reference file in FASTA or GBK format (other formats are supported
        by ASA3P, but have not been tested)

    *-o*, *--output-dir* DIRECTORY
        Project directory that will be the input of ASA3P. Will be created
        if not exists and a "config.xml" file will be placed there. The
        directory will contain a "data" subdirectory, left empty by default.

    *-c*, *--copy-files*
        Place a copy of the reads and reference files in the "./data"
        subdirectory.

    *--force*
        Remove the content of the output directory, if a config file is
        found.

    *-ft*, *--for-tag* STRING
        String denoting the file is a Forward file (default: "_R1").

    *-rt*, *--rev-tag* STRING
        String denoting the file is a Reverse file (default: "_R2")

    *-it*, *--id-separator* STRING
        The sample ID will determined splitting the name at the separator
        (default: "_").

    project metadata: See the METADATA section

METADATA
    For each project the following metadata is required, that can be
    provided either from the command line or with a JSON file like the
    following. Not al the lines need to be added, if the defaults are fine
    (eg: for-tag, rev-tag):

       {
          "user_name" : "Andrea",
          "user_mail" : "info@example.com",
          "user_surname" : "Telatin",
          "project_name": "MaxiSeq",
          "project_description" : "Resequencing of 1230 E. coli isolates",
          "genus" : "Escherichia",
          "species": "coli",
          "project_name" : "Example project",
          "for_tag": "_1",
          "rev_tag": "_2",


       }

    *-p*, *--project-info* JSON_FILE
        A JSON file with project metadata.

    Alternatively (will override JSON metadata):

    *--genus* STRING
        Genus of the bacteria

    *--species* STRING
        Species of the bacteria

    *--project-name* STRING
        Project code name

    *--project-description* STRING
        A description for the project

    *--user-name* STRING
        First name of the project customer

    *--user-surname* STRING
        Last name of the project customer

    *--user-mail* STRING
        Email address name of the project customer

BUGS
    Open an issue in the GitHub repository
    <https://github.com/quadram-institute-bioscience/start-asap/issues>.

COPYRIGHT
    Copyright (C) 2019-2020 Andrea Telatin

    This program is free software distributed under the MIT licence.
```

