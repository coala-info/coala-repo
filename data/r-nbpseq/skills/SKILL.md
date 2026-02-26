---
name: r-nbpseq
description: This tool performs differential expression analysis of RNA-Seq count data using Negative Binomial models to account for overdispersion. Use when user asks to identify differentially expressed genes, perform two-group comparisons of RNA-Seq data, or estimate dispersion parameters in count-based sequencing datasets.
homepage: https://cran.r-project.org/web/packages/nbpseq/index.html
---


# r-nbpseq

name: r-nbpseq
description: Perform differential expression analysis of RNA-Seq data using Negative Binomial (NB) models. Use this skill when analyzing count data from high-throughput sequencing to identify differentially expressed genes, specifically for two-group comparisons or regression-based inference where overdispersion needs to be modeled.

## Overview
The NBPSeq package provides a framework for analyzing RNA-Seq count data. It models the variability of gene expression using a Negative Binomial distribution, accounting for both technical and biological variation (overdispersion). It is designed for identifying differentially expressed genes between conditions and supports regression-based modeling of count data.

## Installation
To install the package from CRAN:
install.packages("NBPSeq")

## Core Workflow
The typical workflow involves preparing the data, estimating dispersion parameters, and performing statistical tests for differential expression.

1. Data Preparation: Use prepare.nbp() to create an NBP object from a count matrix and group labels.
2. Normalization: Specify normalization factors (e.g., TMM or total counts) within the NBP object.
3. Dispersion Estimation: Use estimate.disp() to estimate the dispersion parameter (alpha) which accounts for overdispersion relative to a Poisson model.
4. Testing: Use nbp.test() for two-group comparisons or exact.nb.test() for exact tests.

## Main Functions
- prepare.nbp(counts, grp, lib.sizes): Initializes an NBP data object.
- estimate.disp(obj): Estimates the dispersion parameters for the genes in the NBP object.
- nbp.test(obj, grp1, grp2): Performs a test for differential expression between two specified groups.
- exact.nb.test(counts, grp1, grp2): Performs an exact Negative Binomial test for two-group comparisons.

## Example Usage
library(NBPSeq)

# Assume 'counts' is a matrix of RNA-Seq counts and 'group' is a factor
# 1. Prepare the NBP object
obj = prepare.nbp(counts, group)

# 2. Estimate dispersion
obj = estimate.disp(obj)

# 3. Perform the test
# grp.ids specifies the levels in the group factor to compare
result = nbp.test(obj, grp1 = "Control", grp2 = "Treatment")

# 4. View results
head(result$p.values)
head(result$expression.levels)

## Tips
- Ensure the input count matrix contains raw integers, not normalized values or RPKM/FPKM.
- The package is particularly effective for datasets with small sample sizes where modeling the mean-variance relationship is critical.
- Use the qvalue package (often imported by NBPSeq) to adjust for multiple testing and control the False Discovery Rate (FDR).

## Reference documentation
- [NBPSeq Home Page](./references/home_page.md)