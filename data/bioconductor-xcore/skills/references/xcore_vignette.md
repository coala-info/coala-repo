# xcore vignette

migdal

#### 30 October 2025

#### Package

xcore 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Gene expression modeling in context of rinderpest infection](#gene-expression-modeling-in-context-of-rinderpest-infection)
  + [3.0.1 Computational resources consideration](#computational-resources-consideration)
  + [3.0.2 Parallel computing](#parallel-computing)
* [4 Constructing molecular signatures](#constructing-molecular-signatures)

# 1 Introduction

`xcore` package provides a framework for transcription factor (TF) activity
modeling based on their molecular signatures and user’s gene expression data.
Additionally, `xcoredata` package provides a collection of pre-processed TF
molecular signatures constructed from ChiP-seq experiments available in
[ReMap2020](www.remap2020.univ-amu.fr) or [ChIP-Atlas](www.chip-atlas.org)
databases.

![](data:image/png;base64...)

xcore flow chart

`xcore` use ridge regression to model changes in expression as a linear
combination of molecular signatures and find their unknown activities. Obtained,
estimates can be further tested for significance to select molecular signatures
with the highest predicted effect on the observed expression changes.

# 2 Installation

You can install `xcore` package from Bioconductor:

```
BiocManager::install("xcore")
```

# 3 Gene expression modeling in context of rinderpest infection

```
library("xcore")
```

Here we will use a subset of 293SLAM rinderpest infection dataset from
[FANTOM5](https://fantom.gsc.riken.jp/5/sstar/Rinderpest_infection_series).
This subset contains expression counts for 0, 12 and 24 hours post infection
samples and only for a subset of FANTOM5 promoters. We can find this example
data shipped together with `xcore` package.

This is a simple count matrix, with columns corresponding to samples and rows
corresponding to FANTOM5 promoters.

```
data("rinderpest_mini")
head(rinderpest_mini)
```

```
##                                              00hr_rep1 00hr_rep2 00hr_rep3
## hg19::chr1:10003372..10003465,-;hg_10258.1          52        46        57
## hg19::chr1:10003486..10003551,+;hg_541.1            39        42        27
## hg19::chr1:100111580..100111773,+;hg_4181.1          1         0         2
## hg19::chr1:100232177..100232198,-;hg_13495.1        15         9        26
## hg19::chr1:100315613..100315691,+;hg_4187.1         95       109       110
## hg19::chr1:100435545..100435597,+;hg_4201.1        141       129       101
##                                              12hr_rep1 12hr_rep2 12hr_rep3
## hg19::chr1:10003372..10003465,-;hg_10258.1          54        50        53
## hg19::chr1:10003486..10003551,+;hg_541.1            35        30        40
## hg19::chr1:100111580..100111773,+;hg_4181.1          1         2         3
## hg19::chr1:100232177..100232198,-;hg_13495.1        20        16        13
## hg19::chr1:100315613..100315691,+;hg_4187.1        112        94       103
## hg19::chr1:100435545..100435597,+;hg_4201.1        132       106       125
##                                              24hr_rep1 24hr_rep2 24hr_rep3
## hg19::chr1:10003372..10003465,-;hg_10258.1          11        12        12
## hg19::chr1:10003486..10003551,+;hg_541.1            22        34        50
## hg19::chr1:100111580..100111773,+;hg_4181.1          0         1         1
## hg19::chr1:100232177..100232198,-;hg_13495.1         7        13        10
## hg19::chr1:100315613..100315691,+;hg_4187.1         43        74        89
## hg19::chr1:100435545..100435597,+;hg_4201.1         84       100       121
```

First we need to construct a design matrix describing our experiment design.

```
design <- matrix(
  data = c(1, 0, 0,
           1, 0, 0,
           1, 0, 0,
           0, 1, 0,
           0, 1, 0,
           0, 1, 0,
           0, 0, 1,
           0, 0, 1,
           0, 0, 1),
  ncol = 3,
  nrow = 9,
  byrow = TRUE,
  dimnames = list(
    c(
      "00hr_rep1",
      "00hr_rep2",
      "00hr_rep3",
      "12hr_rep1",
      "12hr_rep2",
      "12hr_rep3",
      "24hr_rep1",
      "24hr_rep2",
      "24hr_rep3"
    ),
    c("00hr", "12hr", "24hr")
  )
)

print(design)
```

```
##           00hr 12hr 24hr
## 00hr_rep1    1    0    0
## 00hr_rep2    1    0    0
## 00hr_rep3    1    0    0
## 12hr_rep1    0    1    0
## 12hr_rep2    0    1    0
## 12hr_rep3    0    1    0
## 24hr_rep1    0    0    1
## 24hr_rep2    0    0    1
## 24hr_rep3    0    0    1
```

Next, we need to preprocess the counts using `prepareCountsForRegression`
function. Here, CAGE expression tags for each sample are filtered for lowly
expressed promoters, normalized for the library size and transformed into counts
per million (CPM). Finally, CPM are log2 transformed with addition of pseudo
count 1. Moreover, we designate the base level samples, 0 hours after treatment
in our example, from which basal expression level is calculated. This basal
level will be used as a reference when modeling the expression changes.

```
mae <- prepareCountsForRegression(counts = rinderpest_mini,
                                  design = design,
                                  base_lvl = "00hr")
```

`xcore` models the expression as a function of molecular signatures. Such
signatures can be constructed eg. from the known transcription factor binding
sites (see [Constructing molecular signatures](#constructing-molecular-signatures) section). Here, we will take
advantage of pre-computed molecular signatures found in the `xcoredata` package.
Particularly, molecular signatures constructed from ReMap2020 against FANTOM5
annotation.

Molecular signatures can be conveniently accessed using the *ExperimentHub*
interface.

```
library("ExperimentHub")

eh <- ExperimentHub()
query(eh, "xcoredata")
```

```
## ExperimentHub with 8 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: ReMap, RIKEN, NA, ChIP-Atlas
## # $species: Homo sapiens, NA
## # $rdataclass: dgCMatrix, data.table, character, GRanges
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH7298"]]'
##
##            title
##   EH7298 | chip_atlas_meta
##   EH7299 | remap_meta
##   EH7300 | chip_atlas_promoters_f5
##   EH7301 | remap_promoters_f5
##   EH7302 | promoters_f5
##   EH7303 | promoters_f5_core
##   EH7699 | entrez2fantom
##   EH7700 | symbol2fantom
```

```
remap_promoters_f5 <- eh[["EH7301"]]
```

Molecular signature is a simple binary matrix indicating if a transcription factor
binding site was found or not found in promoter vicinity.

```
print(remap_promoters_f5[3:6, 3:6])
```

```
## 4 x 4 sparse Matrix of class "dgCMatrix"
##                                             MLLT1.GM12878.ENCSR552XSN
## hg19::chr1:10003372..10003465,-;hg_10258.1                          1
## hg19::chr1:10003486..10003551,+;hg_541.1                            1
## hg19::chr1:100110807..100110818,+;hg_4172.1                         1
## hg19::chr1:100110851..100110860,+;hg_4173.1                         1
##                                             ZBTB10.HEK293.ENCSR004PLU
## hg19::chr1:10003372..10003465,-;hg_10258.1                          1
## hg19::chr1:10003486..10003551,+;hg_541.1                            1
## hg19::chr1:100110807..100110818,+;hg_4172.1                         .
## hg19::chr1:100110851..100110860,+;hg_4173.1                         .
##                                             ZFP3.HEK293.ENCSR134QIE
## hg19::chr1:10003372..10003465,-;hg_10258.1                        .
## hg19::chr1:10003486..10003551,+;hg_541.1                          .
## hg19::chr1:100110807..100110818,+;hg_4172.1                       .
## hg19::chr1:100110851..100110860,+;hg_4173.1                       .
##                                             ZNF2.HEK293.ENCSR011CKE
## hg19::chr1:10003372..10003465,-;hg_10258.1                        1
## hg19::chr1:10003486..10003551,+;hg_541.1                          1
## hg19::chr1:100110807..100110818,+;hg_4172.1                       .
## hg19::chr1:100110851..100110860,+;hg_4173.1                       .
```

### 3.0.1 Computational resources consideration

Running `xcore` using extensive ReMap2020 or ChIP-Atlas molecular signatures,
can be quite time and memory consuming. As an example, modeling the example
293SLAM rinderpest infection dataset with ReMap2020 signatures matrix took
around 10 minutes to compute and used up to 8 GB RAM on Intel(R) Xeon(R) CPU
E5-2680 v3 using 2 cores. This unfortunately exceeds the resources available for
Bioconductor vignettes. This being said, we will further proceed by taking only
a subset of ReMap2020 signatures such that we fit into the time limits. However,
for running `xcore` in a normal setting the whole molecular signatures matrix
should be used!

```
# here we subset ReMap2020 molecular signatures matrix for the purpose of the
# vignette only! In a normal setting the whole molecular signatures matrix should
# be used!
set.seed(432123)
i <- sample(x = seq_len(ncol(remap_promoters_f5)), size = 100, replace = FALSE)
remap_promoters_f5 <- remap_promoters_f5[, i]
```

To add signatures to our `MultiAssayExperiment` object we can use
`addSignatures` function. As you add your signatures remember to give them
unique names.

```
mae <- addSignatures(mae, remap = remap_promoters_f5)
```

When we examine newly added signatures, we can see that some of them does not
overlap any of the promoters. On the other side, depending on the signatures
quality, we could expect to see signatures that overlap all of the promoters.

```
summary(colSums(mae[["remap"]]))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##     1.0    99.5  1300.5  2499.3  4148.0  9561.0
```

While, we do not provide detailed guidelines to signatures filtering, filtering
out at least signatures overlapping no or all promoters is mandatory.
Here, we filter signatures that overlap less than 5% or more than 95% of
promoters using `filterSignatures` function.

```
mae <- filterSignatures(mae, min = 0.05, max = 0.95)
```

At this stage we can investigate `mae` to see how many signatures are
available after intersecting with counts and filtering. number of
columns in signatures corresponds to number of molecular signatures
which will be used to build a model.

```
print(mae)
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] U: matrix with 10388 rows and 1 columns
##  [2] Y: matrix with 10388 rows and 6 columns
##  [3] remap: dgCMatrix with 10388 rows and 63 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Finally, we can run our expression modeling using `modelGeneExpression`
function. `modelGeneExpression` can take advantage of parallelization to
speed up the calculations. To use it we need to register a parallel backend.

### 3.0.2 Parallel computing

While there are many parallel backends to choose from, internally `xcore` uses
[`foreach`](https://cran.r-project.org/web/packages/foreach) to implement
parallel computing. Having this in mind we should use a backend supported by
`foreach`.

Here we are using [`doParallel`](https://cran.r-project.org/package%3DdoParallel)
backend, together with [`BiocParallel`](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html)
package providing unified interface across different OS. Those packages can be
installed with:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocParallel")
install.packages("doParallel")
```

Our modeling will inherently contain some level of randomness due to
using cross validation, here we set the seed so that our results can be
replicated.

This step is time consuming as we need to train a separate model for each of our
samples. To speed up the calculations we will lower number of folds used in
cross-validation procedure from 10 to 5 using `nfolds` argument, which is
internally passed to `cv.glmnet` function. Moreover here we only use a subset
of the ReMap2020 molecular signatures matrix.

```
# register parallel backend
doParallel::registerDoParallel(2L)
BiocParallel::register(BiocParallel::DoparParam(), default = TRUE)

# set seed
set.seed(314159265)

res <- modelGeneExpression(
  mae = mae,
  xnames = "remap",
  nfolds = 5)
```

Output returned by `modelGeneExpression` is a list with following elements:

* `regression_models` - a list holding `cv.glmnet` objects for each
  sample.
* `pvalues` - list of `data.frame`s for each sample, each holding
  signatures estimates, their estimated standard errors and p-values.
* `zscore_avg` - a `matrix` holding replicate average molecular signatures
  Z-scores with columns corresponding to groups in the design.
* `coef_avg` - a `matrix` holding replicate average molecular signatures
  activities with columns corresponding to groups in the design.
* `results` - a `data.frame` holding replicate average molecular signatures and
  overall molecular signatures Z-score calculated over all groups in the design.

`results` is likely of most interest. As you can see below this `data.frame`
holds replicate averaged molecular signatures activities, as well as overall
Z-score which can be used to rank signatures.

```
head(res$results$remap)
```

```
##                                name        12hr        24hr  z_score
## 1            MYC.NCI-H2171.GSE36354 -0.12082629 -0.19828506 51.57852
## 2      E2F4.lymphoblastoid.GSE21488  0.04562324  0.19966038 40.02302
## 3            ATF3.K-562.ENCSR632DCH  0.03155149  0.18341509 34.25033
## 4 NELFA.HeLa_Flavo-0-H2O2.GSE100742 -0.03909478 -0.14367269 23.71841
## 5           MXD4.Hep-G2.ENCSR441KFW -0.07034582 -0.07249674 18.12950
## 6              MYC.HFF_OHT.GSE65544  0.03309922 -0.06793709 17.70650
```

To visualize the result we can plot a heatmap of molecular signatures activities
for the top identified molecular signatures.

```
top_signatures <- head(res$results$remap, 10)
library(pheatmap)
pheatmap::pheatmap(
  mat = top_signatures[, c("12hr", "24hr")],
  scale = "none",
  labels_row = top_signatures$name,
  cluster_cols = FALSE,
  color = colorRampPalette(c("blue", "white", "red"))(15),
  breaks = seq(from = -0.1, to = 0.1, length.out = 16),
  main = "SLAM293 molecular signatures activities"
)
```

![Predicted activities for the top-scoring molecular signatures](data:image/png;base64...)

Figure 1: Predicted activities for the top-scoring molecular signatures

As we only used a random subset of ReMap2020 molecular signatures the obtained
result most likely has no biological meaning. Nonetheless, some general comment
on results interpretation can be made. The top-scoring transcription factors
can be hypothesized to be associated with observed changes in gene expression.
Moreover, the predicted activities indicate if promoters targeted by a specific
signature tend to be downregulated or upregulated.

# 4 Constructing molecular signatures

Constructing molecular signatures is as simple as intersecting promoters
annotation with transcription factors binding sites (TFBS). For example, here we
use FANTOM5’ promoters annotation found in the `xcoredata` package and predicted
CTCF binding sites available in
[CTCF](https://bioconductor.org/packages/release/data/annotation/html/CTCF.html)
`AnnotationHub`’s resource.

Promoter annotations and TFBS should be stored as a `GRanges` object. Moreover,
it is required that the promoter/TF name is held under the `name` column.
Next we can construct a molecular signatures matrix using `getInteractionMatrix`
function, where we can specify the `ext` parameter that will control how
much the promoters are extended in both directions before intersecting with
TFBS.

```
# obtain promoters annotation; *promoter name must be stored under column 'name'
promoters_f5 <- eh[["EH7303"]]
head(promoters_f5)
```

```
## GRanges object with 6 ranges and 5 metadata columns:
##       seqnames            ranges strand |                   name     score
##          <Rle>         <IRanges>  <Rle> |            <character> <numeric>
##   [1]     chr1   9943315-9943407      - | hg19::chr1:10003372...    102331
##   [2]     chr1   9943429-9943493      + | hg19::chr1:10003486...     69018
##   [3]     chr1 99646025-99646217      + | hg19::chr1:100111580..     87706
##   [4]     chr1 99766622-99766642      - | hg19::chr1:100232177..     25838
##   [5]     chr1 99850058-99850135      + | hg19::chr1:100315613..     92180
##   [6]     chr1 99969990-99970041      + | hg19::chr1:100435545..    180010
##       gene_type_gencode    ENTREZID      SYMBOL
##                <factor> <character> <character>
##   [1]    protein_coding       84328        LZIC
##   [2]    protein_coding       64802      NMNAT1
##   [3]    protein_coding       54873       PALMD
##   [4]    protein_coding      391059       FRRS1
##   [5]    protein_coding         178         AGL
##   [6]    protein_coding       23443     SLC35A3
##   -------
##   seqinfo: 25 sequences (1 circular) from hg38 genome
```

```
# obtain predicted CTCF binding for hg38;
# *TF/motif name must be stored under column 'name'
library("AnnotationHub")
ah <- AnnotationHub()
CTCF_hg38 <- ah[["AH104724"]]
CTCF_hg38$name <- "CTCF"
head(CTCF_hg38)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames              ranges strand |  5PrimeGene  3PrimeGene        name
##          <Rle>           <IRanges>  <Rle> | <character> <character> <character>
##   [1]     chr1 100038106-100038125      * |     SLC35A3       HIAT1        CTCF
##   [2]     chr1 100868553-100868572      * |           -       EXTL2        CTCF
##   [3]     chr1 100921277-100921296      * |       EXTL2     SLC30A7        CTCF
##   [4]     chr1 101204233-101204252      * |           -        EDG1        CTCF
##   [5]     chr1 101288599-101288618      * |        EDG1           -        CTCF
##   [6]     chr1 101357558-101357577      * |           -           -        CTCF
##   -------
##   seqinfo: 24 sequences from hg38 genome
```

```
# construct molecular signatures matrix
molecular_signature <- getInteractionMatrix(
  a = promoters_f5,
  b = CTCF_hg38,
  ext = 500
)
head(molecular_signature)
```

```
## 6 x 1 sparse Matrix of class "dgCMatrix"
##                                              CTCF
## hg19::chr1:10003372..10003465,-;hg_10258.1      .
## hg19::chr1:10003486..10003551,+;hg_541.1        .
## hg19::chr1:100111580..100111773,+;hg_4181.1     .
## hg19::chr1:100232177..100232198,-;hg_13495.1    .
## hg19::chr1:100315613..100315691,+;hg_4187.1     .
## hg19::chr1:100435545..100435597,+;hg_4201.1     .
```

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
##  [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
##  [4] S4Vectors_0.48.0     pheatmap_1.0.13      glmnet_4.1-10
##  [7] Matrix_1.7-4         xcoredata_1.13.0     ExperimentHub_3.0.0
## [10] AnnotationHub_4.0.0  BiocFileCache_3.0.0  dbplyr_2.5.1
## [13] BiocGenerics_0.56.0  generics_0.1.4       xcore_1.14.0
## [16] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            farver_2.1.2
##  [3] dplyr_1.1.4                 blob_1.2.4
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] fastmap_1.2.0               digest_0.6.37
##  [9] lifecycle_1.0.4             survival_3.8-3
## [11] statmod_1.5.1               KEGGREST_1.50.0
## [13] RSQLite_2.4.3               magrittr_2.0.4
## [15] compiler_4.5.1              rlang_1.1.6
## [17] sass_0.4.10                 tools_4.5.1
## [19] yaml_2.3.10                 knitr_1.50
## [21] S4Arrays_1.10.0             bit_4.6.0
## [23] curl_7.0.0                  DelayedArray_0.36.0
## [25] RColorBrewer_1.1-3          BiocParallel_1.44.0
## [27] abind_1.4-8                 withr_3.0.2
## [29] purrr_1.1.0                 grid_4.5.1
## [31] edgeR_4.8.0                 scales_1.4.0
## [33] iterators_1.0.14            tinytex_0.57
## [35] dichromat_2.0-0.1           MultiAssayExperiment_1.36.0
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              crayon_1.5.3
## [41] httr_1.4.7                  BiocBaseUtils_1.12.0
## [43] DBI_1.2.3                   cachem_1.1.0
## [45] splines_4.5.1               parallel_4.5.1
## [47] AnnotationDbi_1.72.0        BiocManager_1.30.26
## [49] XVector_0.50.0              matrixStats_1.5.0
## [51] vctrs_0.6.5                 jsonlite_2.0.0
## [53] bookdown_0.45               bit64_4.6.0-1
## [55] magick_2.9.0                locfit_1.5-9.12
## [57] foreach_1.5.2               limma_3.66.0
## [59] jquerylib_0.1.4             glue_1.8.0
## [61] codetools_0.2-20            gtable_0.3.6
## [63] shape_1.4.6.1               BiocVersion_3.22.0
## [65] tibble_3.3.0                pillar_1.11.1
## [67] rappdirs_0.3.3              htmltools_0.5.8.1
## [69] R6_2.6.1                    httr2_1.2.1
## [71] doParallel_1.0.17           evaluate_1.0.5
## [73] lattice_0.22-7              Biobase_2.70.0
## [75] png_0.1-8                   memoise_2.0.1
## [77] bslib_0.9.0                 Rcpp_1.1.0
## [79] SparseArray_1.10.0          xfun_0.53
## [81] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```