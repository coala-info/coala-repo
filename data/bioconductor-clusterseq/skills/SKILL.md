---
name: bioconductor-clusterseq
description: This tool clusters high-throughput sequencing data based on patterns of co-expression across samples. Use when user asks to identify groups of genes with similar expression profiles, perform k-means based clustering on RNA-seq data, or estimate posterior likelihoods for shared expression models.
homepage: https://bioconductor.org/packages/release/bioc/html/clusterSeq.html
---


# bioconductor-clusterseq

name: bioconductor-clusterseq
description: Clustering high-throughput sequencing data (RNA-seq) based on patterns of co-expression across samples. Use this skill to identify groups of genes with similar expression profiles, optionally accounting for replicate structures, using either k-means based dissimilarity or empirical Bayesian posterior likelihoods.

## Overview

The `clusterSeq` package provides methods for clustering genes in sequencing data by their co-expression patterns. Unlike standard clustering which often looks at absolute expression levels, `clusterSeq` focuses on the relationships between samples (e.g., monotonicity of expression across time points). It offers two primary workflows:
1. **K-means based clustering**: Uses a log-normal assumption and a modified gap statistic to determine dissimilarity between genes.
2. **Posterior likelihood analysis**: Leverages the `baySeq` framework to estimate the probability that genes share the same underlying expression model.

## Typical Workflow

### 1. Data Preparation
Data should be a matrix of raw counts. Define the replicate structure as a factor or character vector.

```r
library(clusterSeq)
library(baySeq)

data(ratThymus)
replicates <- c("2w", "2w", "2w", "2w", "6w", "6w", "6w", "6w", "21w", "21w", "21w", "21w", "104w", "104w", "104w", "104w")
libsizes <- getLibsizes(data = ratThymus)
```

### 2. K-means Clustering Workflow
This method is faster for initial exploration. It calculates dissimilarity based on the maximum difference within clusters where expression is monotonic between genes.

```r
# Pre-processing: handle zeros and log-transform
ratThymus[ratThymus == 0] <- 1
normRT <- log2(ratThymus %*% diag(1/libsizes) * mean(libsizes))

# Calculate dissimilarity scores
# B = number of bootstrap iterations for gap statistic
kClust <- kCluster(normRT, replicates = replicates, B = 1000)

# Generate clusters using singleton agglomeration
mkClust <- makeClusters(kClust, normRT, threshold = 1)
```

For large datasets, you can save the full distance matrix to a file and use hierarchical clustering:
```r
kClust <- kCluster(normRT, matrixFile = "dist_matrix.txt.gz", B = 1000)
mkClustRC <- makeClustersFF("dist_matrix.txt.gz", method = "complete", cut.height = 5)
```

### 3. Posterior Likelihood Workflow
This method is more robust but computationally intensive, requiring `baySeq` to pre-calculate model likelihoods.

```r
# Create baySeq object and define models
cD <- new("countData", data = ratThymus, replicates = replicates)
densityFunction(cD) <- nbinomDensity
libsizes(cD) <- getLibsizes(cD)
cD <- allModels(cD)

# Get Priors and Likelihoods (usually requires a cluster)
# cD <- getPriors(cD, consensus = TRUE, cl = cl)
# cD <- getLikelihoods(cD, cl = cl)

# Associate posteriors to find co-expression
aM <- associatePosteriors(cD)
sX <- makeClusters(aM, cD, threshold = 0.5)
```

### 4. Visualization and Comparison
- **Visualization**: Use `plotCluster` to view expression profiles of identified clusters.
- **Comparison**: Use `wallace` to calculate the Wallace coefficient between two different clustering results (e.g., comparing k-means vs. posterior methods).

```r
# Plot the first 6 clusters
plotCluster(sX[1:6], cD)

# Compare two clustering objects
wallace(sX, mkClust)
```

## Tips and Best Practices
- **Filtering**: For the posterior likelihood workflow, it is often beneficial to filter out low-expression genes or focus on a subset of highly variable genes to reduce computation time.
- **Replicates**: Always provide the `replicates` argument to `kCluster` if the experimental design includes them; this forces members of the same group to cluster together, reducing noise.
- **Thresholds**: The `threshold` in `makeClusters` for k-means is a dissimilarity score (lower is more similar), whereas for `associatePosteriors`, it represents a likelihood (higher is more similar).

## Reference documentation
- [clusterSeq](./references/clusterSeq.md)