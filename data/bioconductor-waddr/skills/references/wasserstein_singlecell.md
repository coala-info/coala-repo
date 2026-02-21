# Detection of differential gene expression distributions in single-cell RNA sequencing data

The [`waddR`](waddR.html) package provides an adaptation of the semi-parametric testing procedure based on the 2-Wasserstein distance which is specifically tailored to identify differential distributions in single-cell RNA seqencing (scRNAseq) data.

In particular, a two-stage (TS) approach is implemented that takes account of the specific nature of scRNAseq data by separately testing for differential proportions of zero gene expression (using a logistic regression model) and differences in non-zero gene expression (using the semi-parametric 2-Wasserstein distance-based test) between two conditions.

## Application to an example data set

As an example on how to analyze scRNAseq gene expression data for two different conditions, we look at decidua and blood samples from a data set by Vento-Tormo et al. (2018) (<https://doi.org/10.1038/s41586-018-0698-6>). For our purpose here, we use one a pre-processed and normalized replicate for the two conditions, which is available for download on [GitHub](https://github.com/goncalves-lab/waddR-data/).

First, we load all required packages:

```
suppressPackageStartupMessages({
    library("waddR")
    library("SingleCellExperiment")
    library("BiocFileCache")
})
```

Then, we download the example data set:

```
url.base <- "https://github.com/goncalves-lab/waddR-data/blob/master/data/"
sce.blood.url <- paste0(url.base, "data_blood.rda?raw=true")
sce.decidua.url <- paste0(url.base, "data_decidua.rda?raw=true")

getCachedPath <- function(url, rname){
    bfc <- BiocFileCache() # fire up cache
    res <- bfcquery(bfc, url, field="fpath", exact=TRUE)
    if (bfccount(res) == 0L)
        cachedFilePath <- bfcadd(bfc, rname=rname, fpath=url)
    else
        cachedFilePath <- bfcpath(bfc, res[["rid"]])
    cachedFilePath
}

load(getCachedPath(sce.blood.url, "data_blood"))
load(getCachedPath(sce.decidua.url, "data_decidua"))
```

Having downloaded the two `SingleCellExperiment` objects `data_blood` and `data_decidua`, we randomly select a subset of 1000 genes which we proceed with, as a whole analysis would be out of the scope of this vignette.

```
set.seed(28)
randgenes <- sample(rownames(data_blood), 1000, replace=FALSE)
sce.blood <- data_blood[randgenes, ]
sce.decidua <- data_decidua[randgenes, ]
```

The input data to the main function `wasserstein.sc` can be supplied either as an overall data matrix and a vector specifying the condition of each column (cell), or in the form of two `SingleCellExperiment` objects, one for each condition. Note that the input data matrix or the input `SingleCellExperiment` objects should ideally contain data that has been normalized for cell- or gene-specific biases, as is the case for our example data here.

We here proceed using the two loaded `SingleCellExperiment` objects. Note that the `SingleCellExperiment` objects supplied to `wasserstein.sc` must contain a `counts` assay each, which contains the corresponding (ideally normalized) expression data matrix.

```
assays(sce.blood)
#> List of length 1
#> names(1): counts
assays(sce.decidua)
#> List of length 1
#> names(1): counts
```

The test is then performed using the `wasserstein.sc` function. To obtain reproducible results, a `seed` is set when calling `wasserstein.sc`. For convenience with repect to computation time, we employ `permnum=1000` permutations in our example here, while typically the use of more than 1000 permutations is recommended. We specifically consider a two-stage (TS) procedure here (`method="TS"`), which includes a test for differential proportions of zero gene expression (DPZ) and a test for differential distributions for non-zero gene expression. The TS procedure is applied to all genes in the data set, with one row of the output corresponding to the test result of one specific gene. Note that the DPZ test in the TS procedure takes account of the cellular detection rate and thus depends on the number of considered genes. Hence, the DPZ test results for our exemplary subset of genes differ from that when the test is applied to the whole set of genes.

```
res <- wasserstein.sc(sce.blood, sce.decidua, method="TS",permnum=1000,seed=24)
head(res, n=10L)
#>                              d.wass  d.wass^2  d.comp^2    d.comp   location
#> TBC1D10A-ENSG00000099992  0.4374049 0.1913230 0.1910411 0.4370825 0.16525365
#> KATNBL1-ENSG00000134152   0.4672668 0.2183383 0.2179593 0.4668611 0.20703597
#> ACVR1B-ENSG00000135503    0.5512761 0.3039053 0.2991235 0.5469218 0.24135455
#> LCMT1-AS1-ENSG00000260448 0.5024994 0.2525056 0.2690362 0.5186870 0.09321209
#> PRPS2-ENSG00000101911     0.5067186 0.2567637 0.2561704 0.5061328 0.24615711
#> RBM18-ENSG00000119446     0.4745888 0.2252345 0.2248189 0.4741508 0.20232745
#> HTT-ENSG00000197386       0.5371767 0.2885588 0.2876105 0.5362933 0.24187275
#> SGCD-ENSG00000170624             NA        NA        NA        NA         NA
#> NTMT1-ENSG00000148335     0.4438114 0.1969685 0.1958962 0.4426017 0.15861639
#> YTHDC2-ENSG00000047188    0.4079472 0.1664209 0.1657618 0.4071386 0.12423241
#>                                  size       shape       rho    p.nonzero
#> TBC1D10A-ENSG00000099992  0.021074396 0.004713024 0.9631361 1.490688e-10
#> KATNBL1-ENSG00000134152   0.005251694 0.005671621 0.9616423 4.631608e-10
#> ACVR1B-ENSG00000135503    0.044776858 0.012992068 0.7981924 9.593193e-03
#> LCMT1-AS1-ENSG00000260448 0.150547503 0.025276586 0.8263264 2.340000e-01
#> PRPS2-ENSG00000101911     0.005355620 0.004657646 0.9711169 6.664950e-09
#> RBM18-ENSG00000119446     0.009141826 0.013349665 0.8995144 3.254822e-07
#> HTT-ENSG00000197386       0.031727250 0.014010479 0.9206277 3.126485e-07
#> SGCD-ENSG00000170624               NA          NA        NA           NA
#> NTMT1-ENSG00000148335     0.034006536 0.003273305 0.9652643 1.340940e-07
#> YTHDC2-ENSG00000047188    0.034077247 0.007452183 0.9333628 1.589723e-07
#>                             p.ad.gpd N.exc perc.loc perc.size perc.shape
#> TBC1D10A-ENSG00000099992  0.40301453   250    86.50     11.03       2.47
#> KATNBL1-ENSG00000134152   0.06555501   250    94.99      2.41       2.60
#> ACVR1B-ENSG00000135503    0.45863425   250    80.69     14.97       4.34
#> LCMT1-AS1-ENSG00000260448         NA    NA    34.65     55.96       9.40
#> PRPS2-ENSG00000101911     0.06025367   250    96.09      2.09       1.82
#> RBM18-ENSG00000119446     0.55222476   250    90.00      4.07       5.94
#> HTT-ENSG00000197386       0.23819388   250    84.10     11.03       4.87
#> SGCD-ENSG00000170624              NA    NA       NA        NA         NA
#> NTMT1-ENSG00000148335     0.31841709   250    80.97     17.36       1.67
#> YTHDC2-ENSG00000047188    0.31272403   250    74.95     20.56       4.50
#>                           decomp.error       p.zero   p.combined p.adj.nonzero
#> TBC1D10A-ENSG00000099992   0.001473747 0.5969227510 2.148269e-09  5.373931e-10
#> KATNBL1-ENSG00000134152    0.001735693 0.0371637528 4.438382e-10  1.567788e-09
#> ACVR1B-ENSG00000135503     0.015734593 0.0825630972 6.447944e-03  1.353560e-02
#> LCMT1-AS1-ENSG00000260448  0.065466085 0.2858556037 2.478083e-01  2.673756e-01
#> PRPS2-ENSG00000101911      0.002310943 0.2389382559 3.385354e-08  1.914514e-08
#> RBM18-ENSG00000119446      0.001845202 0.0595411973 3.635428e-07  7.333521e-07
#> HTT-ENSG00000197386        0.003286331 0.2606551281 1.411690e-06  7.111028e-07
#> SGCD-ENSG00000170624                NA 0.7370453706 7.370454e-01            NA
#> NTMT1-ENSG00000148335      0.005444007 0.0000104253 3.955698e-11  3.180322e-07
#> YTHDC2-ENSG00000047188     0.003960462 0.9555869267 2.536923e-06  3.745720e-07
#>                             p.adj.zero p.adj.combined
#> TBC1D10A-ENSG00000099992  0.8787685653   8.457751e-09
#> KATNBL1-ENSG00000134152   0.1568090835   1.888673e-09
#> ACVR1B-ENSG00000135503    0.2808268614   1.239989e-02
#> LCMT1-AS1-ENSG00000260448 0.6132789759   3.644240e-01
#> PRPS2-ENSG00000101911     0.5556703625   1.163352e-07
#> RBM18-ENSG00000119446     0.2263923852   1.102937e-06
#> HTT-ENSG00000197386       0.5870610994   4.044957e-06
#> SGCD-ENSG00000170624      0.9335326862   8.413760e-01
#> NTMT1-ENSG00000148335     0.0001556015   1.874738e-10
#> YTHDC2-ENSG00000047188    0.9800891556   6.988768e-06
```

Output of the 2-Wasserstein distance-based two-stage test for scRNAseq data

| Output column | Description |
| --- | --- |
| d.wass | 2-Wasserstein distance between the two samples: quantile approximation |
| d.wass^2 | squared 2-Wasserstein distance between the two samples: quantile approximation |
| d.comp^2 | squared 2-Wasserstein distance: decomposition approximation |
| d.comp | 2-Wasserstein distance: decomposition approximation |
| location | location term in the decomposition of the squared 2-Wasserstein distance |
| size | size term in the decomposition of the squared 2-Wasserstein distance |
| shape | shape term in the decomposition of the squared 2-Wasserstein distance |
| rho | correlation coefficient in the quantile-quantile plot |
| p.nonzero | p-value of the semi-parametric 2-Wasserstein distance-based test |
| p.ad.gpd | p-value of the Anderson-Darling test to check whether the GPD actually fits the data well \* |
| N.exc | number of exceedances (starting with 250 and iteratively decreased by 10 if necessary) that are required to obtain a good GPD fit (i.e. p-value of Anderson-Darling test greater than or equal to 0.05) \* |
| perc.loc | fraction (in %) of the location part with respect to the overall squared 2-Wasserstein distance obtained by the decomposition approximation |
| perc.size | fraction (in %) of the size part with respect to the overall squared 2-Wasserstein distance obtained by the decomposition approximation |
| perc.shape | fraction (in %) of the shape part with respect to the overall squared 2-Wasserstein distance obtained by the decomposition approximation |
| decomp.error | relative error between the squared 2-Wasserstein distance computed by the quantile approximation and the squared 2-Wasserstein distance computed by the decomposition approximation |
| p.zero | p-value of the test for differential proportions of zero expression (logistic regression model) |
| p.combined | combined p-value of p.nonzero and p.zero obtained by Fisher’s method |
| pval.adj | adjusted p-value of the semi-parametric 2-Wasserstein distance-based test according to the method of Benjamini-Hochberg |
| p.adj.zero | adjusted p-value of the test for differential proportions of zero expression (logistic regression model) according to the method of Benjamini-Hochberg |
| p.adj.combined | adjusted combined p-value of p.nonzero and p.zero obtained by Fisher’s method according to the method of Benjamini-Hochberg |

*\* only if GPD fitting is performed (otherwise NA)*

For further details of the testing procedure for scRNAseq data, see `?wasserstein.sc`.

## See also

* The [`waddR` package](waddR.html)
* [Calculation of the Wasserstein distance](wasserstein_metric.html)
* [Two-sample tests](wasserstein_test.html) to check for differences between two distributions

## Session info

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
#>  [1] BiocFileCache_3.0.0         dbplyr_2.5.1
#>  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           waddR_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] xfun_0.53           bslib_0.9.0         httr2_1.2.1
#>  [4] lattice_0.22-7      Rdpack_2.6.4        vctrs_0.6.5
#>  [7] tools_4.5.1         curl_7.0.0          parallel_4.5.1
#> [10] tibble_3.3.0        RSQLite_2.4.3       blob_1.2.4
#> [13] pkgconfig_2.0.3     Matrix_1.7-4        arm_1.14-4
#> [16] lifecycle_1.0.4     compiler_4.5.1      codetools_0.2-20
#> [19] eva_0.2.6           htmltools_0.5.8.1   sass_0.4.10
#> [22] yaml_2.3.10         nloptr_2.2.1        pillar_1.11.1
#> [25] jquerylib_0.1.4     MASS_7.3-65         BiocParallel_1.44.0
#> [28] cachem_1.1.0        DelayedArray_0.36.0 reformulas_0.4.2
#> [31] boot_1.3-32         abind_1.4-8         nlme_3.1-168
#> [34] tidyselect_1.2.1    digest_0.6.37       purrr_1.1.0
#> [37] dplyr_1.1.4         splines_4.5.1       fastmap_1.2.0
#> [40] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [43] magrittr_2.0.4      S4Arrays_1.10.0     withr_3.0.2
#> [46] filelock_1.0.3      rappdirs_0.3.3      bit64_4.6.0-1
#> [49] rmarkdown_2.30      XVector_0.50.0      bit_4.6.0
#> [52] lme4_1.1-37         memoise_2.0.1       coda_0.19-4.1
#> [55] evaluate_1.0.5      knitr_1.50          rbibutils_2.3
#> [58] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
#> [61] DBI_1.2.3           minqa_1.2.8         jsonlite_2.0.0
#> [64] R6_2.6.1
```