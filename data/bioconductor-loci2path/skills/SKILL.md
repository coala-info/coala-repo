---
name: bioconductor-loci2path
description: bioconductor-loci2path performs pathway enrichment analysis on genomic intervals by linking them to genes through tissue-specific eQTL evidence. Use when user asks to annotate genomic regions using eQTLs, perform tissue-specific pathway enrichment, or identify biological pathways associated with non-coding DNA.
homepage: https://bioconductor.org/packages/release/bioc/html/loci2path.html
---


# bioconductor-loci2path

name: bioconductor-loci2path
description: Regulatory annotation of genomic intervals using tissue-specific eQTLs. Use this skill to perform pathway enrichment analysis on genomic regions (BED files/GenomicRanges) by linking them to genes via eQTL evidence rather than simple proximity.

## Overview

The `loci2path` package provides a strategy to annotate non-coding genomic intervals by leveraging expression quantitative trait loci (eQTL) information. It bridges the gap between genomic coordinates and biological pathways by checking for the presence of tissue-specific eQTLs within query regions. This approach is superior to proximity-based annotation as it accounts for the functional regulatory context of specific tissues.

## Core Workflow

### 1. Prepare Input Data

The package requires three main components: query regions, eQTL sets, and a gene set collection.

**Query Regions:**
Must be a `GenomicRanges` object.
```r
library(GenomicRanges)
query.gr <- makeGRangesFromDataFrame(read.table("query.bed", col.names=c("chr","start","end")))
```

**eQTL Sets:**
Construct an `eqtlSet` for each tissue. You need SNP IDs, SNP locations (GRanges), and associated Gene IDs (typically Entrez).
```r
library(loci2path)
# Create a single tissue set
brain.eset <- eqtlSet(tissue="brain", 
                      eqtlId=tab$snp.id, 
                      eqtlRange=snp.gr, 
                      gene=as.character(tab$entrez.id))

# Create a list for multi-tissue analysis
eset.list <- list(Brain=brain.eset, Skin=skin.eset)
```

**Gene Set Collection:**
Requires a list of gene sets and the total number of genes in the background (e.g., MSigDB total).
```r
biocarta <- geneSet(numGene=31847, 
                    description=pathway_names, 
                    geneSetList=pathway_gene_list)
```

### 2. Perform Query

You can query against a single tissue or a list of tissues.

```r
# Single tissue query
res <- query(query.gr=query.gr, loci=skin.eset, path=biocarta)

# Multi-tissue query (supports parallel processing)
res.list <- query(query.gr=query.gr, loci=eset.list, path=biocarta, parallel=TRUE)
```

### 3. Interpret and Explore Results

**Extract Tables:**
```r
# Get the main enrichment table
tab <- resultTable(res.list)

# Get genes covered by eQTLs in the query regions
genes <- coveredGene(res.list)
```

**Tissue Specificity:**
To check which tissues are most enriched for the query regions without pathway constraints:
```r
tissue.enrich <- query(query.gr, loci=eset.list)
```

**Visualizations:**
- `getMat(res.list)`: Extract tissue-pathway enrichment matrix.
- `getHeatmap(res.list)`: Generate a heatmap of enrichment.
- `getWordcloud(res.list)`: Visualize pathway descriptions based on significance.
- `getPval(res.list)`: Plot p-value distributions.

## Tips and Best Practices

- **Gene IDs:** Ensure that the Gene IDs used in the `eqtlSet` match the ID type used in the `geneSet` (e.g., both Entrez).
- **Tissue Degree:** Use `getTissueDegree(res.list, eset.list)` to identify genes that are regulated by eQTLs across multiple tissues, which helps identify ubiquitous vs. tissue-specific regulatory effects.
- **Parallelization:** For large eQTL datasets or many tissues, always set `parallel=TRUE` in the `query` function to improve performance.
- **Background Gene Count:** The `numGene` parameter in `geneSet()` is critical for the Fisher's exact test; ensure this represents the total gene universe of the database you are using.

## Reference documentation

- [Loci2path: regulatory annotation of genomic intervals based on tissue-specific expression QTLs](./references/loci2path-vignette.md)
- [loci2path Rmd Source](./references/loci2path-vignette.Rmd)