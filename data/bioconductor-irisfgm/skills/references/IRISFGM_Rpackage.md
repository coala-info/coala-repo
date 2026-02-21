# IRIS-FGM vignette

### IRIS-FGM

Yuzhou Chang

#### 12 Aug, 2020

#### Abstract

IRIS-FGM, integrative and interpretation system for co-expression module analysisa biclustering-based gene regulation inference and cell type prediction method for single-cell RNA-Seq data. This R package integrates in-house computational tools and provides two types of analysis, including QUBIC2 based co-expression analysis and LTMG (left-truncated mixture Gaussian model) based scRNA-Seq analysis (quick mode). IRIS-FGM contains fourfour major steps; (i) data preprocessing and regulatory signal modelingd LTMG modeling; (ii) co-regulated expression gene module identification; (iii) cell clustering; (iv) co-expression module and differentially expressed gene analysis.

# Contents

* [Intorduction to IRIS-FGM](#intorduction-to-iris-fgm)
  + [General introduction](#general-introduction)
  + [Main function](#main-function)
  + [Obejct structure](#obejct-structure)
* [Requirements](#requirements)
  + [Environment](#environment)
  + [Input](#input)
  + [Others](#others)
* [Installation](#installation)
* [Example dataset](#example-dataset)
* [1. Input data, create IRISCEM object, add meta information, and preprocessing.](#input-data-create-iriscem-object-add-meta-information-and-preprocessing.)
  + [Input data](#input-data)
  + [Add meta information](#add-meta-information)
  + [Preprocesing](#preprocesing)
* [2. Run LTMG](#run-ltmg)
* [3. Biclustering](#biclustering)
  + [LTMG-discretized bicluster (recommend for small single cell RNA-seq data)](#ltmg-discretized-bicluster-recommend-for-small-single-cell-rna-seq-data)
* [4. Cell clustering](#cell-clustering)
  + [4.1 Perform dimension Reduction and implement Seurat clustering method.](#perform-dimension-reduction-and-implement-seurat-clustering-method.)
  + [4.2 Predict cell clusters based on Markove clustering](#predict-cell-clusters-based-on-markove-clustering)
* [5. Visualization and interpretation](#visualization-and-interpretation)
  + [5.1 Bicluster results](#bicluster-results)
    - [Check gene overlapping of FGMs. The results show first 19 FMGs have overlapping genes, and there is no overlapping gene between first 1 FMGs and the 15th FGM.](#check-gene-overlapping-of-fgms.-the-results-show-first-19-fmgs-have-overlapping-genes-and-there-is-no-overlapping-gene-between-first-1-fmgs-and-the-15th-fgm.)
    - [Heatmap shows relations between any two biclusters (1th and 15th bicluster).](#heatmap-shows-relations-between-any-two-biclusters-1th-and-15th-bicluster.)
    - [Co-expression network shows gene correlation relations in one select FGM.](#co-expression-network-shows-gene-correlation-relations-in-one-select-fgm.)
  + [5.1 cell clustering results](#cell-clustering-results)
    - [Visualize cell clustering results](#visualize-cell-clustering-results)
    - [Find global marker based on Seurat method](#find-global-marker-based-on-seurat-method)
* [sessioninfo](#sessioninfo)

# Intorduction to IRIS-FGM

## General introduction

IRIS-FGM integrates in-house and state-of-the-art computational tools and provides two analysis strategies, including bicluster-based co-expression gene analysis [(Xie, et al., 2020)](https://academic.oup.com/bioinformatics/article-abstract/36/4/1143/5567116?redirectedFrom=fulltext) and LTMG (left-truncated mixture Gaussian model)-embedded scRNA-Seq analysis [(Wan, et al., 2019)](https://academic.oup.com/nar/article/47/18/e111/5542876).

## Main function

The main idea of IRIS-FGM consists of two major strategies:

* 1. biclustering
* 2. quick mode (cluster)

## Obejct structure

The computational frame is constructed under the S4 data structure in R. The structure of `BRIC object` is:

* -**BRIC\_Object:** *name of object is called BRIC.*
  + -**raw\_count:** *raw data matrix (gene in row, cell in columns, prefer using gene symbol).*
  + -**processed\_count:** *normalized and imputation (default: FALSE).*
  + -**Meta\_info:** *cell classification information based on LTMG and Bicluster.*
  + -**Discretization:** *discretized matrix based on qubic 1.0, which prepares for microarry and bulk RNA-Seq analysis.*
  + -**LTMG:** *LTMG slot is for storing relative results from first strategy.*
    - -**LTMG\_discrete:** *Condition assigned matrix, which is generating from LTMG model.*
    - -**LTMG\_BinarySingleSignal:** *binary matrix based on gene “on /off.”*
    - -**LTMG\_BinaryMultisignal:** *binary matrix based on multiple condition.*
    - -**DimReduce:** *include three dimension loading score, including PCA, Tsne, and UMAP*
    - -**MarkerGene:** *Marker gene based on cell type identified by Seurat clustering method.*
    - -**Pathway:** *based on marker gene.*
    - -**tmp.Seurat:** *temporary Seurat object. In this Seurat Object, the starting matrix is LTMG signalling matrix.*
  + -**Bicluster:**
    - -**Coreg\_gene:** *co-regulatory genes are stored in this slot as dataframe; the first column is gene name and the second column is module number.*
    - -**CoCond\_cell:** *co-condition cell are stored in this slot as dataframe; the first column is cell name and the second column is module number.*
    - -**MarkerGene:** *Marker gene based on cell type identified by Markov chain clustering algorithm.*
    - -**Pathway:** *genes based on co-expression gene of gene module (from Coreg\_gene).*

# Requirements

## Environment

We recommend user to install IRIS-FGM on large memory (32GB) based linux operation system if user aims at analyzing bicluster-based co-expression analysis; if user aims at analyzing data by quick mode, we recommend to install IRIS-FGM on small memeory (8GB) based Windows or linux operation system; IRIS-FGM does not support MAC.
We will assum you have the following installed:

* R (equal or greater than 3.5)

Pre-install packge

```
if(!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
# install from bioconductor
BiocManager::install(c('org.Mm.eg.db','multtest', 'org.Hs.eg.db','clusterProfiler','DEsingle', 'DrImpute', 'scater', 'scran'))
# install from cran
chooseCRANmirror()
BiocManager::install(c('devtools', 'AdaptGauss', "pheatmap", 'mixtools','MCL', 'anocva', "Polychrome", 'qgraph','Rtools','ggpubr',"ggraph", "Seurat"))
```

## Input

1. The input to IRIS-FGM is the single-cell RNA-seq expression matrix:

* Rows correspond to genes and columns correspond to cells.
* Expression units: the preferred expression values are RPKM/FPKM/CPM.
* The data file should be tab delimited.

2. IRIS-FGM also accepts output files from 10X CellRanger, includinhg a folder which contains three individual files and h5 file.

## Others

When you perform co-expression analysis, it will output several intermediate files, thus please make sure that you have write permission to the folder where IRIS-FGM is located.

# Installation

For installation, simply type the following command in your R console, please select option 3 when R asks user to update packages:

```
BiocManager::install("IRISFGM")
```

# Example dataset

This tutorial run on a real dataset to illustrate the results obtained at each step.

As example, we will use Yan’s data, a dataset containing 90 cells and 20,214 genes from human embryo, to conduct cell type prediction.

> Yan, L. et al. Single-cell RNA-Seq profiling of human preimplantation embryos and embryonic stem cells. Nat. Struct. Mol. Biol. 20, 1131-1139 (2013)

The original expression matrix was downloaded from <https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/yan/nsmb.2660-S2.csv>. The expression is provided as RPKM value. For convenience, we removed the space in the column names and deleted the second column(Transcript\_ID). The processed data is available at <https://bmbl.bmi.osumc.edu/downloadFiles/Yan_expression.txt>.

# 1. Input data, create IRISCEM object, add meta information, and preprocessing.

IRIS-FGM can accepted 10X chromium input files, including a folder (contain gene name, cell name, and sparse matrix) and .h5 file.

## Input data

1. set working directory and import library

```
# dir.create("your working directory",recursive = TRUE)
# setwd("your working directory")
library(IRISFGM)
```

```
##
```

```
##
```

```
## Registered S3 method overwritten by 'gamlss':
##   method   from
##   print.ri bit
```

```
##
```

2. Read from .h5 file.

```
# if you will use the ".h5" as input file, please uncomment the following command.
# input_matrix <- ReadFrom10X_h5("dir_to_your_hdf5_file")
```

3. Read from 10X folder, which should contain three files (barcode, gene name, and sparse matrix)

```
# if you will use the 10x folder as input file, please uncomment the following command.
# input_matrix <- ReadFrom10X_folder("dir_to_10x_folder")
```

4. Read from .csv or .txt file

First, we should download data from the link, then we will use this data set as example to run the pipeline.

```
InputMatrix <- read.table(url("https://bmbl.bmi.osumc.edu/downloadFiles/Yan_expression.txt"),
header = TRUE,
row.names = 1,
check.names = FALSE)
```

## Add meta information

1. For the computational efficiency, we will use subsampling data, and create IRIS-FGM object.

```
set.seed(123)
seed_idx <- sample(1:nrow(InputMatrix),3000)
InputMatrix_sub <- InputMatrix[seed_idx,]
object <- CreateIRISFGMObject(InputMatrix_sub)
```

```
## Creating IRISCEM object.
## The original input file contains 90 cells and 3000 genes
## Removed 97 genes that total expression value is equal or less than 0
## Removed 0 cells that number of expressed gene is equal or less than 0
```

2. Addmeta: this step can add customized cell label by user, the format of file passing to `meta.info` is data frame of which row name should be cell ID, and column name should be cell type.

```
my_meta <- read.table(url("https://bmbl.bmi.osumc.edu/downloadFiles/Yan_cell_label.txt"),header = TRUE,row.names = 1)
object <- AddMeta(object, meta.info = my_meta)
```

3. plotmeta: plot meta information based on RNA count and Feature number. This step is for the following subset step in terms of filtering out low quality data.

```
PlotMeta(object)
```

![](data:image/png;base64...)

4. remove low quality data based on the previous plot.

```
object <- SubsetData(object , nFeature.upper=2000,nFeature.lower=250)
```

## Preprocesing

User can choose perform normalization or imputation based on their need. The normalization method has two options, one is the simplist CPM normalization (default `normalization = 'cpm'`). The other is from package scran and can be opened by using parameter `normalization = 'scran'`, . The imputation method is from package DrImpute and can be opened by using parameter `IsImputation = TRUE` (default as closed).

```
object <- ProcessData(object, normalization = "cpm", IsImputation = FALSE)
```

# 2. Run LTMG

The argument `Gene_use = 500` is top 500 highlt variant genes which are selected to run LTMG. For quick mode, we recommend to use top 2000 gene (here we use top 500 gene for saving time). On the contrary, for co-expression gene analysis, we recommend to use all gene by changing `Gene_use = "all"`.

```
# do not show progress bar
quiet <- function(x) {
sink(tempfile())
on.exit(sink())
invisible(force(x))
}
# demo only run top 500 gene for saving time.
object <- quiet(RunLTMG(object, Gene_use = "500"))
# you can get LTMG signal matrix
LTMG_Matrix <- GetLTMGmatrix(object)
LTMG_Matrix[1:5,1:5]
```

```
##          OoCyte_1 OoCyte_2 OoCyte_3 Zygote_2 2_Cell_embryo_1_Cell_1
## MTRNR2L2        1        2        2        2                      2
## TPT1            1        2        2        2                      2
## UBB             2        2        2        2                      2
## FABP5           2        2        2        2                      2
## PTTG1           2        2        2        2                      2
```

# 3. Biclustering

IRIS-FGM can provide biclustering function, which is based on our in-house novel algorithm,
QUBIC2 (<https://github.com/maqin2001/qubic2>). Here we will show the basic biclustering
usage of IRIS-FGM using a \(500\times 87\) expression matrix generated from previous top 500 variant genes.
However, we recommend user should use “Gene\_use = all”" to generate LTMG matrix.

## LTMG-discretized bicluster (recommend for small single cell RNA-seq data)

User can type the following command to run discretization (LTMG) + biclustering directly:

```
object <- CalBinaryMultiSignal(object)
```

```
##
  |
  |                                                                      |   0%
  |
  |                                                                      |   1%
  |
  |=                                                                     |   1%
  |
  |=                                                                     |   2%
  |
  |==                                                                    |   2%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |===                                                                   |   5%
  |
  |====                                                                  |   5%
  |
  |====                                                                  |   6%
  |
  |=====                                                                 |   7%
  |
  |=====                                                                 |   8%
  |
  |======                                                                |   8%
  |
  |======                                                                |   9%
  |
  |=======                                                               |   9%
  |
  |=======                                                               |  10%
  |
  |=======                                                               |  11%
  |
  |========                                                              |  11%
  |
  |========                                                              |  12%
  |
  |=========                                                             |  12%
  |
  |=========                                                             |  13%
  |
  |==========                                                            |  14%
  |
  |==========                                                            |  15%
  |
  |===========                                                           |  15%
  |
  |===========                                                           |  16%
  |
  |============                                                          |  17%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  19%
  |
  |==============                                                        |  20%
  |
  |==============                                                        |  21%
  |
  |===============                                                       |  21%
  |
  |===============                                                       |  22%
  |
  |================                                                      |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  24%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |===================                                                   |  28%
  |
  |====================                                                  |  28%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  29%
  |
  |=====================                                                 |  30%
  |
  |=====================                                                 |  31%
  |
  |======================                                                |  31%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |========================                                              |  35%
  |
  |=========================                                             |  35%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |==========================                                            |  38%
  |
  |===========================                                           |  38%
  |
  |===========================                                           |  39%
  |
  |============================                                          |  39%
  |
  |============================                                          |  40%
  |
  |============================                                          |  41%
  |
  |=============================                                         |  41%
  |
  |=============================                                         |  42%
  |
  |==============================                                        |  42%
  |
  |==============================                                        |  43%
  |
  |===============================                                       |  44%
  |
  |===============================                                       |  45%
  |
  |================================                                      |  45%
  |
  |================================                                      |  46%
  |
  |=================================                                     |  47%
  |
  |=================================                                     |  48%
  |
  |==================================                                    |  48%
  |
  |==================================                                    |  49%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  50%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  54%
  |
  |======================================                                |  55%
  |
  |=======================================                               |  55%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  57%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  59%
  |
  |==========================================                            |  60%
  |
  |==========================================                            |  61%
  |
  |===========================================                           |  61%
  |
  |===========================================                           |  62%
  |
  |============================================                          |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |=============================================                         |  65%
  |
  |==============================================                        |  65%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |===============================================                       |  68%
  |
  |================================================                      |  68%
  |
  |================================================                      |  69%
  |
  |=================================================                     |  69%
  |
  |=================================================                     |  70%
  |
  |=================================================                     |  71%
  |
  |==================================================                    |  71%
  |
  |==================================================                    |  72%
  |
  |===================================================                   |  72%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |====================================================                  |  75%
  |
  |=====================================================                 |  75%
  |
  |=====================================================                 |  76%
  |
  |======================================================                |  77%
  |
  |======================================================                |  78%
  |
  |=======================================================               |  78%
  |
  |=======================================================               |  79%
  |
  |========================================================              |  79%
  |
  |========================================================              |  80%
  |
  |========================================================              |  81%
  |
  |=========================================================             |  81%
  |
  |=========================================================             |  82%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  83%
  |
  |===========================================================           |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  87%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  89%
  |
  |===============================================================       |  90%
  |
  |===============================================================       |  91%
  |
  |================================================================      |  91%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  94%
  |
  |==================================================================    |  95%
  |
  |===================================================================   |  95%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |====================================================================  |  98%
  |
  |===================================================================== |  98%
  |
  |===================================================================== |  99%
  |
  |======================================================================|  99%
  |
  |======================================================================| 100%
```

```
# Please uncomment the following command and make sure to set a correct working directory so that the following command will generate intermeidate files.
# object <- RunBicluster(object, DiscretizationModel = "LTMG",OpenDual = FALSE,
#                        NumBlockOutput = 100, BlockOverlap = 0.5, BlockCellMin = 25)
```

(The default parameters in IRIS-FGM are BlockCellMin=15, BlockOverlap=0.7,
Extension=0.90, NumBlockOutput=100 you may use other parameters as you like, just specify them in the argument)

# 4. Cell clustering

## 4.1 Perform dimension Reduction and implement Seurat clustering method.

User can use `reduction = "umap"` or `reductopm = "tsne"` to perform dimension reduction.

```
# demo only run top 500 gene for saving time.
object <- RunDimensionReduction(object, mat.source = "UMImatrix",reduction = "umap")
```

```
## Centering and scaling data matrix
```

```
## Warning in irlba(A = t(x = object), nv = npcs, ...): You're computing too large
## a percentage of total singular values, use a standard svd instead.
```

```
object <- RunClassification(object, k.param = 20, resolution = 0.8, algorithm = 1)
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

```
## Modularity Optimizer version 1.3.0 by Ludo Waltman and Nees Jan van Eck
##
## Number of nodes: 87
## Number of edges: 1450
##
## Running Louvain algorithm...
## Maximum modularity in 10 random starts: 0.6856
## Number of communities: 3
## Elapsed time: 0 seconds
```

## 4.2 Predict cell clusters based on Markove clustering

The cell cluster prediction of IRIS-FGM is based on the biclustering results.
In short, it will construct a weighted graph based on the biclusters and then do clustering on the weighted graph. To facilitate the process, we will use the pre-generated object to perform cell clustering result based on biclustering results.

```
# Please uncomment the following command and make sure your working directory is the same as the directory containing intermediate output files.
# object <- FindClassBasedOnMC(object)
```

```
data("example_object")
getMeta(example_object)[1:5,]
```

```
##          ncount_RNA nFeature Cluster Seurat_r_0.8_k_20 MC_Label
## OoCyte_1   28202.91      657       1                 2        1
## OoCyte_2   27029.84      660       1                 2        1
## OoCyte_3   26520.14      672       1                 2        1
## Zygote_1   24796.04      681       2                 2        1
## Zygote_2   23575.54      679       2                 2        1
```

# 5. Visualization and interpretation

## 5.1 Bicluster results

### Check gene overlapping of FGMs. The results show first 19 FMGs have overlapping genes, and there is no overlapping gene between first 1 FMGs and the 15th FGM.

```
PlotNetwork(example_object,N.bicluster = c(1:20))
```

![](data:image/png;base64...)

### Heatmap shows relations between any two biclusters (1th and 15th bicluster).

```
PlotHeatmap(example_object,N.bicluster = c(1, 20),show.clusters = TRUE,show.annotation=TRUE)
```

![](data:image/png;base64...)

### Co-expression network shows gene correlation relations in one select FGM.

```
PlotModuleNetwork(example_object,N.bicluster = 3,method = "spearman",
cutoff.neg = -0.5,
cutoff.pos = 0.5,
layout = "circle",
node.label = TRUE,
node.col = "black",
node.label.cex = 10)
```

![](data:image/png;base64...)

## 5.1 cell clustering results

### Visualize cell clustering results

```
# cell clustering results based on Seurat clustering method
PlotDimension(example_object,  reduction = "umap",idents = "Seurat_r_0.8_k_20")
```

![](data:image/png;base64...)

```
# cell clustering results based on MCL clustering method
PlotDimension(example_object, reduction = "umap",idents = "MC_Label")
```

![](data:image/png;base64...)

### Find global marker based on Seurat method

```
global_marker <- FindGlobalMarkers(example_object,idents = "Seurat_r_0.8_k_20")
```

```
## Calculating cluster 0
```

```
## Calculating cluster 1
```

```
## Calculating cluster 2
```

```
PlotMarkerHeatmap(Globalmarkers = global_marker,object = example_object,idents ="Seurat_r_0.8_k_20")
```

![](data:image/png;base64...)

# sessioninfo

```
sessionInfo()
```

```
## R version 4.1.0 (2021-05-18)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] IRISFGM_1.0.0    BiocStyle_2.20.0
##
## loaded via a namespace (and not attached):
##   [1] scattermore_0.7             maxLik_1.4-8
##   [3] SeuratObject_4.0.1          tidyr_1.1.3
##   [5] ggplot2_3.3.3               bit64_4.0.5
##   [7] knitr_1.33                  irlba_2.3.3
##   [9] DelayedArray_0.18.0         data.table_1.14.0
##  [11] rpart_4.1-15                KEGGREST_1.32.0
##  [13] RCurl_1.98-1.3              generics_0.1.0
##  [15] ScaledMatrix_1.0.0          BiocGenerics_0.38.0
##  [17] org.Mm.eg.db_3.13.0         Polychrome_1.2.6
##  [19] cowplot_1.1.1               RSQLite_2.2.7
##  [21] shadowtext_0.0.8            RANN_2.6.1
##  [23] VGAM_1.1-5                  future_1.21.0
##  [25] bit_4.0.4                   enrichplot_1.12.0
##  [27] spatstat.data_2.1-0         httpuv_1.6.1
##  [29] SummarizedExperiment_1.22.0 DrImpute_1.0
##  [31] assertthat_0.2.1            viridis_0.6.1
##  [33] xfun_0.23                   hms_1.1.0
##  [35] jquerylib_0.1.4             evaluate_0.14
##  [37] promises_1.2.0.1            fansi_0.4.2
##  [39] readxl_1.3.1                igraph_1.2.6
##  [41] DBI_1.1.1                   htmlwidgets_1.5.3
##  [43] spatstat.geom_2.1-0         stats4_4.1.0
##  [45] purrr_0.3.4                 ellipsis_0.3.2
##  [47] RSpectra_0.16-0             dplyr_1.0.6
##  [49] ggpubr_0.4.0                backports_1.2.1
##  [51] bookdown_0.22               sparseMatrixStats_1.4.0
##  [53] deldir_0.2-10               MatrixGenerics_1.4.0
##  [55] vctrs_0.3.8                 SingleCellExperiment_1.14.0
##  [57] Biobase_2.52.0              ROCR_1.0-11
##  [59] abind_1.4-5                 cachem_1.0.5
##  [61] ggforce_0.3.3               bdsmatrix_1.3-4
##  [63] sctransform_0.3.2           gamlss_5.3-4
##  [65] treeio_1.16.0               scran_1.20.0
##  [67] goftest_1.2-2               cluster_2.1.2
##  [69] DOSE_3.18.0                 segmented_1.3-4
##  [71] ape_5.5                     lazyeval_0.2.2
##  [73] crayon_1.4.1                labeling_0.4.2
##  [75] edgeR_3.34.0                pkgconfig_2.0.3
##  [77] tweenr_1.0.2                GenomeInfoDb_1.28.0
##  [79] vipor_0.4.5                 nlme_3.1-152
##  [81] rlang_0.4.11                globals_0.14.0
##  [83] lifecycle_1.0.0             miniUI_0.1.1.1
##  [85] sandwich_3.0-1              downloader_0.4
##  [87] gamlss.data_6.0-1           rsvd_1.0.5
##  [89] cellranger_1.1.0            polyclip_1.10-0
##  [91] matrixStats_0.58.0          lmtest_0.9-38
##  [93] Matrix_1.3-3                aplot_0.0.6
##  [95] carData_3.0-4               zoo_1.8-9
##  [97] beeswarm_0.3.1              ggridges_0.5.3
##  [99] pheatmap_1.0.12             png_0.1-7
## [101] viridisLite_0.4.0           bitops_1.0-7
## [103] KernSmooth_2.23-20          Biostrings_2.60.0
## [105] DelayedMatrixStats_1.14.0   blob_1.2.1
## [107] stringr_1.4.0               qvalue_2.24.0
## [109] parallelly_1.25.0           rstatix_0.7.0
## [111] S4Vectors_0.30.0            ggsignif_0.6.1
## [113] beachmat_2.8.0              scales_1.1.1
## [115] memoise_2.0.0               magrittr_2.0.1
## [117] plyr_1.8.6                  ica_1.0-2
## [119] zlibbioc_1.38.0             compiler_4.1.0
## [121] scatterpie_0.1.6            miscTools_0.6-26
## [123] dqrng_0.3.0                 bbmle_1.0.23.1
## [125] RColorBrewer_1.1-2          fitdistrplus_1.1-3
## [127] XVector_0.32.0              listenv_0.8.0
## [129] patchwork_1.1.1             pbapply_1.4-3
## [131] MASS_7.3-54                 mgcv_1.8-35
## [133] tidyselect_1.1.1            stringi_1.6.2
## [135] forcats_0.5.1               highr_0.9
## [137] yaml_2.2.1                  GOSemSim_2.18.0
## [139] locfit_1.5-9.4              BiocSingular_1.8.0
## [141] ggrepel_0.9.1               grid_4.1.0
## [143] sass_0.4.0                  fastmatch_1.1-0
## [145] tools_4.1.0                 future.apply_1.7.0
## [147] parallel_4.1.0              rio_0.5.26
## [149] gamlss.dist_5.3-2           bluster_1.2.0
## [151] foreign_0.8-81              metapod_1.0.0
## [153] gridExtra_2.3               scatterplot3d_0.3-41
## [155] farver_2.1.0                Rtsne_0.15
## [157] ggraph_2.0.5                DEsingle_1.12.0
## [159] digest_0.6.27               rvcheck_0.1.8
## [161] BiocManager_1.30.15         shiny_1.6.0
## [163] pracma_2.3.3                AdaptGauss_1.5.6
## [165] Rcpp_1.0.6                  GenomicRanges_1.44.0
## [167] car_3.0-10                  broom_0.7.6
## [169] pscl_1.5.5                  scuttle_1.2.0
## [171] later_1.2.0                 RcppAnnoy_0.0.18
## [173] org.Hs.eg.db_3.13.0         httr_1.4.2
## [175] AnnotationDbi_1.54.0        kernlab_0.9-29
## [177] colorspace_2.0-1            tensor_1.5
## [179] reticulate_1.20             IRanges_2.26.0
## [181] splines_4.1.0               statmod_1.4.36
## [183] uwot_0.1.10                 tidytree_0.3.3
## [185] expm_0.999-6                spatstat.utils_2.1-0
## [187] scater_1.20.0               graphlayouts_0.7.1
## [189] plotly_4.9.3                MCL_1.0
## [191] xtable_1.8-4                jsonlite_1.7.2
## [193] ggtree_3.0.0                tidygraph_1.2.0
## [195] R6_2.5.0                    pillar_1.6.1
## [197] htmltools_0.5.1.1           mime_0.10
## [199] glue_1.4.2                  fastmap_1.1.0
## [201] clusterProfiler_4.0.0       BiocParallel_1.26.0
## [203] BiocNeighbors_1.10.0        anocva_0.1.1
## [205] codetools_0.2-18            fgsea_1.18.0
## [207] mvtnorm_1.1-1               utf8_1.2.1
## [209] lattice_0.20-44             bslib_0.2.5.1
## [211] spatstat.sparse_2.0-0       tibble_3.1.2
## [213] mixtools_1.2.0              numDeriv_2016.8-1.1
## [215] ggbeeswarm_0.6.0            curl_4.3.1
## [217] leiden_0.3.7                magick_2.7.2
## [219] zip_2.1.1                   GO.db_3.13.0
## [221] openxlsx_4.2.3              limma_3.48.0
## [223] survival_3.2-11             rmarkdown_2.8
## [225] munsell_0.5.0               DO.db_2.9
## [227] GenomeInfoDbData_1.2.6      haven_2.4.1
## [229] reshape2_1.4.4              gtable_0.3.0
## [231] spatstat.core_2.1-2         Seurat_4.0.1
```