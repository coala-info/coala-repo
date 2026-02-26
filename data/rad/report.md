# rad CWL Generation Report

## rad

### Tool Description
Parses FASTQ files to identify barcodes and their associated UMI and/or cell barcodes, and outputs various processed files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rad:0.6.0--h077b44d_0
- **Homepage**: https://github.com/indianewok/rad
- **Package**: https://anaconda.org/channels/bioconda/packages/rad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rad/overview
- **Total Downloads**: 411
- **Last updated**: 2025-05-13
- **GitHub**: https://github.com/indianewok/rad
- **Stars**: N/A
### Original Help Text
```text
[ERROR] --layout and --fastq are required

Usage: rad -l LAYOUT -q FASTQ [-k KIT] [-g GLOBAL_WL] [-c CUSTOM_WL] [-o PREFIX] [-d DIR] [-b] [-t THREADS] [-v] [-D] [-h]
  -l, --layout            layout key (five_prime, three_prime, splitseq) or a custom path
  -q, --fastq             input FASTQ file
  -k, --kit               use this kit's default whitelist
  -g, --global_whitelist  path to a single custom global whitelist (i.e, all barcodes that could potentially appear in this dataset) CSV
  -c, --custom_whitelist  path to a single custom whitelist CSV (i.e, barcodes that you've already found in short-read matched data)
  -m, --mutation          mutation space of each barcode
  -s, --shift             shift space of each barcode
  -o, --output            filename prefix  (default: output)
  -d, --dir               output directory (default: current directory)
  -b, --bc_split          write reads into per-barcode FASTQ files
  -t, --threads           number of threads (default: 1)
  -v, --verbose           verbose mode
  -D, --max_verbose       max verbose level (debug only)
  -h, --help              prints this menu
```

