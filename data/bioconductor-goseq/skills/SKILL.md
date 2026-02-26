---
name: bioconductor-goseq
description: The goseq package performs functional enrichment analysis on RNA-seq data while accounting for gene length bias. Use when user asks to perform Gene Ontology or KEGG pathway enrichment analysis, account for selection bias in differential expression results, or fit a probability weighting function to gene data.
homepage: https://bioconductor.org/packages/release/bioc/html/goseq.html
---


# bioconductor-goseq

## Overview
The `goseq` package is designed to perform functional enrichment analysis (GO, KEGG, etc.) on RNA-seq data. Unlike standard hypergeometric tests (like those used for microarrays), `goseq` accounts for the selection bias introduced by gene length: in RNA-seq, longer genes typically have higher read counts and thus more statistical power to be detected as differentially expressed. The package fits a Probability Weighting Function (PWF) to model this bias and uses it to calculate more accurate p-values for category enrichment.

## Core Workflow

### 1. Prepare Input Data
`goseq` requires a named integer vector where:
- Names are unique gene identifiers (e.g., Ensembl, Entrez, Gene Symbol).
- Values are `1` if the gene is differentially expressed (DE) and `0` otherwise.

```r
# Example: Creating the input vector from a list of all assayed genes and DE genes
gene.vector <- as.integer(assayed.genes %in% de.genes)
names(gene.vector) <- assayed.genes
```

### 2. Calculate the Probability Weighting Function (PWF)
The `nullp` function calculates the probability that a gene is DE based on its length.

```r
library(goseq)
# For natively supported organisms (e.g., hg19, mm9) and IDs (e.g., ensGene, knownGene)
pwf <- nullp(gene.vector, "hg19", "ensGene")

# To use custom bias data (e.g., total read counts instead of length)
pwf.counts <- nullp(gene.vector, bias.data = count_vector)
```

### 3. Perform Enrichment Testing
The `goseq` function tests for over-representation using the Wallenius approximation (default) or random sampling.

```r
# Default GO analysis (BP, CC, and MF)
GO.res <- goseq(pwf, "hg19", "ensGene")

# Limit to specific GO categories or KEGG
KEGG.res <- goseq(pwf, "hg19", "ensGene", test.cats = "KEGG")
GO.BP.res <- goseq(pwf, "hg19", "ensGene", test.cats = "GO:BP")

# Using random sampling (more accurate but slower)
GO.samp <- goseq(pwf, "hg19", "ensGene", method = "Sampling", repcnt = 1000)
```

## Handling Non-Native Data
If your organism or gene ID is not supported by `supportedOrganisms()`, you must provide manual mappings.

### Custom Lengths
```r
# Provide a numeric vector of lengths corresponding to the gene.vector
pwf <- nullp(gene.vector, bias.data = manual_lengths)
```

### Custom Category Mappings
```r
# gene2cat can be a data frame with two columns (GeneID, Category) 
# or a list where names are GeneIDs and values are vectors of categories.
res <- goseq(pwf, gene2cat = my_kegg_mapping)
```

## Interpreting Results
The output is a data frame containing:
- `category`: The ID (e.g., GO:0005737).
- `over_represented_pvalue`: The p-value for enrichment (primary metric).
- `under_represented_pvalue`: The p-value for depletion.
- `numDEInCat`: Number of DE genes in this category.
- `numInCat`: Total number of genes in this category.
- `term`: Descriptive name (if GO).

### Multiple Testing Correction
Always apply a correction (e.g., Benjamini-Hochberg) to the results:
```r
enriched.GO <- GO.res[p.adjust(GO.res$over_represented_pvalue, method = "BH") < 0.05, ]
```

## Tips and Best Practices
- **Check Support**: Run `supportedOrganisms()` to see if your genome/ID combination is natively supported for automatic length and GO retrieval.
- **Manual Lengths**: If you have lengths from your quantification tool (e.g., `featureCounts`), use them via the `bias.data` argument in `nullp` for higher accuracy.
- **Plotting**: Use `plotPWF(pwf)` to visualize the relationship between gene length and the probability of being DE. A flat line indicates no length bias.
- **GO.db**: Use the `GO.db` package to look up detailed definitions for the GO IDs returned by `goseq`.

## Reference documentation
- [goseq](./references/goseq.md)