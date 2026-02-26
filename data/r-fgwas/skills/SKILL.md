---
name: r-fgwas
description: The r-fgwas package performs genome-wide association analysis for longitudinal phenotypes using functional mapping models to identify relationships between genes and dynamic trait trajectories. Use when user asks to perform a longitudinal GWAS, scan SNPs for time-varying genetic effects, simulate synthetic growth curve data, or visualize genetic effect curves.
homepage: https://cran.r-project.org/web/packages/fgwas/index.html
---


# r-fgwas

## Overview
The `fgwas` package is designed for genome-wide association analysis where the phenotype is longitudinal (measured over time). It implements functional mapping models to identify the relationship between genes and the dynamic trajectory of traits. It supports loading genotype data from PLINK or tables, handling longitudinal phenotype data with covariates, and visualizing genetic effect curves.

## Installation
The package can be installed from GitHub using `devtools`:

```R
# Install dependencies first
install.packages(c("minpack.lm", "mvtnorm", "parallel"))
# Bioconductor dependency
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("snpStats")

# Install fgwas
library(devtools)
install_github("wzhy2000/fGWAS/pkg")
```

## Core Workflow

### 1. Data Preparation
The package works with genotype and phenotype objects. You can load your own data or simulate datasets for testing.

```R
library(fGWAS)

# Simulation example: 2000 SNPs, 500 samples, 7 time points
# Growth curve: Logistic; Covariance structure: AR1
r <- fg.simulate(curve.model="Logistic", cov.model="AR1", 
                 n.snp=2000, n.ind=500, times=1:7, sig.pos=250)

# Access objects
genotype_obj <- r$obj.gen
phenotype_obj <- r$obj.phe
```

### 2. SNP Scanning
Use `fg.snpscan` to perform the association analysis. This calculates log-likelihood ratios and genetic effects.

```R
# Scan a specific range of SNPs
obj.scan <- fg.snpscan(genotype_obj, phenotype_obj, 
                       method="fgwas", 
                       snp.sub=c(245:255))

# View summary results
print(obj.scan)
```

### 3. Visualization and Selection
Identify significant SNPs and visualize how their genetic effects change over time.

```R
# Plot Manhattan figure
plot(obj.scan, file.pdf="manhattan_plot.pdf")

# Select significant SNPs using Bonferroni correction
tb.sig <- fg.select.sigsnp(obj.scan, sig.level=0.001, pv.adjust = "bonferroni")

# Plot the varying genetic effect curves for significant SNPs
if(nrow(tb.sig) > 0) {
  plot.fgwas.curve(obj.scan, tb.sig$INDEX, file.pdf="genetic_effects.pdf")
}
```

## Key Functions
- `fg.simulate()`: Generates synthetic longitudinal GWAS data.
- `fg.snpscan()`: The primary engine for scanning SNPs using functional mapping.
- `fg.select.sigsnp()`: Filters scan results based on p-value thresholds and adjustment methods.
- `plot.fgwas.curve()`: Generates time-varying curves for additive and dominance effects.

## Tips
- **Memory Management**: For large-scale GWAS, use the `snp.sub` parameter in `fg.snpscan` to process the genome in chunks.
- **Model Selection**: Ensure the `curve.model` (e.g., "Logistic") and `cov.model` (e.g., "AR1", "CS", or "Antedependence") match the biological assumptions of your trait's growth and correlation structure.

## Reference documentation
- [fGWAS README](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)