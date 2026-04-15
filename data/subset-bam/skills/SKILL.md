---
name: subset-bam
description: subset-bam efficiently extracts alignments from 10x Genomics BAM files based on specific cell barcodes or other BAM tags. Use when user asks to subset a BAM file by cell barcodes, extract specific alignments using BAM tags, or reduce the size of sequencing files for specific biological subsets.
homepage: https://github.com/10XGenomics/subset-bam
metadata:
  docker_image: "quay.io/biocontainers/subset-bam:1.1.0--h4349ce8_0"
---

# subset-bam

## Overview

`subset-bam` is a high-performance utility written in Rust that allows for the efficient extraction of alignments from 10x Genomics BAM files based on specific tags. While most commonly used to subset data by the cell barcode tag (`CB`), it can be configured to use any BAM tag. The tool is essential for researchers who need to reduce the size of massive sequencing files to focus on specific biological subsets, such as specific cell clusters identified during single-cell analysis.

## Usage Instructions

### Basic Command
To subset a BAM file using a list of cell barcodes:
```bash
subset-bam --bam input.bam --cell-barcodes barcodes.tsv --out-bam subset_output.bam
```

### Required Inputs
- **Input BAM (`-b`, `--bam`)**: The source 10x Genomics BAM file. A corresponding index file (`.bai`) must exist in the same directory.
- **Barcode File (`-c`, `--cell-barcodes`)**: A plain text file containing one barcode per line. This typically corresponds to the `barcodes.tsv` file found in Cell Ranger output directories (e.g., `outs/filtered_gene_bc_matrices/`).
- **Output BAM (`-o`, `--out-bam`)**: The destination path for the filtered BAM file.

### Performance and Optimization
- **Multithreading**: Use the `--cores` flag to speed up the subsetting process.
  ```bash
  subset-bam --bam input.bam --cell-barcodes barcodes.tsv --out-bam output.bam --cores 8
  ```
- **Logging**: For troubleshooting or monitoring progress, adjust the `--log-level` (options: `info`, `error`, `debug`).
  ```bash
  subset-bam --bam input.bam --cell-barcodes barcodes.tsv --out-bam output.bam --log-level info
  ```

### Advanced Tag Subsetting
If you are working with non-standard data (e.g., LongRanger output) or need to subset by a different attribute, use the `--bam-tag` flag:
```bash
subset-bam --bam input.bam --cell-barcodes tags.txt --out-bam output.bam --bam-tag BX
```

## Expert Tips and Best Practices

- **Temporary Storage**: `subset-bam` writes temporary files to your `$TMPDIR` before the final concatenation. Ensure this location has sufficient disk space (comparable to the size of the expected output) and is writable.
- **Custom TMPDIR**: If your default temporary directory is too small, redirect it before running the tool:
  ```bash
  export TMPDIR=/path/to/large/disk/space
  ```
- **Barcode Matching**: Ensure the barcodes in your `.tsv` file exactly match the format in the BAM file. For example, if your BAM tags include a GEM well suffix (e.g., `AAACCCAAGAAACACT-1`), your barcode file must also include it.
- **Empty Outputs**: If the tool completes but the output BAM is unexpectedly small or empty, verify that the input BAM is indexed and that the barcodes in your list actually exist within the specified `--bam-tag`.
- **Gzip Limitation**: Note that some versions of the tool may panic if the barcode file is gzipped. Always use an uncompressed `.tsv` or `.txt` file for the `--cell-barcodes` argument.

## Reference documentation
- [subset-bam Overview](./references/anaconda_org_channels_bioconda_packages_subset-bam_overview.md)
- [subset-bam GitHub Documentation](./references/github_com_10XGenomics_subset-bam.md)