---
name: bioconductor-wavcluster
description: This tool identifies high-confidence protein binding sites from PAR-CLIP and NGS data by analyzing induced nucleotide substitutions. Use when user asks to identify RNA-protein interaction sites from BAM files, fit mixture models to substitution frequencies, or perform cluster annotation and metagene profiling.
homepage: https://bioconductor.org/packages/release/bioc/html/wavClusteR.html
---


# bioconductor-wavcluster

name: bioconductor-wavcluster
description: Analysis of PAR-CLIP and NGS data with induced nucleotide substitutions (e.g., BisSeq). Use when Claude needs to identify RNA-protein interaction sites (clusters) from BAM files, fit mixture models to substitution frequencies, and perform post-processing like cluster annotation or metagene profiling.

# bioconductor-wavcluster

## Overview

The `wavClusteR` package provides an integrated pipeline for identifying high-confidence protein binding sites from PAR-CLIP data. It leverages experimentally induced nucleotide substitutions (typically T-to-C transitions) to distinguish true binding signals from sequencing errors or SNPs using a non-parametric mixture model and the Mini-Rank Norm (MRN) algorithm for cluster resolution.

## Core Workflow

### 1. Data Input and Substitution Extraction
Load sorted and indexed BAM files and identify all genomic positions with substitutions.

```r
library(wavClusteR)

# Load BAM file
bamData <- readSortedBam("path/to/sorted_indexed.bam")

# Extract substitutions with a coverage threshold (default minCov = 10)
countTable <- getAllSub(bamData, minCov = 10)

# Diagnostic plot of substitution profile
plotSubstitutions(countTable, highlight = "TC")
```

### 2. Mixture Model Estimation
Estimate a model to discriminate experimental transitions from noise.

```r
# Fit the model for a specific substitution type
model <- fitMixtureModel(countTable, substitution = "TC")

# Determine the Relative Substitution Frequency (RSF) interval
# Use bayes = TRUE for a posterior probability cutoff of 0.5
support <- getExpInterval(model, bayes = TRUE)
```

### 3. Identifying High-Confidence Transitions
Filter the observed substitutions using the RSF support interval.

```r
highConfSub <- getHighConfSub(countTable, 
                              support = support, 
                              substitution = "TC")
```

### 4. Cluster Identification and Merging
Resolve binding site boundaries and merge overlapping regions into "wavClusters".

```r
# 1. Identify initial clusters using MRN algorithm
# threshold = 1 is recommended for hard thresholding
clusters <- getClusters(highConfSub = highConfSub,
                        coverage = coverage(bamData),
                        sortedBam = bamData,
                        threshold = 1)

# 2. Filter and merge clusters with statistics
# Requires a BSgenome object for the relevant organism
library(BSgenome.Hsapiens.UCSC.hg19)
wavclusters <- filterClusters(clusters = clusters,
                              highConfSub = highConfSub,
                              coverage = coverage(bamData),
                              model = model,
                              genome = Hsapiens,
                              refBase = "T",
                              minWidth = 12)
```

## Post-Processing and Visualization

### Annotation and Metagene Analysis
Annotate clusters with genomic features and visualize their distribution.

```r
# Annotate clusters (requires a TxDb object)
annotateClusters(clusters = wavclusters, txDB = txDB)

# Compute metagene profile
getMetaGene(clusters = wavclusters, txDB = txDB)

# Plot cluster size distribution
plotSizeDistribution(wavclusters, showCov = TRUE)
```

### Data Export
Export results to standard formats for visualization in genome browsers.

```r
# Export clusters to BED
exportClusters(wavclusters, filename = "results.bed")

# Export high-confidence substitutions to BED
exportHighConfSub(highConfSub, filename = "transitions.bed")

# Export coverage to BigWig
exportCoverage(coverage(bamData), filename = "coverage.bigWig")
```

## Key Considerations
- **Alignment**: Ensure reads were aligned with relaxed parameters to allow for transitions.
- **Coverage Threshold**: Do not set `minCov` below 10 in `getAllSub`, as the mixture model relies on stable relative frequencies.
- **Ranking**: Use the `RelLogOdds` metadata column in the final `wavclusters` object to rank binding sites by statistical confidence.
- **Parallelization**: Functions like `getAllSub` and `getClusters` support multi-core computing via the `cores` argument.

## Reference documentation
- [wavClusteR: a workflow for PAR-CLIP data analysis](./references/wavCluster_vignette.md)