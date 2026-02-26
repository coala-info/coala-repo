# aligncov CWL Generation Report

## aligncov

### Tool Description
Parse a sorted BAM file to generate two tables: a table of alignment summary statistics ('_stats.tsv'), including fold-coverages (fold_cov) and proportions of target lengths covered by mapped reads (prop_cov), and a table of read depths ('_depth.tsv') for each bp position of each target.

### Metadata
- **Docker Image**: quay.io/biocontainers/aligncov:0.0.2--pyh7cba7a3_0
- **Homepage**: https://github.com/pcrxn/aligncov
- **Package**: https://anaconda.org/channels/bioconda/packages/aligncov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aligncov/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pcrxn/aligncov
- **Stars**: N/A
### Original Help Text
```text
usage: aligncov [-h] -i INPUT [-o OUTPUT]

Parse a sorted BAM file to generate two tables: a table of alignment summary
statistics ('_stats.tsv'), including fold-coverages (fold_cov) and proportions
of target lengths covered by mapped reads (prop_cov), and a table of read
depths ('_depth.tsv') for each bp position of each target.

options:
  -h, --help            show this help message and exit

Required:
  -i INPUT, --input INPUT
                        Path to sorted BAM file to process.

Optional:
  -o OUTPUT, --output OUTPUT
                        Path and base name of files to save as tab-separated
                        tables ('[output]_stats.tsv', '[output]_depth.tsv').
                        Default: 'sample'
```

