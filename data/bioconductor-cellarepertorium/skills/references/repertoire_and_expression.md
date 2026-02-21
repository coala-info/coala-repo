# Combining Repertoire with Expression with SingleCellExperiment

#### 27 October 2020

# Contents

* [1 “Load” expression](#load-expression)
* [2 Remake the ContigCellDB with empty cells](#remake-the-contigcelldb-with-empty-cells)
* [3 Chain pairings](#chain-pairings)
* [4 Visualization of TCR features with Scater](#visualization-of-tcr-features-with-scater)
* [5 Colophone](#colophone)

```
library(CellaRepertorium)
library(SingleCellExperiment)
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'matrixStats'
#> The following object is masked from 'package:dplyr':
#>
#>     count
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: GenomeInfoDb
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
library(purrr)
```

It is possible to combine `ContigCellDB` objects with `SingleCellExperiment` objects that measure overlapping barcodes. We choose to include the `ContigCellDB` object as a member of the `colData`. In this way, it is possible to include different cellular “views” of the repertoire, such as the alpha chain and beta chain properties, as well as the paired clonotypes.

# 1 “Load” expression

First we’ll cook up some single cell expression data.

```
set.seed(1345)
data(ccdb_ex)
barcodes = ccdb_ex$cell_tbl[ccdb_ex$cell_pk]

# Take a subsample of almost all of the barcdes
barcodes = barcodes[sample(nrow(barcodes), nrow(barcodes) - 5),]
samples = unique(ccdb_ex$cell_tbl[setdiff(ccdb_ex$cell_pk, 'barcode')])

# For each sample, generate  0-100 "extra" barcodes for which only 5' expression is recovered
extra = samples %>% rowwise() %>% mutate(extrabc = {
  extra_bc = floor(runif(1, 0, 100))
  list(tibble(barcode = paste0('barcode', seq_len(extra_bc))))
})
extra = extra %>% unnest(cols = c(extrabc))
all_bc = bind_rows(extra, barcodes)
```

Simulate some “cells” and “genes” that nearly form a superset of the cells for which repertoire are available. This is generally true if no barcode filters have been applied to the expression data. In practice a few cells may have repertoire but not expression (or fail QC for expression). We will work with the intersection of these cells.

```
genes = 200
cells = nrow(all_bc)
array_size = genes*cells
expression = matrix(rnbinom(array_size, size = 5, mu = 3), nrow = genes, ncol = cells)
sce = SingleCellExperiment(assay = list(counts = expression), colData = all_bc)
```

# 2 Remake the ContigCellDB with empty cells

```
ccdb2 = ccdb_join(sce, ccdb_ex)

ccdb2 = cdhit_ccdb(ccdb2, 'cdr3', type = 'AA', cluster_pk = 'aa80', identity = .8, min_length = 5)
ccdb2 = fine_clustering(ccdb2, sequence_key = 'cdr3', type = 'AA', keep_clustering_details = FALSE)
#> Calculating intradistances on 993 clusters.
#> Summarizing
```

The `ccdb_join(template, ccdb)` function does a left join of the `template` onto the `cell_tbl` of the `ccdb`. This will ensure that the `cell_tbl` is expanded and ordered properly to mesh with `sce` when we add it below.

# 3 Chain pairings

```
colData(sce)$alpha =  canonicalize_cell(ccdb2, chain == 'TRA', contig_fields = c('chain', 'v_gene','d_gene', 'j_gene', 'aa80'))

colData(sce)$beta =  canonicalize_cell(ccdb2, chain == 'TRB', contig_fields = c('chain', 'v_gene','d_gene', 'j_gene', 'aa80'))

colData(sce)$pairing = enumerate_pairing(ccdb2, chain_recode_fun = 'guess')
```

We can add multiple views, represented as fields in the `colData(sce)` of the repertoire.

# 4 Visualization of TCR features with Scater

We can leverage Scater’s ability to use “nested” data frames to visualize TCR features.

```
library(scater)
sce = logNormCounts(sce)
sce = runPCA(sce)
plotReducedDim(sce, dimred = 'PCA', colour_by = I(sce$pairing$pairing), point_alpha = 1)
#> Warning: Removed 286 rows containing missing values (geom_point).
```

![](data:image/png;base64...)

Here we calculate the first two principal components (which aren’t very interesting because these are simulated data without any special structure), and then visualize if the TCR was paired or not.

```
only_paired = sce[,which(sce$pairing$pairing == 'paired')]
plotReducedDim(only_paired, dimred = 'PCA', colour_by = I(only_paired$alpha$j_gene), point_alpha = 1)
#> Warning: Removed 328 rows containing missing values (geom_point).
```

![](data:image/png;base64...)

```
plotReducedDim(only_paired, dimred = 'PCA', colour_by = I(only_paired$beta$j_gene), point_alpha = 1)
#> Warning: Removed 250 rows containing missing values (geom_point).
```

![](data:image/png;base64...)

Since the `ContigCellDB` is nested within the `SingleCellExperiment` it automatically gets subsetted appropriately when the parent object is subsetted. Enough `data.frame`-like semantics have been implemented so that fields from the `cell_tbl` can be visualized.

# 5 Colophone

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    parallel  stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] scater_1.18.0               SingleCellExperiment_1.12.0
#>  [3] SummarizedExperiment_1.20.0 Biobase_2.50.0
#>  [5] GenomicRanges_1.42.0        GenomeInfoDb_1.26.0
#>  [7] MatrixGenerics_1.2.0        matrixStats_0.57.0
#>  [9] Biostrings_2.58.0           XVector_0.30.0
#> [11] IRanges_2.24.0              S4Vectors_0.28.0
#> [13] BiocGenerics_0.36.0         ggdendro_0.1.22
#> [15] purrr_0.3.4                 stringr_1.4.0
#> [17] tidyr_1.1.2                 readr_1.4.0
#> [19] ggplot2_3.3.2               dplyr_1.0.2
#> [21] CellaRepertorium_1.0.0      BiocStyle_2.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] nlme_3.1-150              bitops_1.0-6
#>  [3] RColorBrewer_1.1-2        progress_1.2.2
#>  [5] tools_4.0.3               TMB_1.7.18
#>  [7] backports_1.1.10          irlba_2.3.3
#>  [9] utf8_1.1.4                R6_2.4.1
#> [11] vipor_0.4.5               colorspace_1.4-1
#> [13] withr_2.3.0               gridExtra_2.3
#> [15] tidyselect_1.1.0          prettyunits_1.1.1
#> [17] compiler_4.0.3            cli_2.1.0
#> [19] BiocNeighbors_1.8.0       DelayedArray_0.16.0
#> [21] labeling_0.4.2            bookdown_0.21
#> [23] scales_1.1.1              digest_0.6.27
#> [25] minqa_1.2.4               rmarkdown_2.5
#> [27] pkgconfig_2.0.3           htmltools_0.5.0
#> [29] lme4_1.1-25               sparseMatrixStats_1.2.0
#> [31] highr_0.8                 rlang_0.4.8
#> [33] DelayedMatrixStats_1.12.0 farver_2.0.3
#> [35] generics_0.0.2            BiocParallel_1.24.0
#> [37] broom.mixed_0.2.6         BiocSingular_1.6.0
#> [39] RCurl_1.98-1.2            magrittr_1.5
#> [41] scuttle_1.0.0             GenomeInfoDbData_1.2.4
#> [43] Matrix_1.2-18             ggbeeswarm_0.6.0
#> [45] Rcpp_1.0.5                munsell_0.5.0
#> [47] fansi_0.4.1               viridis_0.5.1
#> [49] lifecycle_0.2.0           stringi_1.5.3
#> [51] yaml_2.2.1                MASS_7.3-53
#> [53] zlibbioc_1.36.0           plyr_1.8.6
#> [55] grid_4.0.3                forcats_0.5.0
#> [57] crayon_1.3.4              lattice_0.20-41
#> [59] beachmat_2.6.0            cowplot_1.1.0
#> [61] splines_4.0.3             hms_0.5.3
#> [63] magick_2.5.0              knitr_1.30
#> [65] pillar_1.4.6              boot_1.3-25
#> [67] reshape2_1.4.4            glue_1.4.2
#> [69] evaluate_0.14             BiocManager_1.30.10
#> [71] vctrs_0.3.4               png_0.1-7
#> [73] nloptr_1.2.2.2            gtable_0.3.0
#> [75] assertthat_0.2.1          xfun_0.18
#> [77] rsvd_1.0.3                broom_0.7.2
#> [79] coda_0.19-4               viridisLite_0.3.0
#> [81] tibble_3.0.4              beeswarm_0.2.3
#> [83] statmod_1.4.35            ellipsis_0.3.1
```