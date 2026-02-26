# toulligqc CWL Generation Report

## toulligqc

### Tool Description
ToulligQC is a tool for quality control of Oxford Nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/toulligqc:2.8.3--pyhdfd78af_0
- **Homepage**: https://github.com/GenomicParisCentre/toulligQC
- **Package**: https://anaconda.org/channels/bioconda/packages/toulligqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/toulligqc/overview
- **Total Downloads**: 57.8K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/GenomicParisCentre/toulligQC
- **Stars**: N/A
### Original Help Text
```text
usage: ToulligQC V2.8.3 [-a SEQUENCING_SUMMARY_SOURCE] [-t TELEMETRY_SOURCE]
                        [-f FAST5_SOURCE] [-p POD5_SOURCE] [-q FASTQ] [-u BAM]
                        [-s SAMPLESHEET] [--use-aliases-for-barcodes]
                        [--thread THREAD] [--batch-size BATCH_SIZE]
                        [--qscore-threshold THRESHOLD] [-n REPORT_NAME]
                        [--output-directory OUTPUT] [-o HTML_REPORT_PATH]
                        [--data-report-path DATA_REPORT_PATH]
                        [--images-directory IMAGES_DIRECTORY]
                        [-d SEQUENCING_SUMMARY_1DSQR_SOURCE] [-b]
                        [-l BARCODES] [--quiet] [--force] [-h] [--version]

required arguments:
  -a SEQUENCING_SUMMARY_SOURCE, --sequencing-summary-source SEQUENCING_SUMMARY_SOURCE
                        Basecaller sequencing summary source, can be
                        compressed with gzip (.gz) or bzip2 (.bz2)
  -t TELEMETRY_SOURCE, --telemetry-source TELEMETRY_SOURCE
                        Basecaller telemetry file source, can be compressed
                        with gzip (.gz) or bzip2 (.bz2)
  -f FAST5_SOURCE, --fast5-source FAST5_SOURCE
                        Fast5 file source (necessary if no telemetry file),
                        can also be in a tar.gz/tar.bz2 archive or a directory
  -p POD5_SOURCE, --pod5-source POD5_SOURCE
                        pod5 file source (necessary if no telemetry file), can
                        also be in a tar.gz/tar.bz2 archive or a directory
  -q FASTQ, --fastq FASTQ
                        FASTQ file (necessary if no sequencing summary file),
                        can also be in a tar.gz archive
  -u BAM, --bam BAM     uBAM file (necessary if no sequencing summary file),
                        can also be in SAM format

optional arguments:
  -s SAMPLESHEET, --samplesheet SAMPLESHEET
                        a samplesheet (.csv file) to fill out sample names in
                        MinKNOW
  --use-aliases-for-barcodes
                        Use the "alias" column for barcodes names in the
                        sample sheet file instead of the "barcode" column
  --thread THREAD       Number of threads
  --batch-size BATCH_SIZE
                        Batch size
  --qscore-threshold THRESHOLD
                        Qscore threshold
  -n REPORT_NAME, --report-name REPORT_NAME
                        Report name
  --output-directory OUTPUT
                        Output directory
  -o HTML_REPORT_PATH, --html-report-path HTML_REPORT_PATH
                        Output HTML report
  --data-report-path DATA_REPORT_PATH
                        Output data report
  --images-directory IMAGES_DIRECTORY
                        Images directory
  -d SEQUENCING_SUMMARY_1DSQR_SOURCE, --sequencing-summary-1dsqr-source SEQUENCING_SUMMARY_1DSQR_SOURCE
                        Basecaller 1dsq summary source
  -b, --barcoding       Option for barcode usage
  -l BARCODES, --barcodes BARCODES
                        Comma-separated barcode list (e.g.,
                        BC05,RB09,NB01,barcode10) or a range separated with
                        ":" (e.g., barcode01:barcode19)
  --quiet               Quiet mode
  --force               Force overwriting of existing files
  -h, --help            Show this help message and exit
  --version             show program's version number and exit
```

