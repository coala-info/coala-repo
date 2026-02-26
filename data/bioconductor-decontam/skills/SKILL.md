---
name: bioconductor-decontam
description: The bioconductor-decontam package provides statistical methods to identify and visualize contaminating DNA features in marker-gene and metagenomics sequencing data based on frequency and prevalence signatures. Use when user asks to identify contaminants in sequencing data, filter taxa based on DNA concentration, or compare feature prevalence between biological samples and negative controls.
homepage: https://bioconductor.org/packages/release/bioc/html/decontam.html
---


# bioconductor-decontam

## Overview

The `decontam` package provides statistical methods to identify and visualize contaminating DNA features in marker-gene (e.g., 16S rRNA) and metagenomics sequencing data. It identifies contaminants based on two main signatures:
1. **Frequency**: Contaminant frequency is inversely proportional to the input DNA concentration.
2. **Prevalence**: Contaminants are more prevalent in negative control samples than in true biological samples.

## Core Workflow

### 1. Data Requirements
You need a feature table (ASVs, OTUs, or taxa) and metadata. While `decontam` accepts matrices, it is optimized for `phyloseq` objects.
- **Frequency method**: Requires DNA quantitation data (e.g., PicoGreen, qPCR).
- **Prevalence method**: Requires identification of "negative control" samples (e.g., extraction blanks).

### 2. Identify Contaminants by Frequency
Use this when you have DNA concentration data for all samples.
```r
library(decontam)
# ps is a phyloseq object; "quant_reading" is the metadata column for DNA concentration
contam_df <- isContaminant(ps, method="frequency", conc="quant_reading")

# Check results
table(contam_df$contaminant)
head(which(contam_df$contaminant))
```

### 3. Identify Contaminants by Prevalence
Use this when you have negative control samples.
```r
# Create a logical vector identifying negative controls
sample_data(ps)$is.neg <- sample_data(ps)$Sample_or_Control == "Control Sample"

# Run prevalence method
contam_df <- isContaminant(ps, method="prevalence", neg="is.neg")

# Optional: Use a more aggressive threshold (0.5 identifies anything more prevalent in controls)
contam_df_05 <- isContaminant(ps, method="prevalence", neg="is.neg", threshold=0.5)
```

### 4. Combined and Batch Methods
- **Combined**: Uses both frequency and prevalence. Set `method="combined"`.
- **Minimum**: Calculates both and takes the minimum p-value. Set `method="minimum"`.
- **Batch**: If contaminants vary by sequencing run, use the `batch` argument to perform identification within batches.

## Visualization and Filtering

### Visualizing Evidence
Use `plot_frequency` to see the relationship between DNA concentration and feature frequency.
```r
# Plot specific taxa (e.g., the first and third)
plot_frequency(ps, taxa_names(ps)[c(1,3)], conc="quant_reading")
```
- **Red line**: Contaminant model (inverse relationship).
- **Black dashed line**: Non-contaminant model (independent of concentration).

### Removing Contaminants
Once identified, use `phyloseq::prune_taxa` to remove the contaminants from your dataset.
```r
# Keep only non-contaminants
ps_clean <- prune_taxa(!contam_df$contaminant, ps)
```

## Tips for Success
- **Keep low-read samples**: Do not filter out low-read samples or negative controls before running `decontam`, as they are essential for the statistical models.
- **Thresholds**: The default p-value threshold is 0.1. Increasing this (e.g., to 0.5 for prevalence) makes the filter more aggressive.
- **Negative Controls**: Extraction controls are superior to PCR controls as they capture contaminants introduced during the entire lab workflow.

## Reference documentation
- [Introduction to decontam](./references/decontam_intro.md)
- [Introduction to decontam (Rmd)](./references/decontam_intro.Rmd)