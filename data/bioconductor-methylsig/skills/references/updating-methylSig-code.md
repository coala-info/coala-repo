# Updating methylSig code

Raymond G. Cavalcante

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Reading Data](#reading-data)
  + [2.1 Old methylSig](#old-methylsig)
  + [2.2 New methylSig](#new-methylsig)
* [3 Tiling Data](#tiling-data)
  + [3.1 Old methylSig](#old-methylsig-1)
  + [3.2 New methylSig](#new-methylsig-1)
* [4 Testing](#testing)
  + [4.1 MethylSig Test](#methylsig-test)
    - [4.1.1 Old methylSig](#old-methylsig-2)
    - [4.1.2 New methylSig](#new-methylsig-2)
  + [4.2 DSS Test](#dss-test)
    - [4.2.1 Old methylSig](#old-methylsig-3)
    - [4.2.2 New methylSig](#new-methylsig-3)
* [5 Session Info](#session-info)

```
library(methylSig)
```

# 1 Introduction

The purpose of this vignette is to show users how to retrofit their `methylSig` < 0.99.0 code to work with the refactor in version 0.99.0 and later.

# 2 Reading Data

## 2.1 Old methylSig

In versions < 0.99.0 of `methylSig`, the `methylSigReadData()` function read Bismark coverage files, Bismark genome-wide CpG reports, or MethylDackel bedGraphs. Additionally, users could destrand the data, filter by coverage, and filter SNPs.

```
meth = methylSigReadData(
    fileList = files,
    pData = pData,
    assembly = 'hg19',
    destranded = TRUE,
    maxCount = 500,
    minCount = 10,
    filterSNPs = TRUE,
    num.cores = 1,
    fileType = 'cytosineReport')
```

## 2.2 New methylSig

In versions >= 0.99.0 of `methylSig`, the user should read data with `bsseq::read.bismark()` and then apply functions that were once bundled within `methylSigReadData()`.

```
files = c(
    system.file('extdata', 'bis_cov1.cov', package='methylSig'),
    system.file('extdata', 'bis_cov2.cov', package='methylSig')
)

bsseq_stranded = bsseq::read.bismark(
    files = files,
    colData = data.frame(row.names = c('test1','test2')),
    rmZeroCov = FALSE,
    strandCollapse = FALSE
)
```

After reading data, filter by coverage. Note, we are changing our dataset to something we can use with the downstream functions.

```
# Load data for use in the rest of the vignette
data(BS.cancer.ex, package = 'bsseqData')
bs = BS.cancer.ex[1:10000]

bs = filter_loci_by_coverage(bs, min_count = 5, max_count = 500)
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
```

If the locations of C-to-T and G-to-A SNPs are known, or some other set of location should be removed:

```
# Construct GRanges object
remove_gr = GenomicRanges::GRanges(
    seqnames = c('chr21', 'chr21', 'chr21'),
    ranges = IRanges::IRanges(
        start = c(9411552, 9411784, 9412099),
        end = c(9411552, 9411784, 9412099)
    )
)

bs = filter_loci_by_location(bs = bs, gr = remove_gr)
```

# 3 Tiling Data

## 3.1 Old methylSig

In versions < 0.99.0 of `methylSig`, the `methylSigTile()` function combined aggregating CpG data over pre-defined tiles and genomic windows.

```
# For genomic windows, tiles = NULL
windowed_meth = methylSigTile(meth, tiles = NULL, win.size = 10000)

# For pre-defined tiles, tiles should be a GRanges object.
```

## 3.2 New methylSig

In versions >= 0.99.0 of `methylSig`, tiling is separated into two functions, `tile_by_regions()` and `tile_by_windows()`. Users should chooose one or the other.

```
windowed_bs = tile_by_windows(bs = bs, win_size = 10000)
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
```

```
# Collapsed promoters on chr21 and chr22
data(promoters_gr, package = 'methylSig')

promoters_bs = tile_by_regions(bs = bs, gr = promoters_gr)
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
```

# 4 Testing

## 4.1 MethylSig Test

### 4.1.1 Old methylSig

In versions < 0.99.0 of `methylSig`, the `methylSigCalc` function had a `min.per.group` parameter to determine how many samples per group had to have coverage in order to be tested.

```
result = methylSigCalc(
    meth = meth,
    comparison = 'DR_vs_DS',
    dispersion = 'both',
    local.info = FALSE,
    local.winsize = 200,
    min.per.group = c(3,3),
    weightFunc = methylSig_weightFunc,
    T.approx = TRUE,
    num.cores = 1)
```

### 4.1.2 New methylSig

In versions >= 0.99.0 of `methylSig`, the `min.per.group` functionality is performed by a separate function `filter_loci_by_group_coverage()`. Also note the change in form to define dispersion calculations, and the use of local information.

```
# Look a the phenotype data for bs
bsseq::pData(bs)
#> DataFrame with 6 rows and 2 columns
#>           Type        Pair
#>    <character> <character>
#> C1      cancer       pair1
#> C2      cancer       pair2
#> C3      cancer       pair3
#> N1      normal       pair1
#> N2      normal       pair2
#> N3      normal       pair3

# Require at least two samples from cancer and two samples from normal
bs = filter_loci_by_group_coverage(
    bs = bs,
    group_column = 'Type',
    c('cancer' = 2, 'normal' = 2))
```

After removing loci with insufficient information, we can now use the `diff_methylsig()` test.

```
# Test cancer versus normal with dispersion from both groups
diff_gr = diff_methylsig(
    bs = bs,
    group_column = 'Type',
    comparison_groups = c('case' = 'cancer', 'control' = 'normal'),
    disp_groups = c('case' = TRUE, 'control' = TRUE),
    local_window_size = 0,
    t_approx = TRUE,
    n_cores = 1)
```

## 4.2 DSS Test

### 4.2.1 Old methylSig

In versions < 0.99.0 of `methylSig`, the `methylSigDSS` function also had a `min.per.group` parameter to determine how many samples per group had to have coverage. Users also couldn’t specify which methylation groups to recover. The form of `design`, `formula`, and `contrast`, remain the same in versions >= 0.99.0.

```
contrast = matrix(c(0,1), ncol = 1)
result_dss = methylSigDSS(
    meth = meth,
    design = design1,
    formula = '~ group',
    contrast = contrast,
    group.term = 'group',
    min.per.group=c(3,3))
```

### 4.2.2 New methylSig

In versions >= 0.99.0 of `methylSig`, the single `methylSigDSS()` function is replaced by a fit function `diff_dss_fit()` and a test functiotn `diff_dss_test()`. As with `diff_methylsig()`, users should ensure enough samples have sufficient coverage with the `filter_loci_by_group_coverage()` function. The `design` and `formula` are unchanged in their forms.

If a continuous covariate is to be tested, `filter_loci_by_group_coverage()` should be skipped, as there are no groups. In prior versions of `methylSigDSS()`, this was not possible, and the group constraints were incorrectly applied prior to testing on a continuous covariate.

```
# IF NOT DONE PREVIOUSLY
# Require at least two samples from cancer and two samples from normal
bs = filter_loci_by_group_coverage(
    bs = bs,
    group_column = 'Type',
    c('cancer' = 2, 'normal' = 2))
```

```
# Test the simplest model with an intercept and Type
diff_fit_simple = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = as.formula('~ Type'))
#> Fitting DML model for CpG site:
```

The `contrast` parameter is also changed in its form. Note the, additional parameters to specify how to recover group methylation. `methylation_group_column` and `methylation_groups` should be specified for group versus group comparisons. For continuous covariates, `methylation_group_column` is sufficient, and the samples will be grouped into top/bottom 25 percentile based on the continuous covariate column name given in `methylation_group_column`.

```
# Test the simplest model for cancer vs normal
# Note, 2 rows corresponds to 2 columns in diff_fit_simple$X
simple_contrast = matrix(c(0,1), ncol = 1)

diff_simple_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_simple,
    contrast = simple_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))
```

# 5 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] methylSig_1.22.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
#>  [3] xfun_0.53                   bslib_0.9.0
#>  [5] rhdf5_2.54.0                Biobase_2.70.0
#>  [7] lattice_0.22-7              bitops_1.0-9
#>  [9] rhdf5filters_1.22.0         tools_4.5.1
#> [11] generics_0.1.4              curl_7.0.0
#> [13] stats4_4.5.1                parallel_4.5.1
#> [15] R.oo_1.27.1                 Matrix_1.7-4
#> [17] BSgenome_1.78.0             data.table_1.17.8
#> [19] RColorBrewer_1.1-3          cigarillo_1.0.0
#> [21] S4Vectors_0.48.0            sparseMatrixStats_1.22.0
#> [23] lifecycle_1.0.4             compiler_4.5.1
#> [25] farver_2.1.2                Rsamtools_2.26.0
#> [27] Biostrings_2.78.0           statmod_1.5.1
#> [29] Seqinfo_1.0.0               codetools_0.2-20
#> [31] permute_0.9-8               htmltools_0.5.8.1
#> [33] sass_0.4.10                 RCurl_1.98-1.17
#> [35] yaml_2.3.10                 crayon_1.5.3
#> [37] jquerylib_0.1.4             R.utils_2.13.0
#> [39] BiocParallel_1.44.0         DelayedArray_0.36.0
#> [41] cachem_1.1.0                limma_3.66.0
#> [43] abind_1.4-8                 gtools_3.9.5
#> [45] locfit_1.5-9.12             digest_0.6.37
#> [47] restfulr_0.0.16             bookdown_0.45
#> [49] splines_4.5.1               fastmap_1.2.0
#> [51] grid_4.5.1                  cli_3.6.5
#> [53] SparseArray_1.10.0          DSS_2.58.0
#> [55] S4Arrays_1.10.0             XML_3.99-0.19
#> [57] dichromat_2.0-0.1           h5mread_1.2.0
#> [59] DelayedMatrixStats_1.32.0   scales_1.4.0
#> [61] httr_1.4.7                  rmarkdown_2.30
#> [63] XVector_0.50.0              matrixStats_1.5.0
#> [65] R.methodsS3_1.8.2           beachmat_2.26.0
#> [67] HDF5Array_1.38.0            evaluate_1.0.5
#> [69] knitr_1.50                  BiocIO_1.20.0
#> [71] GenomicRanges_1.62.0        IRanges_2.44.0
#> [73] rtracklayer_1.70.0          rlang_1.1.6
#> [75] Rcpp_1.1.0                  glue_1.8.0
#> [77] BiocManager_1.30.26         BiocGenerics_0.56.0
#> [79] bsseq_1.46.0                jsonlite_2.0.0
#> [81] R6_2.6.1                    Rhdf5lib_1.32.0
#> [83] GenomicAlignments_1.46.0    MatrixGenerics_1.22.0
```