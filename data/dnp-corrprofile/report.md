# dnp-corrprofile CWL Generation Report

## dnp-corrprofile

### Tool Description
This program computes correlations between the profiles of dinucleotide
    frequency on forward and reverse complent sequences within a sliding
    window.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnp-corrprofile:1.0--hd6d6fdc_6
- **Homepage**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Package**: https://anaconda.org/channels/bioconda/packages/dnp-corrprofile/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnp-corrprofile/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Stars**: N/A
### Original Help Text
```text
corrprofile - Correlations between Dinucleotide Profiles
========================================================

SYNOPSIS
    corrprofile [OPTIONS] "dinucleotideProfilesFile"

DESCRIPTION
    This program computes correlations between the profiles of dinucleotide
    frequency on forward and reverse complent sequences within a sliding
    window.

REQUIRED ARGUMENTS
    PROFILE_FILE STRING

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    -w, --window INTEGER
          Sliding window size, < than length. In range [10..146]. Default: 10.
    -n, --length INTEGER
          Dinucleotide profile sequence length. In range [25..600]. Default:
          600.
    -v, --verbose
          Print parameters and variables.
    --version
          Display version information.

EXAMPLES
    corrprofile -w 146 -n 400 path/to/profiles/file
          Compute correlations at each position in 400bp long profile within
          the sliding 146bp window

OUTPUT
    Column of correlation coefficients
          between forward and reverse profile at each position

VERSION
    Last update: April 2017
    corrprofile version: 1.0
    SeqAn version: 2.4.0
```

