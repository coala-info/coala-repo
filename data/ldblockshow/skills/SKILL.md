---
name: ldblockshow
description: ldblockshow generates linkage disequilibrium heatmaps and identifies haplotype blocks from VCF files while integrating functional annotations and statistical signals. Use when user asks to visualize LD patterns, identify haplotype blocks, overlay GWAS signals on LD plots, or generate publication-quality genomic heatmaps.
homepage: https://github.com/BGI-shenzhen/LDBlockShow
---


# ldblockshow

## Overview
ldblockshow is a high-performance tool designed to generate LD heatmaps and identify haplotype blocks directly from Variant Call Format (VCF) files. It is optimized for speed and memory efficiency, making it suitable for large-scale genomic datasets. Beyond simple LD plotting, it allows users to overlay functional annotations (GFF3) and statistical signals (such as GWAS p-values or Tajima's D) to provide biological context to linkage patterns.

## Core CLI Usage

The primary executable is `LDBlockShow`. At a minimum, you must provide an input VCF, an output prefix, and a target genomic region.

### Basic Command Pattern
```bash
LDBlockShow -InVCF input.vcf.gz -OutPut output_prefix -Region chr1:1000000-1100000
```

### Integrating Annotations and Statistics
To create a comprehensive visualization including gene tracks and association signals:
```bash
LDBlockShow -InVCF in.vcf.gz -OutPut out -Region chr1:100-200 -InGFF genes.gff3 -InGWAS gwas_results.txt
```
*   **-InGWAS format**: A space/tab-delimited file with three columns: `Chr Position P-value`.
*   **-InGFF format**: Standard GFF3 file for showing gene structures (CDS and names).

### LD Statistics and Block Detection
Control how LD is calculated and how blocks are defined:
*   **-SeleVar**: Choose the LD metric. `1` for D' (default), `2` for R², or `3` for both.
*   **-BlockType**: 
    *   `1`: Gabriel method (PLINK style, default).
    *   `2`: Solid Spine of LD.
    *   `3`: Custom thresholds (use with `-BlockCut`).
    *   `4`: User-defined blocks (use with `-FixBlock`).
    *   `5`: No block detection.

## Expert Tips and Best Practices

### Quality Control Filters
Improve plot clarity and computational efficiency by filtering low-quality variants directly within the tool:
*   Use `-MAF 0.05` to exclude rare variants.
*   Use `-Miss 0.25` to filter sites with high missingness.
*   Use `-HWE 0.001` to filter sites failing Hardy-Weinberg Equilibrium tests.

### Output Optimization
*   **Vector vs. Raster**: Use `-OutPdf` for publication-quality vector graphics. For very large regions with many SNPs, use `-OutPng` to avoid massive file sizes that can crash SVG viewers.
*   **Grid Merging**: For dense regions, `-MerMinSNPNum` (default 50) merges color grids to keep the visualization interpretable. Increase this value if the heatmap looks overly cluttered.
*   **Subgroup Analysis**: Use `-SubPop sample_list.txt` to calculate LD for a specific subset of individuals defined in the VCF.

### Post-Processing with ShowLDSVG
If you need to adjust the aesthetics (colors, labels, etc.) of a generated plot without re-calculating the LD statistics, use the companion tool:
```bash
ShowLDSVG -InPreFix output_prefix -OutPut new_plot.svg [options]
```

## Reference documentation
- [LDBlockShow GitHub Repository](./references/github_com_BGI-shenzhen_LDBlockShow.md)