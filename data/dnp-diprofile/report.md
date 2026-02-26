# dnp-diprofile CWL Generation Report

## dnp-diprofile

### Tool Description
This program computes a profile of a frequency of occurrence of the dinucleotide in a batch of fasta sequences aligned by their start position.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnp-diprofile:1.0--hd6d6fdc_7
- **Homepage**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Package**: https://anaconda.org/channels/bioconda/packages/dnp-diprofile/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dnp-diprofile/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Stars**: N/A
### Original Help Text
```text
diprofile - Dinucleotide Frequency Profile
==========================================

SYNOPSIS
    diprofile [OPTIONS] "fastaFile.fa"

DESCRIPTION
    This program computes a profile of a frequency of occurrence of the
    dinucleotide in a batch of fasta sequences aligned by their start
    position.

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
          Dinucleotide to compute a frequency profile in fasta file. One of
          AA, AC, AG, AT, CA, CC, CG, CT, GA, GC, GG, GT, TA, TC, TG, and TT.
          Default: AA.
    -sl, --seqlength INTEGER
          Sequence length in fasta file. In range [25..600]. Default: 600.
    -c, --complement
          Perform computation on COMPLEMENTARY sequences of the strings in
          fasta file.
    -v, --verbose
          Print parameters and variables.
    --version
          Display version information.

EXAMPLES
    diprofile -sl 146 -di CT path/to/fasta/file.fa
          Compute CT profile in fasta sequences of 146bp long
    diprofile -sl 146 -di CT -c path/to/fasta/file.fa
          Compute CT profile in sequence complements of fasta sequences of
          146bp long

OUTPUT
    Column of relative frequencies of dinucleotide occurrences at each 
          position along fasta sequences of given length --seqlength

VERSION
    Last update: April 2017
    diprofile version: 1.0
    SeqAn version: 2.4.0
```


## Metadata
- **Skill**: generated

## dnp-diprofile

### Tool Description
This program computes a profile of a frequency of occurrence of the dinucleotide in a batch of fasta sequences aligned by their start position.

### Metadata
- **Docker Image**: quay.io/biocontainers/dnp-diprofile:1.0--hd6d6fdc_7
- **Homepage**: https://github.com/erinijapranckeviciene/dnpatterntools
- **Package**: https://anaconda.org/channels/bioconda/packages/dnp-diprofile/overview
- **Validation**: PASS
### Original Help Text
```text
diprofile - Dinucleotide Frequency Profile
==========================================

SYNOPSIS
    diprofile [OPTIONS] "fastaFile.fa"

DESCRIPTION
    This program computes a profile of a frequency of occurrence of the
    dinucleotide in a batch of fasta sequences aligned by their start
    position.

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
          Dinucleotide to compute a frequency profile in fasta file. One of
          AA, AC, AG, AT, CA, CC, CG, CT, GA, GC, GG, GT, TA, TC, TG, and TT.
          Default: AA.
    -sl, --seqlength INTEGER
          Sequence length in fasta file. In range [25..600]. Default: 600.
    -c, --complement
          Perform computation on COMPLEMENTARY sequences of the strings in
          fasta file.
    -v, --verbose
          Print parameters and variables.
    --version
          Display version information.

EXAMPLES
    diprofile -sl 146 -di CT path/to/fasta/file.fa
          Compute CT profile in fasta sequences of 146bp long
    diprofile -sl 146 -di CT -c path/to/fasta/file.fa
          Compute CT profile in sequence complements of fasta sequences of
          146bp long

OUTPUT
    Column of relative frequencies of dinucleotide occurrences at each 
          position along fasta sequences of given length --seqlength

VERSION
    Last update: April 2017
    diprofile version: 1.0
    SeqAn version: 2.4.0
```

