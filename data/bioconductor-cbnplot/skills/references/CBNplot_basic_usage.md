# CBNplot

#### 29 October 2025

# 1 CBNplot: Bayesian network plot for clusterProfiler results

## 1.1 Introduction

The R package to infer and plot Bayesian networks. The network are inferred from expression data based on [clusterProfiler](https://github.com/YuLab-SMU/clusterProfiler) or ReactomePA results. It makes use of libraries including [clusterProfiler](https://github.com/YuLab-SMU/clusterProfiler), [ReactomePA](https://github.com/YuLab-SMU/ReactomePA), [bnlearn](https://www.bnlearn.com/), [graphite](https://bioconductor.org/packages/release/bioc/html/graphite.html) and [depmap](https://bioconductor.org/packages/release/data/experiment/html/depmap.html). In this vignette, the description of functions and several use cases are depicted using random data. The more detailed use cases including the analysis of the dataset [GSE133624](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE133624), which contains RNA-Seq data of bladder cancer, can be found on the book (<https://noriakis.github.io/CBNplot/>).

## 1.2 Installation

```
BiocManager::install("CBNplot")
```

## 1.3 Usage

### 1.3.1 Generation of data

```
library(CBNplot)
library(bnlearn)
library(org.Hs.eg.db)

## Load data
data(gaussian.test)

## Draw genes in the KEGG pathway as DEG
kegg <- org.Hs.egPATH2EG
mapped <- mappedkeys(kegg)
genes <- as.list(kegg[mapped])[["00532"]]

## Random data
counts <- head(gaussian.test, length(genes))
row.names(counts) <- genes

## Perform enrichment analysis
pway <- clusterProfiler::enrichKEGG(gene = genes)
pway <- clusterProfiler::setReadable(pway, org.Hs.eg.db, keyType="ENTREZID")
```

### 1.3.2 The use of CBNplot

## 1.4 bngeneplot

Then use CBNplot. Basically, you need to supply the enrichment analysis result, normalized expression value and samples to be included. For `bngeneplot`, the pathway number in the `result` slot of enrichment analysis results must be given.

```
bngeneplot(results = pway,exp = counts, pathNum = 1, expRow="ENTREZID")
```

![](data:image/png;base64...)

Data frame of raw values used in the inference, data frame containing strength and direction, averaged network, and plot can be obtained by specifying `returnNet=TRUE`

```
ret <- bngeneplot(results = pway,exp = counts, pathNum = 1, returnNet=TRUE, , expRow="ENTREZID")
head(ret$str)
```

```
FALSE    from      to strength direction
FALSE 1 CHST3     UST     0.25 0.4000000
FALSE 2 CHST3 B4GALT7     0.00 0.0000000
FALSE 3 CHST3   CHSY1     0.15 0.0000000
FALSE 4 CHST3  B3GAT3     0.30 0.5833333
FALSE 5 CHST3     DSE     0.10 0.5000000
FALSE 6 CHST3  CHST11     0.10 0.5000000
```

The resulting network can be converted to `igraph` object using `bnlearn::as.igraph()`.

```
g <- bnlearn::as.igraph(ret$av)
igraph::evcent(g)$vector
```

```
## Warning: `evcent()` was deprecated in igraph 2.0.0.
## ℹ Please use `eigen_centrality()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##        CHST3          UST      B4GALT7        CHSY1       B3GAT3          DSE
## 3.365185e-16 0.000000e+00 1.538370e-15 8.660254e-01 8.660254e-01 2.884444e-16
##       CHST11       CHST15        CHPF2   CSGALNACT2       CHST12   CSGALNACT1
## 4.807407e-16 1.249926e-15 3.365185e-16 5.000000e-01 2.403703e-16 2.403703e-16
##        CHST7        XYLT1        XYLT2         CHPF       CHST14      B3GALT6
## 1.442222e-16 1.153778e-15 1.000000e+00 3.845925e-16 5.000000e-01 0.000000e+00
##       CHST13        CHSY3
## 1.442222e-16 1.153778e-15
```

## 1.5 bnpathplot

The relationship between pathways can be drawn by `bnpathplot`. The number to be included in the inference can be specified by `nCategory`.

```
bnpathplot(results = pway,exp = counts, nCategory=5, shadowText = TRUE, expRow="ENTREZID")
```

![](data:image/png;base64...)

## 1.6 bngeneplotCustom and bnpathplotCustom

`bngeneplotCustom` and `bnpathplotCustom` can be used to customize visualization with more flexibility, like highlighting the nodes and edges of interest by `glowEdgeNum` and `hub`.

```
bnpathplotCustom(results = pway, exp = counts, expRow="ENTREZID",
                 fontFamily="serif", glowEdgeNum=1, hub=1)
```

![](data:image/png;base64...)

```
bngeneplotCustom(results = pway, exp = counts, expRow="ENTREZID",
                 pathNum=1, fontFamily="sans", glowEdgeNum=NULL, hub=1)
```

![](data:image/png;base64...)

The detailed usage for the package, like including covariates to the plot and probabilistic reasoning is available in the package documentation (<https://noriakis.github.io/CBNplot/>).

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
##  [1] org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0 IRanges_2.44.0
##  [4] S4Vectors_0.48.0     Biobase_2.70.0       BiocGenerics_0.56.0
##  [7] generics_0.1.4       bnlearn_5.1          CBNplot_1.10.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3      jsonlite_2.0.0          pvclust_2.2-0
##   [4] magrittr_2.0.4          magick_2.9.0            ggtangle_0.0.7
##   [7] farver_2.1.2            rmarkdown_2.30          fs_1.6.6
##  [10] vctrs_0.6.5             memoise_2.0.1           ggtree_4.0.0
##  [13] tinytex_0.57            htmltools_0.5.8.1       distributional_0.5.0
##  [16] AnnotationHub_4.0.0     curl_7.0.0              gridGraphics_0.5-1
##  [19] sass_0.4.10             bslib_0.9.0             htmlwidgets_1.6.4
##  [22] plyr_1.8.9              httr2_1.2.1             cachem_1.1.0
##  [25] igraph_2.2.1            lifecycle_1.0.4         pkgconfig_2.0.3
##  [28] gson_0.1.0              Matrix_1.7-4            R6_2.6.1
##  [31] fastmap_1.2.0           digest_0.6.37           aplot_0.2.9
##  [34] enrichplot_1.30.0       patchwork_1.3.2         ExperimentHub_3.0.0
##  [37] RSQLite_2.4.3           labeling_0.4.3          filelock_1.0.3
##  [40] httr_1.4.7              polyclip_1.10-7         compiler_4.5.1
##  [43] bit64_4.6.0-1           fontquiver_0.2.1        withr_3.0.2
##  [46] graphite_1.56.0         S7_0.2.0                BiocParallel_1.44.0
##  [49] viridis_0.6.5           DBI_1.2.3               ggforce_0.5.0
##  [52] R.utils_2.13.0          MASS_7.3-65             rappdirs_0.3.3
##  [55] tools_4.5.1             ape_5.8-1               R.oo_1.27.1
##  [58] glue_1.8.0              nlme_3.1-168            GOSemSim_2.36.0
##  [61] grid_4.5.1              reshape2_1.4.4          fgsea_1.36.0
##  [64] gtable_0.3.6            R.methodsS3_1.8.2       tidyr_1.3.1
##  [67] data.table_1.17.8       tidygraph_1.3.1         XVector_0.50.0
##  [70] ggdist_3.3.3            ggrepel_0.9.6           BiocVersion_3.22.0
##  [73] pillar_1.11.1           stringr_1.5.2           yulab.utils_0.2.1
##  [76] splines_4.5.1           dplyr_1.1.4             tweenr_2.0.3
##  [79] BiocFileCache_3.0.0     treeio_1.34.0           lattice_0.22-7
##  [82] gmp_0.7-5               bit_4.6.0               tidyselect_1.2.1
##  [85] fontLiberation_0.1.0    GO.db_3.22.0            Biostrings_2.78.0
##  [88] knitr_1.50              fontBitstreamVera_0.1.1 gridExtra_2.3
##  [91] bookdown_0.45           Seqinfo_1.0.0           xfun_0.53
##  [94] graphlayouts_1.2.2      stringi_1.8.7           lazyeval_0.2.2
##  [97] ggfun_0.2.0             yaml_2.3.10             evaluate_1.0.5
## [100] codetools_0.2-20        ggraph_2.2.2            gdtools_0.4.4
## [103] tibble_3.3.0            qvalue_2.42.0           graph_1.88.0
## [106] BiocManager_1.30.26     ggplotify_0.1.3         cli_3.6.5
## [109] systemfonts_1.3.1       jquerylib_0.1.4         dichromat_2.0-0.1
## [112] Rcpp_1.1.0              dbplyr_2.5.1            png_0.1-8
## [115] parallel_4.5.1          ggplot2_4.0.0           blob_1.2.4
## [118] clusterProfiler_4.18.0  DOSE_4.4.0              Rmpfr_1.1-2
## [121] viridisLite_0.4.2       tidytree_0.4.6          ggiraph_0.9.2
## [124] scales_1.4.0            purrr_1.1.0             crayon_1.5.3
## [127] rlang_1.1.6             cowplot_1.2.0           fastmatch_1.1-6
## [130] KEGGREST_1.50.0
```