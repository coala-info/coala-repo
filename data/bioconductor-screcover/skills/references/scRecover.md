# scRecover

#### Zhun Miao, Xuegong Zhang

#### 2019-04-28

![](data:image/png;base64...)

# 1. Introduction

**`scRecover`** is an R package for **imputation of single-cell RNA-seq (scRNA-seq) data**. It will detect and impute dropout values in a scRNA-seq raw read counts matrix while **keeping the real zeros unchanged**.

Since there are both dropout zeros and real zeros in scRNA-seq data, imputation methods should not impute all the zeros to non-zero values. To distinguish dropout and real zeros, **`scRecover`** employs the Zero-Inflated Negative Binomial (ZINB) model for dropout probability estimation of each gene and accumulation curves for prediction of dropout number in each cell. By combination with scImpute, SAVER and MAGIC, it not only detects dropout and real zeros **at higher accuracy**, but also **improve the downstream clustering and visualization results**.

# 2. Citation

If you use **`scRecover`** in published research, please cite:

# 3. Installation

To install **`scRecover`** from [**Bioconductor**](http://bioconductor.org/packages/scRecover/):

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scRecover")
```

To install the *developmental version* from [**Bioconductor**](https://bioconductor.org/packages/devel/bioc/html/scRecover.html):

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scRecover", version = "devel")
```

Or install the *developmental version* from [**GitHub**](https://github.com/miaozhun/scRecover/):

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("miaozhun/scRecover")
```

To load **`scRecover`** and other required packages for the vignettes in R:

```
library(scRecover)
library(BiocParallel)
suppressMessages(library(SingleCellExperiment))
```

# 4. Input

**`scRecover`** takes two inputs: `counts` and one of `Kcluster` or `labels`.

The input `counts` is a scRNA-seq **read counts matrix** or a **`SingleCellExperiment`** object which contains the read counts matrix. The rows of the matrix are genes and columns are cells.

`Kcluster` is an integer specifying the number of cell subpopulations. This parameter can be determined based on prior knowledge or clustering of raw data. `Kcluster` is used to determine the candidate neighbors of each cell and need not to be very accurate.

`labels` is a character/integer vector specifying the cell type of each column in the raw count matrix. Only needed when `Kcluster = NULL`. Each cell type should have at least two cells for imputation.

# 5. Test data

Users can load the test data in **`scRecover`** by

```
data(scRecoverTest)
```

The test data `counts` in `scRecoverTest` is a scRNA-seq read counts matrix which has 200 genes (rows) and 150 cells (columns).

```
dim(counts)
#> [1] 200 150
counts[1:6, 1:6]
#>        E3.46.3383 E3.51.3425 E3.46.3388 E3.51.3423 E3.46.3382 E3.49.3407
#> BTG4           22          0         12         26          0          0
#> GABRB1          0          0          0          0          0          0
#> IL9             0          0          0          0          0          0
#> TAPBPL          2          0          5          1          0          2
#> KANK4           0          0          0          0          0          0
#> CPSF2          12          0         95          0          5        115
```

The object `labels` in `scRecoverTest` is a vector of integer specifying the cell types in the read counts matrix, corresponding to the columns of `counts`.

```
length(labels)
#> [1] 150
table(labels)
#> labels
#>   1   2
#>  50 100
```

The object `oneCell` in `scRecoverTest` is a vector of a cell’s raw read counts for each gene.

```
head(oneCell)
#>         Vsx2_1a_F2
#> Itm2a            0
#> Gm26258          0
#> Sergef         149
#> Gm24106          0
#> Fam109a          0
#> Ssu72           60
length(oneCell)
#> [1] 24538
```

# 6. Usage

## 6.1 Imputation using scRecover

### 6.1.1 With read counts matrix input

Here is an example to run **`scRecover`** with read counts matrix input:

```
# Load test data for scRecover
data(scRecoverTest)

# Run scRecover with Kcluster specified
scRecover(counts = counts, Kcluster = 2, outputDir = "./outDir_scRecover/", verbose = FALSE)
#> [1] "========================= Running scImpute ========================="
#> [1] "reading in raw count matrix ..."
#> [1] "number of genes in raw count matrix 200"
#> [1] "number of cells in raw count matrix 150"
#> [1] "reading finished!"
#> [1] "imputation starts ..."
#> [1] "searching candidate neighbors ... "
#> [1] "inferring cell similarities ..."
#> [1] "dimension reduction ..."
#> [1] "calculating cell distances ..."
#> [1] "cluster sizes:"
#> [1] 92 54
#> [1] "estimating dropout probability for type 1 ..."
#> [1] "searching for valid genes ..."
#> [1] "imputing dropout values for type 1 ..."
#> [1] "estimating dropout probability for type 2 ..."
#> [1] "searching for valid genes ..."
#> [1] "imputing dropout values for type 2 ..."
#> [1] "writing imputed count matrix ..."
#> [1] "========================= scImpute finished ========================"
#>
#> Processing 1 of 2 cell clusters
#>
#> Processing 2 of 2 cell clusters
#>
#> [1] "======================== scRecover finished! ========================"
#> [1] "The output files of scRecover are in directory:"
#> [1] "./outDir_scRecover/"
#> [1] "============================== Cheers! =============================="

# Or run scRecover with labels specified
# scRecover(counts = counts, labels = labels, outputDir = "./outDir_scRecover/")
```

### 6.1.2 With SingleCellExperiment input

The [`SingleCellExperiment`](http://bioconductor.org/packages/SingleCellExperiment/) class is a widely used S4 class for storing single-cell genomics data. **`scRecover`** also could take the `SingleCellExperiment` data representation as input.

Here is an example to run **`scRecover`** with `SingleCellExperiment` input:

```
# Load test data for scRecover
data(scRecoverTest)

# Convert the test data in scRecover to SingleCellExperiment data representation
sce <- SingleCellExperiment(assays = list(counts = as.matrix(counts)))

# Run scRecover with SingleCellExperiment input sce (Kcluster specified)
scRecover(counts = sce, Kcluster = 2, outputDir = "./outDir_scRecover/", verbose = FALSE)
#> [1] "========================= Running scImpute ========================="
#> [1] "reading in raw count matrix ..."
#> [1] "number of genes in raw count matrix 200"
#> [1] "number of cells in raw count matrix 150"
#> [1] "reading finished!"
#> [1] "imputation starts ..."
#> [1] "searching candidate neighbors ... "
#> [1] "inferring cell similarities ..."
#> [1] "dimension reduction ..."
#> [1] "calculating cell distances ..."
#> [1] "cluster sizes:"
#> [1] 92 54
#> [1] "estimating dropout probability for type 1 ..."
#> [1] "searching for valid genes ..."
#> [1] "imputing dropout values for type 1 ..."
#> [1] "estimating dropout probability for type 2 ..."
#> [1] "searching for valid genes ..."
#> [1] "imputing dropout values for type 2 ..."
#> [1] "writing imputed count matrix ..."
#> [1] "========================= scImpute finished ========================"
#>
#> Processing 1 of 2 cell clusters
#>
#> Processing 2 of 2 cell clusters
#>
#> [1] "======================== scRecover finished! ========================"
#> [1] "The output files of scRecover are in directory:"
#> [1] "./outDir_scRecover/"
#> [1] "============================== Cheers! =============================="

# Or run scRecover with SingleCellExperiment input sce (labels specified)
# scRecover(counts = sce, labels = labels, outputDir = "./outDir_scRecover/")
```

## 6.2 Estimate dropout gene number in a cell

Function `estDropoutNum` in the package could estimate the dropout gene number or all expressed gene number (namely observed gene number plus dropout gene number) in a cell:

```
# Load test data
data(scRecoverTest)

# Downsample 10% read counts in oneCell
set.seed(999)
oneCell.down <- countsSampling(counts = oneCell, fraction = 0.1)

# Count the groundtruth dropout gene number in the downsampled cell
sum(oneCell.down == 0 & oneCell != 0)
#> [1] 2095

# Estimate the dropout gene number in the downsampled cell by estDropoutNum
estDropoutNum(sample = oneCell.down, depth = 10, return = "dropoutNum")
#> [1] 1994
```

Blow shows the expressed gene number predicted by `estDropoutNum` with 10% downsampled reads and the groundtruth expressed gene number derived by downsampling when the reads depth varying from 0% to 100% of the total reads.

![](data:image/png;base64...)

# 7. Output

Imputed expression matrices of **`scRecover`** will be saved in the output directory specified by or a folder named with prefix ‘outDir\_scRecover\_’ under the current working directory when is unspecified.

# 8. Parallelization

**`scRecover`** integrates parallel computing function with [`BiocParallel`](http://bioconductor.org/packages/BiocParallel/) package. Users could just set `parallel = TRUE` (default) in function `scRecover` to enable parallelization and leave the `BPPARAM` parameter alone.

```
# Run scRecover with Kcluster specified
scRecover(counts = counts, Kcluster = 2, parallel = TRUE)

# Run scRecover with labels specified
scRecover(counts = counts, labels = labels, parallel = TRUE)
```

Advanced users could use a `BiocParallelParam` object from package `BiocParallel` to fill in the `BPPARAM` parameter to specify the parallel back-end to be used and its configuration parameters.

## 8.1 For Unix and Mac users

The best choice for Unix and Mac users is to use `MulticoreParam` to configure a multicore parallel back-end:

```
# Set the parameters and register the back-end to be used
param <- MulticoreParam(workers = 18, progressbar = TRUE)
register(param)

# Run scRecover with 18 cores (Kcluster specified)
scRecover(counts = counts, Kcluster = 2, parallel = TRUE, BPPARAM = param)

# Run scRecover with 18 cores (labels specified)
scRecover(counts = counts, labels = labels, parallel = TRUE, BPPARAM = param)
```

## 8.2 For Windows users

For Windows users, use `SnowParam` to configure a Snow back-end is a good choice:

```
# Set the parameters and register the back-end to be used
param <- SnowParam(workers = 8, type = "SOCK", progressbar = TRUE)
register(param)

# Run scRecover with 8 cores (Kcluster specified)
scRecover(counts = counts, Kcluster = 2, parallel = TRUE, BPPARAM = param)

# Run scRecover with 8 cores (labels specified)
scRecover(counts = counts, labels = labels, parallel = TRUE, BPPARAM = param)
```

See the [*Reference Manual*](https://bioconductor.org/packages/release/bioc/manuals/BiocParallel/man/BiocParallel.pdf) of [`BiocParallel`](http://bioconductor.org/packages/BiocParallel/) package for more details of the `BiocParallelParam` class.

# 9. Evaluation of scRecover

## 9.1 On downsampling data

We evaluated SAVER, scImpute, MAGIC and their combined with scRecover version SAVER+scRecover, scImpute+scRecover, MAGIC+scRecover on a downsampling scRNA-seq dataset generated by random sampling of reads from a SMART-seq2 scRNA-seq dataset (Petropoulos S, et al. Cell, 2016, <https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-3929/>).

### 9.1.1 Accuracy of dropout prediction

We found after combined with scRecover, scImpute+scRecover, SAVER+scRecover and MAGIC+scRecover will have higher accuracy than scImpute, SAVER and MAGIC respectively.

![](data:image/png;base64...)

### 9.1.2 Predicted dropout number

We found scImpute+scRecover, SAVER+scRecover and MAGIC+scRecover will have predicted dropout numbers closer to the real dropout number than without combination with scRecover.

![](data:image/png;base64...)

## 9.2 On 10X data

We applied the 6 imputation methods to a 10X scRNA-seq dataset (<https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.0/heart_1k_v3>).

Then we measured the downstream clustering and visualization results by comparing to the cell labels originated from the dataset and deriving their Adjusted Rand Index (ARI) and Jaccard indexes (the larger, the better).

We found a significant improvement of SAVER, scImpute and MAGIC after combined with scRecover.

![](data:image/png;base64...)

Gene number before and after imputation:

![](data:image/png;base64...)

## 9.3 On SMART-seq data

Next, we applied the 6 imputation methods to a SMART-seq scRNA-seq dataset (Chu L, et al. Genome Biology, 2016, <https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE75748>).

Then we measured the downstream clustering and visualization results by comparing to the cell labels originated from the dataset and deriving their Adjusted Rand Index (ARI) and Jaccard indexes (the larger, the better).

We found a significant improvement of SAVER, scImpute and MAGIC after combined with scRecover.

![](data:image/png;base64...)

Gene number before and after imputation:

![](data:image/png;base64...)

# 10. Help

Use `browseVignettes("scRecover")` to see the vignettes of **`scRecover`** in R after installation.

Use the following code in R to get access to the help documentation for **`scRecover`**:

```
# Documentation for scRecover
?scRecover

# Documentation for estDropoutNum
?estDropoutNum

# Documentation for countsSampling
?countsSampling

# Documentation for normalization
?normalization

# Documentation for test data
?scRecoverTest
?counts
?labels
?oneCell
```

You are also welcome to contact the author by email for help.

# 11. Author

*Zhun Miao, Xuegong Zhang* <zhangxg@tsinghua.edu.cn>

MOE Key Laboratory of Bioinformatics; Bioinformatics Division and Center for Synthetic & Systems Biology, TNLIST; Department of Automation, Tsinghua University, Beijing 100084, China.

# 12. Session info

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
#>  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           BiocParallel_1.44.0
#> [13] scRecover_1.26.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
#>  [4] digest_0.6.37       evaluate_1.0.5      grid_4.5.1
#>  [7] iterators_1.0.14    mvtnorm_1.3-3       fastmap_1.2.0
#> [10] foreach_1.5.2       doParallel_1.0.17   jsonlite_2.0.0
#> [13] Matrix_1.7-4        survival_3.8-3      kernlab_0.9-33
#> [16] gamlss.dist_6.1-1   codetools_0.2-20    numDeriv_2016.8-1.1
#> [19] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
#> [22] SAVER_1.1.2         rlang_1.1.6         bbmle_1.0.25.1
#> [25] XVector_0.50.0      splines_4.5.1       DelayedArray_0.36.0
#> [28] cachem_1.1.0        yaml_2.3.10         S4Arrays_1.10.0
#> [31] tools_4.5.1         parallel_4.5.1      polynom_1.4-1
#> [34] bdsmatrix_1.3-7     rsvd_1.0.5          penalized_0.9-53
#> [37] R6_2.6.1            lifecycle_1.0.4     MASS_7.3-65
#> [40] gamlss.data_6.0-7   bslib_0.9.0         gamlss_5.5-0
#> [43] Rcpp_1.1.0          xfun_0.53           preseqR_4.0.0
#> [46] knitr_1.50          htmltools_0.5.8.1   nlme_3.1-168
#> [49] rmarkdown_2.30      pscl_1.5.9          compiler_4.5.1
```