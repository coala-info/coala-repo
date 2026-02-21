# Matching case study II: CTCF orientation

#### Eric S. Davis

#### 12/15/2025

In this vignette, we demonstrate the generation of covariate-matched null ranges by using the `matchRanges()` function to test the “covergence rule” of CTCF-bound chromatin loops, first described in Rao et al. 2014.

## Background

In the human genome, chromatin loops play an important role in regulating gene expression by connecting regulatory loci to gene promoters. The anchors of these loops are bound by the protein CTCF, which is required for loop formation and maintenance. CTCF binds a specific non-palindromic DNA sequence motif. And the direction of this motif at loop anchors is non-random. That is, CTCF binding motifs found at the anchors of loops tend to be oriented towards the center of the loop more often then would be expected by chance. This phenomenon, first described by Rao et al in 2014, is known as the “convergence rule”. It was initially discovered by first filtering for loops that had a single CTCF binding site at each end of the loop. Here we use matchRanges to reinvestigate the convergence using all loops.

We will use `hg19_10kb_ctcfBoundBinPairs` data from the `nullrangesData` package which contains features from the GM12878 cell line aligned to hg19 as well as CTCF motif data from the [CTCF data package](https://bioconductor.org/packages/devel/data/annotation/html/CTCF.html) available on Bioconductor. `hg19_10kb_ctcfBoundBinPairs` is a [`GInteractions`](https://bioconductor.org/packages/release/bioc/html/InteractionSet.html) object with all pairwise combinations of CTCF-bound 10Kb bins within 1Mb annotated with the following features:

* The total CTCF signal in each bin.
* The number of CTCF sites in each bin.
* The distance between bin pairs.
* Whether at least one CTCF site is convergent between each bin pair.
* The presence or absence of a loop between each bin pair.

Using these annotations and the `matchRanges()` function, we can compare CTCF motif orientations between pairs of genomic regions that are 1) connected by loops, 2) not connected by loops, 3) randomly chosen, or 4) not connected by loops, but matched for the strength of CTCF sites and distance between loop anchors.

## Matching with `matchRanges()`

Before we generate our null ranges, let’s take a look at our example dataset:

```
library(nullrangesData)
## Load example data
binPairs <- hg19_10kb_ctcfBoundBinPairs()
binPairs
```

```
## StrictGInteractions object with 198120 interactions and 5 metadata columns:
##            seqnames1             ranges1     seqnames2             ranges2 |
##                <Rle>           <IRanges>         <Rle>           <IRanges> |
##        [1]      chr1       230001-240000 ---      chr1       520001-530000 |
##        [2]      chr1       230001-240000 ---      chr1       710001-720000 |
##        [3]      chr1       230001-240000 ---      chr1       800001-810000 |
##        [4]      chr1       230001-240000 ---      chr1       840001-850000 |
##        [5]      chr1       230001-240000 ---      chr1       870001-880000 |
##        ...       ...                 ... ...       ...                 ... .
##   [198116]      chrX 154310001-154320000 ---      chrX 154370001-154380000 |
##   [198117]      chrX 154310001-154320000 ---      chrX 155250001-155260000 |
##   [198118]      chrX 154320001-154330000 ---      chrX 154370001-154380000 |
##   [198119]      chrX 154320001-154330000 ---      chrX 155250001-155260000 |
##   [198120]      chrX 154370001-154380000 ---      chrX 155250001-155260000 |
##               looped ctcfSignal  n_sites  distance convergent
##            <logical>  <numeric> <factor> <integer>  <logical>
##        [1]     FALSE    5.18038        2    290000      FALSE
##        [2]     FALSE    5.46775        2    480000       TRUE
##        [3]     FALSE    7.30942        2    570000      FALSE
##        [4]     FALSE    7.34338        2    610000      FALSE
##        [5]     FALSE    6.31338        3    640000       TRUE
##        ...       ...        ...      ...       ...        ...
##   [198116]     FALSE    6.79246        2     60000      FALSE
##   [198117]     FALSE    6.12447        3    940000       TRUE
##   [198118]     FALSE    7.40868        2     50000       TRUE
##   [198119]     FALSE    7.00936        3    930000      FALSE
##   [198120]     FALSE    6.73402        3    880000       TRUE
##   -------
##   regions: 20612 ranges and 5 metadata columns
##   seqinfo: 23 sequences from hg19 genome
```

