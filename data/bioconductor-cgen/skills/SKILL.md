---
name: bioconductor-cgen
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CGEN.html
---

# bioconductor-cgen

name: bioconductor-cgen
description: Analysis of case-control genetic association studies. Use for: (1) SNP-environment interaction analysis using Unconstrained Maximum Likelihood (UML), Constrained Maximum Likelihood (CML), and Empirical Bayes (EB) methods, (2) Matched case-control studies, (3) GWAS-scale GxE scans with PLINK/TPED support, and (4) Custom high-throughput genetic scans.

# bioconductor-cgen

## Overview

CGEN (Case-control GENetics) is an R package designed for the analysis of case-control genetic association studies. It specializes in Gene-Environment (GxE) interaction analysis. A key feature is the implementation of the Constrained Maximum Likelihood (CML) and Empirical Bayes (EB) methods, which can significantly increase statistical power by leveraging the assumption of Gene-Environment independence in the underlying population.

## Core Workflows

### 1. SNP Logistic Regression (snp.logistic)

Use `snp.logistic` for standard case-control analysis or GxE interaction testing.

```r
library(CGEN)

# Load example data
data(Xdata, package="CGEN")

# Define main effects and interaction variables
mainVars <- c("oral.years", "n.children", "age.group_1", "age.group_2")
intVars <- c("oral.years", "n.children")

# Fit the model
# strata.var is used for the CML method
fit <- snp.logistic(Xdata, "case.control", "BRCA.status",
                    main.vars=mainVars,
                    int.vars=intVars,
                    strata.var="ethnic.group")

# Extract results (UML, CML, and EB estimates)
getSummary(fit)

# Perform Wald tests for specific effects
getWaldTest(fit, c("BRCA.status", "BRCA.status:oral.years"))
```

### 2. Matched Case-Control Analysis (snp.matched)

For studies with matched sets, use `snp.matched`.

```r
# 1. Create matched sets if not already present
library(cluster)
d <- daisy(Xdata[, c("age.group_1", "gynSurgery.history")])
mx <- getMatchedSets(d, CC=TRUE, NN=TRUE, 
                     ccs.var=Xdata$case.control, 
                     strata.var=Xdata$ethnic.group, 
                     size=4)

Xdata$CCStrat <- mx$CC

# 2. Run matched analysis
fit_matched <- snp.matched(Xdata, "case.control", 
                           snp.vars="BRCA.status",
                           main.vars=~oral.years + n.children, 
                           int.vars=~oral.years,
                           cc.var="CCStrat")

getSummary(fit_matched, method=c("CLR", "CCL"))
```

### 3. GWAS Scans (GxE.scan)

`GxE.scan` processes large-scale genotype data (e.g., TPED/TFAM) by streaming SNPs to avoid memory issues.

```r
# Define genotype input (TPED format)
snp.list <- list(file="geno.tped.gz", format="tped", subject.list="subjects.tfam")

# Define phenotype input
pheno.list <- list(file="pheno.txt", id.var=c("Family", "Subject"),
                   response.var="CaseControl", 
                   main.vars=c("Age", "Exposure"),
                   int.vars="Exposure")

# Run the scan
GxE.scan(snp.list, pheno.list, op=list(out.file="GxE_results.out"))
```

## Advanced Usage: Custom Scans

You can define a custom function to run specific tests during a GWAS scan.

```r
# Define custom function
myscan <- function(data, lists) {
  fit <- snp.logistic(data, "CaseControl", "SNP", 
                      main.vars=~Age + Exposure, 
                      int.vars=~Exposure)
  
  # Return a list of values to be written to the output file
  list(OR=exp(fit$CML$parms["SNP:Exposure"]))
}

# Run scan with custom function
op <- list(out.file="custom.out", model=0, scan.func="myscan")
GxE.scan(snp.list, pheno.list, op=op)
```

## Tips and Best Practices

- **Independence Assumption**: CML and EB methods assume G and E are independent in the population. If this assumption is violated, use the UML (Unconstrained) estimates.
- **Categorical Variables**: Always create dummy variables or ensure factors are correctly handled before passing to `main.vars`.
- **Missing Data**: `GxE.scan` handles missing genotype data automatically, but ensure phenotype data is clean.
- **Parallelization**: For very large GWAS, use `GxE.scan.partition` to split the job across a computing cluster, then `GxE.scan.combine` to merge results.

## Reference documentation

- [CGEN (Case-control.GENetics) Package](./references/vignette.md)
- [GxE.scan](./references/vignette_GxE.md)