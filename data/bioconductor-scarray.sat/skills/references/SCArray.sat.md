# Large-scale single-cell RNA-seq data analysis using GDS files and Seurat

Dr. Xiuwen Zheng (Genomics Research Center, AbbVie)

#### Feb 2023

# 1 Introduction

Single-cell RNA sequencing (scRNA-seq) has revolutionized our understanding of gene expression heterogeneity within complex biological systems. As scRNA-seq technology becomes increasingly accessible and cost-effective, experiments are generating data from larger and larger numbers of cells. However, the analysis of large scRNA-seq data remains a challenge, particularly in terms of scalability. While numerous analysis tools have been developed to tackle the complexities of scRNA-seq data, their scalability is often limited, posing a major bottleneck in the analysis of large-scale experiments. In particular, the R package [Seurat](https://cran.r-project.org/package%3DSeurat) is one of the most widely used tools for exploring and analyzing scRNA-seq data, but its scalability is often limited by available memory.

To address this issue, we introduce a new R package called “SCArray.sat” that extends the Seurat classes and functions to support Genomic Data Structure ([GDS](http://www.bioconductor.org/packages/gdsfmt)) files as a [DelayedArray](http://www.bioconductor.org/packages/DelayedArray) backend for data representation. GDS files store multiple dense and sparse array-based data sets in a hierarchical structure. This package defines a new class, called “SCArrayAssay” (derived from the Seurat class “Assay”), which wraps raw counts, normalized expressions, and scaled data matrices based on GDS-specific DelayedMatrix. It is designed to integrate seamlessly with the Seurat package to provide common data analysis in a workflow, with optimized algorithms for GDS data files.

~

![Overview of the SCArray framework.](data:image/svg+xml;base64...)

Figure 1: Overview of the SCArray framework

~

The SeuratObject package defines the `Assay` class with three members/slots `counts`, `data` and `scale.data` storing raw counts, normalized expressions and scaled data matrix respectively. However, `counts` and `data` should be either a dense matrix or a sparse matrix defined in the [Matrix](https://cran.r-project.org/package%3DMatrix) package. The scalability of the sparse matrix is limited by the number of non-zero values (should be < 2^31), since the Matrix package uses 32-bit indices internally. `scale.data` in the `Assay` class is defined as a dense matrix, so it is also limited by the available memory. The new class `SCArrayAssay` is derived from `Assay`, with three additional slots `counts2`, `data2` and `scale.data2` replacing the old ones. These new slots can be DelayedMatrix wrapping an on-disk data matrix, without loading the data in memory.

The SCArray.sat package takes advantage of the S3 object-oriented methods defined in the SeuratObject and Seurat packages to reduce code redundancy, by implementing the functions specific to the classes `SCArrayAssay` and `SC_GDSMatrix` (GDS-specific DelayedMatrix). Table 1 shows a list of key S3 methods for data analysis. For example, the function `NormalizeData.SC_GDSMatrix()` will be called when a `SC_GDSMatrix` object is passed to the S3 generic `NormalizeData()`, while `NormalizeData.Assay()` and `NormalizeData.Seurat()` are unchanged. In addition, the SCArray and SCArray.sat packages implement the optimized algorithms for the calculations, by reducing the on-disk data access and taking the GDS data structure into account.

~

**Table 1: Key S3 methods implemented in the SCArray.sat package.**

| **Methods** | **Description** | **Note** |
| --- | --- | --- |
| GetAssayData.SCArrayAssay() | Accessor function for ‘SCArrayAssay’ objects |  |
| SetAssayData.SCArrayAssay | Setter functions for ‘Assay’ objects |  |
| NormalizeData.SC\_GDSMatrix() | Normalize raw count data | Store a DelayedMatrix |
| ScaleData.SC\_GDSMatrix() | Scale and center the normalized data |  |
| FindVariableFeatures.SC\_GDSMatrix() | Identifies features |  |
| RunPCA.SC\_GDSMatrix() | Run a PCA dimensionality reduction |  |

*SC\_GDSMatrix: GDS- and single-cell- specific DelayedMatrix.*

~

~

# 2 Installation

* Requires [SCArray](http://www.bioconductor.org/packages/SCArray/) (≥ v1.7.13), [SeuratObject](https://cran.r-project.org/package%3DSeuratObject) (≥ v4.0), [Seurat](https://cran.r-project.org/package%3DSeurat) (≥ v4.0)
* Bioconductor repository

To install this package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("SCArray.sat")
```

# 3 Examples

## 3.1 Small Datasets

```
# Load the packages
suppressPackageStartupMessages({
    library(Seurat)
    library(SCArray)
    library(SCArray.sat)
})

# Input GDS file with raw counts
fn <- system.file("extdata", "example.gds", package="SCArray")

# show the file contents
(f <- scOpen(fn))
```

```
## Object of class "SCArrayFileClass"
## File: /home/biocbuild/bbs-3.22-bioc/R/site-library/SCArray/extdata/example.gds (504.7K)
## +    [  ] *
## |--+ feature.id   { Str8 1000 LZMA_ra(59.0%), 3.7K }
## |--+ sample.id   { Str8 850 LZMA_ra(13.2%), 1.8K }
## |--+ counts   { SparseReal32 1000x850 LZMA_ra(12.4%), 495.3K }
## |--+ feature.data   [  ]
## |--+ sample.data   [  ]
## |  |--+ Cell_ID   { Str8 850 LZMA_ra(13.2%), 1.8K }
## |  |--+ Cell_type   { Str8 850 LZMA_ra(2.98%), 165B }
## |  \--+ Timepoint   { Str8 850 LZMA_ra(3.73%), 229B }
## \--+ meta.data   [  ]
```

```
scClose(f)    # close the file

# Create a Seurat object from the GDS file
d <- scNewSeuratGDS(fn)
```

```
## Input: /home/biocbuild/bbs-3.22-bioc/R/site-library/SCArray/extdata/example.gds
##     counts: 1000 x 850
```

```
class(GetAssay(d))    # SCArrayAssay, derived from Assay
```

```
## [1] "SCArrayAssay"
## attr(,"package")
## [1] "SCArray.sat"
```

```
d <- NormalizeData(d)
```

```
## Performing log-normalization
```

```
d <- FindVariableFeatures(d, nfeatures=500)
```

```
## Calculating gene variances
## Calculating feature variances of standardized and clipped values
```

```
d <- ScaleData(d)
```

```
## Centering and scaling data matrix (SC_GDSMatrix [500x850])
```

**Let’s check the internal data matrices,**

```
# get the file name for the on-disk object
scGetFiles(d)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SCArray/extdata/example.gds"
```

```
# raw counts
m <- GetAssayData(d, slot="counts")
scGetFiles(m)    # the file name storing raw count data
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SCArray/extdata/example.gds"
```

```
m
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20        2.133695        1.423133   .        0.000000
##         GNB1        3.342935        2.346631   .        0.000000
##        RPL22        2.133695        2.183267   .        2.982560
##        PARK7        1.247608        2.487018   .        1.980463
##         ENO1        3.037644        3.431596   .        3.129447
##          ...               .               .   .               .
##         SSR4        0.000000        2.346631   .        2.810320
##        RPL10        3.342935        1.987902   .        1.416593
## SLC25A6-loc1        2.391330        2.183267   .        2.338835
##       RPS4Y1        0.000000        2.183267   .        1.980463
##         CD24        3.821575        1.744869   .        0.000000
##              1772122_180_D09
##       MRPL20        1.757196
##         GNB1        0.000000
##        RPL22        2.733620
##        PARK7        1.757196
##         ENO1        2.360130
##          ...               .
##         SSR4        1.223211
##        RPL10        2.103432
## SLC25A6-loc1        1.223211
##       RPS4Y1        2.360130
##         CD24        1.757196
```

```
# normalized expression
# the normalized data does not save in neither the file nor the memory
GetAssayData(d, slot="data")
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20        2.133695        1.423133   .        0.000000
##         GNB1        3.342935        2.346631   .        0.000000
##        RPL22        2.133695        2.183267   .        2.982560
##        PARK7        1.247608        2.487018   .        1.980463
##         ENO1        3.037644        3.431596   .        3.129447
##          ...               .               .   .               .
##         SSR4        0.000000        2.346631   .        2.810320
##        RPL10        3.342935        1.987902   .        1.416593
## SLC25A6-loc1        2.391330        2.183267   .        2.338835
##       RPS4Y1        0.000000        2.183267   .        1.980463
##         CD24        3.821575        1.744869   .        0.000000
##              1772122_180_D09
##       MRPL20        1.757196
##         GNB1        0.000000
##        RPL22        2.733620
##        PARK7        1.757196
##         ENO1        2.360130
##          ...               .
##         SSR4        1.223211
##        RPL10        2.103432
## SLC25A6-loc1        1.223211
##       RPS4Y1        2.360130
##         CD24        1.757196
```

```
# scaled and centered data matrix
# in this example, the scaled data does not save in neither the file nor the memory
GetAssayData(d, slot="scale.data")
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20        2.133695        1.423133   .        0.000000
##         GNB1        3.342935        2.346631   .        0.000000
##        RPL22        2.133695        2.183267   .        2.982560
##        PARK7        1.247608        2.487018   .        1.980463
##         ENO1        3.037644        3.431596   .        3.129447
##          ...               .               .   .               .
##         SSR4        0.000000        2.346631   .        2.810320
##        RPL10        3.342935        1.987902   .        1.416593
## SLC25A6-loc1        2.391330        2.183267   .        2.338835
##       RPS4Y1        0.000000        2.183267   .        1.980463
##         CD24        3.821575        1.744869   .        0.000000
##              1772122_180_D09
##       MRPL20        1.757196
##         GNB1        0.000000
##        RPL22        2.733620
##        PARK7        1.757196
##         ENO1        2.360130
##          ...               .
##         SSR4        1.223211
##        RPL10        2.103432
## SLC25A6-loc1        1.223211
##       RPS4Y1        2.360130
##         CD24        1.757196
```

**Perform PCA and UMAP:**

```
d <- RunPCA(d, ndims.print=1:2)
```

```
## Run PCA on the scaled data matrix ...
## Calculating the covariance matrix [500x500] ...
## PC_ 1
## Positive:  NPM1, RPLP1, RPL35, HNRNPA1P10, RPS20, RPS6, RPS19, RPS3, HMGB2, RPL32
##     RPL31P11-p1, HSPE1-MOB4, RPS23, HMGN2, RPS10-NUDT3, SNRPE, RPS24, CKS1B, H2AFZ, RPS14
##     RPA3, RPL18A, RPS18-loc6, EEF1B2, SHFM1, TMA7, KIAA0101, RPS3A, RPL37A, SNRPG
## Negative:  DCX, STMN2, MAP1B, NCAM1, GAP43, RTN1, BASP1, KIF5C, DPYSL3, DCC
##     MIAT, TTC3, MALAT1, CRMP1, SOX11, TUBB3, GPM6A, TUBA1A, WSB1, TUBB2B
##     RTN4, NNAT, SCG2, TUBB2A, MAP2, SEZ6L2, ONECUT2, MAP6, ENO2, CNTN2
## PC_ 2
## Positive:  TUBA1B, NUCKS1, HNRNPA2B1, MARCKSL1, MARCKS, HNRNPD, NES, HNRNPA1, KHDRBS1, LOC644936-p1
##     CKB, SET, MIR1244-3-loc4, TUBA1C, SNORD38A, DEK, SOX11, SFPQ, HNRNPU, IGF2BP1
##     CBX5, NASP, RPS17-loc1, SMC4, RPS17-loc2, RPL41, CENPF, HMGB1, HDAC2, RRM1
## Negative:  RPL13AP5, RPL31P11-p1, RPS14, RPS3A, TTR, RPL37A, RPL18A, PMCH, RPLP1, RPS19
##     RPL23A, RPS3, OLFM3, ANXA2, RPL32, RPS13, SULF1, CDO1, TRPM3, COL1A1
##     RPL18, MTRNR2L8, RNA5-8S5-loc2, MIR611, MALAT1, HTR2C, RNA5-8S5-loc1, RPS25, HES1, LDHA
```

```
DimPlot(d, reduction="pca")
```

![](data:image/png;base64...)

```
d <- RunUMAP(d, dims=1:50)    # use all PCs calculated by RunPCA()
DimPlot(d, reduction="umap")
```

![](data:image/png;base64...)

~

## 3.2 Large Datasets

Let’s download a large single-cell RNA-seq dataset from Bioconductor, and convert it to a GDS file. This step will take a while.

If the `TENxBrainData` package is not installed, run:

```
# install a Bioconductor package
BiocManager::install("TENxBrainData")
```

Then,

```
library(TENxBrainData)
library(SCArray)

# scRNA-seq data for 1.3 million brain cells from E18 mice (10X Genomics)
# the data will be downloaded automatically at the first time.
# raw count data is stored in HDF5 format
tenx <- TENxBrainData()
rownames(tenx) <- rowData(tenx)$Ensembl  # since rownames(tenx)=NULL

# save it to a GDS file
SCArray::scConvGDS(tenx, "1M_sc_neurons.gds")
```

After the file conversion, users can use this GDS file with Seurat to analyze the data.

~

~

# 4 Benchmarks

## 4.1 Test Datasets

The datasets used in the benchmark (Table 2) were generated from the 1.3 million brain cells, with the following R codes:

```
library(SCArray)
library(SCArray.sat)

sce <- scExperiment("1M_sc_neurons.gds")  # load the full 1.3M cells

# D100 dataset
scConvGDS(sce[, 1:1e5], "1M_sc_neurons_d100.gds")  # save to a GDS
# in-memory Seurat object
obj <- scMemory(scNewSeuratGDS("1M_sc_neurons_d100.gds"))
saveRDS(obj, "1M_sc_neurons_d100_seuratobj.rds")  # save to a RDS

# D250 dataset
scConvGDS(sce[, 1:2.5e5], "1M_sc_neurons_d250.gds")
obj <- scMemory(scNewSeuratGDS("1M_sc_neurons_d250.gds"))
saveRDS(obj, "1M_sc_neurons_d250_seuratobj.rds")

# D500 dataset
scConvGDS(sce[, 1:5e5], "1M_sc_neurons_d500.gds")
obj <- scMemory(scNewSeuratGDS("1M_sc_neurons_d500.gds"))
saveRDS(obj, "1M_sc_neurons_d500_seuratobj.rds")

# Dfull dataset
scConvGDS(sce, "1M_sc_neurons_dfull.gds")
```

**Table 2: Datasets in the benchmarks.**

| **Dataset** | **# of features** | **# of cells** | **GDS file** | **RDS (Seurat Object)** |
| --- | --- | --- | --- | --- |
| D100 | 27,998 | 100K | 209MB | 419MB |
| D250 | 27,998 | 250K | 529MB | 1.1GB |
| D500 | 27,998 | 500K | 1.1GB | 2.2GB |
| Dfull | 27,998 | 1.3 million | 2.8GB | Out of the limit of sparse matrix |

*the number of non-zeros should be < 2^31 in a sparse matrix.*

~

## 4.2 R Codes in the Benchmark

The following R script is used in the benchmark for testing GDS files, and the R codes for testing the Seurat Object are similar except the input file.

```
suppressPackageStartupMessages({
    library(Seurat)
    library(SCArray.sat)
})

# the input GDS file can be for d250, d500, dfull
fn <- "1M_sc_neurons_d100.gds"
d <- scNewSeuratGDS(fn)

d <- NormalizeData(d)
d <- FindVariableFeatures(d, nfeatures=2000)  # using the default
d <- ScaleData(d)

d <- RunPCA(d)
d <- RunUMAP(d, dims=1:50)

saveRDS(d, "d100.rds")    # or d250.rds, d500.rds, dfull.rds

q('no')
```

~

## 4.3 Memory Usage and Elapsed Time

With large test datasets, the SCArray.sat package significantly reduces the memory usages compared with the Seurat package, while the in-memory implementation in Seurat is only 2 times faster than SCArray.sat. When the full dataset “Dfull” was tested, Seurat failed to load the data since the number of non-zeros is out of the limit of sparse matrix.

![The benchmark on PCA & UMAP with large datasets (CPU: Intel Xeon Gold 6248 @2.50GHz, RAM: 176GB).](data:image/svg+xml;base64...)

Figure 2: The benchmark on PCA & UMAP with large datasets (CPU: Intel Xeon Gold 6248 @2.50GHz, RAM: 176GB)

~

~

# 5 Miscellaneous

## 5.1 Save SCArrayAssay

The Seurat object with `SCArrayAssay` can be directly saved to a RDS (R object) file, in which the raw counts in the GDS file is not stored in the RDS file. This can avoid data duplication, and is helpful for faster meta data loading. Please keep the GDS and RDS files in the same directory or the same relative paths. The R object can be reloaded later in another R session, and GDS files are reopened internally when accessing the count data.

```
d    # the example for the small dataset
```

```
## An object of class Seurat
## 1000 features across 850 samples within 1 assay
## Active assay: RNA (1000 features, 500 variable features)
##  2 layers present: counts, data
##  2 dimensional reductions calculated: pca, umap
```

```
save_fn <- tempfile(fileext=".rds")  # or specify an appropriate location
save_fn
```

```
## [1] "/tmp/Rtmpbd1KIb/file284b7d2f228a53.rds"
```

```
saveRDS(d, save_fn)  # save to a RDS file

remove(d)  # delete the variable d
gc()       # trigger a garbage collection
```

```
##            used  (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells 10049295 536.7   16805521 897.6 14305992 764.1
## Vcells 18034135 137.6   31802057 242.7 31802056 242.7
```

```
d <- readRDS(save_fn)  # load from a RDS file
d
```

```
## An object of class Seurat
## 1000 features across 850 samples within 1 assay
## Active assay: RNA (1000 features, 500 variable features)
##  2 layers present: counts, data
##  2 dimensional reductions calculated: pca, umap
```

```
GetAssayData(d, slot="counts")  # reopens the GDS file automatically
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20        2.133695        1.423133   .        0.000000
##         GNB1        3.342935        2.346631   .        0.000000
##        RPL22        2.133695        2.183267   .        2.982560
##        PARK7        1.247608        2.487018   .        1.980463
##         ENO1        3.037644        3.431596   .        3.129447
##          ...               .               .   .               .
##         SSR4        0.000000        2.346631   .        2.810320
##        RPL10        3.342935        1.987902   .        1.416593
## SLC25A6-loc1        2.391330        2.183267   .        2.338835
##       RPS4Y1        0.000000        2.183267   .        1.980463
##         CD24        3.821575        1.744869   .        0.000000
##              1772122_180_D09
##       MRPL20        1.757196
##         GNB1        0.000000
##        RPL22        2.733620
##        PARK7        1.757196
##         ENO1        2.360130
##          ...               .
##         SSR4        1.223211
##        RPL10        2.103432
## SLC25A6-loc1        1.223211
##       RPS4Y1        2.360130
##         CD24        1.757196
```

~

## 5.2 Multicore or Multi-process Implementation

The multicore and multi-process features are supported by SCArray and SCArray.sat via the Bioconductor package “BiocParallel”. To enable the parallel feature, users can use the function `setAutoBPPARAM()` in the DelayedArray package to setup multi-process workers. For examples,

```
library(BiocParallel)

DelayedArray::setAutoBPPARAM(MulticoreParam(4))  # 4 child processes
```

~

## 5.3 Downgrade SCArrayAssay

The `SCArrayAssay` object can be downgraded to the regular `Assay`. It is useful when the downstream functions or packages do not support DelayedArray.

```
is(GetAssay(d))
```

```
## [1] "SCArrayAssay" "Assay"        "KeyMixin"
```

```
new_d <- scMemory(d)  # downgrade the active assay
is(GetAssay(new_d))
```

```
## [1] "Assay"    "KeyMixin"
```

If users only want to ‘downgrade’ the scaled data matrix, then

```
is(GetAssayData(d, slot="scale.data"))  # it is a DelayedMatrix
```

```
##  [1] "SC_GDSMatrix"      "DelayedMatrix"     "SC_GDSArray"
##  [4] "UnionMatrix"       "UnionMatrix2"      "DelayedArray"
##  [7] "DelayedUnaryIsoOp" "DelayedUnaryOp"    "DelayedOp"
## [10] "Array"             "RectangularData"
```

```
new_d <- scMemory(d, slot="scale.data")  # downgrade "scale.data" in the active assay
is(GetAssay(new_d))  # it is still SCArrayAssay
```

```
## [1] "SCArrayAssay" "Assay"        "KeyMixin"
```

```
is(GetAssayData(new_d, slot="scale.data"))  # in-memory matrix
```

```
##  [1] "SC_GDSMatrix"      "DelayedMatrix"     "SC_GDSArray"
##  [4] "UnionMatrix"       "UnionMatrix2"      "DelayedArray"
##  [7] "DelayedUnaryIsoOp" "DelayedUnaryOp"    "DelayedOp"
## [10] "Array"             "RectangularData"
```

~

## 5.4 Conversion from Seurat to SingleCellExperiment

A Seurat object with `SCArrayAssay` can be converted to a Bioconductor `SingleCellExperiment` object using `as.SingleCellExperiment()` in the Seurat package. The DelayedMatrix in `SCArrayAssay will be saved in the new SingleCellExperiment object. For example,

```
is(d)
```

```
## [1] "Seurat"
```

```
sce <- as.SingleCellExperiment(d)
is(sce)
```

```
## [1] "SingleCellExperiment"       "RangedSummarizedExperiment"
## [3] "SummarizedExperiment"       "RectangularData"
## [5] "Vector"                     "Annotated"
## [7] "vector_OR_Vector"
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 1000 850
## metadata(0):
## assays(3): counts logcounts scaledata
## rownames(1000): MRPL20 GNB1 ... RPS4Y1 CD24
## rowData names(0):
## colnames(850): 1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##   1772122_180_D09
## colData names(7): orig.ident nCount_RNA ... Timepoint ident
## reducedDimNames(2): PCA UMAP
## mainExpName: RNA
## altExpNames(0):
```

```
counts(sce)  # raw counts
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20        2.133695        1.423133   .        0.000000
##         GNB1        3.342935        2.346631   .        0.000000
##        RPL22        2.133695        2.183267   .        2.982560
##        PARK7        1.247608        2.487018   .        1.980463
##         ENO1        3.037644        3.431596   .        3.129447
##          ...               .               .   .               .
##         SSR4        0.000000        2.346631   .        2.810320
##        RPL10        3.342935        1.987902   .        1.416593
## SLC25A6-loc1        2.391330        2.183267   .        2.338835
##       RPS4Y1        0.000000        2.183267   .        1.980463
##         CD24        3.821575        1.744869   .        0.000000
##              1772122_180_D09
##       MRPL20        1.757196
##         GNB1        0.000000
##        RPL22        2.733620
##        PARK7        1.757196
##         ENO1        2.360130
##          ...               .
##         SSR4        1.223211
##        RPL10        2.103432
## SLC25A6-loc1        1.223211
##       RPS4Y1        2.360130
##         CD24        1.757196
```

~

## 5.5 List of supported functions

Not all of the functions in the Seurat package can be applied to the `SCArrayAssay` object. Here is the list of currently supported and unsupported functions we have tested. The unsupported methods maybe available on request in the future release of SCArray.sat. Note that the supported states may depend on the package versions of Seurat and SeuratObject, and SeuratObject\_4.1.3 and Seurat\_4.3.0 were tested here.

**Table 3: The states of functions and methods with the support of SCArrayAssay.**

| State | Functions | Description | Notes |
| --- | --- | --- | --- |
| ✓ | CreateSeuratObject() |  |  |
| ✓ | FindVariableFeatures() | Identifies the top features |  |
| ✓ | NormalizeData() | Normalize the count data |  |
| ✓ | RunPCA() | Principal component analysis |  |
| ✓ | ScaleData() | Scales and centers features |  |
| ☑ | FindMarkers() | Differentially expressed genes | data read via blocking |
| ☑ | FoldChange() |  |  |
| ☑ | RunICA() | Independent component analysis |  |
| ☑ | RunSPCA() | Supervised principal component analysis |  |
| ☑ | RunLDA() | Linear discriminant analysis |  |
| ☑ | RunSLSI() | Supervised latent semantic indexing |  |
| ☑ | RunUMAP() | Uniform manifold approx. and projection |  |
| ⦿ | FindNeighbors | Nearest-neighbor graph construction |  |
| ⦿ | HVFInfo() | Info for highly variable features |  |
| ⦿ | RunTSNE() | t-SNE dimensionality reduction |  |
| ⦿ | ProjectDim() |  |  |
| ⦿ | ProjectUMAP() |  |  |
| ⦿ | SVFInfo() | Info for spatially variable features |  |
| ⦿ | VariableFeatures() | Get/set variable feature information |  |
| ✗ | CreateAssayObject() |  | use CreateAssayObject2() instead |
| ✗ | as.Seurat() |  | planned |
| ✗ | RunCCA() | Canonical correlation analysis | planned |
| ✗ | SCTransform() | Normalization via regularized NB regression | planned |

* ✓ Supported (implemented in SCArray.sat, optimized for memory)
* ☑ Supported (mainly relying on the implementation in Seurat)
* ⦿ Supported (implemented in Seurat, not in SCArray.sat)
* ✗ Unsupported (raising an error)

~

## 5.6 Debugging

`options(SCArray.verbose=TRUE)` is used to enable displaying debug information when calling the functions in the SCArray and SCArray.sat packages. For example,

```
options(SCArray.verbose=TRUE)

d <- ScaleData(d)
```

```
## Centering and scaling data matrix (SC_GDSMatrix [500x850])
```

~

~

# 6 Session Information

```
# print version information about R, the OS and attached or loaded packages
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
##  [1] SCArray.sat_1.9.0     SCArray_1.17.0        DelayedArray_0.35.3
##  [4] SparseArray_1.9.1     S4Arrays_1.9.1        abind_1.4-8
##  [7] IRanges_2.43.5        S4Vectors_0.47.4      MatrixGenerics_1.21.0
## [10] matrixStats_1.5.0     BiocGenerics_0.55.1   generics_0.1.4
## [13] Matrix_1.7-4          gdsfmt_1.45.1         Seurat_5.3.0
## [16] SeuratObject_5.2.0    sp_2.2-0              BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] spatstat.utils_3.2-0        farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.6.5
##   [9] ROCR_1.0-11                 DelayedMatrixStats_1.31.0
##  [11] spatstat.explore_3.5-3      tinytex_0.57
##  [13] htmltools_0.5.8.1           sass_0.4.10
##  [15] sctransform_0.4.2           parallelly_1.45.1
##  [17] KernSmooth_2.23-26          bslib_0.9.0
##  [19] htmlwidgets_1.6.4           ica_1.0-3
##  [21] plyr_1.8.9                  plotly_4.11.0
##  [23] zoo_1.8-14                  cachem_1.1.0
##  [25] igraph_2.1.4                mime_0.13
##  [27] lifecycle_1.0.4             pkgconfig_2.0.3
##  [29] rsvd_1.0.5                  R6_2.6.1
##  [31] fastmap_1.2.0               fitdistrplus_1.2-4
##  [33] future_1.67.0               shiny_1.11.1
##  [35] digest_0.6.37               patchwork_1.3.2
##  [37] tensor_1.5.1                RSpectra_0.16-2
##  [39] irlba_2.3.5.1               GenomicRanges_1.61.5
##  [41] beachmat_2.25.5             labeling_0.4.3
##  [43] progressr_0.16.0            spatstat.sparse_3.1-0
##  [45] httr_1.4.7                  polyclip_1.10-7
##  [47] compiler_4.5.1              withr_3.0.2
##  [49] S7_0.2.0                    BiocParallel_1.43.4
##  [51] fastDummies_1.7.5           MASS_7.3-65
##  [53] tools_4.5.1                 lmtest_0.9-40
##  [55] httpuv_1.6.16               future.apply_1.20.0
##  [57] goftest_1.2-3               glue_1.8.0
##  [59] nlme_3.1-168                promises_1.3.3
##  [61] grid_4.5.1                  Rtsne_0.17
##  [63] cluster_2.1.8.1             reshape2_1.4.4
##  [65] gtable_0.3.6                spatstat.data_3.1-8
##  [67] tidyr_1.3.1                 data.table_1.17.8
##  [69] ScaledMatrix_1.17.0         BiocSingular_1.25.0
##  [71] XVector_0.49.1              spatstat.geom_3.6-0
##  [73] RcppAnnoy_0.0.22            ggrepel_0.9.6
##  [75] RANN_2.6.2                  pillar_1.11.1
##  [77] stringr_1.5.2               spam_2.11-1
##  [79] RcppHNSW_0.6.0              later_1.4.4
##  [81] splines_4.5.1               dplyr_1.1.4
##  [83] lattice_0.22-7              survival_3.8-3
##  [85] deldir_2.0-4                tidyselect_1.2.1
##  [87] SingleCellExperiment_1.31.1 miniUI_0.1.2
##  [89] pbapply_1.7-4               knitr_1.50
##  [91] gridExtra_2.3               bookdown_0.45
##  [93] Seqinfo_0.99.2              SummarizedExperiment_1.39.2
##  [95] scattermore_1.2             xfun_0.53
##  [97] Biobase_2.69.1              stringi_1.8.7
##  [99] lazyeval_0.2.2              yaml_2.3.10
## [101] evaluate_1.0.5              codetools_0.2-20
## [103] tibble_3.3.0                BiocManager_1.30.26
## [105] cli_3.6.5                   uwot_0.2.3
## [107] xtable_1.8-4                reticulate_1.43.0
## [109] jquerylib_0.1.4             dichromat_2.0-0.1
## [111] Rcpp_1.1.0                  globals_0.18.0
## [113] spatstat.random_3.4-2       png_0.1-8
## [115] spatstat.univar_3.1-4       parallel_4.5.1
## [117] ggplot2_4.0.0               dotCall64_1.2
## [119] sparseMatrixStats_1.21.0    listenv_0.9.1
## [121] viridisLite_0.4.2           scales_1.4.0
## [123] ggridges_0.5.7              purrr_1.1.0
## [125] crayon_1.5.3                rlang_1.1.6
## [127] cowplot_1.2.0
```