Let’s start by defining our focal set (i.e. looped bin-pairs), our pool set (i.e un-looped bin-pairs), and our covariates of interest (i.e. `ctcfSignal` and `distance`):

```
library(nullranges)
set.seed(123)
mgi <- matchRanges(focal = binPairs[binPairs$looped],
                   pool = binPairs[!binPairs$looped],
                   covar = ~ctcfSignal + distance + n_sites,
                   method = 'stratified')
mgi
```

```
## MatchedGInteractions object with 3104 interactions and 5 metadata columns:
##          seqnames1           ranges1     seqnames2           ranges2 |
##              <Rle>         <IRanges>         <Rle>         <IRanges> |
##      [1]     chr11 62160001-62170000 ---     chr11 62190001-62200000 |
##      [2]     chr17   7890001-7900000 ---     chr17   7990001-8000000 |
##      [3]     chr22 36460001-36470000 ---     chr22 36680001-36690000 |
##      [4]     chr11   1560001-1570000 ---     chr11   1710001-1720000 |
##      [5]     chr19 17880001-17890000 ---     chr19 17960001-17970000 |
##      ...       ...               ... ...       ...               ... .
##   [3100]      chr7 25100001-25110000 ---      chr7 25220001-25230000 |
##   [3101]     chr19 14310001-14320000 ---     chr19 14540001-14550000 |
##   [3102]     chr11   6010001-6020000 ---     chr11   6300001-6310000 |
##   [3103]      chr6 37450001-37460000 ---      chr6 37620001-37630000 |
##   [3104]     chr11   1840001-1850000 ---     chr11   2170001-2180000 |
##             looped ctcfSignal  n_sites  distance convergent
##          <logical>  <numeric> <factor> <integer>  <logical>
##      [1]     FALSE    8.12860        2     30000      FALSE
##      [2]     FALSE    8.72976        3    100000       TRUE
##      [3]     FALSE    9.51410        4    220000       TRUE
##      [4]     FALSE    8.64759        3    150000      FALSE
##      [5]     FALSE    8.52097        2     80000      FALSE
##      ...       ...        ...      ...       ...        ...
##   [3100]     FALSE    7.87730        2    120000      FALSE
##   [3101]     FALSE    8.13800        2    230000      FALSE
##   [3102]     FALSE    7.05064        2    290000      FALSE
##   [3103]     FALSE    8.72932        4    170000       TRUE
##   [3104]     FALSE    8.39022        3    330000       TRUE
##   -------
##   regions: 20612 ranges and 5 metadata columns
##   seqinfo: 23 sequences from hg19 genome
```

When the focal and pool arguments are `GInteractions` objects, `matchRanges()` returns a `MatchedGInteractions` object. The `MatchedGInteractions` class extends `GInteractions` so all of the same operations can be applied:

```
library(plyranges)
library(ggplot2)
## Summarize ctcfSignal by n_sites
mgi %>%
  regions() %>%
  group_by(n_sites) %>%
  summarize(ctcfSignal = mean(ctcfSignal)) %>%
  as.data.frame() %>%
  ggplot(aes(x = n_sites, y = ctcfSignal)) +
    geom_line() +
    geom_point(shape = 21, stroke = 1,  fill = 'white') +
    theme_minimal() +
    theme(panel.border = element_rect(color = 'black',
                                      fill = NA))
```

![](data:image/png;base64...)

## Assessing quality of matching

We can get a quick summary of the matching quality with `overview()`:

```
ov <- overview(mgi)
ov
```

