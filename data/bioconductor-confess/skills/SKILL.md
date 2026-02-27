---
name: bioconductor-confess
description: bioconductor-confess performs cell detection and fluorescence signal estimation from Fluidigm C1 images to analyze spatio-temporal dynamics. Use when user asks to detect cells in images, estimate fluorescence intensities, normalize signal data, or order cells by pseudotime and cell cycle phase.
homepage: https://bioconductor.org/packages/release/bioc/html/CONFESS.html
---


# bioconductor-confess

name: bioconductor-confess
description: Cell detection and signal estimation from Fluidigm C1 images. Use for estimating cell cycle phases and pseudotime from fluorescence signals, including image processing, outlier detection, signal normalization, and cell ordering.

# bioconductor-confess

## Overview
CONFESS (Cell OrderiNg by FluorEScence Signal) is an R package designed for cell detection and signal estimation from images, specifically optimized for the Fluidigm C1 system. It enables the study of spatio-temporal dynamics, such as the cell cycle, by converting fluorescence intensities into pseudotime estimates and discrete cell cycle phases.

## Image Analysis and Fluorescence Estimation

### 1. Loading Data
Use `readFiles` to point to directories containing Bright Field (BF) and Channel (CH) images (or text-converted versions).
```r
library(CONFESS)
files <- readFiles(iDirectory = NULL, 
                  BFdirectory = "path/to/BF", 
                  CHdirectory = "path/to/CH", 
                  separator = "_", 
                  image.type = c("BF", "Green", "Red"), 
                  bits = 2^16)
```

### 2. Spot Estimation
Estimate cell locations using `spotEstimator`. Use a range of `foregroundCut` values to optimize detection.
```r
estimates <- spotEstimator(files = files, 
                          foregroundCut = seq(0.6, 0.76, 0.02), 
                          BFarea = 7, 
                          correctionAlgorithm = FALSE, 
                          savePlot = "screen")
```

### 3. Quality Control and Outlier Re-estimation
Identify outliers manually or via clustering, then re-run the estimator for those specific samples.
```r
# Interactive outlier selection
clu <- defineLocClusters(LocData = estimates, out.method = "interactive.manual")

# Re-estimate outliers with correctionAlgorithm = TRUE
estimates.2 <- spotEstimator(files = files, 
                             subset = clu$Outlier.indices, 
                             foregroundCut = seq(0.6, 0.76, 0.02), 
                             correctionAlgorithm = TRUE, 
                             QCdata = clu, 
                             median.correction = TRUE)
```

### 4. Final Filtering
Generate the final location matrix by applying filters (Size, FDR, Signal-to-Noise, etc.).
```r
Results <- LocationMatrix(data = estimates.2, 
                          filter.by = matrix(c("FDR", "Out.Index", 0.005, "confidence"), ncol = 2))
```

## Signal Adjustment and Pseudotime Ordering

### 1. Data Preparation and Normalization
Convert image results into a fluorescence object and adjust for batch effects.
```r
step1 <- createFluo(Results)

# For multi-batch data
step2 <- Fluo_adjustment(data = step1, transformation = "log", maxMix = 3, savePlot = "screen")

# For single-batch data
step1.1 <- FluoSelection_byRun(data = step1, batch = 1)
step2 <- getFluo_byRun(data = step1.1, BGmethod = "normexp")
```

### 2. Clustering and Path Estimation
Inspect clusters and define the progression path (e.g., circular for cell cycle).
```r
step2.1 <- getFluo(data = step2)
step3 <- Fluo_inspection(data = step2.1, altFUN = "kmeans", savePlot = "screen")

# Define path (e.g., starting at cluster 3, moving clockwise)
step3.1 <- pathEstimator(step3, path.start = 3, path.type = c("circular", "clockwise"))
```

### 3. Final Ordering
Model the fluorescence and order cells along the pseudotime.
```r
step4 <- Fluo_modeling(data = step3.1, VSmethod = "DDHFmv", CPmethod = "ECP")
step5 <- Fluo_ordering(data = step4, savePlot = "screen")
# Results are in step5$Summary_results
```

## Cross-Validation
Assess the stability of pseudotime estimates by randomly removing samples or entire batches.
```r
steps2_4 <- Fluo_CV_prep(data = step1, init.path = rep("bottom/left", 2), path.type = c("circular", "clockwise"))
steps2_4cv <- Fluo_CV_modeling(data = steps2_4, B = 10, batch = 1:4)
```

## Reference documentation
- [CONFESS Vignette](./references/vignette.md)
- [CONFESS TeX Vignette](./references/vignette_tex.md)