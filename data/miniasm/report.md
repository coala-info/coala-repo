# miniasm CWL Generation Report

## miniasm

### Tool Description
miniasm: option requires an argument -- 'h'
See miniasm.1 for detailed description of the command-line options.

### Metadata
- **Docker Image**: quay.io/biocontainers/miniasm:0.3_r179--ha92aebf_0
- **Homepage**: https://github.com/lh3/miniasm
- **Package**: https://anaconda.org/channels/bioconda/packages/miniasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/miniasm/overview
- **Total Downloads**: 113.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lh3/miniasm
- **Stars**: N/A
### Original Help Text
```text
miniasm: option requires an argument -- 'h'
Usage: miniasm [options] <in.paf>
Options:
  Pre-selection:
    -R          prefilter clearly contained reads (2-pass required)
    -m INT      min match length [100]
    -i FLOAT    min identity [0.05]
    -s INT      min span [2000]
    -c INT      min coverage [3]
  Overlap:
    -o INT      min overlap [same as -s]
    -h INT      max over hang length [1000]
    -I FLOAT    min end-to-end match ratio [0.8]
  Layout:
    -g INT      max gap differences between reads for trans-reduction [1000]
    -d INT      max distance for bubble popping [50000]
    -e INT      small unitig threshold [4]
    -f FILE     read sequences []
    -n INT      rounds of short overlap removal [3]
    -r FLOAT[,FLOAT]
                max and min overlap drop ratio [0.7,0.5]
    -F FLOAT    aggressive overlap drop ratio in the end [0.8]
  Miscellaneous:
    -p STR      output information: bed, paf, sg or ug [ug]
    -b          both directions of an arc are present in input
    -1          skip 1-pass read selection
    -2          skip 2-pass read selection
    -V          print version number

See miniasm.1 for detailed description of the command-line options.
```