```
## MatchedGInteractions object:
##        set      N ctcfSignal.mean ctcfSignal.sd distance.mean distance.sd
##     <char>  <num>           <num>         <num>         <num>       <num>
##      focal   3104             8.3          0.67        320000      230000
##    matched   3104             8.3          0.69        320000      250000
##       pool 195016             7.9          0.85        490000      290000
##  unmatched 191928             7.8          0.85        490000      290000
##  n_sites.0 n_sites.1 n_sites.2 n_sites.3 n_sites.4 n_sites.5 n_sites.6
##      <num>     <num>     <num>     <num>     <num>     <num>     <num>
##          0         0      2167       734       164        32         4
##          0         0      2212       702       150        34         4
##          0         0    152318     34992      5971       944       158
##          0         0    150122     34290      5821       910       154
##  n_sites.7+ ps.mean ps.sd
##       <num>   <num> <num>
##           3   0.026 0.016
##           2   0.026 0.016
##         633   0.016 0.013
##         631   0.015 0.013
## --------
## focal - matched:
##  ctcfSignal.mean ctcfSignal.sd distance.mean distance.sd n_sites.0 n_sites.1
##            <num>         <num>         <num>       <num>     <num>     <num>
##           0.0014        -0.029         -1300      -27000         0         0
##  n_sites.2 n_sites.3 n_sites.4 n_sites.5 n_sites.6 n_sites.7+  ps.mean    ps.sd
##      <num>     <num>     <num>     <num>     <num>      <num>    <num>    <num>
##        -45        32        14        -2         0          1 -7.2e-08 -4.4e-07
```

In addition to providing a printed overview, the overview data can be extracted for convenience. For example, the `quality` property shows the absolute value of the mean difference between focal and matched sets. Therefore, the lower this value, the better the matching quality:

```
ov$quality
```

```
## [1] 7.2e-08
```

### Visualizing matching results

Let’s visualize overall matching quality by plotting propensity scores for the focal, pool, and matched sets:

```
plotPropensity(mgi, sets = c('f', 'p', 'm'))
```

![](data:image/png;base64...)

Log transformations can be applied to ‘x’, ‘y’, or both (`c('x', 'y')`) for plotting functions to make it easier to assess quality. It is clear that the matched set is very well matched to the focal set:

```
plotPropensity(mgi, sets = c('f', 'p', 'm'), log = 'x')
```

![](data:image/png;base64...)

We can ensure that covariate distributions have been matched appropriately by using the `covariates()` function to extract matched covariates along with `patchwork` and `plotCovarite` to visualize all distributions:

```
library(patchwork)
plots <- lapply(covariates(mgi), plotCovariate, x=mgi, sets = c('f', 'm', 'p'))
Reduce('/', plots)
```

![](data:image/png;base64...)

## Compare CTCF site orientation

Using our matched ranges, we can compare the percent of looped pairs with at least one convergent CTCF site against unlooped pairs, randomly selected pairs, and pairs that are unlooped but have been matched for our covariates. The accessor function `focal()` and `pool()` can be used to conveniently extract these matched sets:

```
## Generate a randomly selected set from all binPairs
all <- c(focal(mgi), pool(mgi))
set.seed(123)
random <- all[sample(1:length(all), length(mgi), replace = FALSE)]
## Calculate the percent of convergent CTCF sites for each group
g1 <- (sum(focal(mgi)$convergent) / length(focal(mgi))) * 100
g2 <- (sum(pool(mgi)$convergent) / length(pool(mgi))) * 100
g3 <- (sum(random$convergent) / length(random)) * 100
g4 <- (sum(mgi$convergent) / length(mgi)) * 100
## Visualize
barplot(height = c(g1, g2, g3, g4),
        names.arg = c('looped\n(focal)', 'unlooped\n(pool)',
                      'all pairs\n(random)', 'unlooped\n(matched)'),
        col = c('#1F78B4', '#33A02C', 'orange2', '#A6CEE3'),
        ylab = "Convergent CTCF Sites (%)",
        main = "Testing the Convergence Rule",
        border = NA,
        las = 1)
```

![](data:image/png;base64...)

