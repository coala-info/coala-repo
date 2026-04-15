---
name: bioconductor-yrimulti
description: The bioconductor-yrimulti package provides specialized data structures and interfaces for the integrative analysis of expression, methylation, and chromatin accessibility data from the HapMap YRI population. Use when user asks to perform gene-centric integration of multi-omic assays, compute regressions between gene expression and nearby CpG methylation, or access specialized YRI population datasets.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/yriMulti.html
---

# bioconductor-yrimulti

## Overview

The `yriMulti` package provides specialized interfaces and data structures for the HapMap YRI population. It serves as a bridge between disparate genomic data types—expression, methylation, and chromatin accessibility—allowing for integrative analysis. It is particularly useful for studying molecular quantitative trait loci (QTLs) and associations between different regulatory layers (e.g., methylation-expression associations).

## Basic Data Resources

The package provides or facilitates access to several key datasets:

*   **Methylation Data**: Access via `data(banovichSE)`. This is a `RangedSummarizedExperiment` containing 450k methylation betas.
*   **Expression Data**: Typically uses `geuvPack`. Access via `data(geuFPKM)`.
*   **DNaseI Hypersensitivity**: Access via `data(DHStop5_hg19)` from the `dsQTL` package.
*   **Genotype Data**: Facilitates access to 1000 Genomes VCF files stored in S3 buckets using `gtpath()`.

```r
library(yriMulti)
library(geuvPack)

# Load methylation data
data(banovichSE)

# Load expression data
data(geuFPKM)
```

## Gene-Centric Integration

A primary workflow in `yriMulti` is selecting data from multiple assays based on a specific gene symbol.

### Using mexGR
The `mexGR` function creates a `GRanges` instance containing methylation scores for CpGs near a specified gene, with expression measures included in the metadata columns.

```r
# Extract methylation and expression for ORMDL3
m1 <- mexGR(banovichSE, geuFPKM, symbol="ORMDL3")

# Check counts of expression vs methylation ranges
table(mcols(m1)$type)
```

### Association Analysis with bindelms
The `bindelms` function computes regressions of a gene's expression against the methylation scores of nearby CpGs.

```r
# Compute regressions for BRCA2 within a 20kb radius
# ytx=log applies a log transformation to expression values
b1 <- bindelms(geuFPKM, banovichSE, symbol="BRCA2", ytx=log, gradius=20000)

# View regression statistics (t-stats, p-values) in rowData
mcols(b1)[, c("t", "p")]

# Visualize the strongest association
plotEvM(b1)
```

## MultiAssayExperiment Workflow

For more complex integrations, `yriMulti` leverages the `MultiAssayExperiment` (MAE) infrastructure.

### Construction
```r
library(MultiAssayExperiment)

# Combine assays into a list
myobs <- list(geuvRNAseq = geuFPKM, yri450k = banovichSE)
cold <- colData(geuFPKM)

# Create the unified object
mm <- MultiAssayExperiment(myobs, as.data.frame(cold))
```

### Range-Based Subsetting
You can subset all assays in the MAE simultaneously based on a genomic range (e.g., a gene's coordinates).

```r
library(erma)
# Get range for BRCA2
brr <- range(genemodel("BRCA2"))

# Subset the entire MAE (adding 20kb padding)
newmm <- subsetByRow(mm, brr + 20000)
```

## Advanced Genotype Integration

The package supports integrating VCF data via `VcfStack`. This allows for large-scale genotype queries without loading entire VCFs into memory.

```r
library(gQTLstats)
library(VariantAnnotation)

# Generate paths to 1000 Genomes VCFs for specific chromosomes
pa <- paths1kg(paste0("chr", c(21:22)))
ob <- RangedVcfStack(VcfStack2(pa, seqinfo(Homo.sapiens)))

# Add to MultiAssayExperiment
myobs <- list(geuvRNAseq = geuFPKM, yriGeno = ob)
mm <- MultiAssayExperiment(myobs)
```

## Reference documentation

- [yriMulti](./references/yriMulti.md)