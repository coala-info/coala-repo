# Perform Genomic Liftover

Abdullah Al Nahid1, Hervé Pagès2 and Michael I. Love3,4

1Department of Biochemistry and Molecular Biology, Shahjalal University of Science and Technology, Sylhet, Bangladesh
2Fred Hutchinson Cancer Research Center, Seattle, WA, USA
3Biostatistics Department, University of North Carolina-Chapel Hill, Chapel Hill, NC, USA
4Genetics Department, University of North Carolina-Chapel Hill, Chapel Hill, NC, USA

#### 29 October 2025

#### Abstract

An R/Bioconductor library to perform genomic liftover between different genome assemblies with `GRanges` and `chain` file. Source Code: <https://github.com/nahid18/easylift>

# Contents

* [1 Getting Started](#getting-started)
  + [1.1 Installation](#installation)
  + [1.2 Documentation](#documentation)
  + [1.3 Import](#import)
  + [1.4 Arguments](#arguments)
  + [1.5 Run](#run)
  + [1.6 Run with BiocFileCache](#run-with-biocfilecache)
* [2 Citation](#citation)
* [3 Code of Conduct](#code-of-conduct)
* [4 Session information](#session-information)

# 1 Getting Started

## 1.1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("easylift")
```

## 1.2 Documentation

To view documentation:

```
browseVignettes("easylift")
```

## 1.3 Import

```
library("easylift")
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
```

## 1.4 Arguments

Create a `GRanges` object, assign a genome to it, and specify chain file

```
gr <- GRanges(
  seqname = Rle(
    c("chr1", "chr2"),
    c(100000, 100000)
  ),
  ranges = IRanges(
    start = 1, end = 200000
  )
)
# Here, "hg19" is the source genome
genome(gr) <- "hg19"

# Here, we use the `system.file()` function because the chain file is in the
# package (however if you need to point to any other file on your machine,
# just do 'chain <- "path/to/your/hg19ToHg38.over.chain.gz"'):
chain <- system.file("extdata", "hg19ToHg38.over.chain.gz", package = "easylift")

gr
#> GRanges object with 200000 ranges and 0 metadata columns:
#>            seqnames    ranges strand
#>               <Rle> <IRanges>  <Rle>
#>        [1]     chr1  1-200000      *
#>        [2]     chr1  1-200000      *
#>        [3]     chr1  1-200000      *
#>        [4]     chr1  1-200000      *
#>        [5]     chr1  1-200000      *
#>        ...      ...       ...    ...
#>   [199996]     chr2  1-200000      *
#>   [199997]     chr2  1-200000      *
#>   [199998]     chr2  1-200000      *
#>   [199999]     chr2  1-200000      *
#>   [200000]     chr2  1-200000      *
#>   -------
#>   seqinfo: 2 sequences from hg19 genome; no seqlengths
```

## 1.5 Run

Call `easylift` with `GRanges` object, target genome and the chain file.

```
# Here, "hg38" is the target genome
easylift(gr, "hg38", chain)
#> GRanges object with 300000 ranges and 0 metadata columns:
#>            seqnames        ranges strand
#>               <Rle>     <IRanges>  <Rle>
#>        [1]     chr1  10001-177376      *
#>        [2]    chr19 242824-242864      *
#>        [3]     chr1  10001-177376      *
#>        [4]    chr19 242824-242864      *
#>        [5]     chr1  10001-177376      *
#>        ...      ...           ...    ...
#>   [299996]     chr2  10001-200000      *
#>   [299997]     chr2  10001-200000      *
#>   [299998]     chr2  10001-200000      *
#>   [299999]     chr2  10001-200000      *
#>   [300000]     chr2  10001-200000      *
#>   -------
#>   seqinfo: 25 sequences (1 circular) from hg38 genome
```

## 1.6 Run with BiocFileCache

To use `BiocFileCache` for the chain file, add it to the cache:

```
chain_file <- "/path/to/your/hg19ToHg38.over.chain.gz"
bfc <- BiocFileCache()

# Add chain file to cache if already not available
if (nrow(bfcquery(bfc, basename(chain_file))) == 0)
    bfcadd(bfc, chain_file)
```

Then, use it in `easylift`:

```
easylift(gr, "hg38")
# or
gr |> easylift("hg38")
```

# 2 Citation

To cite package `easylift` in publications use:

Al Nahid A, Pagès H, Love M (2023). *easylift: An R package to perform
genomic liftover*. R package version 1.0.0,
<https://github.com/nahid18/easylift>.

A BibTeX entry for LaTeX users is

```
  @Manual{,
    title = {easylift: An R package to perform genomic liftover},
    author = {Abdullah Al Nahid, Hervé Pagès, Michael Love},
    year = {2023},
    note = {R package version 1.0.0},
    url = {https://github.com/nahid18/easylift},
  }
```

Please note that the `easylift` was only made possible thanks to many other R and bioinformatics software authors, which are cited either in the vignettes and/or the paper(s) describing this package.

# 3 Code of Conduct

Please note that the `easylift` project is released with a [Contributor Code of Conduct](http://bioconductor.org/about/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

# 4 Session information

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
#>  [1] easylift_1.8.0       BiocFileCache_3.0.0  dbplyr_2.5.1
#>  [4] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
#>  [7] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
#>  [3] xfun_0.53                   bslib_0.9.0
#>  [5] httr2_1.2.1                 lattice_0.22-7
#>  [7] Biobase_2.70.0              vctrs_0.6.5
#>  [9] tools_4.5.1                 bitops_1.0-9
#> [11] parallel_4.5.1              curl_7.0.0
#> [13] tibble_3.3.0                RSQLite_2.4.3
#> [15] blob_1.2.4                  pkgconfig_2.0.3
#> [17] R.oo_1.27.1                 Matrix_1.7-4
#> [19] cigarillo_1.0.0             lifecycle_1.0.4
#> [21] compiler_4.5.1              Rsamtools_2.26.0
#> [23] Biostrings_2.78.0           codetools_0.2-20
#> [25] GenomeInfoDb_1.46.0         htmltools_0.5.8.1
#> [27] sass_0.4.10                 RCurl_1.98-1.17
#> [29] yaml_2.3.10                 pillar_1.11.1
#> [31] crayon_1.5.3                jquerylib_0.1.4
#> [33] R.utils_2.13.0              BiocParallel_1.44.0
#> [35] DelayedArray_0.36.0         cachem_1.1.0
#> [37] abind_1.4-8                 tidyselect_1.2.1
#> [39] digest_0.6.37               dplyr_1.1.4
#> [41] restfulr_0.0.16             bookdown_0.45
#> [43] grid_4.5.1                  fastmap_1.2.0
#> [45] SparseArray_1.10.0          cli_3.6.5
#> [47] magrittr_2.0.4              S4Arrays_1.10.0
#> [49] XML_3.99-0.19               filelock_1.0.3
#> [51] UCSC.utils_1.6.0            rappdirs_0.3.3
#> [53] bit64_4.6.0-1               rmarkdown_2.30
#> [55] XVector_0.50.0              httr_1.4.7
#> [57] matrixStats_1.5.0           bit_4.6.0
#> [59] R.methodsS3_1.8.2           memoise_2.0.1
#> [61] evaluate_1.0.5              knitr_1.50
#> [63] BiocIO_1.20.0               rtracklayer_1.70.0
#> [65] rlang_1.1.6                 glue_1.8.0
#> [67] DBI_1.2.3                   BiocManager_1.30.26
#> [69] jsonlite_2.0.0              R6_2.6.1
#> [71] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```