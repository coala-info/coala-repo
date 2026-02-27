---
name: bioconductor-m6aboost
description: This tool predicts m6A sites from miCLIP2 sequencing data using an AdaBoost-based machine learning model. Use when user asks to assign read counts to peaks, extract genomic features from annotation files, or classify miCLIP2 peaks into m6A sites and background signals.
homepage: https://bioconductor.org/packages/release/bioc/html/m6Aboost.html
---


# bioconductor-m6aboost

name: bioconductor-m6aboost
description: Predict m6A sites from miCLIP2 sequencing data using the m6Aboost AdaBoost-based machine learning model. Use this skill to assign read counts (truncation and C-to-T transitions), extract genomic features, and classify miCLIP2 peaks into m6A sites and background signals.

## Overview

m6Aboost is a Bioconductor package designed to accurately identify N6-methyladenosine (m6A) sites from miCLIP2 data. It addresses the high background signal inherent in m6A antibody-based methods by using a machine learning model trained on high-confidence sites. The workflow transforms miCLIP2 peak calls (typically from PureCLIP) into classified m6A sites by integrating experimental signal strength, C-to-T transitions, transcript regions, and local nucleotide sequences.

## Workflow and Core Functions

### 1. Data Preparation
The input must be a `GRanges` object containing peak calling results (e.g., from PureCLIP).

```r
library(m6Aboost)
# Load peaks (example)
peaks <- readRDS("peaks.rds")
```

### 2. Read Count Assignment
Assign truncation events and C-to-T transitions from bigWig files to the peaks. This should be done for each replicate.

```r
# Assign truncation events
peaks <- truncationAssignment(peaks, 
                              bw_positive = "trunc_pos.bw", 
                              bw_negative = "trunc_neg.bw", 
                              sampleName = "Rep1_Trunc")

# Assign C-to-T transitions
peaks <- CtoTAssignment(peaks, 
                        bw_positive = "ctot_pos.bw", 
                        bw_negative = "ctot_neg.bw", 
                        sampleName = "Rep1_CtoT")
```

### 3. Feature Extraction
Calculate mean counts across replicates and extract features using a GENCODE annotation file (GFF3).

```r
# Calculate means if multiple replicates exist
peaks$WTmean <- (peaks$Rep1_Trunc + peaks$Rep2_Trunc) / 2
peaks$CtoTmean <- (peaks$Rep1_CtoT + peaks$Rep2_CtoT) / 2

# Extract features (requires GENCODE GFF3)
peaks_features <- preparingData(peaks, 
                                gff3 = "annotation.gff3", 
                                colname_reads = "WTmean", 
                                colname_C2T = "CtoTmean")
```

### 4. m6A Prediction
Run the AdaBoost model. You must specify the `BSgenome` package for your species.

```r
# Ensure the BSgenome package is installed and loaded
# BiocManager::install("BSgenome.Mmusculus.UCSC.mm10")

results <- m6Aboost(peaks_features, 
                    genome = "BSgenome.Mmusculus.UCSC.mm10", 
                    normalization = TRUE)
```

## Interpreting Results

The `m6Aboost` function returns a `GRanges` object with two critical metadata columns:
- `class`: "YES" (predicted m6A site) or "NO" (background).
- `prob`: The prediction probability score (0 to 1).

**Tip:** While the default cutoff is 0.5, you can apply a more stringent threshold on the `prob` column for higher confidence.

## Reproducibility Filtering
It is highly recommended to filter your initial peak set to keep only those present in at least two replicates before running the m6Aboost workflow to ensure robust results.

## Accessing the Raw Model
The underlying AdaBoost model is hosted on ExperimentHub (ID: EH6021).

```r
library(ExperimentHub)
eh <- ExperimentHub()
model <- eh[["EH6021"]]
```

## Reference documentation

- [Predicting m6A sites from miCLIP2 data with m6Aboost](./references/m6AboosVignettes.md)
- [m6Aboost Vignettes Source](./references/m6AboosVignettes.Rmd)