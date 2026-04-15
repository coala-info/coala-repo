---
name: bioconductor-monocle
description: Monocle analyzes single-cell RNA-seq data to model biological processes through pseudotime trajectory reconstruction. Use when user asks to perform cell clustering, identify differentially expressed genes, or order cells along a developmental trajectory.
homepage: https://bioconductor.org/packages/release/bioc/html/monocle.html
---

# bioconductor-monocle

name: bioconductor-monocle
description: Analysis of single-cell RNA-seq data using Monocle. Use this skill to perform cell clustering, differential expression analysis, and trajectory reconstruction (pseudotime) for single-cell datasets in R.

# bioconductor-monocle

## Overview
Monocle is a Bioconductor package designed for the analysis of single-cell RNA-seq experiments. Its core strength lies in "pseudotime" analysis—ordering cells along a learned trajectory to model biological processes like differentiation or response to stimuli. It also provides robust tools for data normalization, clustering, and identifying genes that vary across cell states or trajectories.

## Core Workflow

### 1. Data Preparation
Monocle uses the `CellDataSet` (CDS) class. You can create one from a count matrix, expression matrix, or by converting a Seurat object.

```r
library(monocle)

# Create CDS from a matrix
# expr_matrix: genes as rows, cells as columns
# pd: AnnotatedDataFrame for phenoData (cells)
# fd: AnnotatedDataFrame for featureData (genes)
cds <- newCellDataSet(as.matrix(expr_matrix),
                      phenoData = pd,
                      featureData = fd,
                      expressionFamily = negbinomial.size())

# Estimate size factors and dispersions
cds <- estimateSizeFactors(cds)
cds <- estimateDispersions(cds)
```

### 2. Filtering and Preprocessing
Filter out low-quality cells or genes with low detection.

```r
cds <- detectGenes(cds, min_expr = 0.1)
expressed_genes <- row.names(subset(fData(cds), num_cells_expressed >= 10))
```

### 3. Clustering Cells
Identify cell types or states before trajectory analysis.

```r
# Identify marker genes
disp_table <- dispersionTable(cds)
unsup_clustering_genes <- subset(disp_table, mean_expression >= 0.1)
cds <- setOrderingFilter(cds, unsup_clustering_genes$gene_id)

# Reduce dimensionality and cluster
cds <- reduceDimension(cds, max_components = 2, method = 'tSNE')
cds <- clusterCells(cds)
plot_cell_clusters(cds)
```

### 4. Trajectory Reconstruction (Pseudotime)
The signature workflow for Monocle involves ordering cells along a path.

```r
# 1. Choose genes that define progress (e.g., differentially expressed genes)
ordering_genes <- expressed_genes # Or use results from differentialGeneTest
cds <- setOrderingFilter(cds, ordering_genes)

# 2. Reduce dimension using DDRTree
cds <- reduceDimension(cds, method = 'DDRTree')

# 3. Order cells
cds <- orderCells(cds)

# 4. Visualize
plot_cell_trajectory(cds, color_by = "Pseudotime")
plot_cell_trajectory(cds, color_by = "State")
```

### 5. Differential Expression Analysis
Monocle provides specialized tests for single-cell data.

```r
# Test for genes that vary between clusters
diff_test_res <- differentialGeneTest(cds[expressed_genes,],
                                      fullModelFormulaStr = "~Cluster")

# Test for genes that change as a function of pseudotime
sig_genes <- subset(diff_test_res, qval < 0.1)
pseudotime_genes <- differentialGeneTest(cds[sig_genes$gene_id,],
                                         fullModelFormulaStr = "~sm.ns(Pseudotime)")
```

## Tips for Success
- **Expression Family**: Ensure you choose the correct `expressionFamily` during CDS creation. Use `negbinomial.size()` for raw counts and `gaussianff()` for log-transformed data or FPKM/TPM.
- **Gene Selection**: The quality of the trajectory depends heavily on the genes used for ordering. Using genes that are highly variable or differentially expressed across clusters usually yields the best results.
- **Branching**: Use `BEAM` (Branched Expression Analysis Modeling) to identify genes that are regulated in a cell-fate dependent manner at specific trajectory branches.

## Reference documentation
- [Monocle Vignette](./references/monocle-vignette.md)