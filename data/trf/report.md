# trf CWL Generation Report

## trf

### Tool Description
Tandem Repeats Finder: locates and displays tandem repeats in DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/trf:4.10.0rc2--h7b50bb2_0
- **Homepage**: https://tandem.bu.edu/trf/trf.html
- **Package**: https://anaconda.org/channels/bioconda/packages/trf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trf/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-06-17
- **GitHub**: https://github.com/Benson-Genomics-Lab/TRF
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...


Please use: /usr/local/bin/trf File Match Mismatch Delta PM PI Minscore MaxPeriod [options]

Where: (all weights, penalties, and scores are positive)
  File = sequences input file
  Match  = matching weight
  Mismatch  = mismatching penalty
  Delta = indel penalty
  PM = match probability (whole number)
  PI = indel probability (whole number)
  Minscore = minimum alignment score to report
  MaxPeriod = maximum period size to report. Must be between 1 and 2000, inclusive
  [options] = one or more of the following:
        -m        masked sequence file
        -f        flanking sequence
        -d        data file
        -h        suppress html output
        -r        no redundancy elimination
        -l <n>    maximum TR length expected (in millions) (eg, -l 3 or -l=3 for 3 million)
                  Human genome HG38 would need -l 6
        -ngs      more compact .dat output on multisequence files, returns 0 on success.
                  Output is printed to the screen, not a file. You may pipe input in with
                  this option using - for file name. Short 50 flanks are appended to .dat
                  output.

See more information on the TRF Unix Help web page: https://tandem.bu.edu/trf/trf.unix.help.html

Note the sequence file should be in FASTA format:

>Name of sequence
aggaaacctgccatggcctcctggtgagctgtcctcatccactgctcgctgcctctccag
atactctgacccatggatcccctgggtgcagccaagccacaatggccatggcgccgctgt
actcccacccgccccaccctcctgatcctgctatggacatggcctttccacatccctgtg


Tandem Repeats Finder
Copyright (C) 1999-2020 Gary Benson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
```


## Metadata
- **Skill**: generated
