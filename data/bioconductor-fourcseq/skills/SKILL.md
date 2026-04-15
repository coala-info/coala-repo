---
name: bioconductor-fourcseq
description: This tool analyzes 4C-seq data to identify chromatin interactions and detect differential interactions between experimental conditions. Use when user asks to analyze 4C-seq data, generate fragment libraries, count reads at fragment ends, calculate Z-scores for interaction detection, or perform differential interaction analysis.
homepage: https://bioconductor.org/packages/3.12/bioc/html/FourCSeq.html
---

# bioconductor-fourcseq

name: bioconductor-fourcseq
description: Analysis of 4C (Circularized Chromosome Conformation Capture) sequencing data to detect DNA element interactions and differential interactions between conditions. Use this skill when analyzing 4C-seq data starting from BAM files, including fragment library generation, read counting at fragment ends, Z-score calculation for interaction detection, and differential analysis using DESeq2-based methods.

## Overview
FourCSeq is a specialized Bioconductor package for the analysis of 4C-seq data. It manages the complex workflow of in-silico genome digestion, mapping reads to specific restriction fragment ends, and applying statistical models to identify significant chromatin interactions. It integrates with `SummarizedExperiment` and `DESeq2` for robust statistical testing of differential interactions across multiple experimental conditions.

## Core Workflow

### 1. Initialization
Create a `FourC` object by defining metadata (paths and enzyme sequences) and colData (sample information).

```r
library(FourCSeq)

metadata <- list(
  projectPath = "project_dir",
  fragmentDir = "re_fragments",
  referenceGenomeFile = "path/to/genome.fa",
  reSequence1 = "GATC", # First restriction enzyme
  reSequence2 = "CATG", # Second restriction enzyme
  primerFile = "path/to/primers.fa",
  bamFilePath = "path/to/bam_files"
)

colData <- DataFrame(
  viewpoint = "vp1",
  condition = factor(c("cond1", "cond1", "cond2", "cond2")),
  replicate = c(1, 2, 1, 2),
  bamFile = c("s1.bam", "s2.bam", "s3.bam", "s4.bam"),
  sequencingPrimer = "first" # "first" or "second" cutter side
)

fc <- FourC(colData, metadata)
```

### 2. Fragment Reference and Viewpoints
Generate the in-silico digestion and locate the viewpoint fragments.

```r
fc <- addFragments(fc)
findViewpointFragments(fc)
fc <- addViewpointFrags(fc)
```

### 3. Counting and Smoothing
Count reads mapping to fragment ends. Use `trim` to remove restriction site sequences if they are still present in the BAM reads.

```r
# Count reads at fragment ends
fc <- countFragmentOverlaps(fc, trim = 4, minMapq = 30)
fc <- combineFragEnds(fc)

# Optional: Smooth counts for visualization
fc <- smoothCounts(fc)

# Export tracks
writeTrackFiles(fc, format = "bw")
```

### 4. Detecting Interactions (Z-scores)
Identify significant interactions within samples by fitting the decay of 4C signal over distance.

```r
# Calculate Z-scores
fcf <- getZScores(fc)

# Call peaks (interactions)
# Requires z-score > 3 in both replicates and FDR < 0.01 in at least one
fcf <- addPeaks(fcf, zScoreThresh = 3, fdrThresh = 0.01)

# Visualize fits and Z-scores
plotFits(fcf[,1])
plotZScores(fcf[,1:2], txdb = TxDb.Dmelanogaster.UCSC.dm3.ensGene)
```

### 5. Differential Interactions
Compare interaction frequencies between conditions using `getDifferences`.

```r
# referenceCondition defines the baseline for log2 fold changes
fcf <- getDifferences(fcf, referenceCondition = "cond1")

# Extract results
res <- getAllResults(fcf)

# Visualize differences
plotDifferences(fcf, txdb = TxDb.Dmelanogaster.UCSC.dm3.ensGene)
```

## Key Functions and Data Structures
- `FourC`: Constructor for the main data object.
- `addFragments`: Performs in-silico digestion of the reference genome.
- `countFragmentOverlaps`: Assigns BAM reads to fragment ends based on orientation.
- `getZScores`: Fits the distance-dependent decay and calculates Z-scores for interaction detection.
- `getDifferences`: Uses DESeq2 framework to test for differential interactions between conditions.
- `assays(fc)`: Access count matrices (`counts`, `countsLeftFragmentEnd`, `countsRightFragmentEnd`).

## Tips for Success
- **Enzyme Sequences**: Ensure `reSequence1` is the cutter used for the initial circularization and `reSequence2` is the secondary cutter.
- **Primer Orientation**: The `sequencingPrimer` column in `colData` is critical; it tells the package which end of the fragment the reads originate from.
- **Filtering**: `getZScores` filters fragments with low median counts (default 40). Adjust this if your library depth is low.
- **Visualization**: Use `plotScatter` to check reproducibility between replicates before proceeding to differential analysis.

## Reference documentation
- [FourCSeq analysis workflow](./references/FourCSeq.md)