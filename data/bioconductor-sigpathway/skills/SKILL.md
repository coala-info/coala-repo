---
name: bioconductor-sigpathway
description: This tool performs pathway analysis on microarray data by calculating NTk and NEk statistics to identify statistically significant gene sets. Use when user asks to perform gene set enrichment analysis, calculate pathway significance statistics, estimate q-values via permutation, or export pathway results to HTML.
homepage: https://bioconductor.org/packages/3.5/bioc/html/sigPathway.html
---

# bioconductor-sigpathway

name: bioconductor-sigpathway
description: Perform pathway (gene set) analysis on microarray data using the sigPathway package. Use this skill to calculate NTk (Q1) and NEk (Q2) statistics, rank pathways by significance, estimate q-values via permutation, and export results to HTML. Ideal for identifying statistically significant biological pathways in gene expression datasets.

## Overview
The `sigPathway` package implements a robust method for pathway analysis that combines two statistics: $N T_k$ (based on gene-level differential expression) and $N E_k$ (based on the enrichment of the pathway as a whole). It uses permutation testing to estimate significance (q-values), providing a more reliable assessment than single-statistic methods.

## Core Workflow

### 1. Data Preparation
The package requires three main components:
- **Expression Matrix**: A numeric matrix (e.g., `tab`) where rows are probe sets/genes and columns are samples.
- **Phenotype Vector**: A character or numeric vector (e.g., `phenotype`) indicating sample groups (e.g., 0 for Control, 1 for Treatment).
- **Pathway List**: A list object (e.g., `G`) where each element contains:
  - `src`: Database source.
  - `title`: Pathway name.
  - `probes`: Vector of probe IDs associated with the pathway.

### 2. Exploratory Analysis
Calculate t-statistics for individual probes to check for global differential expression:
```R
statList <- calcTStatFast(tab, phenotype, ngroups = 2)
hist(statList$pval, breaks = seq(0, 1, 0.025))
```

### 3. Running Pathway Analysis
Use `runSigPathway` to calculate pathway statistics.
```R
res <- runSigPathway(G, 
                     minsize = 20, 
                     maxsize = 500, 
                     tab, 
                     phenotype, 
                     nsim = 1000, 
                     weightType = "constant", 
                     ngroups = 2, 
                     npath = 25, 
                     annotpkg = "hgu133a.db")
```
**Key Parameters:**
- `minsize`/`maxsize`: Filters pathways based on the number of probes present in the expression matrix.
- `nsim`: Number of permutations.
- `weightType`: "constant" is faster; "variable" can be used if q-values are high.
- `npath`: Number of top pathways to summarize.
- `annotpkg`: (Optional) Bioconductor `.db` package for gene annotation.

### 4. Interpreting Results
The output is a list containing:
- `res$df.pathways`: A data frame of top-ranked pathways with NTk/NEk statistics and q-values.
- `res$list.gPS`: Detailed probe-level statistics for each top pathway.

Positive statistics indicate higher expression in the group coded as 1 (or the second group alphanumerically).

### 5. Exporting Results
Generate an HTML report for interactive browsing:
```R
writeSigPathway(res, filepath = "results_folder")
```

## Tips and Best Practices
- **Seed Setting**: Use `set.seed()` before `runSigPathway` to ensure reproducibility of permutation results.
- **Filtering**: Filter out low-expression probes (e.g., using trimmed mean) before analysis to reduce noise.
- **Memory**: For large datasets, `alwaysUseRandomPerm = FALSE` (default) optimizes performance by using complete permutation only when the sample size is small.
- **Annotation**: If `annotpkg` is provided, the output will include Entrez IDs and Gene Symbols, making biological interpretation easier.

## Reference documentation
- [sigPathway: Pathway Analysis with Microarray Data](./references/sigPathway-vignette.md)