---
name: bioconductor-genebreak
description: This tool identifies genes recurrently affected by copy number aberration-associated breakpoints in genomic data. Use when user asks to detect DNA breaks within gene boundaries, map breakpoints to gene annotations, or perform statistical testing to identify recurrently broken genes across a cohort.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneBreak.html
---

# bioconductor-genebreak

name: bioconductor-genebreak
description: Analysis of copy number aberration (CNA) breakpoints to identify recurrently affected genes. Use when analyzing genomic structural variants from array-CGH or sequencing data to detect DNA breaks within gene boundaries and perform cohort-based statistical testing for recurrence.

# bioconductor-genebreak

## Overview

The `GeneBreak` package is designed to identify genes that are recurrently affected by copy number aberration-associated breakpoints. These breakpoints often indicate underlying DNA breaks and structural variants. The workflow typically involves processing copy number data (from array-CGH or NGS), filtering for high-confidence breakpoints, mapping these to gene annotations, and performing statistical tests to identify genes broken more frequently than expected by chance.

## Core Workflow

### 1. Loading Data and Detecting Breakpoints
GeneBreak accepts `cghCall` or `QDNAseq` objects directly. Alternatively, you can provide a dataframe.

```r
library(GeneBreak)

# Option A: From a cghCall/QDNAseq object
breakpoints <- getBreakpoints(data = myCghCallObject)

# Option B: From a dataframe (requires columns: Chromosome, Start, End, FeatureName)
# data2 is optional and contains discrete calls (loss, neutral, gain)
breakpoints <- getBreakpoints(data = segmented_df, data2 = called_df)
```

### 2. Filtering Breakpoints
Filter breakpoints to remove those flanked by copy number neutral segments (default "CNA-ass").

```r
# filter = "CNA-ass" requires discrete copy number calls
breakpointsFiltered <- bpFilter(breakpoints, filter = "CNA-ass")
```

### 3. Gene Annotation and Mapping
Map the detected breakpoints to specific genes. The package includes built-in annotations for hg18, hg19, and hg38.

```r
# Load built-in annotation
data("ens.gene.ann.hg19")

# Add annotation to the object
breakpointsAnnotated <- addGeneAnnotation(breakpointsFiltered, ens.gene.ann.hg19)

# Identify genes affected by breakpoints
breakpointGenes <- bpGenes(breakpointsAnnotated)
```

### 4. Statistical Analysis
Identify recurrently broken genes or features across a cohort.

```r
# Gene-level statistics (recommended: "Gilbert" method for discrete distributions)
breakpointStatistics <- bpStats(breakpointGenes, level = "gene", method = "Gilbert")

# Feature-level statistics (recommended: "BH" method)
breakpointStatistics <- bpStats(breakpointStatistics, level = "feature", method = "BH")
```

### 5. Results and Visualization
Extract results and visualize breakpoint frequencies across the genome.

```r
# Get recurrently broken genes (FDR < 0.1)
recurrent_list <- recurrentGenes(breakpointStatistics)

# Get detailed gene or feature info
gene_details <- geneInfo(breakpointStatistics)
feature_details <- featureInfo(breakpointStatistics)

# Plot breakpoint frequencies
bpPlot(breakpointStatistics, fdr.threshold = 0.1)
```

## Key Functions and Parameters

- `getBreakpoints()`: Initial detection of breakpoints from segmented data.
- `bpFilter()`: Removes low-confidence or non-CNA associated breakpoints.
- `addGeneAnnotation()`: Maps genomic features to gene names.
- `bpGenes()`: Determines which specific genes are intersected by breakpoints.
- `bpStats()`: Performs cohort-wide statistical testing.
    - `method = "Gilbert"`: Optimized for gene-level testing with covariates (gene length, feature coverage).
    - `method = "BH"`: Standard Benjamini-Hochberg correction.
- `geneInfo()`: Returns a dataframe with gene-level results, including `sampleCount` and `nrOfBreakLocations`.

## Data Requirements
- **Input Dataframe**: If not using Bioconductor objects, the input must have exactly these five columns: `Chromosome`, `Start`, `End`, `FeatureName`, followed by sample data columns.
- **Gene Annotation**: Requires a dataframe with `Gene`, `Chromosome`, `Start`, and `End`.

## Reference documentation

- [GeneBreak](./references/GeneBreak.md)