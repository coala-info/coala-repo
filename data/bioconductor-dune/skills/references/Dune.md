# Vignette for Dune: merging clusters to improve replicability through ARI merging

#### Hector Roux de Bézieux

* [Installation](#installation)
* [Initial visualization](#initial-visualization)
* [Merging with **Dune**](#merging-with-dune)
  + [Initial ARI](#initial-ari)
  + [Actual merging](#actual-merging)
  + [ARI improvement](#ari-improvement)
* [Session](#session)

# Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("Dune")
```

We use a subset of the Allen Smart-Seq nuclei dataset. Run `?Dune::nuclei` for more details on pre-processing.

```
suppressPackageStartupMessages({
  library(RColorBrewer)
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  library(knitr)
  library(purrr)
  library(Dune)
})
data("nuclei", package = "Dune")
theme_set(theme_classic())
```

# Initial visualization

We have a dataset of \(1744\) cells, with the results from 3 clustering algorithms: Seurat3, Monocle3 and SC3. The Allen Institute also produce hand-picked cluster and subclass labels. Finally, we included the coordinates from a t-SNE representation, for visualization.

```
ggplot(nuclei, aes(x = x, y = y, col = subclass_label)) +
  geom_point()
```

![](data:image/png;base64...)

We can also see how the three clustering algorithm partitioned the dataset initially:

```
walk(c("SC3", "Seurat", "Monocle"), function(clus_algo){
  df <- nuclei
  df$clus_algo <- nuclei[, clus_algo]
  p <- ggplot(df, aes(x = x, y = y, col = as.character(clus_algo))) +
    geom_point(size = 1.5) +
    # guides(color = FALSE) +
    labs(title = clus_algo, col = "clusters") +
    theme(legend.position = "bottom")
  print(p)
})
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

# Merging with **Dune**

## Initial ARI

The adjusted Rand Index between the three methods can be computed.

```
plotARIs(nuclei %>% select(SC3, Seurat, Monocle))
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## ℹ The deprecated feature was likely used in the Dune package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

As we can see, the ARI between the three methods is initially quite low.

## Actual merging

We can now try to merge clusters with the `Dune` function. At each step, the algorithm will print which clustering label is merged (by its number, so `1~SC3` and so on), as well as the pair of clusters that get merged.

```
merger <- Dune(clusMat = nuclei %>% select(SC3, Seurat, Monocle), verbose = TRUE)
```

```
## [1] "SC3" "21"  "20"
## [1] "Monocle" "20"      "4"
## [1] "SC3" "11"  "12"
## [1] "SC3" "30"  "28"
## [1] "SC3" "11"  "24"
```

The output from `Dune` is a list with four components:

```
names(merger)
```

```
## [1] "initialMat" "currentMat" "merges"     "ImpMetric"  "metric"
```

`initialMat` is the initial matrix. of cluster labels. `currentMat` is the final matrix of cluster labels. `merges` is a matrix that recapitulates what has been printed above, while `ImpARI` list the ARI improvement over the merges.

## ARI improvement

We can now see how much the ARI has improved:

```
plotARIs(clusMat = merger$currentMat)
```

![](data:image/png;base64...)

The methods now look much more similar, as can be expected.

We can also see how the number of clusters got reduced.

```
plotPrePost(merger)
```

![](data:image/png;base64...)

For SC3 for example, we can visualize how the clusters got merged:

```
ConfusionPlot(merger$initialMat[, "SC3"], merger$currentMat[, "SC3"]) +
  labs(x = "Before merging", y = "After merging")
```

```
## Warning in guide_legend(title.position = "top", fill = "grey"): Arguments in `...` must be used.
## ✖ Problematic argument:
## • fill = "grey"
## ℹ Did you misspell an argument name?
```

![](data:image/png;base64...)

Finally, the **ARIImp** function tracks mean ARI improvement as pairs of clusters get merged down.

```
ARItrend(merger)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the Dune package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

# Session

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Dune_1.22.0        purrr_1.1.0        knitr_1.50         tidyr_1.3.1
## [5] ggplot2_4.0.0      dplyr_1.1.4        RColorBrewer_1.1-3
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] aricode_1.0.3               SparseArray_1.10.0
##  [5] stringi_1.8.7               lattice_0.22-7
##  [7] hms_1.1.4                   digest_0.6.37
##  [9] magrittr_2.0.4              evaluate_1.0.5
## [11] grid_4.5.1                  fastmap_1.2.0
## [13] jsonlite_2.0.0              Matrix_1.7-4
## [15] progress_1.2.3              viridisLite_0.4.2
## [17] scales_1.4.0                tweenr_2.0.3
## [19] codetools_0.2-20            jquerylib_0.1.4
## [21] abind_1.4-8                 cli_3.6.5
## [23] crayon_1.5.3                rlang_1.1.6
## [25] XVector_0.50.0              Biobase_2.70.0
## [27] DelayedArray_0.36.0         withr_3.0.2
## [29] cachem_1.1.0                yaml_2.3.10
## [31] S4Arrays_1.10.0             tools_4.5.1
## [33] parallel_4.5.1              BiocParallel_1.44.0
## [35] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [37] vctrs_0.6.5                 R6_2.6.1
## [39] magick_2.9.0                gganimate_1.0.11
## [41] matrixStats_1.5.0           stats4_4.5.1
## [43] lifecycle_1.0.4             Seqinfo_1.0.0
## [45] S4Vectors_0.48.0            IRanges_2.44.0
## [47] pkgconfig_2.0.3             pillar_1.11.1
## [49] bslib_0.9.0                 gtable_0.3.6
## [51] Rcpp_1.1.0                  glue_1.8.0
## [53] xfun_0.53                   tibble_3.3.0
## [55] GenomicRanges_1.62.0        tidyselect_1.2.1
## [57] MatrixGenerics_1.22.0       dichromat_2.0-0.1
## [59] farver_2.1.2                htmltools_0.5.8.1
## [61] labeling_0.4.3              rmarkdown_2.30
## [63] compiler_4.5.1              prettyunits_1.2.0
## [65] S7_0.2.0
```