---
name: bioconductor-snapcgh
description: This tool provides a comprehensive pipeline for the segmentation, normalization, and processing of array CGH data. Use when user asks to read aCGH data, normalize log2 ratios, perform genomic segmentation using algorithms like BioHMM or DNAcopy, and visualize copy number profiles.
homepage: https://bioconductor.org/packages/3.9/bioc/html/snapCGH.html
---

# bioconductor-snapcgh

name: bioconductor-snapcgh
description: Analysis of array CGH (aCGH) data including reading, normalization, and segmentation. Use this skill when you need to process aCGH data in R, specifically for: (1) Reading GenePix, Agilent, Bluefuse, or Nimblegen data, (2) Incorporating genomic positional information, (3) Normalizing log2 ratios, (4) Running segmentation algorithms (BioHMM, HomHMM, GLAD, DNAcopy, tilingArray), and (5) Visualizing copy number profiles across the genome or specific chromosomes.

# bioconductor-snapcgh

## Overview

The `snapCGH` package provides a comprehensive pipeline for the Segmentation, Normalization, and Processing of array CGH data. It is designed to work seamlessly with the `limma` package, extending its `RGList` and `MAList` objects to handle genomic coordinates. The package is notable for its implementation of `BioHMM` (a heterogeneous hidden Markov model) and its ability to act as a wrapper for several other popular segmentation methods.

## Typical Workflow

### 1. Data Loading and Pre-processing
Load the library and read in raw intensity data. `snapCGH` uses `limma`'s reading functions but adds positional metadata.

```r
library(snapCGH)

# Read targets and raw images (GenePix example)
targets <- readTargets("targets.txt")
RG <- read.maimages(targets$FileName, source = "genepix")

# Add positional information (Chr and Position in Mb)
# Supported: "Agilent", "Bluefuse", "Nimblegen"
RG <- readPositionalInfo(RG, "Agilent")

# Alternatively, read from a custom clone info file
# File must have 'Chr' and 'Position' columns
RG <- read.clonesinfo("cloneinfo.txt", RG)

# Background correction and Normalization
RG2 <- backgroundCorrect(RG, method = "minimum")
MA <- normalizeWithinArrays(RG2, method = "median")
```

### 2. Processing for Segmentation
Before segmentation, data should be "tidied" to handle replicate clones and ensure correct ordering.

```r
# Average replicates and remove duplicates
MA2 <- processCGH(MA, method.of.averaging = mean, ID = "ID")
```

### 3. Segmentation Methods
`snapCGH` provides access to multiple algorithms. All return a `SegList` object.

*   **BioHMM (Recommended):** Heterogeneous HMM that accounts for varying distances between clones.
    ```r
    SegInfo.Bio <- runBioHMM(MA2)
    ```
*   **HomHMM:** Homogeneous HMM.
    ```r
    SegInfo.Hom <- runHomHMM(MA2, criteria = "AIC")
    ```
*   **Wrappers:** Access methods from other packages (`DNAcopy`, `GLAD`, `tilingArray`).
    ```r
    SegInfo.DNAcopy <- runDNAcopy(MA2)
    ```

### 4. Merging States
Segmentation often produces states with very similar means. Use `mergeStates` to consolidate these.

```r
SegInfo.merged <- mergeStates(SegInfo.Bio, MergeType = 1)
```

### 5. Visualization
The package includes static and interactive plotting functions.

*   **Genome Plot:** Plot log2 ratios against genomic position.
    ```r
    genomePlot(MA2, array = 1)
    # Plot specific chromosome
    genomePlot(MA2, array = 1, chrom.to.plot = 8)
    ```
*   **Segmented Plot:** Overlay predicted segments on the data.
    ```r
    plotSegmentedGenome(SegInfo.merged, array = 1)
    ```
*   **Interactive Zooming:**
    ```r
    # Click on a chromosome to zoom in
    zoomGenome(SegInfo.merged, array = 1)
    # Click two points on a chromosome to zoom into a region
    zoomChromosome(SegInfo.merged, array = 1, chrom.to.plot = 1)
    ```

## Simulation and Evaluation
You can simulate aCGH data to test the performance of different segmentation algorithms.

```r
# Simulate 4 arrays
simulation <- simulateData(nArrays = 4)

# Run algorithms on simulated data
Sim.DNAcopy <- runDNAcopy(simulation)

# Compare against ground truth
rates <- compareSegmentations(simulation, offset = 0, Sim.DNAcopy)
# Access True Positive Rate (TPR) and False Discovery Rate (FDR)
rates$TPR
rates$FDR
```

## Tips and Best Practices
*   **Reference Channel:** If Cy3 is the reference, set `RG$design <- 1`. If Cy5 is the reference, set `RG$design <- -1`.
*   **Memory/Time:** Segmentation (especially BioHMM) on large datasets can be computationally intensive. Ensure your data is averaged using `processCGH` to reduce the number of points if necessary.
*   **Chromosome Labels:** The package handles 'X' and 'Y' as 23 and 24 automatically when reading clone information.

## Reference documentation
- [snapCGH Users' Guide](./references/snapCGHguide.md)