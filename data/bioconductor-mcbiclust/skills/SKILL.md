---
name: bioconductor-mcbiclust
description: bioconductor-mcbiclust performs massively correlating biclustering analysis to identify gene sets that are highly correlated across subsets of samples in large-scale transcriptomic data. Use when user asks to find biclusters based on gene correlation patterns, identify co-regulation phenotypes, or classify samples into groups based on bicluster regulation.
homepage: https://bioconductor.org/packages/release/bioc/html/MCbiclust.html
---


# bioconductor-mcbiclust

name: bioconductor-mcbiclust
description: Massively correlating biclustering analysis for large-scale gene expression data. Use this skill to find biclusters where features (genes) are highly correlated across a subset of samples, perform gene set enrichment on correlation patterns, and classify samples into "forks" based on bicluster regulation.

# bioconductor-mcbiclust

## Overview

MCbiclust is an R package designed to identify large-scale biclusters in transcriptomic data. Unlike traditional biclustering that looks for similar expression levels, MCbiclust identifies subsets of genes that are highly correlated (or anti-correlated) across a subset of samples. This is particularly useful for identifying co-regulation patterns and "forking" phenotypes in cancer datasets or other complex biological systems.

## Core Workflow

### 1. Finding a Bicluster Seed
The process begins by finding a small "seed" of samples where the chosen gene set (e.g., mitochondrial genes) shows maximum correlation.

```r
library(MCbiclust)

# gem: gene expression matrix (rows=genes, cols=samples)
# seed.size: number of samples in the initial seed
# iterations: number of stochastic search steps
set.seed(123)
my_seed <- FindSeed(gem = CCLE.mito, 
                    seed.size = 10, 
                    iterations = 10000)

# Calculate the correlation score (alpha) for a seed
score <- CorScoreCalc(CCLE.mito, my_seed)
```

### 2. Selecting Highly Correlated Genes
Identify which genes within your initial set contribute most strongly to the correlation pattern.

```r
# cuts: number of groups for hierarchical clustering
hicor_genes <- HclustGenesHiCor(CCLE.mito, my_seed, cuts = 8)
```

### 3. Calculating the Correlation Vector (CV)
Expand the pattern to the entire dataset to see how all genes correlate with the identified bicluster pattern.

```r
# gem.part: subset matrix used for seed finding
# gem.all: full expression matrix
cor_vec <- CVEval(gem.part = CCLE.mito, 
                  gem.all = CCLE_small, 
                  seed = my_seed, 
                  splits = 10)
```

### 4. Sample Sorting and PCA
Order all samples based on how well they fit the correlation pattern and summarize the pattern using the first principal component (PC1).

```r
# Sort samples
sorted_samples <- SampleSort(CCLE.mito[as.numeric(hicor_genes),], 
                             seed = my_seed)

# Calculate PC1 vector for the ordering
pc1_vec <- PC1VecFun(top.gem = CCLE.mito[as.numeric(hicor_genes),], 
                     seed.sort = sorted_samples, 
                     n = 10)

# Align PC1 so positive values correspond to positive CV genes
pc1_vec <- PC1Align(gem = CCLE_small, 
                    pc1 = pc1_vec, 
                    sort.order = sorted_samples, 
                    cor.vec = cor_vec, 
                    bic = my_bic)
```

### 5. Thresholding and Classification
Define the boundaries of the bicluster and classify samples into "Upper", "Lower", or "Uncorrelated" forks.

```r
# Determine which genes and samples are in the bicluster
my_bic <- ThresholdBic(cor.vec = cor_vec, 
                       sort.order = sorted_samples, 
                       pc1 = pc1_vec, 
                       samp.sig = 0.05)

# Classify samples for plotting
fork_status <- ForkClassifier(pc1_vec, samp.num = length(my_bic[[2]]))
```

## Analysis of Multiple Runs
Because MCbiclust is stochastic, it is recommended to run it multiple times to find distinct patterns.

1. Run `FindSeed` and `CVEval` multiple times (e.g., 100 runs).
2. Combine correlation vectors into a matrix.
3. Use `SilhouetteClustGroups(multi_cv_matrix)` to identify the number of distinct correlation patterns found.
4. Use `CVPlot()` to visualize the different patterns.

## Functional Enrichment
MCbiclust includes a built-in Mann-Whitney U test for Gene Ontology (GO) enrichment based on the Correlation Vector.

```r
gse_results <- GOEnrichmentAnalysis(gene.names = row.names(CCLE_small), 
                                    gene.values = cor_vec, 
                                    sig.rate = 0.05)
```

## Key Tips
- **Computational Cost**: `SampleSort` is computationally expensive. For large datasets, consider using `sort.length` to only sort the top samples or run on a high-performance cluster.
- **Gene Limits**: `FindSeed` is not efficient for >1000 genes. Always use a biologically relevant subset (e.g., a specific pathway or organelle gene set) for the initial seed finding.
- **Absolute Correlation**: The correlation score $\alpha$ uses absolute values, meaning the bicluster can contain both highly correlated and highly anti-correlated genes.

## Reference documentation
- [Introduction to MCbiclust](./references/MCbiclust_vignette.md)