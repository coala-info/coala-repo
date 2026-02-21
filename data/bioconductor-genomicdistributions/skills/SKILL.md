---
name: bioconductor-genomicdistributions
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicDistributions.html
---

# bioconductor-genomicdistributions

## Overview
The `GenomicDistributions` package provides a suite of functions to summarize and visualize the properties of genomic range sets (GRanges objects). It follows a modular "calc-then-plot" philosophy: `calc*` functions perform the heavy lifting and return data tables, while `plot*` functions take those tables and return `ggplot2` objects. This allows for easy customization and integration into larger R workflows.

## Core Workflow

### 1. Data Preparation
Load your genomic regions into a `GRanges` or `GRangesList` object.
```r
library(GenomicDistributions)
library(GenomicDistributionsData) # For full-size reference data
query = rtracklayer::import("my_regions.bed")
```

### 2. Chromosome Distributions
Visualize how regions are spread across the genome.
- **Calculate:** `calcChromBinsRef(query, "hg38")`
- **Plot:** `plotChromBins(df)`

### 3. Feature Distance (e.g., TSS)
Analyze the distance from your regions to the nearest Transcription Start Site or custom feature.
- **TSS (Built-in):** `calcFeatureDistRefTSS(query, "hg38")`
- **Custom Feature:** `calcFeatureDist(query, featureGRanges)`
- **Plot:** `plotFeatureDist(df, featureName="TSS")`
- **Tip:** Use `tile=TRUE` and `labelOrder="center"` in the plot function to compare multiple datasets in a heatmap-like view.

### 4. Genomic Partitions
Determine if regions overlap specific functional elements (promoters, exons, introns, intergenic).
- **Percentage:** `calcPartitionsRef(query, "hg38")`
- **Expected (Observed/Expected):** `calcExpectedPartitionsRef(query, "hg38")`
- **Cumulative:** `calcCumulativePartitionsRef(query, "hg38")`
- **Plot:** `plotPartitions(df)`, `plotExpectedPartitions(df)`, or `plotCumulativePartitions(df)`
- **Proportional Overlap:** Set `bpProportion=TRUE` in `calc` functions to calculate based on base-pair overlap rather than region counts.

### 5. Sequence Properties
Calculate GC content or dinucleotide frequencies (requires `BSgenome` packages).
- **GC Content:** `calcGCContentRef(query, "hg38")` -> `plotGCContent(df)`
- **Dinucleotides:** `calcDinuclFreqRef(query, "hg38")` -> `plotDinuclFreq(df)`

### 6. Signal in Regions
Summarize signal (e.g., DNase-seq, ATAC-seq) across your regions using a signal matrix.
- **Calculate:** `calcSummarySignal(query, openSignalMatrix_hg38)`
- **Plot:** `plotSummarySignal(df, metadata=cellTypeMetadata, colorColumn="tissueType")`

## Custom Genomes and Features
If working with a non-standard genome, use the following utility functions to build reference data:
- `getChromSizesFromFasta(fastaSource)`
- `getTssFromGTF(gtfSource)`
- `getGeneModelsFromGTF(gtfSource)`
- `genomePartitionList(...)` to create a custom priority list for partition analysis.

## Reference documentation
- [Full power GenomicDistributions](./references/full-power.md)
- [Getting started with GenomicDistributions](./references/intro.md)