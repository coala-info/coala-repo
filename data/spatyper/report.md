# spatyper CWL Generation Report

## spatyper_spaTyper

### Tool Description
Get spa types

### Metadata
- **Docker Image**: quay.io/biocontainers/spatyper:0.3.3--pyhdfd78af_3
- **Homepage**: https://github.com/HCGB-IGTP/spaTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/spatyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spatyper/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HCGB-IGTP/spaTyper
- **Stars**: N/A
### Original Help Text
```text
usage: spaTyper [-h] [-r REPEAT_FILE] [-o REPEAT_ORDER_FILE] [-d FOLDER]
                [-f FASTA [FASTA ...]] [-g GLOB] [-e] [--output OUTPUT]
                [--version] [--debug] [--info]

spaTyper.py: Get spa types

Version: 0.3.3
License: GPLv3

USAGE: python spaTyper.py -f fasta_file.fasta
Prints spa type to stdout

It will download sparepeats.fasta and spatypes.txt to repository directory 
if files not provided or already in directory. It can be loaded as a python
module. Python 3 version only.

optional arguments:
  -h, --help            show this help message and exit
  -r REPEAT_FILE, --repeat_file REPEAT_FILE
                        List of spa repeats
                        (http://spa.ridom.de/dynamic/sparepeats.fasta)
  -o REPEAT_ORDER_FILE, --repeat_order_file REPEAT_ORDER_FILE
                        List spa types and order of repeats
                        (http://spa.ridom.de/dynamic/spatypes.txt)
  -d FOLDER, --folder FOLDER
                        Folder to save downloaded files from Ridom/Spa server
  -f FASTA [FASTA ...], --fasta FASTA [FASTA ...]
                        List of one or more fasta files.
  -g GLOB, --glob GLOB  Uses unix style pathname expansion to run spa typing
                        on all files. If your shell autoexpands wildcards use
                        -f.
  -e, --do_enrich       Do PCR product enrichment. [Default: False]
  --output OUTPUT       Provide a name for the output file. Default: Standard
                        out
  --version             show program's version number and exit
  --debug               Developer messages
  --info                Prints additional information

Original code: mjsull. Modified by: JFSanchezHerrero
```

