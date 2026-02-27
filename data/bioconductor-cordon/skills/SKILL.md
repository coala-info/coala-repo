---
name: bioconductor-cordon
description: This tool analyzes codon usage patterns and predicts gene expression levels from DNA sequences. Use when user asks to calculate codon usage statistics, predict gene expressivity, perform functional enrichment analysis on annotated sequences, or visualize codon usage distances.
homepage: https://bioconductor.org/packages/release/bioc/html/coRdon.html
---


# bioconductor-cordon

name: bioconductor-cordon
description: Analysis of codon usage (CU) bias and gene expression prediction using the coRdon Bioconductor package. Use this skill to calculate CU statistics (MILC, ENC, SCUO), predict gene expressivity (MELP, CAI), and perform functional enrichment analysis on KEGG/COG annotated DNA sequences.

# bioconductor-cordon

## Overview
The `coRdon` package is designed for the analysis of codon usage (CU) patterns in DNA sequences. It is particularly useful for metagenomic data, allowing users to identify "functional fingerprints" by predicting highly expressed genes based on translational optimization. The package supports various CU bias statistics, visualization of CU distances, and gene set enrichment analysis (GSEA) for annotated sequences.

## Core Workflow

### 1. Loading Sequences
Sequences must be read into a `DNAStringSet` and then converted into a `codonTable` object, which stores codon counts and metadata.

```r
library(coRdon)

# Read fasta files
dna <- readSet(file = "path/to/sequences.fasta")

# Create codonTable
ctab <- codonTable(dna)

# Access data
counts <- codonCounts(ctab)
lengths <- getlen(ctab) # length in codons
ids <- getKO(ctab)      # get KEGG annotations if present
```

### 2. Calculating CU Bias
Calculate statistics to measure the deviation from uniform codon usage or distance from a reference set.

*   **MILC**: Measure Independent of Length and Composition (Recommended).
*   **ENC / ENCprime**: Effective Number of Codons.
*   **SCUO**: Synonymous Codon Usage Orderliness.
*   **B / MCB**: Other bias measures.

```r
# Calculate MILC relative to average sample CU ("self")
milc_self <- MILC(ctab)

# Calculate MILC relative to ribosomal genes (requires annotations)
milc_ribo <- MILC(ctab, ribosomal = TRUE, filtering = "hard")

# Filtering: Use 'hard' to remove sequences < 80 codons (default threshold)
```

### 3. Predicting Gene Expressivity
Predict relative expression levels by comparing a gene's CU to a reference set of highly expressed genes (usually ribosomal).

*   **MELP**: MILC-based Expression Level Predictor.
*   **CAI**: Codon Adaptation Index.
*   **Fop**: Frequency of Optimal Codons.

```r
# Predict expression using MELP
melp <- MELP(ctab, ribosomal = TRUE, filtering = "hard")
```

### 4. Functional Enrichment Analysis
Identify KEGG Orthology (KO) categories enriched among highly expressed genes.

```r
# 1. Create contingency table (threshold 1.0 for MELP)
annots <- getKO(ctab)[getlen(ctab) > 80]
ct <- crossTab(annots, as.numeric(melp), threshold = 1.0)

# 2. Optional: Reduce to Pathways or Modules
ct_path <- reduceCrossTab(ct, target = "pathway")

# 3. Perform enrichment test (Binomial)
enr <- enrichment(ct_path)
results <- Biobase::pData(enr)
```

## Visualization

### B-Plot
Visualizes CU distances. Each point is a gene.
```r
# Plot distance from ribosomal vs distance from self
Bplot(x = "ribosomal", y = "self", data = milc_ribo)
```

### Enrichment Plots
```r
# MA plot for enrichment
enrichMAplot(enr, pvalue = "pvals", siglev = 0.05)

# Barplot for enriched categories
enrichBarplot(enr, variable = "enrich", siglev = 0.05) + ggplot2::coord_flip()
```

## Tips for Success
*   **Sequence Length**: CU statistics are sensitive to length. Always use `filtering = "hard"` or manually filter for sequences > 80 codons to ensure robust results.
*   **Reference Sets**: If ribosomal annotations are missing, you can provide a custom reference set using the `subsets` argument (a named list of logical vectors).
*   **Integration**: Use `enrichMatrix()` to combine enrichment results from multiple samples into a single matrix for heatmaps or comparative analysis.

## Reference documentation
- [Codon usage (CU) analysis in R](./references/coRdon.Rmd)
- [Codon usage (CU) analysis in R](./references/coRdon.md)