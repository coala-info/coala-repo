---
name: bioconductor-rtreemix
description: This tool models evolutionary pathways of genetic changes using mutagenetic trees mixture models. Use when user asks to fit mixture models to cross-sectional binary data, simulate genetic progression, calculate pattern likelihoods, or estimate Genetic Progression Scores.
homepage: https://bioconductor.org/packages/3.5/bioc/html/Rtreemix.html
---

# bioconductor-rtreemix

name: bioconductor-rtreemix
description: Modeling multiple paths of ordered accumulation of genetic changes using mutagenetic trees mixture models. Use this skill to learn mixture models from cross-sectional binary data, simulate genetic progression, calculate likelihoods, and estimate Genetic Progression Scores (GPS) for diseases like HIV or cancer.

# bioconductor-rtreemix

## Overview
The `Rtreemix` package provides an interface for estimating mutagenetic trees mixture models from cross-sectional data. These models represent evolutionary pathways of permanent genetic changes (e.g., mutations in viral genomes or chromosomal aberrations in tumors). The package allows for model fitting, simulation, likelihood calculation, and the derivation of a Genetic Progression Score (GPS) to estimate disease stages.

## Core Workflows

### 1. Data Preparation
Data must be represented as an `RtreemixData` object, typically consisting of a binary matrix where rows are patients and columns are genetic events (1 = event occurred, 0 = not occurred).

```r
library(Rtreemix)

# Create from a binary matrix
bin.mat <- matrix(c(1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0), ncol = 3)
toy.data <- new("RtreemixData", Sample = bin.mat)

# Load built-in data
data(hiv.data)

# Inspect data
Sample(hiv.data)   # Patient profiles
Events(hiv.data)   # Event names
sampleSize(hiv.data)
```

### 2. Learning Mixture Models
Use the `fit` function to estimate a mixture model with $K$ components.

```r
# Fit a 2-tree mixture model
# noise = TRUE assumes the first component is a star (noise) model
mod <- fit(data = hiv.data, K = 2, equal.edgeweights = TRUE, noise = TRUE)

# Inspect model
Weights(mod)       # Mixture parameters (weights of components)
numTrees(mod)      # Number of tree components
Star(mod)          # Check if noise component is present
```

### 3. Visualization and Inspection
Models are represented as `graphNEL` objects.

```r
# Plot a specific tree component (e.g., the 2nd tree)
plot(mod, k = 2, fontSize = 14)

# Get conditional probabilities (edge weights)
tree2 <- getTree(object = mod, k = 2)
edgeData(tree2, attr = "weight")
```

### 4. Likelihoods and Responsibilities
Calculate how well the model explains specific patterns.

```r
# Calculate log and weighted likelihoods
mod.stat <- likelihoods(model = mod, data = hiv.data)

LogLikelihoods(mod.stat)
getResp(mod.stat) # Responsibilities of each component for each pattern
```

### 5. Simulation
Generate new data from a learned or random model.

```r
# Simulate 300 patterns from a model
sim.data <- sim(model = mod, no.draws = 300)

# Generate a random model for testing
rand.mod <- generate(K = 3, no.events = 9, noise.tree = TRUE, prob = c(0.2, 0.8))
```

### 6. Genetic Progression Score (GPS)
The GPS estimates the stage of disease progression based on waiting time simulations.

```r
# Calculate GPS for a dataset given a model
# sampling mode can be "constant" or "exponential"
gps.results <- gps(model = mod, data = hiv.data, sampling.mode = "exponential")

# Access GPS values
# (Note: Detailed GPS analysis often requires the ExtendedVignette)
```

## Tips and Best Practices
- **Noise Component**: In mixture models with $K \ge 2$, the first component ($T_1$) is conventionally the "noise" or "star" component, representing random event occurrences.
- **Model Selection**: If the number of components $K$ is unknown, stability analysis or cross-validation (often involving bootstrap analysis) is recommended to determine the optimal $K$.
- **Edge Weights**: Edge weights in the trees represent the conditional probability of an event occurring given that its parent event has already occurred.

## Reference documentation
- [Rtreemix](./references/Rtreemix.md)