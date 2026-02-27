---
name: bioconductor-seq2pathway.data
description: This package provides genomic resources, demo datasets, and pre-processed gene sets from GO and MsigDB for pathway analysis. Use when user asks to access GENCODE-mapped gene sets, load Gene Ontology reference lists, or use demo data for seq2pathway analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/seq2pathway.data.html
---


# bioconductor-seq2pathway.data

## Overview

The `seq2pathway.data` package provides essential genomic resources and demo datasets for the `seq2pathway` analysis suite. It contains pre-processed gene sets derived from Gene Ontology (GO) and the Molecular Signatures Database (MsigDB), mapped to specific GENCODE versions. While many objects are intended for internal use by `seq2pathway` functions, several are valuable for standalone analysis or as templates for user-defined pathway analysis.

## Data Categories

### 1. Gene Ontology (GO) Lists
These objects contain gene symbols mapped to GO terms, extracted from `org.Hs.eg.db`.
- **Lists**: `GO_BP_list` (Biological Process), `GO_MF_list` (Molecular Function), `GO_CC_list` (Cellular Component).
- **Descriptions**: `Des_BP_list`, `Des_MF_list`, `Des_CC_list` provide the text descriptions for the corresponding GO IDs.

```r
library(seq2pathway.data)
data(GO_BP_list)
data(Des_BP_list)

# Access a specific term
term_id <- "GO:0000082"
genes_in_term <- GO_BP_list[[term_id]]
description <- Des_BP_list[[term_id]]
```

### 2. GENCODE-Mapped Gene Sets
These data frames contain common genes between functional databases (GO/MsigDB) and specific GENCODE versions.
- **GO Mappings**: `GO_GENCODE_df_hg_v19`, `GO_GENCODE_df_hg_v36`, `GO_GENCODE_df_mm_vM1`, `GO_GENCODE_df_mm_vM25`.
- **MsigDB Mappings**: `Msig_GENCODE_df_hg_v19`, `Msig_GENCODE_df_hg_v36`, `Msig_GENCODE_df_mm_vM1`, `Msig_GENCODE_df_mm_vM25`.
- **Coding Genes**: `gencode_coding` (Vector of ~19,810 human protein-coding symbols).

### 3. Demo Datasets for seq2pathway
These objects are used to run examples in the main `seq2pathway` package.
- **MsigDB_C5**: A `GSA.genesets` object containing GO-annotated gene sets.
- **gene_description**: A data frame mapping HGNC symbols to biomaRt-derived descriptions.
- **Analysis Results**: 
    - `dat_gene2path_chip` / `dat_gene2path_RNA`: Results from ChIP-seq and RNA-seq pathway tests.
    - `dat_seq2pathway_GOterms` / `dat_seq2pathway_Msig`: Results containing `seq2gene` (annotation) and `gene2pathway` (FAIME/FET) outputs.

```r
# Loading MsigDB demo data
data(MsigDB_C5, package="seq2pathway.data")
# Structure: genesets, geneset.names, geneset.descriptions
```

## Typical Workflow

When using `seq2pathway`, you often do not need to load these manually as the main functions call them internally. However, for custom enrichment analysis:

1. **Identify the Organism/Version**: Choose the GENCODE data frame matching your data (e.g., `hg38` uses `v36`).
2. **Load Reference Sets**: Use `data(MsigDB_C5)` for a standard GSA-compatible gene set collection.
3. **Annotate Results**: Use `gene_description` to add human-readable context to your top-ranked genes.

```r
# Example: Adding descriptions to a list of genes
data(gene_description)
my_genes <- c("ABCD4", "ABHD4")
annotated_genes <- gene_description[gene_description$hgnc_symbol %in% my_genes, ]
```

## Reference documentation
- [seq2pathway.data Vignette](./references/seq2pathway.data.md)