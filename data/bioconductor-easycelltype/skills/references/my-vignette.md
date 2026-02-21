# EasyCellType: an example workflow

#### 29 October 2025

# Contents

* [1. Introduction](#introduction)
  + [Installation](#installation)
* [2. Example workflow](#example-workflow)
* [3. Reference](#reference)

## 1. Introduction

The `EasyCellType` package was designed to examine an input marker list using
the databases and provide annotation recommendations in graphical outcomes.
The package refers to 3 public available marker gene data bases,
and provides two approaches to conduct the annotation anaysis:
gene set enrichment analysis(GSEA) and a modified Fisher’s exact test.
The package has been submitted to `bioconductor` to achieve an easy access for researchers.

This vignette shows a simple workflow illustrating how EasyCellType package works.
The data set that will be used throughout the example is freely available from
10X Genomics.

### Installation

The package can be installed using `BiocManager` by the following commands

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EasyCellType")
```

Alternatively, the package can also be installed using `devtools` and launched by

```
library(devtools)
install_github("rx-li/EasyCellType")
```

After the installation, the package can be loaded with

```
library(EasyCellType)
```

## 2. Example workflow

We use the Peripheral Blood Mononuclear Cells (PBMC) data freely available from 10X Genomics.
The data can be downladed from
<https://cf.10xgenomics.com/samples/cell/pbmc3k/pbmc3k_filtered_gene_bc_matrices.tar.gz>.
After downloading the data, it can be read using function `Read10X`.

We have included the data in our package, which can be loaded with

```
data(pbmc_data)
```

We followed the standard workflow provided by `Seurat` package(Hao et al. [2021](#ref-seurat)) to process the PBMC data set.
The detailed technical explanations can be found in
<https://satijalab.org/seurat/articles/pbmc3k_tutorial.html>.

```
library(Seurat)
# Initialize the Seurat object
pbmc <- CreateSeuratObject(counts = pbmc_data, project = "pbmc3k", min.cells = 3, min.features = 200)
# QC and select samples
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
# Normalize the data
pbmc <- NormalizeData(pbmc)
# Identify highly variable features
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)
# Scale the data
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
# Perfom linear dimensional reduction
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
# Cluster the cells
pbmc <- FindNeighbors(pbmc, dims = 1:10)
pbmc <- FindClusters(pbmc, resolution = 0.5)
# Find differentially expressed features
markers <- FindAllMarkers(pbmc, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
```

Now we get the expressed markers for each cluster.
We then convert the gene symbols to Entrez IDs.

```
library(org.Hs.eg.db)
library(AnnotationDbi)
markers$entrezid <- mapIds(org.Hs.eg.db,
                           keys=markers$gene, #Column containing Ensembl gene ids
                           column="ENTREZID",
                           keytype="SYMBOL",
                           multiVals="first")
markers <- na.omit(markers)
```

In case the data is measured in mouse, we would replace the package `org.Hs.eg.db`
with `org.Mm.eg.db` and do the above analysis.

The input for `EasyCellType` package should be a data frame containing Entrez IDs,
clusters and expression scores. The order of columns should follow this rule.
In each cluster, the gene should be sorted by the expression score.

```
library(dplyr)
markers_sort <- data.frame(gene=markers$entrezid, cluster=markers$cluster,
                      score=markers$avg_log2FC) %>%
  group_by(cluster) %>%
  mutate(rank = rank(score),  ties.method = "random") %>%
  arrange(desc(rank))
input.d <- as.data.frame(markers_sort[, 1:3])
```

We have include the processed data in the package. It can be loaded with

```
data("gene_pbmc")
input.d <- gene_pbmc
```

Now we can call the `annot` function to run annotation analysis.

```
annot.GSEA <- easyct(input.d, db="cellmarker", species="Human",
                    tissue=c("Blood", "Peripheral blood", "Blood vessel",
                      "Umbilical cord blood", "Venous blood"), p_cut=0.3,
                    test="GSEA")
```

We used the GSEA approach to do the annotation. In our package, we use `GSEA`
function in `clusterProfiler` package(Wu et al. [2021](#ref-clusterprofiler)) to conduct the enrichment analysis.
You can replace ‘GSEA’ with ‘fisher’ if you would like to use Fisher exact test
to do the annotation.
The candidate tissues can be seen using `data(cellmarker_tissue)`,
`data(clustermole_tissue)` and `data(panglao_tissue)`.

The dot plot showing the overall annotation results can be created by

```
plot_dot(test="GSEA", annot.GSEA)
```

![](data:image/png;base64...)

Bar plot can be created by

```
plot_bar(test="GSEA", annot.GSEA)
```

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] dplyr_1.1.4          org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0
#>  [4] IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
#>  [7] BiocGenerics_0.56.0  generics_0.1.4       future_1.67.0
#> [10] Seurat_5.3.1         SeuratObject_5.2.0   sp_2.2-0
#> [13] EasyCellType_1.5.4   devtools_2.4.6       usethis_3.2.1
#> [16] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] fs_1.6.6                matrixStats_1.5.0       spatstat.sparse_3.1-0
#>   [4] enrichplot_1.30.0       httr_1.4.7              RColorBrewer_1.1-3
#>   [7] tools_4.5.1             sctransform_0.4.2       R6_2.6.1
#>  [10] lazyeval_0.2.2          uwot_0.2.3              withr_3.0.2
#>  [13] gridExtra_2.3           progressr_0.17.0        cli_3.6.5
#>  [16] spatstat.explore_3.5-3  fastDummies_1.7.5       sass_0.4.10
#>  [19] S7_0.2.0                spatstat.data_3.1-9     ggridges_0.5.7
#>  [22] pbapply_1.7-4           systemfonts_1.3.1       yulab.utils_0.2.1
#>  [25] gson_0.1.0              DOSE_4.4.0              R.utils_2.13.0
#>  [28] dichromat_2.0-0.1       parallelly_1.45.1       sessioninfo_1.2.3
#>  [31] limma_3.66.0            RSQLite_2.4.3           gridGraphics_0.5-1
#>  [34] ica_1.0-3               spatstat.random_3.4-2   GO.db_3.22.0
#>  [37] Matrix_1.7-4            abind_1.4-8             R.methodsS3_1.8.2
#>  [40] lifecycle_1.0.4         yaml_2.3.10             qvalue_2.42.0
#>  [43] Rtsne_0.17              grid_4.5.1              blob_1.2.4
#>  [46] promises_1.4.0          crayon_1.5.3            miniUI_0.1.2
#>  [49] ggtangle_0.0.7          lattice_0.22-7          cowplot_1.2.0
#>  [52] KEGGREST_1.50.0         magick_2.9.0            pillar_1.11.1
#>  [55] knitr_1.50              fgsea_1.36.0            future.apply_1.20.0
#>  [58] codetools_0.2-20        fastmatch_1.1-6         glue_1.8.0
#>  [61] ggiraph_0.9.2           ggfun_0.2.0             spatstat.univar_3.1-4
#>  [64] fontLiberation_0.1.0    data.table_1.17.8       remotes_2.5.0
#>  [67] vctrs_0.6.5             png_0.1-8               treeio_1.34.0
#>  [70] spam_2.11-1             org.Mm.eg.db_3.22.0     gtable_0.3.6
#>  [73] cachem_1.1.0            xfun_0.53               mime_0.13
#>  [76] Seqinfo_1.0.0           survival_3.8-3          tinytex_0.57
#>  [79] statmod_1.5.1           ellipsis_0.3.2          fitdistrplus_1.2-4
#>  [82] ROCR_1.0-11             nlme_3.1-168            ggtree_4.0.0
#>  [85] bit64_4.6.0-1           fontquiver_0.2.1        RcppAnnoy_0.0.22
#>  [88] bslib_0.9.0             irlba_2.3.5.1           KernSmooth_2.23-26
#>  [91] otel_0.2.0              DBI_1.2.3               tidyselect_1.2.1
#>  [94] processx_3.8.6          bit_4.6.0               compiler_4.5.1
#>  [97] curl_7.0.0              desc_1.4.3              fontBitstreamVera_0.1.1
#> [100] plotly_4.11.0           bookdown_0.45           scales_1.4.0
#> [103] lmtest_0.9-40           callr_3.7.6             rappdirs_0.3.3
#> [106] stringr_1.5.2           digest_0.6.37           goftest_1.2-3
#> [109] spatstat.utils_3.2-0    rmarkdown_2.30          XVector_0.50.0
#> [112] htmltools_0.5.8.1       pkgconfig_2.0.3         fastmap_1.2.0
#> [115] rlang_1.1.6             htmlwidgets_1.6.4       shiny_1.11.1
#> [118] farver_2.1.2            jquerylib_0.1.4         zoo_1.8-14
#> [121] jsonlite_2.0.0          BiocParallel_1.44.0     GOSemSim_2.36.0
#> [124] R.oo_1.27.1             magrittr_2.0.4          ggplotify_0.1.3
#> [127] dotCall64_1.2           patchwork_1.3.2         Rcpp_1.1.0
#> [130] ape_5.8-1               gdtools_0.4.4           reticulate_1.44.0
#> [133] stringi_1.8.7           MASS_7.3-65             plyr_1.8.9
#> [136] pkgbuild_1.4.8          parallel_4.5.1          listenv_0.9.1
#> [139] ggrepel_0.9.6           forcats_1.0.1           deldir_2.0-4
#> [142] Biostrings_2.78.0       splines_4.5.1           tensor_1.5.1
#> [145] ps_1.9.1                igraph_2.2.1            spatstat.geom_3.6-0
#> [148] RcppHNSW_0.6.0          reshape2_1.4.4          pkgload_1.4.1
#> [151] evaluate_1.0.5          BiocManager_1.30.26     httpuv_1.6.16
#> [154] RANN_2.6.2              tidyr_1.3.1             purrr_1.1.0
#> [157] polyclip_1.10-7         scattermore_1.2         ggplot2_4.0.0
#> [160] xtable_1.8-4            RSpectra_0.16-2         tidytree_0.4.6
#> [163] later_1.4.4             viridisLite_0.4.2       tibble_3.3.0
#> [166] clusterProfiler_4.18.0  aplot_0.2.9             memoise_2.0.1
#> [169] cluster_2.1.8.1         globals_0.18.0
```

## 3. Reference

Hao, Yuhan, Stephanie Hao, Erica Andersen-Nissen, William M. Mauck III, Shiwei Zheng, Andrew Butler, Maddie J. Lee, et al. 2021. “Integrated Analysis of Multimodal Single-Cell Data.” *Cell*. <https://doi.org/10.1016/j.cell.2021.04.048>.

Wu, Tianzhi, Erqiang Hu, Shuangbin Xu, Meijun Chen, Pingfan Guo, Zehan Dai, Tingze Feng, et al. 2021. “ClusterProfiler 4.0: A Universal Enrichment Tool for Interpreting Omics Data.” *The Innovation*. <https://doi.org/10.1016/j.xinn.2021.100141>.