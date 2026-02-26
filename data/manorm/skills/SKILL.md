---
name: manorm
description: MAnorm quantitatively compares and normalizes ChIP-Seq samples to identify differential binding events between two conditions. Use when user asks to normalize ChIP-Seq signal intensities, calculate M-values and A-values, or identify cell-type-specific binding sites.
homepage: https://github.com/shao-lab/MAnorm
---


# manorm

# manorm

## Overview
MAnorm is a robust statistical model used to compare ChIP-Seq samples quantitatively. It normalizes signal intensities between two samples by using common peaks as a reference, allowing for the calculation of M-values (log2 fold change) and A-values (average signal intensity). This tool is essential for identifying cell-type-specific binding events or changes in chromatin states across different conditions, providing a more accurate comparison than simple overlap analysis.

## Usage Instructions

### Basic Command Structure
The core functionality of MAnorm requires peak files and read files for two samples.

```bash
manorm --p1 <sample1_peaks.bed> --p2 <sample2_peaks.bed> \
       --r1 <sample1_reads.bed> --r2 <sample2_reads.bed> \
       --n1 <name1> --n2 <name2> \
       -o <output_directory>
```

### Parameter Breakdown
- `--p1`, `--p2`: Peak files in BED format for sample 1 and sample 2.
- `--r1`, `--r2`: Read alignment files in BED format for sample 1 and sample 2.
- `--n1`, `--n2`: Unique identifiers/names for the samples (used in output files).
- `-o`, `--output`: Directory where results, including normalized data and plots, will be saved.

### Best Practices
- **Input Format**: Ensure all input files (peaks and reads) are in standard BED format. Read files should contain the genomic coordinates of the aligned reads.
- **Sample Naming**: Use clear, descriptive names for `--n1` and `--n2` (e.g., `WT` vs `KO` or `Jurkat` vs `K562`) as these strings will be used to label columns in the final output table.
- **Normalization Logic**: MAnorm operates on the assumption that binding levels at common peak regions are similar between samples. If your samples have global, massive differences in binding, the normalization model may be affected.

### Output Interpretation
MAnorm generates a main output file (usually `*_all_peaks.xls` or similar) containing:
- **M-value**: The $log_2$ ratio of normalized read densities. Positive values indicate higher binding in sample 1; negative values indicate higher binding in sample 2.
- **A-value**: The average $log_2$ read density across both samples.
- **P-value**: The statistical significance of the differential binding.

## Reference documentation
- [MAnorm Overview](./references/anaconda_org_channels_bioconda_packages_manorm_overview.md)
- [MAnorm GitHub Repository](./references/github_com_shao-lab_MAnorm.md)