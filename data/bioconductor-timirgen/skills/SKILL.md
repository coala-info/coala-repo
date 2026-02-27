---
name: bioconductor-timirgen
description: TimiRGeN analyzes longitudinal miRNA and mRNA expression data to identify temporal patterns and gene regulatory networks. Use when user asks to integrate multi-omic time-course data, perform functional pathway enrichment, identify miRNA-mRNA interactions, or generate gene regulatory networks.
homepage: https://bioconductor.org/packages/3.12/bioc/html/TimiRGeN.html
---


# bioconductor-timirgen

name: bioconductor-timirgen
description: Analysis of time-series microRNA (miRNA) and mRNA expression data. Use this skill to integrate multi-omic time-course data, perform functional pathway enrichment using WikiPathways, identify miRNA-mRNA interactions via correlation and database mining (TargetScan, miRDB, miRTarBase), and generate gene regulatory networks.

# bioconductor-timirgen

## Overview

TimiRGeN (Time Incorporated miR-mRNA Generation of Networks) is a Bioconductor package designed for the integrated analysis of longitudinal miRNA and mRNA expression data. It facilitates data reduction while preserving biological signals by identifying temporal patterns, enriched pathways, and validated miRNA-mRNA interactions. The workflow typically starts with differential expression (DE) results and ends with network visualizations or export files for Cytoscape and PathVisio.

## Core Workflow

### 1. Data Preparation and Object Initialization
TimiRGeN uses the `MultiAssayExperiment` (MAE) container. Input dataframes should have column names following the convention `Timepoint.ResultType` (e.g., `D1.log2fc`, `D1.adjPVal`).

```r
library(TimiRGeN)
library(org.Mm.eg.db) # Use appropriate org.db for species

# Initialize MAE
MAE <- startObject(miR_data, mRNA_data)

# Retrieve Gene IDs (Entrez and Ensembl)
MAE <- getIdsMir(MAE, assay(MAE, 1), orgDB = org.Mm.eg.db, miRPrefix = 'mmu')
MAE <- getIdsMrna(MAE, assay(MAE, 2), mirror = 'useast', species = 'mmusculus', orgDB = org.Mm.eg.db)
```

### 2. Filtering and Enrichment
Filter for significant genes across time points and perform overrepresentation analysis (ORA) using WikiPathways.

```r
# Combine and filter
MAE <- combineGenes(MAE, miR_data = assay(MAE, 1), mRNA_data = assay(MAE, 2))
MAE <- genesList(MAE, method = 'c', genetic_data = assay(MAE, 9), timeString = "D")
MAE <- significantVals(MAE, method = 'c', geneList = metadata(MAE)[[1]], maxVal = 0.05, stringVal = "adjPVal")

# Pathway Enrichment
MAE2 <- MultiAssayExperiment()
MAE2 <- dloadGmt(MAE2, species = "Mus musculus")
MAE2 <- enrichWiki(MAE2, method = 'c', ID_list = metadata(MAE)[[4]], 
                   orgDB = org.Mm.eg.db, path_gene = assay(MAE2, 1), 
                   path_name = assay(MAE2, 2), ID = "ENTREZID")
```

### 3. Temporal Clustering
Use soft clustering (Mfuzz) to identify global temporal patterns in pathways.

```r
MAE2 <- wikiList(MAE2, stringSpecies = 'Mus musculus', stringSymbol = 'L')
MAE2 <- wikiMatrix(MAE2, ID_list = metadata(MAE)[[4]], wp_list = metadata(MAE2)[[2]])
MAE2 <- turnPercent(MAE2, wikiMatrix = assay(MAE2, 4))
MAE2 <- createClusters(MAE2, method = "c", percentMatrix = assay(MAE2, 5), noClusters = 4)
```

### 4. miRNA-mRNA Interaction Mining
Identify potential interactions by correlating miRNA and mRNA expression and validating against curated databases.

```r
# Create correlation matrix for a pathway of interest
MAE3 <- mirMrnaInt(MAE = MultiAssayExperiment(), miR_express = miR_log2fc, 
                   GenesofInterest = target_mRNAs, maxInt = 5)

# Download and mine databases
MAE3 <- dloadTargetscan(MAE3, species = "mmu")
MAE3 <- dloadMirdb(MAE3, species = "mmu", orgDB = org.Mm.eg.db)
MAE3 <- dloadMirtarbase(MAE3, species = "mmu")

MAE3 <- dataMiningMatrix(MAE3, corrTable = assay(MAE3, 1), 
                         targetscan = assay(MAE3, 2), 
                         mirdb = assay(MAE3, 3), 
                         mirtarbase = assay(MAE3, 4))

# Filter by evidence and correlation
MAE3 <- matrixFilter(MAE3, miningMatrix = assay(MAE3, 5), negativeOnly = TRUE, threshold = 2, maxCor = -0.5)
```

### 5. Visualization and Export
Generate internal R networks or export for external tools.

```r
# Internal Network
MAE3 <- makeNet(MAE3, filt_df = assay(MAE3, 6))
quickNet(metadata(MAE3)[[1]])

# Export to Cytoscape (requires Cytoscape to be running)
cytoMake(assay(MAE3, 6), titleString = 'My_Pathway')

# Export to PathVisio
MAE3 <- makeMapp(MAE3, filt_df = assay(MAE3, 6), miR_IDs_adj = miR_IDs, dataType = 'L')
```

## Key Functions and Parameters

- `method`: Use `'c'` for combined analysis (miRNA and mRNA together) or `'s'` for separated analysis.
- `timeString`: The prefix used in column names to denote time (e.g., "D" for Days, "H" for Hours).
- `matrixFilter`: Crucial for reducing false positives. `threshold` sets the number of databases that must agree on an interaction.
- `quickCrossCorr` / `quickReg`: Used for detailed pair-wise analysis of specific miRNA-mRNA interactions (best for 5+ time points).

## Tips for Success

1. **Naming Conventions**: Ensure column names have exactly one `.` and no `_`. miRNA names should use `-` (e.g., `hsa-miR-21-5p`).
2. **MAE Management**: The package relies heavily on the `MultiAssayExperiment` structure. Use `assay(MAE, i)` or `metadata(MAE)[[i]]` to access specific data stages.
3. **Species Support**: Supports vertebrate models (Human, Mouse, Rat, Zebrafish). Ensure the correct `org.db` and `miRPrefix` are used.
4. **Missing Data**: Input dataframes should not contain `NA` values in the expression/result columns.

## Reference documentation
- [TimiRGeN Tutorial (Rmd)](./references/TimiRGeN_tutorial.Rmd)
- [TimiRGeN Tutorial (Markdown)](./references/TimiRGeN_tutorial.md)