# transformGamPoi Quickstart

Constantin Ahlmann-Eltze

#### 2025-10-30

# Contents

* [1 Installation](#installation)
* [2 Example](#example)
  + [2.1 Delta method-based variance stabilizing transformations](#delta-method-based-variance-stabilizing-transformations)
  + [2.2 Model residuals-based variance stabilizing transformations](#model-residuals-based-variance-stabilizing-transformations)
* [3 Session Info](#session-info)

*transformGamPoi* provides variance stabilizing transformations to handle the heteroskedasticity of count data. For example single-cell RNA sequencing counts vary more for highly expressed genes than for lowly expressed genes. However, many classical statistical methods perform best on data with uniform variance. This package provides a set of different variance stabilizing transformations to make the subsequent application of generic statistical methods more palatable.

# 1 Installation

You can install *transformGamPoi* from [Bioconductor](https://bioconductor.org/packages/transformGamPoi/) after it has been accepted using the following command

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("transformGamPoi")
```

In the mean time or to get the latest development version, you can install *transformGamPoi* directly from [GitHub](https://github.com/const-ae/transformGamPoi) using the [devtools](https://devtools.r-lib.org/) package

```
# install.packages("devtools")
devtools::install_github("const-ae/transformGamPoi")
```

# 2 Example

The functions in *transformGamPoi* take any kind of matrix-like object (e.g., `matrix`, `dgCMatrix`, `DelayedArray`, `SummarizedExperiment`, `SingleCellExperiment`) and return the corresponding transformed matrix objects. For sparse input the functions try to preserve sparsity. For container objects like `SummarizedExperiment`, *transformGamPoi* extracts the `"counts"` assay and returns an object of the same type as that `"counts"` assay.

We start by loading the package to make the transformation functions available in our R session:

```
library(transformGamPoi)
```

In the next step, we load some example data. Here, we use a single-cell RNA sequencing experiment of 4096 blood cells. For convenience, we subset the data to 1,000 genes and 5,00 cells

```
# Load the 'TENxPBMCData' as a SingleCellExperiment object
sce <- TENxPBMCData::TENxPBMCData("pbmc4k")
#> see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
#> loading from cache
# Subset the data to 1,000 x 500 random genes and cells
sce <- sce[sample(nrow(sce), 1000), sample(ncol(sce), 500)]
```

If we take a look at the stored counts (mainly zeros) stored as a sparse matrix of type `DelayedMatrix`. Fortunately, the precise meaning of that storage type is not important, because *transformGamPoi* handles this automatically.

```
assay(sce, "counts")[1:10, 1:5]
#> <10 x 5> sparse DelayedMatrix object of type "integer":
#>                 [,1] [,2] [,3] [,4] [,5]
#> ENSG00000167014    0    0    0    0    0
#> ENSG00000244575    0    0    0    0    0
#> ENSG00000118495    0    0    0    0    0
#> ENSG00000140479    0    0    0    0    0
#> ENSG00000236641    0    0    0    0    0
#> ENSG00000131174    0    1    2    0    0
#> ENSG00000250905    0    0    0    0    0
#> ENSG00000162040    0    0    0    0    0
#> ENSG00000140557    0    0    0    0    0
#> ENSG00000273523    0    0    0    0    0
```

To see what we mean by heteroskedasticity, let us compare the mean and variance for each gene across cells. We will use the [*MatrixGenerics*](https://bioconductor.org/packages/MatrixGenerics/) package to calculate the row means and row variances. You might be familiar with the [*matrixStats*](https://cran.r-project.org/package%3DmatrixStats) package; *MatrixGenerics* provides the same set of functions but depending on the type of the matrix automatically dispatches the call to either *matrixStats*, [*DelayedMatrixStats*](https://bioconductor.org/packages/DelayedMatrixStats/), or [*sparseMatrixStats*](https://bioconductor.org/packages/sparseMatrixStats/).

```
library(MatrixGenerics)
# Exclude genes where all counts are zero
sce <- sce[rowMeans2(counts(sce)) > 0, ]
gene_means <- rowMeans2(counts(sce))
gene_var <- rowVars(counts(sce))
plot(gene_means, gene_var, log = "xy", main = "Log-log scatter plot of mean vs variance")
abline(a = 0, b = 1)
sorted_means <- sort(gene_means)
lines(sorted_means, sorted_means + 0.2 * sorted_means^2, col = "purple")
```

![](data:image/png;base64...)
The purple line shows a quadratic mean-variance relation (\(\text{Var} = \mu + 0.2 \mu^2\)) typical for data that is Gamma-Poisson distributed. For example a gene with a mean expression of 5 the corresponding variance is 10, whereas for a gene with a mean expression of 500 the variance ~50,000. Here we used an overdispersion of \(\alpha = 0.2\), *transformGamPoi* provides options to either fit \(\alpha\) on the data or fix it to a user-defined value.

*transformGamPoi* implements two approaches for variance stabilization: (1) based on the delta method, (2) based on model residuals.

## 2.1 Delta method-based variance stabilizing transformations

The delta method relates the standard deviation of a transformed random variable \(g(X\_i)\) to the standard deviation of the original random variable \(X\_i\). This can be used to find a function such that \(g(X\_i) = \text{const}\). For a quadratic mean variance relation this function is
\[
g(x) = \frac{1}{\sqrt{\alpha}} \text{acosh}(2 \alpha x + 1).
\]

We can apply this transformation to the counts:

```
assay(sce, "acosh") <- acosh_transform(assay(sce, "counts"))
# Equivalent to 'assay(sce, "acosh") <- acosh_transform(sce)'
```

We plot the variance of the `acosh` transformed counts and find that for \(\mu < 0.5\) the variance still increases for higher average gene expression. However, for larger expression values the variance for a gene is approximately independent of the corresponding average gene expression (note that the y-axis is not log transformed anymore!).

```
acosh_var <- rowVars(assay(sce, "acosh"))
plot(gene_means, acosh_var, log = "x", main = "Log expression vs variance of acosh stabilized values")
abline(h = 1)
```

![](data:image/png;base64...)

The most popular transformation for single cell data is \(g(x) = \log(x + c)\) with pseudo-count \(c=1\). It turns out that this transformation is closely related to the `acosh` transformation. When we choose \(c = 1/(4\alpha)\) the two converge rapidly, only for small values the `acosh` is closer to \(g(x) = 2\sqrt{x}\):

```
x <- seq(0, 30, length.out = 1000)
y_acosh <- acosh_transform(x, overdispersion = 0.1)
y_shiftLog <- shifted_log_transform(x, pseudo_count = 1/(4 * 0.1))
y_sqrt <- 2 * sqrt(x) # Identical to acosh_transform(x, overdispersion = 0)
```

The plot looks as follows:

```
plot(x, y_acosh, type = "l", col = "black", lwd = 3, ylab = "g(x)", ylim = c(0, 10))
lines(x, y_shiftLog, col = "red", lwd = 3)
lines(x, y_sqrt, col = "blue", lwd = 3)
legend("bottomright", legend = c(expression(2*sqrt(x)),
                                 expression(1/sqrt(alpha)~acosh(2*alpha*x+1)),
                                 expression(1/sqrt(alpha)~log(x+1/(4*alpha))+b)),
       col = c("blue", "black", "red"), lty = 1, inset = 0.1, lwd = 3)
```

![](data:image/png;base64...)
The offset \(b\) for the shifted logarithm has no influence on the variance stabilization. We choose \(b\) such that sparsity of the input is retained (i.e., \(g(0) = 0\)).

## 2.2 Model residuals-based variance stabilizing transformations

An alternative approach for variance stabilization was suggested by Hafemeister and Satija (2019). They used the Pearson residuals from a Gamma-Poisson generalized linear model fit as the variance stabilized values. The advantage of this approach is that the variance is also stabilized for lowly expressed genes unlike the delta method-based transformations:

```
assay(sce, "pearson") <- residual_transform(sce, "pearson", clipping = TRUE, on_disk = FALSE)
```

```
pearson_var <- rowVars(assay(sce, "pearson"))
plot(gene_means, pearson_var, log = "x", main = "Log expression vs variance of Pearson residuals")
abline(h = 1)
```

![](data:image/png;base64...)

Pearson residuals are by definition a linear transformation. This means that for genes with strong expression differences across subgroups they cannot achieve variance stabilization. As an alternative, *transformGamPoi* provides randomized quantile residuals which are non-linear and exploit randomization to work around the discrete nature of counts:

```
assay(sce, "rand_quantile") <- residual_transform(sce, "randomized_quantile", on_disk = FALSE)
```

```
rand_quant_var <- rowVars(assay(sce, "rand_quantile"))
plot(gene_means, rand_quant_var, log = "x", main = "Log expression vs variance of Randomized Quantile residuals")
abline(h = 1)
```

![](data:image/png;base64...)

# 3 Session Info

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
#>  [1] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [3] h5mread_1.2.0               rhdf5_2.54.0
#>  [5] DelayedArray_0.36.0         SparseArray_1.10.0
#>  [7] S4Arrays_1.10.0             abind_1.4-8
#>  [9] Matrix_1.7-4                SingleCellExperiment_1.32.0
#> [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [15] IRanges_2.44.0              S4Vectors_0.48.0
#> [17] BiocGenerics_0.56.0         generics_0.1.4
#> [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [21] transformGamPoi_1.16.0      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0           xfun_0.53
#>  [3] bslib_0.9.0               httr2_1.2.1
#>  [5] lattice_0.22-7            rhdf5filters_1.22.0
#>  [7] vctrs_0.6.5               tools_4.5.1
#>  [9] curl_7.0.0                tibble_3.3.0
#> [11] AnnotationDbi_1.72.0      RSQLite_2.4.3
#> [13] blob_1.2.4                pkgconfig_2.0.3
#> [15] dbplyr_2.5.1              sparseMatrixStats_1.22.0
#> [17] lifecycle_1.0.4           compiler_4.5.1
#> [19] Biostrings_2.78.0         tinytex_0.57
#> [21] glmGamPoi_1.22.0          htmltools_0.5.8.1
#> [23] sass_0.4.10               yaml_2.3.10
#> [25] pillar_1.11.1             crayon_1.5.3
#> [27] jquerylib_0.1.4           cachem_1.1.0
#> [29] magick_2.9.0              ExperimentHub_3.0.0
#> [31] AnnotationHub_4.0.0       tidyselect_1.2.1
#> [33] digest_0.6.37             purrr_1.1.0
#> [35] dplyr_1.1.4               bookdown_0.45
#> [37] BiocVersion_3.22.0        fastmap_1.2.0
#> [39] grid_4.5.1                cli_3.6.5
#> [41] magrittr_2.0.4            withr_3.0.2
#> [43] DelayedMatrixStats_1.32.0 filelock_1.0.3
#> [45] rappdirs_0.3.3            bit64_4.6.0-1
#> [47] rmarkdown_2.30            XVector_0.50.0
#> [49] httr_1.4.7                bit_4.6.0
#> [51] png_0.1-8                 beachmat_2.26.0
#> [53] memoise_2.0.1             evaluate_1.0.5
#> [55] knitr_1.50                BiocFileCache_3.0.0
#> [57] rlang_1.1.6               Rcpp_1.1.0
#> [59] glue_1.8.0                DBI_1.2.3
#> [61] BiocManager_1.30.26       jsonlite_2.0.0
#> [63] Rhdf5lib_1.32.0           R6_2.6.1
```