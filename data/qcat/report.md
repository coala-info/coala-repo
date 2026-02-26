# qcat CWL Generation Report

## qcat

### Tool Description
Python command-line tool for demultiplexing Oxford Nanopore reads from FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/qcat:1.1.0--py_0
- **Homepage**: https://github.com/nanoporetech/qcat
- **Package**: https://anaconda.org/channels/bioconda/packages/qcat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qcat/overview
- **Total Downloads**: 16.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/qcat
- **Stars**: N/A
### Original Help Text
```text
usage: qcat [-h] [-V] [-l LOG] [--quiet] [-f FASTQ] [-b BARCODE_DIR]
            [-o OUTPUT] [--min-score MIN_QUAL] [--detect-middle] [-t THREADS]
            [--min-read-length MIN_LENGTH] [--tsv] [--trim]
            [-k {Auto,NBD103/NBD104,PBK004/LWB001,RAB204,PBC001,PBC096,NBD114,RAB204/RAB214,RAB214,DUAL,RBK001,NBD104/NBD114,RPB004/RLB001,RBK004,VMK001}]
            [--list-kits] [--guppy | --epi2me | --dual | --simple]
            [--no-batch] [--filter-barcodes]
            [--simple-barcodes SIMPLE_BARCODES]

Python command-line tool for demultiplexing Oxford Nanopore reads from FASTQ files

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -l LOG, --log LOG     Print debug information
  --quiet               Don't print summary

General settings:
  -f FASTQ, --fastq FASTQ
                        Barcoded read file
  -b BARCODE_DIR, --barcode_dir BARCODE_DIR
                        If specified, qcat will demultiplex reads to this
                        folder
  -o OUTPUT, --output OUTPUT
                        Output file trimmed reads will be written to (default:
                        stdout).
  --min-score MIN_QUAL  Minimum barcode score. Barcode calls with a lower
                        score will be discarded. Must be between 0 and 100.
                        (default: 60)
  --detect-middle       Search for adapters in the whole read
  -t THREADS, --threads THREADS
                        Number of threads. Only works with in guppy mode
  --min-read-length MIN_LENGTH
                        Reads short than <min-read-length> after trimming will
                        be discarded.
  --tsv                 Prints a tsv file containing barcode information each
                        read to stdout.
  --trim                Remove adapter and barcode sequences from reads.
  -k {Auto,NBD103/NBD104,PBK004/LWB001,RAB204,PBC001,PBC096,NBD114,RAB204/RAB214,RAB214,DUAL,RBK001,NBD104/NBD114,RPB004/RLB001,RBK004,VMK001}, --kit {Auto,NBD103/NBD104,PBK004/LWB001,RAB204,PBC001,PBC096,NBD114,RAB204/RAB214,RAB214,DUAL,RBK001,NBD104/NBD114,RPB004/RLB001,RBK004,VMK001}
                        Sequencing kit. Specifying the correct kit will
                        improve sensitivity and specificity and runtime
                        (default: auto)
  --list-kits           List all supported kits

Demultiplexing modes:
  --guppy               Use Guppy's demultiplexing algorithm (default: false)
  --epi2me              Use EPI2ME's demultiplexing algorithm (default: true)
  --dual                Use dual barcoding algorithm
  --simple              Use simple demultiplexing algorithm. Only looks for
                        barcodes, not for adapter sequences. Use only for
                        testing purposes!

EPI2ME options (only valid with --epi2me):
  --no-batch            Don't use information from multiple reads for kit
                        detection (default: false)
  --filter-barcodes     Filter rare barcode calls when run in batch mode

Simple options (only valid with --simple):
  --simple-barcodes SIMPLE_BARCODES
                        Use 12 (standard) or 96 (extended) barcodes for
                        demultiplexing
```

