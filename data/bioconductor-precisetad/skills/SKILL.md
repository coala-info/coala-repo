---
name: bioconductor-precisetad
description: This machine learning framework predicts 3D chromatin domain boundaries at base-level resolution using genomic annotations. Use when user asks to build predictive models for TAD boundaries, perform feature selection for chromatin drivers, or predict precise boundary points and regions.
homepage: https://bioconductor.org/packages/release/bioc/html/preciseTAD.html
---

# bioconductor-precisetad

name: bioconductor-precisetad
description: Machine learning framework for predicting 3D chromatin domain boundaries (TADs and loops) at base-level resolution using genomic annotations like ChIP-seq data. Use this skill when you need to build predictive models for TAD boundaries, perform feature selection (RFE) for chromatin drivers, or predict precise boundary points (PTBP) and regions (PTBR) in specific cell types.

## Overview
`preciseTAD` transforms the identification of Topologically Associating Domain (TAD) boundaries into a supervised machine learning problem. It uses "shifted binning" to create a binary response vector from Hi-C data and leverages genomic features (e.g., CTCF, RAD21 binding sites) to train Random Forest models. The unique advantage of this package is its ability to predict boundaries at base-pair resolution (PTBP) using density-based clustering (DBSCAN), even in cell types where high-resolution Hi-C data is unavailable.

## Core Workflow

### 1. Data Preparation
Prepare "ground-truth" boundaries from Hi-C callers (like Arrowhead) and genomic features from BED files.

```r
library(preciseTAD)

# 1. Extract unique boundaries from domain coordinates
# domains.mat should be a 3-column data frame (CHR, start, end)
bounds <- extractBoundaries(domains.mat = arrowhead_gm12878_5kb, 
                            filter = FALSE, 
                            CHR = c("CHR1", "CHR22"), 
                            resolution = 5000)

# 2. Load genomic annotations (TFBS) as a GRangesList
# Use bedToGRangesList for local BED files
data("tfbsList") 

# 3. Create the training/testing data matrix
# featureType can be "distance", "overlap", "count", or "percent"
set.seed(123)
tadData <- createTADdata(bounds.GR = bounds,
                         resolution = 5000,
                         genomicElements.GR = tfbsList,
                         featureType = "distance",
                         resampling = "rus",
                         trainCHR = "CHR1",
                         predictCHR = "CHR22")
```

### 2. Model Building and Feature Selection
Identify the most predictive transcription factors and train a Random Forest model.

```r
# Recursive Feature Elimination (RFE) to find optimal feature subset
rfe_res <- TADrfe(trainData = tadData[[1]],
                  tuneParams = list(ntree = 500, nodesize = 1),
                  cvFolds = 5,
                  cvMetric = "Accuracy")

# Train the final Random Forest model
tadModel <- TADrandomForest(trainData  = tadData[[1]],
                            testData   = tadData[[2]],
                            tuneParams = list(mtry = 2, ntree = 500, nodesize = 1),
                            cvFolds    = 3,
                            model      = TRUE,
                            importances = TRUE,
                            performances = TRUE)
```

### 3. Precise Boundary Prediction (Base-level)
Apply the trained model to specific genomic regions to find exact boundary points.

```r
# Predict base-level boundaries (PTBPs)
pt <- preciseTAD(genomicElements.GR = tfbsList_filt,
                 featureType         = "distance",
                 CHR                 = "CHR22",
                 chromCoords         = list(17000000, 18000000),
                 tadModel            = tadModel[[1]],
                 threshold           = 1,
                 DBSCAN_params       = list(eps = 30000, MinPts = 100),
                 genome              = "hg19",
                 BaseProbs           = TRUE)

# Access results
ptbr <- pt$PTBR # Precise TAD Boundary Regions
ptbp <- pt$PTBP # Precise TAD Boundary Points (medoids)
```

### 4. Cross-Cell-Type Prediction
Use a model trained on one cell type (e.g., GM12878) to predict boundaries in another (e.g., Hela) using only ChIP-seq data.

```r
# 1. Load pre-trained model
# 2. Prepare new cell-type GRangesList (e.g., hela.GR)
# 3. Run preciseTAD() using the new GRangesList and the pre-trained model
```

## Key Functions
- `extractBoundaries()`: Converts domain lists into unique GRanges boundaries.
- `createTADdata()`: Generates the feature matrix using shifted binning.
- `TADrfe()`: Performs feature selection to identify key chromatin drivers.
- `TADrandomForest()`: Wrapper for training and evaluating the predictive model.
- `preciseTAD()`: The main engine for base-level boundary prediction using DBSCAN and PAM clustering.
- `juicer_func()`: Formats PTBPs for visualization in Juicebox.

## Tips for Success
- **Feature Selection**: The loop-extrusion components (CTCF, RAD21, SMC3, ZNF143) are typically the most predictive features.
- **Resolution**: Ensure the `resolution` parameter in `createTADdata` matches the resolution of the Hi-C data used to define the ground-truth boundaries.
- **Memory Management**: Setting `BaseProbs = TRUE` in `preciseTAD()` can consume significant memory if the genomic region is large. Use it only for specific regions of interest.
- **Thresholding**: The `threshold` (t) and `eps` parameters in `preciseTAD()` control the stringency of boundary calling. Higher thresholds result in more precise but fewer calls.

## Reference documentation
- [preciseTAD Vignette](./references/preciseTAD.Rmd)
- [preciseTAD Vignette](./references/preciseTAD.md)