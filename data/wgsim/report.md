# wgsim CWL Generation Report

## wgsim

### Tool Description
short read simulator

### Metadata
- **Docker Image**: quay.io/biocontainers/wgsim:1.0--h577a1d6_10
- **Homepage**: https://github.com/lh3/wgsim
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wgsim/overview
- **Total Downloads**: 15.3K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/lh3/wgsim
- **Stars**: N/A
### Original Help Text
```text
Program: wgsim (short read simulator)
Version: 0.3.1-r13
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   wgsim [options] <in.ref.fa> <out.read1.fq> <out.read2.fq>

Options: -e FLOAT      base error rate [0.020]
         -d INT        outer distance between the two ends [500]
         -s INT        standard deviation [50]
         -N INT        number of read pairs [1000000]
         -1 INT        length of the first read [70]
         -2 INT        length of the second read [70]
         -r FLOAT      rate of mutations [0.0010]
         -R FLOAT      fraction of indels [0.15]
         -X FLOAT      probability an indel is extended [0.30]
         -S INT        seed for random generator [-1]
         -A FLOAT      disgard if the fraction of ambiguous bases higher than FLOAT [0.05]
         -h            haplotype mode
```

