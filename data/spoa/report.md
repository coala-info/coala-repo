# spoa CWL Generation Report

## spoa

### Tool Description
SPoA: A Sparse-Aligner for Long Reads

### Metadata
- **Docker Image**: quay.io/biocontainers/spoa:4.1.5--h077b44d_0
- **Homepage**: https://github.com/rvaser/spoa
- **Package**: https://anaconda.org/channels/bioconda/packages/spoa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spoa/overview
- **Total Downloads**: 43.3K
- **Last updated**: 2025-09-22
- **GitHub**: https://github.com/rvaser/spoa
- **Stars**: N/A
### Original Help Text
```text
usage: spoa [options ...] <sequences>

  # default output is stdout
  <sequences>
    input file in FASTA/FASTQ format (can be compressed with gzip)

  options:
    -m <int>
      default: 5
      score for matching bases
    -n <int>
      default: -4
      score for mismatching bases
    -g <int>
      default: -8
      gap opening penalty (must be non-positive)
    -e <int>
      default: -6
      gap extension penalty (must be non-positive)
    -q <int>
      default: -10
      gap opening penalty of the second affine function
      (must be non-positive)
    -c <int>
      default: -4
      gap extension penalty of the second affine function
      (must be non-positive)
    -l, --algorithm <int>
      default: 0
      alignment mode:
        0 - local (Smith-Waterman)
        1 - global (Needleman-Wunsch)
        2 - semi-global
    -r, --result <int> (option can be used multiple times)
      default: 0
      result mode:
        0 - consensus (FASTA)
        1 - multiple sequence alignment (FASTA)
        2 - 0 & 1 (FASTA)
        3 - partial order graph (GFA)
        4 - 0 & 3 (GFA)
    --min-coverage <int>
      default: -1
      minimal consensus coverage (usable only with -r 0)
    -d, --dot <file>
      output file for the partial order graph in DOT format
    -s, --strand-ambiguous
      for each sequence pick the strand with the better alignment
    --version
      prints the version number
    -h, --help
      prints the usage

  gap mode:
    linear if g >= e
    affine if g <= q or e >= c
    convex otherwise (default)
```

