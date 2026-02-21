# The IndexedFst class

Pierre-Luc Germain

#### 30 October 2025

#### Abstract

Indexed wrapper for fst objects, enabling indexed fast random access to on-disk data.frames or GRanges

#### Package

scanMiRApp 1.16.0

# Contents

* [1 IndexedFst](#indexedfst)
* [2 Storing GRanges as IndexedFst](#storing-granges-as-indexedfst)
* [3 More…](#more)
  + [3.1 Multithreading](#multithreading)
  + [3.2 Under the hood](#under-the-hood)
* [Session info](#session-info)

# 1 IndexedFst

The `IndexedFst` class provides fast named random access to indexed `fst` files. It is based on the *[fst](https://CRAN.R-project.org/package%3Dfst)* package, which provides fast random reading of data frames. This is particularly useful to manipulate large collections of binding sites without loading them all in memory.

Creating an indexed fst file from a data.frame is very simple:

```
library(scanMiRApp)
```

```
## Loading required package: scanMiR
```

```
# we create a temporary directory in which the files will be saved
tmp <- tempdir()
f <- file.path(tmp, "test")
# we create a dummy data.frame
d <- data.frame( category=sample(LETTERS[1:4], 10000, replace=TRUE),
                 var2=sample(LETTERS, 10000, replace=TRUE),
                 var3=runif(10000) )

saveIndexedFst(d, index.by="category", file.prefix=f)
```

The file can then be loaded (without having all the data in memory) in the following way:

```
d2 <- loadIndexedFst(f)
class(d2)
```

```
## [1] "IndexedFst"
## attr(,"package")
## [1] "scanMiRApp"
```

```
summary(d2)
```

```
## <fst file>
## 10000 rows, 3 columns (test.fst)
##
## * 'category': character
## * 'var2'    : character
## * 'var3'    : double
```

We can see that `d2` is considerably smaller than the original `d`:

```
format(object.size(d),units="Kb")
```

```
## [1] "237 Kb"
```

```
format(object.size(d2),units="Kb")
```

```
## [1] "2.4 Kb"
```

Nevertheless, a number of functions can be used normally on the object:

```
nrow(d2)
```

```
## [1] 10000
```

```
ncol(d2)
```

```
## [1] 3
```

```
colnames(d2)
```

```
## [1] "category" "var2"     "var3"
```

```
head(d2)
```

```
##   category var2      var3
## 1        A    U 0.6494631
## 2        A    Y 0.1738347
## 3        A    N 0.4398419
## 4        A    V 0.9585047
## 5        A    Y 0.3484923
## 6        A    D 0.3323460
```

In addition, the object can be accessed as a list (using the indexed variable). Since in this case the file is indexed using the category column, the different categories can be accessed as `names` of the object:

```
names(d2)
```

```
## [1] "A" "B" "C" "D"
```

```
lengths(d2)
```

```
##    A    B    C    D
## 2512 2511 2442 2535
```

We can read specifically the rows pertaining to one category using:

```
catB <- d2$B
head(catB)
```

```
##   category var2       var3
## 1        B    F 0.07880777
## 2        B    V 0.32486579
## 3        B    W 0.13042985
## 4        B    A 0.86929626
## 5        B    P 0.42725680
## 6        B    U 0.67942214
```

# 2 Storing GRanges as IndexedFst

In addition to data.frames, [GRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html) can be saved as indexed Fst. To demonstrate this, we first create a dummy GRanges object:

```
library(GenomicRanges)
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
gr <- GRanges(sample(LETTERS[1:3],200,replace=TRUE), IRanges(seq_len(200), width=2))
gr$propertyA <- factor(sample(letters[1:5],200,replace=TRUE))
gr
```

```
## GRanges object with 200 ranges and 1 metadata column:
##         seqnames    ranges strand | propertyA
##            <Rle> <IRanges>  <Rle> |  <factor>
##     [1]        B       1-2      * |         d
##     [2]        B       2-3      * |         c
##     [3]        A       3-4      * |         c
##     [4]        B       4-5      * |         b
##     [5]        B       5-6      * |         e
##     ...      ...       ...    ... .       ...
##   [196]        A   196-197      * |         a
##   [197]        B   197-198      * |         d
##   [198]        B   198-199      * |         d
##   [199]        A   199-200      * |         a
##   [200]        A   200-201      * |         d
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

Again the file can then be loaded (without having all the data in memory) in the following way:

```
f2 <- file.path(tmp, "test2")
saveIndexedFst(gr, index.by="seqnames", file.prefix=f2)
d1 <- loadIndexedFst(f2)
names(d1)
```

```
## [1] "B" "A" "C"
```

```
head(d1$A)
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames    ranges strand | propertyA
##          <Rle> <IRanges>  <Rle> |  <factor>
##   [1]        A       3-4      * |         c
##   [2]        A       6-7      * |         d
##   [3]        A       8-9      * |         c
##   [4]        A     18-19      * |         b
##   [5]        A     21-22      * |         d
##   [6]        A     22-23      * |         b
##   -------
##   seqinfo: 3 sequences from an unspecified genome; no seqlengths
```

Similarly, we could index using a different column:

```
saveIndexedFst(gr, index.by="propertyA", file.prefix=f2)
d2 <- loadIndexedFst(f2)
names(d2)
```

```
## [1] "a" "b" "c" "d" "e"
```

# 3 More…

## 3.1 Multithreading

The *[fst](https://CRAN.R-project.org/package%3Dfst)* package supports multithreaded reading and writing. This can also be applied for `IndexedFst`, using the `nthreads` argument of `loadIndexedFst` and `saveIndexedFst`.

## 3.2 Under the hood

The `IndexedFst` class is simply a wrapper around the `fst` package. In addition to the `fst` file, an `rds` file is saved containing the index data. For example, for our last example, the following files have been saved:

```
list.files(tmp, "test2")
```

```
## [1] "test2.fst"     "test2.idx.rds"
```

Either file (or the prefix) can be used for loading, but both files need to have the same prefix.

# Session info

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
##  [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
##  [4] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
##  [7] fstcore_0.10.0       scanMiRApp_1.16.0    scanMiR_1.16.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              shinyjqui_0.4.1
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [15] progress_1.2.3              AnnotationHub_4.0.0
##  [17] curl_7.0.0                  SparseArray_1.10.0
##  [19] sass_0.4.10                 bslib_0.9.0
##  [21] htmlwidgets_1.6.4           httr2_1.2.1
##  [23] plotly_4.11.0               cachem_1.1.0
##  [25] GenomicAlignments_1.46.0    mime_0.13
##  [27] lifecycle_1.0.4             pkgconfig_2.0.3
##  [29] Matrix_1.7-4                R6_2.6.1
##  [31] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [33] shiny_1.11.1                digest_0.6.37
##  [35] AnnotationDbi_1.72.0        shinycssloaders_1.1.0
##  [37] RSQLite_2.4.3               seqLogo_1.76.0
##  [39] filelock_1.0.3              httr_1.4.7
##  [41] abind_1.4-8                 compiler_4.5.1
##  [43] bit64_4.6.0-1               S7_0.2.0
##  [45] BiocParallel_1.44.0         DBI_1.2.3
##  [47] biomaRt_2.66.0              rappdirs_0.3.3
##  [49] DelayedArray_0.36.0         waiter_0.2.5.1
##  [51] rjson_0.2.23                tools_4.5.1
##  [53] otel_0.2.0                  httpuv_1.6.16
##  [55] fst_0.9.8                   glue_1.8.0
##  [57] restfulr_0.0.16             promises_1.4.0
##  [59] grid_4.5.1                  gtable_0.3.6
##  [61] tidyr_1.3.1                 ensembldb_2.34.0
##  [63] hms_1.1.4                   data.table_1.17.8
##  [65] XVector_0.50.0              stringr_1.5.2
##  [67] BiocVersion_3.22.0          pillar_1.11.1
##  [69] later_1.4.4                 rintrojs_0.3.4
##  [71] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [73] lattice_0.22-7              rtracklayer_1.70.0
##  [75] bit_4.6.0                   tidyselect_1.2.1
##  [77] Biostrings_2.78.0           knitr_1.50
##  [79] bookdown_0.45               ProtGenerics_1.42.0
##  [81] SummarizedExperiment_1.40.0 xfun_0.53
##  [83] shinydashboard_0.7.3        Biobase_2.70.0
##  [85] matrixStats_1.5.0           DT_0.34.0
##  [87] stringi_1.8.7               UCSC.utils_1.6.0
##  [89] lazyeval_0.2.2              yaml_2.3.10
##  [91] evaluate_1.0.5              codetools_0.2-20
##  [93] cigarillo_1.0.0             tibble_3.3.0
##  [95] BiocManager_1.30.26         cli_3.6.5
##  [97] xtable_1.8-4                jquerylib_0.1.4
##  [99] dichromat_2.0-0.1           Rcpp_1.1.0
## [101] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [103] png_0.1-8                   XML_3.99-0.19
## [105] parallel_4.5.1              ggplot2_4.0.0
## [107] blob_1.2.4                  prettyunits_1.2.0
## [109] AnnotationFilter_1.34.0     bitops_1.0-9
## [111] pwalign_1.6.0               txdbmaker_1.6.0
## [113] viridisLite_0.4.2           scales_1.4.0
## [115] scanMiRData_1.15.0          purrr_1.1.0
## [117] crayon_1.5.3                rlang_1.1.6
## [119] cowplot_1.2.0               KEGGREST_1.50.0
```