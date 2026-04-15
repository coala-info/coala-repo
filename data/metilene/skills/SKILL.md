---
name: metilene
description: metilene identifies differentially methylated regions (DMRs) in bisulfite sequencing data using a binary segmentation algorithm and statistical testing. Use when user asks to call DMRs, analyze whole-genome bisulfite sequencing data, or compare methylation levels between two groups.
homepage: http://www.bioinf.uni-leipzig.de/Software/metilene
metadata:
  docker_image: "quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0"
---

# metilene

## Overview
metilene is a high-performance tool designed to identify differentially methylated regions (DMRs) using a binary segmentation algorithm and a two-dimensional statistical test. It is particularly effective for analyzing whole-genome bisulfite sequencing (WGBS) data across multiple samples and groups. It excels in speed and sensitivity, making it suitable for large datasets where other tools might be computationally prohibitive.

## Usage Patterns

### Input Format
metilene requires a specific tab-separated input format (often referred to as "metilene format").
- **Columns**: `chrom`, `pos`, `g1_m1`, `g1_m2`, ..., `g2_m1`, `g2_m2`, ...
- **Values**: Methylation rates should be between 0 and 1. Use `.` or `NaN` for missing data.
- **Sorting**: Input must be sorted by chromosome and position.

### Basic Command Line
The core execution follows this pattern:
```bash
metilene -m <min_cpgs> -d <min_diff> -a <group1_label> -b <group2_label> input.txt > output.dmr
```

### Key Parameters
- `-m`: Minimum number of CpGs required to call a DMR (default is often 3).
- `-d`: Minimum mean methylation difference between groups (e.g., 0.1 for 10%).
- `-a` / `-b`: Labels for the two groups being compared.
- `-f`: Filter for a specific p-value threshold (e.g., `-f 1` to output all, then filter later).
- `-X` / `-Y`: Maximum distance between neighboring CpGs to be included in the same DMR.

### Handling Missing Data
metilene can estimate missing values internally. If your data has many gaps, ensure you do not pre-filter too aggressively, as the tool's segmentation algorithm is designed to handle these gaps statistically.

## Expert Tips
- **Pre-filtering**: While metilene is fast, removing non-CpG sites or invariant sites from the input file can significantly reduce memory overhead for whole-genome runs.
- **Output Processing**: The output contains genomic coordinates, the number of CpGs, and statistical significance (p-values from MWU-test and 2D-KS test). Always use the adjusted p-values for downstream biological interpretation.
- **No Replicates**: metilene can run on single samples per group (n=1 vs n=1), though statistical power is limited. In these cases, rely more heavily on the `-d` (mean difference) parameter.

## Reference documentation
- [metilene Home](./references/legacy_bioinf_uni-leipzig_de_Software_metilene.md)
- [Bioconda metilene Overview](./references/anaconda_org_channels_bioconda_packages_metilene_overview.md)