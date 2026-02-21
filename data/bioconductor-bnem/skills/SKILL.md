---
name: bioconductor-bnem
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/bnem.html
---

# bioconductor-bnem

name: bioconductor-bnem
description: Infer signaling pathways from indirect measurements (transcriptional targets) using Boolean Nested Effects Models (B-NEM). Use this skill when you need to reconstruct Boolean logic gates (AND/OR) in signaling networks based on differential gene expression data from perturbation experiments (stimuli and inhibitors).

## Overview

The `bnem` package extends Nested Effects Models (NEM) by incorporating Boolean logic. It uses high-dimensional downstream data (E-genes, like mRNA expression) to infer the logical structure of a signaling pathway (S-genes). It is particularly useful for determining if two signaling components act redundantly (OR-gate) or synergistically (AND-gate).

## Core Workflow

### 1. Data Preparation
B-NEM requires two primary inputs:
- **Differential Expression Data**: A matrix of fold changes (or similar) where rows are E-genes and columns are experimental conditions.
- **Prior Knowledge Network (PKN)**: A SIF file or matrix defining potential interactions between S-genes.

```r
library(bnem)
library(CellNOptR)

# Load your data (example using package data)
data(bcr)
fc <- bcr$fc # Fold changes
```

### 2. Defining the Search Space
You must define the experimental setup using a `CNOlist` and preprocess the PKN into a Boolean model.

```r
# Define stimuli and inhibitors
CNOlist <- dummyCNOlist(stimuli = "BCR", 
                        inhibitors = c("Tak1", "Pi3k", "Ikk2"),
                        maxStim = 1, maxInhibit = 3)

# Preprocess PKN (sif file) into a Boolean model
# PKN <- readSIF("pathway.sif")
model <- preprocessing(CNOlist, PKN)
```

### 3. Network Inference
The `bnem` function performs the search for the optimal Boolean network.

```r
# Initialize with an empty string (all edges 0)
initBstring <- rep(0, length(model$reacID))

# Run greedy search
result <- bnem(search = "greedy",
               fc = fc,
               CNOlist = CNOlist,
               model = model,
               initBstring = initBstring,
               method = "cosine") # "s" for rank correlation, "cosine" for similarity
```

### 4. Visualization and Validation
Visualize the inferred hyper-graph and check how well the model fits the data.

```r
# Plot the resulting network
plotDnf(result$graph, stimuli = "BCR")

# Validate and visualize E-gene attachments
fitinfo <- validateGraph(CNOlist, fc = fc, model = model,
                         bString = result$bString,
                         Sgene = 4, Egenes = 100)
```

## Advanced Features

### Search Algorithms
- **greedy**: Fast neighborhood search (recommended for most cases).
- **genetic**: Genetic algorithm for complex search spaces.
- **exhaustive**: Checks all possible models (only for < 20 hyper-edges).

### Handling Overlapping Stimuli/Inhibitors
If a gene is both stimulated and inhibited in the dataset, B-NEM can resolve this by adding extra S-nodes. Use `simBoolGtn(..., allstim = TRUE)` for simulations or manually adjust the PKN to ensure inhibitors overrule stimuli.

### Pre-attaching E-genes
If you have prior knowledge of which E-genes belong to which S-genes, provide an `egenes` list to the `bnem` function to fix or constrain their attachment.

```r
egenes <- list(Sgene1 = c("EgeneA", "EgeneB"), Sgene2 = c("EgeneC"))
# Pass to bnem(..., egenes = egenes)
```

## Tips for Success
- **Method Selection**: Use `method = "s"` (Spearman) if your data has outliers or non-linear relationships; use `method = "cosine"` for standard fold-change data.
- **Parallelization**: For large networks, set `parallel` to the number of cores (e.g., `parallel = 4`) to speed up the greedy search.
- **Cycles**: B-NEM can resolve cycles in the signaling network, provided there is no contradictory repression that prevents a stable state.

## Reference documentation

- [Boolean Nested Effects Models](./references/bnem.md)