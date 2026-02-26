---
name: bioconductor-alphabeta
description: This tool estimates epimutation rates and spectra from high-throughput DNA methylation data using pedigree-based models. Use when user asks to calculate methylation gain and loss rates, estimate selection coefficients, or analyze methylome divergence in mutation accumulation lines and clonal lineages.
homepage: https://bioconductor.org/packages/release/bioc/html/AlphaBeta.html
---


# bioconductor-alphabeta

name: bioconductor-alphabeta
description: Computational method for estimating epimutation rates and spectra from high-throughput DNA methylation data. Use when analyzing "germline" epimutations in mutation accumulation (MA) lines or "somatic" epimutations in long-lived perennials (trees) to calculate methylation gain/loss rates and selection coefficients.

# bioconductor-alphabeta

## Overview

AlphaBeta is an R package designed to estimate epimutation rates (the rate at which cytosine methylation states change) using pedigree-based DNA methylation data. It supports two primary experimental contexts:
1. **Selfing/Sexual Systems**: Mutation accumulation (MA) lines derived from a common founder.
2. **Somatic/Clonal Systems**: Branching structures in trees or clonally propagated lineages.

The package fits various mathematical models (neutral vs. selection) to observed methylome divergence across generations or time to infer the rates of spontaneous methylation gain ($\alpha$) and loss ($\beta$).

## Workflow

### 1. Input Preparation

AlphaBeta requires two pedigree-defining files and methylome data files.

**Pedigree Files:**
- **Nodelist**: Defines nodes (sampled $S^*$ and unsampled $S$), generation/time, and whether methylome data exists.
- **Edgelist**: Defines ancestral relationships (from/to) and optionally generation differences.

**Methylome Files:**
Expected in `methimpute` format (tab-delimited).
- Required columns: `seqnames`, `start`, `strand`, `context` (CG, CHG, or CHH), `status` (0=unmethylated, 1=methylated), and `posteriorMax`.
- For non-methimpute data: Set `posteriorMax = 1` and `rc.meth.lvl = methylated_counts / total_counts`.

### 2. Building the Pedigree

Use `buildPedigree` to calculate the divergence time ($\Delta t$) and methylome divergence ($D$) between all pairs of samples.

```r
library(AlphaBeta)

# For MA-lines
output <- buildPedigree(nodelist = "nodelist.fn", 
                        edgelist = "edgelist.fn", 
                        cytosine = "CG", 
                        posteriorMaxFilter = 0.99)

# Access divergence data
pedigree_data <- output$Pdata
initial_unmethylated_prop <- output$tmpp0
```

### 3. Visualization and Diagnostics

Verify the pedigree topology and inspect for outliers.

```r
# Plot the pedigree structure
plotPedigree(nodelist = "nodelist.fn", 
             edgelist = "edgelist.fn", 
             sampling.design = "progenitor.endpoint") # or "tree", "sibling"

# Plot Divergence vs Delta.t
dt <- pedigree_data[,2] + pedigree_data[,3] - 2*pedigree_data[,1]
plot(dt, pedigree_data[,"D.value"], xlab="Delta T", ylab="Divergence")
```

### 4. Model Fitting

#### Selfing Systems (MA-lines)
- `ABneutral`: Assumes no selection.
- `ABselectMM`: Selection against gain of methylation.
- `ABselectUU`: Selection against loss of methylation.
- `ABnull`: Null model (no accumulation).

```r
# Fit neutral model
fit_neutral <- ABneutral(pedigree.data = pedigree_data, 
                         p0uu = initial_unmethylated_prop, 
                         Nstarts = 50, 
                         out.dir = getwd(), 
                         out.name = "neutral_model")
```

#### Somatic/Clonal Systems (Trees)
- `ABneutralSOMA`: Neutral somatic epimutations.
- `ABselectMMSOMA`: Selection against somatic methylation gain.
- `ABselectUUSOMA`: Selection against somatic methylation loss.

```r
fit_soma <- ABneutralSOMA(pedigree.data = pedigree_data, 
                          p0uu = initial_unmethylated_prop, 
                          Nstarts = 50, 
                          out.dir = getwd(), 
                          out.name = "soma_model")
```

### 5. Model Comparison and Bootstrapping

Use an F-test to determine if selection models fit significantly better than the neutral model.

```r
# Compare Neutral vs Null
comparison <- FtestRSS(pedigree.select = "neutral_model.Rdata", 
                       pedigree.null = "null_model.Rdata")
print(comparison$Ftest)

# Estimate confidence intervals via bootstrapping
boot_results <- BOOTmodel(pedigree.data = "neutral_model.Rdata", 
                          Nboot = 100, 
                          out.dir = getwd(), 
                          out.name = "boot_results")
```

### 6. Plotting Results

Visualize the model fit against the observed data.

```r
ABplot(pedigree.names = "neutral_model.Rdata", 
       output.dir = getwd(), 
       out.name = "fit_plot")
```

## Tips for Success
- **Nstarts**: For final results, use `Nstarts = 50` or higher to ensure the optimization reaches the global maximum.
- **Filtering**: Use `posteriorMaxFilter` (e.g., 0.99) in `buildPedigree` to ensure only high-confidence methylation calls are used.
- **Context**: Epimutation rates vary significantly by context (CG, CHG, CHH). Run separate analyses for each.
- **Tree Data**: For trees with multiple stems, ensure the `stem` column is correctly populated in the `edgelist`.

## Reference documentation
- [AlphaBeta](./references/AlphaBeta.md)