---
name: bioconductor-orthogene
description: orthogene maps orthologous genes across hundreds of species and handles interspecies conversion of gene expression matrices, lists, and data frames. Use when user asks to convert orthologs between species, infer species from gene lists, standardize species names, or map gene synonyms within a single species.
homepage: https://bioconductor.org/packages/release/bioc/html/orthogene.html
---

# bioconductor-orthogene

## Overview
`orthogene` is a Bioconductor package designed for seamless mapping of orthologous genes across over 700 species. It provides a unified interface to multiple orthology databases (primarily `gprofiler` and `homologene`) and handles complex many-to-many mapping issues during interspecies conversion. It is particularly useful for translating gene expression matrices, lists, or data frames from model organisms to human equivalents or vice versa.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("orthogene")
library(orthogene)
```

## Core Workflows

### 1. Interspecies Ortholog Conversion
The primary function `convert_orthologs` transforms gene identifiers from an `input_species` to an `output_species`.

```r
# Convert a mouse expression matrix to human
# gene_df can be a matrix, data.frame, or vector
gene_df_human <- orthogene::convert_orthologs(
  gene_df = exp_mouse,
  input_species = "mouse",
  output_species = "human",
  method = "gprofiler" # Default, supports 700+ species
)
```

**Handling Non-1:1 Orthologs:**
By default, `orthogene` drops genes without a 1:1 mapping to ensure functional conservation. You can adjust this via `non121_strategy`:
* `"drop_both_species"`: (Default) Strict 1:1 mapping.
* `"keep_popular"`: Returns the most common mapping.
* `"keep_both_species"`: Keeps all many-to-many mappings.

**Matrix Aggregation:**
When converting matrices with many-to-one mappings, use `agg_fun` (e.g., `"sum"`, `"mean"`) to collapse rows.

### 2. Inferring Species from Gene Lists
If the species of a dataset is unknown, `infer_species` checks the gene list against common genomes.

```r
# Returns a table of matches with percentage overlap
matches <- orthogene::infer_species(gene_df = some_unknown_genes)
```

### 3. Standardizing Species Names
`map_species` converts various species identifiers (common names, taxonomy IDs, Latin names) into a standardized format.

```r
# Returns "Homo sapiens", "Mus musculus", etc.
species_names <- orthogene::map_species(
  species = c("human", "mouse", 9606),
  output_format = "scientific_name"
)
```

### 4. Within-Species Gene Mapping
`map_genes` standardizes synonyms (e.g., Ensembl IDs to Gene Symbols) within a single species.

```r
mapped <- orthogene::map_genes(
  genes = c("Klf4", "ENSMUSG00000003032"),
  species = "mouse"
)
```

### 5. Aggregating Matrices
`aggregate_mapped_genes` is a utility to collapse a matrix (e.g., transcript-level to gene-level) using within-species mapping.

```r
exp_agg <- orthogene::aggregate_mapped_genes(
  gene_df = exp_matrix,
  input_species = "mouse",
  agg_fun = "sum"
)
```

## Tips for Success
* **Method Selection**: Use `method="gprofiler"` for the widest species support. Use `method="homologene"` for a smaller, highly curated set of ~20 species.
* **Input Formats**: `convert_orthologs` is highly flexible; it accepts rownames of matrices, columns of data frames, or simple character vectors.
* **Gene Symbols**: By default, the package maps everything to standardized Gene Symbols. Use the `...` arguments to pass specific parameters to the underlying mapping engines if Ensembl IDs or other formats are required as output.

## Reference documentation
- [Docker/Singularity Containers](./references/docker.md)
- [Infer species](./references/infer_species.md)
- [orthogene: Getting Started](./references/orthogene.md)