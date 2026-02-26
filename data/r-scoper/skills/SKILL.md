---
name: r-scoper
description: The scoper package provides computational methods for B cell clonal identification by grouping sequences based on V and J gene usage and junction length. Use when user asks to identify B cell clones, perform hierarchical or spectral clustering on AIRR-Seq data, or group sequences by identical junction regions.
homepage: https://cran.r-project.org/web/packages/scoper/index.html
---


# r-scoper

## Overview
The `scoper` package provides methods for B cell clonal identification. It groups sequences that share the same V gene, J gene, and junction length. It offers three primary algorithms:
1. **Identical**: Groups sequences with 100% identity.
2. **Hierarchical**: Groups sequences using a fixed distance threshold.
3. **Spectral**: Groups sequences using an adaptive, unsupervised threshold (with optional fixed cut-off).

## Installation
```r
install.packages("scoper")
library(scoper)
```

## Data Preparation
Input data must be in AIRR-Seq format (data.frame). Required columns:
- `junction`: Junction region sequence.
- `v_call`: V segment gene call.
- `j_call`: J segment gene call.
- `sequence_alignment`: Aligned nucleotide sequence.
- `germline_alignment_d_mask`: Germline sequence (required for `spectralClones` with `method="vj"`).

**Single Cell Note**: Ensure only one heavy chain per `cell_id` exists. Remove multi-heavy chain cells before processing:
```r
library(dplyr)
heavy_count <- table(filter(ExampleDb, locus=="IGH")$cell_id)
multi_heavy_cells <- names(heavy_count)[heavy_count > 1]
db <- filter(ExampleDb, !cell_id %in% multi_heavy_cells)
```

## Clonal Identification Workflows

### 1. Identical Sequence Matching
Use for the strictest definition of cloning (100% identity).
```r
# Nucleotide level (method="nt") or Amino Acid level (method="aa")
results <- identicalClones(db, method="nt")
```

### 2. Hierarchical Clustering
Requires a predefined distance threshold (typically determined via `shazam::findThreshold`).
```r
# threshold is the distance cut-off for the hierarchy
results <- hierarchicalClones(db, threshold=0.15)
```

### 3. Spectral Clustering (Adaptive)
Use when a clear threshold cannot be found (unimodal distance distribution) or to account for local neighborhood density.
- `method="novj"`: Based on junction region homology.
- `method="vj"`: Combines junction homology with V/J mutation profiles.

```r
# Adaptive thresholding
results <- spectralClones(db, method="novj")

# Adaptive with an upper-limit fixed threshold
results <- spectralClones(db, method="novj", threshold=0.15)

# Including V/J mutation profiles (requires germline column)
results <- spectralClones(db, method="vj", threshold=0.15, 
                          germline="germline_alignment_d_mask")
```

## Handling Results
All main functions return a `ScoperClones` object.
```r
# Extract the data.frame with 'clone_id' column
results_db <- as.data.frame(results)

# Visualize inter- and intra-clonal distances
plot(results, binwidth=0.02)

# Get summary statistics (clone sizes, etc.)
summary(results)
```

## Tips
- **summarize_clones**: Set `summarize_clones = TRUE` in the main functions to pre-calculate summary statistics for the `summary()` method.
- **Effective Threshold**: In hierarchical and spectral methods, `scoper` calculates an "effective threshold" in the output, which represents the actual cut-off achieved between inter- and intra-clonal distances.

## Reference documentation
- [Identifying clones from high-throughput B cell repertoire sequencing data](./references/Scoper-Vignette.Rmd)