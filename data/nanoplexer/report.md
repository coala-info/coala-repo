# nanoplexer CWL Generation Report

## nanoplexer

### Tool Description
Demultiplexes Nanopore sequencing reads based on barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoplexer:0.1.2--h7132678_2
- **Homepage**: https://github.com/hanyue36/nanoplexer
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoplexer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanoplexer/overview
- **Total Downloads**: 13.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hanyue36/nanoplexer
- **Stars**: N/A
### Original Help Text
```text
Usage: nanoplexer [options] input.fastq

Options:
 -b  FILE    barcode file
 -d  FILE    dual barcode pair file
 -p  CHAR    output path
 -l  FILE    output log file
 -M  CHAR    output mode, fastq or fasta [default fastq]
 -B  NUM     batch size [default 400M]
 -t  INT     number of threads [default 3]
 -L  INT     target length for detecting barcode [default 150]
 -m  INT     match score [default 2]
 -x  INT     mismatch score [default 2]
 -o  INT     gap open score [default 3]
 -e  INT     gap extension score [default 1]
 -s  INT     minimal alignment score for demultiplexing
 -i          ignore parameter estimation
 -h          help information
 -v          show version number

-b -p must be specified.

Example:
nanoplexer -b barcode.fa -p /ouput/ input.fastq
```

