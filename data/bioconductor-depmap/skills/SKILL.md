---
name: bioconductor-depmap
description: The bioconductor-depmap package provides a framework for accessing and analyzing cancer dependency data from the Broad Institute in a tidy format. Use when user asks to access CRISPR, RNAi, or drug sensitivity datasets, retrieve cancer cell line metadata, or integrate genomic data for dependency analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/depmap.html
---

# bioconductor-depmap

## Overview

The `depmap` package provides a reproducible framework for accessing cancer dependency data. It transforms large-scale genomic datasets (CRISPR, RNAi, Proteomics, etc.) into a "long" tidy format, making them immediately compatible with `dplyr` and `ggplot2`. Data is retrieved via `ExperimentHub`, ensuring versioned and efficient access to the Broad Institute's DepMap releases.

## Core Workflows

### 1. Loading Data

The package provides wrapper functions to load the most recent version of specific datasets.

```r
library(depmap)
library(dplyr)

# Load common datasets
metadata <- depmap_metadata()      # Cell line info (lineage, disease, etc.)
mutation <- depmap_mutationCalls() # Mutation data
crispr   <- depmap_crispr()        # CRISPR (CERES) gene effect
rnai     <- depmap_rnai()          # RNAi dependency scores
tpm      <- depmap_TPM()           # RNAseq expression (log2(TPM+1))
cn       <- depmap_copyNumber()    # WES copy number
drugs    <- depmap_drug_sensitivity() # Drug sensitivity scores
proteic  <- depmap_proteomic()     # Mass spec proteomics
```

### 2. Accessing Specific Versions

To access older releases (e.g., 19Q1 vs 22Q2), use `ExperimentHub` queries.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "depmap")

# Retrieve by EH ID
rnai_19Q1 <- eh[["EH2260"]]
```

### 3. Data Integration and Analysis

A typical workflow involves joining dependency data with metadata to filter by cancer type (lineage).

```r
# Find top dependencies in Soft Tissue Sarcoma
top_dep <- rnai %>%
  select(depmap_id, gene_name, dependency) %>%
  left_join(select(metadata, depmap_id, cell_line, primary_disease), by = "depmap_id") %>%
  filter(primary_disease == "Sarcoma") %>%
  arrange(dependency)

# Correlation between Expression and Dependency
target_gene <- "RPL14"
analysis_df <- tpm %>%
  filter(gene_name == target_gene) %>%
  select(depmap_id, expression) %>%
  inner_join(filter(crispr, gene_name == target_gene), by = "depmap_id")

# Plotting
library(ggplot2)
ggplot(analysis_df, aes(x = expression, y = dependency)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = paste("Expression vs CRISPR Dependency for", target_gene))
```

### 4. Accessing Original Figshare Files

If you need the raw files provided by the DepMap project (not the tidied versions), use the `dmsets` and `dmget` functions.

```r
# List available datasets on Figshare
datasets <- dmsets()

# Find specific files within a dataset (e.g., 22Q2)
files <- dmfiles() %>% filter(dataset_id == 19700056)

# Download and load a specific CSV
file_path <- dmfiles() %>% 
  filter(name == "CRISPRGeneEffect.csv") %>% 
  dmget()

raw_data <- readr::read_csv(file_path)
```

## Tips and Best Practices

- **Dependency Scores**: A highly negative score (typically < -1) indicates that the cell line is highly dependent on that gene for survival.
- **Memory Management**: These datasets are very large (millions of rows). Use `dplyr::filter` and `dplyr::select` early in your pipeline to reduce memory overhead.
- **Caching**: `ExperimentHub` and `dmget()` cache files locally. Use `dmCache()` to manage the local data directory.
- **Gene Identifiers**: Most datasets include `gene_name` (Symbol) and `entrez_id`. Use `entrez_id` for the most reliable joining across different data types.

## Reference documentation

- [The depmap data](./references/depmap.md)
- [Using the depmap data](./references/using_depmap.md)