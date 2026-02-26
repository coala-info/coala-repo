---
name: r-dgeclustering
description: The r-dgeclustering package automates diagnostic plotting for RNA-seq datasets and performs multidimensional gene clustering integrated with Gene Ontology terms. Use when user asks to generate diagnostic plots from DGE files, cluster genes using expression and biological knowledge, or perform GO enrichment on gene clusters.
homepage: https://cran.r-project.org/web/packages/dgeclustering/index.html
---


# r-dgeclustering

## Overview
The `dgeclustering` package provides tools for downstream RNA-seq analysis. It focuses on two main areas: automating the generation of diagnostic plots from multiple DGE datasets and performing multidimensional clustering that incorporates biological knowledge via Gene Ontology (GO) terms to improve gene grouping accuracy.

## Installation
Install the package from CRAN or via source:

```R
install.packages("dgeclustering")
# Or from source if needed
# install.packages('DGEclustering', type='source', repos=NULL)
```

## Core Workflows

### 1. Automated Diagnostic Plotting
Use the `automation` function to scan a directory for DGE datasets (TSV files) and generate standard diagnostic visualizations.

```R
library(DGEclustering)

# Scans current directory for DGE files and creates folders: qq_plots, fish_plots, scatter_plots
automation(
  rootDir = "./", 
  geneCol = "gene", 
  qqPlot = TRUE, 
  fishPlot = TRUE, 
  scatterPlot = TRUE
)
```

### 2. Multidimensional Clustering with GO Integration
This workflow merges multiple DGE datasets and clusters genes based on both expression patterns (log2FoldChange, p-values) and GO term similarity.

#### Step A: Subset Significant Genes
```R
# datasets is a named list of DGE data frames
sig.res <- sig.subset(
  datasets, 
  geneCol = "gene", 
  x.dsNumber = 1, 
  y.dsNumber = 2, 
  x.threshold = 0.05, 
  y.threshold = 0.05, 
  adjPvalue = TRUE
)

# Access merged data
dat <- if(length(sig.res) == 3) rbind(sig.res$dis, sig.res$con) else sig.res$dat
```

#### Step B: Annotate and Cluster
```R
# Annotate genes with GO terms
ann <- annotate.genes(OrgDb = orgdb, keyType = "FLYBASE", genes = dat$gene, GOEnrichment = FALSE)

# Prepare expression matrix (e.g., log2FC and p-values)
exp <- dat[, grepl("log2FoldChange|pvalue", colnames(dat))]
rownames(exp) <- make.names(dat$gene, unique = TRUE)

# Perform clustering (integrate.method can be 'intego' or 'newdis')
res <- DGE.clust(
  expressions = exp, 
  annotations = ann, 
  integrate.method = "intego", 
  clust.method = "agnes", 
  nb.group = 8
)
```

### 3. Visualization and Enrichment
```R
# Plot clusters in 2D space
cluster.plot(datasets, res$groups, x.dsNumber = 1, y.dsNumber = 2, geneCol = "gene")

# Perform GO enrichment on the resulting clusters
cluster.enrich(
  clusterGroups = res$groups, 
  OrgDb = orgdb, 
  keyType = "FLYBASE", 
  BgGenes = background_vector, 
  ont = "BP", 
  top = 5
)
```

## Tips and Troubleshooting
- **Column Names**: Ensure the `geneCol` (gene ID column) is identical across all input files.
- **KeyError**: If `automation()` fails, check if all TSV files in the directory contain the expected DESeq2 columns (baseMean, log2FoldChange, pvalue, padj).
- **Integration Methods**: 
    - `intego`: Decomposes expression into a binary matrix based on GO.
    - `newdis`: Combines semantic dissimilarity and expression distance.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)