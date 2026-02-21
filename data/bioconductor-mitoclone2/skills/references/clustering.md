# Computation of phylogenetic trees and clustering of mutations

#### Lars Velten

## Before you begin

```
library(mitoClone2)
```

You should have identified true somatic variants in the mitochondrial (and nuclear) genome. The remaining vignettes of this package document how to get there. Here, we start with count matrices of the alternative and the reference alleles, across a number of sites of interest. Such data is available from two patients (P1, P2) as part of this package. Only P1 is analyzed as part of this vignette but the commented code for P2 should be fully functional.

```
load(system.file("data/M_P1.RData", package = "mitoClone2"))
load(system.file("data/N_P1.RData", package = "mitoClone2"))
P1 <- mutationCallsFromMatrix(as.matrix(M_P1), as.matrix(N_P1))
```

A first important step is to decide which mutations to include in the clustering. The default is to use all mutations that are covered in at least 20% of the cells, but this assignment can be changed manually.

## Compute a phylogenetic tree

The next step is to run [SCITE](https://github.com/cbg-ethz/SCITE) or [PhISCS](https://github.com/sfu-compbio/PhISCS) to compute the most likely phylogenetic tree. PhISCS is bundled in this package, but the package needs to be run in an environment where [gurobi](https://www.gurobi.com) and the `gurobipy` python package are available. For example, you could set up a `conda` environment that contains this package. SCITE does not require any additional licenses but may need to be manually compiled.

```
## this next step takes approx 4.1 minutes to run
tmpd <- tempdir()
dir.create(paste0(tmpd, "/p1"))
P1 <- varCluster(P1, tempfolder = paste0(tmpd, "/p1"), method = "SCITE")
#> Warning in max(which(x == 1)): no non-missing arguments to max; returning -Inf
```

This step can take a while to run. It computes a likely phylogenetic tree of all the mutations. In the case of SCITE, multiple equally likely tree can be produced. In it’s current state, this package simply selects the first tree from the list.

## Identify clones and assign cells to clones

In many cases, the order of the leaves on these trees is arbitrary, because mutations systematically co-occur. We therefore cluster the mutations into clones. In detail, we take every every branch on the tree and then shuffle the order of mutations in that branch while re-calculating the likelihood. If swapping nodes leads to small changes in the likelihood, these nodes are then merged into a “clone”. The parameter `min.lik` that controls the merging is set arbitrarily, see below for more information.

```
P1 <- clusterMetaclones(P1, min.lik = 1)
#> Warning in mutcalls@mut2clone[branches[[i]]] <-
#> as.integer(max(mutcalls@mut2clone) + : number of items to replace is not a
#> multiple of replacement length
```

![](data:image/png;base64...)

This step also assigns each cell to the most likely clone, and provides an estimate of the likelihood. Refer to `help(mutationCalls)` for more info on how these results are stored.

Finally, the clustering can be plotted.

```
plotClones(P1)
```

![](data:image/png;base64...)

## Parameter choice

The parameter `min.lik` that controls the merging is set arbitrarily. In practice, the goal of these analyses is to group mutations into clones for subsequent analyses (such as differential expression analyses) and it may make sense to overwrite the result of `clusterMetaclones` manually; for example, if a subclone defned on a mitochondrial mutation only should be treated as part of a more clearly defined upstream clone for differential expression analysis.

To overwrite the result of `clusterMetaclones`, first retrieve the assignment of mutations to clones:

```
m2c <- mitoClone2:::getMut2Clone(P1)
print(m2c)
#>   X1282GA   X2537GA   X3335TC   X3350TC   X5492TC X7527GDEL   X8167TC  X11196GA
#>         2         3         5         5         1         4         5         2
#>  X11559GA  X14462GA  X16233AG      EAPP     SRSF2     CEBPA      KLF7      root
#>         4         3         5         4         4         3         2         5

## To e.g. treat the mt:2537G>A and mt:14462:G>A mutations as a
## subclone distinct from CEBPA, we can assign them a new clonal
## identity
m2c[c("X2537GA", "X14462GA")] <- as.integer(6)

P1.new <- mitoClone2:::overwriteMetaclones(P1, m2c)
plotClones(P1.new)
```

![](data:image/png;base64...)

## Session information

```
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
#> [1] mitoClone2_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
#>  [3] gtable_0.3.6                ggplot2_4.0.0
#>  [5] rjson_0.2.23                xfun_0.53
#>  [7] bslib_0.9.0                 Biobase_2.70.0
#>  [9] lattice_0.22-7              vctrs_0.6.5
#> [11] tools_4.5.1                 bitops_1.0-9
#> [13] generics_0.1.4              stats4_4.5.1
#> [15] curl_7.0.0                  parallel_4.5.1
#> [17] tibble_3.3.0                AnnotationDbi_1.72.0
#> [19] RSQLite_2.4.3               blob_1.2.4
#> [21] pkgconfig_2.0.3             pheatmap_1.0.13
#> [23] Matrix_1.7-4                BSgenome_1.78.0
#> [25] RColorBrewer_1.1-3          S7_0.2.0
#> [27] S4Vectors_0.48.0            cigarillo_1.0.0
#> [29] lifecycle_1.0.4             farver_2.1.2
#> [31] compiler_4.5.1              Rsamtools_2.26.0
#> [33] Biostrings_2.78.0           Seqinfo_1.0.0
#> [35] codetools_0.2-20            deepSNV_1.56.0
#> [37] htmltools_0.5.8.1           sass_0.4.10
#> [39] RCurl_1.98-1.17             yaml_2.3.10
#> [41] pillar_1.11.1               crayon_1.5.3
#> [43] jquerylib_0.1.4             BiocParallel_1.44.0
#> [45] DelayedArray_0.36.0         cachem_1.1.0
#> [47] abind_1.4-8                 tidyselect_1.2.1
#> [49] digest_0.6.37               dplyr_1.1.4
#> [51] restfulr_0.0.16             VariantAnnotation_1.56.0
#> [53] splines_4.5.1               fastmap_1.2.0
#> [55] grid_4.5.1                  cli_3.6.5
#> [57] SparseArray_1.10.0          magrittr_2.0.4
#> [59] S4Arrays_1.10.0             GenomicFeatures_1.62.0
#> [61] dichromat_2.0-0.1           XML_3.99-0.19
#> [63] scales_1.4.0                bit64_4.6.0-1
#> [65] rmarkdown_2.30              XVector_0.50.0
#> [67] httr_1.4.7                  matrixStats_1.5.0
#> [69] bit_4.6.0                   png_0.1-8
#> [71] VGAM_1.1-13                 memoise_2.0.1
#> [73] evaluate_1.0.5              knitr_1.50
#> [75] Rhtslib_3.6.0               GenomicRanges_1.62.0
#> [77] IRanges_2.44.0              BiocIO_1.20.0
#> [79] rtracklayer_1.70.0          rlang_1.1.6
#> [81] glue_1.8.0                  DBI_1.2.3
#> [83] formatR_1.14                BiocGenerics_0.56.0
#> [85] jsonlite_2.0.0              R6_2.6.1
#> [87] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```