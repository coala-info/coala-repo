# nail CWL Generation Report

## nail_search

### Tool Description
Run nail's protein search pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/nail:0.4.0--h4349ce8_1
- **Homepage**: https://github.com/TravisWheelerLab/nail
- **Package**: https://anaconda.org/channels/bioconda/packages/nail/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nail/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-11-25
- **GitHub**: https://github.com/TravisWheelerLab/nail
- **Stars**: N/A
### Original Help Text
```text
Run nail's protein search pipeline

Usage: nail search [OPTIONS] <QUERY.[fasta:hmm]> <TARGET.fasta>

Arguments:
  <QUERY.[fasta:hmm]>  The query database file
  <TARGET.fasta>       The target database file

Options:
  -t <N>      The number of threads that nail will use [default: 8]
  -s          Print out pipeline summary statistics
  -x          Don't write any tabular results, write alignments to stdout
  -h, --help  Print help

File I/O options:
      --tbl-out <PATH>    The file where tabular output will be written [default: results.tbl]
      --ali-out <PATH>    The file where alignment output will be written
      --seeds <PATH>      A file containing pre-computed alignment seeds
      --seeds-out <PATH>  The file where alignment seeds will be written
      --tmp-dir <PATH>    The directory where intermediate files will be placed [default: tmp/]
      --allow-overwrite   Allow nail to overwrite files

Pipeline options:
  -A <X>             Cloud search parameter α:
                       local score pruning threshold [default: 10]
  -B <X>             Cloud search parameter β:
                       global score pruning threshold [default: 16]
  -G <N>             Cloud search parameter γ:
                       at minimum, compute N anti-diagonals [default: 5]
  -S <X>             Seeding filter threshold:
                       filter hits with P-value > X [default: 0.01]
  -C <X>             Cloud search threshold:
                       filter hits with P-value > X [default: 0.001]
  -F <X>             Forward filter threshold:
                       filter hits with P-value > X [default: 0.0001]
  -E <X>             Final reporting threshold:
                       filter hits with E-value > X [default: 10]
      --double-seed  Seed alignments twice (high/low expected sequence divergence)
      --only-seed    Produce alignment seeds and terminate

MMseqs2 options:
      --mmseqs-k <N>                   MMseqs2 prefilter: k-mer length (0: automatically set to
                                       optimum) [default: 0]
      --mmseqs-k-score <N>             MMseqs2 prefilter: k-mer threshold for generating similar
                                       k-mer lists [default: 80]
      --mmseqs-min-ungapped-score <N>  MMseqs2 prefilter: Accept only matches with ungapped
                                       alignment score above threshold [default: 15]
      --mmseqs-max-seqs <N>            MMseqs2 prefilter: Maximum results per query sequence allowed
                                       to pass the prefilter [default: 1000]

Expert options:
  -Z <N>          Override the number of comparisons used for E-value calculation
      --no-null2  Don't compute sequence composition bias score correction
```

