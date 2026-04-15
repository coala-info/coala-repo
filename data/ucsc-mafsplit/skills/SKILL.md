---
name: ucsc-mafsplit
description: ucsc-mafsplit breaks down large Multiple Alignment Format (MAF) files into smaller subsets. Use when user asks to split MAF files by count, split MAF files by genomic position, or prepare MAF files for parallel processing.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-mafsplit:482--h0b57e2e_0"
---

# ucsc-mafsplit

## Overview
The `mafSplit` utility is part of the UCSC Genome Browser "kent" toolset. It is designed to break down massive Multiple Alignment Format (MAF) files—which often contain whole-genome alignments across dozens of species—into smaller subsets. This is a critical preprocessing step for tools that cannot handle monolithic files or for workflows that distribute analysis across a compute cluster.

## Usage Patterns

### Basic Syntax
```bash
mafSplit [options] <num_files> <prefix> <input.maf>
```

### Common Workflows

**1. Splitting by File Count**
To split a large alignment into a specific number of roughly equal-sized files:
```bash
mafSplit 10 split_prefix_ input.maf
```
This creates `split_prefix_000.maf` through `split_prefix_009.maf`.

**2. Splitting by Genomic Position (mafSplitPos)**
While `mafSplit` handles simple chunking, the related utility `mafSplitPos` is often used when alignments need to be split according to specific chromosome/scaffold boundaries:
```bash
mafSplitPos <chunkSize> <prefix> <input.maf> <chrom.sizes>
```

## Expert Tips and Best Practices

*   **Memory Management:** `mafSplit` is generally efficient, but for extremely deep alignments (many species), ensure your environment has sufficient heap space.
*   **Preserving Headers:** The tool maintains the MAF version header in each split file, ensuring they remain valid inputs for other UCSC tools like `mafToAxt` or `mafGene`.
*   **Downstream Parallelization:** When processing whole-genome alignments, split the MAF files first. Most comparative genomics tools (like `phastCons` or `phyloP`) perform significantly better on smaller, localized chunks.
*   **File Permissions:** If you encounter "permission denied" after downloading the binary directly from UCSC, remember to set the executable bit: `chmod +x mafSplit`.
*   **Verification:** After splitting, use `faSize` or `mafCoverage` on the resulting chunks to ensure no sequence data was lost during the process.

## Reference documentation
- [UCSC Genome Browser Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Tool List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)