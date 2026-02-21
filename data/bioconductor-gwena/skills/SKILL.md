---
name: bioconductor-gwena
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GWENA.html
---

# bioconductor-gwena

name: bioconductor-gwena
description: Comprehensive gene co-expression network analysis (WGCNA-based) including gene filtering, network construction, module detection, functional enrichment, phenotypic association, and network comparison across conditions. Use when performing transcriptomic data analysis to identify modules of co-expressed genes and their biological relevance.

# bioconductor-gwena

## Overview

GWENA (Gene Whole co-Expression Network Analysis) is a Bioconductor package designed to perform gene co-expression network analysis in a unified pipeline. It streamlines the transition from normalized expression data to biological insights by identifying modules of co-expressed genes, characterizing them through functional enrichment, and associating them with clinical or experimental phenotypes. It also supports comparing network topologies between different experimental conditions.

## Core Workflow

### 1. Data Preparation and Filtering
GWENA expects an expression matrix with **genes as columns** and **samples as rows**. Data must be pre-normalized.

```r
library(GWENA)

# Filter low variation genes (recommended to reduce computational load)
# pct = 0.7 removes the 70% least variable genes
expr_filtered <- filter_low_var(your_expression_matrix, pct = 0.7, type = "median")

# For RNA-seq specific filtering by counts
# expr_filtered <- filter_RNA_seq(your_counts_matrix, method = "at least one", min_count = 10)
```

### 2. Network Building
The `build_net` function computes similarity (Spearman correlation by default), fits a power law to achieve scale-free topology, and calculates adjacency and Topological Overlap Matrix (TOM).

```r
net <- build_net(expr_filtered, cor_func = "spearman", n_threads = 2)

# Check the power selected and the fit (R^2)
net$metadata$power
net$metadata$fit_power_table
```

### 3. Module Detection
Modules are groups of genes with high topological overlap.

```r
# detect_modules performs clustering and merges similar modules
modules <- detect_modules(expr_filtered, 
                          net$network, 
                          detailled_result = TRUE,
                          merge_threshold = 0.25)

# Module 0 contains genes not assigned to any module
```

### 4. Biological Integration
Characterize modules using over-representation analysis (ORA) and phenotypic correlation.

```r
# Functional enrichment using g:Profiler
enrichment <- bio_enrich(modules$modules)
plot_enrichment(enrichment)

# Phenotypic association (requires a traits data frame)
# traits should have samples as rows matching the expression data
pheno_assoc <- associate_phenotype(modules$modules_eigengenes, traits_df)
plot_modules_phenotype(pheno_assoc)
```

### 5. Visualization and Hub Genes
Identify key "hub" genes and visualize module connections.

```r
# Identify hubs by connectivity
hubs <- get_hub_high_co(expr_filtered, modules$modules$`1`, net$network)

# Build and plot a graph for a specific module
mod_graph <- build_graph_from_sq_mat(net$network[modules$modules$`1`, modules$modules$`1`])
plot_module(mod_graph, upper_weight_th = 0.99)
```

### 6. Network Comparison
Compare module preservation between two conditions (e.g., Control vs. Treatment).

```r
# Requires expression, adjacency, and correlation matrices for both conditions
comparison <- compare_conditions(expr_list, 
                                 adja_list, 
                                 cor_list, 
                                 modules_list, 
                                 pvalue_th = 0.05)
```

## Tips and Best Practices
- **Gene Collapsing**: Ensure data is at the gene level (not transcript/probe) before starting.
- **Scale-Free Topology**: If `build_net` fails to find a power, check if your filtering was too aggressive or if the data has strong batch effects.
- **Eigengenes**: Use `modules$modules_eigengenes` as a "signature" for the module's expression profile in downstream statistical tests.
- **Memory Management**: For very large datasets, use `filter_low_var` to keep the gene count under 10,000-15,000 if resources are limited.
- **Signed vs Unsigned**: GWENA handles the transformation of correlations to ensure positive values for power-law fitting while preserving the sign's biological meaning.

## Reference documentation
- [GWENA - Tutorial](./references/GWENA_guide.md)
- [GWENA - Tutorial (RMarkdown)](./references/GWENA_guide.Rmd)