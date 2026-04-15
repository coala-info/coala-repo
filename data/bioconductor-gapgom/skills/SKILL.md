---
name: bioconductor-gapgom
description: This tool performs functional annotation prediction and semantic similarity analysis for genes using expression correlation and Gene Ontology topology. Use when user asks to predict GO annotations for unannotated genes, calculate semantic similarity between genes or gene sets, or process FANTOM5 expression data for functional genomics.
homepage: https://bioconductor.org/packages/3.9/bioc/html/GAPGOM.html
---

# bioconductor-gapgom

name: bioconductor-gapgom
description: Functional annotation prediction and semantic similarity analysis for genes (especially lncRNAs) using the GAPGOM Bioconductor package. Use this skill to: (1) Predict GO annotations for novel genes using expression correlation (lncRNA2GOA), (2) Calculate topological semantic similarity between GO terms or gene sets (TopoICSim), (3) Process FANTOM5 expression data or custom ExpressionSets for functional genomics.

# bioconductor-gapgom

## Overview
GAPGOM (novel Gene Annotation Prediction and other GO Metrics) provides tools for functional genomics, specifically focusing on predicting the function of unannotated genes like long non-coding RNAs (lncRNAs). It implements two primary algorithms: **lncRNA2GOA** for expression-based "guilt-by-association" annotation and **TopoICSim** for topology-based semantic similarity measurements within the Gene Ontology (GO) Directed Acyclic Graph (DAG).

## Core Workflows

### 1. Expression Data Preparation
GAPGOM works with `ExpressionSet` objects. It provides specific helpers for FANTOM5 data but supports any `AnnotationDbi` compatible IDs (Entrez IDs recommended).

```r
library(GAPGOM)
library(Biobase)

# Option A: Load FANTOM5 data
fantom_file <- fantom_download("./", organism = "human")
ft5 <- fantom_load_raw(fantom_file)
expset <- fantom_to_expset(ft5)

# Option B: Manual ExpressionSet creation
# Ensure rownames are unique IDs and featureData contains mapping
expression_matrix <- as.matrix(my_data[, 2:ncol(my_data)])
rownames(expression_matrix) <- my_data$ENTREZID
expset <- ExpressionSet(assayData = expression_matrix)
```

### 2. Functional Prediction (lncRNA2GOA)
Predict GO terms for a query gene by correlating its expression against a library of annotated genes.

```r
# Predict BP terms for a specific Ensembl ID
result <- expression_prediction(
  gid = "ENSG00000228630",
  expset = expset,
  organism = "human",
  ontology = "BP",
  method = "combine", # Options: pearson, spearman, kendall, sobolev, fisher, combine
  filter_pvals = TRUE
)

# View significant GO terms and FDR
head(result)
```

### 3. Semantic Similarity (TopoICSim)
Calculate similarity between genes or gene sets based on GO DAG topology and Information Content (IC).

```r
# Compare two genes (Entrez IDs)
gene_sim <- topo_ic_sim_genes(
  organism = "human",
  ontology = "MF",
  genes1 = "218",
  genes2 = "501"
)

# Access results
gene_sim$GeneSim    # Similarity score
gene_sim$AllGoPairs # Underlying GO term similarity matrix

# Compare gene sets (Intraset similarity)
geneset <- c("126133", "221", "218")
set_sim <- topo_ic_sim_genes("human", "BP", geneset, geneset)
mean(set_sim$GeneSim)
```

### 4. Custom Gene Definitions
Define "custom genes" using a list of GO terms to compare hypothetical or predicted annotations against known genes.

```r
custom <- list(my_pred = c("GO:0016787", "GO:0042802"))
res <- topo_ic_sim_genes(
  organism = "human", 
  ontology = "MF", 
  genes1 = c(), # Empty if only using custom
  genes2 = "501",
  custom_genes1 = custom
)
```

## Usage Tips
- **ID Types**: While multiple IDs are supported, Entrez IDs are the most stable across Bioconductor dependencies.
- **Performance**: TopoICSim is computationally intensive. For large gene sets, pre-calculate the `AllGoPairs` matrix and pass it to subsequent calls to save time.
- **Memory**: The package may experience memory leaks during large iterative `apply` operations; restarting the R session is recommended for very large batches.
- **Ontology Choice**: Results vary by ontology (MF, BP, or CC). CC often shows higher similarity scores due to lower DAG complexity compared to BP.

## Reference documentation
- [An Introduction to GAPGOM](./references/GAPGOM.md)
- [Benchmarks and other GO similarity methods](./references/benchmarks.md)