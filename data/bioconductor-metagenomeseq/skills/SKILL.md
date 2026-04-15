---
name: bioconductor-metagenomeseq
description: bioconductor-metagenomeseq performs statistical analysis and normalization for sparse high-throughput sequencing data such as metagenomic marker-gene surveys. Use when user asks to normalize count data using cumulative sum scaling, perform differential abundance testing with zero-inflated mixture models, or conduct longitudinal time-series analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/metagenomeSeq.html
---

# bioconductor-metagenomeseq

name: bioconductor-metagenomeseq
description: Statistical analysis for sparse high-throughput sequencing data (metagenomics). Use for normalizing marker-gene survey data (CSS), performing differential abundance testing using Zero-Inflated Log-Normal (fitFeatureModel) or Zero-Inflated Gaussian (fitZig) mixture models, and longitudinal time-series analysis (fitTimeSeries).

# bioconductor-metagenomeseq

## Overview
`metagenomeSeq` is an R package designed to address the unique biases in marker-gene survey data, specifically sparsity (excess zeros) due to undersampling and varying depths of coverage. It introduces Cumulative Sum Scaling (CSS) normalization and mixture models to account for these factors in differential abundance testing.

## Core Workflow

### 1. Data Preparation
Data must be formatted into a `MRexperiment` object.
```R
library(metagenomeSeq)

# From a count matrix, phenoData, and featureData
obj <- newMRexperiment(counts, phenoData = pd, featureData = fd)

# From BIOM format
library(biomformat)
biom_obj <- read_biom("path/to/file.biom")
obj <- biom2MRexperiment(biom_obj)
```

### 2. Normalization (CSS)
Cumulative Sum Scaling (CSS) is the preferred normalization method.
```R
# Calculate the proper percentile for normalization
p <- cumNormStatFast(obj)

# Calculate scaling factors
obj <- cumNorm(obj, p = p)

# Alternative: Wrench normalization (preferred for specific phenotypic groups)
obj <- wrenchNorm(obj, condition = pData(obj)$diet)
```

### 3. Statistical Testing

#### Differential Abundance (Recommended: fitFeatureModel)
Use for comparing two groups using a Zero-Inflated Log-Normal model.
```R
pd <- pData(obj)
mod <- model.matrix(~1 + Group, data = pd)
res <- fitFeatureModel(obj, mod)

# Extract results
MRcoefs(res)
```

#### Complex Designs (fitZig)
Use for multiple groups or confounding covariates using a Zero-Inflated Gaussian model.
```R
settings <- zigControl(maxit = 10, verbose = TRUE)
mod <- model.matrix(~Group + Covariate, data = pd)
res <- fitZig(obj = obj, mod = mod, control = settings)

# Extract results (use eff = 0.5 to filter by effective samples)
MRtable(res, coef = 2, eff = 0.5)
```

#### Longitudinal Analysis (fitTimeSeries)
Use for detecting time intervals of differential abundance in time-series data.
```R
res <- fitTimeSeries(obj, feature = "TaxonName", class = "Group", 
                     time = "TimePoint", id = "SubjectID", B = 1000)
res$timeIntervals
```

### 4. Visualization
```R
# Heatmaps
plotMRheatmap(obj, n = 200, col = colorRampPalette(brewer.pal(9, "RdBu"))(50))

# Ordination (PCA/MDS)
plotOrd(obj, tran = TRUE, bg = pData(obj)$Group, pch = 21)

# Feature-specific plots
plotOTU(obj, otu = 1, classIndex = list(G1 = which(pd$Group == "A"), G2 = which(pd$Group == "B")))
```

## Tips for Success
- **Filtering**: Always filter out extremely rare features before testing (e.g., `filterData(obj, present = 10)`).
- **Effective Samples**: In `fitZig`, check the number of effective samples. Fold-change estimates are unreliable if the effective sample count is too low.
- **Log Transformation**: `MRcounts(obj, norm = TRUE, log = TRUE)` is useful for downstream visualization and manual analysis.

## Reference documentation
- [fitTimeSeries: Longitudinal differential abundance analysis](./references/fitTimeSeries.md)
- [metagenomeSeq: Statistical analysis for sparse high-throughput sequencing](./references/metagenomeSeq.md)