# rotate CWL Generation Report

## rotate

### Tool Description
Rotate a FASTA file to a new start position.

### Metadata
- **Docker Image**: quay.io/biocontainers/rotate:1.0--h577a1d6_1
- **Homepage**: https://github.com/richarddurbin/rotate
- **Package**: https://anaconda.org/channels/bioconda/packages/rotate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rotate/overview
- **Total Downloads**: 818
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/richarddurbin/rotate
- **Stars**: N/A
### Original Help Text
```text
rotate [options] <input fasta filename>
  -x <pos>		position to become new start [0]
  -rc               reverse complement after rotating [false]
  -s <string>       rotate to start of search string
  -m <n_mismatch>   maximum number of mismatches allowed in search [0]
  -o <outfilename>  output file [standard output]
use either -x and optionally -rc, or -s
use filename '-' for standard input
can read .fa.gz files as well as .fa files
```

