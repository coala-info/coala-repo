---
name: bioconductor-multimir
description: This tool retrieves miRNA-target interactions and associations with diseases and drugs from multiple databases using the multiMiR R package. Use when user asks to query validated or predicted miRNA targets, search for miRNA-drug or miRNA-disease associations, or aggregate data from multiple miRNA resources for human, mouse, or rat.
homepage: https://bioconductor.org/packages/release/bioc/html/multiMiR.html
---


# bioconductor-multimir

name: bioconductor-multimir
description: Comprehensive retrieval of miRNA-target interactions and associations with diseases and drugs using the multiMiR R package. Use this skill when you need to query multiple miRNA databases (predicted and validated) for human, mouse, or rat, or when analyzing miRNA-drug/disease associations.

## Overview

The `multiMiR` package is a comprehensive collection of miRNA-target interactions and their associations with diseases and drugs. It aggregates data from 14 external databases, including predicted targets (e.g., TargetScan, miRanda), validated targets (e.g., miRTarBase, TarBase), and disease/drug associations (e.g., miR2Disease, PhenomiR). It provides a unified interface to query these resources without visiting individual websites.

## Core Workflow

### 1. Database Information and Versioning
The `multiMiR` database is versioned. By default, the most recent version is used.

```r
library(multiMiR)

# Check available versions
versions <- multimir_dbInfoVersions()

# Switch to a specific version if necessary
multimir_switchDBVersion(db_version = "2.3.0")

# List available tables and database counts
tables <- multimir_dbTables()
counts <- multimir_dbCount()
```

### 2. Querying Interactions with `get_multimir()`
`get_multimir()` is the primary function for retrieving data.

**Key Arguments:**
- `org`: Organism ('hsa' for human, 'mmu' for mouse, 'rno' for rat).
- `mirna`: A vector of miRNA IDs (e.g., 'hsa-miR-18a-3p').
- `target`: A vector of target gene symbols or Entrez IDs.
- `table`: Which category to search ('validated', 'predicted', 'disease.drug', or 'all').
- `summary`: Logical; if TRUE, provides a summary of how many databases support each interaction.
- `predicted.cutoff`: Integer or percentage to filter predicted results.
- `predicted.cutoff.type`: 'p' for percentage (default) or 'n' for a specific number of records.

**Example: Retrieve Validated Targets**
```r
# Get validated targets for a specific miRNA
results <- get_multimir(org = "hsa", 
                        mirna = "hsa-miR-18a-3p", 
                        table = "validated", 
                        summary = TRUE)

# Access the data (S4 object)
head(results@data)
head(results@summary)
```

**Example: Retrieve Predicted Targets with Cutoffs**
```r
# Get top 10% predicted targets for a gene
pred_results <- get_multimir(org = "mmu", 
                             target = "Gnb1", 
                             table = "predicted", 
                             predicted.cutoff = 10, 
                             predicted.cutoff.type = "p")
```

### 3. Drug and Disease Queries
You can search for miRNAs and targets associated with specific drugs or diseases.

```r
# Search for interactions associated with Cisplatin
drug_results <- get_multimir(disease.drug = "cisplatin", 
                             table = "disease.drug")
```

### 4. Working with Results (AnnotationDbi Methods)
The return object is an S4 class (`mmquery_bioc`) that supports standard `AnnotationDbi` methods for filtering.

```r
# List available columns
columns(results)

# Filter results using select
validated_only <- select(results, 
                         keytype = "type", 
                         keys = "validated", 
                         columns = c("mature_mirna_id", "target_symbol", "pubmed_id"))
```

### 5. Listing Unique Terms
To explore what is available in the database:

```r
# List first 10 drugs or diseases
drugs <- list_multimir("drug", limit = 10)
diseases <- list_multimir("disease", limit = 10)
```

## Tips and Best Practices
- **ID Formats**: The package handles miRNA IDs (mature or accession) and gene IDs (Symbol, Entrez, or Ensembl).
- **Legacy Output**: If you prefer the old S3 object format, use `legacy.out = TRUE` in `get_multimir()`.
- **Filtering**: Use `subset(results@data, type == "validated")` for quick base R filtering of the combined data table.
- **Performance**: Querying large lists of genes or "all" tables can take time depending on your internet connection, as the package communicates with the multiMiR web server.

## Reference documentation
- [The multiMiR user's guide](./references/multiMiR.Rmd)
- [The multiMiR user's guide (Markdown)](./references/multiMiR.md)