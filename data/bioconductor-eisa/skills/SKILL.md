---
name: bioconductor-eisa
description: This package implements the Iterative Signature Algorithm to identify biclusters or transcription modules of co-expressed genes across subsets of samples. Use when user asks to find overlapping gene modules, perform biclustering on expression data, or conduct Gene Ontology enrichment on identified transcription modules.
homepage: https://bioconductor.org/packages/3.8/bioc/html/eisa.html
---

# bioconductor-eisa

## Overview

The `eisa` package implements the Iterative Signature Algorithm (ISA), a biclustering method designed to find "transcription modules" (sets of genes co-expressed across a subset of samples). Unlike standard clustering, ISA allows for overlapping modules and assigns continuous scores to genes and samples, reflecting their strength of association with a module.

## Core Workflow

### 1. Data Preparation
ISA requires an `ExpressionSet` object. It is highly recommended to normalize the data so that genes and samples are centered and scaled.

```r
library(eisa)
library(ALL)
data(ALL)

# Normalize the ExpressionSet (creates an ISAExpressionSet)
# This generates row-wise and column-wise scaled matrices
ALL.normed <- ISANormalize(ALL)
```

### 2. Running ISA
The simplest interface is the `ISA()` function, which performs non-specific filtering, generates random seeds, and runs the iteration.

```r
# thr.gene: threshold for gene scores (higher = smaller, more correlated modules)
# thr.cond: threshold for sample/condition scores
modules <- ISA(ALL, thr.gene=2.7, thr.cond=1.4)
```

For finer control, use the modular functions:
1. `generate.seeds()`: Create starting points for the iteration.
2. `ISAIterate()`: Run the actual biclustering.
3. `ISAUnique()`: Remove duplicated modules.
4. `ISAFilterRobust()`: Remove modules that appear in scrambled data (noise).

### 3. Inspecting Results
The output is an `ISAModules` object.

```r
# Summary of modules found
modules

# Access specific data
getNoFeatures(modules)  # Number of genes per module
getNoSamples(modules)   # Number of samples per module
featureNames(modules)   # Probeset IDs
sampleNames(modules)    # Sample IDs

# Get scores (-1 to 1)
getFeatureScores(modules, 3) # Scores for genes in module 3
getSampleScores(modules, 3)  # Scores for samples in module 3

# Subset modules
sub_modules <- modules[[1:5]] # Keep first 5 modules
```

### 4. Functional Enrichment
The package provides fast Gene Ontology (GO) enrichment for the identified modules.

```r
# Perform GO enrichment
GO <- ISAGO(modules)

# View results for Biological Process (BP)
# Returns a list of data frames, one per module
summary(GO$BP, p=0.001)

# Get genes driving the enrichment in a specific category
geneIdsByCategory(GO$BP)[[module_index]][[category_index]]
```

## Advanced Features

### Smart Seeding
Instead of random seeds, you can provide "educated" seeds based on known phenotypes or gene sets to find modules associated with specific biological conditions.

```r
# Example: Seed based on B-cell vs T-cell status
type <- pData(ALL)$BT
ss1 <- ifelse(grepl("^B", type), -1, 1)
smart.seeds <- matrix(ss1, ncol=1)

modules_smart <- ISAIterate(ALL.normed, sample.seeds=smart.seeds)
```

### Coherence Measures
You can convert `ISAModules` to `Biclust` objects to use metrics from the `biclust` package.

```r
library(biclust)
Bc <- as(modules, "Biclust")
constantVariance(exprs(ALL), Bc, number=1)
```

## Tips for Success
- **Threshold Selection**: Start with `thr.gene` between 2.0 and 4.0. If you get too many modules, increase the threshold. If you get none, decrease it.
- **Filtering**: Non-specific filtering (e.g., removing low-variance genes) is crucial for reducing noise and computation time.
- **Significance**: Always use `ISAFilterRobust` or the default `ISA()` wrapper to ensure modules are not artifacts of random noise.

## Reference documentation
- [The Iterative Signature Algorithm for Gene Expression Data](./references/EISA_tutorial.md)