# StabMap: Stabilised mosaic single cell data integration using unshared features

Shila Ghazanfar, Nick Robertson and Aiden Jin

#### 30 October 2025

#### Package

StabMap 1.4.0

```
library(StabMap)
library(magrittr)

library(scater)
library(scran)
library(SingleCellMultiModal)
library(gridExtra)
```

```
set.seed(2024)
```

# 1 Introduction

StabMap is a technique for performing mosaic single cell data integration.
Mosaic data integration presents the challenge of integration of data where
only some features or cells are shared across datasets. For example, these
challenges arise when integrating single-cell datasets that measure different
molecular profiles, such as chromatin accessibility or RNA expression assays.
Integrative analysis of such data may provide a more in-depth profile of each
cell, facilitating downstream analysis. To read more about StabMap please see
our [paper on Nature Biotechnology](https://www.nature.com/articles/s41587-023-01766-z).

## 1.1 Vignette Goals

In this vignette we will elaborate on how mosaic single cell data integration
is implemented in the `StabMap` package. We address a few key goals:

* Mosaic Data integration for 2 datasets
* Demonstrating cell imputation following integration
* Indirect mosaic data integration for 3 datasets, including 2 non-overlapping
  datasets

# 2 Load data

In this tutorial we will work with a multi-assay single cell dataset, consisting
of ATAC and gene expression data for 10,032 cells.

```
mae <- scMultiome(
  "pbmc_10x",
  mode = "*", dry.run = FALSE, format = "MTX", verbose = TRUE
)
```

Perform some exploration of this data.

```
mae
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] atac: SingleCellExperiment with 108344 rows and 10032 columns
##  [2] rna: SingleCellExperiment with 36549 rows and 10032 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

```
upsetSamples(mae)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the UpSetR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
head(colData(mae))
```

```
## DataFrame with 6 rows and 6 columns
##                  nCount_RNA nFeature_RNA nCount_ATAC nFeature_ATAC
##                   <integer>    <integer>   <integer>     <integer>
## AAACAGCCAAGGAATC       8380         3308       55582         13878
## AAACAGCCAATCCCTT       3771         1896       20495          7253
## AAACAGCCAATGCGCT       6876         2904       16674          6528
## AAACAGCCAGTAGGTG       7614         3061       39454         11633
## AAACAGCCAGTTTACG       3633         1691       20523          7245
## AAACAGCCATCCAGGT       7782         3028       22412          8602
##                                celltype broad_celltype
##                             <character>    <character>
## AAACAGCCAAGGAATC      naive CD4 T cells       Lymphoid
## AAACAGCCAATCCCTT     memory CD4 T cells       Lymphoid
## AAACAGCCAATGCGCT      naive CD4 T cells       Lymphoid
## AAACAGCCAGTAGGTG      naive CD4 T cells       Lymphoid
## AAACAGCCAGTTTACG     memory CD4 T cells       Lymphoid
## AAACAGCCATCCAGGT non-classical monocy..        Myeloid
```

```
dim(experiments(mae)[["rna"]])
```

```
## [1] 36549 10032
```

```
names(experiments(mae))
```

```
## [1] "atac" "rna"
```

Keep the first 2,000 cells only. Normalise and select variable features for the
RNA modality.

```
sce.rna <- experiments(mae)[["rna"]]

# Normalisation
sce.rna <- logNormCounts(sce.rna)

# Feature selection
decomp <- modelGeneVar(sce.rna)
hvgs <- rownames(decomp)[decomp$mean > 0.01 & decomp$p.value <= 0.05]

length(hvgs)
```

```
## [1] 952
```

```
sce.rna <- sce.rna[hvgs, ]
```

Keep the first 2,000 cells only. Normalise and select variable features for the ATAC modality.

```
dim(experiments(mae)[["atac"]])
```

```
## [1] 108344  10032
```

```
sce.atac <- experiments(mae)[["atac"]]

# Normalise
sce.atac <- logNormCounts(sce.atac)

# Feature selection using highly variable peaks
# And adding matching peaks to genes
decomp <- modelGeneVar(sce.atac)
hvgs <- rownames(decomp)[decomp$mean > 0.25 &
  decomp$p.value <= 0.05]
length(hvgs)
```

```
## [1] 788
```

```
sce.atac <- sce.atac[hvgs, ]
```

Create a composite full data matrix by concatenating.

```
logcounts_all <- rbind(logcounts(sce.rna), logcounts(sce.atac))
dim(logcounts_all)
```

```
## [1]  1740 10032
```

```
assayType <- ifelse(rownames(logcounts_all) %in% rownames(sce.rna),
  "rna", "atac"
)
table(assayType)
```

```
## assayType
## atac  rna
##  788  952
```

# 3 Mosaic data integration with StabMap

We will simulate a situation where half of the cells correspond to the Multiome
(RNA + ATAC features) modality, and half of the cells correspond to the RNA modality.
Our goal is to then integrate both datasets by generating a joint embedding of
the cells using all data, and to impute the missing ATAC cell values from the RNA
modality cells.

```
dataType <- setNames(
  sample(c("RNA", "Multiome"), ncol(logcounts_all),
    prob = c(0.5, 0.5), replace = TRUE
  ),
  colnames(logcounts_all)
)
table(dataType)
```

```
## dataType
## Multiome      RNA
##     5025     5007
```

```
assay_list <- list(
  RNA = logcounts_all[assayType %in% c("rna"), dataType %in% c("RNA")],
  Multiome = logcounts_all[
    assayType %in% c("rna", "atac"), dataType %in% c("Multiome")
  ]
)

lapply(assay_list, dim)
```

```
## $RNA
## [1]  952 5007
##
## $Multiome
## [1] 1740 5025
```

```
lapply(assay_list, class)
```

```
## $RNA
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
##
## $Multiome
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
```

Examine the shared features between the two datasets using `mosaicDataUpSet()`.

```
mosaicDataUpSet(assay_list, plot = FALSE)
```

![](data:image/png;base64...)

From this we note that there are shared features between the RNA and Multiome
datasets, but there are many features that are observed only in the Multiome
dataset and not the RNA - as we had constructed.

We can understand the `mosaicDataTopology()` of these datasets, which
generates an `igraph` object, which can be inspected and plotted.
The `mosaicDataTopology()` is a weighted network where nodes represent each
dataset, and edges connect nodes with at least one overlapping feature.

```
mdt <- mosaicDataTopology(assay_list)
mdt
```

```
## IGRAPH d9d89ee UN-- 2 1 --
## + attr: name (v/c), frame.color (v/c), color (v/c), label.color (v/c),
## | label.family (v/c)
## + edge from d9d89ee (vertex names):
## [1] RNA--Multiome
```

```
plot(mdt)
```

![](data:image/png;base64...)

From this we note that the datasets RNA and Multiome share at least some
features. StabMap requires that the mosaic data topology network be connected,
that is, that there should be a path between every pair of nodes in the network.

We now aim to integrate the data from the RNA and Multiome modality by generating
a common joint embedding for these data using `stabMap()`. The `stabMap()` integration
approach aims to stabilize integration of single-cell data by exploting the
non-overlapping features, so that cells with similar biological profiles will
cluster. Stabilisation using non-overlapping features may be important
when there are limited overlapping features or when the informative features are
unknown.

**What is `stabMap` doing?**
`stabMap` generates a joint embedding using 3 steps:

* Identify the `mosaicDataTopology()`
* Embed the reference dataset into a lower dimensional space
* Project cells from non-reference datasets onto the reference dataset embedding
  by using a model to traverse shortest paths in the `mosaicDataTopology()`

Since the Multiome data contains all features, we treat this as the reference dataset.
Since we already examined the mosaic data topology, we set `plot = FALSE`.

```
stab <- stabMap(assay_list,
  reference_list = c("Multiome"),
  plot = FALSE
)
```

```
## treating "Multiome" as reference
```

```
## generating embedding for path with reference "Multiome": "Multiome"
```

```
## generating embedding for path with reference "Multiome": "RNA" -> "Multiome"
```

```
dim(stab)
```

```
## [1] 10032    50
```

```
stab[1:5, 1:5]
```

```
##                  Multiome_PC1 Multiome_PC2 Multiome_PC3 Multiome_PC4
## AAACAGCCAATCCCTT    12.885344    -3.075968    -1.723863   -0.3561525
## AAACAGCCAGTTTACG    11.314093    -2.344855     2.608507    1.2228681
## AAACATGCAAGGTCCT    13.821325    -3.100703     4.755135   -0.6836924
## AAACATGCACCGGCTA     6.287519    -2.080285   -24.802926   -0.6373922
## AAACATGCAGCAAGTG    12.500354    -3.058831     5.358400   -2.6757611
##                  Multiome_PC5
## AAACAGCCAATCCCTT   -4.6468061
## AAACAGCCAGTTTACG   -8.5576292
## AAACATGCAAGGTCCT    6.0538837
## AAACATGCACCGGCTA    7.1583625
## AAACATGCAGCAAGTG   -0.1806992
```

We can reduce the dimension further using non-linear approaches such as UMAP.

```
stab_umap <- calculateUMAP(t(stab))
dim(stab_umap)
```

```
## [1] 10032     2
```

```
plot(stab_umap, pch = 16, cex = 0.3, col = factor(dataType[rownames(stab)]))
```

![](data:image/png;base64...)

Here we see that the RNA and Multiome cells are fairly well-mixed.

# 4 Data imputation after StabMap

Given the joint embedding, we can predict the missing ATAC cell values using
`imputeEmbedding()`. We use `imputeEmbedding()` for demonstration purposes as
for our data both modalities have sufficient sample sizes (cells) and thus
cellular imputation isn’t needed.

To `imputeEmbedding()` we provide the data list, and the joint embedding as output
from `stabMap()`. We set the Multiome cells as reference and the RNA cells as
query. This is useful for downstream visualisation or further interpretation.

```
imp <- imputeEmbedding(
  assay_list,
  stab,
  reference = colnames(assay_list[["Multiome"]]),
  query = colnames(assay_list[["RNA"]])
)

class(imp)
```

```
## [1] "list"
```

```
names(imp)
```

```
## [1] "Multiome"
```

```
lapply(imp, dim)
```

```
## $Multiome
## [1] 1740 5007
```

```
lapply(assay_list, dim)
```

```
## $RNA
## [1]  952 5007
##
## $Multiome
## [1] 1740 5025
```

```
imp[["Multiome"]][1:5, 1:5]
```

```
## 5 x 5 sparse Matrix of class "dgCMatrix"
##        AAACAGCCAAGGAATC AAACAGCCAATGCGCT AAACAGCCAGTAGGTG AAACAGCCATCCAGGT
## CA6            1.299581         1.338925         1.075695                .
## CNR2           .                .                .                       .
## IFNLR1         .                .                .                       .
## RCAN3          1.414502         1.553737         1.656583                .
## ZNF683         .                .                .                       .
##        AAACATGCACTTGTTC
## CA6                   .
## CNR2                  .
## IFNLR1                .
## RCAN3                 .
## ZNF683                .
```

# 5 Annotating Query Datasets using the StabMap embedding

We can also leverage this joint embedding to annotate the query data.
We will use a k-nearest neighbors (KNN) based algorithm to
transfer cell type labels from the reference to the query dataset. For our
demonstration we will treat the Multiome dataset as the reference and the RNA
dataset as the query.

The column data of the single cell experiments objects contained in `mae`
contain cell type annotations for each cell in the `celltype` column. We first
extract cell type annotations for our reference dataset (Multiome).

```
annotation <- "celltype"
referenceLabels <- colData(
  experiments(mae)[["rna"]]
)[colnames(assay_list$Multiome), annotation]
names(referenceLabels) <- colnames(assay_list$Multiome)

table(referenceLabels)
```

```
## referenceLabels
##  CD56 (bright) NK cells     CD56 (dim) NK cells            MAIT T cells
##                     189                     217                      49
##     classical monocytes    effector CD8 T cells  intermediate monocytes
##                     987                     205                     344
##          memory B cells      memory CD4 T cells              myeloid DC
##                     207                     792                     105
##           naive B cells       naive CD4 T cells       naive CD8 T cells
##                     152                     745                     783
## non-classical monocytes         plasmacytoid DC
##                     199                      51
```

To classify query cells based on a reference dataset we can use the
`classifyEmbedding()` function. We provide the joint embedding generated by
`stabMap()` and cell type labels for the reference dataset to the
`classifyEmbedding()` function. `classifyEmbedding()` returns a dataframe with predicted
labels in the `predicted_labels` column.

```
knn_out <- classifyEmbedding(
  stab,
  referenceLabels,
)
```

As we have simulated out datasets we have the true label annotations for the RNA
(query) cells. We can evaluate how well our predicted annotations match the true
annotations use a measure such as accuracy.

```
# Extract query labels
queryLabels <- colData(
  experiments(mae)[["rna"]]
)[colnames(assay_list$RNA), annotation]
names(queryLabels) <- colnames(assay_list$RNA)

acc <- mean(queryLabels == knn_out[names(queryLabels), "predicted_labels"])
acc
```

```
## [1] 0.9203116
```

Since both the reference and query cells are embedded in the same low
dimensional space we can also visualise their cells together. Here we present a
UMAP visualisation colour coded by their cell types.

```
# Extract reference and query cells from UMAP embedding
stab_umap_ref <- stab_umap[colnames(assay_list$Multiome), ]
stab_umap_query <- stab_umap[colnames(assay_list$RNA), ]

# Create UMAP for reference cells
df_umap_ref <- data.frame(
  x = stab_umap_ref[, 1],
  y = stab_umap_ref[, 2],
  cell_type = referenceLabels[rownames(stab_umap_ref)]
)

p_ref <- df_umap_ref %>%
  ggplot() +
  aes(x = x, y = y, colour = cell_type) +
  geom_point(size = 1) +
  ggtitle("Reference cell type annotation")

# Create UMAP for query cells
df_umap_query <- data.frame(
  x = stab_umap_query[, 1],
  y = stab_umap_query[, 2],
  cell_type = queryLabels[rownames(stab_umap_query)]
)

p_query <- df_umap_query %>%
  ggplot() +
  aes(x = x, y = y, colour = cell_type) +
  geom_point(size = 1) +
  ggtitle("Query predicted cell types")

grid.arrange(p_ref, p_query, ncol = 2)
```

![](data:image/png;base64...)

# 6 Indirect mosaic data integration with StabMap

StabMap is a flexible framework for mosaic data integration, and can still
integrate data even when there are pairs of datasets that share no features at
all. So long as there is a path connecting the datasets along the mosaic data
topology (and the underlying assumption that the shared features along these
paths contain information), then we can extract meaningful joint embeddings. To
demonstrate this, we will simulate three data sources.

```
dataTypeIndirect <- setNames(
  sample(c("RNA", "Multiome", "ATAC"), ncol(logcounts_all),
    prob = c(0.3, 0.3, 0.3), replace = TRUE
  ),
  colnames(logcounts_all)
)
table(dataTypeIndirect)
```

```
## dataTypeIndirect
##     ATAC Multiome      RNA
##     3407     3354     3271
```

```
assay_list_indirect <- list(
  RNA = logcounts_all[assayType %in% c("rna"), dataTypeIndirect %in% c("RNA")],
  Multiome = logcounts_all[
    assayType %in% c("rna", "atac"), dataTypeIndirect %in% c("Multiome")
  ],
  ATAC = logcounts_all[
    assayType %in% c("atac"), dataTypeIndirect %in% c("ATAC")
  ]
)

lapply(assay_list_indirect, dim)
```

```
## $RNA
## [1]  952 3271
##
## $Multiome
## [1] 1740 3354
##
## $ATAC
## [1]  788 3407
```

```
lapply(assay_list_indirect, class)
```

```
## $RNA
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
##
## $Multiome
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
##
## $ATAC
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
```

Using `mosaicDataUpSet()`, we note that there are no shared features between
the ATAC and RNA datasets. For their integration we might be able to match features by extracting
genomic positions and making the “central dogma assumption”, that is, that the
peaks associated with a genomic position overlapping a gene should correspond to
positive gene expression for that gene. However, using `stabMap()` we need not make this
assumption for the data integration to be performed.

```
mosaicDataUpSet(assay_list_indirect, plot = FALSE)
```

![](data:image/png;base64...)

We can understand the `mosaicDataTopology()` of these datasets, which
generates an `igraph` object, which can be inspected and plotted.

```
mdt_indirect <- mosaicDataTopology(assay_list_indirect)
mdt_indirect
```

```
## IGRAPH 375e28e UN-- 3 2 --
## + attr: name (v/c), frame.color (v/c), color (v/c), label.color (v/c),
## | label.family (v/c)
## + edges from 375e28e (vertex names):
## [1] RNA     --Multiome Multiome--ATAC
```

```
plot(mdt_indirect)
```

![](data:image/png;base64...)

StabMap only requires that the mosaic data topology network be connected,
that is, that there should be a path between every pair of nodes in the network.
While ATAC and RNA have no overlapping features, since there is a path between
RNA and ATAC (via Multiome), we can proceed.

We now generate a common joint embedding for these data using `stabMap()`. Since the
Multiome data contains all features, we again treat this as the reference
dataset. Since we already examined the mosaic data topology, we set
`plot = FALSE`.

```
stab_indirect <- stabMap(assay_list_indirect,
  reference_list = c("Multiome"),
  plot = FALSE
)
```

```
## treating "Multiome" as reference
```

```
## generating embedding for path with reference "Multiome": "Multiome"
```

```
## generating embedding for path with reference "Multiome": "RNA" -> "Multiome"
```

```
## generating embedding for path with reference "Multiome": "ATAC" -> "Multiome"
```

```
dim(stab_indirect)
```

```
## [1] 10032    50
```

```
stab_indirect[1:5, 1:5]
```

```
##                  Multiome_PC1 Multiome_PC2 Multiome_PC3 Multiome_PC4
## AAACAGCCAATCCCTT     12.55432     3.107860     1.502873   0.28139555
## AAACATGCACTTGTTC      9.23886     1.023749    -2.935769   0.03841815
## AAACCAACACTAAGAA     15.64555     3.406169    -6.186476   0.05686574
## AAACCAACAGGATGGC     11.12493     1.921449    -1.672330  -0.68519801
## AAACCAACATTGTGCA    -22.05879     3.163807    -1.913256  -0.61686372
##                  Multiome_PC5
## AAACAGCCAATCCCTT   4.77024069
## AAACATGCACTTGTTC  -0.08789961
## AAACCAACACTAAGAA  -0.19636234
## AAACCAACAGGATGGC   5.94068549
## AAACCAACATTGTGCA   0.37896876
```

We can reduce the dimension further using non-linear approaches such as UMAP.

```
stab_indirect_umap <- calculateUMAP(t(stab_indirect))
dim(stab_indirect_umap)
```

```
## [1] 10032     2
```

```
plot(stab_indirect_umap,
  pch = 16, cex = 0.3,
  col = factor(dataTypeIndirect[rownames(stab_indirect)])
)
```

![](data:image/png;base64...)

Here we see that the RNA, ATAC and Multiome cells are fairly well-mixed.

Colouring the cells by their original cell type, we can also see that the
mosaic data integration is meaningful.

```
cellType <- setNames(mae$celltype, colnames(mae[[1]]))

plot(stab_indirect_umap,
  pch = 16, cex = 0.3,
  col = factor(cellType[rownames(stab_indirect)])
)
```

![](data:image/png;base64...)

**Session Info**

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
##  [1] gridExtra_2.3               SingleCellMultiModal_1.21.4
##  [3] MultiAssayExperiment_1.36.0 scran_1.38.0
##  [5] scater_1.38.0               ggplot2_4.0.0
##  [7] scuttle_1.20.0              SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] magrittr_2.0.4              StabMap_1.4.0
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                httr2_1.2.1              rlang_1.1.6
##   [4] RcppAnnoy_0.0.22         compiler_4.5.1           RSQLite_2.4.3
##   [7] png_0.1-8                vctrs_0.6.5              SpatialExperiment_1.20.0
##  [10] crayon_1.5.3             pkgconfig_2.0.3          fastmap_1.2.0
##  [13] magick_2.9.0             dbplyr_2.5.1             XVector_0.50.0
##  [16] labeling_0.4.3           rmarkdown_2.30           ggbeeswarm_0.7.2
##  [19] UpSetR_1.4.0             tinytex_0.57             purrr_1.1.0
##  [22] bit_4.6.0                xfun_0.53                bluster_1.20.0
##  [25] cachem_1.1.0             beachmat_2.26.0          jsonlite_2.0.0
##  [28] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
##  [31] Rhdf5lib_1.32.0          BiocParallel_1.44.0      irlba_2.3.5.1
##  [34] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
##  [37] bslib_0.9.0              RColorBrewer_1.1-3       limma_3.66.0
##  [40] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
##  [43] knitr_1.50               BiocBaseUtils_1.12.0     Matrix_1.7-4
##  [46] igraph_2.2.1             tidyselect_1.2.1         dichromat_2.0-0.1
##  [49] abind_1.4-8              yaml_2.3.10              viridis_0.6.5
##  [52] codetools_0.2-20         curl_7.0.0               plyr_1.8.9
##  [55] lattice_0.22-7           tibble_3.3.0             KEGGREST_1.50.0
##  [58] withr_3.0.2              S7_0.2.0                 evaluate_1.0.5
##  [61] BiocFileCache_3.0.0      ExperimentHub_3.0.0      Biostrings_2.78.0
##  [64] filelock_1.0.3           pillar_1.11.1            BiocManager_1.30.26
##  [67] BiocVersion_3.22.0       sparseMatrixStats_1.22.0 scales_1.4.0
##  [70] slam_0.1-55              glue_1.8.0               metapod_1.18.0
##  [73] tools_4.5.1              AnnotationHub_4.0.0      BiocNeighbors_2.4.0
##  [76] ScaledMatrix_1.18.0      locfit_1.5-9.12          rhdf5_2.54.0
##  [79] grid_4.5.1               AnnotationDbi_1.72.0     edgeR_4.8.0
##  [82] HDF5Array_1.38.0         beeswarm_0.4.0           BiocSingular_1.26.0
##  [85] vipor_0.4.7              cli_3.6.5                rsvd_1.0.5
##  [88] rappdirs_0.3.3           S4Arrays_1.10.0          viridisLite_0.4.2
##  [91] dplyr_1.1.4              uwot_0.2.3               gtable_0.3.6
##  [94] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
##  [97] ggrepel_0.9.6            dqrng_0.4.1              rjson_0.2.23
## [100] farver_2.1.2             memoise_2.0.1            htmltools_0.5.8.1
## [103] lifecycle_1.0.4          h5mread_1.2.0            httr_1.4.7
## [106] statmod_1.5.1            bit64_4.6.0-1
```