# revtag CWL Generation Report

## revtag

### Tool Description
Reverse (and complement) array-like SAM tags for negative facing alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/revtag:1.0.0--h3ab6199_0
- **Homepage**: https://github.com/clintval/revtag
- **Package**: https://anaconda.org/channels/bioconda/packages/revtag/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/revtag/overview
- **Total Downloads**: 974
- **Last updated**: 2025-11-10
- **GitHub**: https://github.com/clintval/revtag
- **Stars**: N/A
### Original Help Text
```text
revtag 1.0.0
Reverse (and complement) array-like SAM tags for negative facing alignments.

USAGE:
    revtag [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -i, --input <input>           Input SAM/BAM/CRAM file or stream [default: /dev/stdin]
    -o, --output <output>         Output SAM/BAM/CRAM file or stream [default: /dev/stdout]
        --rev <rev>...            SAM tags with array values to reverse
        --revcomp <revcomp>...    SAM tags with array values to reverse complement
    -t, --threads <threads>       Extra threads for BAM/CRAM compression/decompression [default: 1]
```

