---
name: r-ccube
description: r-ccube clusters somatic variants and estimates cancer cell fractions from bulk sequencing data using Bayesian mixture models. Use when user asks to estimate cancer cell fractions, cluster SNVs or SVs, identify clonal architecture, or estimate tumor purity.
homepage: https://cran.r-project.org/web/packages/ccube/index.html
---

# r-ccube

name: r-ccube
description: Use for clustering and estimating cancer cell fractions (CCF) of somatic variants (SNVs/SVs) from bulk whole genome/exome data. This skill helps in identifying clonal architecture, correcting for copy number alterations and purity, and performing subclone identification using Bayesian mixture models.

# r-ccube

## Overview
r-ccube is an R package designed for the analysis of cancer evolution and intratumor heterogeneity. It uses Bayesian mixture models, fitted with variational inference, to estimate Cancer Cell Fractions (CCF) and cluster somatic variants. It supports both Single Nucleotide Variants (SNVs) and Structural Variants (SVs), accounting for tumor purity and local copy number alterations.

## Installation
To install the package from CRAN:
install.packages("ccube")

To install the development version from GitHub:
devtools::install_github("keyuan/ccube")

## Main Functions and Workflows

### 1. SNV Clustering and CCF Estimation
Use the core Ccube model for SNVs. It employs a Normal-Binomial mixture model to identify mutation clusters.
- Input: Reference and alternative allele read counts, local copy number, and tumor purity.
- Output: CCF estimates for each variant and cluster assignments.

### 2. SV Clustering
Use the CcubeSV model for structural variants. This is a modified version of the core model optimized for the unique properties of SV read support.

### 3. Purity Estimation
The package provides models specifically for estimating or refining tumor purity:
- Student-t mixture model: The primary model for purity estimation.
- Normal mixture model: An alternative model used for code calibration and testing.

### 4. General Workflow
1. Prepare input data: Collect variant allele frequencies (VAF), total depth, and local copy number states.
2. Estimate Purity: If not already known, use the Student-t mixture model.
3. Run Ccube: Execute the clustering algorithm on SNVs or SVs.
4. Analyze Results: Interpret the clusters to determine the clonal (CCF ≈ 1) and subclonal (CCF < 1) populations.

## Tips for Success
- Ensure that copy number and purity inputs are as accurate as possible, as CCF estimates are highly sensitive to these parameters.
- Use the variational inference approach for faster computation compared to traditional MCMC methods, especially with large whole-genome sequencing datasets.
- Check the clonal cluster (usually the one with the highest CCF) to validate purity settings.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)