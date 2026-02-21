# Dimension reduction of single cell data with corral

Lauren Hsu1 and Aedin Culhane2

1Harvard TH Chan School of Public Health; Dana-Farber Cancer Institute
2Department of Data Science, Dana-Farber Cancer Institute, Department of Biostatistics, Harvard TH Chan School of Public Health

#### 5/17/2021

#### Package

BiocStyle 2.38.0

# 1 Introduction

Single-cell ’omics analysis enables high-resolution characterization of heterogeneous
populations of cells by quantifying measurements in individual cells and thus
provides a fuller, more nuanced picture into the complexity and heterogeneity between
cells. However, the data also present new and significant challenges as compared to
previous approaches, especially as single-cell data are much larger and sparser than
data generated from bulk sequencing methods. Dimension reduction is a key step
in the single-cell analysis to address the high dimension and sparsity of these
data, and to enable the application of more complex, computationally expensive downstream pipelines.

Correspondence analysis (CA) is a matrix factorization method, and is similar to
principal components analysis (PCA). Whereas PCA is designed for application to
continuous, approximately normally distributed data, CA is appropriate for
non-negative, count-based data that are in the same additive scale. `corral`
implements CA for dimensionality reduction of a single matrix of single-cell data.

See the vignette for `corralm` for the multi-table adaptation of CA for single-cell batch alignment/integration.

corral can be used with various types of input. When called on a matrix (or other matrix-like object), it returns a list with the SVD output, principal coordinates, and standard coordinates. When called on a *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*, it returns the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* with the corral embeddings in the `reducedDim` slot named `corral`. To retrieve the full list output from a `SingleCellExperiment` input, the `fullout` argument can be set to `TRUE`.
![](data:image/png;base64...)

# 2 Loading packages and data

