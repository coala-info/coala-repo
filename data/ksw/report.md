# ksw CWL Generation Report

## ksw

### Tool Description
klib smith-waterman

### Metadata
- **Docker Image**: quay.io/biocontainers/ksw:0.2.3--h43eeafb_0
- **Homepage**: https://github.com/nh13/ksw
- **Package**: https://anaconda.org/channels/bioconda/packages/ksw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ksw/overview
- **Total Downloads**: 25.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nh13/ksw
- **Stars**: N/A
### Original Help Text
```text
Program: ksw (klib smith-waterman)
Version: 0.2.3
Usage: ksw [options]

Algorithm options:

       -M INT      The alignment mode: 0 - local, 1 - glocal, 2 - extend, 3 - global [0 - local]
       -a INT      The match score (>0) [1]
       -b INT      The mismatch penalty (>0) [3]
       -q INT      The gap open penalty (>=0) [5]
       -r INT      The gap extend penalty (>0) [2]
       -w INT      The band width (ksw only) [536870911]
       -m FILE     Path to the scoring matrix (4x4 or 5x5) [None]
       -c          Append the cigar to the output [false]
       -s          Append the query and target to the output [false]
       -H          Add a header line to the output [false]
       -R          Right-align gaps (ksw only)[false]
       -O          Output offset-and-length, otherwise start-and-end (all zero-based)[false]
       -l INT      The library type: 0 - auto, 1 - ksw2, 2 - parasail [0 - auto]

Note: when any of the algorithms open a gap, the gap open plus the gap extension penalty is applied.
```

