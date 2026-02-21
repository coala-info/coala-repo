---
name: hapbin
description: hapbin is a high-performance toolset designed for rapid scans of positive selection in large genomic datasets.
homepage: https://github.com/evotools/hapbin
---

# hapbin

## Overview

hapbin is a high-performance toolset designed for rapid scans of positive selection in large genomic datasets. It provides optimized implementations for calculating Extended Haplotype Homozygosity (EHH), Integrated Haplotype Score (iHS), and Cross Population Extended Haplotype Homozygosity (XP-EHH). The suite is particularly useful for researchers working with phased human or model organism data who require faster execution times than traditional tools like selscan. It achieves this efficiency through a specialized binary file format and multi-threaded execution.

## Core Workflows

### 1. Data Preparation and Conversion
Before running selection scans, convert standard ASCII IMPUTE format files to the more efficient hapbin binary format.

```bash
# Convert ASCII .hap to binary .hapbin
hapbinconv --hap input.hap --out output.hapbin
```

**Input Requirements:**
- **Haplotype files:** Must be in IMPUTE hap format (phased).
- **Map files:** Must follow the Selscan format (4 space-separated columns: chromosome, locus ID, genetic position, physical position).

### 2. Calculating EHH for Specific Loci
Use `ehhbin` to analyze the decay of identity by descent for a specific variant.

```bash
ehhbin --hap data.hapbin --map data.map --locus [locus_id] --out [prefix]
```
- The output contains 5 columns: Locus ID, genetic position, physical position, EHH for allele 0, and EHH for allele 1.

### 3. Genome-wide iHS Scans
Use `ihsbin` to calculate the Integrated Haplotype Score across all loci in a file.

```bash
ihsbin --hap data.hapbin --map data.map --out [prefix] --minmaf 0.05 --cutoff 0.05
```
- **--minmaf:** Filters out variants with a Minor Allele Frequency below the threshold (e.g., 0.05).
- **--cutoff:** Sets the EHH value at which the integration stops (default is often 0.05).

### 4. Cross-Population XP-EHH Scans
Use `xpehhbin` to compare haplotype lengths between two populations.

```bash
xpehhbin --hapA popA.hapbin --hapB popB.hapbin --map data.map --out [prefix]
```
- The output includes iHH values for both populations and the resulting XP-EHH statistic.

## Expert Tips and Best Practices

- **Performance:** Always use `hapbinconv` to create `.hapbin` files before running large-scale scans. The binary format significantly reduces I/O overhead and memory usage.
- **Map File Consistency:** Ensure your map file has the exact same number of loci as your haplotype file. A common error is a mismatch between these two files, which will cause the tools to fail.
- **Standardization:** `ihsbin` performs internal standardisation by grouping alleles into frequency bins (default 2%). If you require custom standardisation, you may need to process the unstandardised iHS values from the output manually.
- **VCF Conversion:** If your data is in VCF format, use `vcftools` with the `--export-impute` flag to generate the required input for `hapbinconv`.
- **Parallelization:** If compiled with OpenMP, the tools will utilize multiple cores. Ensure your environment variables (like `OMP_NUM_THREADS`) are set correctly for your HPC environment.

## Reference documentation
- [hapbin GitHub Repository](./references/github_com_evotools_hapbin.md)
- [hapbin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hapbin_overview.md)