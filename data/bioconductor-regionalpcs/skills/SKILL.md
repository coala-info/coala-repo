---
name: bioconductor-regionalpcs
description: The regionalpcs package summarizes high-dimensional DNA methylation data into regional principal components to capture maximum biological variation within genomic intervals. Use when user asks to summarize CpG-level signals, compute regional principal components, or reduce the dimensionality of methylation data for downstream analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/regionalpcs.html
---

# bioconductor-regionalpcs

## Overview
The `regionalpcs` package addresses the challenge of high-dimensional DNA methylation data by summarizing CpG-level signals into Regional Principal Components (rPCs). Unlike simple averaging, rPCs capture the maximum variation and biologically relevant signals within specific genomic intervals. This approach is particularly useful for downstream differential methylation analysis or phenotype association studies where regional context is more informative than individual site analysis.

## Core Workflow

### 1. Data Preparation
The package typically works with methylation M-values or Beta-values (as a matrix) and genomic coordinates (as `GRanges`).

```r
library(regionalpcs)
library(GenomicRanges)

# Extract methylation values (rows = CpGs, cols = samples)
# Example using minfi objects:
mvals <- getM(MsetEx.sub)

# Get CpG coordinates as GRanges
cpg_gr <- granges(gset)
```

### 2. Defining Genomic Regions
You must define the regions (e.g., promoters) you want to summarize. These should be provided as a `GRanges` object.

```r
# Example: Define promoters using a TxDb object
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
promoters_gr <- promoters(genes(txdb), upstream=1000, downstream=0)
```

### 3. Creating a Region Map
The `create_region_map` function links specific CpGs to your defined genomic regions.

```r
# Map CpGs to regions
region_map <- create_region_map(cpg_gr = cpg_gr, genes_gr = promoters_gr)

# Note: Ensure region_map$cpg_id matches the rownames of your methylation matrix
```

### 4. Computing Regional PCs
The `compute_regional_pcs` function performs the summarization. It uses Random Matrix Theory to determine the optimal number of PCs that represent signal rather than noise.

```r
# Compute rPCs using the Gavish-Donoho (gd) method (more conservative)
res <- compute_regional_pcs(meth = mvals, 
                            region_map = region_map, 
                            pc_method = "gd")

# Alternatively, use Marcenko-Pasteur (mp) for potentially more PCs
res_mp <- compute_regional_pcs(meth = mvals, 
                               region_map = region_map, 
                               pc_method = "mp")
```

## Interpreting Results
The output of `compute_regional_pcs` is a list containing:
- `regional_pcs`: A dataframe where rows are "Region-PC#" (e.g., "GeneID-PC1") and columns are samples. This is your new feature matrix for downstream analysis.
- `percent_variance`: The variance explained by each PC.
- `loadings`: The contribution of each CpG to the PCs.
- `info`: Metadata about the computation.

```r
# Access the summarized data
final_features <- res$regional_pcs

# Check how many PCs were generated per region
regions_df <- data.frame(id = rownames(final_features))
# Split ID to see distribution
```

## Tips for Success
- **Genome Builds**: Ensure that your CpG coordinates (`cpg_gr`) and your region annotations (`genes_gr`) use the same genome build (e.g., hg19 vs hg38).
- **Method Selection**: Use `pc_method = "gd"` if you want a more parsimonious model with fewer features. Use `"mp"` if you want to ensure you aren't missing subtler signals, though this may include more noise.
- **Input Values**: While the package accepts Beta-values, M-values are often preferred for the underlying PCA due to their better distributional properties for statistical modeling.

## Reference documentation
- [regionalpcs Vignette (Rmd)](./references/regionalpcs.Rmd)
- [regionalpcs Tutorial (md)](./references/regionalpcs.md)