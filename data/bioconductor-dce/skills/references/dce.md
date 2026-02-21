# Get started

Kim Philipp Jablonski, Martin Pirkl

#### 2021-05-19

# Contents

* [1 Overview](#overview)
* [2 Installation](#installation)
* [3 Load required packages](#load-required-packages)
* [4 Introductory example](#introductory-example)
* [5 Application to real data](#application-to-real-data)
  + [5.1 Retrieve gene expression data](#retrieve-gene-expression-data)
  + [5.2 Retrieve biological pathway of interest](#retrieve-biological-pathway-of-interest)
  + [5.3 Estimate Differential Causal Effects](#estimate-differential-causal-effects)
* [6 Session information](#session-information)
* [References](#references)

# 1 Overview

One cause of diseases like cancer is the deregulation of signalling pathways. The interaction of two or more genes is changed and cell behaviour is changed in the malignant tissue.

The estimation of causal effects from observational data has previously been used to elucidate gene interactions. We extend this notion to compute Differential Causal Effects (DCE). We compare the causal effects between two conditions, such as a malignant tissue (e.g., from a tumor) and a healthy tissue to detect differences in the gene interactions.

However, computing causal effects solely from given observations is difficult, because it requires reconstructing the gene network beforehand. To overcome this issue, we use prior knowledge from literature. This largely improves performance and makes the estimation of DCEs more accurate.

Overall, we can detect pathways which play a prominent role in tumorigenesis. We can even pinpoint specific interaction in the pathway that make a large contribution to the rise of the disease.

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("dce")
```

# 3 Load required packages

Load `dce` package and other required libraries.

```
# fix "object 'guide_edge_colourbar' of mode 'function' was not found"
# when building vignettes
# (see also https://github.com/thomasp85/ggraph/issues/75)
library(ggraph)

library(curatedTCGAData)
library(TCGAutils)
library(SummarizedExperiment)

library(tidyverse)
library(cowplot)
library(graph)
library(dce)

set.seed(42)
```

# 4 Introductory example

To demonstrate the basic idea of Differential Causal Effects (DCEs), we first artificially create a wild-type network by setting up its adjacency matrix.
The specified edge weights describe the direct causal effects and total causal effects are defined accordingly (Pearl 2010).
In this way, the detected dysregulations are endowed with a causal interpretation and spurious correlations are ignored. This can be achieved by using valid adjustment sets, assuming that the underlying network indeed models causal relationships accurately.
In a biological setting, these networks correspond, for example, to a KEGG pathway (Kanehisa et al. 2004) in a healthy cell.
Here, the edge weights correspond to proteins facilitating or inhibiting each others expression levels.

```
graph_wt <- matrix(c(0, 0, 0, 1, 0, 0, 1, 1, 0), 3, 3)
rownames(graph_wt) <- colnames(graph_wt) <- c("A", "B", "C")
graph_wt
```

```
##   A B C
## A 0 1 1
## B 0 0 1
## C 0 0 0
```

In case of a disease, these pathways can become dysregulated.
This can be expressed by a change in edge weights.

```
graph_mt <- graph_wt
graph_mt["A", "B"] <- 2.5 # dysregulation happens here!
graph_mt
```

```
##   A   B C
## A 0 2.5 1
## B 0 0.0 1
## C 0 0.0 0
```

```
cowplot::plot_grid(
  plot_network(graph_wt, edgescale_limits = c(-3, 3)),
  plot_network(graph_mt, edgescale_limits = c(-3, 3)),
  labels = c("WT", "MT")
)
```

![](data:image/png;base64...)

By computing the counts based on the edge weights (root nodes are randomly initialized), we can generate synthetic expression data for each node in both networks. Both `X_wt` and `X_mt` then induce causal effects as defined in their respective adjacency matrices.

```
X_wt <- simulate_data(graph_wt)
X_mt <- simulate_data(graph_mt)

X_wt %>%
  head
```

```
##         A   B    C
## [1,] 1117 398  802
## [2,]  964 244  501
## [3,]  963 246  469
## [4,] 1204 502 1032
## [5,]  848 125  251
## [6,] 1163 455  885
```

Given the network topology (without edge weights!) and expression data from both WT and MT conditions, we can estimate the difference in causal effects for each edge between the two conditions. These are the aforementioned Differential Causal Effects (DCEs).

```
res <- dce(graph_wt, X_wt, X_mt, solver = "lm")

res %>%
  as.data.frame %>%
  drop_na
```

```
##   source target       dce dce_stderr    dce_pvalue
## 1      A      B 1.5443343 0.03062434 3.373144e-114
## 2      A      C 1.5234426 0.04449333  1.207257e-84
## 3      B      C 0.1152442 0.17882577  5.200452e-01
```

Visualizing the result shows that we can recover the dysregulation of the edge from `A` to `B`.
Note that since we are computing total causal effects, the causal effect of `A` on `C` has changed as well.

```
plot(res) +
  ggtitle("Differential Causal Effects between WT and MT condition")
```

![](data:image/png;base64...)

# 5 Application to real data

Pathway dysregulations are a common cancer hallmark (Hanahan and Weinberg 2011).
It is thus of interest to investigate how the causal effect magnitudes in relevant pathways vary between normal and tumor samples.

## 5.1 Retrieve gene expression data

As a showcase, we download breast cancer (BRCA) RNA transcriptomics profiling data from TCGA (Tomczak, Czerwińska, and Wiznerowicz 2015).

```
brca <- curatedTCGAData(
  diseaseCode = "BRCA",
  assays = c("RNASeq2*"),
  version = "2.0.1",
  dry.run = FALSE
)
```

```
## snapshotDate(): 2021-05-05
```

```
## Working on: BRCA_RNASeq2Gene-20160128
```

```
## see ?curatedTCGAData and browseVignettes('curatedTCGAData') for documentation
```

```
## loading from cache
```

```
## Working on: BRCA_RNASeq2GeneNorm-20160128
```

```
## see ?curatedTCGAData and browseVignettes('curatedTCGAData') for documentation
```

```
## loading from cache
```

```
## Working on: BRCA_colData-20160128
```

```
## see ?curatedTCGAData and browseVignettes('curatedTCGAData') for documentation
```

```
## loading from cache
```

```
## Working on: BRCA_metadata-20160128
```

```
## see ?curatedTCGAData and browseVignettes('curatedTCGAData') for documentation
```

```
## loading from cache
```

```
## Working on: BRCA_sampleMap-20160128
```

```
## see ?curatedTCGAData and browseVignettes('curatedTCGAData') for documentation
```

```
## loading from cache
```

```
## harmonizing input:
##   removing 13161 sampleMap rows not in names(experiments)
##   removing 5 colData rownames not in sampleMap 'primary'
```

This will retrieve all available samples for the requested data sets.
These samples can be classified according to their site of origin.

```
sampleTables(brca)
```

```
## $`BRCA_RNASeq2Gene-20160128`
##
##   01   06   11
## 1093    7  112
##
## $`BRCA_RNASeq2GeneNorm-20160128`
##
##   01   06   11
## 1093    7  112
```

```
data(sampleTypes, package = "TCGAutils")
sampleTypes %>%
  filter(Code %in% c("01", "06", "11"))
```

```
##   Code          Definition Short.Letter.Code
## 1   01 Primary Solid Tumor                TP
## 2   06          Metastatic                TM
## 3   11 Solid Tissue Normal                NT
```

We can extract Primary Solid Tumor and matched Solid Tissue Normale samples.

```
# split assays
brca_split <- splitAssays(brca, c("01", "11"))
```

```
## Warning: 'splitAssays' is deprecated.
## Use 'TCGAsplitAssays' instead.
## See help("Deprecated")
```

```
# only retain matching samples
brca_matched <- as(brca_split, "MatchedAssayExperiment")

brca_wt <- assay(brca_matched, "01_BRCA_RNASeq2GeneNorm-20160128")
brca_mt <- assay(brca_matched, "11_BRCA_RNASeq2GeneNorm-20160128")
```

## 5.2 Retrieve biological pathway of interest

KEGG (Kanehisa et al. 2004) provides the breast cancer related pathway `hsa05224`.
It can be easily retrieved using `dce`.

```
pathways <- get_pathways(pathway_list = list(kegg = c("Breast cancer")))
```

```
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
## 'select()' returned 1:1 mapping between keys and columns
```

```
brca_pathway <- pathways[[1]]$graph
```

Luckily, it shares all genes with the cancer data set.

```
shared_genes <- intersect(nodes(brca_pathway), rownames(brca_wt))
glue::glue(
  "Covered nodes: {length(shared_genes)}/{length(nodes(brca_pathway))}"
)
```

```
## Covered nodes: 145/145
```

## 5.3 Estimate Differential Causal Effects

We can now estimate the differences in causal effects between matched tumor and normal samples on a breast cancer specific pathway.

```
res <- dce::dce(brca_pathway, t(brca_wt), t(brca_mt), solver = "lm")
```

Interpretations may now begin.

```
res %>%
  as.data.frame %>%
  drop_na %>%
  arrange(desc(abs(dce))) %>%
  head
```

```
##   source target        dce dce_stderr   dce_pvalue
## 1  WNT8A   FZD4 -4342.2001  2876.9003 1.326486e-01
## 2   FGF3  FGFR1 -1553.3334  1322.3358 2.413890e-01
## 3  WNT8B   FZD4 -1540.1078   235.1719 4.038543e-10
## 4  WNT7A   FZD4 -1334.3963   598.5797 2.680676e-02
## 5  FGF21  FGFR1  -917.1445  1128.4631 4.172471e-01
## 6  WNT8A   FZD7   817.6733   954.3545 3.924979e-01
```

```
plot(res, nodesize = 20, labelsize = 1, use_symlog = TRUE)
```

![](data:image/png;base64...)

# 6 Session information

```
sessionInfo()
```

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.13.0         AnnotationDbi_1.54.0
##  [3] dce_1.0.0                   graph_1.70.0
##  [5] cowplot_1.1.1               forcats_0.5.1
##  [7] stringr_1.4.0               dplyr_1.0.6
##  [9] purrr_0.3.4                 readr_1.4.0
## [11] tidyr_1.1.3                 tibble_3.1.2
## [13] tidyverse_1.3.1             TCGAutils_1.12.0
## [15] curatedTCGAData_1.13.9      MultiAssayExperiment_1.18.0
## [17] SummarizedExperiment_1.22.0 Biobase_2.52.0
## [19] GenomicRanges_1.44.0        GenomeInfoDb_1.28.0
## [21] IRanges_2.26.0              S4Vectors_0.30.0
## [23] BiocGenerics_0.38.0         MatrixGenerics_1.4.0
## [25] matrixStats_0.58.0          ggraph_2.0.5
## [27] ggplot2_3.3.3               BiocStyle_2.20.0
##
## loaded via a namespace (and not attached):
##   [1] rappdirs_0.3.3                rtracklayer_1.52.0
##   [3] prabclus_2.3-2                bit64_4.0.5
##   [5] knitr_1.33                    multcomp_1.4-17
##   [7] DelayedArray_0.18.0           data.table_1.14.0
##   [9] wesanderson_0.3.6             KEGGREST_1.32.0
##  [11] RCurl_1.98-1.3                generics_0.1.0
##  [13] metap_1.4                     GenomicFeatures_1.44.0
##  [15] TH.data_1.0-10                RSQLite_2.2.7
##  [17] proxy_0.4-25                  CombinePValue_1.0
##  [19] bit_4.0.4                     mutoss_0.1-12
##  [21] xml2_1.3.2                    lubridate_1.7.10
##  [23] httpuv_1.6.1                  assertthat_0.2.1
##  [25] viridis_0.6.1                 amap_0.8-18
##  [27] xfun_0.23                     hms_1.1.0
##  [29] jquerylib_0.1.4               evaluate_0.14
##  [31] promises_1.2.0.1              DEoptimR_1.0-8
##  [33] fansi_0.4.2                   restfulr_0.0.13
##  [35] progress_1.2.2                dbplyr_2.1.1
##  [37] readxl_1.3.1                  Rgraphviz_2.36.0
##  [39] igraph_1.2.6                  DBI_1.1.1
##  [41] tmvnsim_1.0-2                 apcluster_1.4.8
##  [43] RcppArmadillo_0.10.4.0.0      ellipsis_0.3.2
##  [45] backports_1.2.1               bookdown_0.22
##  [47] permute_0.9-5                 harmonicmeanp_3.0
##  [49] biomaRt_2.48.0                vctrs_0.3.8
##  [51] abind_1.4-5                   Linnorm_2.16.0
##  [53] cachem_1.0.5                  RcppEigen_0.3.3.9.1
##  [55] withr_2.4.2                   sfsmisc_1.1-11
##  [57] ggforce_0.3.3                 robustbase_0.93-7
##  [59] bdsmatrix_1.3-4               checkmate_2.0.0
##  [61] vegan_2.5-7                   GenomicAlignments_1.28.0
##  [63] pcalg_2.7-2                   prettyunits_1.1.1
##  [65] mclust_5.4.7                  mnormt_2.0.2
##  [67] cluster_2.1.2                 ExperimentHub_2.0.0
##  [69] GenomicDataCommons_1.16.0     crayon_1.4.1
##  [71] ellipse_0.4.2                 labeling_0.4.2
##  [73] FMStable_0.1-2                edgeR_3.34.0
##  [75] pkgconfig_2.0.3               tweenr_1.0.2
##  [77] nlme_3.1-152                  ggm_2.5
##  [79] nnet_7.3-16                   rlang_0.4.11
##  [81] diptest_0.76-0                lifecycle_1.0.0
##  [83] sandwich_3.0-1                filelock_1.0.2
##  [85] BiocFileCache_2.0.0           mathjaxr_1.4-0
##  [87] modelr_0.1.8                  AnnotationHub_3.0.0
##  [89] cellranger_1.1.0              polyclip_1.10-0
##  [91] Matrix_1.3-3                  zoo_1.8-9
##  [93] reprex_2.0.0                  png_0.1-7
##  [95] viridisLite_0.4.0             rjson_0.2.20
##  [97] bitops_1.0-7                  Biostrings_2.60.0
##  [99] blob_1.2.1                    scales_1.1.1
## [101] plyr_1.8.6                    memoise_2.0.0
## [103] graphite_1.38.0               magrittr_2.0.1
## [105] gdata_2.18.0                  zlibbioc_1.38.0
## [107] compiler_4.1.0                BiocIO_1.2.0
## [109] clue_0.3-59                   plotrix_3.8-1
## [111] Rsamtools_2.8.0               cli_2.5.0
## [113] XVector_0.32.0                ps_1.6.0
## [115] MASS_7.3-54                   mgcv_1.8-35
## [117] tidyselect_1.1.1              stringi_1.6.2
## [119] highr_0.9                     yaml_2.2.1
## [121] locfit_1.5-9.4                ggrepel_0.9.1
## [123] grid_4.1.0                    sass_0.4.0
## [125] tools_4.1.0                   rstudioapi_0.13
## [127] snowfall_1.84-6.1             gridExtra_2.3
## [129] farver_2.1.0                  Rtsne_0.15
## [131] digest_0.6.27                 BiocManager_1.30.15
## [133] flexclust_1.4-0               shiny_1.6.0
## [135] mnem_1.8.0                    fpc_2.2-9
## [137] ppcor_1.1                     Rcpp_1.0.6
## [139] broom_0.7.6                   BiocVersion_3.13.1
## [141] later_1.2.0                   httr_1.4.2
## [143] ggdendro_0.1.22               kernlab_0.9-29
## [145] naturalsort_0.1.3             Rdpack_2.1.1
## [147] colorspace_2.0-1              rvest_1.0.0
## [149] XML_3.99-0.6                  fs_1.5.0
## [151] splines_4.1.0                 RBGL_1.68.0
## [153] statmod_1.4.36                sn_2.0.0
## [155] expm_0.999-6                  graphlayouts_0.7.1
## [157] multtest_2.48.0               flexmix_2.3-17
## [159] xtable_1.8-4                  jsonlite_1.7.2
## [161] tidygraph_1.2.0               corpcor_1.6.9
## [163] modeltools_0.2-23             R6_2.5.0
## [165] gmodels_2.18.1                TFisher_0.2.0
## [167] pillar_1.6.1                  htmltools_0.5.1.1
## [169] mime_0.10                     glue_1.4.2
## [171] fastmap_1.1.0                 BiocParallel_1.26.0
## [173] class_7.3-19                  interactiveDisplayBase_1.30.0
## [175] codetools_0.2-18              tsne_0.1-3
## [177] mvtnorm_1.1-1                 utf8_1.2.1
## [179] lattice_0.20-44               bslib_0.2.5.1
## [181] logger_0.2.0                  numDeriv_2016.8-1.1
## [183] curl_4.3.1                    gtools_3.8.2
## [185] magick_2.7.2                  survival_3.2-11
## [187] limma_3.48.0                  rmarkdown_2.8
## [189] fastICA_1.2-2                 munsell_0.5.0
## [191] e1071_1.7-6                   fastcluster_1.1.25
## [193] GenomeInfoDbData_1.2.6        reshape2_1.4.4
## [195] haven_2.4.1                   gtable_0.3.0
## [197] rbibutils_2.1.1
```

# References

Hanahan, Douglas, and Robert A Weinberg. 2011. “Hallmarks of Cancer: The Next Generation.” *Cell* 144 (5): 646–74.

Kanehisa, Minoru, Susumu Goto, Shuichi Kawashima, Yasushi Okuno, and Masahiro Hattori. 2004. “The Kegg Resource for Deciphering the Genome.” *Nucleic Acids Research* 32 (suppl\_1): D277–D280.

Pearl, Judea. 2010. “Causal Inference.” *Causality: Objectives and Assessment*, 39–58.

Tomczak, Katarzyna, Patrycja Czerwińska, and Maciej Wiznerowicz. 2015. “The Cancer Genome Atlas (Tcga): An Immeasurable Source of Knowledge.” *Contemporary Oncology* 19 (1A): A68.