---
name: idemux
description: idemux sorts paired-end sequencing reads into individual sample files based on index sequences and provides automated error correction for Lexogen indices. Use when user asks to demultiplex FASTQ files, sort reads by barcode, or process Lexogen unique dual indices.
homepage: https://github.com/lexogen-tools/idemux
metadata:
  docker_image: "quay.io/biocontainers/idemux:0.1.6--pyhdfd78af_0"
---

# idemux

## Overview
The `idemux` tool is a specialized utility for sorting paired-end sequencing reads into individual sample files based on index sequences. While it can demultiplex any standard barcodes found in FASTQ headers, it is specifically optimized for Lexogen indices, providing automated error correction for 12 nt Unique Dual Indices (UDIs) to maximize usable read yield. It is particularly effective for workflows involving inline barcodes (i1) and handles common library preparation variations like reverse-complemented i5 indices.

## Installation
Install via Bioconda or Pip:
```bash
conda install -c bioconda idemux
# OR
pip install idemux
```

## Command Line Usage
The basic syntax requires both read files, a sample sheet, and an output directory.

```bash
idemux --r1 read_1.fastq.gz --r2 read_2.fastq.gz --sample-sheet samples.csv --out ./demultiplexed_results/
```

### Key Arguments
- `--r1`, `--r2`: Paths to the paired-end FASTQ files.
- `--sample-sheet`: Path to the CSV defining sample-barcode mappings.
- `--out`: Directory where demultiplexed FASTQ files will be saved.
- `--i1-start`: The starting position of the i1 barcode in Read 2 (required if using i1 barcodes).
- `--i5-rc`: Use this flag if the i5 index was sequenced as a reverse complement; do not manually reverse-complement sequences in the sample sheet.

## Sample Sheet Configuration
The sample sheet must be a CSV file with a specific header and four columns.

**Format:**
```csv
sample_name,i7,i5,i1
Sample_A,AAAACATGCGTT,CCCCACTGAGTT,AAAACATGCGTT
Sample_B,AAAATCCCAGTT,CCCCTAAACGTT,
Sample_C,GAAAATTTACGC,,GAAAATTTACGC
```

**Rules for Success:**
- **Uniqueness**: Both `sample_name` and the specific barcode combinations must be unique.
- **Consistency**: i7 and i5 indices must be used consistently (either present for all samples or none).
- **i1 Flexibility**: Unlike i7/i5, the i1 index can be used for only a subset of samples.
- **Empty Fields**: Indicate the absence of a barcode by leaving the column empty (e.g., `,,`).

## Expert Tips and Best Practices
- **Input Preparation**: `idemux` expects the i7 and i5 barcode sequences to be present in the read ID line of the FASTQ files (e.g., `@ID... 1:N:0:TTAGGACGCAAA+GGGTCTGCCGAA`). If using `bcl2fastq`, run it with `--barcode-mismatches 0` and a dummy sample sheet to ensure all reads are output to "Undetermined" files with the index sequences preserved in the headers.
- **Error Correction**: To benefit from Lexogen's error correction, ensure your 12 nt UDIs are sequenced to at least 8 nt.
- **Memory Management**: When processing very large FASTQ files, ensure the output file system has sufficient space, as `idemux` will generate multiple individual FASTQ files simultaneously.
- **Validation**: If `idemux` throws an error regarding ambiguous combinations, check for overlapping barcode sequences in your sample sheet, especially if using shorter index reads.

## Reference documentation
- [Idemux GitHub Repository](./references/github_com_Lexogen-Tools_idemux.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_idemux_overview.md)