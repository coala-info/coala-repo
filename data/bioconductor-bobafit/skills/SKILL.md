---
name: bioconductor-bobafit
description: "This tool refits and recalibrates tumor copy number profiles to correct diploid region assessments. Use when user asks to recalibrate tumor copy number segments, identify stable chromosomal arms, refit diploid regions, or visualize corrected copy number profiles."
homepage: https://bioconductor.org/packages/release/bioc/html/BOBaFIT.html
---


# bioconductor-bobafit

name: bioconductor-bobafit
description: Refit and recalibrate tumor copy number profiles to correct diploid region assessments. Use when analyzing tumor copy number segments (e.g., from TCGA) to identify stable chromosomal arms, perform clustering-based recalibration, and visualize corrected profiles.

# bioconductor-bobafit

## Overview
BOBaFIT (BiolOgical BAse FITting) is an R package designed to check and correct the diploid region in tumor copy number profiles. It is particularly useful for samples with complex karyotypes where the initial diploid region assessment may be incorrect. The package uses a chromosome clustering method and a list of unaltered reference chromosomes to recalibrate copy number values.

## Data Preparation
Before analysis, input data must be formatted as a data frame containing genomic segments.

### 1. Assign Chromosomal Arms
Use `Popeye()` to add chromosomal arm information (`arm` and `chrarm` columns) to your segments. This is required for downstream functions.

```r
library(BOBaFIT)
# data should have columns: ID, chr, start, end, Segment_Mean
segments <- Popeye(data)
```

### 2. Calculate Copy Number (CN)
Convert logR values (`Segment_Mean`) to absolute copy numbers.
*   **SNP Array:** Use a compression factor of 0.55.
*   **WGS/WES:** Use a compression factor of 1.0.

```r
compression_factor <- 0.55 
segments$CN <- 2^(segments$Segment_Mean / compression_factor + 1)
```

## Core Workflow

### 1. Identify Normal Chromosomes
Generate a list of chromosomal arms least affected by somatic copy number alterations (SCNAs). The `tolerance_val` represents the maximum alteration rate allowed (e.g., 0.05 for small cohorts, 0.25 for large cohorts).

```r
chr_list <- computeNormalChromosomes(segments = segments, 
                                     tolerance_val = 0.25)
```

### 2. Refit the Profile
Use `DRrefit()` to estimate the correct diploid region and recalibrate the profile. It uses the `NbClust` method to group chromosomal arms.

```r
results <- DRrefit(segments_chort = segments, 
                   chrlist = chr_list, 
                   clust_method = "ward.D2")

# Access corrected segments
corrected_segs <- results$corrected_segments

# Access the report (contains Correction Factor 'CR' and class)
report <- results$report
```

### 3. Interpret Correction Classes
The `report` data frame classifies samples based on the Correction Factor (CR):
*   **No Changes:** CR < 0.1
*   **Recalibrated:** 0.1 < CR < 0.5
*   **Refitted:** CR > 0.5

## Visualization

### Plot Refitting Results
Compare the original (red) and corrected (orange/green) copy number profiles.

```r
DRrefit_plot(corrected_segments = results$corrected_segments,
             DRrefit_report = results$report, 
             plot_viewer = TRUE)
```

### Visualize Chromosome Clusters
View how chromosomal arms are clustered within a sample to understand the refitting logic.

```r
cluster_out <- PlotChrCluster(segs = segments,
                              clust_method = "ward.D2",
                              plot_output = TRUE)
```

## Reference documentation
- [BOBaFIT Vignette](./references/BOBaFIT.md)
- [Data Preparation Guide](./references/Data-Preparation.md)