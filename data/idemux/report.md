# idemux CWL Generation Report

## idemux

### Tool Description
A tool to demultiplex fastq files based on Lexogen i7,i5,i1 barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/idemux:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/lexogen-tools/idemux
- **Package**: https://anaconda.org/channels/bioconda/packages/idemux/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/idemux/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lexogen-tools/idemux
- **Stars**: N/A
### Original Help Text
```text
usage: idemux [-h] --r1 READ1 --r2 READ2 --sample-sheet SAMPLE_SHEET --out
              OUTPUT_DIR [--i5-rc] [--i1-start I1_START] [-v]

A tool to demultiplex fastq files based on Lexogen i7,i5,i1 barcodes.

optional arguments:
  -h, --help            show this help message and exit
  --i5-rc               when the i5 barcode has been sequenced as reverse
                        complement. make sure to enter non-reverse complement
                        sequences in the barcode file
  --i1-start I1_START   start position of the i1 index (1-based) on read 2
                        (default: 11)
  -v, --version         show program's version number and exit

required arguments:
  --r1 READ1            gzipped read 1 fastq file
  --r2 READ2            path to gzipped read 2 fastq file
  --sample-sheet SAMPLE_SHEET
                        csv file describing sample names, and barcode
                        combinations
  --out OUTPUT_DIR      where to write the output files
```

