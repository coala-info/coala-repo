---
name: bioconductor-cfdnakit
description: Bioconductor-cfdnakit analyzes cell-free DNA fragment length distributions and infers copy-number variations from shallow whole-genome sequencing data. Use when user asks to extract fragment lengths from BAM files, calculate short-to-long fragment ratios, estimate tumor fraction, or perform fragmentomics-based copy-number analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/cfdnakit.html
---


# bioconductor-cfdnakit

name: bioconductor-cfdnakit
description: Analyze cell-free DNA (cfDNA) fragment length distributions and infer copy-number variations (CNV) from shallow whole-genome sequencing (sWGS) data. Use this skill to extract fragment lengths from BAM files, calculate short-to-long (S/L) fragment ratios, estimate tumor fraction (TF), and compute the ctDNA estimation score (CES).

# bioconductor-cfdnakit

## Overview
The `cfdnakit` package is designed for the analysis of next-generation sequencing (NGS) data from liquid biopsies. It specializes in fragmentomics—specifically extracting and visualizing cfDNA fragment length information. By analyzing the enrichment of short fragments (typically 100-150 bp) relative to long fragments (151-250 bp), the package allows for the quantification of circulating tumor DNA (ctDNA) and the inference of copy-number aberrations even from shallow sequencing data (~0.3X coverage).

## Core Workflow

### 1. Data Input and Binning
Read coordination-sorted BAM files into non-overlapping genomic bins.
```r
library(cfdnakit)

# Path to BAM file
bam_path <- "path/to/sample.bam"

# Read BAM and split into 1000KB bins (default)
# Supports hg19 (default), hg38, and mm10
sample_bam <- read_bamfile(bam_path, 
                           apply_blacklist = TRUE, 
                           ref = "hg19", 
                           bin_size = 1000)
```

### 2. Fragment Length Distribution
Visualize the fragmentation pattern to identify the characteristic 167 bp peak and 10 bp periodicity.
```r
# Plot distribution for one or more samples
plot_fragment_dist(list("Patient_A" = sample_bam, "Healthy_Control" = control_bam))
```

### 3. Quantification of Short Fragments
Extract the fragment profile and calculate the Short/Long (S/L) ratio.
```r
# Get profile (Short: 100-150bp, Long: 151-250bp)
sample_profile <- get_fragment_profile(sample_bam, sample_id = "Sample_01")

# View summary statistics (Mode, Mean, S.L.Ratio)
print(sample_profile$sample_profile)

# Plot genome-wide S/L ratio
plot_sl_ratio(sample_profile)
```

### 4. Panel of Normal (PoN) and Normalization
To infer CNVs, you must compare the sample against a Panel of Normal (PoN) created from healthy individuals.
```r
# Create PoN from a text file containing paths to saved SampleFragment RDS files
# PoN_list.txt should have one path per line
pon_data <- create_PoN("PoN_list.txt")

# Calculate Z-scores relative to PoN
sample_zscore <- get_zscore_profile(sample_profile, pon_data)
```

### 5. CNV Calling and Tumor Fraction Estimation
Perform segmentation and fit solutions for tumor fraction and ploidy.
```r
# Circular Binary Segmentation (CBS)
sample_segmented <- segmentByPSCB(sample_zscore)

# Plot transformed S/L ratio with segments
plot_transformed_sl(sample_zscore, sample_segmented)

# Call CNV and estimate Tumor Fraction (TF)
# Searches for solutions at ploidy 2, 3, and 4
cnv_results <- call_cnv(sample_segmented, sample_zscore)

# View ranked solutions
solution_table <- get_solution_table(cnv_results)
print(solution_table)

# Plot the best solution (Rank 1)
plot_cnv_solution(cnv_results, selected_solution = 1)
```

### 6. ctDNA Estimation Score (CES)
Calculate the CES score to quantify tumor-derived DNA based on fragmentation instability.
```r
ces_score <- calculate_CES_score(sample_segmented)
print(ces_score)
```

## Tips and Best Practices
- **Coverage**: While the package works with shallow WGS, ensure coverage is at least 0.3X for reliable CNV inference.
- **Reference Genomes**: Ensure the `ref` parameter in `read_bamfile` matches your alignment (e.g., "hg19", "hg38").
- **Efficiency**: Reading BAM files is resource-intensive. Save intermediate `SampleBam` and `SampleFragment` objects as `.rds` files using `saveRDS()` to avoid re-processing.
- **PoN Quality**: The accuracy of Z-scores and CNV calls depends heavily on a high-quality PoN derived from healthy samples processed with the same sequencing protocol.

## Reference documentation
- [cfdnakit vignette](./references/cfdnakit-vignette.md)
- [cfdnakit Rmd source](./references/cfdnakit-vignette.Rmd)