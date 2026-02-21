# Installing and Using BrainSABER

Carrie Minette

#### 2020-10-27

# Contents

* [1 Introduction](#introduction)
* [2 Installing BrainSABER](#installing-brainsaber)
* [3 Dynamically Constructing the AIBSARNA Reference Dataset](#dynamically-constructing-the-aibsarna-reference-dataset)
* [4 The BrainSABER Workflow](#the-brainsaber-workflow)
  + [4.1 Preparing a CellScabbard object](#preparing-a-cellscabbard-object)
  + [4.2 Select Gene Identifiers](#select-gene-identifiers)
    - [4.2.1 Filter the Data](#filter-the-data)
    - [4.2.2 Generate Similarity Scores](#generate-similarity-scores)
    - [4.2.3 Generate Age x Structure Matrices or Data Frames](#generate-age-x-structure-matrices-or-data-frames)
    - [4.2.4 Generate Up-Regulated / Down-Regulated / Normal Matrices](#generate-up-regulated-down-regulated-normal-matrices)
  + [4.3 Session Info](#session-info)

# 1 Introduction

The Allen Institute for Brain Science provides an
RNA sequencing (RNA-Seq) data resource for studying
transcriptional mechanisms involved in human brain
development known as BrainSpan. This resource serves as an
additional control in research involving RNA sequencing of
human brain tissue. BrainSABER facilitates comparisons of user data
with the various developmental stages and brain structures found in
the BrainSpan atlas. It extends the SummarizedExperiment class into a
self-validating container for user data
and produces similarity matrices containing samples of the user’s data
analyzed against each sample in the BrainSpan database. These matrices
are presented as dynamic heat maps, and include both cosine and Euclidean
similarity methods.

# 2 Installing BrainSABER

BrainSABER requires Bioconductor 3.11 or higher. For more information on Bioconductor, please see their website at <https://bioconductor.org>. To install Bioconductor and BrainSABER, run the following commands in R or RStudio:

```
# for R version >= 4.0
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BrainSABER")
```

After installing, attach the BrainSABER package with the following command:

```
library(BrainSABER)
```

# 3 Dynamically Constructing the AIBSARNA Reference Dataset

To leverage the Allen Institute for Brain Science Brain Atlas RNA sequence
data, BrainSABER includes a function, ‘buildAIBSARNA’, that will download the
data, format it into a RangedSummarizedExperiment, and use biomaRt to add RefSeq
identifiers. This function also stores the downloaded zipped file using the BiocFileCache
package in a local cached directory, so after the initial run the process should
be faster and won’t require an active internet connection. For more information
on how *[BiocFileCache](https://bioconductor.org/packages/3.12/BiocFileCache)* stores data use the link or see the package vignette.

```
# Extract dataset from online source or from local BiocCache
AIBSARNA <- buildAIBSARNA()
```

Once AIBSARNA has been build, this function does not need to be run again for
subsequent work unless the AIBSARNA variable is removed or a new R session is
started. If desired, AIBSARNA can be saved as an R data object and reloaded
for future work without the need to rebuild it.

# 4 The BrainSABER Workflow

The BrainSABER workflow can be used to compare the Allen Institute data to a CellScabbard
object. The CellScabbard class extends the SummarizedExperiment class, and in addition
requires a sample of the Allen Institute’s data.

## 4.1 Preparing a CellScabbard object

To build a CellScabbard object requires the following inputs:

1. exprsData, a numeric matrix of expression values, where rows are genes, and columns are cells/samples
2. phenoData, a data frame or DataFrame where rows are cells/samples, and columns are cell/sample attributes (such as cell type, culture condition, day captured, etc.)
3. featureData, a data frame or DataFrame where rows are features (e.g. genes), and columns are gene attributes, such as gene identifiers, gc content, etc.
4. AIBSARNA, a SummarizedExperiment or RangedSummarizedExperiment object containing sample AIBSARNA data.

The expression value matrix must have the same number of columns as the phenoData has rows, and it must have the same number of rows as the featureData data frame has rows. Row names of the phenoData object should match the column names of the expression matrix. Row names of the featureData object should match row names of the expression matrix.

For this vignette, we will construct a toy CellScabbard object by extracting 50 samples and 200 genes from AIBSARNA, using the code below:

```
# Obtain the sample indexes to use for subsetting (not random)
sample_idx <- 1:50 * 10 - 1
# Set the RNG seed for repeatable results
set.seed(8)
# Get the total number of genes available
totalGenes <- nrow(AIBSARNA)
# Sample the indices of 200 random genes
gene_idx <- sample.int(totalGenes, 200)

# Subset AIBSARNA
toy_exprs <- assay(AIBSARNA)[gene_idx, sample_idx]
toy_fd <- rowData(AIBSARNA)[gene_idx, ]
toy_pd <- colData(AIBSARNA)[sample_idx, ]

# Create toy CellScabbard
toySet <- CellScabbard(exprsData = toy_exprs, phenoData = toy_pd,
                       featureData = toy_fd, AIBSARNA = AIBSARNA,
                       autoTrim = TRUE)
```

## 4.2 Select Gene Identifiers

Before we can compare our data to the Allen Institute data, we must remove any genes that are not present in the Allen Institute data. To accomplish that, we need to explore different combinations of gene identifiers for our data and the Allen Institute data to find which combination yields the most matched genes. We can use BrainSABER’s “getExternalVector()” function to extract trimmed vectors from our toySet, and compare lengths to find which one contains the most matches.

```
# Try comparing different identifiers
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                         dataSetId = "gene_id", AIBSARNAid = "gene_id"))
```

```
## [1] 200
```

```
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                         dataSetId = "ensembl_gene_id",
                         AIBSARNAid = "ensembl_gene_id"))
```

```
## [1] 200
```

```
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                         dataSetId = "gene_symbol",
                         AIBSARNAid = "gene_symbol"))
```

```
## [1] 200
```

```
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                         dataSetId = "entrez_id", AIBSARNAid = "entrez_id"))
```

```
## [1] 200
```

```
length(getExternalVector(toySet, index = 1, AIBSARNA = AIBSARNA,
                         dataSetId = "refseq_ids", AIBSARNAid = "refseq_ids"))
```

```
## [1] 200
```

Because the Allen Institute data was originally sequenced using Ensembl identifiers, the “ensembl\_id” column of AIBSARNA is the only column with no missing values, making it the ideal choice if the user data also contains ensembl identifiers. If not, the Allen Institute data contains other identifiers. More information is available at their website, <http://brainspan.org>.

### 4.2.1 Filter the Data

Before we can compare our data to the Allen Institute data, we must remove any genes that are not present in the Allen Institute data. BrainSABER includes a function to trim down user data, which returns a new SummarizedExperiment object. Although this process is done automatically when the user sets the autoTrim argument of CellScabbard() to true, the user can also manually trim their data by specifying the subsetting columns. We will use the “ensembl\_gene\_id” columns to trim by, as they showed the most matches in the previous step.

```
trimmed_toySet <- getTrimmedExternalSet(dataSet = toySet,
                                        dataSetId = "ensembl_gene_id",
                                        AIBSARNA = AIBSARNA,
                                        AIBSARNAid = "ensembl_gene_id")
```

We must also filter AIBSARNA to obtain only the genes present in our data set, using BrainSABER’s “getRelevantGenes()” function. Although the CellScabbard constructor does this automatically and stores the results under the ‘relevantGenes’ slot, we will use the “ensembl\_gene\_id” columns to demonstrate the process manually.

```
trimmed_AIBSARNA <- getRelevantGenes(data = toySet,
                                     dataSetId = "ensembl_gene_id",
                                     AIBSARNA = AIBSARNA,
                                     AIBSARNAid = "ensembl_gene_id")

# Or extract the results directly from our toySet
autotrim_AIBSARNA <- relevantGenes(toySet)
```

Note that both the autotrimming and autofiltering processes in ‘CellScabbard()’ use the highest-matching column identifier.

### 4.2.2 Generate Similarity Scores

Once we have filtered the data to contain only genes present in both the user data and the Allen Institute data, we can obtain a data frame containing similarity scores comparing each sample in the user data to each sample in the Allen Institute data. This can be done using the manually trimmed user and AIBSARNA data, or any trimmed CellScabbard set, which already contains the necessary info in its relevantGenes slot. The getSimScores() function currently supports scoring based on either euclidean distance or cosine similarity, and users should store results in the ‘similarityScores’ slot if using a CellScabbard set. The scores range from 0 to 1, where 1 is a perfect match, and 0 is completely dissimilar.

```
# Using manually filtered data sets
euc_sim <- getSimScores(data = trimmed_toySet,
                         relevantGenes = trimmed_AIBSARNA,
                         similarity_method = "euclidean")
cos_sim <- getSimScores(data = trimmed_toySet,
                         relevantGenes = trimmed_AIBSARNA,
                         similarity_method = "cosine")

# Or using the auto-trimmed toySet
auto_euc_sim <- getSimScores(data = toySet, similarity_method = "euclidean")
auto_cos_sim <- getSimScores(data = toySet, similarity_method = "cosine")
```

### 4.2.3 Generate Age x Structure Matrices or Data Frames

We can use the similarity scores generated in the previous step to generate a matrix or data frame for each sample in our data to identify which ages and brain structures from the Allen Institute data that sample most closely matches. The getSimMatrix function will return single list which contains the matrices for all samples, and the getSimDataFrame function will return a single list containing data frames for all samples, sorted by the highest score. If passing in a CellScabbard, the functions will automatically extract the relevant genes and similarity scores from the data set, but the user will have to store them there first.

```
# Using manually filtered data scores
euc_mats <- getSimMatrix(sim_score = euc_sim, relevantGenes = trimmed_AIBSARNA)
euc_df <- getSimDataFrame(sim_score = euc_sim,
                          relevantGenes = trimmed_AIBSARNA,
                          similarity_method = "euclidean")
cos_mats <- getSimMatrix(sim_score = cos_sim, relevantGenes = trimmed_AIBSARNA)
cos_df <- getSimDataFrame(sim_score = cos_sim,
                          relevantGenes = trimmed_AIBSARNA,
                          similarity_method = "cosine")

# Or using the auto-trimmed data scores
# first store the data in the toySet, then call the similarity functions
similarityScores(toySet) <- auto_euc_sim
auto_euc_mats <- getSimMatrix(data = toySet)
auto_euc_df <- getSimDataFrame(data = toySet, similarity_method = "euclidean")
# to determine cosine similarity, reset the similarityScores data and then call similarity functions
similarityScores(toySet) <- auto_cos_sim
auto_cos_mats <- getSimMatrix(data = toySet)
auto_cos_df <- getSimDataFrame(data = toySet, similarity_method = "cosine")

# Store results of euclidean testing in the toySet
similarityMatrices(toySet) <- auto_euc_mats
similarityDFs(toySet) <- auto_euc_df
```

To access the similarity matrices and data frames from the toySet, use the ‘similarityMatrices()’ and ‘similarityDFs()’ accessor methods.

Using R’s head() function, we can see the best matches for a sample in our list of data frames:

```
head(cos_df[[1]])
```

```
##        age structure_acronym cosine_similarity
## 211 24 pcw               VFC       0.003296334
## 194 21 pcw               OFC       0.003083213
## 220 35 pcw               CBC       0.002850345
## 203 24 pcw               S1C       0.002796607
## 186 21 pcw               MFC       0.002363169
## 208 24 pcw               OFC       0.002333901
```

The matrices can be fed into a heatmapping function to produce graphics displaying the similarity for a sample. we will use the heatmaply package to generate an interactive heatmap:

```
library(heatmaply)
```

```
## Loading required package: plotly
```

```
## Loading required package: ggplot2
```

```
##
## Attaching package: 'plotly'
```

```
## The following object is masked from 'package:ggplot2':
##
##     last_plot
```

```
## The following object is masked from 'package:IRanges':
##
##     slice
```

```
## The following object is masked from 'package:S4Vectors':
##
##     rename
```

```
## The following object is masked from 'package:biomaRt':
##
##     select
```

```
## The following object is masked from 'package:stats':
##
##     filter
```

```
## The following object is masked from 'package:graphics':
##
##     layout
```

```
## Loading required package: viridis
```

```
## Loading required package: viridisLite
```

```
##
## ======================
## Welcome to heatmaply version 1.1.1
##
## Type citation('heatmaply') for how to cite the package.
## Type ?heatmaply for the main documentation.
##
## The github page is: https://github.com/talgalili/heatmaply/
## Please submit your suggestions and bug-reports at: https://github.com/talgalili/heatmaply/issues
## Or contact: <tal.galili@gmail.com>
## ======================
```

```
##
## Attaching package: 'heatmaply'
```

```
## The following object is masked from 'package:BiocGenerics':
##
##     normalize
```

```
heatmaply(euc_mats[[1]])
```

### 4.2.4 Generate Up-Regulated / Down-Regulated / Normal Matrices

In addition to similarity scoring, BrainSABER can also be used to create a list of matrices, one for each sample, indicating whether genes are up-reglated, down-regulated, or normal as compared to the Allen Institute data. The getUNDmatrix() function compares the two data sets, either directly with the “discrete” option, or using the log2 fold-change via “log2fc”, and returns either a numerical matrix or a character matrix where ‘-1’ or ‘D’ indicates down-regulation, ‘1’ or ‘U’ indicates up-regulation, and ‘0’ or ‘N’ indicates normal. The rows of these matrices will be named with the rownames of the user’s trimmed gene expression matrix, and so correspond to the genes of the user data, while the columns of the matrices will be named for the columns in the trimmed Allen Institute data gene expression matrix, and thus correspond to each sample in the Allen Institute data

```
und_num <- getUNDmatrix(dataSet = trimmed_toySet,
                        relevantGenes = trimmed_AIBSARNA,
                        method = "log2fc",
                        matrix_type = "num")
und_num[[1]][1:10, 1:10]
```

```
##              Sample_1  Sample_2  Sample_3  Sample_4  Sample_5  Sample_6
## Gene_13620  0.7805937  1.001816  2.509564  1.620752  1.423441  2.625176
## Gene_42722       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_47116       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_42238 -5.0511187 -5.893638 -3.034275 -3.457771 -4.815736 -3.339929
## Gene_5853        -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_35715       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_17332 -4.4062581 -4.222253 -4.523927 -4.661644 -4.058217 -4.120087
## Gene_34152 -1.4152096 -1.099079 -1.582914 -1.206143 -1.314688 -1.437514
## Gene_26734       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_14089       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
##             Sample_7  Sample_8  Sample_9 Sample_10
## Gene_13620  1.680324  2.982117  1.348810  1.266450
## Gene_42722      -Inf      -Inf      -Inf      -Inf
## Gene_47116      -Inf      -Inf      -Inf      -Inf
## Gene_42238 -4.791561 -1.607487 -4.014670 -3.350593
## Gene_5853       -Inf      -Inf      -Inf      -Inf
## Gene_35715      -Inf      -Inf      -Inf      -Inf
## Gene_17332 -4.356516 -4.499664 -3.905202 -3.419984
## Gene_34152 -1.162350 -1.290172 -1.361178 -1.663125
## Gene_26734      -Inf      -Inf      -Inf      -Inf
## Gene_14089      -Inf      -Inf      -Inf      -Inf
```

```
und_char <- getUNDmatrix(dataSet = trimmed_toySet,
                        relevantGenes = trimmed_AIBSARNA,
                        method = "log2fc",
                        matrix_type = "char")
und_char[[1]][1:10, 1:10]
```

```
##              Sample_1  Sample_2  Sample_3  Sample_4  Sample_5  Sample_6
## Gene_13620  0.7805937  1.001816  2.509564  1.620752  1.423441  2.625176
## Gene_42722       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_47116       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_42238 -5.0511187 -5.893638 -3.034275 -3.457771 -4.815736 -3.339929
## Gene_5853        -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_35715       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_17332 -4.4062581 -4.222253 -4.523927 -4.661644 -4.058217 -4.120087
## Gene_34152 -1.4152096 -1.099079 -1.582914 -1.206143 -1.314688 -1.437514
## Gene_26734       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
## Gene_14089       -Inf      -Inf      -Inf      -Inf      -Inf      -Inf
##             Sample_7  Sample_8  Sample_9 Sample_10
## Gene_13620  1.680324  2.982117  1.348810  1.266450
## Gene_42722      -Inf      -Inf      -Inf      -Inf
## Gene_47116      -Inf      -Inf      -Inf      -Inf
## Gene_42238 -4.791561 -1.607487 -4.014670 -3.350593
## Gene_5853       -Inf      -Inf      -Inf      -Inf
## Gene_35715      -Inf      -Inf      -Inf      -Inf
## Gene_17332 -4.356516 -4.499664 -3.905202 -3.419984
## Gene_34152 -1.162350 -1.290172 -1.361178 -1.663125
## Gene_26734      -Inf      -Inf      -Inf      -Inf
## Gene_14089      -Inf      -Inf      -Inf      -Inf
```

```
# Or using the auto-trimmed toySet
auto_und_num <- getUNDmatrix(dataSet = toySet, method = "log2fc", matrix_type = "num")
auto_und_char <- getUNDmatrix(dataSet = toySet, method = "log2fc", matrix_type = "char")
```

## 4.3 Session Info

```
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] heatmaply_1.1.1             viridis_0.5.1
##  [3] viridisLite_0.3.0           plotly_4.9.2.1
##  [5] ggplot2_3.3.2               BrainSABER_1.0.0
##  [7] SummarizedExperiment_1.20.0 Biobase_2.50.0
##  [9] GenomicRanges_1.42.0        GenomeInfoDb_1.26.0
## [11] IRanges_2.24.0              S4Vectors_0.28.0
## [13] BiocGenerics_0.36.0         MatrixGenerics_1.2.0
## [15] matrixStats_0.57.0          biomaRt_2.46.0
## [17] BiocStyle_2.18.0
##
## loaded via a namespace (and not attached):
##  [1] lsa_0.73.2             bitops_1.0-6           bit64_4.0.5
##  [4] webshot_0.5.2          RColorBrewer_1.1-2     progress_1.2.2
##  [7] httr_1.4.2             SnowballC_0.7.0        tools_4.0.3
## [10] R6_2.4.1               DBI_1.1.0              lazyeval_0.2.2
## [13] colorspace_1.4-1       withr_2.3.0            tidyselect_1.1.0
## [16] gridExtra_2.3          prettyunits_1.1.1      bit_4.0.4
## [19] curl_4.3               compiler_4.0.3         Cairo_1.5-12.2
## [22] TSP_1.1-10             xml2_1.3.2             DelayedArray_0.16.0
## [25] labeling_0.4.2         bookdown_0.21          scales_1.1.1
## [28] askpass_1.1            rappdirs_0.3.1         stringr_1.4.0
## [31] digest_0.6.27          rmarkdown_2.5          XVector_0.30.0
## [34] pkgconfig_2.0.3        htmltools_0.5.0        dbplyr_1.4.4
## [37] htmlwidgets_1.5.2      rlang_0.4.8            RSQLite_2.2.1
## [40] farver_2.0.3           generics_0.0.2         jsonlite_1.7.1
## [43] crosstalk_1.1.0.1      dendextend_1.14.0      dplyr_1.0.2
## [46] RCurl_1.98-1.2         magrittr_1.5           GenomeInfoDbData_1.2.4
## [49] Matrix_1.2-18          Rcpp_1.0.5             munsell_0.5.0
## [52] lifecycle_0.2.0        stringi_1.5.3          yaml_2.2.1
## [55] zlibbioc_1.36.0        plyr_1.8.6             BiocFileCache_1.14.0
## [58] grid_4.0.3             blob_1.2.1             crayon_1.3.4
## [61] lattice_0.20-41        hms_0.5.3              knitr_1.30
## [64] pillar_1.4.6           reshape2_1.4.4         codetools_0.2-16
## [67] XML_3.99-0.5           glue_1.4.2             evaluate_0.14
## [70] data.table_1.13.2      BiocManager_1.30.10    vctrs_0.3.4
## [73] foreach_1.5.1          gtable_0.3.0           openssl_1.4.3
## [76] purrr_0.3.4            tidyr_1.1.2            assertthat_0.2.1
## [79] xfun_0.18              seriation_1.2-9        tibble_3.0.4
## [82] iterators_1.0.13       registry_0.5-1         AnnotationDbi_1.52.0
## [85] memoise_1.1.0          ellipsis_0.3.1
```