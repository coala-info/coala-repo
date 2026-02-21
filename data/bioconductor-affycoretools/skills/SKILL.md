---
name: bioconductor-affycoretools
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/affycoretools.html
---

# bioconductor-affycoretools

name: bioconductor-affycoretools
description: Specialized workflows for creating annotated reports, HTML tables, and Venn diagrams from microarray and RNA-Seq data. Use this skill when you need to automate the generation of publication-quality output from Bioconductor objects (ExpressionSet, MArrayLM), specifically for adding gene annotations, embedding expression plots into HTML reports, and creating interactive Venn diagrams.

# bioconductor-affycoretools

## Overview

The `affycoretools` package is designed to streamline the post-analysis workflow for genomic data. While originally Affymetrix-focused, it now provides general-purpose utilities for any microarray or RNA-Seq experiment analyzed via `limma` or `edgeR`. Its primary strength lies in "decorating" standard analysis results with functional annotations (Entrez IDs, Symbols) and visual aids (dotplots, boxplots) that are automatically linked within HTML reports.

## Core Workflows

### 1. Annotating ExpressionSets
Before analysis, use `annotateEset` to map probe IDs to gene symbols and Entrez IDs using a standard Bioconductor annotation package (e.g., `hgu95av2.db`).

```r
library(affycoretools)
# Assuming eset is an ExpressionSet and hgu95av2.db is loaded
eset <- annotateEset(eset, hgu95av2.db)
```

### 2. Creating Enhanced HTML Reports
The package works with `ReportingTools` to create HTML tables that include embedded plots for each gene.

```r
library(ReportingTools)
library(limma)

# 1. Fit model
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit2)

# 2. Generate images and decorated data frame
# This creates small dotplots for the top genes
d.f <- topTable(fit2, coef = 1)
out <- makeImages(df = d.f, eset = eset, grp.factor = pd$type, 
                  design = design, contrast = contrast, colind = 1)

# 3. Publish to HTML
htab <- HTMLReport("results", "Differential Expression")
publish(out$df, htab, .modifyDF = list(entrezLinks, affyLinks))
finish(htab)
```

### 3. Interactive Venn Diagrams
`makeVenn` creates Venn diagrams where the counts in each cell can be linked to specific gene lists.

```r
# collist defines which columns of the contrast matrix to compare
collist <- list(1:2)
venn <- makeVenn(fit2, contrast, design, collist = collist)

# Display in an Rmarkdown/HTML context
cap <- list("Venn diagram comparing Case vs Control across sexes.")
vennInLine(venn, cap)
```

## Key Functions

- `annotateEset`: Adds featureData (Symbol, Entrez ID, Gene Name) to an ExpressionSet.
- `makeImages`: Generates individual gene plots (dotplots or boxplots) and returns a data frame with paths to these images, suitable for `ReportingTools`.
- `entrezLinks` / `affyLinks`: Helper functions used with the `.modifyDF` argument in `ReportingTools::publish` to turn IDs into clickable hyperlinks to NCBI or Affymetrix.
- `makeVenn`: High-level wrapper for `limma::vennCounts` that prepares data for automated reporting.
- `vennInLine`: Specifically designed for Rmarkdown to insert Venn diagrams with formatted captions.

## Tips for Success

- **Directory Management**: By default, `makeImages` and report functions often create a `reports` or `images` subdirectory. Ensure your working directory is writeable.
- **Plot Customization**: Use the `type` argument in `makeImages` to switch between "dotplot" and "boxplot".
- **Annotation Consistency**: Ensure the annotation Dbi package matches your platform. `affycoretools` relies on these mappings to generate the links in the HTML output.
- **Multiple Comparisons**: When dealing with multiple contrasts, use `lapply` to iterate through coefficients and generate a master index page with links to individual contrast reports.

## Reference documentation

- [Creating annotated output with affycoretools and ReportingTools](./references/RefactoredAffycoretools.md)