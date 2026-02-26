# irf CWL Generation Report

## irf

### Tool Description
Inverted Repeats Finder

### Metadata
- **Docker Image**: quay.io/biocontainers/irf:3.09--h7b50bb2_0
- **Homepage**: https://github.com/Benson-Genomics-Lab/IRF
- **Package**: https://anaconda.org/channels/bioconda/packages/irf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irf/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Benson-Genomics-Lab/IRF
- **Stars**: N/A
### Original Help Text
```text
Inverted Repeats Finder, Version 3.09
Copyright (C) Dr. Gary Benson 2002-2025. All rights reserved.


Please use: irf File Match Mismatch Delta PM PI Minscore Maxlength MaxLoop [options]

Where: (all weights, penalties, and scores are positive)
  File = sequences input file
  Match  = matching weight
  Mismatch  = mismatching penalty
  Delta = indel penalty
  PM = match probability (whole number)
  PI = indel probability (whole number)
  Minscore = minimum alignment score to report
  MaxLength = maximum stem length to report (10,000 minimum and no upper limit, but system will run out memory if this is too large)
  MaxLoop = filters results to have loop less than this value (will not give you more results unless you increase -t4,-t4,-t7 as well)
  [options] = one or more of the following :
               -m    masked sequence file
               -f    flanking sequence
               -d    data file
               -h    suppress HTML output

               -l    lowercase letters do not participate in a k-tuple match, but can be part of an alignment
               -gt   allow the GT match (gt matching weight must follow immediately after the switch)
               -mr   target is mirror repeats
               -r    set the identity value of the redundancy algorithm (value 60 to 100 must follow immediately after the switch)

               -la   lookahead test enabled. Results are slightly different as a repeat might be found at a different interval. Faster.
               -a3   perform a third alignment going inward. Produces longer or better alignments. Slower.
               -a4   same as a3 but alignment is of maximum narrowband width. Slightly better results than a3. Much slower.
               -i1   Do not stop once a repeat is found at a certain interval and try larger intervals at nearby centers. Better(?) results. Slower.
               -i2   Do not stop once a repeat is found at a certain interval and try all intervals at same and nearby centers. Better(?) results. Much slower.
               -r0   do not eliminate redundancy from the output
               -r2   modified redundancy algorithm, does not remove stuff which is redundant to redundant. Slower and not good for TA repeat regions, would not leave the largest, but a whole bunch.

               -t4   set the maximum loop separation for tuple of length4 (default 154, separation <=1,000 must follow)
               -t5   set the maximum loop separation for tuple of length5 (default 813, separation <=10,000 must follow)
               -t7   set the maximum loop separation for tuple of length7 (default 14800, limited by your system's memory, make sure you increase maxloop to the same value)
               -ngs  more compact .dat output on multisequence files, returns 0 on success. 

Note the sequence file should be in FASTA format:

>Name of sequence
   aggaaacctg ccatggcctc ctggtgagct gtcctcatcc actgctcgct gcctctccag
   atactctgac ccatggatcc cctgggtgca gccaagccac aatggccatg gcgccgctgt
   actcccaccc gccccaccct cctgatcctg ctatggacat ggcctttcca catccctgtg
```

