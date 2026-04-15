---
name: bioconductor-gskb
description: This package provides a comprehensive gene set knowledgebase for mouse pathway analysis and functional genomics. Use when user asks to access mouse-specific gene sets, perform gene set enrichment analysis for Mus musculus, or integrate curated pathways into functional genomics workflows.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/gskb.html
---

# bioconductor-gskb

name: bioconductor-gskb
description: Access and utilize the Gene Set Knowledgebase (GSKB) for mouse pathway analysis. Use this skill when performing Gene Set Enrichment Analysis (GSEA), Parametric Analysis of Gene Set Enrichment (PAGE), or other functional genomics interpretations specifically for Mus musculus data.

# bioconductor-gskb

## Overview

The `gskb` package is a comprehensive gene set knowledgebase specifically curated for mouse (Mus musculus), serving as the mouse-specific equivalent to the human MSigDB. It contains over 33,000 pathways and gene sets compiled from 40 sources, including GO, KEGG, PANTHER, and transcription factor targets. It is designed to be used with pathway analysis tools like `PGSEA` or the standard GSEA algorithm.

## Core Gene Set Categories

The package organizes gene sets into seven primary categories. Load them using the `data()` function:

- `mm_GO`: Gene Ontology terms for mouse.
- `mm_pathway`: Curated biological pathways (KEGG, etc.).
- `mm_metabolic`: Specific metabolic pathways.
- `mm_miRNA`: Predicted or verified microRNA target genes.
- `mm_TF`: Transcription factor target genes.
- `mm_location`: Gene sets based on chromosomal position.
- `mm_other`: Miscellaneous functional categories.

## Basic Usage

### Loading Data
To use a specific category, load the library and the desired dataset:

```r
library(gskb)
data(mm_pathway)

# View the first gene set in the list
mm_pathway[[1]]
```

### Integration with PGSEA
`gskb` datasets are formatted as lists, making them compatible with the `PGSEA` package for parametric gene set enrichment.

```r
library(PGSEA)
library(gskb)
data(mm_miRNA)

# Assume 'exp_data' is a matrix of gene expression (rows=genes, cols=samples)
# Genes should be centered (e.g., by mean)
exp_centered <- exp_data - apply(exp_data, 1, mean)

# Run PGSEA
pg_results <- PGSEA(exp_centered, cl=mm_miRNA, range=c(15, 2000), p.value=NA)

# Filter out pathways with no matches (all NAs)
pg_filtered <- pg_results[rowSums(is.na(pg_results)) != ncol(exp_centered), ]
```

### Integration with GSEA
The gene sets can be passed directly to GSEA implementations in R.

```r
# Example using a standard GSEA function call
GSEA(
  input.ds = "path_to_data.gct",
  input.cls = "path_to_phenotype.cls",
  gs.db = mm_pathway,  # Use the gskb object here
  output.directory = getwd(),
  doc.string = "mouse_analysis"
)
```

## Advanced Workflows

### Accessing External/Large Gene Sets
Some very large collections (like co-expression gene lists from literature) are hosted externally to keep the package size manageable. You can pull these into R manually:

```r
# Example: Loading co-expression GMT files from the ge-lab server
gmt_url <- "http://ge-lab.org/gskb/2-MousePath/MousePath_Co-expression_gmt.gmt"
d1 <- scan(gmt_url, what="", sep="\n", skip=1)
mm_Co_expression <- strsplit(d1, "\t")
names(mm_Co_expression) <- sapply(mm_Co_expression, '[[', 1)
```

## Tips for Success
- **Gene Identifiers**: Ensure your expression data uses the same gene identifiers (typically Gene Symbols) as the `gskb` sets.
- **Filtering**: When using `PGSEA`, always filter the resulting matrix to remove rows that are entirely `NA`, which occurs when too few genes in your dataset match a specific gene set.
- **Species Specificity**: Do not use this package for human data; use `MSigDB` or `msigdbr` instead.

## Reference documentation
- [Gene Set Data for Pathway Analysis in Mouse](./references/gskb.md)