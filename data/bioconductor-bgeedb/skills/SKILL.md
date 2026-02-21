---
name: bioconductor-bgeedb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BgeeDB.html
---

# bioconductor-bgeedb

## Overview
BgeeDB is an R package that provides an interface to the Bgee database, offering curated, healthy, wild-type expression data. It allows users to retrieve processed quantitative expression data (TPM, FPKM, counts) and perform "TopAnat" analyses—an anatomical entity enrichment test similar to Gene Ontology enrichment but based on where genes are expressed in the body.

## Core Workflow

### 1. Initialize Bgee Object
All operations start by creating a Bgee object for a specific species.
```r
library(BgeeDB)

# List available species and data types
listBgeeSpecies()

# Create object (e.g., Mouse RNA-seq)
# Data types: "rna_seq", "affymetrix", "sc_full_length", "sc_droplet_based"
bgee <- Bgee$new(species = "Mus_musculus", dataType = "rna_seq")
```

### 2. Retrieve Processed Expression Data
You can fetch metadata (annotations) and the actual expression values.
```r
# Get experiment and sample metadata
annotation <- getAnnotation(bgee)

# Download processed data (can filter by experimentId, anatEntityId, stageId, etc.)
data_bgee <- getSampleProcessedData(bgee, experimentId = "GSE30617")

# Format into an ExpressionSet for downstream R analysis
# stats can be "tpm", "fpkm", or "counts"
eset <- formatData(bgee, data_bgee, callType = "present", stats = "tpm")
```

### 3. TopAnat Enrichment Analysis
TopAnat identifies anatomical structures where a list of genes is significantly over-expressed.

**Step A: Load Reference Data**
```r
# Loads mapping of genes to anatomical structures
myTopAnatData <- loadTopAnatData(bgee)
```

**Step B: Prepare Gene List**
Create a named factor vector where names are Ensembl IDs and values are 1 (foreground) or 0 (background).
```r
# Example: myGenes is your vector of interest, universe is your background
geneList <- factor(as.integer(unique(universe) %in% myGenes))
names(geneList) <- unique(universe)

# Create topGO object
myTopAnatObject <- topAnat(myTopAnatData, geneList)
```

**Step C: Run Test and Format Results**
```r
# Run the enrichment test (uses topGO engine)
results <- runTest(myTopAnatObject, algorithm = 'weight', statistic = 'fisher')

# Create a results table with FDR correction
tableOver <- makeTable(myTopAnatData, myTopAnatObject, results, cutoff = 0.01)
```

## Key Functions and Tips
- `listBgeeRelease()`: Check available database versions.
- `getSampleProcessedData()`: The primary function for bulk data. For single-cell UMI counts at cell level, use `getCellProcessedData()`.
- **Caching**: BgeeDB saves downloaded data in a local SQLite database in your working directory. Use `deleteLocalData(bgee)` to clear space if needed.
- **Anatomical IDs**: Use UBERON ontology IDs (e.g., `UBERON:0000955` for heart) for precise filtering in `getSampleProcessedData()`.
- **Confidence Levels**: In `loadTopAnatData()`, use `confidence = "gold"` for highest stringency or `"silver"` for broader coverage.

## Reference documentation
- [BgeeDB Manual (Rmd)](./references/BgeeDB_Manual.Rmd)
- [BgeeDB Manual (md)](./references/BgeeDB_Manual.md)