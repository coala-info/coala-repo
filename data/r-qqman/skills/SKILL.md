---
name: r-qqman
description: Create Q-Q and manhattan plots for GWAS data from PLINK results.</p>
homepage: https://cloud.r-project.org/web/packages/qqman/index.html
---

# r-qqman

## Overview
The `qqman` package is a specialized tool for visualizing GWAS results. It provides two primary functions: `manhattan()` for creating Manhattan plots (genomic coordinates vs. significance) and `qq()` for Quantile-Quantile plots (diagnostic plots for p-value distributions). It is designed to work with standard data frames containing SNP identifiers, chromosome numbers, base-pair positions, and p-values.

## Installation
To install the package from CRAN:
```R
install.packages("qqman")
library(qqman)
```

## Core Functions

### Manhattan Plots
The `manhattan()` function expects a data frame with columns for Chromosome, Base Position, and P-value.

**Basic Usage:**
```R
# Assumes columns: SNP, CHR, BP, P
manhattan(gwasResults)
```

**Customizing Columns:**
If your data frame uses different column names, specify them explicitly:
```R
manhattan(df, chr="CHROM", bp="POS", p="PVAL", snp="RSID")
```

**Key Parameters:**
- `col`: A character vector of colors for alternating chromosomes (e.g., `col=c("blue4", "orange3")`).
- `suggestiveline`: The -log10(p-value) threshold for the suggestive line (default 1e-5). Set to `FALSE` to disable.
- `genomewideline`: The -log10(p-value) threshold for the genome-wide significance line (default 5e-8). Set to `FALSE` to disable.
- `highlight`: A character vector of SNP IDs to highlight in a different color.
- `annotatePval`: Annotate SNPs with p-values below this threshold.
- `annotateTop`: Boolean. If `TRUE` (default), only annotates the top SNP per chromosome/hit. If `FALSE`, annotates all SNPs below the threshold.
- `logp`: Boolean. Set to `FALSE` if you are plotting values that are already transformed or are not p-values (e.g., Z-scores).

### Q-Q Plots
The `qq()` function takes a numeric vector of p-values and plots them against a theoretical uniform distribution.

**Basic Usage:**
```R
qq(gwasResults$P)
```

**Customizing Appearance:**
```R
qq(gwasResults$P, main="Q-Q Plot", col="blue4", pch=18)
```

## Workflows and Tips

### Visualizing a Single Chromosome
To zoom in on a specific chromosome, subset the data before plotting:
```R
manhattan(subset(gwasResults, CHR == 1))
```

### Handling Non-Numeric Chromosomes
The `manhattan()` function requires the chromosome column to be numeric. If your data contains "X", "Y", or "MT", convert them to integers (e.g., 23, 24, 25) before plotting. You can use the `chrlabs` argument to restore the original labels on the X-axis:
```R
manhattan(gwasResults, chrlabs = c(1:22, "X", "Y"))
```

### Plotting Non-P-Value Data
You can use `manhattan()` to plot other statistics like Fst or Z-scores by disabling the log transformation:
```R
manhattan(df, p="zscore", logp=FALSE, ylab="Z-score", genomewideline=FALSE)
```

## Reference documentation
- [Intro to the qqman package](./references/qqman.Rmd)