---
name: bioconductor-contibait
description: This tool improves draft genome assemblies by clustering, reorienting, and ordering contigs using Strand-seq data. Use when user asks to cluster contigs into chromosomes, reorient fragments, or order fragments within linkage groups.
homepage: https://bioconductor.org/packages/3.6/bioc/html/contiBAIT.html
---


# bioconductor-contibait

name: bioconductor-contibait
description: Improving genome assemblies using Strand-seq data. Use this skill to cluster contigs into chromosomes, order contigs within chromosomes, and determine fragment orientation using the contiBAIT R package.

# bioconductor-contibait

## Overview

The `contiBAIT` package leverages Strand-seq data—which identifies template strand inheritance in single cells—to improve draft genome assemblies. It is particularly useful for assemblies consisting of unplaced contigs or scaffolds. The package provides a workflow to:
1.  **Cluster** contigs into linkage groups (chromosomes).
2.  **Reorient** fragments to a consistent direction.
3.  **Order** fragments within chromosomes based on Sister Chromatid Exchange (SCE) events.
4.  **Visualize** results through ideograms and heatmaps.

## Typical Workflow

### 1. Data Input and Preprocessing

Start by identifying BAM files and creating a chromosome table to define the fragments.

```R
library(contiBAIT)

# 1. List BAM files
bamFileList <- list.files(path="path/to/bams", pattern=".bam$", full.names=TRUE)

# 2. Create a chromosome table (ChrTable)
# Use splitBy to subdivide large scaffolds into bins (e.g., 1Mb) to find chimeric fragments
exampleChrTable <- makeChrTable(bamFileList[1], splitBy=1000000)

# 3. Generate Strand Frequency Matrix
# BAITtables=TRUE returns Watson/Crick read counts for ideograms
strandFrequencyList <- strandSeqFreqTable(bamFileList, 
                                          filter=exampleChrTable, 
                                          pairedEnd=TRUE)

# 4. Quality Control: Plot distributions to check for expected 1:2:1 (WW:WC:CC) ratio
plotWCdistribution(strandFrequencyList[[1]])
```

### 2. Clustering and Reorientation

Convert frequencies to discrete strand states and group contigs that share inheritance patterns.

```R
# 1. Preprocess to Strand State Matrix (1=WW, 2=WC, 3=CC)
strandStateMatrix <- preprocessStrandTable(strandFrequencyList[[1]], lowQualThreshold=0.8)

# 2. Cluster contigs into Linkage Groups
clusteredContigs <- clusterContigs(strandStateMatrix[[1]])

# 3. Reorient fragments and merge discordant groups
# This identifies which fragments are inverted relative to the largest sub-group
reorientedData <- reorientAndMergeLGs(clusteredContigs, strandStateMatrix[[1]])
linkageGroupList <- reorientedData[[3]]

# 4. Visualize clustering quality
plotLGDistances(linkageGroupList, strandStateMatrix[[1]])
```

### 3. Ordering and Validation

Order fragments within each linkage group using a greedy algorithm or TSP.

```R
# 1. Order fragments for a specific Linkage Group (e.g., LG 1)
contigOrder <- orderAllLinkageGroups(linkageGroupList, 
                                     strandStateMatrix[[1]], 
                                     strandFrequencyList[[1]], 
                                     strandFrequencyList[[2]], 
                                     whichLG=1)

# 2. Check order against existing assembly (if available)
plotContigOrder(contigOrder[[1]])

# 3. Visual validation via Ideograms
# Requires Watson/Crick read matrices from strandSeqFreqTable
ideogramPlot(StrandReadMatrix(strandFrequencyList[[3]][,1, drop=FALSE]), 
             StrandReadMatrix(strandFrequencyList[[4]][,1, drop=FALSE]), 
             exampleChrTable,
             orderFrame=contigOrder[[1]])
```

### 4. Exporting Results

Write the final assembly structure to a BED file for use with downstream tools like `bedtools`.

```R
writeBed(exampleChrTable, reorientedData[[2]], contigOrder[[1]], fileName="improved_assembly.bed")
```

## Key Functions and Tips

- **`makeChrTable`**: Essential for defining the "contigs" the package will manipulate. If your assembly is already at the chromosome level but you suspect misorientations, use `splitBy` to create smaller bins.
- **`strandSeqFreqTable`**: The most time-consuming step. Ensure `pairedEnd` is set correctly for your library type.
- **`clusterBy`**: In `clusterContigs`, the default is to cluster by both homozygous and heterozygous states. Use `clusterBy='homo'` if you only want to use WW/CC calls.
- **Chimeric Fragments**: If a contig shows recurrent strand state changes in the middle, it may be chimeric. Use `mapGapFromOverlap` to identify and split these fragments at gap regions.

## Reference documentation

- [contiBAIT](./references/contiBAIT.md)