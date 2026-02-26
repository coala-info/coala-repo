# suppa CWL Generation Report

## suppa_suppa.py

### Tool Description
SUPPA allows you to generate all the possible Alternative Splicing events from an annotation file, calculate the PSI values per event, calculate differential splicing across multiple conditions with replicates, and cluster events across conditions

### Metadata
- **Docker Image**: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
- **Homepage**: https://github.com/comprna/SUPPA
- **Package**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/suppa/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/comprna/SUPPA
- **Stars**: N/A
### Original Help Text
```text
usage: SUPPA [-h] [-v]
             {generateEvents,psiPerEvent,psiPerIsoform,diffSplice,clusterEvents,joinFiles} ...

Description:

SUPPA allows you to generate all the possible Alternative Splicing events from an annotation file, 
calculate the PSI values per event, calculate differential splicing across multiple conditions 
with replicates, and cluster events across conditions 
For further information, see the help of each subcommand.

positional arguments:
  {generateEvents,psiPerEvent,psiPerIsoform,diffSplice,clusterEvents,joinFiles}
    generateEvents      Calculates the Alternative Splicing events from an annotation file.
    psiPerEvent         Calculates the PSI value for each event previously generated.
    psiPerIsoform       Calculates the PSI value for each isoform.
    diffSplice          Calculates differentially spliced events across multiple conditions.
    clusterEvents       Calculates clusters of events across conditions.
    joinFiles           Join multiple tab separated files into a single file.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
```

