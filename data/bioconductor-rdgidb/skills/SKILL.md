---
name: bioconductor-rdgidb
description: This tool queries the Drug-Gene Interaction Database (DGIdb) to identify drug-target interactions for specific genes. Use when user asks to search for drugs associated with genes, filter interactions by source or type, and visualize drug-gene interaction summaries.
homepage: https://bioconductor.org/packages/3.5/bioc/html/rDGIdb.html
---


# bioconductor-rdgidb

name: bioconductor-rdgidb
description: Query the Drug-Gene Interaction Database (DGIdb) using the rDGIdb R package. Use this skill to identify drug-target interactions for specific genes, filter results by source databases or interaction types, and visualize drug-gene interaction summaries.

# bioconductor-rdgidb

## Overview
The `rDGIdb` package is an R wrapper for the Drug-Gene Interaction Database (DGIdb). It allows users to query over 15 different resources to identify drugs associated with specific genes or pathways. This is particularly useful for annotating genomic variants with potential therapeutic options or clinical trial information.

## Standard Workflow

### 1. Basic Query
To perform a search, provide a character vector of gene symbols (e.g., HGNC symbols) to the `queryDGIdb` function.

```r
library(rDGIdb)

# Define genes of interest
genes <- c("TNF", "AP1", "AP2")

# Execute query
result <- queryDGIdb(genes)
```

### 2. Accessing Results
The query returns an `rDGIdbResult` S4 object. Use the following helper functions to extract data frames:

*   `resultSummary(result)`: Drug-gene interactions summarized by reporting sources.
*   `detailedResults(result)`: Detailed interaction data for matching genes.
*   `byGene(result)`: Interaction counts and druggable categories per gene.
*   `searchTermSummary(result)`: Summary of how input terms mapped to DGIdb records.

### 3. Filtering Queries
You can refine queries using optional arguments. Use helper functions to see valid filter values:

```r
# View available filters
sourceDatabases()
geneCategories()
interactionTypes()

# Query with specific filters
resultFilter <- queryDGIdb(genes, 
                           sourceDatabases = c("DrugBank", "ChEMBL"),
                           geneCategories = "clinically actionable",
                           interactionTypes = c("inhibitor", "antagonist"))
```

### 4. Visualization
Generate a quick overview of which databases provided the interaction data:

```r
plotInteractionsBySource(result, main = "Drug Interactions by Source")
```

## Advanced Usage: VCF Integration
If starting with a VCF file, use `VariantAnnotation` to map variants to gene symbols before querying `rDGIdb`:

```r
library(VariantAnnotation)
# After identifying gene symbols from VCF (e.g., using locateVariants)
# genes <- unique(symbols$SYMBOL)
# result <- queryDGIdb(genes)
```

## Tips
*   **Gene Symbols**: Ensure gene names are character vectors. If a gene is not found, it will be listed in the `searchTermSummary`.
*   **Resource Versions**: Use `resourceVersions()` to check the currency of the underlying data sources in DGIdb.
*   **Empty Results**: If filters are too restrictive, the result object may contain empty data frames.

## Reference documentation
- [rDGIdb Vignette](./references/vignette.md)