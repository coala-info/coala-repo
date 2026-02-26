# nwalign3 CWL Generation Report

## nwalign3

### Tool Description
Performs pairwise global alignment of two sequences using the Needleman-Wunsch algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwalign3:0.1.6--py39hff726c5_0
- **Homepage**: https://github.com/briney/nwalign3
- **Package**: https://anaconda.org/channels/bioconda/packages/nwalign3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nwalign3/overview
- **Total Downloads**: 36.4K
- **Last updated**: 2025-09-30
- **GitHub**: https://github.com/briney/nwalign3
- **Stars**: N/A
### Original Help Text
```text
Usage: nwalign3 [options] seq1 seq2

Options:
  -h, --help            show this help message and exit
  --gap_extend=GAP_EXTEND
                        gap extend penalty (must be integer <= 0)
  --gap_open=GAP_OPEN   gap open penalty (must be integer <= 0)
  --match=MATCH         match score (must be integer > 0)
  --matrix=MATRIX       scoring matrix in ncbi/data/ format,
                        if not specificied, match/mismatch are used
  --server=SERVER       if non-zero integer, a server is started
Usage: nwalign3 [options] seq1 seq2

Options:
  -h, --help            show this help message and exit
  --gap_extend=GAP_EXTEND
                        gap extend penalty (must be integer <= 0)
  --gap_open=GAP_OPEN   gap open penalty (must be integer <= 0)
  --match=MATCH         match score (must be integer > 0)
  --matrix=MATRIX       scoring matrix in ncbi/data/ format,
                        if not specificied, match/mismatch are used
  --server=SERVER       if non-zero integer, a server is started
```

