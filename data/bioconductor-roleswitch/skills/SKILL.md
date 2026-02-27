---
name: bioconductor-roleswitch
description: Bioconductor-roleswitch infers miRNA-mRNA interaction probabilities from paired expression data of a single sample by accounting for competition and total transcription levels. Use when user asks to infer miRNA targets, calculate Probabilities of MiRNA-mRNA Interaction Signature (ProMISe), or model miRNA-mRNA competition in single samples.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Roleswitch.html
---


# bioconductor-roleswitch

name: bioconductor-roleswitch
description: Infer miRNA-mRNA interactions using paired expression data from a single sample. Use this skill when you need to calculate Probabilities of MiRNA-mRNA Interaction Signature (ProMISe) by accounting for mRNA/miRNA competition and total transcription levels.

## Overview

Roleswitch is a Bioconductor package designed to infer the probability that an mRNA is a target of a specific miRNA using expression data from a single sample. Unlike methods that require large cohorts, Roleswitch uses a probabilistic model that accounts for the competition between multiple mRNAs for the same miRNA and vice versa. It iteratively updates the estimated total transcription levels of mRNAs to account for miRNA-mediated repression.

## Core Workflow

### 1. Data Preparation
Roleswitch requires three inputs:
- **mRNA expression**: A vector or matrix (N mRNAs x 1 sample).
- **miRNA expression**: A vector or matrix (M miRNAs x 1 sample).
- **Seed match matrix**: An N x M matrix containing the number of target sites for each mRNA-miRNA pair.

Note: Expression values must be non-negative. Use linear transformation or rescaling if the data contains negative values.

```R
library(Roleswitch)

# Ensure non-negative expression
if(any(x < 0)) x <- rescale(as.matrix(x), to = c(0, max(x)))
if(any(z < 0)) z <- rescale(as.matrix(z), to = c(0, max(z)))
```

### 2. Obtaining the Seed Match Matrix
If you do not have a pre-calculated seed match matrix, use `getSeedMatrix` to retrieve target site information for human or mouse.

```R
# Retrieve human seed match matrix
seedMatrix <- getSeedMatrix(species = "human")

# Align expression data with the seed matrix
common_mRNAs <- intersect(rownames(x), rownames(seedMatrix))
common_miRNAs <- intersect(rownames(z), colnames(seedMatrix))

x_filtered <- x[common_mRNAs, , drop = FALSE]
z_filtered <- z[common_miRNAs, , drop = FALSE]
seed_filtered <- seedMatrix[common_mRNAs, common_miRNAs]
```

### 3. Running Roleswitch
The `roleswitch()` function executes the iterative inference algorithm.

```R
# Run inference
rs.pred <- roleswitch(x_filtered, z_filtered, seed_filtered)

# The output is a list containing:
# rs.pred$p.xz  : The joint probability matrix (ProMISe)
# rs.pred$p.x   : Probability of mRNA being targeted by miRNA
# rs.pred$p.z   : Probability of miRNA being "targeted" by mRNA
# rs.pred$x.t   : Estimated total mRNA transcription levels
```

### 4. Visualization and Diagnostics
Use `diagnosticPlot` to visualize the input expression, seed matches, and the convergence of the model.

```R
diagnosticPlot(rs.pred)
```

## Working with ExpressionSets
Roleswitch can accept `ExpressionSet` objects for mRNA data. It will automatically attempt to map probe IDs to gene symbols if an annotation database is provided.

```R
# Example with ExpressionSet
# rs <- roleswitch(eset_object, mirna_matrix)
```

## Key Tips
- **Single Sample**: The algorithm is specifically optimized for single-sample analysis. If you have multiple samples, run the function for each sample individually or use the average expression.
- **Convergence**: The model typically converges within 10 iterations. You can monitor this in the `error` component of the output.
- **ProMISe**: The joint probability matrix (`p.xz`) is generally the most robust metric for identifying functional interactions as it combines both mRNA and miRNA competition effects.

## Reference documentation
- [Roleswitch](./references/Roleswitch.md)