We will use the `Zhengmix4eq` dataset from the *[DuoClustering2018](https://bioconductor.org/packages/3.22/DuoClustering2018)* package.

```
library(corral)
library(SingleCellExperiment)
library(ggplot2)
library(DuoClustering2018)
zm4eq.sce <- sce_full_Zhengmix4eq()
zm8eq <- sce_full_Zhengmix8eq()
```

This dataset includes approximately 4,000 pre-sorted and annotated cells of
4 types mixed by Duo et al. in approximately equal proportions (Duò, Robinson, and Soneson, [n.d.](#ref-zmdata)).
The cells were sampled from a “Massively parallel digital transcriptional
profiling of single cells” (Zheng et al. [2017](#ref-zheng)).

```
zm4eq.sce
```

```
## class: SingleCellExperiment
## dim: 15568 3994
## metadata(1): log.exprs.offset
## assays(3): counts logcounts normcounts
## rownames(15568): ENSG00000237683 ENSG00000228327 ... ENSG00000215700
##   ENSG00000215699
## rowData names(10): id symbol ... total_counts log10_total_counts
## colnames(3994): b.cells1147 b.cells6276 ... regulatory.t1084
##   regulatory.t9696
## colData names(14): dataset barcode ... libsize.drop feature.drop
## reducedDimNames(2): PCA TSNE
## mainExpName: NULL
## altExpNames(0):
```

```
table(colData(zm4eq.sce)$phenoid)
```

```
##
##         b.cells  cd14.monocytes naive.cytotoxic    regulatory.t
##             999            1000             998             997
```

# 3 `corral` on *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*

We will run `corral` directly on the raw count data:

```
zm4eq.sce <- corral(inp = zm4eq.sce,
                    whichmat = 'counts')

zm4eq.sce
```

```
## class: SingleCellExperiment
## dim: 15568 3994
## metadata(1): log.exprs.offset
## assays(3): counts logcounts normcounts
## rownames(15568): ENSG00000237683 ENSG00000228327 ... ENSG00000215700
##   ENSG00000215699
## rowData names(10): id symbol ... total_counts log10_total_counts
## colnames(3994): b.cells1147 b.cells6276 ... regulatory.t1084
##   regulatory.t9696
## colData names(14): dataset barcode ... libsize.drop feature.drop
## reducedDimNames(3): PCA TSNE corral
## mainExpName: NULL
## altExpNames(0):
```

We can use `plot_embedding` to visualize the output:

```
plot_embedding_sce(sce = zm4eq.sce,
                   which_embedding = 'corral',
                   plot_title = 'corral on Zhengmix4eq',
                   color_attr = 'phenoid',
                   color_title = 'cell type',
                   saveplot = FALSE)
```

![](data:image/png;base64...)

Using the `scater` package, we can also add and visualize `umap` and `tsne` embeddings based on the `corral` output:

```
library(scater)
```

```
## Loading required package: scuttle
```

```
library(gridExtra) # so we can arrange the plots side by side

zm4eq.sce <- runUMAP(zm4eq.sce,
                     dimred = 'corral',
                     name = 'corral_UMAP')
zm4eq.sce <- runTSNE(zm4eq.sce,
                     dimred = 'corral',
                     name = 'corral_TSNE')

ggplot_umap <- plot_embedding_sce(sce = zm4eq.sce,
                                  which_embedding = 'corral_UMAP',
                                  plot_title = 'Zhengmix4eq corral with UMAP',
                                  color_attr = 'phenoid',
                                  color_title = 'cell type',
                                  returngg = TRUE,
                                  showplot = FALSE,
                                  saveplot = FALSE)

ggplot_tsne <- plot_embedding_sce(sce = zm4eq.sce,
                                  which_embedding = 'corral_TSNE',
                                  plot_title = 'Zhengmix4eq corral with tSNE',
                                  color_attr = 'phenoid',
                                  color_title = 'cell type',
                                  returngg = TRUE,
                                  showplot = FALSE,
                                  saveplot = FALSE)

gridExtra::grid.arrange(ggplot_umap, ggplot_tsne, ncol = 2)
```

![](data:image/png;base64...)

The `corral` embeddings stored in the `reducedDim` slot can be used in
downstream analysis, such as for clustering or trajectory analysis.

`corral` can also be run on a `SummarizedExperiment` object.

# 4 `corral` on matrix

`corral` can also be performed on a matrix (or matrix-like) input.

```
zm4eq.countmat <- assay(zm4eq.sce,'counts')
zm4eq.countcorral <- corral(zm4eq.countmat)
```

The output is in a `list` format, including the SVD output (`u`,`d`,`v`),
the standard coordinates (`SCu`,`SCv`), and the principal coordinates (`PCu`,`PCv`).

```
zm4eq.countcorral
```

```
## corral output summary===========================================
##   Output "list" includes standard coordinates (SCu, SCv),
##   principal coordinates (PCu, PCv), & SVD output (u, d, v)
## Variance explained----------------------------------------------
##                           PC1  PC2  PC3  PC4  PC5  PC6  PC7  PC8
## percent.Var.explained    0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00
## cumulative.Var.explained 0.01 0.02 0.02 0.02 0.03 0.03 0.03 0.03
##
## Dimensions of output elements-----------------------------------
##   Singular values (d) :: 30
##   Left singular vectors & coordinates (u, SCu, PCu) :: 15568 30
##   Right singular vectors & coordinates (v, SCv, PCv) :: 3994 30
##   See corral help for details on each output element.
##   Use plot_embedding to visualize; see docs for details.
## ================================================================
```

We can use `plot_embedding` to visualize the output:
(the embeddings are in the `v` matrix because these data are by genes in the
rows and have cells in the columns; if this were reversed, with cells in the
rows and genes/features in the column, then the cell embeddings would instead
be in the `u` matrix.)

```
celltype_vec <- zm4eq.sce$phenoid
plot_embedding(embedding = zm4eq.countcorral$v,
               plot_title = 'corral on Zhengmix4eq',
               color_vec = celltype_vec,
               color_title = 'cell type',
               saveplot = FALSE)
```

![](data:image/png;base64...)

The output is the same as above with the `SingleCellExperiment`, and can be
passed as the low-dimension embedding for downstream analysis. Similarly,
UMAP and tSNE can be computed for visualization. (Note that in performing SVD,
the direction of the axes doesn’t matter so they may be flipped between runs,
as `corral` and `corralm` use `irlba` to perform fast approximation.)

# 5 Updates to CA to address overdispersion

Correspondence analysis is known to be sensitive to “rare objects” (Greenacre, 2013). Sometimes this can be beneficial because the method can detect small perturbations of rare populations. However, in other cases, a couple outlier cells can be allowed to exert undue influence on a particular dimension.

In the `corral` manuscript, we describe three general approaches, included below; see our manuscript for more details and results. In this vignette we also present a fourth approach (Trimming extreme values with `smooth` mode)

## 5.1 Changing the residual type (`rtype`)

Standard correspondence analysis decomposes Pearson \(\chi^2\) residuals, computed with the formula:
\[r\_{p; ij} = \frac{\mathrm{observed} - \mathrm{expected}}{\sqrt{\mathrm{expected}}} = \frac{p\_{ij} - p\_{i.} \ p\_{.j}}{\sqrt{p\_{i.} \ p\_{.j}}}\]

where \(p\_{ij} = \frac{x\_{ij}}{N}\), \(N = \sum\_{i=1}^m \sum\_{j=1}^n x\_{ij}\), \(p\_{i.} = \mathrm{row \ weights} = \sum\_{i=1}^m p\_{ij}\), and \(p\_{.j} = \mathrm{col \ weights} = \sum\_{j=1}^n p\_{ij}\).

In `corral`, this is the default setting. It can also be explicitly selected by setting `rtype = 'standardized'` or `rtype = 'pearson'`.

Another \(\chi^2\) residual is the Freeman-Tukey:
\[r\_{f; ij} = \sqrt{p\_{ij}} + \sqrt{p\_{ij} + \frac{1}{N}} - \sqrt{4 p\_{i.} \ p\_{.j} + \frac{1}{N}}\]

It is more robust to overdispersion than the Pearson residuals, and therefore outperforms standard CA in many scRNAseq datasets.

In `corral`, this option can be selected by setting `rtype = 'freemantukey'`.

## 5.2 Variance stabilization before CA (`vst_mth`)

Another approach for addressing overdispersed counts is to apply a variance stabilizing transformation. The options included in the package:

* Square root transform (\(\sqrt{x}\)): `vst_mth = 'sqrt'`
* Anscombe transform (\(2 \sqrt{x + \frac{3}{8}}\)): `vst_mth = 'anscombe'`
* Freeman-Tukey transform (\(\sqrt{x} + \sqrt{x + 1}\)): `vst_mth = 'freemantukey'` \*\*Note that this option is different from setting the `rtype` parameter to `'freemantukey'`

## 5.3 Power deflation (`powdef_alpha`)

To apply a smoothing effect to the \(\chi^2\) residuals, another approach is to transform the residual matrix by a power of \(\alpha \in (0,1)\). To achieve a “soft” smoothing effect, we suggest \(\alpha \in [0.9,0.99]\). This option is controlled with the `powdef_alpha` parameter, which takes the default value of `NULL` (not used). To set it, use this parameter and set it equal to the desired value for \(\alpha\) as a numeric. e.g., `powdef_alpha = 0.95` would be including this option and setting \(\alpha = 0.95\).

## 5.4 Trimming extreme values (`smooth` mode)

One adaptation (not described in the manuscript) that addresses unduly influential outliers is to apply an alternative smoothing procedure that narrows the range of the \(\chi^2\)-transformed values by symmetrically trimming the top \(n\) fraction of extreme values (\(n\) defaults to \(.01\) and can be set with the `pct_trim` argument). Since the `corral` matrix pre-processing procedure transforms the values into standardized \(\chi^2\) space, they can be considered proportional to the significance of difference between observed and expected abundance for a given gene in a given cell. This approach differs from power deflation in that it only adjusts the most extreme values, and explicitly so, whereas power deflation shifts the distribution of all values to be less extreme.

This additional pre-processing step can be applied in `corral` by setting the `smooth` argument to `TRUE` (it defaults to `FALSE`), and this mode only works with standardized and indexed residuals options.

```
zm8eq.corral <- corral(zm8eq, fullout = TRUE)
zm8eq.corralsmooth <- corral(zm8eq, fullout = TRUE, smooth = TRUE)
```

# 6 Visualizing links between features and sub-populations with biplots

Reduced dimension embeddings are often used to find relationships between observations. `corral` can be used to additionally explore relationships between the features and the observations. By plotting both embeddings into the same space, the biplot reveals potential associations between the “rows” and “columns” – in this case, cells and genes.

Influential features in a given dimension will be further from the origin, and features strongly associated to a particular cluster of observations will be close in terms of vector direction (e.g., cosine similarity).

```
gene_names <- rowData(zm4eq.sce)$symbol

biplot_corral(corral_obj = zm4eq.countcorral, color_vec = celltype_vec, text_vec = gene_names)
```

![](data:image/png;base64...)

For example, in this case, in the general direction of the B cells, there is the MALAT1 gene, which is a B cell marker. Considering the side of the plot with the CD14 monocytes, by showing which genes are closer to which subpopulation, the biplot can help characterize the different groups of cells.

# 7 Session information

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
##  [1] scater_1.38.0               scuttle_1.20.0
##  [3] DuoClustering2018_1.27.0    ggplot2_4.0.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           corral_1.20.0
## [17] gridExtra_2.3               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   httr2_1.2.1
##   [3] rlang_1.1.6                 magrittr_2.0.4
##   [5] compiler_4.5.1              RSQLite_2.4.3
##   [7] png_0.1-8                   vctrs_0.6.5
##   [9] maps_3.4.3                  reshape2_1.4.4
##  [11] stringr_1.5.2               pkgconfig_2.0.3
##  [13] crayon_1.5.3                fastmap_1.2.0
##  [15] dbplyr_2.5.1                magick_2.9.0
##  [17] XVector_0.50.0              labeling_0.4.3
##  [19] rmarkdown_2.30              ggbeeswarm_0.7.2
##  [21] tinytex_0.57                purrr_1.1.0
##  [23] bit_4.6.0                   xfun_0.53
##  [25] MultiAssayExperiment_1.36.0 beachmat_2.26.0
##  [27] cachem_1.1.0                pals_1.10
##  [29] jsonlite_2.0.0              blob_1.2.4
##  [31] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [33] parallel_4.5.1              irlba_2.3.5.1
##  [35] R6_2.6.1                    bslib_0.9.0
##  [37] stringi_1.8.7               RColorBrewer_1.1-3
##  [39] jquerylib_0.1.4             Rcpp_1.1.0
##  [41] bookdown_0.45               knitr_1.50
##  [43] FNN_1.1.4.1                 BiocBaseUtils_1.12.0
##  [45] Matrix_1.7-4                tidyselect_1.2.1
##  [47] dichromat_2.0-0.1           abind_1.4-8
##  [49] yaml_2.3.10                 viridis_0.6.5
##  [51] codetools_0.2-20            curl_7.0.0
##  [53] lattice_0.22-7              tibble_3.3.0
##  [55] plyr_1.8.9                  withr_3.0.2
##  [57] KEGGREST_1.50.0             S7_0.2.0
##  [59] Rtsne_0.17                  evaluate_1.0.5
##  [61] BiocFileCache_3.0.0         ExperimentHub_3.0.0
##  [63] mclust_6.1.1                Biostrings_2.78.0
##  [65] pillar_1.11.1               BiocManager_1.30.26
##  [67] filelock_1.0.3              BiocVersion_3.22.0
##  [69] scales_1.4.0                glue_1.8.0
##  [71] mapproj_1.2.12              tools_4.5.1
##  [73] AnnotationHub_4.0.0         BiocNeighbors_2.4.0
##  [75] data.table_1.17.8           ScaledMatrix_1.18.0
##  [77] grid_4.5.1                  tidyr_1.3.1
##  [79] AnnotationDbi_1.72.0        colorspace_2.1-2
##  [81] beeswarm_0.4.0              BiocSingular_1.26.0
##  [83] vipor_0.4.7                 rsvd_1.0.5
##  [85] cli_3.6.5                   rappdirs_0.3.3
##  [87] ggthemes_5.1.0              S4Arrays_1.10.0
##  [89] viridisLite_0.4.2           dplyr_1.1.4
##  [91] uwot_0.2.3                  gtable_0.3.6
##  [93] sass_0.4.10                 digest_0.6.37
##  [95] ggrepel_0.9.6               SparseArray_1.10.0
##  [97] farver_2.1.2                memoise_2.0.1
##  [99] htmltools_0.5.8.1           lifecycle_1.0.4
## [101] httr_1.4.7                  transport_0.15-4
## [103] bit64_4.6.0-1
```

# References

Duò, A, MD Robinson, and C Soneson. n.d. “A Systematic Performance Evaluation of Clustering Methods for Single-Cell Rna-Seq Data [Version 2; Peer Review: 2 Approved], Journal = F1000Research, Volume = 7, Year = 2018, Number = 1141, Doi = 10.12688/f1000research.15666.2.”

Zheng, Grace X. Y., Jessica M. Terry, Phillip Belgrader, Paul Ryvkin, Zachary W. Bent, Ryan Wilson, Solongo B. Ziraldo, et al. 2017. “Massively Parallel Digital Transcriptional Profiling of Single Cells.” *Nature Communications* 8 (1): 14049. <https://doi.org/10.1038/ncomms14049>.