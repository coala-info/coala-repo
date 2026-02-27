---
name: bioconductor-pathwaysplice
description: PathwaySplice performs pathway enrichment analysis for alternative splicing in RNA-seq data while correcting for selection bias related to the number of gene features. Use when user asks to quantify feature-length bias, perform bias-corrected pathway analysis using GO or KEGG, and visualize results through enrichment maps or comparison plots.
homepage: https://bioconductor.org/packages/3.8/bioc/html/PathwaySplice.html
---


# bioconductor-pathwaysplice

name: bioconductor-pathwaysplice
description: Perform pathway analysis for alternative splicing in RNA-seq data while adjusting for selection bias caused by varying numbers of gene features (exons/junctions). Use this skill to analyze DEXSeq or JunctionSeq results, test for feature-length bias, run bias-corrected enrichment analysis (GO, KEGG, MSigDB), and visualize results via enrichment maps.

## Overview

PathwaySplice addresses a critical bias in RNA-seq pathway analysis: genes with more features (exons or junctions) are more likely to be identified as differentially spliced simply due to higher statistical power. This package provides tools to:
1.  **Quantify Bias**: Test if the number of gene features correlates with significance.
2.  **Correct Bias**: Use the Wallenius non-central hypergeometric distribution to adjust pathway p-values.
3.  **Visualize**: Create enrichment maps and comparison plots to understand the impact of bias correction.

## Typical Workflow

### 1. Data Preparation
The input must be a data frame containing gene feature IDs (exons/junctions), gene IDs, and p-values (typically from `DEXSeq` or `JunctionSeq`).

```r
library(PathwaySplice)

# Load example feature-based data
data(featureBasedData)

# Convert feature-level data to gene-level table
# stat can be "pvalue" (default) or "fdr"
gene.based.table <- makeGeneTable(featureBasedData, stat = "pvalue")
```

### 2. Bias Detection
Before running enrichment, check if a bias exists using logistic regression.

```r
# Returns p-value for bias and generates a boxplot
lrTestBias(gene.based.table, boxplot.width = 0.3)
```

### 3. Pathway Analysis (Bias-Corrected)
Use `runPathwaySplice` to perform the enrichment. The `Wallenius` method is recommended for a balance of accuracy and speed.

```r
# Analysis using Gene Ontology (GO)
res.adj <- runPathwaySplice(
  genewise.table = gene.based.table,
  genome = "hg19",
  id = "ensGene",
  test.cats = c("GO:BP"),
  go.size.limit = c(5, 30),
  method = "Wallenius",
  use.genes.without.cat = TRUE
)
```

### 4. Using Custom Gene Sets (MSigDB/KEGG)
To use non-GO gene sets, you must convert `.gmt` files using `gmtGene2Cat`.

```r
# For KEGG (requires internet for organism data)
outKegg2Gmt("hsa", "kegg.gmt.txt")
kegg.pathways <- gmtGene2Cat("kegg.gmt.txt", genomeID = "hg19")

# Run analysis with custom gene2cat
res.kegg <- runPathwaySplice(
  genewise.table = gene.based.table,
  genome = "hg19",
  id = "ensGene",
  gene2cat = kegg.pathways,
  method = "Wallenius"
)
```

### 5. Visualization and Comparison
Compare adjusted vs. unadjusted (Hypergeometric) results to see which pathways were likely false positives driven by gene length.

```r
# Compare results
compareResults(
  n.go = 20, 
  adjusted = res.adj, 
  unadjusted = res.unadj, 
  gene.based.table = gene.based.table,
  output.dir = tempdir()
)

# Create an Enrichment Map (Network)
enmap <- enrichmentMap(
  pathway.res = res.adj,
  n = 10, # Top 10 pathways
  similarity.threshold = 0.5
)
```

## Key Functions and Parameters

- `makeGeneTable()`: Collapses feature p-values to gene p-values (usually by taking the minimum).
- `runPathwaySplice()`:
    - `method`: "Wallenius" (recommended), "Sampling" (slow but precise), or "Hypergeometric" (no correction).
    - `use.genes.without.cat`: Set to `TRUE` to include all genes in the background calculation.
- `enrichmentMap()`: Generates a network where nodes are pathways and edges represent gene overlap (Jaccard index).

## Reference documentation

- [PathwaySplice: Pathway analysis for alternative splicing in RNA-seq datasets](./references/tutorial.md)