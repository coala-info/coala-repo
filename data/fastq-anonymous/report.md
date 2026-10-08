# fastq-anonymous CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastq-anonymous | Failed | tool bug: output has a blank line after every FASTQ record, so the FASTQ is malformed |

## fastq-anonymous

### Tool Description
Change the sequence of a fastq file to enable sharing of confidential information, for troubleshooting of tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-anonymous:1.0.1--py36_0
- **Homepage**: https://github.com/wdecoster/fastq-anonymous
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-anonymous/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastq-anonymous/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/fastq-anonymous
- **Stars**: N/A
### Original Help Text
```text
usage: fastq-anonymous [-h] [-v] [-m]

Change the sequence of a fastq file to enable sharing of confidential
information, for troubleshooting of tools.

optional arguments:
  -h, --help     show this help message and exit
  -v, --version  Print version and exit.
  -m, --mask     Mask all nucleotides using N
```

