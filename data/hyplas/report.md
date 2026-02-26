# hyplas CWL Generation Report

## hyplas

### Tool Description
Hyplas is a tool for plasmid assembly and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/hyplas:1.0.2--py311h2de2dd3_0
- **Homepage**: https://github.com/cchauve/hyplas
- **Package**: https://anaconda.org/channels/bioconda/packages/hyplas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hyplas/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-09-29
- **GitHub**: https://github.com/cchauve/hyplas
- **Stars**: N/A
### Original Help Text
```text
usage: hyplas [-h] [-l LONG_READS] [-s SHORT_READS [SHORT_READS ...]]
              [--sr-assembly SR_ASSEMBLY] -o OUTPUT_DIRECTORY
              [-p PROPAGATE_ROUNDS] --platon-db PLATON_DB [-t THREADS]
              [--verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--force]

options:
  -h, --help            show this help message and exit
  -l LONG_READS, --long-reads LONG_READS
                        long reads fastq file
  -s SHORT_READS [SHORT_READS ...], --short-reads SHORT_READS [SHORT_READS ...]
                        short reads fastq files
  --sr-assembly SR_ASSEMBLY
                        short reads assembly graph
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
  -p PROPAGATE_ROUNDS, --propagate-rounds PROPAGATE_ROUNDS
                        Number of rounds to propagate plasmid long read
                        information
  --platon-db PLATON_DB
  -t THREADS, --threads THREADS
  --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
  --force
```

