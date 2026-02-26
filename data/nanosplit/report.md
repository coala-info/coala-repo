# nanosplit CWL Generation Report

## nanosplit_NanoSplit

### Tool Description
Perform splitting of a fastq file based on average basecall quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosplit:0.1.4--py35_0
- **Homepage**: https://github.com/wdecoster/nanosplit
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosplit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanosplit/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/nanosplit
- **Stars**: N/A
### Original Help Text
```text
usage: NanoSplit [-h] [-q QUALITY] [--outdir OUTDIR] fastqfile

Perform splitting of a fastq file based on average basecall quality.

positional arguments:
  fastqfile             Fastq file to split, can be gz compressed.

optional arguments:
  -h, --help            show this help message and exit
  -q QUALITY, --quality QUALITY
                        Splitting on this average read quality score
  --outdir OUTDIR       Specify directory in which output has to be created.
```

