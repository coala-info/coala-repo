---
name: bioconductor-chipxpress
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChIPXpress.html
---

# bioconductor-chipxpress

name: bioconductor-chipxpress
description: Identify functional transcription factor (TF) target genes by integrating ChIP-seq/ChIP-chip data with publicly available gene expression databases. Use this skill when you need to rank TF-bound genes from ChIPx experiments to prioritize those most likely to be transcriptionally responsive, especially when specific perturbation expression data is unavailable.

## Overview

ChIPXpress enhances the identification of functional target genes by integrating ChIPx (ChIP-seq or ChIP-chip) binding data with large-scale public gene expression datasets (20,000+ samples for human and mouse). It addresses the common problem where ChIPx experiments identify thousands of binding sites, but only a small fraction are functional targets. By calculating the correlation between the TF and its bound genes across diverse conditions, ChIPXpress re-ranks the genes to prioritize true functional targets.

## Core Workflow

### 1. Prepare Input Data
ChIPXpress requires three main inputs:
- **TFID**: The Entrez GeneID of the Transcription Factor of interest.
- **ChIP**: A character vector of Entrez GeneIDs for genes predicted to be bound by the TF, ranked from most to least likely (typically based on peak height/significance).
- **DB**: A gene expression database in `big.matrix` format.

### 2. Load Pre-built Databases
Pre-built databases for Human (GPL570) and Mouse (GPL1261) are available in the `ChIPXpressData` package. Because they use the `bigmemory` framework, they must be attached rather than loaded via standard `data()` calls.

```r
library(ChIPXpress)
library(ChIPXpressData)
library(bigmemory)

# Locate and attach the mouse database (GPL1261)
path <- system.file("extdata", package="ChIPXpressData")
DB_GPL1261 <- attach.big.matrix("DB_GPL1261.bigmemory.desc", path=path)

# For human (GPL570), use "DB_GPL570.bigmemory.desc"
```

### 3. Run ChIPXpress Ranking
Execute the ranking algorithm to produce a prioritized list of functional targets.

```r
# Example using Oct4 (Entrez ID 18999) in mouse
# chip_genes_vector should be a character vector of Entrez IDs
results <- ChIPXpress(TFID="18999", 
                      ChIP=chip_genes_vector, 
                      DB=DB_GPL1261)

# results[[1]] contains the ranked ChIPXpress scores (lower is better)
# results[[2]] contains genes not found in the expression database
head(results[[1]])
```

### 4. Building Custom Databases
If working with a different species or platform, you can build a custom database from NCBI GEO.

1. **Download and Process**: Use `buildDatabase` to fetch GSM/GPL data and process via `frma`.
2. **Annotate**: Convert probe IDs to Entrez GeneIDs (or your preferred ID format).
3. **Clean**: Use `cleanDatabase` to resolve many-to-one probe-to-gene mappings and normalize.

```r
# 1. Build from GEO
library(mouse4302frmavecs) # Required for GPL1261/mouse4302
DB <- buildDatabase(GPL_id='GPL1261', SaveDir=getwd())

# 2. Annotate (User must perform this step)
library(mouse4302.db)
entrez_ids <- mget(as.character(rownames(DB)), mouse4302ENTREZID)
rownames(DB) <- as.character(entrez_ids)

# 3. Clean and Normalize
cleanDB <- cleanDatabase(DB, 
                         SaveFile="custom_DB.bigmemory", 
                         SavePath=getwd())
```

## Tips for Success
- **ID Consistency**: Ensure the `TFID`, the `ChIP` vector, and the `rownames` of the `DB` all use the same identifier format (Entrez GeneID is highly recommended).
- **Peak Ranking**: For the initial `ChIP` input, rank genes by the highest peak score (e.g., FDR or fold enrichment) associated with that gene.
- **Memory Management**: The databases are large. Always use `attach.big.matrix` to point to the `.desc` file rather than trying to load the raw data into standard R memory.
- **Annotation**: Use packages like `biomaRt` or organism-specific `.db` packages to convert the final ranked Entrez IDs back to Gene Symbols for interpretation.

## Reference documentation
- [ChIPXpress](./references/ChIPXpress.md)