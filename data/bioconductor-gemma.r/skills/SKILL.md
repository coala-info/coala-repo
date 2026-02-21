---
name: bioconductor-gemma.r
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gemma.R.html
---

# bioconductor-gemma.r

name: bioconductor-gemma.r
description: Access and analyze curated gene expression data from the Gemma database using the gemma.R Bioconductor package. Use this skill to search for genomics datasets, download expression matrices (SummarizedExperiment/ExpressionSet), retrieve platform annotations, and access precomputed differential expression results for meta-analysis.

# bioconductor-gemma.r

## Overview

The `gemma.R` package provides an R interface to [Gemma](https://gemma.msl.ubc.ca/), a curated database of thousands of public genomics studies. Every dataset in Gemma is re-annotated at the sequence level, ensuring consistent cross-platform comparisons. This skill guides you through searching for datasets, downloading processed data, and performing meta-analyses using Gemma's precomputed differential expression results.

## Core Workflows

### 1. Searching for Datasets
Use `get_datasets` to find experiments by taxa, keywords, or ontology URIs.

```r
library(gemma.R)

# Search by keyword and taxa
ds <- get_datasets(query = 'bipolar', taxa = 'human')

# Search using specific ontology terms (e.g., MONDO ID for Alzheimer's)
ds_onto <- get_datasets(uris = 'http://purl.obolibrary.org/obo/MONDO_0004975')

# Filter by properties (e.g., sample count > 10)
ds_filtered <- get_datasets(filter = 'bioAssayCount > 10 and allCharacteristics.category = disease')
```

### 2. Downloading Expression Data
The `get_dataset_object` function is the primary high-level wrapper for retrieving annotated data.

```r
# Get a SummarizedExperiment (default)
se <- get_dataset_object("GSE46416", type = 'se')

# Access expression and design
expr_matrix <- assay(se[[1]])
design_metadata <- colData(se[[1]])

# Get tidy format for ggplot2
tidy_data <- get_dataset_object("GSE46416", type = 'tidy')
```

### 3. Accessing Differential Expression (DE)
Gemma provides precomputed DE analyses. Results are returned as a list of `resultSets`.

```r
# Get DE values
de_list <- get_differential_expression_values("GSE46416", readableContrasts = TRUE)
de_results <- de_list[[1]]

# Identify top genes
top_genes <- de_results[order(de_results$pvalue), ]
```

### 4. Platform and Gene Information
Retrieve probe-to-gene mappings and platform details.

```r
# Get annotations for a specific platform
annots <- get_platform_annotations('GPL96')

# Find probes for a specific gene (using NCBI ID)
probes <- get_gene_probes(2026)
```

## Advanced Usage

### Pagination
Gemma API calls are limited to 100 entries. Use `get_all_pages` to retrieve full result sets.
```r
all_human_ds <- get_datasets(taxa = 'human') %>% get_all_pages()
```

### Metadata Exploration
Use `get_dataset_annotations` to see tags and `make_design` to create human-readable design matrices from sample metadata.
```r
samples <- get_dataset_samples('GSE48962')
design <- make_design(samples)
```

### Performance
Enable memoization to cache results locally and speed up repeated queries.
```r
gemma_memoised(TRUE)
```

## Tips for Success
- **Identifiers**: Use NCBI IDs or Ensembl IDs for genes whenever possible to avoid ambiguity with symbols.
- **Ontologies**: Use `search_annotations('keyword')` to find precise URIs for more accurate filtering than plain text.
- **Batch Effects**: Check the `experiment.batchEffect` column. A value of `-1` indicates a detected confound that could not be resolved.
- **Result Sets**: One experiment may have multiple DE analyses (e.g., different factors or interactions). Always check the `result.ID` and `contrast.ID` to ensure you are looking at the correct comparison.

## Reference documentation
- [Accessing curated gene expression data with gemma.R](./references/gemma.R.md)
- [A guide to metadata for samples and differential expression analyses](./references/metadata.md)
- [A meta analysis on effects of Parkinson’s Disease using Gemma.R](./references/metanalysis.md)