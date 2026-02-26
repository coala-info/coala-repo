# bed2gtf CWL Generation Report

## bed2gtf

### Tool Description
A fast and memory efficient BED to GTF converter

### Metadata
- **Docker Image**: quay.io/biocontainers/bed2gtf:1.9.3--h9948957_2
- **Homepage**: https://github.com/alejandrogzi/bed2gtf
- **Package**: https://anaconda.org/channels/bioconda/packages/bed2gtf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bed2gtf/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alejandrogzi/bed2gtf
- **Stars**: N/A
### Original Help Text
```text
A fast and memory efficient BED to GTF converter

Usage: bed2gtf [OPTIONS] --bed <BED> --output <OUTPUT>

Options:
  -b, --bed <BED>            Path to BED file
  -o, --output <OUTPUT>      Path to output file
  -t, --threads <THREADS>    Number of threads [default: 20]
  -g, --gz[=<FLAG>]          Compress output file [default: false] [possible values: true, false]
  -n, --no-gene[=<FLAG>]     Flag to disable gene_id feature [default: false] [possible values: true, false]
  -i, --isoforms <ISOFORMS>  Path to isoforms file [gene -> transcript1, transcript2, ...]
  -h, --help                 Print help
  -V, --version              Print version
```

