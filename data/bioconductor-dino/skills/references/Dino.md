# Normalization by distributional resampling of high throughput single-cell RNA-sequencing data

Jared Brown and Christina Kendziorski

#### 05/31/2022

#### Package

Dino 1.16.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
  + [2.1 Installation](#installation)
  + [2.2 All-in-one function](#all-in-one-function)
* [3 Detailed steps](#detailed-steps)
  + [3.1 Read UMI data](#read-umi-data)
  + [3.2 Clean UMI data](#clean-umi-data)
  + [3.3 Normalize UMI data](#normalize-umi-data)
  + [3.4 Clustering with Seurat](#clustering-with-seurat)
  + [3.5 Normalizing data formatted as SingleCellExperiment](#normalizing-data-formatted-as-singlecellexperiment)
  + [3.6 Alternate sequencing depth](#alternate-sequencing-depth)
* [4 Method](#method)
  + [4.1 Model](#model)
  + [4.2 Mixture components \(K\)](#mixture-components-k)
* [5 Session Information](#session-information)
* [6 Citation](#citation)
* [7 Contact](#contact)

# 1 Introduction

Over the past decade, advances in single-cell RNA-sequencing (scRNA-seq) technologies have significantly increased the sensitivity and specificity with which cellular transcriptional dynamics can be analyzed. Further, parallel increases in the number cells which can be simultaneously sequenced have allowed for novel analysis pipelines including the description of transcriptional trajectories and the discovery of rare sub-populations of cells. The development of droplet-based, unique-molecular-identifier (UMI) protocols such as Drop-seq, inDrop, and the 10x Genomics Chromium platform have significantly contributed to these advances. In particular, the commercially available 10x Genomics platform has allowed the rapid and cost effective gene expression profiling of hundreds to tens of thousands of cells across many studies to date.

The use of UMIs in the 10x Genomics and related platforms has augmented these developments in sequencing technology by tagging individual mRNA transcripts with unique cell and transcript specific identifiers. In this way, biases due to transcript length and PCR amplification have been significantly reduced. However, technical variability in sequencing depth remains and, consequently, normalization to adjust for sequencing depth is required to ensure accurate downstream analyses. To address this, we introduce `Dino`, an `R` package implementing the **Dino** normalization method.

`Dino` utilizes a flexible mixture of Negative Binomials model of gene expression to reconstruct full gene-specific expression distributions which are independent of sequencing depth. By giving exact zeros positive probability, the Negative Binomial components are applicable to shallow sequencing (high proportions of zeros). Additionally, the mixture component is robust to cell heterogeneity as it accommodates multiple centers of gene expression in the distribution. By directly modeling (possibly heterogenous) gene-specific expression distributions, Dino outperforms competing approaches, especially for datasets in which the proportion of zeros is high as is typical for modern, UMI based protocols.

`Dino` does not attempt to correct for batch or other sample specific effects, and will only do so to the extent that they are correlated with sequencing depth. In situations where batch effects are expected, downstream analysis may benefit from such accommodations.

# 2 Quick Start

## 2.1 Installation

`Dino` is now available on `BioConductor` and can be easily installed from that repository by running:

```
# Install Bioconductor if not present, skip otherwise
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install Dino package
BiocManager::install("Dino")

# View (this) vignette from R
browseVignettes("Dino")
```

`Dino` is also available from Github, and bug fixes, patches, and updates are available there first. To install `Dino` from Github, run

```
devtools::install_github('JBrownBiostat/Dino', build_vignettes = TRUE)
```

*Note*, building vignettes can take a little time, so for a quicker install, consider setting `build_vignettes = FALSE`.

## 2.2 All-in-one function

`Dino` (function) is an all-in-one function to normalize raw UMI count data from 10X Cell Ranger or similar protocols. Under default options, `Dino` outputs a sparse matrix of normalized expression. `SeuratFromDino` provides one-line functionality to return a Seurat object from raw UMI counts or from a previously normalized expression matrix.

```
library(Dino)

# Return a sparse matrix of normalized expression
Norm_Mat <- Dino(UMI_Mat)

# Return a Seurat object from already normalized expression
# Use normalized (doNorm = FALSE) and un-transformed (doLog = FALSE) expression
Norm_Seurat <- SeuratFromDino(Norm_Mat, doNorm = FALSE, doLog = FALSE)

# Return a Seurat object from UMI expression
# Transform normalized expression as log(x + 1) to improve
# some types of downstream analysis
Norm_Seurat <- SeuratFromDino(UMI_Mat)
```

# 3 Detailed steps

## 3.1 Read UMI data

To facilitate concrete examples, we demonstrate normalization on a small subset of sequencing data from about 3,000 peripheral blood mononuclear cells (PBMCs) published by [10X Genomics](https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k). This dataset, named `pbmcSmall` contains 200 cells and 1,000 genes and is included with the `Dino` package.

```
set.seed(1)

# Bring pbmcSmall into R environment
library(Dino)
library(Seurat)
library(Matrix)
data("pbmcSmall")
print(dim(pbmcSmall))
```

```
## [1] 1000  200
```

While `Dino` was developed to normalize UMI count data, it will run on any matrix of non-negative expression data; user caution is advised if applying `Dino` to non-UMI sequencing protocols. Input formats may be sparse or dense matrices of expression with genes (features) on the rows and cells (samples) on the columns.

## 3.2 Clean UMI data

While `Dino` can normalize the `pbmcSmall` dataset as it currently exists, the resulting normalized matrix, and in particular, downstream analysis are likely to be improved by cleaning the data. Of greatest use is removing genes that are expected *not* to contain useful information. This set of genes may be case dependent, but a good rule of thumb for UMI protocols is to remove genes lacking a minimum of non-zero expression prior to normalization and analysis.

By default, `Dino` will not perform the resampling algorithm on any genes without at least 10 non-zero samples, and will rather normalize such genes by scaling with sequencing depth. To demonstrate a stricter threshold, we remove genes lacking at least 20 non-zero samples prior to normalization.

```
# Filter genes for a minimum of non-zero expression
pbmcSmall <- pbmcSmall[rowSums(pbmcSmall != 0) >= 20, ]
print(dim(pbmcSmall))
```

```
## [1] 907 200
```

## 3.3 Normalize UMI data

`Dino` contains several options to tune output. One of particular interest is `nCores` which allows for parallel computation of normalized expression. By default, `Dino` runs with two threads. Choosing `nCores = 0` will utilize all available cores, and otherwise an integer number of parallel instances can be chosen.

```
# Normalize data
pbmcSmall_Norm <- Dino(pbmcSmall)
```

## 3.4 Clustering with Seurat

After normalization, `Dino` makes it easy to perform data analysis. The default output is the normalized matrix in sparse format, and `Dino` additionally provides a function to transform normalized output into a `Seurat` object. We demonstrate this by running a quick clustering pipeline in `Seurat`. Much of the pipeline is modified from the tutorial at <https://satijalab.org/seurat/v3.1/pbmc3k_tutorial.html>

```
# Reformat normalized expression as a Seurat object
pbmcSmall_Seurat <- SeuratFromDino(pbmcSmall_Norm, doNorm = FALSE)

# Cluster pbmcSmall_Seurat
pbmcSmall_Seurat <- FindVariableFeatures(pbmcSmall_Seurat,
                        selection.method = "mvp")
pbmcSmall_Seurat <- ScaleData(pbmcSmall_Seurat,
                        features = rownames(pbmcSmall_Norm))
pbmcSmall_Seurat <- RunPCA(pbmcSmall_Seurat,
                        features = VariableFeatures(object = pbmcSmall_Seurat),
                        verbose = FALSE)
pbmcSmall_Seurat <- FindNeighbors(pbmcSmall_Seurat, dims = 1:10)
pbmcSmall_Seurat <- FindClusters(pbmcSmall_Seurat, verbose = FALSE)
pbmcSmall_Seurat <- RunUMAP(pbmcSmall_Seurat, dims = 1:10)
DimPlot(pbmcSmall_Seurat, reduction = "umap")
```

![](data:image/png;base64...)

## 3.5 Normalizing data formatted as SingleCellExperiment

`Dino` additionally supports the normalization of datasets formatted as *SingleCellExperiment*. As with the `Seurat` pipeline, this functionality is implemented through the use of a wrapper function. We demonstrate this by quickly converting the *pbmcSmall* dataset to a *SingleCellExperiment* object and then normalizing.

```
# Reformatting pbmcSmall as a SingleCellExperiment
library(SingleCellExperiment)
pbmc_SCE <- SingleCellExperiment(assays = list("counts" = pbmcSmall))

# Run Dino
pbmc_SCE <- Dino_SCE(pbmc_SCE)
str(normcounts(pbmc_SCE))
```

```
## Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
##   ..@ i       : int [1:162750] 0 1 2 3 4 5 6 7 8 9 ...
##   ..@ p       : int [1:201] 0 812 1621 2434 3239 4058 4867 5677 6488 7298 ...
##   ..@ Dim     : int [1:2] 907 200
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:907] "ENSG00000087086" "ENSG00000167996" "ENSG00000251562" "ENSG00000205542" ...
##   .. ..$ : chr [1:200] "CCAACCTGACGTAC-1" "ATCTGGGATTCCGC-1" "TACTTTCTTTTGGG-1" "CAGGCCGAACACGT-1" ...
##   ..@ x       : num [1:162750] 103.53 29.65 12.11 27 9.34 ...
##   ..@ factors : list()
```

## 3.6 Alternate sequencing depth

By default, `Dino` computes sequencing depth, which is corrected for in the normalized data, as the sum of expression for a cell (sample) across genes. This sum is then scaled such that the median depth is 1. For some datasets, however, it may be beneficial to run `Dino` on an alternately computed set of sequencing depths. *Note*: it is generally recommended that the median depth not be far from 1 as this corresponds to recomputing expression as though all cells had been sequenced at the median depth.

A simple pipeline to compute alternate sequencing depths utilizes the `Scran` method for computing normalization scale factors, and is demonstrated below.

```
library(scran)

# Compute scran size factors
scranSizes <- calculateSumFactors(pbmcSmall)

# Re-normalize data
pbmcSmall_SNorm <- Dino(pbmcSmall, nCores = 1, depth = log(scranSizes))
```

A fuller discussion of a specific use case for providing alternate sequencing depths can be viewed on the `Dino` Github page: [Issue #1](https://github.com/JBrownBiostat/Dino/issues/1)

# 4 Method

## 4.1 Model

`Dino` models observed UMI counts as a mixture of Negative Binomial random variables. The Negative Binomial distribution can, however, be decomposed into a hierarchical Gamma-Poisson distribution, so for gene \(g\) and cell \(j\), the `Dino` model for UMI counts is:
\[y\_{gj}\sim f^{P}(\lambda\_{gj}\delta\_{j})\\
\lambda\_{gj}\sim\sum\_{K}\pi\_{k}f^{G}\left(\frac{\mu\_{gk}}{\theta\_g},\theta\_g\right)\]
where \(f^{P}\) is a Poisson distribution parameterized by mean \(\lambda\_{gj}\delta\_{j}\) and \(f^{G}\) is a Gamma distribution parameterized by shape \(\mu\_{gk}/\theta\_g\) and scale \(\theta\_g\). \(\delta\_{j}\) is the cell-specific sequencing depth, \(\lambda\_{gj}\) is the latent level of gene/cell-specific expression independent of depth, component probabilities \(\pi\_{k}\) sum to 1, the Gamma distribution is parameterized such that \(\mu\_{gk}\) denotes the distribution mean, and the Gamma scale paramter, \(\theta\_g\), is constant across mixture components.

Following model fitting for a fixed gene through an accelerated EM algorithm, `Dino` produces normalized expression values by resampling from the posterior distribution of the latent expression parameters, \(\lambda\_{gj}\). It can be shown that the distribution on the \(\lambda\_{j}\) (dropping the gene-specific subscript \(g\) as calculations are repreated across genes) is a mixture of Gammas, specifically:
\[\mathbb{P}(\lambda\_{j}|y\_{j},\delta\_j)=\sum\_{K}\tau\_{kj}f^{G}\left(\frac{\mu\_{k}}{\theta}+\gamma y\_{j},\frac{1}{\frac{1}{\theta}+\gamma\delta\_j}\right)\]
where \(\tau\_{kj}\) denotes the conditional probability that \(\lambda\_{gj}\) was sampled from mixture component \(k\) and \(\gamma\) is a global concentration parameter. The \(\tau\_{kj}\) are estimated as part of the implementation of the EM algorithm in `Dino`. The adjustment from the concentration parameter can be seen as a bias in the normalized values towards a scale-factor version of normalization, since, in the limit of \(\gamma\), the normalized expression for cell \(j\) converges to \(y\_j/\delta\_j\). Default values of \(\gamma=15\) have proven successful.

## 4.2 Mixture components \(K\)

Approximating the flexibility of a non-parametric method, `Dino` uses a large number of mixture components, \(K\), in order to capture the full heterogeneity of expression that may exist for a given gene. The gene-specific number of components is estimated as the square root of the number of strictly positive UMI counts for a given gene. By default, \(K\) is limited to be no larger than 100. In simulation, large values of \(K\) are shown to successfully reconstruct both unimodal and multimodal underlying distributions. For example, when UMI counts are estimated under a single negative binomial distribution, the `Dino` fitted prior distribution (black, right panel) which is used to sample normalized expression closely matches the theoretical sampling distribution (red, right panel). Likewise, the fitted means (\(\mu\_k\) in the model, gray lines, left panel) span the range of the simulated data (heat map of counts, left panel), but concentrate around the theoretical mean of the sampling distribution (red, left panel).

![](data:image/png;base64...)

```
## TableGrob (2 x 2) "arrange": 3 grobs
##   z     cells    name                grob
## 1 1 (2-2,1-1) arrange      gtable[layout]
## 2 2 (2-2,2-2) arrange      gtable[layout]
## 3 3 (1-1,1-2) arrange text[GRID.text.284]
```

Simulating data from a pair of Negative Binomial distributions with different means and different dispersion parameters yields similar results in the multimodal case.

![](data:image/png;base64...)

```
## TableGrob (2 x 2) "arrange": 3 grobs
##   z     cells    name                grob
## 1 1 (2-2,1-1) arrange      gtable[layout]
## 2 2 (2-2,2-2) arrange      gtable[layout]
## 3 3 (1-1,1-2) arrange text[GRID.text.488]
```

# 5 Session Information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ggpubr_0.6.2                gridExtra_2.3
##  [3] ggplot2_4.0.0               SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] future_1.67.0               Matrix_1.7-4
## [17] Seurat_5.3.1                SeuratObject_5.2.0
## [19] sp_2.2-0                    Dino_1.16.0
## [21] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22       splines_4.5.1          later_1.4.4
##   [4] tibble_3.3.0           polyclip_1.10-7        fastDummies_1.7.5
##   [7] lifecycle_1.0.4        rstatix_0.7.3          edgeR_4.8.0
##  [10] globals_0.18.0         lattice_0.22-7         MASS_7.3-65
##  [13] backports_1.5.0        magrittr_2.0.4         limma_3.66.0
##  [16] plotly_4.11.0          sass_0.4.10            rmarkdown_2.30
##  [19] jquerylib_0.1.4        yaml_2.3.10            metapod_1.18.0
##  [22] httpuv_1.6.16          otel_0.2.0             sctransform_0.4.2
##  [25] spam_2.11-1            spatstat.sparse_3.1-0  reticulate_1.44.0
##  [28] cowplot_1.2.0          pbapply_1.7-4          RColorBrewer_1.1-3
##  [31] abind_1.4-8            Rtsne_0.17             purrr_1.1.0
##  [34] ggrepel_0.9.6          irlba_2.3.5.1          listenv_0.9.1
##  [37] spatstat.utils_3.2-0   goftest_1.2-3          RSpectra_0.16-2
##  [40] spatstat.random_3.4-2  dqrng_0.4.1            fitdistrplus_1.2-4
##  [43] parallelly_1.45.1      codetools_0.2-20       DelayedArray_0.36.0
##  [46] scuttle_1.20.0         tidyselect_1.2.1       farver_2.1.2
##  [49] ScaledMatrix_1.18.0    spatstat.explore_3.5-3 jsonlite_2.0.0
##  [52] BiocNeighbors_2.4.0    Formula_1.2-5          progressr_0.17.0
##  [55] ggridges_0.5.7         survival_3.8-3         tools_4.5.1
##  [58] ica_1.0-3              Rcpp_1.1.0             glue_1.8.0
##  [61] SparseArray_1.10.0     xfun_0.53              dplyr_1.1.4
##  [64] withr_3.0.2            BiocManager_1.30.26    fastmap_1.2.0
##  [67] bluster_1.20.0         digest_0.6.37          rsvd_1.0.5
##  [70] R6_2.6.1               mime_0.13              scattermore_1.2
##  [73] tensor_1.5.1           dichromat_2.0-0.1      spatstat.data_3.1-9
##  [76] hexbin_1.28.5          tidyr_1.3.1            data.table_1.17.8
##  [79] httr_1.4.7             htmlwidgets_1.6.4      S4Arrays_1.10.0
##  [82] uwot_0.2.3             pkgconfig_2.0.3        gtable_0.3.6
##  [85] lmtest_0.9-40          S7_0.2.0               XVector_0.50.0
##  [88] htmltools_0.5.8.1      carData_3.0-5          dotCall64_1.2
##  [91] bookdown_0.45          scales_1.4.0           png_0.1-8
##  [94] spatstat.univar_3.1-4  scran_1.38.0           reshape2_1.4.4
##  [97] nlme_3.1-168           cachem_1.1.0           zoo_1.8-14
## [100] stringr_1.5.2          KernSmooth_2.23-26     parallel_4.5.1
## [103] miniUI_0.1.2           pillar_1.11.1          vctrs_0.6.5
## [106] RANN_2.6.2             promises_1.4.0         BiocSingular_1.26.0
## [109] car_3.1-3              beachmat_2.26.0        xtable_1.8-4
## [112] cluster_2.1.8.1        evaluate_1.0.5         tinytex_0.57
## [115] magick_2.9.0           cli_3.6.5              locfit_1.5-9.12
## [118] compiler_4.5.1         rlang_1.1.6            future.apply_1.20.0
## [121] ggsignif_0.6.4         labeling_0.4.3         plyr_1.8.9
## [124] stringi_1.8.7          viridisLite_0.4.2      deldir_2.0-4
## [127] BiocParallel_1.44.0    lazyeval_0.2.2         spatstat.geom_3.6-0
## [130] RcppHNSW_0.6.0         patchwork_1.3.2        statmod_1.5.1
## [133] shiny_1.11.1           ROCR_1.0-11            igraph_2.2.1
## [136] broom_1.0.10           bslib_0.9.0
```

# 6 Citation

If you use *Dino* in your analysis, please cite our paper:

Brown, J., Ni, Z., Mohanty, C., Bacher, R., and Kendziorski, C. (2021). “Normalization by distributional resampling of high throughput single-cell RNA-sequencing data.” Bioinformatics, 37, 4123-4128. <https://academic.oup.com/bioinformatics/article/37/22/4123/6306403>.

Other work referenced in this vignette include:

Satija, R., Farrell, J.A., Gennert, D., Schier, A.F. and Regev, A. (2015). “Spatial reconstruction of single-cell gene expression data.” Nat. Biotechnol., 33, 495–502.
<https://doi.org/10.1038/nbt.3192>

Amezquita, R.A., Lun, A.T.L., Becht, E., Carey, V.J., Carpp, L.N., Geistlinger, L., Marini, F., Rue-Albrecht, K., Risso, D., Soneson, C., et al. (2020). “Orchestrating single-cell analysis with Bioconductor.” Nat. Methods, 17, 137–145.
<https://doi.org/10.1038/s41592-019-0654-x>

Lun, A. T. L., Bach, K. and Marioni, J. C. (2016). “Pooling across cells to normalize single-cell RNA sequencing data with many zero counts.” Genome Biol., 17, 1–14.
<https://doi.org/10.1186/s13059-016-0947-7>

# 7 Contact

Jared Brown: ![](data:image/jpeg;base64...)

Christina Kendziorski: ![](data:image/jpeg;base64...)