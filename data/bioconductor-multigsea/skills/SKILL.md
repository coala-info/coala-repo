---
name: bioconductor-multigsea
description: The multiGSEA package performs integrated pathway enrichment analysis across multiple omics layers by aggregating independent enrichment scores. Use when user asks to calculate multi-omics enrichment, aggregate p-values from different omics layers, or identify pathways altered across transcriptome, proteome, and metabolome data.
homepage: https://bioconductor.org/packages/release/bioc/html/multiGSEA.html
---


# bioconductor-multigsea

## Overview

The `multiGSEA` package enables robust GSEA-based pathway enrichment for multiple omics layers. It calculates enrichment for each layer (transcriptome, proteome, metabolome) independently and then aggregates the resulting p-values to identify pathways significantly altered across the entire multi-omics system. It supports 11 model organisms and integrates with `graphite` for pathway definitions and `AnnotationDbi` for feature mapping.

## Core Workflow

### 1. Data Preparation
Input data for each layer must be a data frame containing feature IDs, log2 fold changes (`logFC`), and p-values (`pValue`).

```r
library(multiGSEA)
library(org.Hs.eg.db) # Use appropriate org.db for your organism

# Initialize the nested list structure
omics_data <- initOmicsDataStructure(layer = c("transcriptome", "proteome", "metabolome"))

# Rank features using the local statistic: sign(logFC) * -log10(pValue)
omics_data$transcriptome <- rankFeatures(df_trans$logFC, df_trans$pValue)
names(omics_data$transcriptome) <- df_trans$Symbol

omics_data$proteome <- rankFeatures(df_prot$logFC, df_prot$pValue)
names(omics_data$proteome) <- df_prot$Symbol

# Note: Metabolite IDs often need prefixing (e.g., HMDB to HMDB00)
omics_data$metabolome <- rankFeatures(df_metab$logFC, df_metab$pValue)
names(omics_data$metabolome) <- gsub("HMDB", "HMDB00", df_metab$HMDB)
```

### 2. Pathway Retrieval and Mapping
Use `getMultiOmicsFeatures` to download pathway definitions and map them to the IDs used in your ranked lists.

```r
databases <- c("kegg", "reactome")
pathways <- getMultiOmicsFeatures(
  dbs = databases, 
  layer = names(omics_data),
  returnTranscriptome = "SYMBOL",
  returnProteome = "SYMBOL",
  returnMetabolome = "HMDB",
  useLocal = FALSE
)
```

### 3. Enrichment and Aggregation
Calculate enrichment scores for each layer and combine the results.

```r
# Run GSEA for all layers
enrichment_scores <- multiGSEA(pathways, omics_data)

# Extract p-values into a data frame
df_res <- extractPvalues(
  enrichmentScores = enrichment_scores,
  pathwayNames = names(pathways[[1]])
)

# Aggregate p-values (default: Stouffer's Z-method)
# Options for method: "stouffer" (default), "fisher", or "edgington"
df_res$combined_pval <- combinePvalues(df_res)
df_res$combined_padj <- p.adjust(df_res$combined_pval, method = "BH")

# Add pathway names and sort
df_res <- cbind(data.frame(pathway = names(pathways[[1]])), df_res)
df_res <- df_res[order(df_res$combined_padj), ]
```

## Key Functions

- `initOmicsDataStructure()`: Creates the required nested list format.
- `rankFeatures()`: Calculates the ranking metric for GSEA.
- `getMultiOmicsFeatures()`: Downloads and maps pathway features from `graphite`.
- `multiGSEA()`: Wrapper to run `fgsea` on all omics layers.
- `extractPvalues()`: Formats results for p-value combination.
- `combinePvalues()`: Aggregates p-values using various statistical methods.

## Tips and Best Practices

- **Organism Support**: Use `getOrganisms()` to see supported species abbreviations (e.g., "hsapiens", "mmusculus").
- **ID Consistency**: Ensure the `returnXXX` arguments in `getMultiOmicsFeatures` match the names assigned to your `omics_data` lists.
- **Metabolome IDs**: Metabolite mapping is sensitive. Ensure HMDB IDs follow the 11-character format (e.g., "HMDB0000001").
- **Custom Gene Sets**: You can provide custom lists to the `pathways` object. Ensure the list structure and names match across all layers.
- **P-value Combination**: Since Bioconductor 3.18, `multiGSEA` combines raw p-values rather than adjusted p-values to satisfy statistical assumptions of the Fisher and Stouffer methods.

## Reference documentation

- [multiGSEA](./references/multiGSEA.md)