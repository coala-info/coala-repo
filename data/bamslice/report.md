# bamslice CWL Generation Report

## bamslice

### Tool Description
Extract byte ranges from BAM files and convert to interleaved FASTQ format for parallel processing

### Metadata
- **Docker Image**: quay.io/biocontainers/bamslice:0.1.7--h67a98e6_0
- **Homepage**: https://github.com/nebiolabs/bamslice
- **Package**: https://anaconda.org/channels/bioconda/packages/bamslice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamslice/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/nebiolabs/bamslice
- **Stars**: N/A
### Original Help Text
```text
Extract byte ranges from BAM files and convert to interleaved FASTQ format for parallel processing

Usage: bamslice [OPTIONS] --input <INPUT> --start-offset <START_OFFSET> --end-offset <END_OFFSET>

Options:
  -i, --input <INPUT>                Input BAM file
  -s, --start-offset <START_OFFSET>  Starting byte offset (will find next BGZF block at or after this offset)
  -e, --end-offset <END_OFFSET>      Ending byte offset (will process until reaching a block at or after this offset)
  -o, --output <OUTPUT>              Output file (default: stdout)
  -l, --log-level <LOG_LEVEL>        Log level (off, error, warn, info, debug, trace) [default: info]
  -h, --help                         Print help
  -V, --version                      Print version
```

