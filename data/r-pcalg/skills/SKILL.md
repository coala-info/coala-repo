---
name: r-pcalg
description: This tool provides algorithms for causal structure learning and causal inference using the pcalg R package. Use when user asks to estimate causal graphs like CPDAGs or PAGs, perform structure learning with PC or FCI algorithms, or estimate causal effects using IDA and covariate adjustment.
homepage: https://cran.r-project.org/web/packages/pcalg/index.html
---

# r-pcalg

name: r-pcalg
description: Expert guidance for causal structure learning and causal inference using the pcalg R package. Use this skill when you need to estimate Directed Acyclic Graphs (DAGs), Completed Partially Directed Acyclic Graphs (CPDAGs), or Partial Ancestral Graphs (PAGs) from observational or interventional data. It supports algorithms like PC, FCI, GES, GIES, and IDA for causal effect estimation and covariate adjustment.

## Overview

The `pcalg` package provides a comprehensive suite of algorithms for causal discovery and inference. It is designed to handle various data types (Gaussian, discrete, binary) and scenarios (with or without hidden variables, observational or interventional data).

## Installation

```R
install.packages("pcalg")
# Note: Some visualization features require Bioconductor packages
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("graph", "RBGL", "Rgraphviz"))
```

## Core Workflows

### 1. Structure Learning (Constraint-Based)

Use the PC algorithm for data without hidden variables, or FCI/RFCI for data where latent confounders may exist.

```R
library(pcalg)
data(gmG8)
# 1. Define sufficient statistics
suffStat <- list(C = cor(gmG8$x), n = nrow(gmG8$x))

# 2. Run PC Algorithm (Estimates CPDAG)
pc.fit <- pc(suffStat, indepTest = gaussCItest, alpha = 0.01, labels = gmG8$g@nodes)

# 3. Run FCI Algorithm (Estimates PAG - allows hidden variables)
fci.fit <- fci(suffStat, indepTest = gaussCItest, alpha = 0.01, labels = gmG8$g@nodes)

# Plotting
plot(pc.fit)
```

### 2. Structure Learning (Score-Based)

Use GES for observational data or GIES for a mix of observational and interventional data.

```R
# GES for observational data
score <- new("GaussL0penObsScore", gmG8$x)
ges.fit <- ges(score)

# GIES for interventional data
# targets: list of intervened nodes for each setting
# target.index: vector mapping each row to a target setting
score.int <- new("GaussL0penIntScore", data = gmInt$x, 
                 targets = gmInt$targets, target.index = gmInt$target.index)
gies.fit <- gies(score.int)
```

### 3. Causal Effect Estimation (IDA)

Estimate the multiset of possible total causal effects of X on Y when the true DAG is unknown but a CPDAG is available.

```R
# Estimate effects of node 2 on node 5
# mcov is the covariance matrix
effs <- ida(2, 5, cov(gmG8$x), pc.fit@graph, method = "local", type = "cpdag")
# Result is a vector of possible causal effects
```

### 4. Covariate Adjustment

Check if a set of variables Z satisfies the Generalized Adjustment Criterion (GAC).

```R
# Check if nodes {2, 4} satisfy GAC for effect of 3 on 6
# m1 is an adjacency matrix
res <- gac(m1, x = 3, y = 6, z = c(2, 4), type = "cpdag")
res$gac # TRUE or FALSE
```

## Key Functions Reference

| Function | Purpose | Assumptions |
| :--- | :--- | :--- |
| `pc()` | Estimate CPDAG | No hidden variables, Faithfulness |
| `fci()` / `rfci()` | Estimate PAG | Allows hidden variables |
| `ges()` | Score-based discovery | No hidden variables, BIC-style score |
| `gies()` | Interventional discovery | Mix of obs/int data |
| `ida()` | Causal effect bounds | Gaussian data, no hidden variables |
| `gac()` | Adjustment criterion | Works on DAG, CPDAG, MAG, PAG |
| `addBgKnowledge()` | Add edge orientations | Incorporate prior knowledge into PDAG |

## Tips for Success

- **Independence Tests**: Ensure the `indepTest` matches your data type (e.g., `gaussCItest` for Gaussian, `disCItest` for discrete, `binCItest` for binary).
- **Alpha Selection**: The `alpha` parameter is the significance level for individual tests. In high-dimensional settings, smaller values (0.01 or 0.05) are standard.
- **Adjacency Matrices**: `pcalg` uses specific coding for adjacency matrices (`amat.cpdag` and `amat.pag`). Use `as(obj, "amat")` to extract them correctly.
- **Order Independence**: Use `method = "stable"` in `pc()` to ensure the result doesn't change based on the order of variables in your dataframe.

## Reference documentation
- [An Overview of the pcalg Package for R](./references/vignette2018.md)