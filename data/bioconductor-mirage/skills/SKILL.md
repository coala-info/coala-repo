---
name: bioconductor-mirage
description: This tool infers miRNA-mediated target gene regulation from gene expression profiles by identifying significant shifts in target gene expression. Use when user asks to identify miRNAs regulating gene sets, rank miRNAs based on differential expression data, or perform statistical tests on miRNA target gene regulation.
homepage: https://bioconductor.org/packages/release/bioc/html/MiRaGE.html
---


# bioconductor-mirage

name: bioconductor-mirage
description: Inference of miRNA-mediated target gene regulation from gene expression profiles. Use this skill when you need to identify which miRNAs are likely regulating a set of genes based on differential expression data (e.g., treated vs. control, or different cell states) without requiring direct miRNA expression measurements.

## Overview

The MiRaGE package (miRNA Ranking by Gene Expression) identifies miRNA targets that are significantly up- or down-regulated between two experimental conditions. It maps gene identifiers to miRNA target sets (based on TargetScan seed matches) and performs statistical tests (KS, t-test, or Wilcoxon) to determine if the target genes of specific miRNAs show a systematic shift in expression compared to non-target genes.

## Core Workflow

### 1. Data Preparation
MiRaGE requires an `ExpressionSet` object. The `phenoData` must contain a `sample_name` column with a specific naming convention: `group.n` (e.g., `neg.1`, `neg.2`, `pos.1`, `pos.2`).

```R
library(MiRaGE)
library(Biobase)

# Example: Creating an ExpressionSet from a matrix
# expr_matrix: rows = genes, cols = samples
# gene_ids: vector of identifiers (RefSeq, Entrez, etc.)
# sample_names: e.g., c("control.1", "control.2", "treat.1", "treat.2")

gene_exp <- new("ExpressionSet", exprs = as.matrix(expr_matrix))
fData(gene_exp)[["gene_id"]] <- gene_ids
pData(gene_exp)[["sample_name"]] <- sample_names
```

### 2. Running the Analysis
The primary function is `MiRaGE()`. It is highly recommended to use `location="web"` to ensure the latest target tables are used.

```R
# Basic execution for Human (HS) or Mouse (MM)
result <- MiRaGE(gene_exp, 
                 species = "HS", 
                 ID = "refseq", 
                 location = "web",
                 method = "mean", 
                 test = "ks")
```

### 3. Key Parameters
- `species`: "HS" (Human) or "MM" (Mouse).
- `ID`: The type of gene identifier used (e.g., "refseq", "entrezgene", "hgnc_symbol", "affy_hg_u133_plus_2").
- `method`: 
    - `"mean"`: Averages replicates before testing.
    - `"mixed"`: Treats replicates as independent observations for the test.
- `test`: Statistical test to use: `"ks"` (default), `"t"`, or `"wilcox"`.
- `conv`: miRNA conservation level: `"conserved"` (default), `"weak_conserv"`, or `"all"`.

### 4. Interpreting Results
The output is a list containing two data frames:
- `result$P0`: P-values for target gene **up-regulation** in the second group (or down-regulation of the miRNA).
- `result$P1`: P-values for target gene **down-regulation** in the second group (or up-regulation of the miRNA).

```R
# Adjust for multiple comparisons
adj_p <- p.adjust(result$P1[, 2], method = "BH")

# Identify significant miRNAs (FDR < 0.05)
significant_mirnas <- result$P1[adj_p < 0.05, 1]
```

## Performance Tips
- **Offline Use**: If running multiple times, download the tables once and set `species_force=FALSE`, `ID_force=FALSE`, and `conv_force=FALSE` to avoid redundant downloads.
- **Gene IDs**: Ensure the `ID` parameter matches the format of `fData(gene_exp)$gene_id`. MiRaGE supports a wide array of IDs including Ensembl, Uniprot, and various microarray probe IDs.

## Reference documentation
- [MiRaGE](./references/MiRaGE.md)