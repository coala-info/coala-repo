# pydemult CWL Generation Report

## pydemult

### Tool Description
Demultiplexing of fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/pydemult:0.6--py_0
- **Homepage**: https://github.com/jenzopr/pydemult
- **Package**: https://anaconda.org/channels/bioconda/packages/pydemult/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pydemult/overview
- **Total Downloads**: 11.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jenzopr/pydemult
- **Stars**: N/A
### Original Help Text
```text
usage: pydemult [-h] --fastq input.fastq.gz --samplesheet samplesheet.txt
                [--column-separator COLUMN_SEPARATOR]
                [--barcode-column Barcode] [--sample-column Sample]
                [--barcode-regex BARCODE_REGEX] [--edit-distance 1]
                [--edit-alphabet ACGTN] [--buffer-size 4000000]
                [--output fastq] [--output-file-suffix .fastq.gz]
                [--write-unmatched] [--keep-empty] [--threads 1]
                [--writer-threads 2] [-v] [--debug]

Demultiplexing of fastq files

optional arguments:
  -h, --help            show this help message and exit
  --fastq input.fastq.gz, -f input.fastq.gz
                        FASTQ file for demultiplexing.
  --samplesheet samplesheet.txt, -s samplesheet.txt
                        Samplesheet containing barcodes and samplenames
  --column-separator COLUMN_SEPARATOR
                        Separator that is used in samplesheet
  --barcode-column Barcode
                        Name of the column containing barcodes
  --sample-column Sample
                        Name of the column containing sample names
  --barcode-regex BARCODE_REGEX, -b BARCODE_REGEX
                        Regular expression to parse cell barcode (CB) and UMIs
                        (UMI) from read names
  --edit-distance 1     Maximum allowed edit distance for barcodes
  --edit-alphabet ACGTN
                        The alphabet that is used to created edited barcodes
  --buffer-size 4000000
                        Buffer size for the FASTQ reader (in Bytes). Must be
                        large enough to contain the largest entry.
  --output fastq, -o fastq
                        Output directory to write individual fastq files to.
  --output-file-suffix .fastq.gz
                        A suffix to append to individual fastq files.
  --write-unmatched     Write reads with unmatched barcodes into
                        unmatched.fastq.gz
  --keep-empty          Keep empty sequences in demultiplexed output files.
  --threads 1, -t 1     Number of threads to use for multiprocessing.
  --writer-threads 2, -w 2
                        Number of threads to use for writing
  -v, --version         show program's version number and exit
  --debug
```

