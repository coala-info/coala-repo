# twobitreader CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| twobitreader_extract | PASS |  |

## twobitreader_extract

### Tool Description
Reads a 2bit file and BED regions from standard input and writes FASTA to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/twobitreader:3.1.7--py_0
- **Homepage**: https://github.com/benjschiller/twobitreader
- **Package**: https://anaconda.org/channels/bioconda/packages/twobitreader/overview
- **Validation**: PASS

### Original Help Text
```text

    cmdline_reader allows twobitreader module to be executed as a script
    accepts only one argument -- the .2bit filename
    reads input (BED format) from stdin
    writes output (FASTA format) to stdout
    writes errors/warning to stderr

    Regions should be given in BED format on stdin
    chrom    start(0-based)    end(0-based, not included)

    To use a BED file of regions, do
    python -m twobitreader example.2bit < example.bed

    Non-regions will be skipped and warnings will be issued to logging
    (logging output to stderr by default)
```

