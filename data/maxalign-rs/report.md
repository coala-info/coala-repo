# maxalign-rs CWL Generation Report

## maxalign-rs

### Tool Description
A Rust reimplementation of the MaxAlign algorithm for optimizing multiple sequence
alignments by maximizing the alignment area

### Metadata
- **Docker Image**: quay.io/biocontainers/maxalign-rs:0.1.0--h4349ce8_0
- **Homepage**: https://github.com/apcamargo/maxalign-rs
- **Package**: https://anaconda.org/channels/bioconda/packages/maxalign-rs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maxalign-rs/overview
- **Total Downloads**: 442
- **Last updated**: 2026-01-03
- **GitHub**: https://github.com/apcamargo/maxalign-rs
- **Stars**: N/A
### Original Help Text
```text
A Rust reimplementation of the MaxAlign algorithm for optimizing multiple sequence
alignments by maximizing the alignment area

Usage: maxalign-rs [OPTIONS] [INPUT] [OUTPUT]

Arguments:
  [INPUT]   Input FASTA file [default: -]
  [OUTPUT]  Output FASTA file [default: -]

Options:
  -m, --heuristic-method <HEURISTIC_METHOD>
          Heuristic method: 1 (no synergy), 2 (pairwise synergy), 3 (three-way synergy)
          [default: 2]
  -i, --max-iterations <MAX_ITERATIONS>
          Maximum number of iterations (-1 for unlimited iterations) [default: -1]
  -o, --refinement
          Perform refinement using the optimal branch-and-bound algorithm
  -t, --improvement-threshold <IMPROVEMENT_THRESHOLD>
          Stop iterating if the relative improvement is below this threshold [default:
          0.0]
  -s, --excluded-seqs-threshold <EXCLUDED_SEQS_THRESHOLD>
          Stop iterating if the fraction of excluded sequences is above this threshold
          [default: 1.0]
  -k, --keep-sequence <KEEP_SEQUENCE>
          Sequence to always retain (can be specified multiple times)
  -r, --report <REPORT>
          Report file path
      --retained-sequences <RETAINED_SEQUENCES>
          Write a list of retained sequences to file
      --excluded-sequences <EXCLUDED_SEQUENCES>
          Write a list of excluded sequences to file
  -v, --verbosity...
          Verbosity level (-v for normal logging, -vv for detailed logging)
  -h, --help
          Print help
  -V, --version
          Print version
```

