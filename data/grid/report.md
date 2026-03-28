# grid CWL Generation Report

## grid_single

### Tool Description
Processes single-end sequencing data or SAM alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/grid:1.3--0
- **Homepage**: https://github.com/ohlab/GRiD
- **Package**: https://anaconda.org/channels/bioconda/packages/grid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grid/overview
- **Total Downloads**: 21.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ohlab/GRiD
- **Stars**: N/A
### Original Help Text
```text
Usage:
    grid single <options>
    <options>
    -r      Samples directory (single end reads or SAM alignment files)
    -e      Sample filename extension (fq, fastq, fastq.gz, sam) [default fastq]
    -o      Output directory
    -g      Reference genome (fasta)
    -l      Path to file listing a subset of reads
            for analysis [default = analyze all samples in reads directory]
    -n INT  Number of threads [default 1]
    -h      Display this message
```


## grid_multiplex

### Tool Description
Multiplexing tool for grid data.

### Metadata
- **Docker Image**: quay.io/biocontainers/grid:1.3--0
- **Homepage**: https://github.com/ohlab/GRiD
- **Package**: https://anaconda.org/channels/bioconda/packages/grid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    grid multiplex <options>
    <options>
    -r         Samples directory (single end reads)
    -e         Sample filename extension (fq, fastq, fastq.gz) [default fastq]
    -o         Output directory
    -d         GRiD database directory
    -c  FLOAT  Coverage cutoff (>= 0.2) [default 1]
    -p         Enable reassignment of ambiguous reads using Pathoscope2
    -t  INT    Theta prior for reads reassignment [default 0]. Requires the -p flag
    -l         Path to file listing a subset of reads
               for analysis [default = analyze all samples in reads directory]
    -m         merge output tables into a single matrix file
    -n  INT    Number of threads [default 1]
    -h         Display this message
```


## Metadata
- **Skill**: generated
