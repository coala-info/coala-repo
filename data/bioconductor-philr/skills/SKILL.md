---
name: bioconductor-philr
description: PhILR transforms compositional microbiome data into an orthogonal space using phylogenetic trees to define balances between clades. Use when user asks to transform OTU tables into isometric log-ratios, perform phylogenetic compositional data analysis, or identify evolutionary balances that distinguish sample groups.
homepage: https://bioconductor.org/packages/release/bioc/html/philr.html
---

# bioconductor-philr

## Overview

PhILR (Phylogenetic Isometric Log-Ratio) transforms compositional data (e.g., microbiome OTU tables) into an orthogonal, unconstrained real space. This transformation uses a phylogenetic tree to define "balances" at each internal node, representing the log-ratio of the geometric mean abundance of the two descending clades. This allows the application of standard statistical tools (MDS, linear models, etc.) to compositional data while maintaining evolutionary interpretation.

## Core Workflow

### 1. Data Preparation

Ensure the phylogenetic tree is rooted and binary. Use `ape::multi2di` if the tree has multichotomies.

```r
library(philr)
library(ape)
library(mia)

# Example with TreeSummarizedExperiment (TreeSE)
data(GlobalPatterns, package = "mia")

# 1. Filter low abundance/prevalence
tse <- subsetByPrevalentTaxa(GlobalPatterns, detection = 3, prevalence = 0.2)

# 2. Ensure tree matches filtered taxa and is binary
tree <- ape::keep.tip(rowTree(tse), rowLinks(tse)$nodeNum)
if(!is.binary(tree)) tree <- multi2di(tree)
if(!is.rooted(tree)) tree <- root(tree, outgroup = 1, resolve.root = TRUE)

# 3. Add pseudocount (PhILR requires non-zero values)
assays(tse)$counts.shifted <- assays(tse)$counts + 1
```

### 2. PhILR Transformation

The `philr()` function is a wrapper that handles the Sequential Binary Partition (SBP) and weight calculations.

```r
# Using a TreeSE object
gp.philr <- philr(tse, 
                  abund_values = "counts.shifted",
                  part.weights = 'enorm.x.gm.counts', 
                  ilr.weights = 'blw.sqrt')

# Using a matrix and tree
# otu.table should be (samples x taxa)
# gp.philr <- philr(otu.table, tree, part.weights='enorm.x.gm.counts', ilr.weights='blw.sqrt')
```

### 3. Statistical Analysis

Once transformed, use standard Euclidean-based methods.

```r
# Ordination (MDS)
gp.dist <- dist(gp.philr, method = "euclidean")
cmd <- as.data.frame(cmdscale(gp.dist))

# Supervised Learning (e.g., identifying balances distinguishing groups)
library(glmnet)
fit <- glmnet(gp.philr, y_vector, family = "binomial")
```

### 4. Interpreting and Naming Balances

Balances are named after internal nodes (e.g., "n1"). Use `name.balance` to find the consensus taxonomy for the numerator (+) and denominator (-) of a balance.

```r
# Get taxonomy table
tax <- as.data.frame(rowData(tse))

# Name a specific balance (e.g., node 'n10')
name.balance(tree, tax, 'n10')

# Get detailed voting information
votes <- name.balance(tree, tax, 'n10', return.votes = c('up', 'down'))
```

### 5. Visualization

Use `ggtree` to visualize balances on the phylogeny and `convert_to_long` for distribution plots.

```r
library(ggtree)

# Map balance names to node numbers
node_idx <- name.to.nn(tree, "n10")

# Highlight balance on tree
ggtree(tree) + 
  geom_balance(node = node_idx, fill = "steelblue", alpha = 0.5) +
  annotate_balance(tree, "n10", labels = c("n10+", "n10-"))

# Boxplots of balance values
df_long <- convert_to_long(gp.philr, colData(tse)$GroupVariable)
ggplot(df_long, aes(x = labels, y = value)) + 
  geom_boxplot() + 
  facet_wrap(~coord, scales = "free")
```

## Tips for Success

- **Taxa Weighting**: `part.weights = 'enorm.x.gm.counts'` is recommended to down-weight low-abundance taxa.
- **ILR Weighting**: `ilr.weights = 'blw.sqrt'` weights balances by the branch lengths of the tree, accounting for evolutionary distance.
- **Node Naming**: Always name your internal nodes (e.g., `tree <- makeNodeLabel(tree, prefix='n')`) before transformation to ensure coordinates in the output matrix are identifiable.
- **Zero Handling**: PhILR cannot handle zeros. Always apply a pseudocount or a multiplicative replacement method before transformation.

## Reference documentation

- [Introduction to PhILR](./references/philr-intro.Rmd)
- [Introduction to PhILR (Markdown)](./references/philr-intro.md)