# rrmscorer CWL Generation Report

## rrmscorer

### Tool Description
RRM-RNA scoring version 1.0.11

### Metadata
- **Docker Image**: quay.io/biocontainers/rrmscorer:1.0.11--pyhdfd78af_0
- **Homepage**: https://bio2byte.be/rrmscorer/
- **Package**: https://anaconda.org/channels/bioconda/packages/rrmscorer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rrmscorer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Executing rrmscorer version 1.0.11.
usage: rrmscorer [-h] (-u UNIPROT_ID | -f /path/to/input.fasta)
                 (-r RNA_SEQUENCE | -t) [-w N] [-j /path/to/output]
                 [-c /path/to/output] [-p /path/to/output]
                 [-a /path/to/output] [--x_min X_MIN] [--x_max X_MAX]
                 [--title TITLE] [--wrap-title] [--adjust-scores] [-v]

RRM-RNA scoring version 1.0.11

optional arguments:
  -h, --help            show this help message and exit
  -u UNIPROT_ID, --uniprot UNIPROT_ID
                        UniProt identifier
  -f /path/to/input.fasta, --fasta /path/to/input.fasta
                        Fasta file path
  -r RNA_SEQUENCE, --rna RNA_SEQUENCE
                        RNA sequence
  -t, --top             To find the top scoring RNA fragments
  -w N, --window_size N
                        The window size to test
  -j /path/to/output, --json /path/to/output
                        Store the results in a json file in the declared
                        directory path
  -c /path/to/output, --csv /path/to/output
                        Store the results in a CSV file in the declared
                        directory path
  -p /path/to/output, --plot /path/to/output
                        Store the plots in the declared directory path
  -a /path/to/output, --aligned /path/to/output
                        Store the aligned sequences in the declared directory
                        path
  --x_min X_MIN         Minimum value for x-axis in plots (default: -0.9)
  --x_max X_MAX         Maximum value for x-axis in plots (default: 1.0)
  --title TITLE         Title for the generated plots
  --wrap-title          Wrap long titles to multiple lines
  --adjust-scores       Add 0.89 to scores to better separate training and
                        randomized regions (positive scores indicate likely
                        binders, negative scores indicate less likely binders)
  -v, --version         show RRM-RNA scoring version number and exit
```


## Metadata
- **Skill**: generated
