---
name: bioconductor-plogo2
description: Bioconductor-plogo2 performs comparative analysis and visualization of Gene Ontology and KEGG pathway annotations across multiple data subsets. Use when user asks to generate functional annotation summaries, perform enrichment analysis using Fisher's exact test, or integrate protein abundance data with functional categories in R.
homepage: https://bioconductor.org/packages/3.11/bioc/html/PloGO2.html
---


# bioconductor-plogo2

name: bioconductor-plogo2
description: Analysis and visualization of Gene Ontology (GO) and KEGG pathway annotation and abundance for multiple data subsets. Use when you need to generate GO/Pathway summaries, compare subsets to a baseline for enrichment (Fisher's exact test), or integrate protein abundance data with functional annotations in R.

# bioconductor-plogo2

## Overview
PloGO2 is an R package designed for the comparative analysis of Gene Ontology (GO) and KEGG pathway data across multiple experimental conditions or data subsets. It is particularly useful in proteomics for summarizing functional categories and visualizing how protein abundance changes within those categories. It supports generating text/Excel summaries, performing enrichment analysis using Fisher's exact test, and plotting aggregated abundance data.

## Core Workflows

### 1. Gene Ontology (GO) Analysis
The GO workflow typically involves generating annotation files, selecting categories of interest, and plotting results.

```r
library(PloGO2)

# Generate a GO annotation file from Uniprot/Ensembl IDs (requires internet)
v <- c("Q9HWC9", "Q9HWD0", "Q9I4N8")
genWegoFile(v, fname = "F1.txt")

# Define GO categories of interest (by name or ID)
termList <- c("response to stimulus", "transport", "metabolic process")
GOIDmap <- getGoID(termList)
GOIDlist <- names(GOIDmap)

# Process multiple annotation files
file.names <- c("subset1.txt", "subset2.txt", "Control.txt")
res.list <- processAnnotation(file.names, GOIDlist)

# Plot percentages and counts
annot.res <- annotationPlot(res.list)

# Compare subsets to a reference (Enrichment analysis)
enrichment <- compareAnnot(res.list, "Control")
```

### 2. KEGG Pathway Analysis
Pathway analysis requires a pre-downloaded pathway database file (two-column CSV: ID and space-separated pathways).

```r
# Generate annotation files from an Excel input (e.g., WGCNA clusters)
genAnnotationFiles(fExcelName = "Results.xlsx", 
                   colName = "Uniprot", 
                   DB.name = "pathwayDB.csv", 
                   folder = "PWFiles")

# Automated Pathway Analysis
res <- PloPathway(zipFile = "PWFiles.zip", 
                  reference = "AllData", 
                  data.file.name = "Abundance.csv", 
                  datafile.ignore.cols = 1)

# Visualize and Export
plotAbundanceBar(res$aggregatedAbundance, res$Counts)
printSummary(res)
```

### 3. Integrating Abundance Data
You can merge abundance values (e.g., NSAF, LFQ) with annotations to see functional distribution of expression.

```r
# Process annotations with abundance data
res.list <- processAnnotation(file.names, 
                              GOIDlist, 
                              data.file.name = "abundance.csv", 
                              datafile.ignore.cols = 2)

# Generate abundance levelplots
abundancePlot(res.list)
```

## Key Functions
- `genWegoFile`: Creates GO annotation files from protein IDs.
- `processAnnotation`: The main engine for batch processing GO or Pathway files.
- `compareAnnot`: Performs Fisher's exact test against a reference group.
- `annotationPlot`: Generates bar plots of category percentages.
- `abundancePlot`: Generates levelplots showing total abundance per category.
- `PloPathway`: Wrapper for the complete pathway analysis workflow.

## Tips for Success
- **File Formats**: Annotation files should be "long" format: Identifier in column 1, space-separated GO/Pathway IDs in column 2.
- **GO Levels**: Use `GOTermList("BP", level = 2)` to quickly grab all terms at a specific hierarchy level.
- **WGCNA Integration**: PloGO2 is designed to take multi-tab Excel files from WGCNA as input for functional characterization of modules.
- **Enrichment**: The `compareAnnot` function only records p-values for categories with counts > 5 to avoid noise.

## Reference documentation
- [PloGO2: An R package for plotting GO or Pathway annotation and abundance](./references/PloGO2_vignette.md)
- [Integration of PloGO2 and WGCNA for proteomics](./references/PloGO2_with_WGNCA_vignette.md)