# manorm CWL Generation Report

## manorm

### Tool Description
MAnorm -- A robust model for quantitative comparison of ChIP-seq data sets

### Metadata
- **Docker Image**: quay.io/biocontainers/manorm:1.3.0--py_0
- **Homepage**: https://github.com/shao-lab/MAnorm
- **Package**: https://anaconda.org/channels/bioconda/packages/manorm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/manorm/overview
- **Total Downloads**: 28.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shao-lab/MAnorm
- **Stars**: N/A
### Original Help Text
```text
usage: manorm [-h] [-v] --p1 FILE --p2 FILE [--pf FORMAT] --r1 FILE --r2 FILE
              [--rf FORMAT] [--n1 NAME] [--n2 NAME] [--s1 N] [--s2 N] [--pe]
              [-w LENGTH] [--summit-dis DISTANCE] [--n-random NUM] [-m FLOAT]
              [-p FLOAT] [-o DIR] [--wa] [--verbose]

MAnorm -- A robust model for quantitative comparison of ChIP-seq data sets

Citation:
  Shao Z, Zhang Y, Yuan GC, Orkin SH, Waxman DJ. MAnorm: a robust model 
  for quantitative comparison of ChIP-Seq data sets. Genome biology. 
  2012 Mar 16;13(3):R16. https://doi.org/10.1186/gb-2012-13-3-r16

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --verbose             Enable verbose log messages.

Input Options:
  --p1 FILE, --peak1 FILE
                        Peak file of sample 1.
  --p2 FILE, --peak2 FILE
                        Peak file of sample 2.
  --pf FORMAT, --peak-format FORMAT
                        Format of the peak files. Support ['bed',
                        'bed3-summit', 'macs', 'macs2', 'narrowpeak',
                        'broadpeak']. Default: bed
  --r1 FILE, --read1 FILE
                        Read file of sample 1.
  --r2 FILE, --read2 FILE
                        Read file of sample 2.
  --rf FORMAT, --read-format FORMAT
                        Format of the read files. Support ['bed', 'bedpe',
                        'sam', 'bam']. Default: bed
  --n1 NAME, --name1 NAME
                        Name of sample 1. If not specified, the peak file name
                        will be used.
  --n2 NAME, --name2 NAME
                        Name of sample 2. If not specified, the peak file name
                        will be used.

Reads Manipulation:
  --s1 N, --shiftsize1 N
                        Single-end reads shift size for sample 1. Reads are
                        shifted by `N` bp towards 3' direction and the 5' end
                        of each shifted read is used to represent the genomic
                        locus of the DNA fragment. Set to 0.5 * fragment size
                        of the ChIP-seq library. Default: 100
  --s2 N, --shiftsize2 N
                        Single-end reads shift size for sample 2. Default: 100
  --pe, --paired-end    Paired-end mode. The middle point of each read pair is
                        used to represent the genomic locus of the DNA
                        fragment. If specified, `--s1` and `--s2` will be
                        ignored.

Normalization Model Options:
  -w LENGTH, --window-size LENGTH
                        Window size to count reads and calculate read
                        densities. Set to 2000 is recommended for sharp
                        histone marks like H3K4me3 or H3K27ac and 1000 for TFs
                        or DNase-seq. Default: 2000
  --summit-dis DISTANCE
                        Summit-to-summit distance cutoff for overlapping
                        common peaks. Common peaks with summit distance beyond
                        the cutoff are excluded in model fitting. Default:
                        `window size` / 4
  --n-random NUM        Number of random simulations to test the enrichment of
                        peak overlap between the specified samples. Set to 0
                        to disable the testing. Default: 10

Output Options:
  -m FLOAT, --m-cutoff FLOAT
                        Absolute M-value (log2-ratio) cutoff to define the
                        biased (differential binding) peaks. Default: 1.0
  -p FLOAT, --p-cutoff FLOAT
                        P-value cutoff to define the biased peaks. Default:
                        0.01
  -o DIR, --output-dir DIR
                        Output directory. Default: Current working directory
  --wa, --write-all     Write two extra output files containing the results of
                        the original (unmerged) peaks.

See also:
  Documentation: https://manorm.readthedocs.io
  Source code: https://github.com/shao-lab/MAnorm
  Bug reports: https://github.com/shao-lab/MAnorm/issues
```