As shown above the convergent rule holds true even when controlling for CTCF signal strength and bin pair distance. Greater than 90% of looped pairs contain convergent CTCF sites, compared to only ~55% among non-looped subsets.

# Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] cobalt_4.6.1                plotgardener_1.16.0
##  [3] ggplot2_4.0.1               tidyr_1.3.1
##  [5] patchwork_1.3.2             plyranges_1.30.1
##  [7] dplyr_1.1.4                 nullranges_1.16.3
##  [9] GenomeInfoDb_1.46.2         EnsDb.Hsapiens.v86_2.99.0
## [11] ensembldb_2.34.0            AnnotationFilter_1.34.0
## [13] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
## [15] nullrangesData_1.16.0       InteractionSet_1.38.0
## [17] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] ExperimentHub_3.0.0         GenomicRanges_1.62.1
## [23] Seqinfo_1.0.0               IRanges_2.44.0
## [25] S4Vectors_0.48.0            AnnotationHub_4.0.0
## [27] BiocFileCache_3.0.0         dbplyr_2.5.1
## [29] BiocGenerics_0.56.0         generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       strawr_0.0.92            jsonlite_2.0.0
##   [4] magrittr_2.0.4           farver_2.1.2             rmarkdown_2.30
##   [7] fs_1.6.6                 BiocIO_1.20.0            vctrs_0.6.5
##  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [13] progress_1.2.3           htmltools_0.5.9          S4Arrays_1.10.1
##  [16] curl_7.0.0               Rhdf5lib_1.32.0          SparseArray_1.10.7
##  [19] rhdf5_2.54.1             gridGraphics_0.5-1       pracma_2.4.6
##  [22] sass_0.4.10              KernSmooth_2.23-26       bslib_0.9.0
##  [25] httr2_1.2.2              cachem_1.1.0             GenomicAlignments_1.46.0
##  [28] lifecycle_1.0.4          pkgconfig_2.0.3          Matrix_1.7-4
##  [31] R6_2.6.1                 fastmap_1.2.0            digest_0.6.39
##  [34] RSQLite_2.4.5            filelock_1.0.3           labeling_0.4.3
##  [37] httr_1.4.7               abind_1.4-8              compiler_4.5.2
##  [40] bit64_4.6.0-1            withr_3.0.2              S7_0.2.1
##  [43] BiocParallel_1.44.0      DBI_1.2.3                chk_0.10.0
##  [46] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
##  [49] DNAcopy_1.84.0           tools_4.5.2              otel_0.2.0
##  [52] glue_1.8.0               restfulr_0.0.16          rhdf5filters_1.22.0
##  [55] gtable_0.3.6             hms_1.1.4                data.table_1.17.8
##  [58] utf8_1.2.6               XVector_0.50.0           BiocVersion_3.22.0
##  [61] pillar_1.11.1            yulab.utils_0.2.3        lattice_0.22-7
##  [64] rtracklayer_1.70.0       bit_4.6.0                ks_1.15.1
##  [67] tidyselect_1.2.1         Biostrings_2.78.0        knitr_1.50
##  [70] ProtGenerics_1.42.0      xfun_0.54                UCSC.utils_1.6.1
##  [73] lazyeval_0.2.2           yaml_2.3.12              evaluate_1.0.5
##  [76] codetools_0.2-20         cigarillo_1.0.0          tibble_3.3.0
##  [79] BiocManager_1.30.27      ggplotify_0.1.3          cli_3.6.5
##  [82] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
##  [85] png_0.1-8                XML_3.99-0.20            parallel_4.5.2
##  [88] blob_1.2.4               prettyunits_1.2.0        mclust_6.1.2
##  [91] jpeg_0.1-11              bitops_1.0-9             mvtnorm_1.3-3
##  [94] scales_1.4.0             ggridges_0.5.7           purrr_1.2.0
##  [97] crayon_1.5.3             RcppHMM_1.2.2.1          rlang_1.1.6
## [100] KEGGREST_1.50.0
```