# dnp-binstrings CWL Generation Report

## dnp-binstrings

### Tool Description
This program reads the fasta file and each sequence is transformed into
    0011 form in which ones denotedinucleotides and zeros are elsewhere.Binary
    sequence is printed. The last lneis the profile of the dinucleotide
    appearance.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnp-binstrings:1.0--hd6d6fdc_6
- **Homepage**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Package**: https://anaconda.org/channels/bioconda/packages/dnp-binstrings/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnp-binstrings/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Stars**: N/A
### Original Help Text
```text
binstrings - Binary strings from fasta
======================================

SYNOPSIS
    binstrings [OPTIONS] "fastaFile.fa"

DESCRIPTION
    This program reads the fasta file and each sequence is transformed into
    0011 form in which ones denotedinucleotides and zeros are elsewhere.Binary
    sequence is printed. The last lneis the profile of the dinucleotide
    appearance.

REQUIRED ARGUMENTS
    FASTA_FILE STRING

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    -di, --dinucleotide STRING
          Dinucleotide that is to identify in fasta sequences One of AA, AC,
          AG, AT, CA, CC, CG, CT, GA, GC, GG, GT, TA, TC, TG, and TT. Default:
          CC.
    --version
          Display version information.

EXAMPLES
    binstrings -di CC path/to/fasta/file.fa
          Compute binary strings matching CC in fasta sequences.

OUTPUT
    100000000111000 CC chr9:42475963-42476182 CCAGGCAGACCCCATA 4
          binary string, CC, fasta id, DNA sequence, occurrences

VERSION
    Last update: September 2018
    binstrings version: 1.0
    SeqAn version: 2.4.0
```

