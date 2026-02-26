# bracken CWL Generation Report

## bracken

### Tool Description
Estimates the abundance of organisms in a metagenomic sample using Kraken and Bracken.

### Metadata
- **Docker Image**: quay.io/biocontainers/bracken:3.1--h9948957_0
- **Homepage**: https://github.com/jenniferlu717/Bracken
- **Package**: https://anaconda.org/channels/bioconda/packages/bracken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bracken/overview
- **Total Downloads**: 105.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jenniferlu717/Bracken
- **Stars**: N/A
### Original Help Text
```text
Usage: bracken -v -d MY_DB -i INPUT -o OUTPUT -w OUTREPORT -r READ_LEN -l LEVEL -t THRESHOLD
  -v             Echoes the current software version and exits
  MY_DB          location of Kraken database
  INPUT          Kraken REPORT file to use for abundance estimation
  OUTPUT         file name for Bracken default output
  OUTREPORT      New Kraken REPORT output file with Bracken read estimates
  READ_LEN       read length to get all classifications for (default: 100)
  LEVEL          level to estimate abundance at [options: D,P,C,O,F,G,S,S1,etc] (default: S)
  THRESHOLD      number of reads required PRIOR to abundance estimation to perform reestimation (default: 0)
```

