---
name: bioconductor-mdgsa
description: This tool performs multidimensional gene set analysis using logistic regression to identify functional enrichment patterns across one or more genomic dimensions. Use when user asks to perform univariate or multivariate gene set enrichment analysis, transform p-values into ranking indices, or identify joint enrichment patterns from multiple experimental contrasts.
homepage: https://bioconductor.org/packages/3.5/bioc/html/mdgsa.html
---


# bioconductor-mdgsa

name: bioconductor-mdgsa
description: Multidimensional Gene Set Analysis (MDGSA) for functional profiling of genomic data. Use this skill when you need to perform univariate or multivariate gene set enrichment analysis on R-based genomic datasets (e.g., differential expression, copy number variations). It is particularly useful for identifying gene sets enriched by the combined effect of two different genomic dimensions or contrasts.

# bioconductor-mdgsa

## Overview
The `mdgsa` package implements a flexible framework for Gene Set Analysis (GSA) using logistic regression. Unlike standard GSEA, it allows for **multidimensional** analysis, where two different ranking indices (e.g., two different experimental contrasts or two different data types like expression and methylation) can be explored simultaneously to find joint enrichment patterns or interactions.

## Core Workflow

### 1. Prepare Ranking Indices
The analysis starts with gene-level statistics (p-values and direction of change).
- Use `pval2index()` to combine p-values and signs (from t-statistics or logFC) into a ranking index.
- Use `indexTransform()` to normalize the index (usually via a logit-like transformation) to ensure the logistic regression assumptions are met.

```r
library(mdgsa)
# For a single contrast
rindex <- pval2index(pval = fit$p.value[, "Contrast1"], sign = fit$t[, "Contrast1"])
rindex <- indexTransform(rindex)

# For multidimensional analysis, provide matrices
rindex_md <- pval2index(pval = fit$p.value[, c("C1", "C2")], sign = fit$t[, c("C1", "C2")])
rindex_md <- indexTransform(rindex_md)
```

### 2. Prepare Annotation
Gene sets must be formatted as a list where each element contains gene identifiers.
- Use `annotMat2list()` to convert a data frame (e.g., from `biomaRt` or `org.Hs.eg.db`) into the required list format.
- **Crucial Step:** Use `annotFilter()` to map the annotation to your ranking index and filter out sets that are too small or too large.

```r
# Convert matrix to list
annot <- annotMat2list(anmat) 
# Filter based on the gene universe in rindex
annot <- annotFilter(annot, rindex, minsize = 10, maxsize = 500)
```

### 3. Run Gene Set Analysis
- **Univariate (`uvGsa`)**: For analyzing one ranking index.
- **Multidimensional (`mdGsa`)**: For analyzing two ranking indices simultaneously.

```r
# Univariate
res_uv <- uvGsa(rindex, annot)

# Multidimensional
res_md <- mdGsa(rindex_md, annot)
```

### 4. Interpret Results
The output is a data frame containing Log Odds Ratios (LOR) and p-values.
- **LOR > 0**: Enrichment in high-ranking (up-regulated) genes.
- **LOR < 0**: Enrichment in low-ranking (down-regulated) genes.
- Use `uvPat()` or `mdPat()` to automatically classify the enrichment patterns (e.g., "q3f" for joint down-regulation in both dimensions).
- Use `getKEGGnames()` or `getGOnames()` to add descriptive labels to the results.
- Use `uvSignif()` to filter for significant results.

### 5. Visualization
For multidimensional analysis, use `plotMdGsa()` to visualize how a specific gene set (red dots/ellipse) shifts relative to the genomic background (blue ellipse).

```r
# Visualize a specific pathway (e.g., "03030")
plotMdGsa(rindex_md, block = annot[["03030"]], main = "DNA Replication")
```

## Multidimensional Patterns
When using `mdPat()`, common patterns include:
- **q1f to q4f**: Displacement toward specific quadrants (1=TopRight, 2=TopLeft, 3=BottomLeft, 4=BottomRight) without interaction.
- **xh / xl**: Shifted only in the X-axis (high/low).
- **yh / yl**: Shifted only in the Y-axis (high/low).
- **b13 / b24**: Bimodal distribution (genes split between opposite quadrants).

## Reference documentation
- [mdgsa_vignette](./references/mdgsa_vignette.md)
- [mdgsa_vignette_source](./references/mdgsa_vignette.Rmd)