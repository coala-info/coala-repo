---
name: bioconductor-countclust
description: This package applies Grade of Membership models to biological count data to estimate membership proportions across multiple clusters. Use when user asks to fit topic models to RNA-seq data, visualize sample compositions with structure plots, or identify top driving features for clusters.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CountClust.html
---


# bioconductor-countclust

## Overview

The `CountClust` package applies Grade of Membership (GoM) models—also known as Latent Dirichlet Allocation (LDA) or admixture models—to biological count data, such as RNA-seq. Unlike traditional clustering where a sample belongs to one group, GoM allows each sample to have a membership proportion across multiple clusters. This is particularly useful for identifying cell types in single-cell data or tissue compositions in bulk RNA-seq.

## Core Workflow

### 1. Data Preparation
Input data should be a counts matrix where rows are samples and columns are features (genes). Note that many `CountClust` functions require the transpose of standard Bioconductor `ExpressionSet` objects.

```r
library(CountClust)
# Assuming counts is a matrix with genes as rows and samples as columns
data_input <- t(counts) 
```

### 2. Fitting the Model
Use `FitGoM` to fit the topic model. You can provide a single value or a vector for `K` (number of clusters).

```r
# Fit for a specific K
fit <- FitGoM(data_input, K = 4, tol = 1)

# Fit for a range of K
fit_range <- FitGoM(data_input, K = 2:7, tol = 0.1)
```

### 3. Visualization with Structure Plots
The `StructureGGplot` function creates a "Structure plot" where each bar represents a sample and colors represent cluster membership proportions.

```r
# Extract omega (membership proportions)
omega <- fit$omega

# Create annotation dataframe
annot <- data.frame(
  sample_id = rownames(omega),
  tissue_label = factor(metadata$group)
)

# Generate plot
StructureGGplot(omega = omega,
                annotation = annot,
                palette = RColorBrewer::brewer.pal(8, "Accent"),
                yaxis_label = "Group",
                order_sample = TRUE)
```

### 4. Dimensionality Reduction Overlay
You can visualize GoM memberships as pie charts on PCA or t-SNE coordinates using `StructurePie`.

```r
StructurePie(data_input, 
             input_type = "apply_tsne", 
             omega = omega, 
             use_voom = TRUE, 
             main = "GoM K=4 on t-SNE")
```

### 5. Identifying Cluster Features
To interpret what each cluster represents biologically, extract the top driving features (genes) using `ExtractTopFeatures`.

```r
# theta contains the probability of each gene belonging to a cluster
theta_mat <- fit$theta

top_features <- ExtractTopFeatures(theta_mat, 
                                   top_features = 100, 
                                   method = "poisson", 
                                   options = "min")

# Get gene names for the top indices
gene_list <- apply(top_features$indices, 1, function(x) rownames(counts)[x])
```

### 6. Batch Correction
If technical effects (like amplification batches) are driving the clustering, use `BatchCorrectedCounts` to remove these effects before re-fitting the model.

```r
batch_corrected <- BatchCorrectedCounts(data_input, 
                                        batch_vector = metadata$batch, 
                                        use_parallel = FALSE)
```

## Tips and Best Practices
- **Tolerance**: The `tol` parameter in `FitGoM` controls convergence. Use a higher tolerance (e.g., 1) for quick exploratory runs and a lower one (e.g., 0.1) for final results.
- **Normalization**: `StructurePie` includes a `use_voom` argument; setting this to `TRUE` applies log-CPM transformation, which is generally recommended for PCA/t-SNE.
- **Sample Ordering**: In `StructureGGplot`, `order_sample = TRUE` sorts samples within each group by their dominant cluster membership, making the plot much easier to read.

## Reference documentation
- [Visualizing the structure of RNA-seq expression data using Grade of Membership Models](./references/count-clust.Rmd)
- [Visualizing the structure of RNA-seq expression data using Grade of Membership Models (Markdown)](./references/count-clust.md)