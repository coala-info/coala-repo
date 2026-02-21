# Alignment & batch integration of single cell data with corralm

Lauren Hsu1 and Aedin Culhane2

1Harvard TH Chan School of Public Health; Dana-Farber Cancer Institute
2Department of Data Sciences, Dana-Farber Cancer Institute, Department of Biostatistics, Harvard TH Chan School of Public Health

#### 4/28/2020

#### Package

BiocStyle 2.38.0

---

# 1 Introduction

Data from different experimental platforms and/or batches exhibit systematic
variation – i.e., batch effects. Therefore, when conducting joint analysis
of data from different batches, a key first step is to align the datasets.

`corralm` is a multi-table adaptation of correspondence analysis designed
for single-cell data, which applies multi-dimensional optimized scaling and
matrix factorization to compute integrated embeddings across the datasets.
These embeddings can then be used in downstream analyses, such as clustering,
cell type classification, trajectory analysis, etc.

See the vignette for `corral` for dimensionality reduction of a single matrix of single-cell data.

# 2 Loading packages and data

We will use the `SCMixology` datasets from the *[CellBench](https://bioconductor.org/packages/3.22/CellBench)* package (Tian et al. [2019](#ref-scmix)).

```
library(corral)
library(SingleCellExperiment)
library(ggplot2)
library(CellBench)
library(MultiAssayExperiment)

scmix_dat <- load_all_data()[1:3]
```

These datasets include a mixture of three lung cancer cell lines:

* H2228
* H1975
* HCC827

which was sequenced using three platforms:

* 10X
* CELseq2
* Dropseq

```
scmix_dat
```

```
## $sc_10x
## class: SingleCellExperiment
## dim: 16468 902
## metadata(3): scPipe Biomart log.exprs.offset
## assays(2): counts logcounts
## rownames(16468): ENSG00000272758 ENSG00000154678 ... ENSG00000054219
##   ENSG00000137691
## rowData names(0):
## colnames(902): CELL_000001 CELL_000002 ... CELL_000955 CELL_000965
## colData names(14): unaligned aligned_unmapped ... cell_line sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
##
## $sc_celseq
## class: SingleCellExperiment
## dim: 28204 274
## metadata(3): scPipe Biomart log.exprs.offset
## assays(2): counts logcounts
## rownames(28204): ENSG00000281131 ENSG00000227456 ... ENSG00000148143
##   ENSG00000226887
## rowData names(0):
## colnames(274): A1 A10 ... P8 P9
## colData names(15): unaligned aligned_unmapped ... cell_line sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
##
## $sc_dropseq
## class: SingleCellExperiment
## dim: 15127 225
## metadata(3): scPipe Biomart log.exprs.offset
## assays(2): counts logcounts
## rownames(15127): ENSG00000223849 ENSG00000225355 ... ENSG00000133789
##   ENSG00000146674
## rowData names(0):
## colnames(225): CELL_000001 CELL_000002 ... CELL_000249 CELL_000302
## colData names(14): unaligned aligned_unmapped ... cell_line sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Each sequencing platform captures a different set of genes.
In order to apply this method, the matrices need to be matched by features (i.e., genes).
We’ll find the intersect of the three datasets, then subset for that as we proceed.

First, we will prepare the data by:
1. adding to the colData the sequencing platform (`Method` in `colData` for each SCE), and
2. subsetting by the intersect of the genes.

```
platforms <- c('10X','CELseq2','Dropseq')
for(i in seq_along(scmix_dat)) {
  colData(scmix_dat[[i]])$Method<- rep(platforms[i], ncol(scmix_dat[[i]]))
}

scmix_mae <- as(scmix_dat,'MultiAssayExperiment')
scmix_dat <- as.list(MultiAssayExperiment::experiments(MultiAssayExperiment::intersectRows(scmix_mae)))
```

![](data:image/png;base64...)

`corralm` can be applied to the following types of objects:

* **a single *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*** requires specifying `splitby` (also see documentation of `corralm_matlist` for additional optional arguments that can be passed), which is a character string for the attribute in `colData` that is tracking the batches. In our case, this would be the “Method” attribute we just added. The output from this type of input is the same `SingleCellExperiment`, with the result added to the `reducedDim` slot under `corralm`.
* **a list of *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*** does not require any specific arguments. The output is a list of the input `SingleCellExperiment`s, with the result added to the `reducedDim` slot under `corralm`.
* **a list of matrices** (or other matrix-like objects: matrix, Matrix, tibble, data.frame, etc.) also does not require specific arguments. The output will be a concatenated list of SVD output matrices (`u`,`d`,`v`) where `v` contains a concatenated vector of the embeddings for the cells
* **a list of *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*s** does not require specific arguments. The output is the same as for a list of matrices.
* ***[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* or `ExperimentList`** does not require any specific arguments. `corralm` will identify the intersect of the rows, and use these to match the matrices. The output will be the same as for a list of matrices.

For purposes of illustration, we will walk through using `corralm` with a single SCE, and with a list of matrices.

# 3 `corralm` on a single *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*

First, setting up the data to demonstrate this:

```
colData(scmix_dat[[2]])$non_ERCC_percent <- NULL
# need to remove this column so the objects can be concatenated

scmix_sce <- SingleCellExperiment::cbind(scmix_dat[[1]],
                                         scmix_dat[[2]],
                                         scmix_dat[[3]])
```

Running `corralm`, and specifying the `splitby` argument:
(Note that the default is for the `counts` matrix to be used.
To change this default, use the `whichmat` argument.)

```
scmix_sce <- corralm(scmix_sce, splitby = 'Method')
```

Visualizing the results:

```
plot_embedding_sce(sce = scmix_sce,
                   which_embedding = 'corralm',
                   color_attr = 'Method',
                   color_title = 'platform',
                   ellipse_attr = 'cell_line',
                   plot_title = 'corralm on scmix',
                   saveplot = FALSE)
```

```
## Warning: The following aesthetics were dropped during statistical transformation:
## colour.
## ℹ This can happen when ggplot fails to infer the correct grouping structure in
##   the data.
## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
##   variable into a factor?
```

![](data:image/png;base64...)

# 4 `corralm` on a list of matrices

Again, preparing the data to be in this input format:

```
scmix_matlist <- sce2matlist(sce = scmix_sce,
                             splitby = 'Method',
                             whichmat = 'counts')

# for plotting purposes later, while we're here
platforms <- colData(scmix_sce)$Method
cell_lines <- colData(scmix_sce)$cell_line
```

Running corralm and visualizing output…
(the embeddings are in the `v` matrix because these data are matched by genes
in the rows and have cells in the columns; if this were reversed, with cells
in the rows and genes/features in the column, then the cell embeddings would
instead be in the `u` matrix.)

```
scmix_corralm <- corralm(scmix_matlist)
scmix_corralm
```

```
## corralm output summary==========================================
##   Output "list" includes SVD output (u, d, v) & a table of the
##   dimensions of the input matrices (batch_sizes)
## Variance explained----------------------------------------------
##                           PC1  PC2  PC3  PC4  PC5  PC6  PC7  PC8
## percent.Var.explained    0.03 0.02 0.01 0.01 0.01 0.01 0.01 0.01
## cumulative.Var.explained 0.03 0.05 0.05 0.06 0.07 0.07 0.08 0.08
##
## Dimensions of output elements-----------------------------------
##   Singular values (d) :: 30
##   Left singular vectors (u) :: 13575 30
##   Right singular vectors (v) :: 1401 30
##   See corralm help for details on each output element.
##
## Original batches & sizes (in order)-----------------------------
##   10X :: 902
##   CELseq2 :: 274
##   Dropseq :: 225
##
##   Use plot_embedding to visualize; see docs for details.
## ================================================================
```

```
plot_embedding(embedding = scmix_corralm$v,
               plot_title = 'corralm on scmix',
               color_vec = platforms,
               color_title = 'platform',
               ellipse_vec = cell_lines,
               saveplot = FALSE)
```

```
## Warning: The following aesthetics were dropped during statistical transformation:
## colour.
## ℹ This can happen when ggplot fails to infer the correct grouping structure in
##   the data.
## ℹ Did you forget to specify a `group` aesthetic or to convert a numerical
##   variable into a factor?
```

![](data:image/png;base64...)

As expected, we get the same results as above. (Note that in performing SVD,
the direction of the axes doesn’t matter and they may be flipped between runs,
as `corral` and `corralm` use `irlba` to perform fast approximation.)

# 5 Scaled variance plots to evaluate integration

Scaled variance plots provide a simple and fast visual summary of the integration of embeddings. It can be called using the `scal_var` function, and works on both `corralm` objects and custom embeddings (with a vector indicating batch).

When integrating embedding representations across batches, measures for cluster evaluation are effective for assessing group compactness and recovery of cell populations via clustering. However, they do not directly assess how well dataset embeddings are integrated across batches. To focus specifically on batch integration, we developed and applied a heuristic scaled variance metric, which captures the relative dispersion of each batch with respect to the entire dataset. The scaled variance of component dimension \(d^\*\) for the subset of observations in batch \(b^\*\), \(SV\_{b^\*,d}\), is computed with:
\[SV\_{b^\*,d} = \frac{\mathrm{Var}(\mathbf{E\_{b=b^\*,d=d^\*}})}{\mathrm{Var}(\mathbf{E\_{d=d^\*}})}\]
where \(\mathbf{E}\) is the matrix of embeddings, and \(b\) indexes the rows (observations by batch) while \(d\) indexes the columns to indicate which component dimension to evaluate.

```
scal_var(scmix_corralm)
```

![](data:image/png;base64...)

When the datasets are well integrated, SV values for each batch are close to 1, indicating that each batch’s subset has similar dispersion as compared to the entire embedding. In contrast, if there is poorer integration, the scaled variance values will be more extreme away from 1 because the variance within batches will differ more from the variance overall. This metric is appropriate when the types of cells represented in different datasets are expected to be similar, but cannot account for situations where the expected distribution of cell types (and therefore, embeddings) is fundamentally different between batches.

# 6 Session information

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
##  [1] MultiAssayExperiment_1.36.0 CellBench_1.26.0
##  [3] tibble_3.3.0                magrittr_2.0.4
##  [5] scater_1.38.0               scuttle_1.20.0
##  [7] DuoClustering2018_1.27.0    ggplot2_4.0.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           corral_1.20.0
## [21] gridExtra_2.3               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            httr2_1.2.1          rlang_1.1.6
##   [4] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
##   [7] vctrs_0.6.5          maps_3.4.3           reshape2_1.4.4
##  [10] stringr_1.5.2        pkgconfig_2.0.3      crayon_1.5.3
##  [13] fastmap_1.2.0        dbplyr_2.5.1         magick_2.9.0
##  [16] XVector_0.50.0       labeling_0.4.3       rmarkdown_2.30
##  [19] ggbeeswarm_0.7.2     tinytex_0.57         purrr_1.1.0
##  [22] bit_4.6.0            xfun_0.53            beachmat_2.26.0
##  [25] cachem_1.1.0         pals_1.10            jsonlite_2.0.0
##  [28] blob_1.2.4           DelayedArray_0.36.0  BiocParallel_1.44.0
##  [31] parallel_4.5.1       irlba_2.3.5.1        R6_2.6.1
##  [34] bslib_0.9.0          stringi_1.8.7        RColorBrewer_1.1-3
##  [37] lubridate_1.9.4      jquerylib_0.1.4      assertthat_0.2.1
##  [40] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
##  [43] FNN_1.1.4.1          BiocBaseUtils_1.12.0 timechange_0.3.0
##  [46] Matrix_1.7-4         tidyselect_1.2.1     dichromat_2.0-0.1
##  [49] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
##  [52] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
##  [55] plyr_1.8.9           withr_3.0.2          KEGGREST_1.50.0
##  [58] S7_0.2.0             Rtsne_0.17           evaluate_1.0.5
##  [61] BiocFileCache_3.0.0  ExperimentHub_3.0.0  mclust_6.1.1
##  [64] Biostrings_2.78.0    pillar_1.11.1        BiocManager_1.30.26
##  [67] filelock_1.0.3       BiocVersion_3.22.0   scales_1.4.0
##  [70] glue_1.8.0           mapproj_1.2.12       tools_4.5.1
##  [73] AnnotationHub_4.0.0  BiocNeighbors_2.4.0  data.table_1.17.8
##  [76] ScaledMatrix_1.18.0  grid_4.5.1           tidyr_1.3.1
##  [79] AnnotationDbi_1.72.0 colorspace_2.1-2     beeswarm_0.4.0
##  [82] BiocSingular_1.26.0  vipor_0.4.7          rsvd_1.0.5
##  [85] cli_3.6.5            rappdirs_0.3.3       ggthemes_5.1.0
##  [88] S4Arrays_1.10.0      viridisLite_0.4.2    dplyr_1.1.4
##  [91] uwot_0.2.3           gtable_0.3.6         sass_0.4.10
##  [94] digest_0.6.37        ggrepel_0.9.6        SparseArray_1.10.0
##  [97] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [100] lifecycle_1.0.4      httr_1.4.7           transport_0.15-4
## [103] bit64_4.6.0-1
```

# References

Tian, Luyi, Xueyi Dong, Saskia Freytag, Kim-Anh Lê Cao, Shian Su, Abolfazl JalalAbadi, Daniela Amann-Zalcenstein, et al. 2019. “Benchmarking Single Cell RNA-Sequencing Analysis Pipelines Using Mixture Control Experiments.” *Nature Methods* 16 (6): 479–87. <https://doi.org/10.1038/s41592-019-0425-8>.