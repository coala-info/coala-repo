---
name: bioconductor-ctrap
description: "bioconductor-ctrap compares differential gene expression results against Connectivity Map perturbations and drug sensitivity data to identify mimicking or reversing compounds. Use when user asks to compare transcriptomic profiles with CMap perturbations, predict targeting drugs based on expression-drug sensitivity associations, or perform drug set enrichment analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/cTRAP.html
---


# bioconductor-ctrap

## Overview
The `cTRAP` package allows users to compare their own differential gene expression results (e.g., from RNA-seq experiments) against a large library of known cellular perturbations from the Connectivity Map (CMap). This helps identify which gene knockdowns or drugs mimic or reverse an observed transcriptomic state. It also supports predicting targeting drugs by correlating expression profiles with drug sensitivity data (NCI60, GDSC, CTRP) and performing Drug Set Enrichment Analysis (DSEA).

## Typical Workflow

### 1. Prepare Input Data
The package requires a named numeric vector of differential expression statistics (e.g., t-statistics or log2 fold changes), where names are Gene Symbols.

```r
library(cTRAP)

# Example: Using ENCODE data
metadata <- downloadENCODEknockdownMetadata("HepG2", "EIF4G1")
samples <- loadENCODEsamples(metadata)[[1]]
counts <- prepareENCODEgeneExpression(samples)

# Convert IDs and perform DE analysis
counts$gene_id <- convertGeneIdentifiers(counts$gene_id)
diffExpr <- performDifferentialExpression(counts)

# Create the named vector for cTRAP
diffExprStat <- diffExpr$t
names(diffExprStat) <- diffExpr$Gene_symbol
```

### 2. Load CMap Perturbations
CMap data is large and usually downloaded automatically upon first use. You can filter by cell line or perturbation type.

```r
# Load metadata
cmapMetadata <- loadCMapData("cmapMetadata.txt", type="metadata")

# Filter for specific conditions (e.g., shRNA knockdown in HepG2)
cmapMetadataKD <- filterCMapMetadata(
    cmapMetadata, cellLine="HepG2",
    perturbationType="Consensus signature from shRNAs targeting the same gene")

# Load the actual z-scores (requires cmapZscores.gctx)
cmapPerturbationsKD <- prepareCMapPerturbations(
    metadata=cmapMetadataKD, 
    zscores="cmapZscores.gctx",
    geneInfo="cmapGeneInfo.txt")
```

### 3. Rank Similar Perturbations
Compare your DE profile against CMap using Spearman, Pearson, or GSEA methods.

```r
# Compare against knockdowns
compareKD <- rankSimilarPerturbations(diffExprStat, cmapPerturbationsKD)

# View top hits (positively associated)
head(compareKD[order(rankProduct_rank)])

# Plot results
plot(compareKD, "spearman", n=c(10, 3)) # Top 10 positive, 3 negative
```

### 4. Predict Targeting Drugs
Identify compounds likely to target the observed phenotype by comparing DE profiles with drug sensitivity associations.

```r
# List and load associations (e.g., CTRP 2.1)
assocName <- listExpressionDrugSensitivityAssociation()[[2]]
assoc <- loadExpressionDrugSensitivityAssociation(assocName)

# Predict drugs
predicted <- predictTargetingDrugs(diffExprStat, assoc)

# Plot targeting potential
plot(predicted, method="rankProduct")
```

### 5. Molecular Descriptor Enrichment (DSEA)
Analyze if the predicted targeting drugs share specific chemical properties.

```r
# Load descriptors (e.g., CMap 2D)
descriptors <- loadDrugDescriptors("CMap", "2D")
drugSets <- prepareDrugSets(descriptors)

# Perform enrichment
dsea <- analyseDrugSetEnrichment(drugSets, predicted)

# Plot top enriched descriptors
plotDrugSetEnrichment(drugSets, predicted, selectedSets=head(dsea$descriptor, 6))
```

## Key Functions and Tips
- `convertGeneIdentifiers()`: Essential for ensuring input gene names match CMap/Bioconductor standards.
- `rankSimilarPerturbations()`: The core comparison engine. Using multiple methods (Spearman, Pearson, GSEA) allows the calculation of a `rankProduct_rank` for more robust results.
- `filterCMapMetadata()`: Use this to reduce memory usage by only loading relevant slices of the massive CMap GCTX files.
- **Memory Management**: CMap GCTX files are ~20GB. Ensure sufficient disk space and use the filtering options in `prepareCMapPerturbations` to avoid loading the entire dataset into RAM.

## Reference documentation
- [cTRAP](./references/cTRAP.md)