# dedup CWL Generation Report

## dedup

### Tool Description
DeDup tool for deduplicating reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/dedup:0.12.9--hdfd78af_0
- **Homepage**: https://github.com/apeltzer/dedup
- **Package**: https://anaconda.org/channels/bioconda/packages/dedup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dedup/overview
- **Total Downloads**: 29.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apeltzer/dedup
- **Stars**: N/A
### Original Help Text
```text
usage: dedup
 -h,--help           show this help page
 -i,--input <arg>    the input file if this option is not specified,
                     the input is expected to be piped in
 -m,--merged         the input only contains merged reads.
                     If this option is specified read names are not
                     examined for prefixes.
                     Both the start and end of the aligment are considered
                     for all reads.
 -o,--output <arg>   the output folder. Has to be specified if input is
                     set.
 -u,--unsorted       Do not automatically sort the output
 -v,--version        the version of DeDup.
```

