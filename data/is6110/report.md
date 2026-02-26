# is6110 CWL Generation Report

## is6110

### Tool Description
Find IS elements in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/is6110:0.5.0--pyh7e72e81_0
- **Homepage**: https://github.com/jodyphelan/is6110
- **Package**: https://anaconda.org/channels/bioconda/packages/is6110/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/is6110/overview
- **Total Downloads**: 130
- **Last updated**: 2026-01-20
- **GitHub**: https://github.com/jodyphelan/is6110
- **Stars**: N/A
### Original Help Text
```text
usage: is6110 [-h] -b BAM -o OUT -r REF [-g GFF] [--is-sequences IS_SEQUENCES]
              [-t TARGET | -T TARGETS_FILE] [-d MIN_DEPTH]
              [--clipping-gap CLIPPING_GAP] [--min-seed MIN_SEED]
              [--min-score MIN_SCORE] [-@ THREADS] [--debug] [--version]

Find IS elements in a BAM file.

options:
  -h, --help            show this help message and exit
  -b, --bam BAM         Input BAM file.
  -o, --out OUT         Output file for IS counts.
  -r, --ref REF         Reference genome file.
  -g, --gff GFF         Reference genome file.
  --is-sequences IS_SEQUENCES
                        Custom FASTA file containing IS sequences. If not
                        provided, uses the default IS.fasta.
  -t, --target TARGET   Region to search in the format 'chr:start-end'.
  -T, --targets-file TARGETS_FILE
                        Bed file with regions to search.
  -d, --min-depth MIN_DEPTH
                        Minimum depth for positions to be considered.
  --clipping-gap CLIPPING_GAP
                        Maximum gap between left and right clipped reads.
  --min-seed MIN_SEED   Minimum seed length for BWA MEM (-k).
  --min-score MIN_SCORE
                        Minimum alignment score for BWA MEM (-T).
  -@, --threads THREADS
                        Number of CPUs to use.
  --debug               Enable verbose logging.
  --version             show program's version number and exit
```

