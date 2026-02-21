---
name: bioconductor-cellarepertorium
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.12/bioc/html/CellaRepertorium.html
---

# bioconductor-cellarepertorium

## Overview

The `CellaRepertorium` package provides a specialized framework for handling single-cell immune repertoire data. It organizes data into a `ContigCellDB` object, which maintains relationships between three levels of information: **contigs** (individual sequence reads), **cells** (barcoded units), and **clusters** (clonotypes or sequence-similarity groups). This structure allows for robust analysis of TCR/BCR pairing, sequence clustering using CD-HIT, and statistical testing for clonal expansion or differential usage.

## Core Workflow

### 1. Data Loading and Initialization

The package is designed to work seamlessly with 10X Genomics Cellranger VDJ output (`all_contig_annotations.csv`).

```r
library(CellaRepertorium)

# Load 10X data
cdb = ContigCellDB_10XVDJ(contigs_qc, 
                          contig_pk = c('barcode', 'pop', 'sample', 'contig_id'), 
                          cell_pk = c('barcode', 'pop', 'sample'))

# Basic filtering
cdb = filter_cdb(cdb, high_confidence, full_length, productive == 'True')
```

### 2. Sequence Clustering

Use `cdhit_ccdb` to group CDR3 sequences by similarity. This is a wrapper for the CD-HIT algorithm.

```r
# Cluster Amino Acid sequences at 80% identity
aa80 = cdhit_ccdb(cdb, sequence_key = 'cdr3', type = 'AA', cluster_pk = 'aa80', 
                  identity = 0.8, min_length = 5)

# Calculate internal distances and medoids
aa80 = fine_clustering(aa80, sequence_key = 'cdr3', type = 'AA')

# Visualize cluster sizes
cluster_plot(aa80)
```

### 3. Canonicalization and Manipulation

To perform cell-level analysis, you must often choose a "representative" contig for each cell or cluster.

```r
# Choose a representative CDR3 for each cluster
aa80 = canonicalize_cluster(aa80, representative = 'cdr3', 
                            contig_fields = c('v_gene', 'j_gene', 'chain'))

# Choose a representative contig for each cell (e.g., the dominant TRA/TRB)
cell_representative = canonicalize_cell(aa80, chain == 'TRB')
```

### 4. Pairing Analysis

Analyze the pairing of alpha/beta or heavy/light chains.

```r
# Enumerate pairing types (paired, single, etc.)
pairing_summary = enumerate_pairing(cdb, chain_recode_fun = 'guess')

# Generate pairing tables for expanded clones
pairing_list = pairing_tables(aa80, table_order = 2, min_expansion = 3)

# Plot pairing heatmap
pairs_plt = ggplot(pairing_list$cell_tbl, aes(x = cluster_idx.1_fct, y = cluster_idx.2_fct)) + 
  geom_jitter()
```

### 5. Statistical Testing

Test for differential abundance of clusters across groups using logistic regression or permutation tests.

```r
# Logistic regression for differential usage
test_results = cluster_test_by(aa80, fields = 'chain', 
                               formula = ~ pop + (1|sample))

# Permutation test for clonal properties
perm_test = cluster_permute_test(aa80, cell_covariate_keys = 'pop', 
                                 cell_label_key = 'aa80', 
                                 statistic = my_stat_function)
```

### 6. Multimodal Integration

Integrate repertoire data into `SingleCellExperiment` objects for joint analysis with gene expression.

```r
library(SingleCellExperiment)
# Join repertoire to SCE colData
ccdb_integrated = ccdb_join(sce, ccdb)

# Add repertoire features to SCE metadata
colData(sce)$tcr_pairing = enumerate_pairing(ccdb_integrated)
```

## Tips and Best Practices

- **Primary Keys**: Always ensure `contig_pk` and `cell_pk` correctly identify unique rows. For multi-sample projects, include `sample` or `dataset` in the keys.
- **Filtering**: Perform QC (e.g., `guess_celltype`) before clustering to remove debris or non-T/B cell contigs.
- **Memory**: `fine_clustering` calculates distance matrices; for very large datasets, filter to expanded clones or use `cluster_whitelist` to save memory.
- **Visualization**: Use `map_axis_labels` to improve the readability of pairing plots by replacing cluster IDs with gene names or CDR3 sequences.

## Reference documentation

- [Clustering and differential usage of repertoire CDR3 sequences](./references/cdr3_clustering.md)
- [An Introduction to CellaRepertorium](./references/cr-overview.md)
- [Quality control and Exploration of UMI-based repertoire data](./references/mouse_tcell_qc.md)
- [Combining Repertoire with Expression with SingleCellExperiment](./references/repertoire_and_expression.md)