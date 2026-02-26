# gapless CWL Generation Report

## gapless_gapless.sh

### Tool Description
Improves input assembly with reads in {long_reads}.fq using gapless, minimap2, racon and seqtk

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/schmeing/gapless
- **Stars**: N/A
### Original Help Text
```text
Usage: gapless.sh [OPTIONS] {long_reads}.fq
Improves input assembly with reads in {long_reads}.fq using gapless, minimap2, racon and seqtk
  -h -?                    Display this help and exit
  -i [STRING]              Input assembly (fasta)
  -j [INT]                 Number of threads [4]
  -n [INT]                 Number of iterations [3]
  -o [STRING]              Output directory (improved assembly is written to gapless.fa in this directory) [gapless_run]
  -r                       Restart at the start iteration and overwrite instead of incorporat already present files
  -s [INT]                 Start iteration (Previous runs must be present in output directory) [1]
  -t [STRING]              Type of long reads ('pb_clr','pb_hifi','nanopore')
```


## gapless_gapless.py

### Tool Description
Program: gapless
Version: 0.4
Contact: https://github.com/schmeing/gapless

### Metadata
- **Docker Image**: quay.io/biocontainers/gapless:0.4--hdfd78af_0
- **Homepage**: https://github.com/schmeing/gapless
- **Package**: https://anaconda.org/channels/bioconda/packages/gapless/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown module: -help.
Program: gapless
Version: 0.4
Contact: https://github.com/schmeing/gapless

Usage:  gapless.py <module> [options]
Modules:
split         Splits scaffolds into contigs
scaffold      Scaffolds contigs and assigns reads to gaps
extend        Extend scaffold ends
finish        Create new fasta assembly file
visualize     Visualizes regions to manually inspect breaks or joins
test          Short test
```

