---
name: probabel
description: ProbABEL is a suite of tools designed for high-throughput genetic association analysis using imputed dosage or genotype probability data. Use when user asks to perform linear regression for continuous traits, logistic regression for binary traits, or Cox proportional hazards regression for survival analysis.
homepage: https://github.com/GenABEL-Project/ProbABEL
---

# probabel

## Overview
ProbABEL is a specialized suite of tools designed for high-throughput genetic association studies using imputed data. Unlike standard GWAS tools that often rely on hard-called genotypes, ProbABEL is optimized to handle the uncertainty of imputed data by processing dosages or genotype probabilities directly. This skill assists in choosing the correct analysis binary based on the phenotype being studied and provides troubleshooting tips for common execution hurdles.

## Core Analysis Tools
ProbABEL consists of three primary binaries, each tailored to a specific type of trait analysis:

- **palinear**: Use for continuous traits (e.g., height, BMI, biomarker levels). It performs linear regression.
- **palogist**: Use for binary or dichotomous traits (e.g., case-control status, presence/absence of a condition). It performs logistic regression.
- **pacoxph**: Use for survival analysis or time-to-event data. It performs Cox proportional hazards regression.

## Common CLI Patterns and Parameters
While specific file paths depend on the local environment, the following patterns are standard across the suite:

### Essential Flags
- `--nids [number]`: Explicitly defines the number of individuals (IDs) to be analyzed. This is a critical parameter for ensuring the tool correctly parses the phenotype and genotype files.
- **Phenotype Files**: Usually provided as a space-separated or tab-separated text file.
- **Info Files**: Required to provide metadata for the SNPs being analyzed (often generated during the imputation process).
- **Dosage/Probability Files**: The primary genetic input containing the imputed data.

### Input Data Handling
- **Imputed Data Formats**: ProbABEL is designed to work with files containing dosages (0 to 2) or probabilities for the three genotypes (P(AA), P(AB), P(BB)).
- **File Compression**: Be aware that some versions of ProbABEL may encounter issues when reading gzipped dosage files directly. If errors occur, consider decompressing files or using pipes.

## Expert Tips and Troubleshooting
- **Library Compatibility**: ProbABEL relies heavily on the Eigen library. If you are compiling from source or encountering mathematical errors, note that specific versions (e.g., Eigen > 3.2.1) have historically caused check failures in linear regression modules.
- **Data Alignment**: Ensure that the order of individuals in your phenotype file matches the order in your genotype/dosage files. The `--nids` flag should reflect the count of individuals present in both.
- **Memory and Performance**: ProbABEL is written in C++ for speed. For very large datasets, ensure your environment has sufficient RAM to hold the phenotype and covariate data, though the genotype data is typically processed in a memory-efficient streaming fashion.
- **Output Interpretation**: The tools typically output beta coefficients, standard errors, and other statistics. Note that p-values may need to be calculated post-hoc from the test statistics in some versions.

## Reference documentation
- [ProbABEL Homepage](./references/github_com_GenABEL-Project_ProbABEL.md)
- [ProbABEL Issues and Bug Reports](./references/github_com_GenABEL-Project_ProbABEL_issues.md)