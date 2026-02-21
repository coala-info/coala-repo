# mia: Microbiome analysis tools

#### 2025-10-30

#### Package

mia 1.18.0

`mia` implements tools for microbiome analysis based on the
`SummarizedExperiment` (Morgan et al. [2020](#ref-SE)), `SingleCellExperiment` (Amezquita et al. [2020](#ref-SCE)) and
`TreeSummarizedExperiment` (Huang [2021](#ref-TSE)) infrastructure. Data wrangling and analysis
are the main scope of this package.

# 1 Installation

To install `mia`, install `BiocManager` first, if it is not installed.
Afterwards use the `install` function from `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mia")
```

# 2 Load *mia*

```
library("mia")
```

# 3 Loading a `TreeSummarizedExperiment` object

A few example datasets are available via `mia`. For this vignette the
`GlobalPatterns` dataset is loaded first.

```
data(GlobalPatterns, package = "mia")
tse <- GlobalPatterns
tse
```

```
## class: TreeSummarizedExperiment
## dim: 19216 26
## metadata(0):
## assays(1): counts
## rownames(19216): 549322 522457 ... 200359 271582
## rowData names(7): Kingdom Phylum ... Genus Species
## colnames(26): CL3 CC1 ... Even2 Even3
## colData names(7): X.SampleID Primer ... SampleType Description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (19216 rows)
## rowTree: 1 phylo tree(s) (19216 leaves)
## colLinks: NULL
## colTree: NULL
```

# 4 Functions for working with microbiome data

One of the main topics for analysing microbiome data is the application of
taxonomic data to describe features measured. The interest lies in the
connection between individual bacterial species and their relation to each
other.

`mia` does not rely on a specific object type to hold taxonomic data, but
uses specific columns in the `rowData` of a `TreeSummarizedExperiment` object.
`taxonomyRanks` can be used to construct a `character` vector of available
taxonomic levels. This can be used, for example, for subsetting.

```
# print the available taxonomic ranks
colnames(rowData(tse))
```

```
## [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"   "Species"
```

```
taxonomyRanks(tse)
```

```
## [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"   "Species"
```

```
# subset to taxonomic data only
rowData(tse)[,taxonomyRanks(tse)]
```

```
## DataFrame with 19216 rows and 7 columns
##            Kingdom        Phylum        Class        Order        Family
##        <character>   <character>  <character>  <character>   <character>
## 549322     Archaea Crenarchaeota Thermoprotei           NA            NA
## 522457     Archaea Crenarchaeota Thermoprotei           NA            NA
## 951        Archaea Crenarchaeota Thermoprotei Sulfolobales Sulfolobaceae
## 244423     Archaea Crenarchaeota        Sd-NA           NA            NA
## 586076     Archaea Crenarchaeota        Sd-NA           NA            NA
## ...            ...           ...          ...          ...           ...
## 278222    Bacteria           SR1           NA           NA            NA
## 463590    Bacteria           SR1           NA           NA            NA
## 535321    Bacteria           SR1           NA           NA            NA
## 200359    Bacteria           SR1           NA           NA            NA
## 271582    Bacteria           SR1           NA           NA            NA
##              Genus                Species
##        <character>            <character>
## 549322          NA                     NA
## 522457          NA                     NA
## 951     Sulfolobus Sulfolobusacidocalda..
## 244423          NA                     NA
## 586076          NA                     NA
## ...            ...                    ...
## 278222          NA                     NA
## 463590          NA                     NA
## 535321          NA                     NA
## 200359          NA                     NA
## 271582          NA                     NA
```

The columns are recognized case insensitive. Additional functions are
available to check for validity of taxonomic information or generate labels
based on the taxonomic information.

```
table(taxonomyRankEmpty(tse, "Species"))
```

```
##
## FALSE  TRUE
##  1413 17803
```

```
head(getTaxonomyLabels(tse))
```

```
## [1] "Class:Thermoprotei"               "Class:Thermoprotei_1"
## [3] "Species:Sulfolobusacidocaldarius" "Class:Sd-NA"
## [5] "Class:Sd-NA_1"                    "Class:Sd-NA_2"
```

For more details see the man page `?taxonomyRanks`.

## 4.1 Merging and agglomeration based on taxonomic information.

Agglomeration of data based on these taxonomic descriptors can be performed
using functions implemented in `mia`. In addition to the `aggValue` functions
provide by `TreeSummarizedExperiment` `agglomerateByRank` is available.
`agglomerateByRank` does not require tree data to be present.

`agglomerateByRank` constructs a `factor` to guide merging from the available
taxonomic information. For more information on merging have a look at the man
page via `?mergeFeatures`.

```
# agglomerate at the Family taxonomic rank
x1 <- agglomerateByRank(tse, rank = "Family")
## How many taxa before/after agglomeration?
nrow(tse)
```

```
## [1] 19216
```

```
nrow(x1)
```

```
## [1] 341
```

Tree data can also be shrunk alongside agglomeration, but this is turned of
by default.

```
# with agglomeration of the tree
x2 <- agglomerateByRank(tse, rank = "Family",
                        agglomerateTree = TRUE)
nrow(x2) # same number of rows, but
```

```
## [1] 341
```

```
rowTree(x1) # ... different
```

```
##
## Phylogenetic tree with 341 tips and 340 internal nodes.
##
## Tip labels:
##   Sulfolobaceae, SAGMA-X, Cenarchaeaceae, Nitrososphaeraceae, Halobacteriaceae, Methanosaetaceae, ...
## Node labels:
##   , 0.858.4, 0.764.3, 0.985.6, 1.000.112, 0.978.18, ...
##
## Rooted; includes branch length(s).
```

```
rowTree(x2) # ... tree
```

```
##
## Phylogenetic tree with 341 tips and 340 internal nodes.
##
## Tip labels:
##   Sulfolobaceae, SAGMA-X, Cenarchaeaceae, Nitrososphaeraceae, Halobacteriaceae, Methanosaetaceae, ...
## Node labels:
##   , 0.858.4, 0.764.3, 0.985.6, 1.000.112, 0.978.18, ...
##
## Rooted; includes branch length(s).
```

For `agglomerateByRank` to work, taxonomic data must be present. Even though
only one rank is available for the `enterotype` dataset, agglomeration can be
performed effectively de-duplicating entries for the genus level.

```
data(enterotype, package = "mia")
taxonomyRanks(enterotype)
```

```
## [1] "Genus"
```

```
agglomerateByRank(enterotype)
```

```
## class: TreeSummarizedExperiment
## dim: 551 280
## metadata(0):
## assays(1): counts
## rownames(551): Prosthecochloris Chloroflexus ... Syntrophococcus
##   Mogibacterium
## rowData names(1): Genus
## colnames(280): AM.AD.1 AM.AD.2 ... TS98_V2 TS99.2_V2
## colData names(9): Enterotype Sample_ID ... Age ClinicalStatus
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: NULL
## rowTree: NULL
## colLinks: NULL
## colTree: NULL
```

To keep data tidy, the agglomerated data can be stored as an alternative
experiment in the object of origin. With this synchronized sample subsetting
becomes very easy.

```
altExp(tse, "family") <- x2
```

Keep in mind, that if you set `empty.rm = TRUE`, rows with `NA` or similar value
(defined via the `empty.fields` argument) will be removed. Depending on these
settings different number of rows will be returned.

```
x1 <- agglomerateByRank(tse, rank = "Species", empty.rm = TRUE)
altExp(tse,"species") <- agglomerateByRank(
    tse, rank = "Species", empty.rm = FALSE)
dim(x1)
```

```
## [1] 944  26
```

```
dim(altExp(tse,"species"))
```

```
## [1] 2307   26
```

For convenience the function `agglomerateByRanks` is available, which
agglomerates data on all `ranks` selected. By default all available ranks will
be used. The output is compatible to be stored as alternative experiments.

```
tse <- agglomerateByRanks(tse)
tse
```

```
## class: TreeSummarizedExperiment
## dim: 19216 26
## metadata(0):
## assays(1): counts
## rownames(19216): 549322 522457 ... 200359 271582
## rowData names(7): Kingdom Phylum ... Genus Species
## colnames(26): CL3 CC1 ... Even2 Even3
## colData names(7): X.SampleID Primer ... SampleType Description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(9): family species ... Genus Species
## rowLinks: a LinkDataFrame (19216 rows)
## rowTree: 1 phylo tree(s) (19216 leaves)
## colLinks: NULL
## colTree: NULL
```

```
altExpNames(tse)
```

```
## [1] "family"  "species" "Kingdom" "Phylum"  "Class"   "Order"   "Family"
## [8] "Genus"   "Species"
```

## 4.2 Constructing a tree from taxonomic data

Constructing a taxonomic tree from taxonomic data stored in `rowData` is quite
straightforward and uses mostly functions implemented in
`TreeSummarizedExperiment`.

```
taxa <- rowData(altExp(tse,"Species"))[,taxonomyRanks(tse)]
taxa_res <- resolveLoop(as.data.frame(taxa))
taxa_tree <- toTree(data = taxa_res)
taxa_tree$tip.label <- getTaxonomyLabels(altExp(tse,"Species"))
rowNodeLab <- getTaxonomyLabels(altExp(tse,"Species"), make.unique = FALSE)
altExp(tse,"Species") <- changeTree(
    altExp(tse,"Species"),
    rowTree = taxa_tree,
    rowNodeLab = rowNodeLab)
```

## 4.3 Transformation of assay data

Transformation of count data stored in `assays` is also a main task when work
with microbiome data. `transformAssay` can be used for this and offers a few
choices of available transformations. A modified object is returned and the
transformed counts are stored in a new `assay`.

```
assayNames(enterotype)
```

```
## [1] "counts"
```

```
anterotype <- transformAssay(enterotype, method = "log10", pseudocount = 1)
assayNames(enterotype)
```

```
## [1] "counts"
```

For more details have a look at the man page `?transformAssay`.

Sub-sampling to equal number of counts per sample. Also known as rarefying.

```
data(GlobalPatterns, package = "mia")

tse.subsampled <- rarefyAssay(
    GlobalPatterns,
    sample = 60000,
    name = "subsampled",
    replace = TRUE,
    seed = 1938)
tse.subsampled
```

```
## class: TreeSummarizedExperiment
## dim: 12305 25
## metadata(0):
## assays(2): counts subsampled
## rownames(12305): 549322 522457 ... 200359 271582
## rowData names(7): Kingdom Phylum ... Genus Species
## colnames(25): CL3 CC1 ... Even2 Even3
## colData names(7): X.SampleID Primer ... SampleType Description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (12305 rows)
## rowTree: 1 phylo tree(s) (19216 leaves)
## colLinks: NULL
## colTree: NULL
```

Alternatively, one can save both original TreeSE and subsampled TreeSE within a
MultiAssayExperiment object.

```
library(MultiAssayExperiment)
mae <- MultiAssayExperiment(
    c("originalTreeSE" = GlobalPatterns,
    "subsampledTreeSE" = tse.subsampled))
mae
```

```
## A MultiAssayExperiment object of 2 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 2:
##  [1] originalTreeSE: TreeSummarizedExperiment with 19216 rows and 26 columns
##  [2] subsampledTreeSE: TreeSummarizedExperiment with 12305 rows and 25 columns
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
# To extract specifically the subsampled TreeSE
experiments(mae)$subsampledTreeSE
```

```
## class: TreeSummarizedExperiment
## dim: 12305 25
## metadata(0):
## assays(2): counts subsampled
## rownames(12305): 549322 522457 ... 200359 271582
## rowData names(7): Kingdom Phylum ... Genus Species
## colnames(25): CL3 CC1 ... Even2 Even3
## colData names(7): X.SampleID Primer ... SampleType Description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (12305 rows)
## rowTree: 1 phylo tree(s) (19216 leaves)
## colLinks: NULL
## colTree: NULL
```

## 4.4 Community indices

In the field of microbiome ecology several indices to describe samples and
community of samples are available. In this vignette we just want to give a
very brief introduction.

Functions for calculating alpha and beta diversity indices are available.
Using `addAlpha` multiple diversity indices are calculated by default
and results are stored automatically in `colData`. Selected indices can be
calculated individually by setting `index = "shannon"` for example.

```
tse <- addAlpha(tse, index = "shannon")
colnames(colData(tse))[8:ncol(colData(tse))]
```

```
## [1] "shannon"
```

Beta diversity indices are used to describe inter-sample connections.
Technically they are calculated as `dist` object and reduced dimensions can
be extracted using `cmdscale`. This is wrapped up in the `runMDS` function
of the `scater` package, but can be easily used to calculated beta diversity
indices using the established functions from the `vegan` package or any other
package using comparable inputs.

```
library(scater)
altExp(tse,"Genus") <- runMDS(
    altExp(tse,"Genus"),
    FUN = getDissimilarity,
    method = "bray",
    name = "BrayCurtis",
    ncomponents = 5,
    assay.type = "counts",
    keep_dist = TRUE)
```

JSD and UniFrac are implemented in `mia` as well. `getJSD` can be used
as a drop-in replacement in the example above (omit the `method` argument as
well) to calculate the JSD. For calculating the UniFrac distance via
`getUniFrac` either a `TreeSummarizedExperiment` must be used or a tree
supplied via the `tree` argument. For more details see `?getJSD`,
`?getUnifrac` or `?getDPCoA`.

`runMDS` performs the decomposition. Alternatively `addNMDS` can also be used.

## 4.5 Other indices

`estimateDominance` and `estimateEvenness` implement other sample-wise indices.
The function behave equivalently to `estimateDiversity`. For more information
see the corresponding man pages.

# 5 Utility functions

To make migration and adoption as easy as possible several utility functions
are available.

## 5.1 Data loading functions

Functions to load data from `biom` files, `QIIME2` output, `DADA2` objects
(Callahan et al. [2016](#ref-dada2)) or `phyloseq` objects are available.

```
library(phyloseq)
data(esophagus, package = "phyloseq")
```

```
esophagus
```

```
## phyloseq-class experiment-level object
## otu_table()   OTU Table:         [ 58 taxa and 3 samples ]
## phy_tree()    Phylogenetic Tree: [ 58 tips and 57 internal nodes ]
```

```
esophagus <- convertFromPhyloseq(esophagus)
esophagus
```

```
## class: TreeSummarizedExperiment
## dim: 58 3
## metadata(0):
## assays(1): counts
## rownames(58): 59_8_22 59_5_13 ... 65_9_9 59_2_6
## rowData names(0):
## colnames(3): B C D
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (58 rows)
## rowTree: 1 phylo tree(s) (58 leaves)
## colLinks: NULL
## colTree: NULL
```

For more details have a look at the man page, for examples
`?convert`.

## 5.2 General wrapper functions

Row-wise or column-wise assay data subsetting.

```
# Specific taxa
assay(tse['522457',], "counts") |> head()
```

```
##        CL3 CC1 SV1 M31Fcsw M11Fcsw M31Plmr M11Plmr F21Plmr M31Tong M11Tong
## 522457   0   0   0       0       0       0       0       0       0       0
##        LMEpi24M SLEpi20M AQC1cm AQC4cm AQC7cm NP2 NP3 NP5 TRRsed1 TRRsed2
## 522457        0        0      0      2      6   0   0   0       0       0
##        TRRsed3 TS28 TS29 Even1 Even2 Even3
## 522457       0    0    0     0     0     0
```

```
# Specific sample
assay(tse[,'CC1'], "counts") |> head()
```

```
##        CC1
## 549322   0
## 522457   0
## 951      0
## 244423   0
## 586076   0
## 246140   0
```

## 5.3 Selecting most interesting features

`getTop` returns a vector of the most `top` abundant feature IDs.

```
data(esophagus, package = "mia")
top_taxa <- getTop(
    esophagus,
    method = "mean",
    top = 5,
    assay.type = "counts")
top_taxa
```

```
## [1] "59_2_6"  "59_7_6"  "59_8_22" "59_5_19" "65_6_2"
```

## 5.4 Generating tidy data

To generate tidy data as used and required in most of the tidyverse,
`meltAssay` can be used. A `data.frame` in the long format will be returned.

```
molten_data <- meltAssay(
    tse,
    assay.type = "counts",
    add.row = TRUE,
    add.col = TRUE
)
molten_data
```

```
## # A tibble: 499,616 × 18
##    FeatureID SampleID counts Kingdom Phylum     Class Order Family Genus Species
##    <fct>     <fct>     <dbl> <chr>   <chr>      <chr> <chr> <chr>  <chr> <chr>
##  1 549322    CL3           0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  2 549322    CC1           0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  3 549322    SV1           0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  4 549322    M31Fcsw       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  5 549322    M11Fcsw       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  6 549322    M31Plmr       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  7 549322    M11Plmr       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  8 549322    F21Plmr       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
##  9 549322    M31Tong       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
## 10 549322    M11Tong       0 Archaea Crenarcha… Ther… <NA>  <NA>   <NA>  <NA>
## # ℹ 499,606 more rows
## # ℹ 8 more variables: X.SampleID <fct>, Primer <fct>, Final_Barcode <fct>,
## #   Barcode_truncated_plus_T <fct>, Barcode_full_length <fct>,
## #   SampleType <fct>, Description <fct>, shannon <dbl>
```

# 6 Session info

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
##  [1] phyloseq_1.54.0                 scater_1.38.0
##  [3] ggplot2_4.0.0                   scuttle_1.20.0
##  [5] mia_1.18.0                      TreeSummarizedExperiment_2.18.0
##  [7] Biostrings_2.78.0               XVector_0.50.0
##  [9] SingleCellExperiment_1.32.0     MultiAssayExperiment_1.36.0
## [11] SummarizedExperiment_1.40.0     Biobase_2.70.0
## [13] GenomicRanges_1.62.0            Seqinfo_1.0.0
## [15] IRanges_2.44.0                  S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0             generics_0.1.4
## [19] MatrixGenerics_1.22.0           matrixStats_1.5.0
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              TH.data_1.1-4
##   [5] estimability_1.5.1          ggbeeswarm_0.7.2
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] fs_1.6.6                    ragg_1.5.0
##  [11] vctrs_0.6.5                 multtest_2.66.0
##  [13] DelayedMatrixStats_1.32.0   htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             BiocBaseUtils_1.12.0
##  [17] BiocNeighbors_2.4.0         Rhdf5lib_1.32.0
##  [19] cellranger_1.1.0            rhdf5_2.54.0
##  [21] SparseArray_1.10.0          sass_0.4.10
##  [23] parallelly_1.45.1           bslib_0.9.0
##  [25] plyr_1.8.9                  DECIPHER_3.6.0
##  [27] sandwich_3.1-1              emmeans_2.0.0
##  [29] zoo_1.8-14                  cachem_1.1.0
##  [31] igraph_2.2.1                iterators_1.0.14
##  [33] lifecycle_1.0.4             pkgconfig_2.0.3
##  [35] rsvd_1.0.5                  Matrix_1.7-4
##  [37] R6_2.6.1                    fastmap_1.2.0
##  [39] digest_0.6.37               ggnewscale_0.5.2
##  [41] patchwork_1.3.2             irlba_2.3.5.1
##  [43] textshaping_1.0.4           vegan_2.7-2
##  [45] beachmat_2.26.0             mgcv_1.9-3
##  [47] abind_1.4-8                 compiler_4.5.1
##  [49] withr_3.0.2                 S7_0.2.0
##  [51] BiocParallel_1.44.0         viridis_0.6.5
##  [53] DBI_1.2.3                   MASS_7.3-65
##  [55] rappdirs_0.3.3              DelayedArray_0.36.0
##  [57] biomformat_1.38.0           bluster_1.20.0
##  [59] permute_0.9-8               tools_4.5.1
##  [61] vipor_0.4.7                 beeswarm_0.4.0
##  [63] ape_5.8-1                   glue_1.8.0
##  [65] rhdf5filters_1.22.0         nlme_3.1-168
##  [67] gridtext_0.1.5              grid_4.5.1
##  [69] ade4_1.7-23                 cluster_2.1.8.1
##  [71] reshape2_1.4.4              gtable_0.3.6
##  [73] fillpattern_1.0.2           tzdb_0.5.0
##  [75] tidyr_1.3.1                 data.table_1.17.8
##  [77] hms_1.1.4                   utf8_1.2.6
##  [79] BiocSingular_1.26.0         ScaledMatrix_1.18.0
##  [81] xml2_1.4.1                  foreach_1.5.2
##  [83] ggrepel_0.9.6               pillar_1.11.1
##  [85] stringr_1.5.2               yulab.utils_0.2.1
##  [87] splines_4.5.1               dplyr_1.1.4
##  [89] ggtext_0.1.2                treeio_1.34.0
##  [91] lattice_0.22-7              survival_3.8-3
##  [93] tidyselect_1.2.1            DirichletMultinomial_1.52.0
##  [95] knitr_1.50                  gridExtra_2.3
##  [97] bookdown_0.45               xfun_0.53
##  [99] rbiom_2.2.1                 stringi_1.8.7
## [101] lazyeval_0.2.2              yaml_2.3.10
## [103] evaluate_1.0.5              codetools_0.2-20
## [105] tibble_3.3.0                BiocManager_1.30.26
## [107] cli_3.6.5                   xtable_1.8-4
## [109] systemfonts_1.3.1           jquerylib_0.1.4
## [111] dichromat_2.0-0.1           Rcpp_1.1.0
## [113] readxl_1.4.5                coda_0.19-4.1
## [115] parallel_4.5.1              readr_2.1.5
## [117] sparseMatrixStats_1.22.0    decontam_1.30.0
## [119] viridisLite_0.4.2           mvtnorm_1.3-3
## [121] slam_0.1-55                 tidytree_0.4.6
## [123] scales_1.4.0                purrr_1.1.0
## [125] crayon_1.5.3                rlang_1.1.6
## [127] multcomp_1.4-29
```

# References

Amezquita, Robert, Aaron Lun, Etienne Becht, Vince Carey, Lindsay Carpp, Ludwig Geistlinger, Federico Marini, et al. 2020. “Orchestrating Single-Cell Analysis with Bioconductor.” *Nature Methods* 17: 137–45. <https://www.nature.com/articles/s41592-019-0654-x>.

Callahan, Benjamin J, Paul J McMurdie, Michael J Rosen, Andrew W Han, Amy Jo A Johnson, and Susan P Holmes. 2016. “DADA2: High-Resolution Sample Inference from Illumina Amplicon Data.” *Nature Methods* 13: 581–83. <https://doi.org/10.1038/nmeth.3869>.

Huang, Ruizhu. 2021. *TreeSummarizedExperiment: TreeSummarizedExperiment: A S4 Class for Data with Tree Structures*.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2020. *SummarizedExperiment: SummarizedExperiment Container*. <https://bioconductor.org/packages/SummarizedExperiment>.