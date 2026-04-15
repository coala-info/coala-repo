---
name: bioconductor-dss
description: bioconductor-dss provides a statistical framework for differential analysis of count-based sequencing data using dispersion shrinkage. Use when user asks to detect differential expression in RNA-seq data or identify differentially methylated loci and regions in BS-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/DSS.html
---

# bioconductor-dss

## Overview

The `DSS` (Dispersion Shrinkage for Sequencing data) package provides a statistical framework for differential analysis of count-based sequencing data. It is primarily used for:
1. **RNA-seq**: Detecting differential expression (DE) using a Negative Binomial model with Bayesian dispersion shrinkage.
2. **BS-seq**: Detecting differential methylation (DML/DMR) using a Beta-Binomial model.

The core advantage of `DSS` is its ability to share information across features (genes or CpG sites) to provide stable variance estimates even with limited biological replicates.

## RNA-seq Differential Expression

### Two-Group Comparison
For simple designs, use the high-level wrapper or the step-by-step workflow.

```R
library(DSS)

# High-level wrapper
# counts: matrix of integers; designs: vector of 0s and 1s
result = DSS.DE(counts, designs)

# Step-by-step workflow (SeqCountSet)
seqData = newSeqCountSet(counts, designs)
seqData = estNormFactors(seqData)
seqData = estDispersion(seqData)
result = waldTest(seqData, 0, 1) # Compare group 0 vs 1
```

### Multi-factor RNA-seq
`DSS` estimates dispersions which can then be plugged into `edgeR` for complex GLM fitting.

```R
seqData = newSeqCountSet(counts, as.data.frame(design_matrix))
seqData = estNormFactors(seqData)
seqData = estDispersion(seqData)

# Use edgeR for GLM fitting with DSS dispersions
library(edgeR)
fit = glmFit(counts, design_matrix, dispersion=dispersion(seqData))
lrt = glmLRT(fit, coef=2)
```

## BS-seq Differential Methylation

### Data Preparation
Input data must be a data frame with columns: `chr`, `pos`, `N` (total reads), and `X` (methylated reads).

```R
# Create BSseq object
BSobj = makeBSseqData(list(sample1, sample2, ...), c("S1", "S2", ...))
```

### Two-Group DML/DMR Detection
1. **Test DML**: Perform the statistical test at each CpG site.
2. **Call DML**: Filter significant sites.
3. **Call DMR**: Merge significant sites into regions.

```R
# 1. Statistical Test (smoothing=TRUE is recommended for WGBS)
dmlTest = DMLtest(BSobj, group1=c("S1", "S2"), group2=c("S3", "S4"), smoothing=TRUE)

# 2. Call DML (Loci)
# delta: optional threshold for methylation difference (e.g., 0.1 for 10%)
dmls = callDML(dmlTest, p.threshold=0.001)

# 3. Call DMR (Regions)
dmrs = callDMR(dmlTest, p.threshold=0.01)

# Visualization
showOneDMR(dmrs[1,], BSobj)
```

### General Experimental Design (Multi-factor)
Uses an arcsine link function and a general linear model framework.

```R
# 1. Fit the model
# design: data.frame; formula: ~case+cell
DMLfit = DMLfit.multiFactor(BSobj, design=design, formula=~case+cell)

# 2. Test a specific coefficient or term
# coef: index or name of the column in design matrix
dmlTest = DMLtest.multiFactor(DMLfit, coef="cellrN")

# 3. Call DMR
dmrs = callDMR(dmlTest, p.threshold=0.05)
```

## Key Tips and Best Practices

- **Smoothing**: Always recommended for BS-seq (WGBS and RRBS). It allows `DSS` to estimate dispersions even without biological replicates by using neighboring sites as "pseudo-replicates."
- **Count Data**: `DSS` requires raw integer counts. Do not use normalized values (like RPKM/FPKM) or estimated methylation percentages (beta values) as primary input.
- **Parallel Computing**: For large BS-seq datasets, use the `ncores` parameter in `DMLtest` to speed up calculations (Note: Use `ncores=1` on Windows).
- **Filtering**: You do not need to pre-filter low-coverage CpG sites; the Beta-Binomial model naturally weights them based on sequencing depth.
- **Paired Designs**: Handle paired BS-seq data by including the "pair" as a factor in the `DMLfit.multiFactor` formula.

## Reference documentation
- [The DSS User's Guide](./references/DSS.md)