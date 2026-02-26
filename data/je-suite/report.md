# je-suite CWL Generation Report

## je-suite_je

### Tool Description
JE-Suite is a collection of tools for processing sequencing data, particularly for single-cell RNA sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Picked up _JAVA_OPTIONS: -Xmx4G -Xms256m
Usage:   je <command> [options] 

with command in : 
	 clip      		 clips barcodes/UMIs from fastq sequence and places them in read name headers 
	 debarcode 		 demultiplexes fastq file(s) into user-defined output files, with optional handling of molecular barcodes
	 demultiplex 		 demultiplexes fastq file(s) with Je 1.x implementation, with optional handling of molecular barcodes for further use in 'dupes' module
	 demultiplex-illu 	 demultiplexes fastq file(s) using Illumina Index files with Je 1.x implementation, with optional handling of molecular barcodes for further use in 'dupes' module
	 markdupes     		 removes read duplicates based on molecular barcodes found in read name headers (as produced by clip or plex)
	 dropseq    		 clips cell barcode and UMI from read 1 and adds them to header of read 2. This command is for processing drop-seq results.
	 retag    		 extracts barcode and UMI sequence(s) embedded in read names and tag reads with proper BAM tag.

Version : 2.0.RC
```

