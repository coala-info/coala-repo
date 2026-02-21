# The epialleleR output values

#### 29 October, 2025

Abstract

A comparison and visualisation of epialleleR output values for various input files

# Introduction

The best possible explanation on VEF and lMHL values is given in help files for *`generateCytosineReport`* and *`generateMhlReport`* methods, respectively. Here we try to show some simplified and real situations, i.e., different methylation patterns that may exist, and provide a visual summary of *`epialleleR`* output.

The readers are welcome to try their own real and simulated data. If it might be of interest to others, please create an issue and these examples might get included in this vignette.

NB: the `plotMetrics` function used below is a piece of spaghetti code, hence hidden. If you still want to use it or see what it does - browse a [source code](https://github.com/BBCG/epialleleR/blob/devel/vignettes/values.Rmd) of this vignette online.

```
out.bam <- tempfile(pattern="simulated", fileext=".bam")
set.seed(1)

# no epimutations
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    sapply(
      lapply(1:1000, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.148s]
#> [1] 1000
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), 0, title="no epimutations")
```

![](data:image/png;base64...)

```
# one complete epimutation
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    paste(rep("Z", 10), collapse=""),
    sapply(
      lapply(1:999, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.129s]
#> [1] 1000
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), title="one complete epimutation")
```

![](data:image/png;base64...)

```
# one partial epimutation
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    paste(c(rep("Z", 4), "z", "z", rep("Z", 4)), collapse=""),
    sapply(
      lapply(1:999, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.137s]
#> [1] 1000
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), title="one partial epimutation")
```

![](data:image/png;base64...)

```
# another partial epimutation
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    "zZZZZZZZzz",
    sapply(
      lapply(1:999, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.117s]
#> [1] 1000
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), title="another partial epimutation")
```

![](data:image/png;base64...)

```
# several partial epimutations
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    sapply(
      lapply(1:10, function (x) c(rep("Z", 6), rep("z", 4))),
      paste, collapse=""
    ),
    sapply(
      lapply(1:999, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.146s]
#> [1] 1009
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), title="several partial epimutations")
```

![](data:image/png;base64...)

```
# several short partial epimutations
simulateBam(
  output.bam.file=out.bam,
  XM=c(
    sapply(
      lapply(1:10, function (x) c(rep("Z", 4), rep("z", 6))),
      paste, collapse=""
    ),
    sapply(
      lapply(1:999, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.156s]
#> [1] 1009
plotMetrics(out.bam, as("chrS:1-10", "GRanges"), title="several short partial epimutations")
```

![](data:image/png;base64...)

```
# several overlapping partial epimutations
simulateBam(
  output.bam.file=out.bam,
  pos=1:10,
  XM=c(
    "ZZZZZZZZZZ", "ZZZZZZZZZz", "ZZZZZZZZzz", "ZZZZZZZzzz", "ZZZZZZzzzz",
    sapply(
      lapply(1:15, function (x) sample(c("Z",rep("z", 9)), 10)),
      paste, collapse=""
    )
  ),
  XG="CT"
)
#> Writing sample BAM [0.005s]
#> [1] 20
plotMetrics(out.bam, as("chrS:1-20", "GRanges"), title="several overlapping partial epimutations")
```

![](data:image/png;base64...)

```
# amplicon 0%
plotMetrics(
  system.file("extdata", "amplicon000meth.bam", package="epialleleR"),
  as("chr17:43124861-43126026", "GRanges"), title="amplicon, 0%"
)
```

![](data:image/png;base64...)

```
# amplicon 10%
plotMetrics(
  system.file("extdata", "amplicon010meth.bam", package="epialleleR"),
  as("chr17:43124861-43126026", "GRanges"), title="amplicon, 10%"
)
```

![](data:image/png;base64...)

```
# sample capture, BMP7
plotMetrics(
  system.file("extdata", "capture.bam", package="epialleleR"),
  as("chr20:57266125-57268185:+", "GRanges"), title="sample capture, BMP7, + strand"
)
```

![](data:image/png;base64...)

```
# sample capture, BMP7
plotMetrics(
  system.file("extdata", "capture.bam", package="epialleleR"),
  as("chr20:57266125-57268185:-", "GRanges"), title="sample capture, BMP7, - strand"
)
```

![](data:image/png;base64...)

```
# sample capture, RAD51C
plotMetrics(
  system.file("extdata", "capture.bam", package="epialleleR"),
  as("chr17:58691673-58693108:+", "GRanges"), title="sample capture, RAD51C, + strand"
)
```

![](data:image/png;base64...)

```
# sample capture, RAD51C
plotMetrics(
  system.file("extdata", "capture.bam", package="epialleleR"),
  as("chr17:58691673-58693108:-", "GRanges"), title="sample capture, RAD51C, - strand"
)
```

![](data:image/png;base64...)

```
# long-read sequencing, low methylation
getXM <- function (p) {sample(x=c("z", "Z"), size=1, prob=c(p, 1-p))}
probs <- (sin(seq(-2*pi, +1*pi, by = pi/25))+2)/3
simulateBam(
  output.bam.file=out.bam,
  pos=1:10,
  XM=sapply(1:10, function (i) {paste(sapply(probs, getXM), collapse="")}),
  XG="CT"
)
#> Writing sample BAM [0.019s]
#> [1] 10
plotMetrics(out.bam, as("chrS:1-1000", "GRanges"), title="long-read sequencing, low methylation")
```

![](data:image/png;base64...)

```
# long-read sequencing, high methylation
simulateBam(
  output.bam.file=out.bam,
  pos=1:10,
  XM=sapply(1:10, function (i) {paste(sapply(1-probs, getXM), collapse="")}),
  XG="CT"
)
#> Writing sample BAM [0.016s]
#> [1] 10
plotMetrics(out.bam, as("chrS:1-1000", "GRanges"), title="long-read sequencing, high methylation")
```

![](data:image/png;base64...)

## Session Info

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
#>  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#> [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#> [5] BiocGenerics_0.56.0  generics_0.1.4       data.table_1.17.8    ggplot2_4.0.0
#> [9] epialleleR_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [4] rjson_0.2.23                xfun_0.53                   bslib_0.9.0
#>  [7] Biobase_2.70.0              lattice_0.22-7              vctrs_0.6.5
#> [10] tools_4.5.1                 bitops_1.0-9                curl_7.0.0
#> [13] parallel_4.5.1              tibble_3.3.0                AnnotationDbi_1.72.0
#> [16] RSQLite_2.4.3               blob_1.2.4                  pkgconfig_2.0.3
#> [19] Matrix_1.7-4                BSgenome_1.78.0             RColorBrewer_1.1-3
#> [22] cigarillo_1.0.0             S7_0.2.0                    lifecycle_1.0.4
#> [25] compiler_4.5.1              farver_2.1.2                Rsamtools_2.26.0
#> [28] Biostrings_2.78.0           codetools_0.2-20            GenomeInfoDb_1.46.0
#> [31] htmltools_0.5.8.1           sass_0.4.10                 RCurl_1.98-1.17
#> [34] yaml_2.3.10                 pillar_1.11.1               crayon_1.5.3
#> [37] jquerylib_0.1.4             BiocParallel_1.44.0         DelayedArray_0.36.0
#> [40] cachem_1.1.0                abind_1.4-8                 tidyselect_1.2.1
#> [43] digest_0.6.37               restfulr_0.0.16             dplyr_1.1.4
#> [46] VariantAnnotation_1.56.0    labeling_0.4.3              fastmap_1.2.0
#> [49] grid_4.5.1                  cli_3.6.5                   SparseArray_1.10.0
#> [52] magrittr_2.0.4              S4Arrays_1.10.0             GenomicFeatures_1.62.0
#> [55] XML_3.99-0.19               dichromat_2.0-0.1           withr_3.0.2
#> [58] UCSC.utils_1.6.0            scales_1.4.0                bit64_4.6.0-1
#> [61] rmarkdown_2.30              XVector_0.50.0              httr_1.4.7
#> [64] matrixStats_1.5.0           bit_4.6.0                   png_0.1-8
#> [67] memoise_2.0.1               evaluate_1.0.5              knitr_1.50
#> [70] BiocIO_1.20.0               rtracklayer_1.70.0          rlang_1.1.6
#> [73] Rcpp_1.1.0                  glue_1.8.0                  DBI_1.2.3
#> [76] jsonlite_2.0.0              R6_2.6.1                    GenomicAlignments_1.46.0
#> [79] MatrixGenerics_1.22.0
```