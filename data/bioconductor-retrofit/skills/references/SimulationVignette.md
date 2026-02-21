# Retrofit Simulation Vignette

Adam Keebum Park, Roopali Singh

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Package Installation](#package-installation)
* [3 Spatial Transcriptomics Data](#spatial-transcriptomics-data)
* [4 Deconvolution](#deconvolution)
* [5 Cell-type Annotation](#cell-type-annotation)
* [6 Deconvolution and annotation in one step (Optional)](#deconvolution-and-annotation-in-one-step-optional)
* [7 Results](#results)
* [8 Session information](#session-information)

# 1 Introduction

RETROFIT is a statistical method for reference-free deconvolution of spatial transcriptomics data to estimate cell type mixtures. In this Vignette, we will estimate cell type composition of a sample synthetic dataset. We will annotate cell types using an annotated single cell reference.

# 2 Package Installation

Install and load the package using the following steps:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("retrofit")
```

The main functionalities of RETROFIT are covered in this tutorial.

# 3 Spatial Transcriptomics Data

First load the ST data, using the following command:

```
data("vignetteSimulationData")
x = vignetteSimulationData$n10m3_x
```

The ST data matrix will consist of G = 500 genes and S = 1000 spots i.e., a matrix of order G x S.

# 4 Deconvolution

Initialize the following parameters for deconvolution:
- iterations: Number of iterations (default = 4000)
- L: Number of components required

```
iterations  = 10
L           = 20
```

After initialization, run RETROFIT on the data (X) as follows:

```
result  = retrofit::decompose(x, L=L, iterations=iterations, verbose=TRUE)
```

```
## [1] "iteration: 1 0.094 Seconds"
## [1] "iteration: 2 0.094 Seconds"
## [1] "iteration: 3 0.1 Seconds"
## [1] "iteration: 4 0.103 Seconds"
## [1] "iteration: 5 0.092 Seconds"
## [1] "iteration: 6 0.138 Seconds"
## [1] "iteration: 7 0.095 Seconds"
## [1] "iteration: 8 0.092 Seconds"
## [1] "iteration: 9 0.09 Seconds"
## [1] "iteration: 10 0.09 Seconds"
## [1] "Iteration mean:  0.099  seconds  total:  0.988  seconds"
```

```
H   = result$h
W   = result$w
Th  = result$th
```

After deconvolution of ST data, we have our estimates of W (a matrix of order G x L), H (a matrix of order L x S) and Theta (a vector of L components). Here, we are using number of iterations as 10 for demonstration purposes. For reproducing results in the paper, we need to run RETROFIT for iterations = 4000. The whole computation is omitted here due to time complexity (> 10min). We will load the results from 4000 iterations for the rest of the analysis.

```
H   = vignetteSimulationData$results_4k_iterations$decompose$h
W   = vignetteSimulationData$results_4k_iterations$decompose$w
Th  = vignetteSimulationData$results_4k_iterations$decompose$th
```

The above results are obtained by running the code below.

```
iterations = 4000
set.seed(12)
result = retrofit::decompose(x, L=L, iterations=iterations)
```

# 5 Cell-type Annotation

Next, we need to annotate the components, to get the proportion of, say K, cell types. We can do this in two ways: (a) using an annotated single cell reference or (b) using the known marker genes. Here, we will annotate using single cell reference.

Get the single cell reference data:

```
sc_ref_w = vignetteSimulationData$sc_ref_w
```

This file contains average gene expression values for G = 500 genes in K = 10 cell types i.e., a matrix of order G x K. Run the following command to get K cell-type mixtures from the ST data X:

```
K             = 10
result        = retrofit::annotateWithCorrelations(sc_ref=sc_ref_w, K=K,
                                                   decomp_w=W, decomp_h=H)
H_annotated   = result$h
W_annotated   = result$w
ranked_cells  = result$ranked_cells
```

Above code assigns components to the cell type it has maximum correlation with.

# 6 Deconvolution and annotation in one step (Optional)

We can also deconvolve the ST data matrix along with cell-type annotation all in one step, as follows:

```
iterations  = 10
L           = 20
K           = 10
result      = retrofit::retrofit(x,
                                 sc_ref=sc_ref_w,
                                 iterations=iterations,
                                 L=L,
                                 K=K)
```

# 7 Results

Visualize the correlation values between each cell type and the chosen component, as follows:

```
# correlation between true and estimated cell-type proportions
correlations        = stats::cor(sc_ref_w[ranked_cells], W_annotated[,ranked_cells])
ranked_correlations = sort(diag(correlations), decreasing=TRUE)
df                  = data.frame(x=1:length(ranked_correlations),
                                 y=ranked_correlations,
                                 label_x1=1,
                                 label_x2=2,
                                 label_y=seq(from=0.5, by=-0.05, length.out=10),
                                 label_cell=ranked_cells,
                                 label_corr=format(round(ranked_correlations, digits=4)))

gg <- ggplot2::ggplot(df,ggplot2::aes(x=x, y=y, group=1)) +
  ggplot2::geom_line(ggplot2::aes(x=x, y=y)) +
  ggplot2::geom_point(ggplot2::aes(x=x, y=y)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text.x=ggplot2::element_blank()) +
  ggplot2::ylim(0, 1.05) +
  ggplot2::ylab(expression(paste("Correlation (",W^0,",",widetilde(W),")"))) +
  ggplot2::geom_text(data=df, ggplot2::aes(x=label_x1, y=label_y, label=label_corr), size=4, hjust=0) +
  ggplot2::geom_text(data=df, ggplot2::aes(x=label_x2, y=label_y, label=label_cell), size=4, hjust=0)
plot(gg)
```

![](data:image/png;base64...)

All mapped cell types have greater than 0.75 correlation with the component they are matched with.

Since this is synthetic data, true cell type proportions are known. We can visualize the RMSE between the true and the estimated cell-type proportions as follows:

```
H_true  = vignetteSimulationData$sc_ref_h
H_est   = H_annotated
corrH   = sort(diag(stats::cor(H_true,H_est)), decreasing=TRUE, na.last=TRUE)
df      = data.frame(x=seq(0,1,length.out = 1000),
                     y=corrH)
df_text = data.frame(x=0.2,
                     y=0.6,
                     label = c(paste("RETROFIT:", round(DescTools::AUC(x=seq(0,1,length.out = 1000), y=corrH),digits=3))))

gg   <- ggplot2::ggplot(df, ggplot2::aes(x=x,y=y)) +
  ggplot2::geom_line() +
  ggplot2::scale_color_manual('gray30') +
  ggplot2::xlab("Normalized Rank") +
  ggplot2::ylab(expression(paste("Correlation (",H,",",widetilde(H),")"))) +
  ggplot2::theme_bw() +
  ggplot2::geom_text(data = df_text, ggplot2::aes(label = label))
plot(gg)
```

![](data:image/png;base64...)

In case of real data, where ground truth is not available, we can do certain diagnostics on the quality of results. For example, compute the correlation between marker expression (if known) and cell type proportion in ST data and visualize the agreement of the spatial pattern between markers and estimated proportion (read the paper for more information).

# 8 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] retrofit_1.10.0  Rcpp_1.1.0       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gld_2.6.8           gtable_0.3.6        xfun_0.53
##  [4] bslib_0.9.0         ggplot2_4.0.0       corrplot_0.95
##  [7] lattice_0.22-7      tzdb_0.5.0          vctrs_0.6.5
## [10] tools_4.5.1         bitops_1.0-9        generics_0.1.4
## [13] tibble_3.3.0        proxy_0.4-27        pkgconfig_2.0.3
## [16] Matrix_1.7-4        data.table_1.17.8   RColorBrewer_1.1-3
## [19] S7_0.2.0            pals_1.10           readxl_1.4.5
## [22] lifecycle_1.0.4     rootSolve_1.8.2.4   compiler_4.5.1
## [25] farver_2.1.2        stringr_1.5.2       Exact_3.3
## [28] tinytex_0.57        mapproj_1.2.12      htmltools_0.5.8.1
## [31] DescTools_0.99.60   maps_3.4.3          class_7.3-23
## [34] sass_0.4.10         RCurl_1.98-1.17     yaml_2.3.10
## [37] pillar_1.11.1       jquerylib_0.1.4     MASS_7.3-65
## [40] cachem_1.1.0        magick_2.9.0        boot_1.3-32
## [43] tidyselect_1.2.1    digest_0.6.37       mvtnorm_1.3-3
## [46] stringi_1.8.7       dplyr_1.1.4         reshape2_1.4.4
## [49] bookdown_0.45       forcats_1.0.1       labeling_0.4.3
## [52] fastmap_1.2.0       grid_4.5.1          colorspace_2.1-2
## [55] lmom_3.2            expm_1.0-0          cli_3.6.5
## [58] magrittr_2.0.4      dichromat_2.0-0.1   e1071_1.7-16
## [61] readr_2.1.5         withr_3.0.2         scales_1.4.0
## [64] httr_1.4.7          rmarkdown_2.30      cellranger_1.1.0
## [67] hms_1.1.4           png_0.1-8           evaluate_1.0.5
## [70] haven_2.5.5         knitr_1.50          rlang_1.1.6
## [73] glue_1.8.0          BiocManager_1.30.26 rstudioapi_0.17.1
## [76] jsonlite_2.0.0      R6_2.6.1            plyr_1.8.9
## [79] fs_1.6.6
```