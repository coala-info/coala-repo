# Differential detection analysis

Jeroen Gilis1,2,3, Helena L Crowell4, Davide Risso5,6 and Lieven Clement1,2

1Applied Mathematics, Computer science and Statistics, Ghent University, Ghent, Belgium
2Bioinformatics Institute, Ghent University, Ghent, Belgium
3Data Mining and Modeling for Biomedicine, VIB Flemish Institute for Biotechnology, Ghent, Belgium
4National Center for Genomic Analysis (CNAG), Barcelona, Spain
5Department of Statistical Sciences, University of Padova, Padova, Italy
6Padua Center for Network Medicine, University of Padova, Padova, Italy

#### October 30, 2025

#### Abstract

In this vignette, we display how `muscat` can be used to perform differrential detection (DD) analyses in multi-sample, multi-group, multi-(cell-)subpopulation scRNA-seq data. Furthermore, we show how DD and differential state (DS) analysis results on the same data can be effectively combined. This vignette thus introduces a workflow that allows users to jointly assess two biological hypotheses that often contain orthogonal information, which thus can be expected to improve their understanding of complex biological phenomena, at no extra cost.

#### Package

muscat 1.24.0

# Contents

* [Load packages](#load-packages)
* [1 Introduction](#introduction)
* [2 Setup](#setup)
  + [2.1 Aggregation](#aggregation)
  + [2.2 Analysis](#analysis)
  + [2.3 Handling and visualizing results](#handling-and-visualizing-results)
* [3 Stagewise anaysis](#stagewise-anaysis)
  + [3.1 Comparison](#comparison)
* [Session info](#session-info)
* [References](#references)

---

Based on Gilis et al. ([2023](#ref-Gilis2023))

> Gilis J, Perin L, Malfait M, Van den Berge K,

# Load packages

```
library(dplyr)
library(purrr)
library(tidyr)
library(scater)
library(muscat)
library(ggplot2)
library(patchwork)
```

# 1 Introduction

Single-cell RNA-sequencing (scRNA-seq) has improved our understanding of complex biological processes by elucidating cell-level heterogeneity in gene expression. One of the key tasks in the downstream analysis of scRNA-seq data is studying differential gene expression (DE). Most DE analysis methods aim to identify genes for which the *average* expression differs between biological groups of interest, e.g., between cell types or between diseased and healthy cells. As such, most methods allow for assessing only one aspect of the gene expression distribution: the mean. However, in scRNA-seq data, differences in other characteristics between count distributions can commonly be observed.

One such characteristic is gene detection, i.e., the number of cells in which a gene is (detectably) expressed. Analogous to a DE analysis, a differential detection (DD) analysis aims to identify genes for which the *average fraction of cells in which the gene is detected* changes between groups. In Gilis et al. ([2023](#ref-Gilis2023)), we show how DD analysis contain information that is biologically relevant, and that is largely orthogonal to the information obtained from DE analysis on the same data.

In this vignette, we display how `muscat` can be used to perform DD analyses in multi-sample, multi-group, multi-(cell-)subpopulation scRNA-seq data. Furthermore, we show how DD and DS analysis results on the same data can be effectively combined using a two-stage testing approach. This workflow thus allows users to jointly assess two biological hypotheses containing orthogonal information, which thus can be expected to improve their understanding of complex biological phenomena, at no extra cost.

# 2 Setup

We will use the same data as in the differential state (DS) analyses described in *[muscat](https://bioconductor.org/packages/3.22/muscat/vignettes/analysis.html)*, namely, scRNA-seq data acquired on PBMCs from 8 patients before and after IFN-\(\beta\) treatment. For a more detailed description of these data and subsequent preprocessing, we refer to *[muscat](https://bioconductor.org/packages/3.22/muscat/vignettes/analysis.html)*.

```
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "Kang")
```

```
## ExperimentHub with 3 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: NCI_GDC, GEO
## # $species: Homo sapiens
## # $rdataclass: character, SingleCellExperiment, BSseq
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH1661"]]'
##
##            title
##   EH1661 | Whole Genome Bisulfit Sequencing Data for 47 samples
##   EH1662 | Whole Genome Bisulfit Sequencing Data for 47 samples
##   EH2259 | Kang18_8vs8
```

```
(sce <- eh[["EH2259"]])
```

```
## class: SingleCellExperiment
## dim: 35635 29065
## metadata(0):
## assays(1): counts
## rownames(35635): MIR1302-10 FAM138A ... MT-ND6 MT-CYB
## rowData names(2): ENSEMBL SYMBOL
## colnames(29065): AAACATACAATGCC-1 AAACATACATTTCC-1 ... TTTGCATGGTTTGG-1
##   TTTGCATGTCTTAC-1
## colData names(5): ind stim cluster cell multiplets
## reducedDimNames(1): TSNE
## mainExpName: NULL
## altExpNames(0):
```

We further apply some minimal filtering to remove low-quality genes and cells, and use `prepSCE()` to standardize cell metadata such that slots specifying cluster (`cell`), sample (`stim`+`ind`), and group (`stim`) identifiers conform with the `muscat` framework:

```
sce <- sce[rowSums(counts(sce) > 0) > 0, ]
qc <- perCellQCMetrics(sce)
sce <- sce[, !isOutlier(qc$detected, nmads=2, log=TRUE)]
sce <- sce[rowSums(counts(sce) > 1) >= 10, ]
sce$id <- paste0(sce$stim, sce$ind)
sce <- prepSCE(sce, "cell", "id", "stim")
table(sce$cluster_id, sce$group_id)
```

```
##
##                     ctrl stim
##   B cells           1422 1313
##   CD14+ Monocytes   2855 2662
##   CD4 T cells       5874 5897
##   CD8 T cells       1369 1188
##   Dendritic cells     90  130
##   FCGR3A+ Monocytes  698  791
##   Megakaryocytes     117  130
##   NK cells          1038 1246
```

```
table(sce$sample_id)
```

```
##
##  ctrl101 ctrl1015 ctrl1016 ctrl1039  ctrl107 ctrl1244 ctrl1256 ctrl1488
##      912     2880     2062      436      586     2091     2267     2229
##  stim101 stim1015 stim1016 stim1039  stim107 stim1244 stim1256 stim1488
##     1197     2494     1901      639      578     1642     2127     2779
```

## 2.1 Aggregation

In general, `aggregateData()` will aggregate the data by the `colData` variables specified with argument `by`, and return a `SingleCellExperiment` containing pseudobulk data.

To perform a pseudobulk-level analysis, measurements must be aggregated at the cluster-sample level (default `by = c("cluster_id", "sample_id"`). In this case, the returned `SingleCellExperiment` will contain one assay per cluster, where rows = genes and columns = samples. Arguments `assay` and `fun` specify the input data and summary statistic, respectively, to use for aggregation.

In a differential detection (DD) analysis, the default choice of the summary statistic used for aggregation is `fun = "num.detected"`. This strategy can be thought of as first binarizing the gene expression values (1: expressed, 0: not expressed), and subsequently performing a simple summation of the binarized gene expression counts for cells belonging to the same cluster-sample level. Hence, the resulting pseudobulk-level expression count reflects the total number of cells in a particular cluster-sample level with a non-zero gene expression value.

In a differential state (DS) analysis, the default choice for aggregation is `fun = "sum"`, which amounts to the simple summation of the raw gene expression counts of cells belonging to the same cluster-sample level.

```
pb_sum <- aggregateData(sce,
    assay="counts", fun="sum",
    by=c("cluster_id", "sample_id"))
pb_det <- aggregateData(sce,
    assay="counts", fun="num.detected",
    by=c("cluster_id", "sample_id"))
t(head(assay(pb_det)))
```

```
##          NOC2L HES4 ISG15 TNFRSF18 TNFRSF4 SDF4
## ctrl101     11    0    10        7       1   10
## ctrl1015    37    4    86       43      10   39
## ctrl1016    12    2    30        7       0   15
## ctrl1039     2    1    10        3       1    1
## ctrl107      5    0     4        3       1    5
## ctrl1244    17    5    14       17       4    6
## ctrl1256    21    1    45       22       6   16
## ctrl1488    16    1    28       18       3   20
## stim101     12    8   142        3       1    8
## stim1015    32   26   356       16       2   16
## stim1016     5    7   129        1       3    6
## stim1039     2    2    39        1       1    1
## stim107      3    2    56        1       0    3
## stim1244    11    9    93        5       2    5
## stim1256    14    8   210        8       1    6
## stim1488    16    4   282        9       1   15
```

Qiu ([2020](#ref-Qiu2020)) demonstrated that binarizing scRNA-seq counts generates expression profiles that still accurately reflect biological variation.
This finding was confirmed by Bouland, Mahfouz, and Reinders ([2021](#ref-Bouland2021)), who showed that the frequencies of zero counts capture biological variability, and further claimed that a binarized representation of the single-cell expression data allows for a more robust description of the relative abundance of transcripts than counts.

```
pbMDS(pb_sum) + ggtitle("Σ counts") +
pbMDS(pb_det) + ggtitle("# detected") +
plot_layout(guides="collect") +
plot_annotation(tag_levels="A") &
theme(legend.key.size=unit(0.5, "lines"))
```

![Pseudobulk-level multidimensional scaling (MDS) plot based on (A) sum of counts and (B) sum of binarized counts (i.e., counting the number of detected features) in each cluster-sample.](data:image/png;base64...)

Figure 1: Pseudobulk-level multidimensional scaling (MDS) plot based on (A) sum of counts and (B) sum of binarized counts (i.e., counting the number of detected features) in each cluster-sample

## 2.2 Analysis

Once we have assembled the pseudobulk data, we can test for DD using `pbDD()`. By default, a \(\sim\)`group_id` model is fit, and the last coefficient of the linear model is tested to be equal to zero.

```
res_DD <- pbDD(pb_det, min_cells=0, filter="none", verbose=FALSE)
```

## 2.3 Handling and visualizing results

Inspection, manipulation, and visualization of DD analysis results follows the same principles as for a DS analysis. For a detailed description, we refer to the DS analysis vignette*[muscat](https://bioconductor.org/packages/3.22/muscat/vignettes/analysis.html)*. Below, some basic functionalities are being displayed.

```
tbl <- res_DD$table[[1]]
# one data.frame per cluster
names(tbl)
```

```
## [1] "B cells"           "CD14+ Monocytes"   "CD4 T cells"
## [4] "CD8 T cells"       "Dendritic cells"   "FCGR3A+ Monocytes"
## [7] "Megakaryocytes"    "NK cells"
```

```
# view results for 1st cluster
k1 <- tbl[[1]]
head(format(k1[, -ncol(k1)], digits = 2))
```

```
##       gene cluster_id    logFC logCPM       F    p_val p_adj.loc p_adj.glb
## 1    NOC2L    B cells -0.30298    7.6 2.4e+00  1.2e-01   2.9e-01   3.1e-01
## 2     HES4    B cells  2.20193    6.5 3.5e+01  1.1e-08   2.4e-07   2.8e-07
## 3    ISG15    B cells  2.56778   10.3 1.1e+03  6.2e-88   7.2e-85   5.8e-84
## 4 TNFRSF18    B cells -1.38247    7.3 3.4e+01  1.6e-08   3.4e-07   4.0e-07
## 5  TNFRSF4    B cells -1.12662    5.8 5.7e+00  1.8e-02   7.5e-02   8.0e-02
## 6     SDF4    B cells -0.84449    7.3 1.5e+01  1.7e-04   1.7e-03   1.7e-03
```

```
# filter FDR < 5%, |logFC| > 1 & sort by adj. p-value
tbl_fil <- lapply(tbl, \(u)
    filter(u,
        p_adj.loc < 0.05,
        abs(logFC) > 1) |>
        arrange(p_adj.loc))

# nb. of DS genes & % of total by cluster
n_de <- vapply(tbl_fil, nrow, numeric(1))
p_de <- format(n_de / nrow(sce) * 100, digits = 3)
data.frame("#DD" = n_de, "%DD" = p_de, check.names = FALSE)
```

```
##                    #DD   %DD
## B cells            715 10.04
## CD14+ Monocytes   1983 27.86
## CD4 T cells        498  7.00
## CD8 T cells        333  4.68
## Dendritic cells    277  3.89
## FCGR3A+ Monocytes 1110 15.59
## Megakaryocytes     109  1.53
## NK cells           423  5.94
```

```
library(UpSetR)
de_gs_by_k <- map(tbl_fil, "gene")
upset(fromList(de_gs_by_k))
```

![](data:image/png;base64...)

# 3 Stagewise anaysis

While DD analysis results may contain biologically relevant information in their own right, we show in Gilis et al. ([2023](#ref-Gilis2023)) that combing DD and DS analysis results on the same data can further improve our understanding of complex biological phenomena. In the remainder of this vignette, we show how DD and DS analysis results on the same data can be effectively combined.

For this, we build on the two-stage testing paradigm proposed by Van den Berge et al. ([2017](#ref-Vandenberge2017)). In the first stage of this testing procedure, we identify differential genes by using an omnibus test for differential detection and differential expression (DE). The null hypothesis for this test is that the gene is neither differentially detected, nor differentially expressed.

In the second stage, we perform post-hoc tests on the differential genes from stage one to unravel whether they are DD, DE or both. Compared to the individual DD and DS analysis results, the two-stage approach increases statistical power and provides better type 1 error control.

```
res_DS <- pbDS(pb_sum, min_cells=0, filter="none", verbose=FALSE)
```

```
res <- stagewise_DS_DD(res_DS, res_DD, verbose=FALSE)
head(res[[1]][[1]]) # results for 1st cluster
```

```
## DataFrame with 6 rows and 8 columns
##          gene       p_adj    p_val.DS    p_val.DD  cluster_id    contrast
##   <character>   <numeric>   <numeric>   <numeric> <character> <character>
## 1       NOC2L 3.73101e-01          NA          NA     B cells        stim
## 2        HES4 4.68059e-07 1.35723e-05 5.50416e-08     B cells        stim
## 3       ISG15 1.46213e-84 2.69203e-32 3.14212e-87     B cells        stim
## 4    TNFRSF18 6.82446e-07 1.01290e-04 8.14603e-08     B cells        stim
## 5     TNFRSF4 1.24340e-02 4.71896e-03 9.06526e-02     B cells        stim
## 6        SDF4 3.21041e-03 6.90684e-02 8.68584e-04     B cells        stim
##                           res_DS                         res_DD
##                     <data.frame>                   <data.frame>
## 1    NOC2L:B cells:-0.208861:...    NOC2L:B cells:-0.302977:...
## 2     HES4:B cells: 2.225205:...     HES4:B cells: 2.201933:...
## 3    ISG15:B cells: 5.521694:...    ISG15:B cells: 2.567783:...
## 4 TNFRSF18:B cells:-1.271517:... TNFRSF18:B cells:-1.382466:...
## 5  TNFRSF4:B cells:-1.645401:...  TNFRSF4:B cells:-1.126618:...
## 6     SDF4:B cells:-0.612357:...     SDF4:B cells:-0.844490:...
```

## 3.1 Comparison

```
# for each approach, get adjusted p-values across clusters
ps <- map_depth(res, 2, \(df) {
    data.frame(
        df[, c("gene", "cluster_id")],
        p_adj.stagewise=df$p_adj,
        p_adj.DS=df$res_DS$p_adj.loc,
        p_adj.DD=df$res_DD$p_adj.loc)
}) |>
    lapply(do.call, what=rbind) |>
    do.call(what=rbind) |>
    data.frame(row.names=NULL)
head(ps)
```

```
##       gene cluster_id p_adj.stagewise     p_adj.DS     p_adj.DD
## 1    NOC2L    B cells    3.731007e-01 6.065349e-01 2.864466e-01
## 2     HES4    B cells    4.680591e-07 5.706921e-05 2.379679e-07
## 3    ISG15    B cells    1.462131e-84 1.879035e-29 7.245169e-85
## 4 TNFRSF18    B cells    6.824459e-07 3.588867e-04 3.446482e-07
## 5  TNFRSF4    B cells    1.243400e-02 9.547347e-03 7.487607e-02
## 6     SDF4    B cells    3.210414e-03 8.075329e-02 1.721607e-03
```

To get an overview of how different approaches compare, we can count the number of genes found differential in each cluster for a given FDR threshold:

```
# for each approach & cluster, count number
# of genes falling below 5% FDR threshold
ns <- lapply(seq(0, 0.2, 0.005), \(th) {
    ps |>
        mutate(th=th) |>
        group_by(cluster_id, th) |>
        summarise(
            .groups="drop",
            across(starts_with("p_"),
            \(.) sum(. < th, na.rm=TRUE)))
}) |>
    do.call(what=rbind) |>
    pivot_longer(starts_with("p_"))
ggplot(ns, aes(th, value, col=name)) +
    geom_line(linewidth=0.8, key_glyph="point") +
    geom_vline(xintercept=0.05, lty=2, linewidth=0.4) +
    guides(col=guide_legend(NULL, override.aes=list(size=3))) +
    labs(x="FDR threshold", y="number of significantly\ndifferential genes") +
    facet_wrap(~cluster_id, scales="free_y", nrow=2) +
    theme_bw() + theme(
        panel.grid.minor=element_blank(),
        legend.key.size=unit(0.5, "lines"))
```

![](data:image/png;base64...)

We can further identify which hits are shared between or unique to a given approach.
In the example below, for instance, the vast majority of hits is common to all approaches, many hits are shared between DD and stagewise testing, and only few genes are specific to any one approach:

```
# subset adjuster p-values for cluster of interest
qs <- ps[grep("CD4", ps$cluster_id), grep("p_", names(ps))]
# for each approach, extract genes at 5% FDR threshold
gs <- apply(qs, 2, \(.) ps$gene[. < 0.05])
# visualize set intersections between approaches
UpSetR::upset(UpSetR::fromList(gs), order.by="freq")
```

![Upset plot of differential findings (FDR < 0.05) across DS, DD, and stagewise analysis for an exemplary cluster; shown are the 50 most frequent interactions.](data:image/png;base64...)

Figure 2: Upset plot of differential findings (FDR < 0.05) across DS, DD, and stagewise analysis for an exemplary cluster; shown are the 50 most frequent interactions

```
# extract genes unique to stagewise testing
sw <- grep("stagewise", names(gs))
setdiff(gs[[sw]], unlist(gs[-sw]))
```

```
## [1] "OLIG1"   "MRPL39"  "SLC31A1"
```

# Session info

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
##  [1] tidyr_1.3.1                 UpSetR_1.4.0
##  [3] scater_1.38.0               scuttle_1.20.0
##  [5] muscData_1.23.0             SingleCellExperiment_1.32.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [17] BiocFileCache_3.0.0         dbplyr_2.5.1
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] purrr_1.1.0                 muscat_1.24.0
## [23] limma_3.66.0                ggplot2_4.0.0
## [25] dplyr_1.1.4                 cowplot_1.2.0
## [27] patchwork_1.3.2             BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22         splines_4.5.1            filelock_1.0.3
##   [4] bitops_1.0-9             tibble_3.3.0             lpsymphony_1.38.0
##   [7] httr2_1.2.1              lifecycle_1.0.4          Rdpack_2.6.4
##  [10] edgeR_4.8.0              doParallel_1.0.17        globals_0.18.0
##  [13] lattice_0.22-7           MASS_7.3-65              backports_1.5.0
##  [16] magrittr_2.0.4           sass_0.4.10              rmarkdown_2.30
##  [19] jquerylib_0.1.4          yaml_2.3.10              sctransform_0.4.2
##  [22] DBI_1.2.3                minqa_1.2.8              RColorBrewer_1.1-3
##  [25] multcomp_1.4-29          abind_1.4-8              EnvStats_3.1.0
##  [28] glmmTMB_1.1.13           TH.data_1.1-4            rappdirs_0.3.3
##  [31] sandwich_3.1-1           circlize_0.4.16          ggrepel_0.9.6
##  [34] pbkrtest_0.5.5           irlba_2.3.5.1            listenv_0.9.1
##  [37] parallelly_1.45.1        codetools_0.2-20         DelayedArray_0.36.0
##  [40] tidyselect_1.2.1         shape_1.4.6.1            farver_2.1.2
##  [43] lme4_1.1-37              ScaledMatrix_1.18.0      viridis_0.6.5
##  [46] jsonlite_2.0.0           GetoptLong_1.0.5         BiocNeighbors_2.4.0
##  [49] survival_3.8-3           iterators_1.0.14         emmeans_2.0.0
##  [52] foreach_1.5.2            tools_4.5.1              progress_1.2.3
##  [55] Rcpp_1.1.0               blme_1.0-6               glue_1.8.0
##  [58] gridExtra_2.3            SparseArray_1.10.0       xfun_0.53
##  [61] mgcv_1.9-3               DESeq2_1.50.0            stageR_1.32.0
##  [64] withr_3.0.2              numDeriv_2016.8-1.1      BiocManager_1.30.26
##  [67] fastmap_1.2.0            boot_1.3-32              caTools_1.18.3
##  [70] digest_0.6.37            rsvd_1.0.5               R6_2.6.1
##  [73] estimability_1.5.1       colorspace_2.1-2         Cairo_1.7-0
##  [76] gtools_3.9.5             dichromat_2.0-0.1        RSQLite_2.4.3
##  [79] RhpcBLASctl_0.23-42      variancePartition_1.40.0 data.table_1.17.8
##  [82] corpcor_1.6.10           httr_1.4.7               prettyunits_1.2.0
##  [85] S4Arrays_1.10.0          uwot_0.2.3               pkgconfig_2.0.3
##  [88] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
##  [91] S7_0.2.0                 XVector_0.50.0           remaCor_0.0.20
##  [94] htmltools_0.5.8.1        bookdown_0.45            TMB_1.9.18
##  [97] clue_0.3-66              scales_1.4.0             png_0.1-8
## [100] fANCOVA_0.6-1            reformulas_0.4.2         knitr_1.50
## [103] reshape2_1.4.4           rjson_0.2.23             curl_7.0.0
## [106] coda_0.19-4.1            nlme_3.1-168             nloptr_2.2.1
## [109] cachem_1.1.0             zoo_1.8-14               GlobalOptions_0.1.2
## [112] stringr_1.5.2            BiocVersion_3.22.0       KernSmooth_2.23-26
## [115] parallel_4.5.1           vipor_0.4.7              AnnotationDbi_1.72.0
## [118] pillar_1.11.1            grid_4.5.1               vctrs_0.6.5
## [121] gplots_3.2.0             slam_0.1-55              BiocSingular_1.26.0
## [124] IHW_1.38.0               beachmat_2.26.0          xtable_1.8-4
## [127] cluster_2.1.8.1          beeswarm_0.4.0           evaluate_1.0.5
## [130] magick_2.9.0             tinytex_0.57             mvtnorm_1.3-3
## [133] cli_3.6.5                locfit_1.5-9.12          compiler_4.5.1
## [136] rlang_1.1.6              crayon_1.5.3             future.apply_1.20.0
## [139] labeling_0.4.3           fdrtool_1.2.18           plyr_1.8.9
## [142] ggbeeswarm_0.7.2         stringi_1.8.7            viridisLite_0.4.2
## [145] BiocParallel_1.44.0      Biostrings_2.78.0        lmerTest_3.1-3
## [148] aod_1.3.3                Matrix_1.7-4             hms_1.1.4
## [151] bit64_4.6.0-1            future_1.67.0            KEGGREST_1.50.0
## [154] statmod_1.5.1            rbibutils_2.3            memoise_2.0.1
## [157] broom_1.0.10             bslib_0.9.0              bit_4.6.0
```

# References

Bouland, Gerard A, Ahmed Mahfouz, and Marcel J T Reinders. 2021. “Differential Analysis of Binarized Single-Cell RNA Sequencing Data Captures Biological Variation.” *NAR Genomics and Bioinformatics* 3 (4): lqab118.

Gilis, Jeroen, Laura Perin, Milan Malfait, Koen Van den Berge, Alemu Takele Assefa, Bie Verbist, Davide Risso, and Lieven Clement. 2023. “Differential Detection Workflows for Multi-Sample Single-Cell RNA-seq Data.” *bioRxiv*.

Qiu, Peng. 2020. “Embracing the Dropouts in Single-Cell RNA-seq Analysis.” *Nature Communications* 11 (1): 1169.

Van den Berge, Koen, Charlotte Soneson, Mark D Robinson, and Lieven Clement. 2017. “StageR: A General Stage-Wise Method for Controlling the Gene-Level False Discovery Rate in Differential Expression and Differential Transcript Usage.” *Genome Biology* 18 (151).