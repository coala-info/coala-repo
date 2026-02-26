# bed2gff CWL Generation Report

## bed2gff

### Tool Description
A fast and memory efficient BED to gff converter

### Metadata
- **Docker Image**: quay.io/biocontainers/bed2gff:0.1.5--h9948957_1
- **Homepage**: https://github.com/alejandrogzi/bed2gff
- **Package**: https://anaconda.org/channels/bioconda/packages/bed2gff/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bed2gff/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alejandrogzi/bed2gff
- **Stars**: N/A
### Original Help Text
```text
A fast and memory efficient BED to gff converter

Usage: bed2gff [OPTIONS] --bed <BED> --output <OUTPUT>

Options:
  -b, --bed <BED>            Path to BED file
  -o, --output <OUTPUT>      Path to output file
  -t, --threads <THREADS>    Number of threads [default: 20]
  -g, --gz[=<FLAG>]          Compress output file [default: false] [possible values: true, false]
  -n, --no-gene[=<FLAG>]     Flag to disable gene_id feature [default: false] [possible values: true, false]
  -i, --isoforms <ISOFORMS>  Path to isoforms file
  -h, --help                 Print help
  -V, --version              Print version
```

