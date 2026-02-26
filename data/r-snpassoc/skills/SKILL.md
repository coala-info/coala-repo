---
name: r-snpassoc
description: The SNPassoc R package provides tools for performing genetic association studies, including data preparation, quality control, and statistical modeling of SNP data. Use when user asks to prepare SNP data for analysis, test for Hardy-Weinberg Equilibrium, perform single-SNP or whole-genome association studies, or analyze gene-environment and gene-gene interactions.
homepage: https://cloud.r-project.org/web/packages/SNPassoc/index.html
---


# r-snpassoc

name: r-snpassoc
description: Expert guidance for using the SNPassoc R package to perform whole genome association studies (GWAS). Use this skill when analyzing SNP data, including data preparation (setupSNP), descriptive statistics, Hardy-Weinberg Equilibrium (HWE) testing, single SNP association analysis (GLMs for quantitative or binary traits), gene-environment/gene-gene interactions, and haplotype analysis.

## Overview

The `SNPassoc` package is designed for the analysis of genome-wide association studies (GWAS) and candidate gene studies. It provides tools for data manipulation, exploratory analysis, and assessing genetic association using various inheritance models (codominant, dominant, recessive, overdominant, and additive). It also supports haplotype analysis and interaction testing.

## Installation

```R
install.packages("SNPassoc")
# For the development version with scanWGassociation:
# devtools::install_github("isglobal-brge/SNPassoc")
```

## Core Workflow

### 1. Data Preparation

Use `setupSNP` to transform raw data into a format compatible with the package. This assigns the `snp` class to specified columns.

```R
library(SNPassoc)
data(asthma)

# colSNPs: indices of columns containing SNP data
# sep: character separating alleles (e.g., "" for "AG", "/" for "A/G")
asthma.s <- setupSNP(data = asthma, colSNPs = 7:ncol(asthma), sep = "")
```

### 2. Descriptive Analysis and Quality Control

Check genotype frequencies, missingness, and Hardy-Weinberg Equilibrium (HWE).

```R
# Summary of a single SNP
summary(asthma.s$rs1422993)
plot(asthma.s$rs1422993)

# Summary of all SNPs
summary(asthma.s)

# Visualize missing data patterns
plotMissing(asthma.s)

# HWE testing (usually performed on controls only)
hwe <- tableHWE(asthma.s, casecontrol) 
# Filter SNPs with HWE p-value < 0.001
snps.ok <- rownames(hwe)[hwe[, "Controls"] >= 0.001]
```

### 3. Single SNP Association

The `association` function fits generalized linear models for a single SNP across multiple inheritance models.

```R
# Binary trait (Case-Control)
association(casecontrol ~ rs1422993, data = asthma.s)

# Quantitative trait
association(bmi ~ rs1422993, data = asthma.s)

# Adjusted for covariates
association(casecontrol ~ rs1422993 + age + gender, data = asthma.s)

# Max-statistic for the best inheritance model
maxstat(asthma.s$casecontrol, asthma.s$rs1422993)
```

### 4. Whole Genome (Massive Univariate) Association

Use `WGassociation` to run association tests across all SNPs in the dataset.

```R
ans <- WGassociation(casecontrol ~ 1, data = asthma.s)

# Manhattan plot
plot(ans)

# Get detailed table for specific SNPs
info <- WGstats(ans)
info$rs1422993
```

### 5. Interactions (GxE and GxG)

```R
# Gene-Environment Interaction
association(casecontrol ~ dominant(rs1422993) * factor(smoke), data = asthma.s)

# Gene-Gene Interaction (Epistasis)
# model.interaction specifies the model for the second SNP
association(casecontrol ~ rs1422993 * factor(rs184448), 
            data = asthma.s, model.interaction = "dominant")

# Screen for all pairwise interactions in a subset
ans.int <- interactionPval(casecontrol ~ 1, data = asthma.s2)
plot(ans.int)
```

### 6. Haplotype Analysis

Requires the `haplo.stats` package.

```R
library(haplo.stats)

# 1. Format genotypes for haplo.stats
snpsH <- c("rs714588", "rs1023555", "rs898070")
genoH <- make.geno(asthma.s, snpsH)

# 2. Estimate haplotype frequencies (EM algorithm)
em <- haplo.em(genoH, locus.label = snpsH)

# 3. Haplotype association (GLM)
mod <- haplo.glm(casecontrol ~ genoH, family = "binomial", 
                 locus.label = snpsH,
                 allele.lev = attributes(genoH)$unique.alleles,
                 control = haplo.glm.control(haplo.freq.min = 0.05))
intervals(mod)
```

## Tips and Best Practices

- **Reference Allele**: `setupSNP` automatically labels the most common genotype as the reference.
- **Model Selection**: Use the AIC column in the `association` output to determine the best-fitting inheritance model (lower is better).
- **Parallelization**: For large datasets, use the `mc.cores` argument in `setupSNP` and `WGassociation` to speed up computation on multi-core systems.
- **Sliding Windows**: For haplotype discovery without prior block knowledge, use `haplo.score.slide` to identify regions of interest.

## Reference documentation

- [SNPassoc: an R package to perform whole genome association studies](./references/SNPassoc.Rmd)