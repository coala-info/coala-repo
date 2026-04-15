---
name: sabre
description: sabre demultiplexes barcoded FastQ files into separate sample files while removing barcode sequences. Use when user asks to demultiplex single-end or paired-end reads, partition multiplexed FastQ files based on barcodes, or strip barcode sequences from sequencing data.
homepage: https://github.com/najoshi/sabre/
metadata:
  docker_image: "quay.io/biocontainers/sabre:1.000--h577a1d6_6"
---

# sabre

## Overview
`sabre` is a high-performance tool designed to partition multiplexed FastQ files into individual samples based on a list of known barcodes. It streamlines the preprocessing workflow by simultaneously identifying barcodes, assigning reads to specific output files, and stripping the barcode sequences (and their corresponding quality values) from the reads. It is particularly useful for handling large datasets from platforms like Illumina where multiple samples are sequenced in a single lane.

## Barcode Data File Format
The barcode file is a plain text file where each line maps a barcode to its destination file(s). Fields must be separated by tabs.

### Single-End Format
```text
barcode1	sample1.fastq
barcode2	sample2.fastq
```

### Paired-End Format
```text
barcode1	sample1_R1.fastq	sample1_R2.fastq
barcode2	sample2_R1.fastq	sample2_R2.fastq
```

## Common CLI Patterns

### Single-End Demultiplexing
To demultiplex a single FastQ file:
`sabre se -f input.fastq -b barcodes.txt -u unknown.fastq`

### Paired-End Demultiplexing
To demultiplex paired-end reads where the barcode is at the beginning of the first read (R1):
`sabre pe -f input_R1.fastq -r input_R2.fastq -b barcodes.txt -u unknown_R1.fastq -w unknown_R2.fastq`

### Handling Mismatches
By default, `sabre` requires an exact match. Use the `-m` flag to allow a specific number of mismatches:
`sabre se -m 1 -f input.fastq -b barcodes.txt -u unknown.fastq`

### Stripping Barcodes from Both Ends (Paired-End)
If your library preparation results in barcodes on both reads, or if you want to ensure the barcode sequence is removed from the start of the paired read (R2) even if it was only matched in R1, use the `-c` option:
`sabre pe -c -f input_R1.fastq -r input_R2.fastq -b barcodes.txt -u unk_R1.fastq -w unk_R2.fastq`

## Expert Tips and Best Practices
- **Gzip Support**: `sabre` natively supports gzipped input files (`.fastq.gz`), which is recommended to save disk space and I/O overhead.
- **Summary Output**: Always capture or review the standard output after a run. `sabre` provides a summary of how many records were assigned to each barcode file, which is critical for assessing library balance and sequencing quality.
- **Fasta Compatibility**: While designed for FastQ, you can process Fasta data by converting it to a "fake" FastQ (assigning dummy quality scores), as `sabre` does not use quality values for its matching logic—it only removes them.
- **Tab Delimiters**: Ensure your barcode data file uses actual tab characters. Spaces can cause the tool to misinterpret file names or barcodes.
- **Unknown Reads**: Always provide a dedicated file for unknown reads (`-u` and `-w`). Monitoring the size of these files helps identify issues with barcode design or sequencing errors in the index region.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_najoshi_sabre.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sabre_overview.md)