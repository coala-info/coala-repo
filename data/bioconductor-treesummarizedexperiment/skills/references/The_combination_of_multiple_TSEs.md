# Combine TreeSummarizedExperiment objects

Ruizhu HUANG1,2, Charlotte Soneson1,2 and Mark Robinson1,2

1Institute of Molecular Life Sciences, University of Zurich.
2SIB Swiss Institute of Bioinformatics.

#### 30 October 2025

#### Package

TreeSummarizedExperiment 2.18.0

# Contents

* [1 Combine multiple `TreeSummarizedExperiment` objects](#combine-multiple-treesummarizedexperiment-objects)
* [2 Subset a **TSE** object](#subset-a-tse-object)
* [3 Change specific trees of **TSE**](#change-specific-trees-of-tse)
* [4 Session Info](#session-info)
* [5 Reference](#reference)

# 1 Combine multiple `TreeSummarizedExperiment` objects

Multiple `TreeSummarizedExperiemnt` objects (**TSE**) can be combined by using
`rbind` or `cbind`. Here, we create a toy `TreeSummarizedExperiment` object
using `makeTSE()` (see `?makeTSE()`). As the tree in the row/column tree slot is
generated randomly using `ape::rtree()`, `set.seed()` is used to create
reproducible results.

```
library(TreeSummarizedExperiment)

set.seed(1)
# TSE: without the column tree
(tse_a <- makeTSE(include.colTree = FALSE))
```

```
## class: TreeSummarizedExperiment
## dim: 10 4
## metadata(0):
## assays(1): ''
## rownames(10): entity1 entity2 ... entity9 entity10
## rowData names(2): var1 var2
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (10 rows)
## rowTree: 1 phylo tree(s) (10 leaves)
## colLinks: NULL
## colTree: NULL
```

```
# combine two TSEs by row
(tse_aa <- rbind(tse_a, tse_a))
```

```
## class: TreeSummarizedExperiment
## dim: 20 4
## metadata(0):
## assays(1): ''
## rownames(20): entity1 entity2 ... entity9 entity10
## rowData names(2): var1 var2
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (20 rows)
## rowTree: 1 phylo tree(s) (10 leaves)
## colLinks: NULL
## colTree: NULL
```

The generated `tse_aa` has 20 rows, which is two times of that in `tse_a`. The row tree in `tse_aa` is the same as that in `tse_a`.

```
identical(rowTree(tse_aa), rowTree(tse_a))
```

```
## [1] TRUE
```

If we `rbind` two TSEs (e.g., `tse_a` and `tse_b`) that have different row trees, the obtained TSE (e.g., `tse_ab`) will have two row trees.

```
set.seed(2)
tse_b <- makeTSE(include.colTree = FALSE)

# different row trees
identical(rowTree(tse_a), rowTree(tse_b))
```

```
## [1] FALSE
```

```
# 2 phylo tree(s) in rowTree
(tse_ab <- rbind(tse_a, tse_b))
```

```
## class: TreeSummarizedExperiment
## dim: 20 4
## metadata(0):
## assays(1): ''
## rownames(20): entity1 entity2 ... entity9 entity10
## rowData names(2): var1 var2
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (20 rows)
## rowTree: 2 phylo tree(s) (20 leaves)
## colLinks: NULL
## colTree: NULL
```

In the row link data, the `whichTree` column gives information about which tree the row is mapped to.
For `tse_aa`, there is only one tree named as `phylo`. However, for `tse_ab`, there are two trees (`phylo` and `phylo.1`).

```
rowLinks(tse_aa)
```

```
## LinkDataFrame with 20 rows and 5 columns
##              nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##          <character>   <character> <integer> <logical> <character>
## entity1      entity1       alias_1         1      TRUE       phylo
## entity2      entity2       alias_2         2      TRUE       phylo
## entity3      entity3       alias_3         3      TRUE       phylo
## entity4      entity4       alias_4         4      TRUE       phylo
## entity5      entity5       alias_5         5      TRUE       phylo
## ...              ...           ...       ...       ...         ...
## entity6      entity6       alias_6         6      TRUE       phylo
## entity7      entity7       alias_7         7      TRUE       phylo
## entity8      entity8       alias_8         8      TRUE       phylo
## entity9      entity9       alias_9         9      TRUE       phylo
## entity10    entity10      alias_10        10      TRUE       phylo
```

```
rowLinks(tse_ab)
```

```
## LinkDataFrame with 20 rows and 5 columns
##              nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##          <character>   <character> <integer> <logical> <character>
## entity1      entity1       alias_1         1      TRUE       phylo
## entity2      entity2       alias_2         2      TRUE       phylo
## entity3      entity3       alias_3         3      TRUE       phylo
## entity4      entity4       alias_4         4      TRUE       phylo
## entity5      entity5       alias_5         5      TRUE       phylo
## ...              ...           ...       ...       ...         ...
## entity6      entity6       alias_6         6      TRUE     phylo.1
## entity7      entity7       alias_7         7      TRUE     phylo.1
## entity8      entity8       alias_8         8      TRUE     phylo.1
## entity9      entity9       alias_9         9      TRUE     phylo.1
## entity10    entity10      alias_10        10      TRUE     phylo.1
```

The name of trees can be accessed using `rowTreeNames`. If the input **TSE**s use the same name for trees, `rbind` will automatically create valid and unique names for trees by using `make.names`. `tse_a` and `tse_b` both use `phylo` as the name of their row trees. In `tse_ab`, the row tree that originates from `tse_b` is named as `phylo.1` instead.

```
rowTreeNames(tse_aa)
```

```
## [1] "phylo"
```

```
rowTreeNames(tse_ab)
```

```
## [1] "phylo"   "phylo.1"
```

```
# The original tree names in the input TSEs
rowTreeNames(tse_a)
```

```
## [1] "phylo"
```

```
rowTreeNames(tse_b)
```

```
## [1] "phylo"
```

Once the name of trees is changed, the column `whichTree` in the `rowLinks()` is updated accordingly.

```
rowTreeNames(tse_ab) <- paste0("tree", 1:2)
rowLinks(tse_ab)
```

```
## LinkDataFrame with 20 rows and 5 columns
##              nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##          <character>   <character> <integer> <logical> <character>
## entity1      entity1       alias_1         1      TRUE       tree1
## entity2      entity2       alias_2         2      TRUE       tree1
## entity3      entity3       alias_3         3      TRUE       tree1
## entity4      entity4       alias_4         4      TRUE       tree1
## entity5      entity5       alias_5         5      TRUE       tree1
## ...              ...           ...       ...       ...         ...
## entity6      entity6       alias_6         6      TRUE       tree2
## entity7      entity7       alias_7         7      TRUE       tree2
## entity8      entity8       alias_8         8      TRUE       tree2
## entity9      entity9       alias_9         9      TRUE       tree2
## entity10    entity10      alias_10        10      TRUE       tree2
```

To run `cbind`, **TSE**s should agree in the row dimension. If **TSE**s only differ in the row tree, the row tree and the row link data are dropped.

```
cbind(tse_a, tse_a)
```

```
## class: TreeSummarizedExperiment
## dim: 10 8
## metadata(0):
## assays(1): ''
## rownames(10): entity1 entity2 ... entity9 entity10
## rowData names(2): var1 var2
## colnames(8): sample1 sample2 ... sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (10 rows)
## rowTree: 1 phylo tree(s) (10 leaves)
## colLinks: NULL
## colTree: NULL
```

```
cbind(tse_a, tse_b)
```

```
## Warning in cbind(...): rowTree & rowLinks differ in the provided TSEs.
##  rowTree & rowLinks are dropped after 'cbind'
```

```
## class: TreeSummarizedExperiment
## dim: 10 8
## metadata(0):
## assays(1): ''
## rownames(10): entity1 entity2 ... entity9 entity10
## rowData names(2): var1 var2
## colnames(8): sample1 sample2 ... sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (10 rows)
## rowTree: 1 phylo tree(s) (10 leaves)
## colLinks: NULL
## colTree: NULL
```

# 2 Subset a **TSE** object

We obtain a subset of `tse_ab` by extracting the data on rows `11:15`. These rows are mapped to the same tree named as `phylo.1`. So, the `rowTree` slot of `sse` has only one tree.

```
(sse <- tse_ab[11:15, ])
```

```
## class: TreeSummarizedExperiment
## dim: 5 4
## metadata(0):
## assays(1): ''
## rownames(5): entity1 entity2 entity3 entity4 entity5
## rowData names(2): var1 var2
## colnames(4): sample1 sample2 sample3 sample4
## colData names(2): ID group
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (5 rows)
## rowTree: 1 phylo tree(s) (10 leaves)
## colLinks: NULL
## colTree: NULL
```

```
rowLinks(sse)
```

```
## LinkDataFrame with 5 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity1     entity1       alias_1         1      TRUE       tree2
## entity2     entity2       alias_2         2      TRUE       tree2
## entity3     entity3       alias_3         3      TRUE       tree2
## entity4     entity4       alias_4         4      TRUE       tree2
## entity5     entity5       alias_5         5      TRUE       tree2
```

`[` works not only as a getter but also a setter to replace a subset of `sse`.

```
set.seed(3)
tse_c <- makeTSE(include.colTree = FALSE)
rowTreeNames(tse_c) <- "new_tree"

# the first two rows are from tse_c, and are mapped to 'new_tree'
sse[1:2, ] <- tse_c[5:6, ]
rowLinks(sse)
```

```
## LinkDataFrame with 5 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_5         5      TRUE    new_tree
## entity6     entity6       alias_6         6      TRUE    new_tree
## entity3     entity3       alias_3         3      TRUE       tree2
## entity4     entity4       alias_4         4      TRUE       tree2
## entity5     entity5       alias_5         5      TRUE       tree2
```

The **TSE** object can be subset also by nodes or/and trees using `subsetByNodes`

```
# by tree
sse_a <- subsetByNode(x = sse, whichRowTree = "new_tree")
rowLinks(sse_a)
```

```
## LinkDataFrame with 2 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_5         5      TRUE    new_tree
## entity6     entity6       alias_6         6      TRUE    new_tree
```

```
# by node
sse_b <- subsetByNode(x = sse, rowNode = 5)
rowLinks(sse_b)
```

```
## LinkDataFrame with 2 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_5         5      TRUE    new_tree
## entity5     entity5       alias_5         5      TRUE       tree2
```

```
# by tree and node
sse_c <- subsetByNode(x = sse, rowNode = 5, whichRowTree = "tree2")
rowLinks(sse_c)
```

```
## LinkDataFrame with 1 row and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_5         5      TRUE       tree2
```

# 3 Change specific trees of **TSE**

By using `colTree`, we can add a column tree to `sse` that has no column tree before.

```
colTree(sse)
```

```
## NULL
```

```
library(ape)
set.seed(1)
col_tree <- rtree(ncol(sse))

# To use 'colTree` as a setter, the input tree should have node labels matching
# with column names of the TSE.
col_tree$tip.label <- colnames(sse)

colTree(sse) <- col_tree
colTree(sse)
```

```
##
## Phylogenetic tree with 4 tips and 3 internal nodes.
##
## Tip labels:
##   sample1, sample2, sample3, sample4
##
## Rooted; includes branch length(s).
```

`sse` has two row trees. We can replace one of them with a new tree by
specifying `whichTree` of the `rowTree`.

```
# the original row links
rowLinks(sse)
```

```
## LinkDataFrame with 5 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_5         5      TRUE    new_tree
## entity6     entity6       alias_6         6      TRUE    new_tree
## entity3     entity3       alias_3         3      TRUE       tree2
## entity4     entity4       alias_4         4      TRUE       tree2
## entity5     entity5       alias_5         5      TRUE       tree2
```

```
# the new row tree
set.seed(1)
row_tree <- rtree(4)
row_tree$tip.label <- paste0("entity", 5:7)

# replace the tree named as the 'new_tree'
nse <- sse
rowTree(nse, whichTree = "new_tree") <- row_tree
rowLinks(nse)
```

```
## LinkDataFrame with 5 rows and 5 columns
##             nodeLab nodeLab_alias   nodeNum    isLeaf   whichTree
##         <character>   <character> <integer> <logical> <character>
## entity5     entity5       alias_1         1      TRUE    new_tree
## entity6     entity6       alias_2         2      TRUE    new_tree
## entity3     entity3       alias_3         3      TRUE       tree2
## entity4     entity4       alias_4         4      TRUE       tree2
## entity5     entity5       alias_5         5      TRUE       tree2
```

In the row links, the first two rows now have new values in `nodeNum` and
`nodeLab_alias`. The name in `whichTree` is not changed but the tree is actually
updated.

```
# FALSE is expected
identical(rowTree(sse, whichTree = "new_tree"),
          rowTree(nse, whichTree = "new_tree"))
```

```
## [1] FALSE
```

```
# TRUE is expected
identical(rowTree(nse, whichTree = "new_tree"),
          row_tree)
```

```
## [1] TRUE
```

If nodes of the input tree and rows of the **TSE** are named differently, users
can match rows with nodes via `changeTree` with `rowNodeLab` provided.

# 4 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0                   ggtree_4.0.1
##  [3] ape_5.8-1                       TreeSummarizedExperiment_2.18.0
##  [5] Biostrings_2.78.0               XVector_0.50.0
##  [7] SingleCellExperiment_1.32.0     SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0                  GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0                   IRanges_2.44.0
## [13] S4Vectors_0.48.0                BiocGenerics_0.56.0
## [15] generics_0.1.4                  MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0               BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] ggiraph_0.9.2           tidyselect_1.2.1        dplyr_1.1.4
##  [4] farver_2.1.2            S7_0.2.0                fastmap_1.2.0
##  [7] lazyeval_0.2.2          fontquiver_0.2.1        digest_0.6.37
## [10] lifecycle_1.0.4         tidytree_0.4.6          magrittr_2.0.4
## [13] compiler_4.5.1          rlang_1.1.6             sass_0.4.10
## [16] tools_4.5.1             yaml_2.3.10             knitr_1.50
## [19] S4Arrays_1.10.0         labeling_0.4.3          htmlwidgets_1.6.4
## [22] DelayedArray_0.36.0     RColorBrewer_1.1-3      aplot_0.2.9
## [25] abind_1.4-8             BiocParallel_1.44.0     withr_3.0.2
## [28] purrr_1.1.0             grid_4.5.1              gdtools_0.4.4
## [31] scales_1.4.0            dichromat_2.0-0.1       tinytex_0.57
## [34] cli_3.6.5               rmarkdown_2.30          crayon_1.5.3
## [37] treeio_1.34.0           cachem_1.1.0            parallel_4.5.1
## [40] ggplotify_0.1.3         BiocManager_1.30.26     yulab.utils_0.2.1
## [43] vctrs_0.6.5             Matrix_1.7-4            jsonlite_2.0.0
## [46] fontBitstreamVera_0.1.1 bookdown_0.45           gridGraphics_0.5-1
## [49] patchwork_1.3.2         systemfonts_1.3.1       magick_2.9.0
## [52] tidyr_1.3.1             jquerylib_0.1.4         glue_1.8.0
## [55] codetools_0.2-20        gtable_0.3.6            tibble_3.3.0
## [58] pillar_1.11.1           rappdirs_0.3.3          htmltools_0.5.8.1
## [61] R6_2.6.1                evaluate_1.0.5          lattice_0.22-7
## [64] ggfun_0.2.0             fontLiberation_0.1.0    bslib_0.9.0
## [67] Rcpp_1.1.0              SparseArray_1.10.0      nlme_3.1-168
## [70] xfun_0.54               fs_1.6.6                pkgconfig_2.0.3
```

# 5 Reference