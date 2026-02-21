# Roadmap to prepare the input matrix for `scTensor`

Koki Tsuyuzaki1, Manabu Ishii1 and Itoshi Nikaido1\*

1Laboratory for Bioinformatics Research, RIKEN Center for Biosystems Dynamics Research

\*k.t.the-answer@hotmail.co.jp

#### 30 October 2025

#### Package

scTensor 2.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Step.1: Create a gene-level expression matrix](#step.1-create-a-gene-level-expression-matrix)
  + [2.1 Case I: Gene-level quantification](#case-i-gene-level-quantification)
  + [2.2 Case II: Transcript-level quantification](#case-ii-transcript-level-quantification)
  + [2.3 Case III: UMI-count](#case-iii-umi-count)
* [3 Step.2: Convert the row names of a matrix as NCBI Gene ID (ENTREZID)](#step.2-convert-the-row-names-of-a-matrix-as-ncbi-gene-id-entrezid)
  + [3.1 Case I: Ensembl Gene ID to NCBI Gene ID](#case-i-ensembl-gene-id-to-ncbi-gene-id)
  + [3.2 Case II: Gene Symbol to NCBI Gene ID](#case-ii-gene-symbol-to-ncbi-gene-id)
* [4 Step.3: Normalize the count matrix](#step.3-normalize-the-count-matrix)
* [Session information](#session-information)

This vignette has been changed in BioC 3.14, when each data package (LRBase.XXX.eg.db) is deprecated and the way to provide LRBase data has changed to AnnotationHub-style.

# 1 Introduction

We explain the way to create a matrix, in which the row names are **NCBI Gene ID (ENTREZID)**, for specifying an input of *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*.
Typical *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* workflow can be described as below.

```
library("scTensor")
library("AnnotationHub")
library("LRBaseDbi")

# Input matrix
input <- ...
sce <- SingleCellExperiment(assays=list(counts = input))
# Celltype vector
label <- ...
# LRBase.XXX.eg.db
ah <- AnnotationHub()
dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]
LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)
# Setting
cellCellSetting(sce, LRBase.Hsa.eg.db, label)
```

In *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*, the row names of the input matrix is limited only NCBI Gene ID to cooperate with the other R packages (cf. data(“Germline”)). Since the user has many different types of the data matrix, here we introduce some situations and the way to convert the row names of the user’s matrix as NCBI Gene ID.

# 2 Step.1: Create a gene-level expression matrix

First of all, we have to prepare the expression matrix (gene \(\times\) cell).
There are many types of single-cell RNA-Seq (scRNA-Seq) technologies and the situation will be changed by the used experimental methods and quantification tools described below.

## 2.1 Case I: Gene-level quantification

In Plate-based scRNA-Seq experiment (i.e. Smart-Seq2, Quart-Seq2, CEL-Seq2, MARS-Seq,…etc), the FASTQ file is generated in each cell. After the mapping of reads in each FASTQ file to the reference genome, the same number of BAM files will be generated.
By using some quantification tools such as [featureCounts](http://bioinf.wehi.edu.au/featureCounts/), or [HTSeq-count](https://htseq.readthedocs.io/en/release_0.11.1/count.html), user can get the expression matrix and used as the input of *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*. These tools simply count the number of reads in union-exon in each gene.
One downside of these tools is that such tools do not take “multimap” of not unique reads into consideration and the quantification is not accurate.
Therefore, we recommend the transcript-level quantification and gene-level summarization explained below.

## 2.2 Case II: Transcript-level quantification

Some quantification tools such as [RSEM](https://deweylab.github.io/RSEM/), [Sailfish](https://www.cs.cmu.edu/~ckingsf/software/sailfish/), [Salmon](https://combine-lab.github.io/salmon/), [Kallisto](https://pachterlab.github.io/kallisto/), and [StringTie](http://ccb.jhu.edu/software/stringtie/index.shtml) use the reference transcriptome instead of genome, and quantify the expression level in each transcript. After the quantification, the transcript-level expression can be summarized to gene-level by using `summarizeToGene` function of *[tximport](https://bioconductor.org/packages/3.22/tximport)*. [The paper of tximport](https://f1000research.com/articles/4-1521) showed that the transcript-level expression summalized to gene-level is more accurate than the gene-level expression calculated by featureCounts.

Note that if you use the reference transcriptome of [GENCODE](https://www.gencodegenes.org/human/stats.html), this step becomes slightly complicated. Although the number of transcripts of GENCODE and that of [Ensembl](https://ensembl.org/Homo_sapiens/Info/Annotation) is almost the same,
and actually, most of the transcript is duplicated in these two databases,
the gene identifier used in GENCODE looks complicated like “ENST00000456328.2|ENSG00000223972.5|OTTHUMG00000000961.2|OTTHUMT00000362751.1|DDX11L1-202|DDX11L1|1657|processed\_transcript|”.
In such a case, firstly only Ensembl Transcript ID should be extracted (e.g. ENST00000456328.2), removed the version (e.g. ENST00000456328), summarized to Ensembl Gene ID by tximport (e.g. ENSG00000223972), and then converted to NCBI Gene ID (e.g. 100287102) by each organism package such as *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*.

## 2.3 Case III: UMI-count

In the droplet-based scRNA-Seq experiment (i.e. Drop-Seq, inDrop RNA-Seq, 10X Chromium), unique molecular identifier (UMI) is introduced for avoiding the bias of PCR amplification, and after multiplexing by cellular barcode, digital gene expression (DGE) matrix is generated by counting the number of types of UMI mapped in each gene.

When user perform Drop-seq, [Drop-Seq tool](https://github.com/broadinstitute/Drop-seq) can generate the DGE matrix.

Another tool [Alevin](https://salmon.readthedocs.io/en/latest/alevin.html), which is a subcommand of Salmon is also applicable to Drop-seq data. In such case [tximport] with option “type = ‘alevin’” can import the result of Alevin into R and summarize the DGE matrix.

When the user performs 10X Chromium, using [Cell Ranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger) developed by 10X Genomics is straightforward.

Although Cell Ranger is implemented by Python, starting from the files generated by Cell Ranger (e.g. filtered\_gene\_bc\_matrices/{hg19,mm10}/{barcodes.tsv,genes.tsv,matrix.mtx}), *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* can import these files to an R object.

For example, according to the tutorial of Seurat ([Seurat - Guided Clustering Tutorial](https://satijalab.org/seurat/v3.0/pbmc3k_tutorial.html)), PBMC data of Cell Ranger can be imported by the `Read10X` function and DGE matrix of UMI-count is available by the output of `CreateSeuratObject` function.

```
if(!require(Seurat)){
    BiocManager::install("Seurat")
    library(Seurat)
}

# Load the PBMC dataset
pbmc.data <- Read10X(data.dir = "filtered_gene_bc_matrices/hg19/")

# Initialize the Seurat object with the raw (non-normalized data).
pbmc <- CreateSeuratObject(counts = pbmc.data,
  project = "pbmc3k", min.cells = 3, min.features = 200)
```

**Note that the matrix is formatted as a sparse matrix of *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package (MM: Matrix market), but the *[scTensor](https://bioconductor.org/packages/3.22/scTensor)* assumes dense matrix for now.**
By using `as.matrix` function,
the sparse matrix is easily converted to a dense matrix as follows.

```
# Sparse matrix to dense matrix
for_sc <- as.matrix(pbmc.data)
```

# 3 Step.2: Convert the row names of a matrix as NCBI Gene ID (ENTREZID)

Even after creating the gene-level expression matrix in Step.1,
many kinds of gene-level gene identifiers can be assigned as row names of the matrix such as Ensembl Gene ID, RefSeq, or Gene Symbol.
Again, only NCBI Gene ID can be used as row names of the input matrix of *[scTensor](https://bioconductor.org/packages/3.22/scTensor)*.
To do such a task, we originally implemented a function `convertRowID` function of *[scTGIF](https://bioconductor.org/packages/3.22/scTGIF)*.
The only user has to prepare for using this function is the 1. input matrix (or data.frame) filled with only numbers, 2. current gene-level gene identifier in each row of the input matrix, and 3. corresponding table containing current gene-level gene identifier (left) and corresponding NCBI Gene ID (right).
The usage of this function is explained below.

## 3.1 Case I: Ensembl Gene ID to NCBI Gene ID

In addition to 1. and 2., the user has to prepare the 3. corresponding table.
Here we introduce two approaches to assign the user’s Ensembl Gene ID to NCBI Gene ID.
First approarch is using [Organism DB](https://bioconductor.org/packages/release/BiocViews.html#___OrganismDb) packages such as *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*, *[Mus.musculus](https://bioconductor.org/packages/3.22/Mus.musculus)*, and *[Rattus.norvegicus](https://bioconductor.org/packages/3.22/Rattus.norvegicus)*.

Using the `select` function of Organism DB, the corresponding table can be retrieved like below.

```
suppressPackageStartupMessages(library("scTensor"))
if(!require(Homo.sapiens)){
    BiocManager::install("Homo.sapiens")
    suppressPackageStartupMessages(library(Homo.sapiens))
}
```

```
## Loading required package: Homo.sapiens
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: OrganismDbi
```

```
## Loading required package: GenomicFeatures
```

```
## Loading required package: GO.db
```

```
## Loading required package: org.Hs.eg.db
```

```
##
```

```
## Loading required package: TxDb.Hsapiens.UCSC.hg19.knownGene
```

```
if(!require(scTGIF)){
    BiocManager::install("scTGIF")
    suppressPackageStartupMessages(library(scTGIF))
}
```

```
## Loading required package: scTGIF
```

```
# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 2. Gene identifier in each row
rowID <- c("ENSG00000204531", "ENSG00000181449",
  "ENSG00000136997", "ENSG00000136826")
# 3. Corresponding table
LefttoRight <- select(Homo.sapiens,
  column=c("ENSEMBL", "ENTREZID"),
  keytype="ENSEMBL", keys=rowID)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
# ID conversion
(input <- convertRowID(input, rowID, LefttoRight))
```

```
##
  |
  |                                                                      |   0%
  |
  |==================                                                    |  25%
  |
  |===================================                                   |  50%
  |
  |====================================================                  |  75%
  |
  |======================================================================| 100%
```

```
## Input matrix: 4x5
```

```
## Output matrix: 4x5
```

```
## Some gene expression vectors were collapsed into single vector
```

```
##   by sum rule
```

```
## $output
##      [,1] [,2] [,3] [,4] [,5]
## 5460    1    5    9   13   17
## 6657    2    6   10   14   18
## 4609    3    7   11   15   19
## 9314    4    8   12   16   20
##
## $ctable
##      Left              Right
## [1,] "ENSG00000204531" "5460"
## [2,] "ENSG00000181449" "6657"
## [3,] "ENSG00000136997" "4609"
## [4,] "ENSG00000136826" "9314"
```

Second approarch is using *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package.

Although only three Organism DB packages are explicitly developed,
even if the data is generated from other species (e.g. Zebrafish, Arabidopsis thaliana),
similar database is also available from *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*,
and `select` function can be performed like below.

```
suppressPackageStartupMessages(library("AnnotationHub"))

# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 3. Corresponding table
ah <- AnnotationHub()
# Database of Human
hs <- query(ah, c("OrgDb", "Homo sapiens"))[[1]]
```

```
## loading from cache
```

```
LefttoRight <- select(hs,
  column=c("ENSEMBL", "ENTREZID"),
  keytype="ENSEMBL", keys=rowID)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
(input <- convertRowID(input, rowID, LefttoRight))
```

```
##
  |
  |                                                                      |   0%
  |
  |==================                                                    |  25%
  |
  |===================================                                   |  50%
  |
  |====================================================                  |  75%
  |
  |======================================================================| 100%
```

```
## Input matrix: 4x5
```

```
## Output matrix: 4x5
```

```
## Some gene expression vectors were collapsed into single vector
```

```
##   by sum rule
```

```
## $output
##      [,1] [,2] [,3] [,4] [,5]
## 5460    1    5    9   13   17
## 6657    2    6   10   14   18
## 4609    3    7   11   15   19
## 9314    4    8   12   16   20
##
## $ctable
##      Left              Right
## [1,] "ENSG00000204531" "5460"
## [2,] "ENSG00000181449" "6657"
## [3,] "ENSG00000136997" "4609"
## [4,] "ENSG00000136826" "9314"
```

## 3.2 Case II: Gene Symbol to NCBI Gene ID

When using cellranger or *[Seurat](https://CRAN.R-project.org/package%3DSeurat)* to quantify UMI-count (cf. Step1, Case III),
the row names of the input matrix might be Gene Symbol,
and have to be converted to NCBI Gene ID.
As well as the Case I described above,
[Organism DB](https://bioconductor.org/packages/release/BiocViews.html#___OrganismDb)
and *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* will support such a task like below.

```
# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 2. Gene identifier in each row
rowID <- c("POU5F1", "SOX2", "MYC", "KLF4")
# 3. Corresponding table
LefttoRight <- select(Homo.sapiens,
  column=c("SYMBOL", "ENTREZID"),
  keytype="SYMBOL", keys=rowID)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
# ID conversion
(input <- convertRowID(input, rowID, LefttoRight))
```

```
##
  |
  |                                                                      |   0%
  |
  |==================                                                    |  25%
  |
  |===================================                                   |  50%
  |
  |====================================================                  |  75%
  |
  |======================================================================| 100%
```

```
## Input matrix: 4x5
```

```
## Output matrix: 4x5
```

```
## Some gene expression vectors were collapsed into single vector
```

```
##   by sum rule
```

```
## $output
##      [,1] [,2] [,3] [,4] [,5]
## 5460    1    5    9   13   17
## 6657    2    6   10   14   18
## 4609    3    7   11   15   19
## 9314    4    8   12   16   20
##
## $ctable
##      Left     Right
## [1,] "POU5F1" "5460"
## [2,] "SOX2"   "6657"
## [3,] "MYC"    "4609"
## [4,] "KLF4"   "9314"
```

```
# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 3. Corresponding table
ah <- AnnotationHub()
# Database of Human
hs <- query(ah, c("OrgDb", "Homo sapiens"))[[1]]
```

```
## loading from cache
```

```
LefttoRight <- select(hs,
  column=c("SYMBOL", "ENTREZID"),
  keytype="SYMBOL", keys=rowID)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
(input <- convertRowID(input, rowID, LefttoRight))
```

```
##
  |
  |                                                                      |   0%
  |
  |==================                                                    |  25%
  |
  |===================================                                   |  50%
  |
  |====================================================                  |  75%
  |
  |======================================================================| 100%
```

```
## Input matrix: 4x5
```

```
## Output matrix: 4x5
```

```
## Some gene expression vectors were collapsed into single vector
```

```
##   by sum rule
```

```
## $output
##      [,1] [,2] [,3] [,4] [,5]
## 5460    1    5    9   13   17
## 6657    2    6   10   14   18
## 4609    3    7   11   15   19
## 9314    4    8   12   16   20
##
## $ctable
##      Left     Right
## [1,] "POU5F1" "5460"
## [2,] "SOX2"   "6657"
## [3,] "MYC"    "4609"
## [4,] "KLF4"   "9314"
```

# 4 Step.3: Normalize the count matrix

Finally, we introduce some situations to perform some normalization methods of gene expression matrix.

If a user converts a Seurat object to a SingleCellExperient object by using `as.SingleCellExperiment`,
the result of the `NormalizeData` function (log counts) is inherited to the SingleCellExperient object as follows;

```
pbmc2 <- NormalizeData(pbmc, normalization.method = "LogNormalize",
    scale.factor = 10000)
sce <- as.SingleCellExperiment(pbmc2)
assayNames(sce) # counts, logcounts
```

If the user want to use *[scater](https://bioconductor.org/packages/3.22/scater)* package,
`calculateCPM` or `normalize` function can calculate the normalized expression values as follows; (see also [the vignette of scater](https://bioconductor.org/packages/release/bioc/vignettes/scater/inst/doc/vignette-intro.html)).

```
if(!require(scater)){
    BiocManager::install("scater")
    library(scater)
}
sce <- SingleCellExperiment(assays=list(counts = input))
cpm(sce) <- calculateCPM(sce)
sce <- normalize(sce)
assayNames(sce) # counts, normcounts, logcounts, cpm
```

Any original normalization can be stored in the sce.
For example, we can calculate the value of count per median (CPMED) as follows;

```
# User's Original Normalization Function
CPMED <- function(input){
    libsize <- colSums(input)
    median(libsize) * t(t(input) / libsize)
}
# Normalization
normcounts(sce) <- log10(CPMED(counts(sce)) + 1)
```

We recommend using the normcounts slot to save such original normalization values.
After the normalization, such values can be specified by `assayNames` option in `cellCellRanks` `cellCellDecomp` and `cellCellReport` functions.

# Session information

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
##  [1] scTGIF_1.24.0
##  [2] Homo.sapiens_1.3.1
##  [3] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [4] org.Hs.eg.db_3.22.0
##  [5] GO.db_3.22.0
##  [6] OrganismDbi_1.52.0
##  [7] GenomicFeatures_1.62.0
##  [8] AnnotationDbi_1.72.0
##  [9] SingleCellExperiment_1.32.0
## [10] SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0
## [12] GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0
## [14] IRanges_2.44.0
## [15] S4Vectors_0.48.0
## [16] MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0
## [18] scTensor_2.20.0
## [19] RSQLite_2.4.3
## [20] LRBaseDbi_2.20.0
## [21] AnnotationHub_4.0.0
## [22] BiocFileCache_3.0.0
## [23] dbplyr_2.5.1
## [24] BiocGenerics_0.56.0
## [25] generics_0.1.4
## [26] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                 bitops_1.0-9             enrichplot_1.30.0
##   [4] httr_1.4.7               webshot_0.5.5            RColorBrewer_1.1-3
##   [7] Rgraphviz_2.54.0         tools_4.5.1              backports_1.5.0
##  [10] R6_2.6.1                 lazyeval_0.2.2           withr_3.0.2
##  [13] graphite_1.56.0          gridExtra_2.3            schex_1.24.0
##  [16] fdrtool_1.2.18           cli_3.6.5                TSP_1.2-5
##  [19] entropy_1.3.2            sass_0.4.10              S7_0.2.0
##  [22] genefilter_1.92.0        meshr_2.16.0             Rsamtools_2.26.0
##  [25] systemfonts_1.3.1        yulab.utils_0.2.1        gson_0.1.0
##  [28] DOSE_4.4.0               R.utils_2.13.0           MeSHDbi_1.46.0
##  [31] AnnotationForge_1.52.0   dichromat_2.0-0.1        nnTensor_1.3.0
##  [34] plotrix_3.8-4            maps_3.4.3               visNetwork_2.1.4
##  [37] gridGraphics_0.5-1       GOstats_2.76.0           BiocIO_1.20.0
##  [40] dplyr_1.1.4              dendextend_1.19.1        Matrix_1.7-4
##  [43] abind_1.4-8              R.methodsS3_1.8.2        lifecycle_1.0.4
##  [46] yaml_2.3.10              qvalue_2.42.0            SparseArray_1.10.0
##  [49] grid_4.5.1               blob_1.2.4               misc3d_0.9-1
##  [52] crayon_1.5.3             ggtangle_0.0.7           lattice_0.22-7
##  [55] msigdbr_25.1.1           cowplot_1.2.0            cigarillo_1.0.0
##  [58] annotate_1.88.0          KEGGREST_1.50.0          magick_2.9.0
##  [61] pillar_1.11.1            knitr_1.50               fgsea_1.36.0
##  [64] tcltk_4.5.1              rjson_0.2.23             codetools_0.2-20
##  [67] fastmatch_1.1-6          glue_1.8.0               ggiraph_0.9.2
##  [70] outliers_0.15            ggfun_0.2.0              fontLiberation_0.1.0
##  [73] data.table_1.17.8        vctrs_0.6.5              png_0.1-8
##  [76] treeio_1.34.0            spam_2.11-1              rTensor_1.4.9
##  [79] gtable_0.3.6             assertthat_0.2.1         cachem_1.1.0
##  [82] xfun_0.53                S4Arrays_1.10.0          tidygraph_1.3.1
##  [85] survival_3.8-3           seriation_1.5.8          iterators_1.0.14
##  [88] tinytex_0.57             fields_17.1              nlme_3.1-168
##  [91] Category_2.76.0          ggtree_4.0.0             bit64_4.6.0-1
##  [94] fontquiver_0.2.1         filelock_1.0.3           bslib_0.9.0
##  [97] DBI_1.2.3                tidyselect_1.2.1         bit_4.6.0
## [100] compiler_4.5.1           curl_7.0.0               httr2_1.2.1
## [103] graph_1.88.0             fontBitstreamVera_0.1.1  DelayedArray_0.36.0
## [106] plotly_4.11.0            bookdown_0.45            rtracklayer_1.70.0
## [109] checkmate_2.3.3          scales_1.4.0             hexbin_1.28.5
## [112] RBGL_1.86.0              plot3D_1.4.2             rappdirs_0.3.3
## [115] stringr_1.5.2            digest_0.6.37            rmarkdown_2.30
## [118] ca_0.71.1                XVector_0.50.0           htmltools_0.5.8.1
## [121] pkgconfig_2.0.3          fastmap_1.2.0            rlang_1.1.6
## [124] htmlwidgets_1.6.4        farver_2.1.2             jquerylib_0.1.4
## [127] jsonlite_2.0.0           BiocParallel_1.44.0      GOSemSim_2.36.0
## [130] R.oo_1.27.1              RCurl_1.98-1.17          magrittr_2.0.4
## [133] ggplotify_0.1.3          dotCall64_1.2            patchwork_1.3.2
## [136] Rcpp_1.1.0               babelgene_22.9           ape_5.8-1
## [139] viridis_0.6.5            gdtools_0.4.4            stringi_1.8.7
## [142] tagcloud_0.7.0           ggraph_2.2.2             MASS_7.3-65
## [145] plyr_1.8.9               parallel_4.5.1           ggrepel_0.9.6
## [148] Biostrings_2.78.0        graphlayouts_1.2.2       splines_4.5.1
## [151] igraph_2.2.1             reshape2_1.4.4           BiocVersion_3.22.0
## [154] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
## [157] foreach_1.5.2            tweenr_2.0.3             tidyr_1.3.1
## [160] purrr_1.1.0              polyclip_1.10-7          heatmaply_1.6.0
## [163] ggplot2_4.0.0            ReactomePA_1.54.0        ggforce_0.5.0
## [166] xtable_1.8-4             restfulr_0.0.16          reactome.db_1.94.0
## [169] tidytree_0.4.6           viridisLite_0.4.2        tibble_3.3.0
## [172] aplot_0.2.9              ccTensor_1.0.3           GenomicAlignments_1.46.0
## [175] memoise_2.0.1            registry_0.5-1           cluster_2.1.8.1
## [178] concaveman_1.2.0         GSEABase_1.72.0
```