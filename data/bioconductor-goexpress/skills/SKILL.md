---
name: bioconductor-goexpress
description: This tool visualizes and ranks Gene Ontology terms from gene expression data to identify biological processes that best discriminate between experimental groups. Use when user asks to identify significant GO terms using supervised clustering, rank gene sets based on expression profiles, or generate heatmaps and dendrograms for specific biological functions.
homepage: https://bioconductor.org/packages/release/bioc/html/GOexpress.html
---


# bioconductor-goexpress

name: bioconductor-goexpress
description: Visualise gene expression data (microarray/RNA-seq) using Gene Ontology (GO) annotations. Use this skill to identify GO terms that best classify sample groups using supervised clustering (Random Forest or ANOVA) and to generate high-quality gene expression profiles, heatmaps, and dendrograms.

## Overview

GOexpress is a Bioconductor package designed for the exploration of multifactorial transcriptomics data. It uses a supervised approach to rank Gene Ontology (GO) terms based on the ability of their associated genes to discriminate between predefined experimental groups. It is particularly useful for visualizing how specific biological processes or molecular functions behave across different treatments, time-points, or genotypes.

## Core Workflow

### 1. Data Preparation
GOexpress requires an `ExpressionSet` object containing a normalized expression matrix and phenotypic metadata.

```R
library(GOexpress)
library(Biobase)

# Load example data
data(AlvMac)

# Ensure the grouping factor is an R factor
AlvMac$Treatment <- factor(AlvMac$Treatment)
```

### 2. Running the Analysis
The `GO_analyse()` function is the primary engine. It scores genes using `randomForest` (default) or `one-way ANOVA`.

```R
# Using local annotations (recommended for speed and reproducibility)
# Requires GO_genes, all_GO, and all_genes mapping objects
set.seed(4543)
results <- GO_analyse(
  eSet = AlvMac, 
  f = "Treatment",
  GO_genes = AlvMac_GOgenes, 
  all_GO = AlvMac_allGO, 
  all_genes = AlvMac_allgenes
)

# Note: If local annotations are omitted, the package will attempt 
# to fetch them from Ensembl via biomaRt (slower).
```

### 3. Statistical Significance
Assess the significance of GO term rankings using permutation-based P-values.

```R
# N=1000 is recommended for publication-quality P-values
results.pVal <- pValue_GO(result = results, N = 100)
```

### 4. Filtering and Subsetting
Filter results by ontology type (BP, MF, CC), minimum gene count, or P-value.

```R
# Filter for Biological Process with at least 5 genes and p < 0.05
BP.filtered <- subset_scores(
  result = results.pVal,
  namespace = "biological_process",
  total = 5,
  p.val = 0.05
)
```

## Visualization Functions

### Heatmaps and Clustering
Visualize sample clustering based on genes associated with a specific GO term.

```R
# Heatmap for a specific GO ID
heatmap_GO(
  go_id = "GO:0034142", 
  result = BP.filtered, 
  eSet = AlvMac, 
  labRow = AlvMac$Group
)

# Hierarchical clustering dendrogram
cluster_GO(
  go_id = "GO:0034142", 
  result = BP.filtered, 
  eSet = AlvMac, 
  f = "Group"
)
```

### Gene Expression Profiles
Plot the expression of individual genes across experimental factors.

```R
# Plot by Gene ID (e.g., Ensembl)
expression_plot(
  gene_id = "ENSBTAG00000047107", 
  result = results, 
  eSet = AlvMac, 
  x_var = "Timepoint"
)

# Plot by Gene Symbol
expression_plot_symbol(
  gene_symbol = "BIKBA", 
  result = results, 
  eSet = AlvMac, 
  x_var = "Timepoint"
)

# Individual sample series (tracking specific subjects/replicates)
expression_profiles_symbol(
  gene_symbol = "TNIP3", 
  result = results, 
  eSet = AlvMac, 
  x_var = "Timepoint", 
  seriesF = "Animal.Treatment"
)
```

## Advanced Usage Tips

- **Custom Annotations**: To work offline or with unsupported species, provide custom data frames to `GO_genes` (mapping), `all_genes` (descriptions), and `all_GO` (GO descriptions).
- **On-the-fly Subsetting**: Use the `subset` argument in most functions (e.g., `subset = list(Time = c("24H", "48H"))`) to analyze or visualize specific groups without creating new `ExpressionSet` objects.
- **Reranking**: Use `rerank(result, rank.by = "score")` or `rank.by = "p.val"` to change the sorting order of the results table.
- **ANOVA vs Random Forest**: Use `method = "anova"` in `GO_analyse` for a faster, univariate approach. Use the default `randomForest` to capture multivariate interactions between genes.

## Reference documentation

- [GOexpress User's Guide](./references/GOexpress-UsersGuide.md)