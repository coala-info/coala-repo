---
name: bioconductor-joda
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/joda.html
---

# bioconductor-joda

name: bioconductor-joda
description: Quantify gene deregulation between two cell populations using regulator knockdown data and pathway knowledge. Use this skill when analyzing how the regulatory influence of specific factors (e.g., transcription factors) on target genes changes across different biological conditions (e.g., healthy vs. damaged cells).

# bioconductor-joda

## Overview

The `joda` package implements the JODA (Joint Optimization of Differential Analysis) algorithm. It is designed to quantify changes in gene regulation between two distinct cell populations. The algorithm integrates regulator knockdown expression data with prior knowledge of signaling pathway topologies and regulator-gene relationships.

The workflow produces **deregulation scores**, which indicate how much more (or less) a regulator activates or represses a gene in one condition compared to another.

## Typical Workflow

### 1. Data Preparation
The algorithm requires three main inputs for each cell population (e.g., "healthy" and "damage"):
- **Expression Data**: Log expression ratios of regulator knockdowns vs. controls.
- **Pathway Models**: Binary matrices where rows/columns represent regulators. A `1` at `model[i, j]` indicates that knockdown of regulator `j` affects regulator `i`.
- **Beliefs (Optional)**: Probabilities representing prior knowledge of regulator-gene targets.

```r
library(joda)
data(damage) # Example dataset

# data.healthy and data.damage are data frames of expression ratios
# model.healthy and model.damage are binary matrices
# beliefs.healthy and beliefs.damage are lists of prior probabilities
```

### 2. Step 1: Compute Differential Expression Probabilities
Use `differential.probs` to estimate the probability that genes are differentially expressed in each knockdown experiment. This uses mixture modeling (unsupervised or belief-based).

```r
# For healthy cells
probs.healthy <- differential.probs(data = data.healthy, 
                                    beliefs = beliefs.healthy, 
                                    verbose = TRUE, 
                                    plot.it = TRUE)

# For damaged cells
probs.damage <- differential.probs(data = data.damage, 
                                   beliefs = beliefs.damage, 
                                   verbose = TRUE, 
                                   plot.it = TRUE)
```

### 3. Step 2: Compute Regulation Scores
Use `regulation.scores` to aggregate probabilities across experiments based on the pathway model. This quantifies the effect of a regulator on genes within a specific population.

```r
reg.healthy <- regulation.scores(probs.healthy, model.healthy, verbose = TRUE)
reg.damage <- regulation.scores(probs.damage, model.damage, verbose = TRUE)
```

### 4. Step 3: Compute Deregulation Scores
Use `deregulation.scores` to calculate the difference in regulation between the two populations.

```r
# Subtracts reg.scores1 from reg.scores2
dereg <- deregulation.scores(reg.scores1 = reg.healthy, 
                             reg.scores2 = reg.damage, 
                             verbose = TRUE)
```

## Interpreting Results

Deregulation scores represent the shift in regulatory activity:
- **Negative Scores**: The gene is more activated (or less repressed) by the regulator in the **second** population (e.g., damaged cells).
- **Positive Scores**: The gene is more activated (or less repressed) by the regulator in the **first** population (e.g., healthy cells).

To find the top genes most activated by a specific regulator (e.g., "p53") in the second condition:
```r
top_genes <- rownames(dereg)[order(dereg[, "p53"])]
head(top_genes)
```

## Reference documentation

- [joda Package Vignette](./references/JodaVignette.md)