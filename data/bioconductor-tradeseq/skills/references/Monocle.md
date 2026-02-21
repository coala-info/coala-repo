# Using Monocle as input to **tradeSeq**

#### Koen Van den Berge and Hector Roux de Bézieux

#### 02/20/2020

* [Introduction](#introduction)
* [Load data](#load-data)
* [Monocle3](#monocle3)
  + [Constructing the trajectory](#constructing-the-trajectory)
  + [Extracting the pseudotimes and cell weights for tradeSeq](#extracting-the-pseudotimes-and-cell-weights-for-tradeseq)
* [Session](#session)
* [References](#references)

# Introduction

`tradeSeq` is an `R` package that allows analysis of gene expression along trajectories. While it has been developed and applied to single-cell RNA-sequencing (scRNA-seq) data, its applicability extends beyond that, and also allows the analysis of, e.g., single-cell ATAC-seq data along trajectories or bulk RNA-seq time series datasets. For every gene in the dataset, `tradeSeq` fits a generalized additive model (GAM) by building on the `mgcv` R package. It then allows statistical inference on the GAM by assessing contrasts of the parameters of the fitted GAM model, aiding in interpreting complex datasets. All details about the `tradeSeq` model and statistical tests are described in our preprint (Van den Berge et al. 2020).

In this vignette, we analyze a subset of the data from (Paul et al. 2015). A `SingleCellExperiment` object of the data has been provided with the [`tradeSeq`](https://github.com/statOmics/tradeSeqpaper) package and can be retrieved as shown below. The data and UMAP reduced dimensions were derived from following the [Monocle 3 vignette](http://cole-trapnell-lab.github.io/monocle-release/monocle3/#tutorial-1-learning-trajectories-with-monocle-3).

The [main vignette](https://bioconductor.org/packages/devel/bioc/vignettes/tradeSeq/inst/doc/tradeSeq.html) focuses on using `tradeSeq` downstream of `slingshot`. Here, we present how to use `tradeSeq` downstream of `monocle`(Qiu et al. 2017).

# Load data

```
library(tradeSeq)
library(RColorBrewer)
library(SingleCellExperiment)

# For reproducibility
palette(brewer.pal(8, "Dark2"))
data(countMatrix, package = "tradeSeq")
counts <- as.matrix(countMatrix)
rm(countMatrix)
data(celltype, package = "tradeSeq")
```

# Monocle3

As of now (06/2020), monocle3(Cao et al. 2019), is still in its beta version. Therefore, we have no plan yet to include a S4 method for monocle3 while it is not on CRAN or Bioconductor and the format is still moving. However, we present below a way to use `tradeSeq` downstream of `monocle3` as of version ‘0.2’, for a fully connected graph. We follow the tutorial from the [monocle3 website](https://cole-trapnell-lab.github.io/monocle3/docs/trajectories/).

## Constructing the trajectory

You will need to install monocle3 from [here](https://cole-trapnell-lab.github.io/monocle3/docs/installation/) before running the code below.

```
set.seed(22)
library(monocle3)
# Create a cell_data_set object
cds <- new_cell_data_set(counts, cell_metadata = pd,
                gene_metadata = data.frame(gene_short_name = rownames(counts),
                                           row.names = rownames(counts)))
# Run PCA then UMAP on the data
cds <- preprocess_cds(cds, method = "PCA")
cds <- reduce_dimension(cds, preprocess_method = "PCA",
                        reduction_method = "UMAP")

# First display, coloring by the cell types from Paul et al
plot_cells(cds, label_groups_by_cluster = FALSE, cell_size = 1,
           color_cells_by = "cellType")

# Running the clustering method. This is necessary to the construct the graph
cds <- cluster_cells(cds, reduction_method = "UMAP")
# Visualize the clusters
plot_cells(cds, color_cells_by = "cluster", cell_size = 1)

# Construct the graph
# Note that, for the rest of the code to run, the graph should be fully connected
cds <- learn_graph(cds, use_partition = FALSE)

# We find all the cells that are close to the starting point
cell_ids <- colnames(cds)[pd$cellType ==  "Multipotent progenitors"]
closest_vertex <- cds@principal_graph_aux[["UMAP"]]$pr_graph_cell_proj_closest_vertex
closest_vertex <- as.matrix(closest_vertex[colnames(cds), ])
closest_vertex <- closest_vertex[cell_ids, ]
closest_vertex <- as.numeric(names(which.max(table(closest_vertex))))
mst <- principal_graph(cds)$UMAP
root_pr_nodes <- igraph::V(mst)$name[closest_vertex]

# We compute the trajectory
cds <- order_cells(cds, root_pr_nodes = root_pr_nodes)
plot_cells(cds, color_cells_by = "pseudotime")
```

## Extracting the pseudotimes and cell weights for tradeSeq

```
library(magrittr)
# Get the closest vertice for every cell
y_to_cells <-  principal_graph_aux(cds)$UMAP$pr_graph_cell_proj_closest_vertex %>%
  as.data.frame()
y_to_cells$cells <- rownames(y_to_cells)
y_to_cells$Y <- y_to_cells$V1

# Get the root vertices
# It is the same node as above
root <- cds@principal_graph_aux$UMAP$root_pr_nodes

# Get the other endpoints
endpoints <- names(which(igraph::degree(mst) == 1))
endpoints <- endpoints[!endpoints %in% root]

# For each endpoint
cellWeights <- lapply(endpoints, function(endpoint) {
  # We find the path between the endpoint and the root
  path <- igraph::shortest_paths(mst, root, endpoint)$vpath[[1]]
  path <- as.character(path)
  # We find the cells that map along that path
  df <- y_to_cells[y_to_cells$Y %in% path, ]
  df <- data.frame(weights = as.numeric(colnames(cds) %in% df$cells))
  colnames(df) <- endpoint
  return(df)
  }) %>% do.call(what = 'cbind', args = .) %>%
    as.matrix()
rownames(cellWeights) <- colnames(cds)
pseudotime <- matrix(pseudotime(cds), ncol = ncol(cellWeights),
                     nrow = ncol(cds), byrow = FALSE)
```

```
sce <- fitGAM(counts = counts,
              pseudotime = pseudotime,
              cellWeights = cellWeights)
```

Then, the `sce` object can be analyzed following the [main vignette](https://bioconductor.org/packages/devel/bioc/vignettes/tradeSeq/inst/doc/tradeSeq.html).

# Session

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           RColorBrewer_1.1-3
## [13] tradeSeq_1.24.0             knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6           xfun_0.53              bslib_0.9.0
##  [4] ggplot2_4.0.0          lattice_0.22-7         vctrs_0.6.5
##  [7] tools_4.5.1            slingshot_2.18.0       parallel_4.5.1
## [10] tibble_3.3.0           pkgconfig_2.0.3        Matrix_1.7-4
## [13] S7_0.2.0               TrajectoryUtils_1.18.0 lifecycle_1.0.4
## [16] compiler_4.5.1         farver_2.1.2           statmod_1.5.1
## [19] codetools_0.2-20       htmltools_0.5.8.1      sass_0.4.10
## [22] yaml_2.3.10            pillar_1.11.1          jquerylib_0.1.4
## [25] BiocParallel_1.44.0    DelayedArray_0.36.0    cachem_1.1.0
## [28] limma_3.66.0           viridis_0.6.5          abind_1.4-8
## [31] nlme_3.1-168           princurve_2.1.6        locfit_1.5-9.12
## [34] tidyselect_1.2.1       digest_0.6.37          dplyr_1.1.4
## [37] splines_4.5.1          fastmap_1.2.0          grid_4.5.1
## [40] cli_3.6.5              SparseArray_1.10.0     magrittr_2.0.4
## [43] S4Arrays_1.10.0        dichromat_2.0-0.1      edgeR_4.8.0
## [46] scales_1.4.0           rmarkdown_2.30         XVector_0.50.0
## [49] igraph_2.2.1           gridExtra_2.3          pbapply_1.7-4
## [52] evaluate_1.0.5         viridisLite_0.4.2      mgcv_1.9-3
## [55] rlang_1.1.6            Rcpp_1.1.0             glue_1.8.0
## [58] jsonlite_2.0.0         R6_2.6.1
```

# References

Cao, Junyue, Malte Spielmann, Xiaojie Qiu, Xingfan Huang, Daniel M. Ibrahim, Andrew J. Hill, Fan Zhang, et al. 2019. “The Dynamics and Regulators of Cell Fate Decisions Are Revealed by Pseudo-Temporal Ordering of Single Cells.” *Nature*.

Paul, Franziska, Ya’ara Arkin, Amir Giladi, DiegoÂ Adhemar Jaitin, Ephraim Kenigsberg, Hadas Keren-Shaul, Deborah Winter, et al. 2015. “Transcriptional Heterogeneity and Lineage Commitment in Myeloid Progenitors.” *Cell* 163 (7): 1663–77. <https://doi.org/10.1016/J.CELL.2015.11.013>.

Qiu, Xiaojie, Qi Mao, Ying Tang, Li Wang, Raghav Chawla, Hannah A Pliner, and Cole Trapnell. 2017. “Reversed graph embedding resolves complex single-cell trajectories.” *Nature Methods* 14 (10): 979–82. <https://doi.org/10.1038/nmeth.4402>.

Van den Berge, Koen, Hector Roux de Bézieux, Kelly Street, Wouter Saelens, Robrecht Cannoodt, Yvan Saeys, Sandrine Dudoit, and Lieven Clement. 2020. “Trajectory-based differential expression analysis for single-cell sequencing data.” *Nature Communications* 11 (1): 1201. <https://doi.org/10.1038/s41467-020-14766-3>.