---
name: bioconductor-cner
description: The CNEr package provides a pipeline for the large-scale identification, filtering, and visualization of Conserved Noncoding Elements from pairwise genome alignments. Use when user asks to identify conserved noncoding elements, scan axt alignment files for identity thresholds, merge reciprocal alignments, or visualize CNE density plots.
homepage: https://bioconductor.org/packages/release/bioc/html/CNEr.html
---

# bioconductor-cner

## Overview
The `CNEr` package provides a comprehensive pipeline for the large-scale identification and visualization of Conserved Noncoding Elements (CNEs). It operates primarily on `axt` alignment files (typically sourced from UCSC) and uses efficient C extensions to handle genome-wide data. The workflow involves scanning alignments for specific identity thresholds, filtering against genomic annotations (exons/repeats), merging elements from reciprocal alignments, and visualizing results through CNE density plots.

## Core Workflows

### 1. Data Input and Classes
`CNEr` uses specialized S4 classes to manage alignments:
*   `Axt`: Stores pairwise alignments.
*   `GRangePairs`: Holds paired `GRanges` objects of equal length.

```r
library(CNEr)

# Read axt files
axtHg38DanRer10 <- readAxt("path/to/hg38.danRer10.net.axt")

# Visualize alignment distribution
matchDistribution(axtHg38DanRer10)

# Read filtering regions (BED format)
filterRegions <- readBed("filter_regions.bed")
```

### 2. CNE Identification Pipeline
The standard identification process follows these steps:

**Step A: Initialize CNE Object**
```r
cneObj <- CNE(
  assembly1Fn = "path/to/species1.2bit",
  assembly2Fn = "path/to/species2.2bit",
  axt12Fn = "species1_to_species2.axt",
  axt21Fn = "species2_to_species1.axt",
  cutoffs1 = 8L, cutoffs2 = 4L
)
```

**Step B: Scan for Conserved Regions**
Scan using specific identity (I) over window (C) thresholds (e.g., 45/50, 48/50).
```r
identities <- c(45L, 48L)
windows <- c(50L, 50L)

cneList <- ceScan(x = cneObj, tFilter = filter1, qFilter = filter2,
                  window = windows, identity = identities)
```

**Step C: Merge and Filter**
Merge reciprocal alignments to remove redundancy while keeping duplicated elements distinct.
```r
# Merge overlapping elements
cneMerged <- lapply(cneList, cneMerge)

# Optional: Realignment with BLAT to remove unannotated repeats
# Requires blat installed on system
cneFinal <- lapply(cneMerged, blatCNE)
```

### 3. Storage and Querying
Because CNE sets can be large, `CNEr` utilizes SQLite for efficient storage and retrieval.
```r
dbName <- "CNE_storage.sqlite"
saveCNEToSQLite(cneFinal[[1]], dbName, "species1_species2_45_50")

# Query specific genomic regions
fetchedCNEs <- readCNERangesFromSQLite(dbName, "tableName", 
                                       chr="chr6", start=24000000, end=27000000,
                                       whichAssembly="first")
```

### 4. Visualization
CNE density is often visualized as a "Horizon Plot" to show clusters of conservation.
```r
# Calculate density
density <- CNEDensity(dbName = dbName, tableName = "tableName",
                      whichAssembly = "first", chr = "chr6",
                      start = 24000000, end = 27000000,
                      windowSize = 200L)

# Plot using Gviz
library(Gviz)
dTrack <- DataTrack(range = density, type = "horiz", name = "CNE Density")
plotTracks(list(GenomeAxisTrack(), dTrack))
```

## Pairwise Alignment Generation
If pre-computed UCSC alignments are unavailable, `CNEr` provides wrappers for alignment tools (LASTZ/LAST).
*   `lastz()`: Generates `.lav` files.
*   `lavToPsl()`: Converts to `.psl`.
*   `axtChain()`, `chainNetSyntenic()`, `netToAxt()`: Sequential steps to produce the final `.net.axt` files required for CNE detection.

## Tips
*   **Assembly Order**: When creating a `CNE` object, the order of assemblies must match the `axt12Fn` (assembly1 as target) and `axt21Fn` (assembly2 as target) files.
*   **Thresholds**: Common scanning thresholds are 70% to 100% identity over 30bp or 50bp windows.
*   **Whole Genome Duplication**: For species with extra WGD events (like zebrafish), double the `blatCutoff` relative to the other species.

## Reference documentation
- [CNE identification and visualisation](./references/CNEr.md)
- [Pairwise whole genome alignment](./references/PairwiseWholeGenomeAlignment.md)