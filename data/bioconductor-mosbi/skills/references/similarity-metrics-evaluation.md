# Similarity Metrics Evaluation

Tim Daniel Rose

#### 2025-10-30

# Contents

* [1 Session Info](#session-info)

In the `mosbi` package, similarities between biclusters are
computed using different possible similarity metrics.

This vignette gives an overview about the implemented metrics.

```
library(mosbi)
```

The following similarity metrics are currently implemented:

* Bray-Curtis similarity
  ([Wikipedia](https://en.wikipedia.org/wiki/Bray%E2%80%93Curtis_dissimilarity))
* Jaccard index
  ([Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index))
* overlap coefficient
  ([Wikipedia](https://en.wikipedia.org/wiki/Overlap_coefficient))
* Fowlkes–Mallows index
  ([Wikipedia](https://en.wikipedia.org/wiki/Fowlkes%E2%80%93Mallows_index))

```
# Bray-Curtis similarity
bray_curtis <- function(s1, s2, overlap) {
    return(((2 * overlap) / (s1 + s2)))
}

# Jaccard index
jaccard <- function(s1, s2, overlap) {
    return(((overlap) / (s1 + s2 - overlap)))
}

# overlap coefficient
overlap <- function(s1, s2, overlap) {
    return((overlap / min(s1, s2)))
}

# Fowlkes–Mallows index
folkes_mallows <- function(s1, s2, overlap) {
    tp <- choose(overlap, 2)
    fp <- choose(s1 - overlap, 2)
    fn <- choose(s2 - overlap, 2)

    return(sqrt((tp / (tp + fp)) * (tp / (tp + fn))))
}
```

The behavior of the similarity metrics will be evaluated for two scenarios:

* Two biclusters of the same size with an increasing overlap.
* Two biclusters of different sizes (One twice as big as the other)
  with an increasing overlap.

```
# Scenario 1 - two biclusters of the same size
size1_1 <- rep(1000, 1000)
size2_1 <- rep(1000, 1000)
overlap_1 <- seq(1, 1000)

# Scenario 2 - two biclusters one of size 500, the other of size 1000
size1_2 <- rep(1000, 500)
size2_2 <- rep(500, 500)
overlap_2 <- seq(1, 500)
```

Two biclusters of the same size:

```
plot(overlap_1, bray_curtis(size1_1, size2_1, overlap_1),
    col = "red", type = "l", xlab = "Overlap", ylab = "Similarity",
    ylim = c(0, 1)
)
lines(overlap_1, jaccard(size1_1, size2_1, overlap_1), col = "blue")
lines(overlap_1, overlap(size1_1, size2_1, overlap_1), col = "green", lty = 2)
lines(overlap_1, folkes_mallows(size1_1, size2_1, overlap_1), col = "orange")
legend(
    x = .8, legend = c("Bray-Curtis", "Jaccard", "Overlap", "Fowlkes–Mallows"),
    col = c("red", "blue", "green", "orange"),
    lty = 1, cex = 0.8, title = "Similarity metrics"
)
```

![](data:image/png;base64...)

Two biclusters of different sizes:

```
plot(overlap_2, bray_curtis(size1_2, size2_2, overlap_2),
    col = "red", type = "l", xlab = "Overlap", ylab = "Similarity",
    ylim = c(0, 1)
)
lines(overlap_2, jaccard(size1_2, size2_2, overlap_2), col = "blue")
lines(overlap_2, overlap(size1_2, size2_2, overlap_2), col = "green")
lines(overlap_2, folkes_mallows(size1_2, size2_2, overlap_2), col = "orange")
legend(
    x = .8, legend = c("Bray-Curtis", "Jaccard", "Overlap", "Fowlkes–Mallows"),
    col = c("red", "blue", "green", "orange"),
    lty = 1, cex = 0.8, title = "Similarity metrics"
)
```

![](data:image/png;base64...)

# 1 Session Info

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
#> [1] mosbi_1.16.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.3.1             sass_0.4.10             generics_0.1.4
#>  [4] class_7.3-23            lattice_0.22-7          digest_0.6.37
#>  [7] magrittr_2.0.4          evaluate_1.0.5          grid_4.5.1
#> [10] RColorBrewer_1.1-3      bookdown_0.45           fastmap_1.2.0
#> [13] jsonlite_2.0.0          tinytex_0.57            BiocManager_1.30.26
#> [16] purrr_1.1.0             scales_1.4.0            modeltools_0.2-24
#> [19] jquerylib_0.1.4         cli_3.6.5               isa2_0.3.6
#> [22] rlang_1.1.6             Biobase_2.70.0          cachem_1.1.0
#> [25] yaml_2.3.10             tools_4.5.1             parallel_4.5.1
#> [28] biclust_2.0.3.1         dplyr_1.1.4             colorspace_2.1-2
#> [31] ggplot2_4.0.0           BiocGenerics_0.56.0     vctrs_0.6.5
#> [34] R6_2.6.1                stats4_4.5.1            lifecycle_1.0.4
#> [37] magick_2.9.0            QUBIC_1.38.0            MASS_7.3-65
#> [40] pkgconfig_2.0.3         RcppParallel_5.1.11-1   bslib_0.9.0
#> [43] pillar_1.11.1           gtable_0.3.6            glue_1.8.0
#> [46] Rcpp_1.1.0              tidyselect_1.2.1        tibble_3.3.0
#> [49] xfun_0.53               flexclust_1.5.0         knitr_1.50
#> [52] dichromat_2.0-0.1       farver_2.1.2            fabia_2.56.0
#> [55] igraph_2.2.1            htmltools_0.5.8.1       rmarkdown_2.30
#> [58] BH_1.87.0-1             compiler_4.5.1          S7_0.2.0
#> [61] additivityTests_1.1-4.2
```