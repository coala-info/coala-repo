# spillR Vignette

Marco Guazzini1, Alexander G. Reisach2, Sebastian Weichwald3 and Christof Seiler1,4,5

1Department of Advanced Computing Sciences, Maastricht University, The Netherlands
2Université Paris Cité, CNRS, MAP5, F-75006 Paris, France
3Department of Mathematical Sciences, University of Copenhagen, Denmark
4Mathematics Centre Maastricht, Maastricht University, The Netherlands
5Center of Experimental Rheumatology, Department of Rheumatology, University Hospital Zurich, University of Zurich, Switzerland

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data](#data)
* [4 Compensation Workflow](#compensation-workflow)
* [5 Diagnostic Plot](#diagnostic-plot)
* [Session Info](#session-info)
* [References](#references)

# 1 Introduction

Mass cytometry makes it possible to count a large number of proteins simultaneously on individual cells (Bandura et al. [2009](#ref-bandura2009mass); Bendall et al. [2011](#ref-bendall2011single)). Mass cytometry has less spillover— measurements from one channel overlap less with those of another—than flow cytometry (Bagwell and Adams [1993](#ref-sp-c); Novo, Grégori, and Rajwa [2013](#ref-novo2013generalized)), but spillover is still a problem and affects downstream analyses such as differential testing (Weber et al. [2019](#ref-diffcyt); Seiler et al. [2021](#ref-seiler2021cytoglmm)) or dimensionality reduction (McCarthy et al. [2017](#ref-scater)). Reducing spillover by careful design of experiment is possible (Takahashi et al. [2017](#ref-takahashi2017mass)), but a purely experimental approach may not be sufficient nor efficient (Lun et al. [2017](#ref-lun2017influence)). Chevrier et al. ([2018](#ref-catalyst)) propose a method for addressing spillover by conducting an experiment on beads. This experiment measures spillover by staining each bead with a single antibody. Their solution relies on an estimate for the spillover matrix using non-negative matrix factorization. The spillover matrix encodes the pairwise spillover proportion between channels. We avoid this step and directly describe the spillover channels and the channel with the true signal using a mixture of nonparametric distributions. Our main new assumption is that the spillover distribution—not just the spillover proportion—from the beads experiment carries over to the biological experiment. Here, we illustrate the `spillR`*R* package for spillover compensation in mass cytometry.

Our motivation to submit to Bioconductor is to make our package available to a large user base and to ensure its compatibility with other packages that address preprocessing and analysis of mass cytometry data.

# 2 Installation

Install this package.

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("spillR")
```

# 3 Data

We test our method on one of the example datasets in the `CATALYST` package. The dataset has an experiment with real cells and a corresponding bead experiment. The experiments on real cells has 5,000 peripheral blood mononuclear cells from healthy donors measured on 39 channels. The experiment on beads has 10,000 cells measured on 36 channels. They have single stained bead experiments. The number of beads per mental label range from 112 to 241.

We compare the two methods on the same marker as in the original `CATALYST` paper (Chevrier et al. [2018](#ref-catalyst)) in their Figure 3B. In the original experiment, they conjugated three proteins—CD3, CD8, and HLA-DR—with two different metal labels. Here is the `CATALYST` code to load the data into a Single Cell Experiment (SCE).

```
library(spillR)
library(CATALYST)
library(dplyr)
library(ggplot2)
library(cowplot)

bc_key <- c(139, 141:156, 158:176)
sce_bead <- prepData(ss_exp)
sce_bead <- assignPrelim(sce_bead, bc_key, verbose = FALSE)
sce_bead <- applyCutoffs(estCutoffs(sce_bead))
sce_bead <- computeSpillmat(sce_bead)

# --------- experiment with real cells ---------
data(mp_cells, package = "CATALYST")
sce <- prepData(mp_cells)
```

# 4 Compensation Workflow

The function `compCytof` takes as inputs two Single Cell Experiment (SCE) objects. One contains the real cells experiment and the other the beads experiment. It also requires a table `marker_to_barc` that maps the channels to their barcodes used in the beads experiment. The output is the same SCE for the real experiments with the addition of the compensated counts and the `asinh` transformed compensated counts.

```
# --------- table for mapping markers and barcode ---------
marker_to_barc <-
    rowData(sce_bead)[, c("channel_name", "is_bc")] |>
    as_tibble() |>
    dplyr::filter(is_bc == TRUE) |>
    mutate(barcode = bc_key) |>
    select(marker = channel_name, barcode)

# --------- compensate function from spillR package ---------
sce_spillr <-
    spillR::compCytof(sce, sce_bead, marker_to_barc, impute_value = NA,
                      overwrite = FALSE)

# --------- 2d histogram from CATALYST package -------
as <- c("counts", "exprs", "compcounts", "compexprs")
chs <- c("Yb171Di", "Yb173Di")
ps <- lapply(as, function(a) plotScatter(sce_spillr, chs, assay = a))
plot_grid(plotlist = ps, nrow = 2)
```

![](data:image/png;base64...)

# 5 Diagnostic Plot

`spillR` offers the possibility to visualize the compensation results and the internal spillover estimates. The function `plotDiagnostics` presents two plots: the frequency polygons before and after spillover compensation, and the density plot of spillover markers with our estimation of the spillover probability function as a black dashed curve. This plot allows us to check the compensation performed by our method. If the black curve captures all the spillover makers, then that indicates a reliable spillover estimation. If the target marker in the beads experiment overlaps with the real cells, then that indicates a high-quality bead experiment.

```
ps <- spillR::plotDiagnostics(sce_spillr, "Yb173Di")
x_lim <- c(0, 7)
plot_grid(ps[[1]] + xlim(x_lim),
    ps[[2]] + xlim(x_lim),
    ncol = 1, align = "v"
)
```

![](data:image/png;base64...)

# Session Info

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
##  [1] cowplot_1.2.0               ggplot2_4.0.0
##  [3] dplyr_1.1.4                 spillR_1.6.0
##  [5] CATALYST_1.34.0             SingleCellExperiment_1.32.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               magrittr_2.0.4
##   [5] magick_2.9.0                TH.data_1.1-4
##   [7] spatstat.utils_3.2-0        ggbeeswarm_0.7.2
##   [9] farver_2.1.2                rmarkdown_2.30
##  [11] GlobalOptions_0.1.2         vctrs_0.6.5
##  [13] tinytex_0.57                rstatix_0.7.3
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] plotrix_3.8-4               BiocNeighbors_2.4.0
##  [19] broom_1.0.10                SparseArray_1.10.0
##  [21] Formula_1.2-5               sass_0.4.10
##  [23] bslib_0.9.0                 plyr_1.8.9
##  [25] sandwich_3.1-1              zoo_1.8-14
##  [27] cachem_1.1.0                igraph_2.2.1
##  [29] lifecycle_1.0.4             iterators_1.0.14
##  [31] pkgconfig_2.0.3             rsvd_1.0.5
##  [33] Matrix_1.7-4                R6_2.6.1
##  [35] fastmap_1.2.0               clue_0.3-66
##  [37] digest_0.6.37               colorspace_2.1-2
##  [39] ggnewscale_0.5.2            scater_1.38.0
##  [41] irlba_2.3.5.1               ggpubr_0.6.2
##  [43] beachmat_2.26.0             labeling_0.4.3
##  [45] cytolib_2.22.0              colorRamps_2.3.4
##  [47] nnls_1.6                    polyclip_1.10-7
##  [49] abind_1.4-8                 compiler_4.5.1
##  [51] withr_3.0.2                 doParallel_1.0.17
##  [53] ConsensusClusterPlus_1.74.0 S7_0.2.0
##  [55] backports_1.5.0             BiocParallel_1.44.0
##  [57] carData_3.0-5               viridis_0.6.5
##  [59] hexbin_1.28.5               ggforce_0.5.0
##  [61] ggsignif_0.6.4              MASS_7.3-65
##  [63] drc_3.0-1                   DelayedArray_0.36.0
##  [65] rjson_0.2.23                FlowSOM_2.18.0
##  [67] gtools_3.9.5                tools_4.5.1
##  [69] vipor_0.4.7                 beeswarm_0.4.0
##  [71] glue_1.8.0                  grid_4.5.1
##  [73] Rtsne_0.17                  cluster_2.1.8.1
##  [75] reshape2_1.4.4              gtable_0.3.6
##  [77] tidyr_1.3.1                 data.table_1.17.8
##  [79] BiocSingular_1.26.0         ScaledMatrix_1.18.0
##  [81] car_3.1-3                   XVector_0.50.0
##  [83] ggrepel_0.9.6               foreach_1.5.2
##  [85] pillar_1.11.1               stringr_1.5.2
##  [87] circlize_0.4.16             splines_4.5.1
##  [89] flowCore_2.22.0             tweenr_2.0.3
##  [91] lattice_0.22-7              survival_3.8-3
##  [93] RProtoBufLib_2.22.0         tidyselect_1.2.1
##  [95] ComplexHeatmap_2.26.0       scuttle_1.20.0
##  [97] knitr_1.50                  gridExtra_2.3
##  [99] bookdown_0.45               xfun_0.53
## [101] stringi_1.8.7               yaml_2.3.10
## [103] evaluate_1.0.5              codetools_0.2-20
## [105] tibble_3.3.0                BiocManager_1.30.26
## [107] cli_3.6.5                   jquerylib_0.1.4
## [109] dichromat_2.0-0.1           Rcpp_1.1.0
## [111] png_0.1-8                   XML_3.99-0.19
## [113] spatstat.univar_3.1-4       parallel_4.5.1
## [115] viridisLite_0.4.2           mvtnorm_1.3-3
## [117] scales_1.4.0                ggridges_0.5.7
## [119] purrr_1.1.0                 crayon_1.5.3
## [121] GetoptLong_1.0.5            rlang_1.1.6
## [123] multcomp_1.4-29
```

# References

Bagwell, C Bruce, and Earl G Adams. 1993. “Fluorescence Spectral Overlap Compensation for Any Number of Flow Cytometry Parameters.” *Annals of the New York Academy of Sciences* 677 (1): 167–84.

Bandura, Dmitry R, Vladimir I Baranov, Olga I Ornatsky, Alexei Antonov, Robert Kinach, Xudong Lou, Serguei Pavlov, Sergey Vorobiev, John E Dick, and Scott D Tanner. 2009. “Mass Cytometry: Technique for Real Time Single Cell Multitarget Immunoassay Based on Inductively Coupled Plasma Time-of-Flight Mass Spectrometry.” *Analytical Chemistry* 81 (16): 6813–22.

Bendall, Sean C, Erin F Simonds, Peng Qiu, D Amir El-ad, Peter O Krutzik, Rachel Finck, Robert V Bruggner, et al. 2011. “Single-Cell Mass Cytometry of Differential Immune and Drug Responses Across a Human Hematopoietic Continuum.” *Science* 332 (6030): 687–96.

Chevrier, Stéphane, Helena L. Crowell, Vito R. T. Zanotelli, Stefanie Engler, Mark D. Robinson, and Bernd Bodenmiller. 2018. “Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry.” *Cell Systems* 6 (5): 612–620.e5.

Lun, Xiao-Kang, Vito RT Zanotelli, James D Wade, Denis Schapiro, Marco Tognetti, Nadine Dobberstein, and Bernd Bodenmiller. 2017. “Influence of Node Abundance on Signaling Network State and Dynamics Analyzed by Mass Cytometry.” *Nature Biotechnology* 35 (2): 164–72.

McCarthy, Davis J, Kieran R Campbell, Aaron TL Lun, and Quin F Wills. 2017. “Scater: Pre-Processing, Quality Control, Normalization and Visualization of Single-Cell RNA-Seq Data in R.” *Bioinformatics* 33 (8): 1179–86.

Novo, David, Gérald Grégori, and Bartek Rajwa. 2013. “Generalized Unmixing Model for Multispectral Flow Cytometry Utilizing Nonsquare Compensation Matrices.” *Cytometry Part A* 83 (5): 508–20.

Seiler, Christof, Anne-Maud Ferreira, Lisa M Kronstad, Laura J Simpson, Mathieu Le Gars, Elena Vendrame, Catherine A Blish, and Susan Holmes. 2021. “CytoGLMM: Conditional Differential Analysis for Flow and Mass Cytometry Experiments.” *BMC Bioinformatics* 22 (137): 1–14.

Takahashi, Chikara, Amelia Au-Yeung, Franklin Fuh, Teresa Ramirez-Montagut, Chris Bolen, William Mathews, and William E O’Gorman. 2017. “Mass Cytometry Panel Optimization Through the Designed Distribution of Signal Interference.” *Cytometry Part A* 91 (1): 39–47.

Weber, Lukas M, Malgorzata Nowicka, Charlotte Soneson, and Mark D Robinson. 2019. “Diffcyt: Differential Discovery in High-Dimensional Cytometry via High-Resolution Clustering.” *Communications Biology* 2 (1): 1–11.