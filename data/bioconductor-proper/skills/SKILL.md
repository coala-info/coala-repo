---
name: bioconductor-proper
description: This tool performs simulation-based power and sample size assessments for differential expression detection in RNA-seq experiments. Use when user asks to perform power analysis, determine the number of replicates needed, or evaluate the impact of sequencing depth on differential expression detection.
homepage: https://bioconductor.org/packages/release/bioc/html/PROPER.html
---


# bioconductor-proper

name: bioconductor-proper
description: Prospective Power Evaluation for RNA-seq (PROPER). Use this skill to perform simulation-based power and sample size assessments for differential expression (DE) detection in two-group RNA-seq experiments. This skill helps determine the number of replicates needed, evaluate the impact of sequencing depth, and estimate targeted power for biologically interesting genes.

## Overview

PROPER provides a simulation-based framework to assess the relationship between power and sample size in RNA-seq studies. It addresses the complexities of multiple testing (FDR), varying coverage depths, and the specific DE detection algorithms (like edgeR, DESeq, or DSS) by simulating count data from a negative binomial model and evaluating detection performance across multiple iterations.

## Core Workflow

### 1. Set Simulation Options
Define the experimental scenario using `RNAseq.SimOptions.2grp`. You can use parameters derived from built-in datasets to represent different biological variation levels:
- `cheung`: High variation (unrelated individuals).
- `gilad`: Moderate variation (human liver).
- `bottomly`: Low variation (inbred mice).
- `MAQC`: Minimal variation (technical replicates).

```r
library(PROPER)
# Example: 20k genes, 5% DE, based on Bottomly (low dispersion)
sim.opts = RNAseq.SimOptions.2grp(ngenes = 20000, p.DE = 0.05, 
                                 lOD = "bottomly", lBaselineExpr = "bottomly")
```

### 2. Run Simulations
Execute the simulation and DE detection using `runSims`. This is the most computationally intensive step.
- `Nreps`: A vector of sample sizes to evaluate (e.g., `c(3, 5, 10)`).
- `DEmethod`: The tool to use (`"edgeR"`, `"DESeq"`, or `"DSS"`).
- `nsims`: Number of iterations (at least 20 recommended for stability).

```r
simres = runSims(Nreps = c(3, 5, 7, 10), sim.opts = sim.opts, 
                 DEmethod = "edgeR", nsims = 20)
```

### 3. Evaluate Power
Analyze the simulation results with `comparePower`. You can define "biologically interesting" genes using the `delta` parameter (log fold change threshold).

```r
# Evaluate power for genes with log fold change > 0.5 and FDR < 0.1
powers = comparePower(simres, alpha.type = "fdr", alpha.nominal = 0.1, 
                      stratify.by = "expr", delta = 0.5)
```

## Analysis and Visualization

### Summary Tables
- `summaryPower(powers)`: Provides a table of marginal power, actual FDR, true discoveries (TD), and false discovery cost (FDC) for each sample size.
- `power.seqDepth(simres, powers)`: Compares the benefit of increasing sequencing depth versus increasing sample size.

### Plotting Functions
- `plotPower(powers)`: Plots stratified power (usually by expression level).
- `plotPowerTD(powers)`: Plots the number of true discoveries.
- `plotFDcost(powers)`: Plots the false discovery cost.
- `plotAll(powers)`: Generates a multi-panel figure containing all standard power plots.

## Advanced Usage

### Targeted Power
Instead of calculating power for all DE genes, use `target.by = "effectsize"` and `delta` to focus on genes where the log fold change is large relative to the biological coefficient of variation (BCV).

### Filtering
To simulate the effect of removing low-count genes (which can improve power by reducing the multiple testing burden), use the `filter.by` and `strata.filtered` arguments in `comparePower`.

```r
# Filter out the first stratum (lowest counts)
powers_filtered = comparePower(simres, filter.by = "expr", strata.filtered = 1)
```

### Resampling from Pilot Data
If you have pilot data, you can set effect sizes by resampling rather than using parametric assumptions by providing a data frame of mean expressions (e.g., `data(pbmc)`).

## Reference documentation

- [PROPER: PROspective Power Evaluation for RNAseq](./references/PROPER.md)