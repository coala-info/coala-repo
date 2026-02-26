# tagbam CWL Generation Report

## tagbam

### Tool Description
Tag reads in BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/tagbam:0.1.0--h3ab6199_0
- **Homepage**: https://github.com/fellen31/tagbam
- **Package**: https://anaconda.org/channels/bioconda/packages/tagbam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tagbam/overview
- **Total Downloads**: 520
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fellen31/tagbam
- **Stars**: N/A
### Original Help Text
```text
Tag reads in BAM file

Usage: tagbam [OPTIONS] --input <INPUT> --tag <TAG> --value <VALUE> --output-file <OUTPUT_FILE>

Options:
  -i, --input <INPUT>              Input BAM file
  -t, --threads <THREADS>          Number of parallel decompression & writer threads to use [default: 4]
      --tag <TAG>                  Tag to add (must be 1-2 characters)
  -v, --value <VALUE>              Value to add
  -o, --output-file <OUTPUT_FILE>  Output file
  -c, --compression <COMPRESSION>  BAM output compression level [default: 6]
  -h, --help                       Print help
  -V, --version                    Print version
```

