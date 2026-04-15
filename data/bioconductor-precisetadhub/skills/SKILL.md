---
name: bioconductor-precisetadhub
description: This package provides pre-trained Random Forest models for predicting TAD and loop boundaries at base-level resolution. Use when user asks to load pre-trained models for TAD boundary prediction, retrieve chromatin loop models, or access genomic data for preciseTAD analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/preciseTADhub.html
---

# bioconductor-precisetadhub

## Overview

`preciseTADhub` is a Bioconductor ExperimentData package providing 84 pre-trained Random Forest (RF) models. These models are designed to work in conjunction with the `preciseTAD` package to predict TAD and loop boundaries at base-level resolution. Each model was trained using specific combinations of cell lines (GM12878, K562), ground truth callers (Arrowhead, Peakachu), and resolutions (5kb, 10kb), using a leave-one-chromosome-out strategy.

## Core Workflow

### 1. Initialization and Querying
To use the pre-trained models, you must initialize `ExperimentHub` and query for the `preciseTADhub` resources.

```r
library(ExperimentHub)
library(preciseTADhub)
library(preciseTAD)

hub <- ExperimentHub()
myfiles <- query(hub, "preciseTADhub")
```

### 2. Loading a Pre-trained Model
Use the `readEH()` wrapper function to retrieve a specific model based on the chromosome to be predicted (the holdout), the cell line, and the ground truth caller.

**Parameters for `readEH()`:**
- `chr`: The holdout chromosome (e.g., "CHR22").
- `cl`: Cell line ("GM12878" or "K562").
- `gt`: Ground truth caller ("Arrowhead" for TADs, "Peakachu" for loops).
- `source`: The queried hub object.

```r
# Example: Load model for CHR22, GM12878, using Arrowhead at 5kb
model_data <- readEH(chr = "CHR22", 
                     cl = "GM12878", 
                     gt = "Arrowhead", 
                     source = myfiles)
```

### 3. Preparing Genomic Predictors
The models require specific Transcription Factor Binding Site (TFBS) data as predictors: CTCF, RAD21, SMC3, and ZNF143. These should be provided as a named `GRangesList`.

```r
data("tfbsList")
# Filter for required predictors and rename for the model
tfbs_filt <- tfbsList[names(tfbsList) %in% c("Gm12878-Ctcf-Broad", 
                                            "Gm12878-Rad21-Haib",
                                            "Gm12878-Smc3-Sydh",
                                            "Gm12878-Znf143-Sydh")]
names(tfbs_filt) <- c("Ctcf", "Rad21", "Smc3", "Znf143")
```

### 4. Predicting Boundaries
Pass the loaded model to the `tadModel` argument of the `preciseTAD()` function.

```r
set.seed(123)
prediction <- preciseTAD(
  genomicElements.GR = tfbs_filt,
  featureType         = "distance",
  CHR                 = "CHR22",
  chromCoords         = list(18000000, 19000000),
  tadModel            = model_data,
  threshold           = 1.0,
  DBSCAN_params       = list(30000, 3)
)
```

## Model Metadata and Naming
Files in the hub follow the naming convention: `i_j_k_l.rds`
- `i`: Holdout chromosome (CHR1 to CHR22).
- `j`: Cell line (GM12878, K562).
- `k`: Resolution (5kb, 10kb).
- `l`: Ground truth caller (Arrowhead, Peakachu).

Each loaded object is a list containing:
1. `train`: The `caret` RF model object.
2. `importance`: A data frame of variable importance for the predictors.

## Tips for Success
- **Resolution Match**: Ensure your genomic predictors and the `preciseTAD` parameters align with the resolution of the pre-trained model (e.g., use 5kb models for high-resolution base-level mapping).
- **Chromosome Selection**: Always select the model where the chromosome you are currently analyzing was the "holdout" during training to ensure unbiased prediction.
- **Memory Management**: `ExperimentHub` caches downloads locally. If you encounter issues, check your local BiocFileCache.

## Reference documentation
- [Predicting TAD/loop boundaries using pre-trained models provided by preciseTADhub](./references/preciseTADhub.Rmd)
- [preciseTADhub Documentation](./references/preciseTADhub.md)