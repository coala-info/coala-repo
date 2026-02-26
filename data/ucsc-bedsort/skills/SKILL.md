---
name: ucsc-bedsort
description: ucsc-bedsort orders BED files by chromosome and then by start position. Use when user asks to order BED files, sort BED files, prepare BED files for BigBed conversion, or prepare BED files for UCSC Genome Browser visualization.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedsort

## Overview
ucsc-bedsort (commonly invoked as `bedSort`) is a specialized utility from the UCSC Kent toolset designed to order BED files by chromosome and then by start position. Unlike general-purpose sorting tools, it is optimized for genomic data structures, ensuring that the output is perfectly indexed for high-performance visualization and downstream processing in the UCSC Genome Browser ecosystem.

## Usage Instructions

### Basic Syntax
The tool requires an input file and an output destination. It does not support piping to stdout by default in most versions.

```bash
bedSort input.bed output.bed
```

### Standard Workflow: Preparing for BigBed
The most common use case for `bedSort` is as a mandatory preprocessing step for creating BigBed files.

1. **Sort the BED file:**
   ```bash
   bedSort my_data.bed my_data.sorted.bed
   ```
2. **Convert to BigBed:**
   ```bash
   bedToBigBed my_data.sorted.bed hg38.chrom.sizes my_data.bb
   ```

## Expert Tips and Best Practices

### Performance vs. GNU Sort
While `sort -k1,1 -k2,2n` can achieve similar results, `bedSort` is preferred because:
- It is specifically tuned for the UCSC chromosome naming conventions.
- It is often faster and more memory-efficient for extremely large genomic datasets.
- It guarantees compatibility with the internal indexing logic of `bedToBigBed`.

### Handling Large Files
`bedSort` loads the data into memory to perform the sort. If you are working with a file that exceeds available RAM, you may need to split the file by chromosome, sort individually, and then concatenate, though `bedSort` is generally robust for most standard experimental datasets (e.g., ChIP-seq, RNA-seq).

### Validation
After sorting, you can verify the file is ready for UCSC tools by checking that:
1. Chromosomes are grouped together.
2. Within each chromosome, the `chromStart` values are in non-decreasing order.

## Reference documentation
- [ucsc-bedsort Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedsort_overview.md)
- [UCSC Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)