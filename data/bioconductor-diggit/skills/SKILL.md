---
name: bioconductor-diggit
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/diggit.html
---

# bioconductor-diggit

name: bioconductor-diggit
description: Driver-gene Inference by Genetical-Genomic Information Theory (DIGGIT). Use this skill to identify genetic variants (like CNVs) that drive cellular phenotypes by analyzing regulatory networks upstream of Master Regulators. It supports functional CNV inference, Master Regulator Analysis (MARINA), and activity Quantitative Trait Loci (aQTL) mapping.

## Overview
The `diggit` package implements the DIGGIT algorithm to systematically identify causal genetic determinants of disease. It works by exploring regulatory and signaling networks upstream of Master Regulator (MR) genes. This approach reduces the hypothesis testing space and provides mechanistic insights into how genetic alterations drive specific cellular states or phenotypes.

## Core Workflow

### 1. Initialization
Create a `diggit` class object to store expression data, copy number variation (CNV) data, and regulatory networks (ARACNe/MINDy).

```r
library(diggit)
# expset: ExpressionSet or matrix
# cnv: matrix of CNV data
# regulon: ARACNe network object
# mindy: MINDy network object (optional)
dobj <- diggitClass(expset=gbmExprs, cnv=gbmCNV, regulon=gbmTFregulon, mindy=gbmMindy)
```

### 2. Inferring Functional CNV (fCNV)
Identify CNVs significantly associated with the expression of the same gene.

```r
# Using Spearman correlation
dobj <- fCNV(dobj, method="spearman")

# Using Mutual Information (MI) - requires seed for reproducibility
set.seed(1)
dobj <- fCNV(dobj, method="mi", cores=1)

# Retrieve results
fcnv_results <- diggitFcnv(dobj)
head(dobj, 5)$fcnv
```

### 3. Master Regulator Analysis (MARINA)
Identify transcription factors (MRs) that drive the transition between two phenotypes (e.g., Mesenchymal vs Proneural subtypes).

```r
dobj <- marina(dobj, pheno="subtype", group1="MES", group2="PN", cores=1)
head(dobj, 5)$mr
```

### 4. Activity Quantitative Trait Loci (aQTL)
Identify fCNVs predictive of MR activity. This step uses the VIPER algorithm internally to infer protein activity from the expression of its targets.

```r
# Map CNVs to the activity of specific MRs
dobj <- aqtl(dobj, mr=c("CEBPD", "STAT3"), method="mi", cores=1)

# Optional: Restrict to MINDy-inferred upstream modulators to increase power
dobj <- aqtl(dobj, mr=c("CEBPD", "STAT3"), method="mi", mindy=TRUE)
```

### 5. Conditional Association Analysis
Assess if a CNV's association with a phenotype is independent or merely due to physical proximity (linkage) to another driver.

```r
# Discretize CNV data using a threshold (e.g., from normal samples)
cnvthr <- quantile(as.vector(gbmCNVnormal), c(.025, .975), na.rm=TRUE)

dobj <- conditional(dobj, pheno="subtype", group1="MES", group2="PN", 
                    mr="STAT3", cnv=cnvthr)

# Visualize and summarize
plot(dobj, "STAT3")
summary(dobj)
```

## Tips and Best Practices
- **Data Alignment**: Ensure that the row names (genes) and column names (samples) in your expression and CNV matrices overlap significantly before initializing the `diggit` object.
- **Parallelization**: Many functions (`fCNV`, `marina`, `aqtl`) support a `cores` argument. Use multiple cores to speed up Mutual Information permutations.
- **Reproducibility**: Always set a seed (`set.seed()`) before running MI-based functions, as they involve stochastic permutation steps.
- **Thresholding**: For conditional analysis, use normal tissue samples to define the background noise for CNV discretization.

## Reference documentation
- [Using DIGGIT, a package for Infering Genetic Variants Driving Cellular Phenotypes](./references/diggit.md)