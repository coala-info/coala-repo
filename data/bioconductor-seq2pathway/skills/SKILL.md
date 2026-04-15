---
name: bioconductor-seq2pathway
description: This tool performs functional enrichment analysis by mapping genomic coordinates to genes and identifying associated biological pathways. Use when user asks to map genomic regions to genes, perform pathway enrichment analysis on ChIP-seq or RNA-seq data, or identify enriched GO terms and MSigDB pathways from NGS peaks.
homepage: https://bioconductor.org/packages/release/bioc/html/seq2pathway.html
---

# bioconductor-seq2pathway

name: bioconductor-seq2pathway
description: Functional analysis of next-generation sequencing (NGS) data by integrating genomic information with biological pathways. Use this skill when performing pathway enrichment analysis for genomic regions (ChIP-seq, DNase-seq) or gene sets (RNA-seq), specifically for mapping genomic coordinates to genes and identifying enriched GO terms or MSigDB pathways.

# bioconductor-seq2pathway

## Overview
The `seq2pathway` package is designed to bridge the gap between NGS peaks (genomic coordinates) and biological pathways. It provides a multi-level analysis framework:
1.  **seq2gene**: Maps genomic regions to genes using a "coding-focus" or "full-genome" strategy, accounting for distance and gene structure.
2.  **gene2pathway**: Performs functional enrichment analysis on gene sets using various statistical tests (Fisher's Exact Test, Kolmogorov-Smirnov test).
3.  **seq2pathway**: A wrapper function that executes the end-to-end workflow from genomic regions to pathway scores.

## Core Workflows

### 1. Mapping Genomic Regions to Genes (seq2gene)
Use this to annotate ChIP-seq peaks or SNPs with neighboring genes.

```r
library(seq2pathway)

# Load sample data (GRanges or data.frame with chr, start, end)
data(dat_chip) 

# Map regions to genes
# searchRadius: distance to include upstream/downstream
# promoterRegion: definition of promoter relative to TSS
genes <- seq2gene(inputfile = dat_chip, 
                  searchRadius = 100000, 
                  promoterRegion = 1000, 
                  type = "overlap", 
                  genome = "hg19")
```

### 2. Pathway Enrichment Analysis (gene2pathway)
Use this when you already have a list of genes (e.g., from RNA-seq) and want to find enriched pathways.

```r
# Load pathway databases (GO, MSigDB)
data(G_list) 

# Run enrichment
# method: "FET" (Fisher's Exact Test) or "KS" (Kolmogorov-Smirnov)
pathway_results <- gene2pathway(gene_list = genes, 
                                 genome = "hg19", 
                                 database = G_list, 
                                 method = "FET")
```

### 3. Integrated Analysis (seq2pathway)
The primary function for a complete run from peaks to pathways.

```r
result <- seq2pathway(inputfile = dat_chip, 
                      genome = "hg19", 
                      searchRadius = 100000, 
                      database = G_list, 
                      run_seq2gene = TRUE, 
                      run_gene2pathway = TRUE)

# Access results
head(result$seq2gene_res)
head(result$gene2pathway_res)
```

## Key Parameters and Tips
- **Genome Support**: Supports "hg19", "hg38", "mm9", and "mm10".
- **Mapping Strategy**: 
    - `type="overlap"`: Assigns regions to genes if they overlap with the gene body or defined promoter.
    - `type="nearest"`: Assigns regions to the single nearest gene.
- **Databases**: The package works best with structured lists of gene sets. You can provide custom lists or use the built-in `G_list` (which typically contains GO terms and MSigDB collections).
- **Scoring**: When using the "KS" method, the package can utilize quantitative values (like fold-change or peak height) associated with the genes to rank enrichment.

## Reference documentation
- [seq2pathway Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/seq2pathway.html)