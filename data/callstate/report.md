# callstate CWL Generation Report

## callstate

### Tool Description
Calculate callable states for a BAM file based on a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/callstate:0.0.2--h0fde405_1
- **Homepage**: https://github.com/LuobinY/Callstate
- **Package**: https://anaconda.org/channels/bioconda/packages/callstate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/callstate/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LuobinY/Callstate
- **Stars**: N/A
### Original Help Text
```text
callstate 0.0.1

  Usage: callstate [options] <BED> <BAM>

Arguments:

  <BAM>  the alignment file for which to calculate callable states
  <BED>  The BED file that contains regions.

Common Options:

  -t --threads <threads>                 Number of BAM decompression threads [default: 4]
  -o --output <output>                   The output BED file
  -bdout --base-depth-output <bdout>     If a file name is given, per-base depth will be written to this file

Quality Metrics Options:

  -mbq --min-base-qual <mbq>             The minimum base quality for a base to contribute to QC depth [default: 10]
  -mmq --min-mapq <mmq>                  The minimum mapping quality of reads to count as QC depth [default: 10]
  -mdp --min-depth <mdp>                 The minimum QC read depth before a read is considered callable [default: 20]
  -mlmq --max-low-mapq <mlmq>            The maximum value of MAPQ before a read is considered as problematic mapped read. [default: 1]
  -mxdp --max-depth <mxdp>               The maximum read depth before a locus is considered high coverage [default: -1]
  -mdflmq --min-depth-low-mapq <mdflmq>  Minimum read depth before a locus is considered candidate for poorly mapped [default: 10]
  -frlmq --low-mapq-frac <frlmq>         If the fraction of low mapping reads exceeds this value, the site is considered poorly mapped [default: 0.5]

Other options:
  
  -F --flag <FLAG >                      exclude reads with any of the bits in FLAG set [default: 1796]
  -h --help                              show help
```

