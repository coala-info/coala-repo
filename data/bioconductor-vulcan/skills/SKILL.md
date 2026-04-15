---
name: bioconductor-vulcan
description: VULCAN identifies transcription factor co-regulators by integrating ChIP-Seq data with gene regulatory networks using an adaptation of the VIPER algorithm. Use when user asks to identify master regulators from ChIP-Seq data, perform virtual ChIP-Seq analysis through networks, or test for enrichment of differentially bound genes within regulons.
homepage: https://bioconductor.org/packages/release/bioc/html/vulcan.html
---

# bioconductor-vulcan

name: bioconductor-vulcan
description: Virtual ChIP-Seq Analysis through Networks (VULCAN). Use this skill to identify transcription factor co-regulators by combining ChIP-Seq data with gene regulatory networks (ARACNe). It is specifically designed for analyzing TF occupancy changes in response to stimuli by testing the enrichment of differentially bound genes within established regulons.

## Overview

VULCAN (VirtUaL ChIP-Seq Analysis through Networks) is a computational pipeline that adapts the VIPER algorithm for ChIP-Seq analysis. It treats ChIP-Seq promoter occupancy as a proxy for regulatory activity. By overlaying differential binding signatures onto a regulatory network (regulon), VULCAN identifies co-factors and master regulators likely involved in a specific biological response.

## Core Workflow

### 1. Data Import and Annotation
VULCAN requires a sample sheet (CSV format) defining the BAM and BED file locations.

```r
library(vulcan)
# Import data based on a sample sheet
vobj <- vulcan.import("samplesheet.csv")

# Annotate peaks to gene names
# lborder/rborder define the window around the TSS (e.g., +/- 10kb)
vobj <- vulcan.annotate(vobj, lborder=-10000, rborder=10000, method="sum")
```

### 2. Normalization
Normalize peak abundance to allow for differential binding analysis.

```r
vobj <- vulcan.normalize(vobj)
# Check available conditions
names(vobj$samples)
```

### 3. Network Integration and Analysis
VULCAN requires a network object (typically an ARACNe-generated regulon compatible with the `viper` package).

```r
# Run the VULCAN pipeline
# contrast: c("case", "control")
vobj_analysis <- vulcan(vobj, network=network_object, contrast=c("t90", "t0"), minsize=5)

# Visualize results using msviper plotting
plot(vobj_analysis$msviper, mrs=7)
```

## Functional Analysis Tools

### Gene Set Enrichment Analysis (GSEA)
VULCAN includes a GSEA implementation that can use a Pareto tail distribution for accurate p-value estimation in the tails.

```r
# reflist: named vector of gene scores
# set: character vector of genes in the set
res <- gsea(reflist, set, method="pareto")
plot_gsea(res)
```

### Rank Enrichment Analysis (REA)
REA provides a fast, linear algebraic method to calculate enrichment of multiple groups over a signature.

```r
# signatures: named vector of values
# groups: list of gene sets
rea_results <- rea(signatures=signatures, groups=groups)
```

## Convenience Functions

- `kmgformat()`: Formats large numbers into human-readable strings (K, M, G, T, P). Useful for axis labels.
- `val2col()`: Converts a numeric distribution into a color scale for plotting.

## Tips for Success
- **Regulon Compatibility**: Ensure your regulatory network is a `regulon` class object as defined by the `viper` package.
- **Peak Width**: VULCAN works best when peak widths are optimized; consider using the `csaw` package integration if default widths are insufficient.
- **Small Datasets**: If working with a subset of the genome (e.g., a single chromosome for testing), reduce the `minsize` parameter in the `vulcan()` function to avoid filtering out all regulons.

## Reference documentation
- [Using vulcan, a package that combines regulatory networks and ChIP-Seq data to identify chromatin-binding cofactors](./references/vulcan.md)