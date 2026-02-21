---
name: bioconductor-cimice
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CIMICE.html
---

# bioconductor-cimice

## Overview
CIMICE (Markov Chain Method to Infer Cancer Evolution) is an R package designed to model the evolutionary paths of tumor subtypes. It takes a boolean mutational matrix (genes as columns, samples/genotypes as rows) and constructs a Cancer Progression Markov Chain (CPMC). The tool is optimized for single-cell DNA analysis, where it identifies unique genotypes, builds a Directed Acyclic Graph (DAG) based on mutational subset relations, and calculates transition probabilities (weights) between states.

## Core Workflow

### 1. Input Management
CIMICE supports several input formats. The primary requirement is a boolean matrix where 1 indicates a mutation.

```r
library(CIMICE)

# Load from CAPRI/CAPRESE format
dataset <- read_CAPRI(system.file("extdata", "example.CAPRI", package = "CIMICE"))

# Load from MAF file
dataset_maf <- read_MAF("path/to/file.maf")

# Create manually
dataset_custom <- make_dataset(GeneA, GeneB, GeneC) %>%
    update_df("Sample1", 1, 0, 0) %>%
    update_df("Sample2", 1, 1, 0)
```

### 2. Exploratory Analysis & Feature Selection
Before building the model, analyze mutation distributions and filter high-dimensional data.

```r
# Visualize distributions
gene_mutations_hist(dataset)
sample_mutations_hist(dataset)

# Correlation heatmaps
corrplot_genes(dataset)

# Feature selection: Keep top 50 most mutated genes
dataset_filtered <- select_genes_on_mutations(dataset, 50)

# Feature selection: Keep 100 least mutated samples
dataset_filtered <- select_samples_on_mutations(dataset, 100, desc = FALSE)
```

### 3. Automated Analysis (Quick Run)
The fastest way to generate a model and visualization is using `quick_run`.

```r
# Perform full pipeline: preprocessing, topology, and weight computation
result <- quick_run(dataset)

# Visualize the result
draw_visNetwork(result)
```

### 4. Manual Pipeline Steps
For granular control, execute the pipeline stages individually:

```r
# Step A: Preprocessing (grouping equal genotypes)
preproc <- dataset_preprocessing(dataset)
# Returns list: samples, freqs, labels, genes

# Step B: Topology Construction (Subset relation)
# Removes transitive edges to create a DAG
g <- graph_non_transitive_subset_topology(preproc$samples, preproc$labels)

# Step C: Weight Computation
# Calculates transition probabilities (UP/DOWN normalization)
W <- compute_weights_default(g, preproc$freqs)
```

### 5. Output and Export
CIMICE provides multiple visualization engines and export formats.

```r
# Interactive visualizations
draw_visNetwork(result)  # Recommended for large graphs
draw_networkD3(result)   # D3.js based

# Static visualization
draw_ggraph(result)

# Export to DOT format for Graphviz
cat(to_dot(result))
```

## Tips for Success
- **Clonal Root**: CIMICE automatically adds a "Clonal" (all zeros) genotype if not present to serve as the root of the evolution tree.
- **Genotype Compaction**: The package automatically groups identical genotypes and calculates their frequency; you do not need to deduplicate samples manually.
- **Large Datasets**: For very large single-cell datasets, always use `select_genes_on_mutations` to focus on driver mutations, as the subset-relation graph complexity grows with the number of unique genotypes.

## Reference documentation
- [CIMICE-R: (Markov) Chain Method to Infer Cancer Evolution](./references/CIMICER.md)
- [Quick guide](./references/CIMICE_SHORT.md)