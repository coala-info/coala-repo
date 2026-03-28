# commec CWL Generation Report

## commec_screen

### Tool Description
Run Common Mechanism screening on an input FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ibbis-screening/common-mechanism
- **Package**: https://anaconda.org/channels/bioconda/packages/commec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/commec/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2026-01-23
- **GitHub**: https://github.com/ibbis-screening/common-mechanism
- **Stars**: N/A
### Original Help Text
```text
usage: commec screen [-h] [-d DATABASE_DIR] [-y CONFIG_YAML] [-v] [--skip-tx]
                     [--skip-nt] [-p {blastx,diamond}] [-f] [-n] [-t THREADS]
                     [-j DIAMOND_JOBS] [-o OUTPUT_PREFIX] [-c] [-F | -R]
                     fasta_file

Run Common Mechanism screening on an input FASTA.

positional arguments:
  fasta_file            FASTA file to screen

options:
  -h, --help            show this help message and exit
  -d, --databases DATABASE_DIR
                        Path to directory containing reference databases (e.g.
                        taxonomy, protein, HMM)
  -y, --config CONFIG_YAML
                        Configuration for screen run in YAML format, including
                        custom database paths
  -v, --verbose         Output verbose (i.e. DEBUG-level) logs

Screen run logic:
  --skip-tx             Skip taxonomy homology search (only toxins and other
                        proteins included in the biorisk database will be
                        flagged)
  --skip-nt             Skip nucleotide search (regulated pathogens will only
                        be identified based on biorisk database and protein
                        hits)
  -p, --protein-search-tool {blastx,diamond}
                        Tool for protein homology search to identify regulated
                        pathogens
  -f, --fast-mode       (DEPRECATED: legacy commands for --fast-mode, please
                        use --skip-tx to skip the taxonomy step instead.)
  -n                    (DEPRECATED: shorthand for --skip-nt, use --skip-nt
                        instead.)

Parallelisation:
  -t, --threads THREADS
                        Number of CPU threads to use. Passed to search tools.
  -j, --diamond-jobs DIAMOND_JOBS
                        Diamond-only: number of runs to do in parallel on
                        split Diamond databases

Output file handling:
  -o, --output OUTPUT_PREFIX
                        Prefix for output files. Can be a string (interpreted
                        as output basename) or a directory (files will be
                        output there, names will be determined from input
                        FASTA)
  -c, --cleanup         Delete intermediate output files for this Screen run
  -F, --force           Overwrite any pre-existing output for this Screen run
                        (cannot be used with --resume)
  -R, --resume          Re-use any pre-existing output for this Screen run
                        (cannot be used with --force)
```


## commec_flag

### Tool Description
Parse all .screen, or .json files in a directory and create CSVs of flags raised

### Metadata
- **Docker Image**: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ibbis-screening/common-mechanism
- **Package**: https://anaconda.org/channels/bioconda/packages/commec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: commec flag [-h] [-r] [-o OUTPUT] [-e] directory

Parse all .screen, or .json files in a directory and create CSVs of flags
raised

positional arguments:
  directory             Directory containing .screen files to summarize

options:
  -h, --help            show this help message and exit
  -r, --recursive       Search directory recursively for screen files
  -o, --output OUTPUT   Output directory name (defaults to directory if not
                        provided)
  -e, --evalportal-format
                        Output format compatible with the IBBIS sceening
                        evaluation portal
```


## commec_split

### Tool Description
Split a multi-record FASTA file into individual files, one for each record

### Metadata
- **Docker Image**: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ibbis-screening/common-mechanism
- **Package**: https://anaconda.org/channels/bioconda/packages/commec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: commec split [-h] fasta_file

Split a multi-record FASTA file into individual files, one for each record

positional arguments:
  fasta_file  Input fasta file

options:
  -h, --help  show this help message and exit
```


## commec_setup

### Tool Description
This script will help download the mandatory databases required for using Commec Screen, and requires a stable internet connection, wget, and update_blastdb.pl. This setup is split over 3 steps: 1. Specify download location. 2. Choose which databases to download. 3. Confirm and start downloads.

### Metadata
- **Docker Image**: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ibbis-screening/common-mechanism
- **Package**: https://anaconda.org/channels/bioconda/packages/commec/overview
- **Validation**: PASS

### Original Help Text
```text
Welcome to

 ██████╗ ██████╗ ███╗   ███╗███╗   ███╗███████╗ ██████╗ [38;5;202m         ▄▄               [0m
██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔════╝██╔════╝ [38;5;202m       ▄███▌              [0m
██║     ██║   ██║██╔████╔██║██╔████╔██║█████╗  ██║      [38;5;202m      ▐█████              [0m
██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══╝  ██║      [38;5;202m     ▐██████▌             [0m
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║███████╗╚██████╗ [38;5;202m     ███████▌             [0m
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝ ╚═════╝ [38;5;202m    ▐███████▌             [0m
[48;5;17m█ █████▄ █████▄ █ ▄█▀█▄                                 [38;5;202m     ███████   ▄█▄      [0m
[48;5;17m█ █    █ █    █ █ █   ▀          DATABASE               [38;5;202m      █████▌  ▄███▄▄     [0m  
[48;5;17m█ █████▄ █████▄ █ ▀███▄            SETUP                [38;5;202m      ▐█████▄██▀    ▀▄    [0m   
[48;5;17m█ █    █ █    █ █ ▄   █              UTILITY            [38;5;202m      ▐████████       ▌  [0m
[48;5;17m█ █████▀ █████▀ █ ▀█▄█▀                                 [38;5;202m      ████████▀         [0m
                                                        [38;5;202m   ▄▄██████▀▀             [0m
                                                        [38;5;202m ▀▀                       [0m
                 The Common Mechanism! 

International Biosecurity and Biosafety Initiative for Science 
Copyright © 2021-2024  

This script will help download the mandatory databases  
required for using Commec Screen, and requires a stable 
internet connection, wget, and update_blastdb.pl. 

This setup is split over 3 steps: 
 1. Specify download location. 
 2. Choose which databases to download. 
 3. Confirm and start downloads.
[38;5;202m Instructions: 
 -> You can exit this setup at any time with "exit"
 -> You can return to a previous step with "back"
 -> You can get additional help at each step with "help"[0m

[38;5;242mChecking for wget, and update_blastdb[0m

[38;5;17m*----------------*[0m Step  1  [38;5;17m*-------------------*[0m

Please provide the absolute or relative filepath to where you would like the Commec databases to be located... 
Press <Enter> to use existing:  commec-dbs/
>>>
```


## Metadata
- **Skill**: generated
