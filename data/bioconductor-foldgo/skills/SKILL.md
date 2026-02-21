---
name: bioconductor-foldgo
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/FoldGO.html
---

# bioconductor-foldgo

name: bioconductor-foldgo
description: Perform fold-change-specific functional enrichment analysis using the FoldGO R package. Use this skill when you need to identify Gene Ontology (GO) terms that are significantly overrepresented within specific fold-change intervals of differentially expressed genes (DEGs), rather than just the entire DEG list.

# bioconductor-foldgo

## Overview

FoldGO is a specialized Bioconductor package designed to detect "fold-change-specific" functional enrichment. While traditional GO enrichment analysis treats all differentially expressed genes (DEGs) as a single set, FoldGO subdivides DEGs into quantiles based on their fold-change values. It then tests for enrichment across all possible combinations of neighboring quantiles. This approach reveals biological processes that are specifically associated with narrow ranges of transcriptional response, which might be masked in a global analysis.

## Workflow and Key Functions

### 1. Data Preparation and Grouping
Input data must be a data frame where the first column contains Gene IDs and the second column contains Fold-Change (FC) values. Up-regulated and down-regulated genes must be processed separately.

```r
library(FoldGO)

# Create gene groups (quantiles and their unions)
# quannumber: number of equal-sized quantiles to create
up_groups <- GeneGroups(degenes_up, quannumber = 6)
down_groups <- GeneGroups(degenes_down, quannumber = 6)
```

### 2. Functional Annotation
FoldGO uses the `topGO` framework for enrichment. You must provide a background set of genes (`bggenes`) and specify the GO namespace ("BP", "MF", or "CC").

**Using Bioconductor Annotation Packages:**
```r
up_annotobj <- FuncAnnotGroupsTopGO(
  genegroups = up_groups, 
  namespace = "MF", 
  mapping = "org.At.tair.db", 
  annot = topGO::annFUN.org, 
  ID = "entrez", 
  bggenes = bggenes
)
```

**Using Custom GAF Files:**
```r
gaf <- GAFReader(file = "path/to/annotation.gaf", geneid_col = 10)
up_annotobj <- FuncAnnotGroupsTopGO(
  genegroups = up_groups, 
  namespace = "MF", 
  customAnnot = gaf, 
  annot = topGO::annFUN.GO2genes, 
  bggenes = bggenes
)
```

### 3. Testing for Fold-Specificity
The `FoldSpecTest` function identifies which GO terms are specifically enriched in certain fold-change intervals.

*   `fdrstep1`: FDR threshold for initial GO term preselection from the whole DEG list (default is 1, no preselection).
*   `fdrstep2`: FDR threshold for the fold-change-specific test (default is 0.05).

```r
up_fsobj <- FoldSpecTest(up_annotobj, fdrstep1 = 0.05, fdrstep2 = 0.01)
```

### 4. Extracting and Visualizing Results
Results are categorized into fold-change-specific (FS) and non-fold-change-specific (NFS) tables.

```r
# Get tables of results
fs_results <- getFStable(up_fsobj)
nfs_results <- getNFStable(up_fsobj)

# Visualize the Fold-change specific GO Profile
# Combines up and down regulated results in one plot
plot(up_fsobj, down_fsobj)
```

## Tips for Success
*   **Separate Directions:** Always run the pipeline twice: once for up-regulated genes and once for down-regulated genes.
*   **Quantile Selection:** Choosing `quannumber` depends on your DEG list size; 6 is a common starting point, but smaller lists may require fewer quantiles to maintain statistical power.
*   **Background Genes:** Ensure `bggenes` represents the "universe" of genes measured in your experiment (e.g., all genes on the microarray or all genes with non-zero counts in RNA-seq).
*   **Column Order:** `GeneGroups` strictly expects GeneID in column 1 and Fold-Change in column 2.

## Reference documentation
- [FoldGO: a tool for fold-change-specific functional enrichment analysis](./references/vignette.md)