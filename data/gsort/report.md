# gsort CWL Generation Report

## gsort

### Tool Description
Sorts genomic interval files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gsort:0.1.5--he881be0_0
- **Homepage**: https://github.com/brentp/gsort
- **Package**: https://anaconda.org/channels/bioconda/packages/gsort/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gsort/overview
- **Total Downloads**: 51.1K
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/brentp/gsort
- **Stars**: N/A
### Original Help Text
```text
Usage: gsort [--chromosomemappings CHROMOSOMEMAPPINGS] [--memory MEMORY] [--parent] [PATH [GENOME]]

Positional arguments:
  PATH                   a tab-delimited file to sort
  GENOME                 a genome file of chromosome sizes and order

Options:
  --chromosomemappings CHROMOSOMEMAPPINGS, -c CHROMOSOMEMAPPINGS
                         a file used to re-map chromosome names for example from hg19 to GRCh37
  --memory MEMORY, -m MEMORY
                         megabytes of memory to use before writing to temp files. [default: 2800]
  --parent, -p           for gff only. given rows with same chrom and start put those with a 'Parent' attribute first
  --help, -h             display this help and exit
```

