# mark-nonconverted-reads CWL Generation Report

## mark-nonconverted-reads_mark-nonconverted-reads.py

### Tool Description
Mark nonconverted reads

### Metadata
- **Docker Image**: quay.io/biocontainers/mark-nonconverted-reads:1.2--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/mark-nonconverted-reads
- **Package**: https://anaconda.org/channels/bioconda/packages/mark-nonconverted-reads/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mark-nonconverted-reads/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nebiolabs/mark-nonconverted-reads
- **Stars**: N/A
### Original Help Text
```text
usage: mark-nonconverted-reads.py [-h] [--reference REFERENCE] [--bam BAM]
                                  [--out OUT] [--c_count C_COUNT]
                                  [--flag_reads]

options:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        Reference fasta file
  --bam BAM             Input bam or sam file (must end in .bam or .sam)
                        [default = stdin]
  --out OUT             Name for output sam file [default = stdout]
  --c_count C_COUNT     Minimum number of nonconverted Cs on a read to
                        consider it nonconverted [default = 3]
  --flag_reads          Set the 'Failing platform / vendor quality check flag
```

