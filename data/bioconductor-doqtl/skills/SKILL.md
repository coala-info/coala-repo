---
name: bioconductor-doqtl
description: "DOQTL performs Quantitative Trait Locus (QTL) mapping and haplotype reconstruction in Diversity Outbred mice. Use when user asks to perform linkage mapping, calculate kinship matrices, run permutation tests, visualize founder effects, or conduct association mapping in Diversity Outbred populations."
homepage: https://bioconductor.org/packages/3.6/bioc/html/DOQTL.html
---


# bioconductor-doqtl

## Overview
The `DOQTL` package is designed for Quantitative Trait Locus (QTL) mapping in Diversity Outbred (DO) mice. It provides tools for haplotype reconstruction using a Hidden Markov Model (HMM), linkage mapping with kinship correction, and association mapping by imputing founder SNPs onto DO genomes.

## Installation
To install the package from Bioconductor:
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DOQTL")
```

## Core Workflow

### 1. Data Preparation
QTL mapping requires phenotype data (a data frame) and genotype data (a 3D array of founder haplotype probabilities: samples x founders x markers). Ensure sample IDs match between the two.

```R
library(DOQTL)
library(MUGAExampleData)
data(pheno)
data(model.probs)
```

### 2. Calculate Kinship
Use the founder probabilities to create a kinship matrix to account for relatedness between samples.

```R
K = kinship.probs(model.probs)
```

### 3. Define Covariates
Create a data frame of additive covariates (e.g., sex, diet).

```R
covar = data.frame(sex = as.numeric(pheno$Sex == "M"), 
                   diet = as.numeric(pheno$Diet == "hf"))
rownames(covar) = rownames(pheno)
```

### 4. Perform Linkage Mapping
Use `scanone` to perform the mapping. You will need the marker locations (e.g., `muga_snps`).

```R
# Load marker locations
load(url("ftp://ftp.jax.org/MUGA/muga_snps.Rdata"))

# Run the mapping
qtl = scanone(pheno = pheno, 
              pheno.col = "HDW2", 
              probs = model.probs, 
              K = K, 
              addcovar = covar, 
              snps = muga_snps)
```

### 5. Significance Testing
Run permutations to determine the significance threshold.

```R
perms = scanone.perm(pheno = pheno, 
                     pheno.col = "HDW2", 
                     probs = model.probs, 
                     addcovar = covar, 
                     snps = muga_snps, 
                     nperm = 100) # 1000 recommended for publication
thr = quantile(perms, probs = 0.95)
```

### 6. Visualization and Analysis
Plot the LOD scores and founder allele effects.

```R
# Plot genome-wide LOD scores
plot(qtl, sig.thr = thr, main = "HDW2")

# Plot founder effects for a specific chromosome
coefplot(qtl, chr = 9)

# Calculate the Bayesian credible interval for a peak
interval = bayesint(qtl, chr = 9)
```

### 7. Association Mapping
Perform association mapping within a specific interval by imputing founder SNPs.

```R
ma = assoc.map(pheno = pheno, 
               pheno.col = "HDW2", 
               probs = model.probs, 
               K = K, 
               addcovar = covar, 
               snps = muga_snps, 
               chr = interval[1,2], 
               start = interval[1,3], 
               end = interval[3,3])

# Plot association results
assoc.plot(ma, thr = 4)
```

### 8. Identify Candidate Genes
Retrieve gene information for the identified interval.

```R
mgi = get.mgi.features(chr = interval[1,2], 
                       start = interval[1,3], 
                       end = interval[3,3], 
                       type = "gene", 
                       source = "MGI")
```

## Reference documentation
- [QTL Mapping using Diversity Outbred Mice](./references/QTL_Mapping_DO_Mice.md)