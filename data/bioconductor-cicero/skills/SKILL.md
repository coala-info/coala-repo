---
name: bioconductor-cicero
description: Cicero predicts physical proximity between genomic regions by calculating co-accessibility scores from single-cell chromatin accessibility data. Use when user asks to predict cis-regulatory interactions, identify co-accessibility networks, or calculate gene activity scores from scATAC-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/cicero.html
---

# bioconductor-cicero

## Overview
Cicero is an R package designed to predict physical proximity between genomic regions using single-cell chromatin accessibility data. It addresses the inherent sparsity of scATAC-seq by aggregating similar cells into "consensus" groups. Its primary outputs are co-accessibility scores (ranging from -1 to 1) between peaks and "Cicero gene activity scores," which provide a more robust proxy for gene expression than promoter accessibility alone.

## Core Workflow: Cis-Regulatory Networks

### 1. Data Preparation
Cicero uses the `CellDataSet` (CDS) class from Monocle. Features must be peaks formatted as `chr_bp1_bp2`.

```r
library(cicero)

# Create a CDS from a sparse matrix or data frame
# Input: 3 columns (peak, cell, count)
input_cds <- make_atac_cds(cicero_data, binarize = TRUE)

# Pre-process using Monocle functions
input_cds <- detectGenes(input_cds)
input_cds <- estimateSizeFactors(input_cds)
```

### 2. Create Cicero CDS
To handle sparsity, you must aggregate cells based on similarity (e.g., tSNE or UMAP coordinates).

```r
# Reduce dimensions (using Monocle)
input_cds <- reduceDimension(input_cds, max_components = 2, num_dim=6,
                             reduction_method = 'tSNE', norm_method = "none")

# Extract coordinates and create aggregated CDS
tsne_coords <- t(reducedDimA(input_cds))
row.names(tsne_coords) <- row.names(pData(input_cds))
cicero_cds <- make_cicero_cds(input_cds, reduced_coordinates = tsne_coords)
```

### 3. Run Cicero and Visualize
The `run_cicero` function automates the estimation of co-accessibility.

```r
# Requires a genome coordinates file (chromosome lengths)
data("human.hg19.genome")
conns <- run_cicero(cicero_cds, human.hg19.genome)

# Visualize connections in a specific genomic region
data(gene_annotation_sample)
plot_connections(conns, "chr18", 8575097, 8839855,
                 gene_model = gene_annotation_sample,
                 coaccess_cutoff = .25)
```

## Advanced Analysis

### Cis-Coaccessibility Networks (CCANs)
CCANs are modules of sites that are highly co-accessible.
```r
ccan_assigns <- generate_ccans(conns)
```

### Gene Activity Scores
This combines promoter accessibility with linked distal site accessibility to better predict expression.
```r
# 1. Annotate CDS with 'gene' column in fData (marking TSS/promoters)
input_cds <- annotate_cds_by_site(input_cds, gene_annotation_sub)

# 2. Build unnormalized matrix
unnorm_ga <- build_gene_activity_matrix(input_cds, conns)

# 3. Normalize
num_genes <- pData(input_cds)$num_genes_expressed
names(num_genes) <- row.names(pData(input_cds))
cicero_gene_activities <- normalize_gene_activities(unnorm_ga, num_genes)
```

## Trajectory Analysis
Cicero extends Monocle 2 to order cells in pseudotime based on accessibility.

1. **Aggregate Nearby Peaks**: Use `aggregate_nearby_peaks(input_cds, distance = 10000)` to reduce noise before dimensionality reduction.
2. **Dimensionality Reduction**: Use `reduceDimension` with `reduction_method = 'DDRTree'`. Always include `num_genes_expressed` in the `residualModelFormulaStr` to account for technical variation.
3. **Differential Accessibility**: To find sites changing across pseudotime, aggregate similar cells into bins using `aggregate_by_cell_bin` before running `differentialGeneTest`.

## Tips for Success
- **Peak Formatting**: Ensure peak names use underscores (e.g., `chr1_1000_2000`). Use `make_atac_cds` to ensure the object is correctly initialized.
- **Sparsity**: Never run co-accessibility analysis on raw single cells; always use `make_cicero_cds` to create aggregated groups.
- **Memory**: For large datasets, subset the genome or use the `sample_num` parameter in `run_cicero` to manage computational load.

## Reference documentation
- [Single Cell ATAC-seq Analysis with Cicero](./references/website.md)