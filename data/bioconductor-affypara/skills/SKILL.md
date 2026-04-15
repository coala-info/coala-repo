---
name: bioconductor-affypara
description: This tool provides parallelized preprocessing methods for Affymetrix oligonucleotide microarrays to handle large datasets efficiently. Use when user asks to perform background correction, normalization, or summarization on large numbers of CEL files using a computer cluster or multicore processor.
homepage: https://bioconductor.org/packages/3.8/bioc/html/affyPara.html
---

# bioconductor-affypara

name: bioconductor-affypara
description: Parallelized preprocessing of Affymetrix oligonucleotide microarrays using the affyPara package. Use this skill when you need to perform background correction, normalization, or summarization on large microarray datasets (typically >150 arrays) using a computer cluster or multicore processor to overcome memory limitations and accelerate computation.

# bioconductor-affypara

## Overview

The `affyPara` package provides parallelized versions of the preprocessing methods found in the `affy` package. It is specifically designed to handle large numbers of Affymetrix CEL files by distributing data across multiple nodes or cores. This approach solves the memory exhaustion issues common with the standard `AffyBatch` object and significantly reduces processing time.

## Workflow and Usage

### 1. Cluster Initialization
Before using any parallel functions, you must initialize a cluster using `snow` (integrated into `affyPara`).

```R
library(affyPara)

# Start a cluster (e.g., 4 nodes using sockets)
# affyPara masks makeCluster to store the object internally
makeCluster(4, type = "SOCK")
```

### 2. Data Input
For large datasets, it is more memory-efficient to pass a vector of CEL file paths rather than a pre-loaded `AffyBatch` object.

```R
# Get list of CEL files
files <- list.celfiles(full.names = TRUE)
```

### 3. Parallel Preprocessing Functions

#### Background Correction
```R
# Available methods: "bg.correct", "mas", "none", "rma"
bg_data <- bgCorrectPara(files, method = "rma")
```

#### Normalization
```R
# Quantile normalization
norm_data <- normalizeAffyBatchQuantilesPara(files, type = "pmonly")

# Other available functions:
# normalizeAffyBatchConstantPara()
# normalizeAffyBatchInvariantsetPara()
# normalizeAffyBatchLoessPara()
# vsnPara()
```

#### Summarization
```R
# Generates an ExpressionSet
eset <- computeExprSetPara(files, pmcorrect.method = "pmonly", summary.method = "avgdiff")
```

### 4. Combined Preprocessing (Recommended)
The most efficient way to process data is using combined functions. This avoids building intermediate `AffyBatch` objects and reduces data transfer between nodes.

```R
# General preprocessing (similar to expresso)
eset <- preproPara(files, 
                   bgcorrect = TRUE, bgcorrect.method = "rma",
                   normalize = TRUE, normalize.method = "quantil",
                   pmcorrect.method = "pmonly",
                   summary.method = "avgdiff")

# Parallel RMA (Robust Multi-array Average)
eset_rma <- rmaPara(files)

# Parallel VSN-RMA
eset_vsn <- vsnrmaPara(files)
```

### 5. Quality Control
Parallelized versions of graphical QC tools are available for large datasets:
```R
boxplotPara(files)
MAplotPara(files)
```

### 6. Cluster Termination
Always stop the cluster when finished to free up system resources.
```R
stopCluster()
```

## Key Tips
- **Memory Management**: Always prefer passing file paths (`files`) to functions instead of an `AffyBatch` object to minimize the memory footprint on the master node.
- **Accuracy**: Parallel results are identical to serial results (within machine accuracy). For `loess` normalization, use `set.seed()` before calling the function to ensure reproducibility, as it uses random sub-sampling.
- **Data Distribution**: If nodes do not share a filesystem, use `distributeFiles(files, protocol="RCP")` to move CEL files to slave nodes before processing.
- **VSN Subsampling**: The default `vsn2` uses 30,000 probes for parameter estimation. For high-density chips, increasing this (e.g., `subsample = 100000`) via `vsnPara` can improve accuracy but requires the parallel capabilities of `affyPara` to handle the increased load.

## Reference documentation
- [affyPara: Parallelized preprocessing methods for Affymetrix Oligonucleotide Arrays](./references/affyPara.md)
- [Simulation Study for vsn Add-On Normalization and Subsample Size](./references/vsnStudy.md)