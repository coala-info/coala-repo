---
name: ucsc-bedcoverage
description: The ucsc-bedcoverage tool calculates genomic coverage from BED files. Use when user asks to determine total bases covered, calculate percentage of coverage, assess sequencing breadth, identify assembly gaps, or calculate genomic annotation footprints.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedcoverage

## Overview
The `bedCoverage` utility is part of the UCSC Genome Browser "kent" toolset. It is designed to provide a high-level analysis of genomic coverage by processing BED files. Unlike tools that calculate per-base depth (like `samtools depth`), `bedCoverage` is primarily used to determine the total number of bases covered and the percentage of coverage across chromosomes or the entire genome. This is particularly useful for assessing the breadth of sequencing assays, identifying gaps in assemblies, or calculating the footprint of specific genomic annotations.

## Usage Guidance

### Basic Command Structure
The tool typically requires a list of chromosome sizes and the BED file to be analyzed.

```bash
bedCoverage chrom.sizes input.bed
```

### Key Inputs
1.  **chrom.sizes**: A two-column tab-separated file containing `<chromosome_name> <size_in_bases>`. You can often generate this using `fetchChromSizes` (another UCSC utility) for standard assemblies (e.g., `fetchChromSizes hg38 > hg38.chrom.sizes`).
2.  **input.bed**: The genomic regions you want to calculate coverage for.

### Common CLI Patterns
While specific flags can vary by version, the standard UCSC utility pattern for this tool includes:

*   **Genome-wide Summary**: By default, the tool outputs coverage statistics for each chromosome found in the BED file that matches the `chrom.sizes` file.
*   **Handling Overlaps**: The tool internally handles overlapping BED entries to ensure that a single base is not counted multiple times toward the total coverage.

### Expert Tips
*   **Pre-sorting**: While many UCSC tools handle unsorted data, it is a best practice to sort your BED file by chromosome and then by start position (`sort -k1,1 -k2,2n`) before running coverage analysis to ensure consistent behavior across different environments.
*   **Permission Errors**: If you have downloaded the binary directly from the UCSC server, ensure it is executable: `chmod +x bedCoverage`.
*   **Database Connectivity**: Some UCSC utilities attempt to connect to the public MySQL server. If you encounter connection errors, ensure you have an `.hg.conf` file in your home directory or use the tool on local files only.
*   **Bioconda Installation**: The most reliable way to manage dependencies for this tool is via Conda: `conda install -c bioconda ucsc-bedcoverage`.

## Reference documentation
- [UCSC Genome Browser Admin Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-bedcoverage Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedcoverage_overview.md)
- [UCSC Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)