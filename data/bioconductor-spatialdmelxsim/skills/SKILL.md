---
name: bioconductor-spatialdmelxsim
description: This package provides access to allelic expression counts from spatial slices of Drosophila melanogaster and Drosophila simulans hybrid embryos. Use when user asks to load the spatialDmelxsim dataset, calculate allelic ratios, or visualize spatially varying cis-regulatory divergence across embryo slices.
homepage: https://bioconductor.org/packages/release/data/experiment/html/spatialDmelxsim.html
---


# bioconductor-spatialdmelxsim

name: bioconductor-spatialdmelxsim
description: Access and analyze allelic expression counts from spatial slices of Drosophila melanogaster x Drosophila simulans hybrid embryos. Use this skill to load the spatialDmelxsim dataset, calculate allelic ratios, and visualize spatially varying cis-regulatory divergence across embryo slices.

# bioconductor-spatialdmelxsim

## Overview

The `spatialDmelxsim` package provides a specialized dataset (as a `SummarizedExperiment`) containing allelic expression counts from spatial slices of fly embryos. The data comes from a reciprocal cross between *D. melanogaster* and *D. simulans*. This resource is primarily used to study spatially varying allelic-specific expression (svASE) and cis-regulatory logic as described in Combs and Fraser (2018).

## Loading the Data

The primary way to access the data is through the package's accessor function, which retrieves the object from ExperimentHub.

```r
library(spatialDmelxsim)
library(SummarizedExperiment)

# Load the SummarizedExperiment object
se <- spatialDmelxsim()
```

Alternatively, you can use `ExperimentHub` directly:
```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "spatialDmelxsim")
# se <- eh[["EH6129"]]
```

## Data Preparation

The object uses Ensembl IDs as rownames by default. For easier analysis, it is common practice to switch to the gene symbols used in the original publication.

```r
# Check for NAs and set rownames to paper symbols
table(is.na(mcols(se)$paper_symbol))
rownames(se) <- mcols(se)$paper_symbol
```

### Allele Mapping
*   **a1**: *D. simulans* allele
*   **a2**: *D. melanogaster* allele

### Calculating Allelic Ratios
To analyze the bias toward one species, calculate the ratio of the *simulans* allele over the total counts:

```r
assay(se, "total") <- assay(se, "a1") + assay(se, "a2") 
assay(se, "ratio") <- assay(se, "a1") / assay(se, "total")
```

## Visualizing Spatial Patterning

The `normSlice` column in the metadata represents the spatial position (slice number) scaled to a standard length of 27 slices.

### Plotting Workflow
Use the following pattern to visualize how the allelic ratio changes across the embryo:

```r
plot_spatial_ase <- function(se, gene_name) {
    x <- se$normSlice
    y <- assay(se, "ratio")[gene_name, ]
    replicate_color <- as.integer(se$rep)
    
    plot(x, y, xlab="Normalized Slice", ylab="sim / total ratio",
         ylim=c(0,1), main=gene_name, col=replicate_color)
    
    # Add a trend line
    lw <- loess(y ~ x)
    lines(sort(x), predict(lw, newdata=data.frame(x=sort(x))), col="red", lwd=2)
    abline(h=0.5, col="grey", lty=2)
}

# Example: Plot a gene with spatial patterning
plot_spatial_ase(se, "hb")
```

## Key Metadata Columns

*   `mcols(se)$paper_symbol`: Gene symbols used in the Combs and Fraser (2018) publication.
*   `mcols(se)$scASE`: Logical flag indicating genes with spatially varying allelic-specific expression (svASE).
*   `mcols(se)$predicted`: Logical flag indicating if allelic counts were imputed/predicted from FPKM data (5,673 genes).
*   `se$normSlice`: The spatial coordinate of the slice (1 to 27).
*   `se$rep`: The biological replicate/embryo ID.
*   `se$strain`: Indicates the parental arrangement (reciprocal cross info).

## Reference documentation

- [spatialDmelxsim Vignette (Rmd)](./references/spatialDmelxsim.Rmd)
- [spatialDmelxsim Documentation (md)](./references/spatialDmelxsim.md)