# oncofuse CWL Generation Report

## oncofuse

### Tool Description
Oncofuse.jar is a tool for analyzing fusion genes. It takes an input file, its type, and optionally a tissue type, and produces an output file.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncofuse:1.1.1--0
- **Homepage**: https://github.com/mikessh/oncofuse
- **Package**: https://anaconda.org/channels/bioconda/packages/oncofuse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oncofuse/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikessh/oncofuse
- **Stars**: N/A
### Original Help Text
```text
usage: Oncofuse.jar [options] input_file input_type [tissue_type or -] output_file
                    Supported input types: coord, fcatcher, fcatcher-N-M, tophat, tophat-N-M,
                    tophat-post, rnastar, rnastar-N-M, starfusion, starfusion-N-M
                    Running with input type args: replace N by number of spanning reads and M by
                    number of total supporting read pairs
                    Supported tissue types: EPI, HEM, MES, AVG or -
                    Version 1.0.9b2, 6May2015
 -a <hgXX>      Genome assembly version, default is hg19. Allowed values: hg18, hg19, hg38
 -h             display help message
 -p <integer>   Number of threads, uses all available processors by default
```

