---
name: bioconductor-ogre
description: OGRE calculates and visualizes overlaps between genomic region datasets within the R environment. Use when user asks to calculate genomic overlaps, generate overlap statistics, or visualize genomic regions and coverage profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/OGRE.html
---

# bioconductor-ogre

name: bioconductor-ogre
description: Comprehensive analysis and visualization of overlaps between genomic region datasets. Use when needing to calculate overlaps between user-defined annotations (e.g., genes, SNPs, TFBS, CpG islands) in R, generate summary statistics, or visualize genomic overlaps using Gviz and coverage profiles.

# bioconductor-ogre

## Overview
OGRE (Overlap Analysis of Genomic Regions) is an R package designed to calculate and visualize overlaps between different sets of genomic annotations. It treats datasets as "queries" (the primary regions of interest) and "subjects" (the regions to check for overlaps against). It provides a structured `OGREDataSet` object to manage these relationships and includes built-in tools for statistical summaries, histograms, and genomic track visualizations.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("OGRE")
library(OGRE)
```

## Core Workflow

### 1. Initialize the OGREDataSet
You can initialize the dataset from local directories, AnnotationHub, or existing GRanges objects.

**From Local Directory:**
Store query and subject files (.rds or .gff) in separate folders.
```r
myOGRE <- OGREDataSetFromDir(queryFolder = "path/to/query", 
                             subjectFolder = "path/to/subject")
```

**From AnnotationHub:**
```r
myOGRE <- OGREDataSet() 
# View available datasets: listPredefinedDataSets()
myOGRE <- addDataSetFromHub(myOGRE, "protCodingGenes", "query")
myOGRE <- addDataSetFromHub(myOGRE, "CGI", "subject")
```

**From GRanges Objects:**
```r
myOGRE <- OGREDataSet()
myOGRE <- addGRanges(myOGRE, myGRangesObject, "query")
```

### 2. Load and Inspect Annotations
```r
myOGRE <- loadAnnotations(myOGRE)
names(myOGRE) # Check dataset labels
myOGRE        # View as GRangesList
```

### 3. Calculate Overlaps
The `fOverlaps` function calculates both partial and complete overlaps.
```r
myOGRE <- fOverlaps(myOGRE)
# Access detailed overlap table
head(metadata(myOGRE)$detailDT)
```

### 4. Visualization and Statistics

**Summary Barplot:**
```r
myOGRE <- sumPlot(myOGRE)
metadata(myOGRE)$barplot_summary
```

**Genomic Track Plot (Gviz):**
Visualize a specific query region and its overlapping subjects.
```r
myOGRE <- gvizPlot(myOGRE, queryID = "ENSG00000142168", showPlot = TRUE)
```

**Overlap Distribution & Histograms:**
```r
myOGRE <- summarizeOverlap(myOGRE) 
myOGRE <- plotHist(myOGRE)
metadata(myOGRE)$summaryDT # View stats (Min, Mean, Median, etc.)
metadata(myOGRE)$hist$SubjectName # View specific histogram
```

**Coverage Profiles:**
Create an average coverage profile (e.g., TFBS enrichment across gene bodies).
```r
myOGRE <- covPlot(myOGRE) 
metadata(myOGRE)$covPlot$SubjectName$plot
```

## Data Requirements
To ensure compatibility when adding custom `GenomicRanges`:
- **Genome Build:** All datasets must use the same build (e.g., "hg19").
- **Chromosomes:** Chromosome naming must be consistent (e.g., "chr1" vs "1").
- **Metadata:** GRanges objects must contain "name" and "ID" columns in `mcols()`.

## Tips
- **GUI:** Use `SHREC()` to launch the OGRE graphical user interface.
- **Renaming:** Change dataset labels using `names(myOGRE) <- c("QueryName", "Subj1", "Subj2")`.
- **Tabular Data:** For .csv or .bed files, read them into R first, then use `GenomicRanges::makeGRangesFromDataFrame()` before adding to OGRE.

## Reference documentation
- [The OGRE user guide](./references/OGRE.Rmd)
- [The OGRE user guide](./references/OGRE.md)