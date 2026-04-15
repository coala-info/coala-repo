---
name: bioconductor-trigger
description: This tool performs statistical analysis of integrative genomic data to identify causal regulatory relationships between genotypes and high-dimensional traits. Use when user asks to perform eQTL mapping, identify eQTL hotspots, analyze epistasis, or construct gene regulatory networks using causal inference.
homepage: https://bioconductor.org/packages/3.6/bioc/html/trigger.html
---

# bioconductor-trigger

name: bioconductor-trigger
description: Statistical analysis of integrative genomic data, including eQTL mapping, epistasis analysis, and gene regulatory network construction. Use this skill when analyzing datasets containing both genotypes (markers) and high-dimensional traits (e.g., gene expression) to identify causal regulatory relationships, eQTL hotspots, or multi-locus interactions.

# bioconductor-trigger

## Overview

The `trigger` package provides tools for integrative genomic analysis. It is designed to link genetic variation (genotypes) to intermediate traits (gene expression) and higher-order phenotypes. Its primary strength lies in the "Trigger" algorithm, which uses causal inference to construct directed gene regulatory networks and identify causal genes for specific traits.

## Core Workflow

### 1. Data Preparation
The package requires four specific matrices: marker genotypes, trait expression (e.g., mRNA), marker positions, and trait positions.

```R
library(trigger)
data(yeast) # Example dataset

# Build the trigger object
trig.obj <- trigger.build(marker = yeast$marker, 
                          exp = yeast$exp,
                          marker.pos = yeast$marker.pos, 
                          exp.pos = yeast$exp.pos)
```

### 2. Genome-wide eQTL Analysis
Compute pairwise likelihood ratio statistics for every gene-marker pair.

```R
# Compute linkage statistics
trig.obj <- trigger.link(trig.obj, norm = TRUE)

# Plot the eQTL map
plot(trig.obj, type = "link", cutoff = 1e-5)
```

### 3. Multi-locus Linkage (Epistasis)
Identify pairs of loci that interact to affect gene expression.

```R
# Requires local linkage calculation first
trig.obj <- trigger.loclink(trig.obj, window.size = 30000)
trig.obj <- trigger.mlink(trig.obj, B = 10)

# Visualize epistatic interactions
plot(trig.obj, type = "mlink", qcut = 0.1)
```

### 4. Identifying eQTL Hotspots (eigenR2)
Quantify the proportion of genome-wide variation explained by each locus.

```R
trig.obj <- trigger.eigenR2(trig.obj, adjust = TRUE)
plot(trig.obj, type = "eigenR2")
```

### 5. Causal Network Construction
The "Trigger" algorithm estimates the posterior probability that gene A causes gene B based on three conditions: local linkage of A, secondary linkage of B to A's locus, and conditional independence.

```R
# 1. Compute local linkage probabilities
trig.obj <- trigger.loclink(trig.obj, window.size = 10000)

# 2. Estimate pairwise regulatory probabilities
trig.prob <- trigger.net(trig.obj, Bsec = 100)

# 3. Visualize the network (requires Graphviz)
trigger.netPlot2ps(trig.obj, trig.prob, pcut = 0.95, filenam = "my_network")
```

### 6. Trait-Trigger Analysis
Identify causal genes for a specific quantitative trait (e.g., a clinical phenotype or a specific gene's expression).

```R
# Convert to cross format (requires 'qtl' package)
cross_data <- trigger.export2cross(trig.obj)

# Identify causal regulators for a trait (e.g., "DSE1")
causreg <- trigger.trait(trig.obj, trait = "DSE1", cross = cross_data, addplot = TRUE)
```

## Key Functions Reference

- `trigger.build`: Initializes the S4 object.
- `trigger.link`: Performs standard eQTL mapping.
- `trigger.loclink`: Finds the best local marker for each gene (cis-eQTL).
- `trigger.net`: Main function for causal probability estimation between genes.
- `trigger.eigenR2`: Identifies master regulators/hotspots.
- `trigger.trait`: Maps causal genes to a specific phenotype.

## Tips for Success

- **Chromosome Naming**: Ensure autosomal chromosomes are integers and sex chromosomes are labeled "X".
- **Units**: Use consistent units (bp, kb, or cM) for both marker and gene positions.
- **Network Files**: `trigger.net` writes a temporary file `net_trigg_prob.txt` to the working directory. Delete this file before re-running an analysis to avoid appending data.
- **Normalization**: Use `norm = TRUE` in `trigger.link` to rank-normalize expression data to a standard normal distribution, which makes parametric p-values more robust.

## Reference documentation
- [trigger](./references/trigger.md)