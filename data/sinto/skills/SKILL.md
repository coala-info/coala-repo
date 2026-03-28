---
name: sinto
description: Sinto is a suite of command-line utilities designed to manipulate single-cell alignment files and generate fragment files based on cell-level metadata. Use when user asks to filter BAM files by barcode, create scATAC-seq fragment files, add or move BAM tags, or process FASTQ files for single-cell analysis.
homepage: https://timoast.github.io/sinto/
---

# sinto

## Overview

Sinto is a specialized suite of command-line utilities designed to handle the unique requirements of single-cell sequencing data. It provides efficient methods for manipulating alignment files (BAM) based on cell-level metadata. It is particularly useful for scATAC-seq workflows where fragment files are required, or for scRNA-seq tasks involving the management of Cell Barcode (CB) and Unique Molecular Identifier (UB/UMI) tags.

## Basic Usage and Installation

Install sinto via pip or bioconda:

```bash
pip install sinto
# OR
conda install -c bioconda sinto
```

All commands follow the pattern: `sinto <command> [options]`

## Core Command Patterns

### Subsetting BAM Files by Barcode
Use `filterbarcodes` to create a new BAM file containing only reads from specific cells or to split a BAM by cluster.

```bash
# Filter BAM for specific barcodes listed in a file
sinto filterbarcodes -b input.bam -c barcodes.txt -o filtered.bam

# Split BAM into multiple files based on a mapping file (barcode <tab> cluster)
sinto filterbarcodes -b input.bam -c metadata.tsv -p 8
```
*   **Tip**: The barcode file can be gzipped.
*   **Tip**: Use `-p` to specify the number of processors for faster execution.

### Creating scATAC-seq Fragment Files
The `fragments` command is the standard way to generate a fragment file from an aligned scATAC-seq BAM.

```bash
sinto fragments -b input.bam -f fragments.tsv.gz
```
*   **Requirement**: The BAM file must be indexed.
*   **Best Practice**: Always use the `.gz` extension for the output to ensure the file is compressed, as fragment files can be very large.

### Manipulating Barcodes and Tags
Sinto can move barcodes between read names and BAM tags, which is often necessary when switching between different pipeline requirements (e.g., CellRanger vs. custom scripts).

```bash
# Copy barcode from read name to the 'CB' tag
sinto barcode -b input.bam -o output.bam --barcode_readname

# Add tags to a BAM file from a CSV file
sinto addtags -b input.bam -c tags.csv -o tagged.bam
```

### Processing FASTQ Files
Add cell barcodes directly to FASTQ read names before alignment.

```bash
sinto fastq -r1 read1.fastq.gz -r2 read2.fastq.gz -b barcodes.fastq.gz -o output_prefix
```

## Expert Tips

1.  **Multi-threading**: Most sinto commands support the `-p` or `--nproc` argument. Increasing this is the most effective way to speed up processing of large single-cell datasets.
2.  **Memory Management**: When using `filterbarcodes` with many output files (e.g., splitting by 20+ clusters), ensure your system's file descriptor limit (`ulimit -n`) is high enough to handle the simultaneous open BAM files.
3.  **Read Group Integration**: Use `tag2rg` to convert a BAM tag (like a cluster ID) into a Read Group (RG). This allows you to use standard tools like GATK or Samtools that operate on Read Groups rather than custom tags.
4.  **Tag Copying**: Use `copytag` to duplicate information between tags (e.g., copying `CB` to `CR`) without re-processing the entire file through a heavy pipeline.



## Subcommands

| Command | Description |
|---------|-------------|
| sinto addtags | Add read tags to reads from individual cells |
| sinto fragments | Create ATAC-seq fragment file from BAM file |
| sinto nametotag | Copy cell barcode sequences from read name to read tag |
| sinto tagtorg | Append a read tag to the read group ID of each read. Also appends the read tag to the SM field of the read group. |
| sinto_barcode | Add cell barcode sequences to read names in FASTQ file. |
| sinto_blocks | Create scRNA-seq block file from BAM file |
| sinto_filterbarcodes | Filter reads based on input list of cell barcodes |
| sinto_tagtoname | Copy cell barcode sequences from tag to read names. Cell barcodes will be added as a readname prefix, followed by ":" |
| sinto_tagtotag | Copies BAM entries to a new file while copying a read tag to another read tag and optionally deleting the originating tag. |

## Reference documentation

- [Sinto: single-cell analysis tools](./references/github_com_timoast_sinto_blob_master_README.rst.md)
- [Basic Usage](./references/timoast_github_io_sinto_basic_usage.html.md)
- [scATAC-seq Fragments](./references/timoast_github_io_sinto_scatac.html.md)