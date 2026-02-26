# splitp CWL Generation Report

## splitp

### Tool Description
Streaming SPLiT-seq read pre-processing

### Metadata
- **Docker Image**: quay.io/biocontainers/splitp:0.2.0--h9948957_1
- **Homepage**: https://github.com/COMBINE-lab/splitp
- **Package**: https://anaconda.org/channels/bioconda/packages/splitp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/splitp/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/splitp
- **Stars**: N/A
### Original Help Text
```text
Streaming SPLiT-seq read pre-processing

Usage: splitp [OPTIONS] --read-file <READ_FILE> --start <START> --end <END> <BC_MAP>

Arguments:
  <BC_MAP>  the map of oligo-dT to random hexamers

Options:
  -r, --read-file <READ_FILE>  the input R2 file
  -s, --start <START>          start position of the random barcode
  -e, --end <END>              end position of the random barcode
  -o, --one-hamming            consider 1-hamming distance neighbors of random hexamers
  -h, --help                   Print help
  -V, --version                Print version
```

