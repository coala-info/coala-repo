# Using methylSig

Yongseok Park, Raymond G. Cavalcante, Maria E. Figueroa, Laura S. Rozek, and Maureen A. Sartor

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Usage](#usage)
  + [3.1 Reading Data](#reading-data)
  + [3.2 Filtering Data](#filtering-data)
    - [3.2.1 By Coverage](#by-coverage)
    - [3.2.2 By Location](#by-location)
  + [3.3 Aggregating Data](#aggregating-data)
    - [3.3.1 By Tiling the Genome](#by-tiling-the-genome)
    - [3.3.2 By Pre-defined Regions](#by-pre-defined-regions)
  + [3.4 Testing for Differential Methylation](#testing-for-differential-methylation)
    - [3.4.1 Filtering by Coverage in a Minimum Number of Samples](#filtering-by-coverage-in-a-minimum-number-of-samples)
    - [3.4.2 Binomial Test](#binomial-test)
    - [3.4.3 MethylSig Test](#methylsig-test)
    - [3.4.4 General Models with DSS](#general-models-with-dss)
* [4 Session Info](#session-info)

```
library(methylSig)
```

# 1 Introduction

DNA methylation plays critical roles in gene regulation and cellular specification without altering DNA sequences. It is one of the best understood and most intensively studied epigenetic marks in mammalian cells. Treatment of DNA with sodium bisulfite deaminates unmethylated cytosines to uracil while methylated cytosines are resistant to this conversion thus allowing for the discrimination between methylated and unmethylated CpG sites. Sodium bisulfite pre-treatment of DNA coupled with next-generation sequencing has allowed DNA methylation to be studied quantitatively and genome-wide at single cytosine site resolution.

`methylSig` is a method for testing for differential methylated cytosines (DMCs) or regions (DMRs) in whole-genome bisulfite sequencing (WGBS) or reduced representation bisulfite sequencing (RRBS) experiments. `methylSig` uses a beta-binomial model to test for significant differences between groups of samples. Several options exist for either site-specific or sliding window tests, combining strands, and for variance estimation.

# 2 Installation

`methylSig` is available on GitHub at <http://www.github.com/sartorlab/methylSig>, and the easiest way to install it is as follows:

```
devtools::install_github('sartorlab/methylSig')
```

# 3 Usage

The basic flow of analysis with `methylSig` is to:

* Read data
* Optionally filter data by coverage and/or location
* Optionally aggregate data into regions
* Optionally filter data by coverage in a minimum number of samples per group
* Test for differential methylation

The sections below walk through each step with small test data.

## 3.1 Reading Data

Methylation calls output by either [MethylDackel](https://github.com/dpryan79/MethylDackel#single-cytosine-methylation-metrics-extraction) or [Bismark](https://github.com/FelixKrueger/Bismark/tree/master/Docs#the-coverage-output-looks-like-this-tab-delimited-1-based-genomic-coords) can be read by the `bsseq::read.bismark()` function from the [`bsseq`](https://www.bioconductor.org/packages/release/bioc/html/bsseq.html) R/Bioconductor package.

This function accepts `bedGraph`s from [MethylDackel](https://github.com/dpryan79/MethylDackel#single-cytosine-methylation-metrics-extraction) and either the coverage or genome-wide cytosine reports from [Bismark](https://github.com/FelixKrueger/Bismark/tree/master/Docs#the-coverage-output-looks-like-this-tab-delimited-1-based-genomic-coords). Options to consider when reading data are:

* `colData`, a `data.frame` or `DataFrame` whose rows are samples and columns are phenotype data. The row ordering should match the ordering of files in `files`. This matrix will be needed for downstream differential methylation testing.
* `strandCollapse`, a `logical` (`TRUE`/`FALSE`) indicating whether or not to collapse +/- CpG data onto the + strand. Note, this can only be `TRUE` when the input type is the genome-wide cytosine report from Bismark. MethylDackel has an option to destrand data when methylation calls are made so that the output is already destranded. In this case, `strandCollapse` should be `FALSE`.

For all options, see the `bsseq` [reference manual](https://www.bioconductor.org/packages/release/bioc/manuals/bsseq/man/bsseq.pdf), and the [section on reading data](https://www.bioconductor.org/packages/release/bioc/vignettes/bsseq/inst/doc/bsseq.html#4_reading_data) in the package vignette.

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

The result is a `BSseq` object. Aspects of the object can be accessed via:

```
# pData
bsseq::pData(bsseq_stranded)
#> DataFrame with 2 rows and 0 columns

# GRanges
GenomicRanges::granges(bsseq_stranded)
#> GRanges object with 11 ranges and 0 metadata columns:
#>        seqnames    ranges strand
#>           <Rle> <IRanges>  <Rle>
#>    [1]     chr1        10      *
#>    [2]     chr1        11      *
#>    [3]     chr1        25      *
#>    [4]     chr1        26      *
#>    [5]     chr1        40      *
#>    [6]     chr1        41      *
#>    [7]     chr1        50      *
#>    [8]     chr1        51      *
#>    [9]     chr1        60      *
#>   [10]     chr1        75      *
#>   [11]     chr1        76      *
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths

# Coverage matrix
bsseq::getCoverage(bsseq_stranded, type = 'Cov')
#>       test1 test2
#>  [1,]     5    10
#>  [2,]     5    10
#>  [3,]    30    50
#>  [4,]    70    50
#>  [5,]    10    15
#>  [6,]    20    35
#>  [7,]     0     5
#>  [8,]     0     5
#>  [9,]    40    20
#> [10,]  1000   100
#> [11,]  1500   200

# Methylation matrix
bsseq::getCoverage(bsseq_stranded, type = 'M')
#>       test1 test2
#>  [1,]     4     9
#>  [2,]     4     9
#>  [3,]     0     1
#>  [4,]     5     5
#>  [5,]     9    14
#>  [6,]    19    34
#>  [7,]     0     5
#>  [8,]     0     5
#>  [9,]    35    15
#> [10,]   900    99
#> [11,]  1400   199
```

## 3.2 Filtering Data

After data is loaded, it is good practice to filter loci that have too few or too many reads, and C-to-T and G-to-A SNPs which confound bisulfite conversion.

### 3.2.1 By Coverage

Low coverage loci (typically those with fewer than 5 reads) should be marked because they adversely affect the variance calculation in downstream differential methylation tests. Very high coverage loci (typically those with more than 500 reads) are likely the result of PCR duplication, and should also be marked.

`MethylSig` marks such sites by setting their coverage and methylation matrix entries to 0 for each sample in which this happens. Prior to testing, these sites can be removed, see below.

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

### 3.2.2 By Location

As noted above, locations with C-to-T and G-to-A SNPs confound bisulfite conversion in WGBS and ERRBS. Filtering them out can be accomplished by constructing a `GRanges` object with their location. For now, we leave locating such SNPs to the user.

```
# Show locations of bs
GenomicRanges::granges(bs)
#> GRanges object with 10000 ranges and 0 metadata columns:
#>           seqnames    ranges strand
#>              <Rle> <IRanges>  <Rle>
#>       [1]    chr21   9411552      *
#>       [2]    chr21   9411784      *
#>       [3]    chr21   9412099      *
#>       [4]    chr21   9412376      *
#>       [5]    chr21   9412503      *
#>       ...      ...       ...    ...
#>    [9996]    chr21  10831230      *
#>    [9997]    chr21  10831255      *
#>    [9998]    chr21  10831310      *
#>    [9999]    chr21  10831425      *
#>   [10000]    chr21  10831455      *
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths

# Construct GRanges object
remove_gr = GenomicRanges::GRanges(
    seqnames = c('chr21', 'chr21', 'chr21'),
    ranges = IRanges::IRanges(
        start = c(9411552, 9411784, 9412099),
        end = c(9411552, 9411784, 9412099)
    )
)

bs = filter_loci_by_location(bs = bs, gr = remove_gr)

# Show removal
GenomicRanges::granges(bs)
#> GRanges object with 9997 ranges and 0 metadata columns:
#>          seqnames    ranges strand
#>             <Rle> <IRanges>  <Rle>
#>      [1]    chr21   9412376      *
#>      [2]    chr21   9412503      *
#>      [3]    chr21   9412808      *
#>      [4]    chr21   9413583      *
#>      [5]    chr21   9413763      *
#>      ...      ...       ...    ...
#>   [9993]    chr21  10831230      *
#>   [9994]    chr21  10831255      *
#>   [9995]    chr21  10831310      *
#>   [9996]    chr21  10831425      *
#>   [9997]    chr21  10831455      *
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

## 3.3 Aggregating Data

One way to increase the power of differential methylation testing is to aggregate the CpG-level data into regions. Regions can take two forms: tiling the entire genome by windows of a certain width or defining a set of regions such as CpG islands or gene promoters.

### 3.3.1 By Tiling the Genome

Given that CpG methylation is strongly correlated over short genomic distances, a reasonable upper threshold might be 500bp. For the example below, in the interest of speed, we tile by larger windows.

```
windowed_bs = tile_by_windows(bs = bs, win_size = 10000)
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix

# Show tiling
GenomicRanges::granges(windowed_bs)
#> GRanges object with 1085 ranges and 0 metadata columns:
#>          seqnames            ranges strand
#>             <Rle>         <IRanges>  <Rle>
#>      [1]    chr21           1-10000      *
#>      [2]    chr21       10001-20000      *
#>      [3]    chr21       20001-30000      *
#>      [4]    chr21       30001-40000      *
#>      [5]    chr21       40001-50000      *
#>      ...      ...               ...    ...
#>   [1081]    chr21 10800001-10810000      *
#>   [1082]    chr21 10810001-10820000      *
#>   [1083]    chr21 10820001-10830000      *
#>   [1084]    chr21 10830001-10840000      *
#>   [1085]    chr21 10840001-10841455      *
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 3.3.2 By Pre-defined Regions

It may be the case that differential methylation is only relevant at promoter regions of genes for a particular project. In this case, aggregation of methylation calls over these regions may increase power, and decrease computation time.

```
# Collapsed promoters on chr21 and chr22
data(promoters_gr, package = 'methylSig')

promoters_bs = tile_by_regions(bs = bs, gr = promoters_gr)
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
#> Warning in value[[3L]](cond): expected no additional right arguments for
#> 'DelayedNaryIsoOp', falling back to an unknown matrix
```

## 3.4 Testing for Differential Methylation

`MethylSig` offers three tests for differential methylation:

1. `diff_binomial()`
2. `diff_methylsig()`
3. `diff_dss_fit()` and `diff_dss_test()`

Each returns a `GRanges` object with tested loci and the corresponding statistics and methylation levels (if applicable). See the documentation for each function for more information (`?diff_binomial`, `?diff_methylsig`, `?diff_dss_fit`, and `?diff_dss_test`).

### 3.4.1 Filtering by Coverage in a Minimum Number of Samples

Prior to applying any test function, loci without a minimum number of samples having appropriate coverage should be removed to avoid testing loci where one sample dominates the test.

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

### 3.4.2 Binomial Test

`diff_binomial()` is a binomial test based on that in the [`methylKit`](https://bioconductor.org/packages/release/bioc/html/methylKit.html) R/Bioconductor package. This was included for benchmarking purposes in the publication. It does not take into account the variability among samples being compared.

```
# Test cancer versus normal
diff_gr = diff_binomial(
    bs = bs,
    group_column = 'Type',
    comparison_groups = c('case' = 'cancer', 'control' = 'normal'))

diff_gr
#> GRanges object with 1358 ranges and 7 metadata columns:
#>          seqnames    ranges strand | meth_case meth_control meth_diff
#>             <Rle> <IRanges>  <Rle> | <numeric>    <numeric> <numeric>
#>      [1]    chr21   9413763      * |      0.00         6.45     -6.45
#>      [2]    chr21   9416731      * |     63.64       100.00    -36.36
#>      [3]    chr21   9417127      * |     22.22        47.06    -24.84
#>      [4]    chr21   9419355      * |     15.38        64.52    -49.14
#>      [5]    chr21   9420237      * |     14.29        26.32    -12.03
#>      ...      ...       ...    ... .       ...          ...       ...
#>   [1354]    chr21  10831159      * |     50.00        50.00      0.00
#>   [1355]    chr21  10831205      * |     31.03        37.93     -6.90
#>   [1356]    chr21  10831230      * |     56.52        76.00    -19.48
#>   [1357]    chr21  10831425      * |     86.14        90.66     -4.52
#>   [1358]    chr21  10831455      * |     78.55        84.46     -5.91
#>            direction      pvalue         fdr log_lik_ratio
#>          <character>   <numeric>   <numeric>     <numeric>
#>      [1]      normal 1.37950e-01 0.280229141      2.200680
#>      [2]      normal 1.11483e-02 0.050296774      6.441531
#>      [3]      normal 1.19314e-01 0.253169711      2.426301
#>      [4]      normal 1.65661e-05 0.000523179     18.548211
#>      [5]      normal 3.95560e-01 0.559564440      0.721783
#>      ...         ...         ...         ...           ...
#>   [1354]      cancer   1.0000000   1.0000000      0.000000
#>   [1355]      normal   0.5803640   0.7317868      0.305646
#>   [1356]      normal   0.1513080   0.2943785      2.059015
#>   [1357]      normal   0.0170048   0.0659787      5.695877
#>   [1358]      normal   0.0806182   0.1961998      3.052395
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

### 3.4.3 MethylSig Test

The `diff_methylsig()` is a beta-binomial test which takes into account the variability among samples being compared. It can perform group versus group comparisons with no covariates.

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

diff_gr
#> GRanges object with 1358 ranges and 9 metadata columns:
#>          seqnames    ranges strand | meth_case meth_control meth_diff
#>             <Rle> <IRanges>  <Rle> | <numeric>    <numeric> <numeric>
#>      [1]    chr21   9413763      * |    0.0000      6.49751  -6.49751
#>      [2]    chr21   9416731      * |   63.4272    100.00000 -36.57276
#>      [3]    chr21   9417127      * |   22.2200     47.05888 -24.83887
#>      [4]    chr21   9419355      * |   15.3828     64.51513 -49.13232
#>      [5]    chr21   9420237      * |   14.2857     26.31581 -12.03013
#>      ...      ...       ...    ... .       ...          ...       ...
#>   [1354]    chr21  10831159      * |   43.5065      52.9219  -9.41540
#>   [1355]    chr21  10831205      * |   31.0346      37.9314  -6.89683
#>   [1356]    chr21  10831230      * |   54.8027      78.3147 -23.51194
#>   [1357]    chr21  10831425      * |   86.3300      90.5347  -4.20472
#>   [1358]    chr21  10831455      * |   78.5454      84.4641  -5.91865
#>            direction     pvalue       fdr    disp_est log_lik_ratio        df
#>          <character>  <numeric> <numeric>   <numeric>     <numeric> <numeric>
#>      [1]      normal 0.26498356  0.526114 8.12977e+00      1.511133         6
#>      [2]      normal 0.06962183  0.342560 4.58693e+01      6.056174         4
#>      [3]      normal 0.19431108  0.468936 1.00000e+06      2.426293         4
#>      [4]      normal 0.00505542  0.269846 1.00000e+06     18.547969         6
#>      [5]      normal 0.43434258  0.667774 1.00000e+06      0.721783         5
#>      ...         ...        ...       ...         ...           ...       ...
#>   [1354]      normal  0.7252207  0.875422 4.12922e+00      0.138296         5
#>   [1355]      normal  0.6003419  0.800849 1.00000e+06      0.305642         6
#>   [1356]      normal  0.2250738  0.489277 9.82992e+00      1.828248         6
#>   [1357]      normal  0.0909511  0.374278 9.82979e+02      4.046584         6
#>   [1358]      normal  0.1312360  0.414624 1.00000e+06      3.051969         6
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

### 3.4.4 General Models with DSS

`diff_dss_fit()` and `diff_dss_test()` are tests supporting general models, and are wrappers for functions in the [`DSS`](https://bioconductor.org/packages/release/bioc/html/DSS.html) R/Bioconductor package. We have added the ability to recover group methylation for group comparisons, or top/bottom 25 percentile methylation rates based on a continuous covariate.

The `DSS` style test is in two stages similar to tests in the `edgeR` or `limma` R/Bioconductor packages. The first stage is a fit, and the second stage is a test on a contrast.

First we add a numerical covariate to the `pData(bs)` so that we can give an example of such a test.

```
bsseq::pData(bs)$num_covariate = c(84, 96, 93, 10, 18, 9)
```

#### 3.4.4.1 Model Fitting

Fit the simplest group versus group model on just the type.

```
diff_fit_simple = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = as.formula('~ Type'))
#> Fitting DML model for CpG site:
```

Fit a paired model where cancer and normal samples are paired by patient.

```
# Paired-test
diff_fit_paired = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = '~ Type + Pair')
#> Fitting DML model for CpG site:
```

Fit a model on the numerical covariate.

```
# Numerical covariate test
diff_fit_num = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = '~ num_covariate')
#> Fitting DML model for CpG site:
```

The result of `diff_dss_fit()` is a `list` with the following structure with elements:

* `gr`, the `GRanges` of the fit loci.
* `design`, the phenotype matrix passed via the `design` parameter.
* `formula`, the formula used in conjunction with `design` to create the model matrix.
* `X`, the result of `model.matrix` with `design` and `formula`.
* `fit`, the `beta` and `var.beta` matrices.

#### 3.4.4.2 Building Contrasts

Prior to calling `diff_fit_test()`, it may help to look at the model matrix used for fitting in order to build the contrast.

```
diff_fit_simple$X
#>    (Intercept) Typenormal
#> C1           1          0
#> C2           1          0
#> C3           1          0
#> N1           1          1
#> N2           1          1
#> N3           1          1
#> attr(,"assign")
#> [1] 0 1
#> attr(,"contrasts")
#> attr(,"contrasts")$Type
#> [1] "contr.treatment"

diff_fit_paired$X
#>    (Intercept) Typenormal Pairpair2 Pairpair3
#> C1           1          0         0         0
#> C2           1          0         1         0
#> C3           1          0         0         1
#> N1           1          1         0         0
#> N2           1          1         1         0
#> N3           1          1         0         1
#> attr(,"assign")
#> [1] 0 1 2 2
#> attr(,"contrasts")
#> attr(,"contrasts")$Type
#> [1] "contr.treatment"
#>
#> attr(,"contrasts")$Pair
#> [1] "contr.treatment"

diff_fit_num$X
#>    (Intercept) num_covariate
#> C1           1            84
#> C2           1            96
#> C3           1            93
#> N1           1            10
#> N2           1            18
#> N3           1             9
#> attr(,"assign")
#> [1] 0 1
```

The contrast passed to `diff_fit_test()` should be a column vector or a matrix whose rows correspond to the columns of the model matrix above. See the [DSS user guide](http://bioconductor.org/packages/release/bioc/vignettes/DSS/inst/doc/DSS.html#34_dmldmr_detection_from_general_experimental_design) for more information.

```
# Test the simplest model for cancer vs normal
# Note, 2 rows corresponds to 2 columns in diff_fit_simple$X
simple_contrast = matrix(c(0,1), ncol = 1)

# Test the paired model for cancer vs normal
# Note, 4 rows corresponds to 4 columns in diff_fit_paired$X
paired_contrast = matrix(c(0,1,0,0), ncol = 1)

# Test the numerical covariate
num_contrast = matrix(c(0,1), ncol = 1)
```

#### 3.4.4.3 Testing

The `diff_fit_test()` function enables the recovery of group methylation rates via the optional `methylation_group_column` and `methylation_groups` parameters.

The simple, group versus group, test.

```
diff_simple_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_simple,
    contrast = simple_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))

diff_simple_gr
#> GRanges object with 1358 ranges and 7 metadata columns:
#>          seqnames    ranges strand | meth_case meth_control meth_diff
#>             <Rle> <IRanges>  <Rle> | <numeric>    <numeric> <numeric>
#>      [1]    chr21   9413763      * |      0.00         6.45     -6.45
#>      [2]    chr21   9416731      * |     63.64       100.00    -36.36
#>      [3]    chr21   9417127      * |     22.22        47.06    -24.84
#>      [4]    chr21   9419355      * |     15.38        64.52    -49.13
#>      [5]    chr21   9420237      * |     14.29        26.32    -12.03
#>      ...      ...       ...    ... .       ...          ...       ...
#>   [1354]    chr21  10831159      * |     50.00        50.00      0.00
#>   [1355]    chr21  10831205      * |     31.03        37.93     -6.90
#>   [1356]    chr21  10831230      * |     56.52        76.00    -19.48
#>   [1357]    chr21  10831425      * |     86.14        90.66     -4.53
#>   [1358]    chr21  10831455      * |     78.55        84.46     -5.92
#>            direction      stat      pvalue       fdr
#>          <character> <numeric>   <numeric> <numeric>
#>      [1]      normal  0.729474 4.65711e-01 0.7261035
#>      [2]      normal  2.365831 1.79896e-02 0.1285786
#>      [3]      normal  1.687860 9.14381e-02 0.3151597
#>      [4]      normal  4.396071 1.10228e-05 0.0011392
#>      [5]      normal  1.138130 2.55066e-01 0.5200900
#>      ...         ...       ...         ...       ...
#>   [1354]      cancer  0.453781   0.6499867  0.848938
#>   [1355]      normal  0.587070   0.5571567  0.784061
#>   [1356]      normal  1.198860   0.2305825  0.498198
#>   [1357]      normal  0.944001   0.3451693  0.607963
#>   [1358]      normal  1.698473   0.0894185  0.312965
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

The paired test.

```
diff_paired_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_paired,
    contrast = paired_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))
#> 93 loci were dropped due to insufficient degrees of freedom.

diff_paired_gr
#> GRanges object with 1265 ranges and 7 metadata columns:
#>          seqnames    ranges strand | meth_case meth_control meth_diff
#>             <Rle> <IRanges>  <Rle> | <numeric>    <numeric> <numeric>
#>      [1]    chr21   9413763      * |      0.00         6.45     -6.45
#>      [2]    chr21   9419355      * |     15.38        64.52    -49.13
#>      [3]    chr21   9420237      * |     14.29        26.32    -12.03
#>      [4]    chr21   9420952      * |     57.14        65.52     -8.37
#>      [5]    chr21   9580059      * |     71.43        84.09    -12.66
#>      ...      ...       ...    ... .       ...          ...       ...
#>   [1261]    chr21  10831159      * |     50.00        50.00      0.00
#>   [1262]    chr21  10831205      * |     31.03        37.93     -6.90
#>   [1263]    chr21  10831230      * |     56.52        76.00    -19.48
#>   [1264]    chr21  10831425      * |     86.14        90.66     -4.53
#>   [1265]    chr21  10831455      * |     78.55        84.46     -5.92
#>            direction      stat      pvalue        fdr
#>          <character> <numeric>   <numeric>  <numeric>
#>      [1]      normal  0.724620 4.68685e-01 0.70439772
#>      [2]      normal  4.032480 5.51913e-05 0.00188695
#>      [3]      normal  0.697177 4.85692e-01 0.72174449
#>      [4]      normal  0.355852 7.21952e-01 0.87938305
#>      [5]      normal  1.247730 2.12130e-01 0.46426373
#>      ...         ...       ...         ...        ...
#>   [1261]      cancer  0.657701    0.510730   0.740911
#>   [1262]      normal  0.426110    0.670028   0.846738
#>   [1263]      normal  1.229273    0.218970   0.472342
#>   [1264]      normal  0.637471    0.523818   0.748735
#>   [1265]      normal  1.420936    0.155335   0.392214
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

The numerical covariate test. Note, here the `methylation_groups` parameter is omitted because there are no groups. By giving the numerical covariate column, we will group samples by the top/bottom 25 percentile over the covariate, and compute mean methylation within those groups of samples.

```
diff_num_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_num,
    contrast = num_contrast,
    methylation_group_column = 'num_covariate')

diff_num_gr
#> GRanges object with 1358 ranges and 7 metadata columns:
#>          seqnames    ranges strand | meth_case meth_control meth_diff
#>             <Rle> <IRanges>  <Rle> | <numeric>    <numeric> <numeric>
#>      [1]    chr21   9413763      * |     11.11         0.00     11.11
#>      [2]    chr21   9416731      * |    100.00        63.64     36.36
#>      [3]    chr21   9417127      * |     50.00        22.22     27.78
#>      [4]    chr21   9419355      * |     63.64        10.34     53.29
#>      [5]    chr21   9420237      * |     27.27        14.29     12.99
#>      ...      ...       ...    ... .       ...          ...       ...
#>   [1354]    chr21  10831159      * |     83.33        40.00     43.33
#>   [1355]    chr21  10831205      * |     33.33        22.22     11.11
#>   [1356]    chr21  10831230      * |     93.75        46.15     47.60
#>   [1357]    chr21  10831425      * |     89.02        84.39      4.63
#>   [1358]    chr21  10831455      * |     81.65        78.38      3.27
#>            direction      stat      pvalue         fdr
#>          <character> <numeric>   <numeric>   <numeric>
#>      [1]       Hyper  -0.84328 3.99072e-01 0.650587695
#>      [2]       Hyper  -2.32367 2.01430e-02 0.128928038
#>      [3]       Hyper  -1.79346 7.28996e-02 0.274231889
#>      [4]       Hyper  -4.47274 7.72224e-06 0.000813826
#>      [5]       Hyper  -1.09861 2.71939e-01 0.525272220
#>      ...         ...       ...         ...         ...
#>   [1354]       Hyper -0.597314    0.550298    0.773607
#>   [1355]       Hyper -0.636270    0.524601    0.755469
#>   [1356]       Hyper -1.449572    0.147178    0.380700
#>   [1357]       Hyper -1.097767    0.272306    0.525272
#>   [1358]       Hyper -1.563098    0.118030    0.334685
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

# 4 Session Info

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