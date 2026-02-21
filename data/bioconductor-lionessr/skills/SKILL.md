---
name: bioconductor-lionessr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/lionessR.html
---

# bioconductor-lionessr

name: bioconductor-lionessr
description: Reconstruct single-sample networks from aggregate data using the LIONESS (Linear Interpolation to Obtain Network Estimates for Single Samples) algorithm. Use this skill when you need to perform single-sample co-expression analysis, identify individual-specific network edges, or conduct differential co-expression analysis between patient groups in R.

# bioconductor-lionessr

## Overview

The `lionessR` package implements the LIONESS equation to estimate the network structure of individual samples within a population. While traditional network reconstruction (like Pearson correlation) requires a group of samples to produce a single aggregate network, LIONESS uses a "leave-one-out" approach to interpolate the specific contribution of each sample. This allows for downstream statistical analysis (e.g., LIMMA) on network edges just as one would perform on gene expression data.

## Core Workflow

### 1. Data Preparation
The input should be a gene expression matrix or a `SummarizedExperiment` object. To reduce computational load and noise, it is standard practice to subset the data to the most variably expressed genes.

```r
library(lionessR)
library(SummarizedExperiment)

# Assuming 'exp' is your expression matrix
nsel <- 500
cvar <- apply(exp, 1, sd)
dat <- exp[tail(order(cvar), nsel), ]
```

### 2. Single-Sample Network Reconstruction
The primary function is `lioness()`. By default, it uses Pearson correlation (`netFun`), but it can be adapted for any algorithm that returns a complete weighted adjacency matrix.

```r
# Returns a data frame where rows are edges and columns are samples
cormat <- lioness(dat, netFun)

# The output format is typically: [Gene1, Gene2, Sample1_Weight, Sample2_Weight, ...]
# It is helpful to create unique edge IDs
row.names(cormat) <- paste(cormat[,1], cormat[,2], sep="_")
edge_values <- as.matrix(cormat[, 3:ncol(cormat)])
```

### 3. Differential Co-expression Analysis
Once single-sample edge weights are calculated, you can use standard linear modeling (like `limma`) to find edges that differ significantly between conditions.

```r
library(limma)

# Define groups based on sample metadata
group <- factor(targets$condition)
design <- model.matrix(~0+group)
cont.matrix <- makeContrasts(GroupAvsB = (groupA - groupB), levels = design)

# Fit model to the edge weights
fit <- lmFit(edge_values, design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2e <- eBayes(fit2)
toptable <- topTable(fit2e, number=nrow(edge_values), adjust="fdr")
```

### 4. Visualization
Significant edges can be converted into `igraph` objects. A common pattern is to color edges by the sign of the log fold change (logFC) and nodes by the t-statistic of differential expression.

```r
library(igraph)

# Extract top 50 edges
top_edges <- t(matrix(unlist(strsplit(row.names(toptable)[1:50], "_")), 2))
g <- graph_from_data_frame(data.frame(top_edges, weight=toptable$logFC[1:50]), directed=FALSE)

# Plotting
plot(g, vertex.size=10, edge.width=abs(E(g)$weight)*5)
```

## Tips and Best Practices
- **Computational Cost**: LIONESS runs the network reconstruction algorithm $N+1$ times (where $N$ is the number of samples). For large gene sets, this is memory and time-intensive. Always filter genes (e.g., top 500-1000 by SD) before running.
- **Edge Selection**: Before running LIONESS, you can pre-filter edges by calculating a "global" difference between condition-specific networks to focus only on edges likely to show high variance.
- **Bipartite Networks**: The package supports bipartite networks (e.g., Transcription Factor to Target Gene) if the reconstruction function provided to `lioness()` handles them.

## Reference documentation
- [lionessR.Rmd](./references/lionessR.Rmd)
- [lionessR.md](./references/lionessR.md)