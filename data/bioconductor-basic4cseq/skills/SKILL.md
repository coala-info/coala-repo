---
name: bioconductor-basic4cseq
description: Basic4Cseq is an R/Bioconductor package for the end-to-end analysis and visualization of 4C-seq data. Use when user asks to create virtual fragment libraries, map aligned reads to fragments, normalize data, or visualize 4C-seq interactions near a viewpoint.
homepage: https://bioconductor.org/packages/release/bioc/html/Basic4Cseq.html
---


# bioconductor-basic4cseq

## Overview
Basic4Cseq is an R/Bioconductor package designed for the end-to-end analysis of 4C-seq data. It handles the unique requirements of 4C-seq, where reads originate from specific restriction enzyme sites. The package facilitates the creation of virtual fragment libraries, mapping of aligned reads (BAM) to these fragments, quality control, and specialized visualization of interactions near the "viewpoint."

## Typical Workflow

### 1. Create a Virtual Fragment Library
Before analysis, you must define the expected fragments based on the restriction enzymes used (primary and secondary cutters).

```R
library(Basic4Cseq)
library(BSgenome.Mmusculus.UCSC.mm9)

# Create library for HindIII (aagctt) and NlaIII (catg)
# useOnlyIndex = TRUE if BAM file uses "1" instead of "chr1"
createVirtualFragmentLibrary(chosenGenome = Mmusculus, 
                             firstCutter = "aagctt", 
                             secondCutter = "catg", 
                             readLength = 54, 
                             libraryName = "vfl_mm9.csv")
```

### 2. Initialize Data4Cseq Object
Load your aligned reads (BAM) and metadata into the central container.

```R
library(GenomicAlignments)

# Load reads and points of interest (BED format)
bamFile <- "path/to/data.bam"
reads <- readGAlignments(bamFile)
poi <- readPointsOfInterestFile("points.bed")

# Initialize object
# viewpointInterval defines the genomic coordinates of the primer/viewpoint
liverData <- Data4Cseq(viewpointChromosome = "10", 
                       viewpointInterval = c(20879870, 20882209),
                       readLength = 54, 
                       pointsOfInterest = poi, 
                       rawReads = reads)

# Map reads to the virtual library
rawFragments(liverData) <- readsToFragments(liverData, "vfl_mm9.csv")
```

### 3. Filtering and Normalization
Focus on the "near-cis" region (the area surrounding the viewpoint) and normalize counts to Reads Per Million (RPM).

```R
# Select a specific window around the viewpoint (e.g., 300kb)
nearCisFragments(liverData) <- chooseNearCisFragments(liverData,
                                regionCoordinates = c(20800000, 21100000))

# Normalize data
nearCisFragments(liverData) <- normalizeFragmentData(liverData)
```

### 4. Quality Control
Check the distribution of reads to ensure the experiment was successful.

```R
# Returns total reads, cis/trans ratio, and coverage near viewpoint
getReadDistribution(liverData, useFragEnds = TRUE)
```

### 5. Visualization
Basic4Cseq provides two primary ways to visualize near-cis data.

```R
# 1. Coverage Plot: Running median/mean smoothing with quantile interpolation
visualizeViewpoint(liverData, 
                   mainColour = "blue", 
                   plotTitle = "Near-Cis Plot", 
                   maxY = 6000)

# 2. Heatmap/Domainogram: Multi-scale contact intensity profile
drawHeatmap(liverData, bands = 5)
```

## Key Functions Reference
- `createVirtualFragmentLibrary`: Generates the expected fragment structure for a genome.
- `readsToFragments`: Assigns aligned reads to specific fragments in the library.
- `normalizeFragmentData`: Performs RPM normalization.
- `visualizeViewpoint`: Creates a smoothed line plot of interaction frequency.
- `drawHeatmap`: Creates a multi-scale contact profile (domainogram).
- `printWigFile`: Exports fragment data for use in UCSC Genome Browser or other tools.
- `giveEnzymeSequence`: Helper to look up restriction site sequences by enzyme name.

## Reference documentation
- [Basic4Cseq Vignette](./references/vignette.md)