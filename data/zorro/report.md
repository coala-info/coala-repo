# zorro CWL Generation Report

## zorro

### Tool Description
ZORRO Options

### Metadata
- **Docker Image**: quay.io/biocontainers/zorro:2011.12.01--h7b50bb2_5
- **Homepage**: https://sourceforge.net/projects/probmask/
- **Package**: https://anaconda.org/channels/bioconda/packages/zorro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zorro/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
File not specified
Usage: zorro [options] filename > outputfile

ZORRO Options 

-sample          : Sampling pairs to calculate alignment reliabilty [Off By Default]
-nosample        : No Sampling i.e. using every pair to calculate alignment reliabilty [On By Default]
-noweighting     : Using sum of pairs instead of weighted sum of pairs to calculate column confidence [Off By Default]
-ignoregaps      : Ignore pair-gaps in columns when calculating column confidences [Off By Default]
-Nsample NUMBER  : Tells ZORRO to sample #NUMBER pairs when sampling, automatically turns on -sample option [Samples 10*Nseq sequences By Default]
-treeprog PROGRAM: Tells ZORRO to use PROGRAM instead of the default FastTree to create guide tree [FastTree By Default]
-guide treefile  : User provided guide tree
```

