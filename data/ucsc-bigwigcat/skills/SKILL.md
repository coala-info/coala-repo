---
name: ucsc-bigwigcat
description: ucsc-bigwigcat concatenates multiple bigWig files containing non-overlapping genomic data into a single output file. Use when user asks to join bigWig files, concatenate bigWig files, merge chromosome-level bigWig files, or assemble a full-genome track.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bigwigcat

## Overview
The `bigWigCat` utility is a specialized tool from the UCSC Genome Browser "kent" suite used to join multiple bigWig files. Unlike `bigWigMerge`, which is designed to handle overlapping data by summing or averaging signals, `bigWigCat` is optimized for non-overlapping data. It effectively concatenates the data blocks from multiple files into one, making it a highly efficient choice for assembling a full-genome track from individual chromosome files or merging tiled data.

## Command Line Usage

The basic syntax for `bigWigCat` requires the output filename followed by the input files:

```bash
bigWigCat output.bw input1.bw input2.bw [inputN.bw ...]
```

### Common Patterns

1. **Merging Chromosome-level Files**:
   If you have generated bigWig files for each chromosome separately to save time, use `bigWigCat` to create the final assembly:
   ```bash
   bigWigCat human_genome_full.bw chr1.bw chr2.bw chr3.bw ...
   ```

2. **Using Wildcards**:
   If your files are named systematically, you can use standard shell expansion:
   ```bash
   bigWigCat combined_track.bw part_*.bw
   ```

## Expert Tips and Best Practices

*   **Strict Non-Overlap Requirement**: `bigWigCat` assumes that the data intervals in the input files are mutually exclusive. If your data contains overlapping genomic coordinates, the resulting bigWig may be invalid or the tool may fail. For overlapping data, use `bigWigMerge` instead.
*   **Input Order**: While the tool handles the internal indexing, it is best practice to provide input files in genomic order (e.g., chr1, chr2, etc.) to ensure consistent processing.
*   **Validation**: After concatenation, it is recommended to run `bigWigInfo` on the output file to verify that the chromosome counts and total item counts match the sum of the inputs.
*   **Permissions**: If running the binary for the first time after downloading from the UCSC server, ensure it has execution permissions:
    ```bash
    chmod +x bigWigCat
    ./bigWigCat
    ```
*   **Memory Efficiency**: Because `bigWigCat` does not perform complex signal arithmetic (like averaging), it is significantly faster and uses less memory than `bigWigMerge` for large-scale concatenation tasks.

## Reference documentation
- [bioconda | ucsc-bigwigcat Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigcat_overview.md)
- [UCSC Genome Browser Build Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)