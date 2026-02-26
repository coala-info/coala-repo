# pmmrcalculator CWL Generation Report

## pmmrcalculator

### Tool Description
Calculate the pairwise mismatch rate of genotyped between all individuals in the input eigenstrat dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/pmmrcalculator:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/TCLamnidis/pMMRCalculator
- **Package**: https://anaconda.org/channels/bioconda/packages/pmmrcalculator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pmmrcalculator/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-10-09
- **GitHub**: https://github.com/TCLamnidis/pMMRCalculator
- **Stars**: N/A
### Original Help Text
```text
usage: pmmrcalculator [-h] [-i <INPUT FILES PREFIX>] [-o <OUTPUT FILE>]
                      [-s <INPUT FILES SUFFIX>] [-v] [-j]

Calculate the pairwise mismatch rate of genotyped between all individuals in
the input eigenstrat dataset.

Available options:
  -h, --help            show this help message and exit
  -i <INPUT FILES PREFIX>, --Input <INPUT FILES PREFIX>
                        The desired input file prefix. Input files are assumed
                        to be <INPUT PREFIX>.geno, <INPUT PREFIX>.snp and
                        <INPUT PREFIX>.ind .
  -o <OUTPUT FILE>, --Output <OUTPUT FILE>
                        The desired output file name. Omit to print to stdout.
  -s <INPUT FILES SUFFIX>, --Suffix <INPUT FILES SUFFIX>
                        The desired input file suffix. Input files are assumed
                        to be <INPUT PREFIX>.geno<INPUT SUFFIX>, <INPUT
                        PREFIX>.snp<INPUT SUFFIX> and <INPUT PREFIX>.ind<INPUT
                        SUFFIX> .
  -v, --version         Print the version of the script and exit.
  -j, --json            Create additional json formatted output file named
                        <OUTPUT FILE>.json . [Default:
                        'pmmrcalculator_output.json']
```

