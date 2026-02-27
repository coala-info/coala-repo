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
## [1] "Assay5"
## attr(,"package")
## [1] "SeuratObject"
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
m <- GetAssayData(d, layer="counts")
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
##       MRPL20               3               2   .               0
##         GNB1              11               6   .               0
##        RPL22               3               5   .               6
##        PARK7               1               7   .               2
##         ENO1               8              19   .               7
##          ...               .               .   .               .
##         SSR4               0               6   .               5
##        RPL10              11               4   .               1
## SLC25A6-loc1               4               5   .               3
##       RPS4Y1               0               5   .               2
##         CD24              18               3   .               0
##              1772122_180_D09
##       MRPL20               2
##         GNB1               0
##        RPL22               6
##        PARK7               2
##         ENO1               4
##          ...               .
##         SSR4               1
##        RPL10               3
## SLC25A6-loc1               1
##       RPS4Y1               4
##         CD24               2
```

```
# normalized expression
# the normalized data does not save in neither the file nor the memory
GetAssayData(d, layer="data")
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
GetAssayData(d, layer="scale.data")
```

```
## <500 x 850> SC_GDSMatrix object of type "double":
##        1772122_301_C02 1772122_180_E05 ... 1772122_180_B06 1772122_180_D09
## MRPL20       1.0698786       0.2495111   .     -1.39354354      0.63519819
##   GNB1       1.9986433       0.9319892   .     -1.58034238     -1.58034238
##  PARK7      -0.7051228       0.7692228   .      0.16664801     -0.09894006
## MINOS1       0.8386726       0.8972573   .      1.08110724     -0.23734026
##    ID3      -1.2795653      -1.2795653   .      1.26163229     -0.17349183
##    ...               .               .   .               .               .
##  CETN2       0.4491348      -1.5497391   .       0.6670945       2.2490430
## SLC6A8      -0.9531097       0.1969921   .      -0.9531097      -0.9531097
##  RPL10       1.5151657       0.0120144   .      -0.6217454       0.1401726
## RPS4Y1      -0.8929986       0.9293677   .       0.7600876       1.0769944
##   CD24       2.2493072       0.1059022   .      -1.6950086       0.1186249
```

**Perform PCA and UMAP:**

```
{r fig.wide=TRUE}
d <- RunPCA(d, ndims.print=1:2)
DimPlot(d, reduction="pca")

d <- RunUMAP(d, dims=1:50)    # use all PCs calculated by RunPCA()
DimPlot(d, reduction="umap")
```

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
##  3 layers present: counts, data, scale.data
```

```
save_fn <- tempfile(fileext=".rds")  # or specify an appropriate location
save_fn
```

```
## [1] "/tmp/RtmpWD7iYb/file219c41a9e1384.rds"
```

```
saveRDS(d, save_fn)  # save to a RDS file

remove(d)  # delete the variable d
gc()       # trigger a garbage collection
```

```
##            used  (Mb) gc trigger  (Mb) max used  (Mb)
## Ncells  9739716 520.2   14219025 759.4 12520877 668.7
## Vcells 17373023 132.6   31887087 243.3 31775999 242.5
```

```
d <- readRDS(save_fn)  # load from a RDS file
d
```

```
## An object of class Seurat
## 1000 features across 850 samples within 1 assay
## Active assay: RNA (1000 features, 500 variable features)
##  3 layers present: counts, data, scale.data
```

```
GetAssayData(d, layer="counts")  # reopens the GDS file automatically
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20               3               2   .               0
##         GNB1              11               6   .               0
##        RPL22               3               5   .               6
##        PARK7               1               7   .               2
##         ENO1               8              19   .               7
##          ...               .               .   .               .
##         SSR4               0               6   .               5
##        RPL10              11               4   .               1
## SLC25A6-loc1               4               5   .               3
##       RPS4Y1               0               5   .               2
##         CD24              18               3   .               0
##              1772122_180_D09
##       MRPL20               2
##         GNB1               0
##        RPL22               6
##        PARK7               2
##         ENO1               4
##          ...               .
##         SSR4               1
##        RPL10               3
## SLC25A6-loc1               1
##       RPS4Y1               4
##         CD24               2
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
## [1] "Assay5"   "StdAssay" "KeyMixin"
```

```
new_d <- scMemory(d)  # downgrade the active assay
is(GetAssay(new_d))
```

```
## [1] "Assay5"   "StdAssay" "KeyMixin"
```

If users only want to ‘downgrade’ the scaled data matrix, then

```
is(GetAssayData(d, layer="scale.data"))  # it is a DelayedMatrix
```

```
##  [1] "SC_GDSMatrix"      "DelayedMatrix"     "SC_GDSArray"
##  [4] "UnionMatrix"       "UnionMatrix2"      "DelayedArray"
##  [7] "DelayedUnaryIsoOp" "DelayedUnaryOp"    "DelayedOp"
## [10] "Array"             "RectangularData"
```

```
# new_d <- scMemory(d, "scale.data")  # downgrade "scale.data" in the active assay
is(GetAssay(new_d))  # it is still SCArrayAssay
```

```
## [1] "Assay5"   "StdAssay" "KeyMixin"
```

```
# is(GetAssayData(new_d, layer="scale.data"))  # in-memory matrix
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
## assays(2): counts logcounts
## rownames(1000): MRPL20 GNB1 ... RPS4Y1 CD24
## rowData names(0):
## colnames(850): 1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##   1772122_180_D09
## colData names(7): orig.ident nCount_RNA ... Timepoint ident
## reducedDimNames(0):
## mainExpName: RNA
## altExpNames(0):
```

```
counts(sce)  # raw counts
```

```
## <1000 x 850> sparse SC_GDSMatrix object of type "double":
##              1772122_301_C02 1772122_180_E05 ... 1772122_180_B06
##       MRPL20               3               2   .               0
##         GNB1              11               6   .               0
##        RPL22               3               5   .               6
##        PARK7               1               7   .               2
##         ENO1               8              19   .               7
##          ...               .               .   .               .
##         SSR4               0               6   .               5
##        RPL10              11               4   .               1
## SLC25A6-loc1               4               5   .               3
##       RPS4Y1               0               5   .               2
##         CD24              18               3   .               0
##              1772122_180_D09
##       MRPL20               2
##         GNB1               0
##        RPL22               6
##        PARK7               2
##         ENO1               4
##          ...               .
##         SSR4               1
##        RPL10               3
## SLC25A6-loc1               1
##       RPS4Y1               4
##         CD24               2
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
## R version 4.5.2 (2025-10-31)
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
##  [1] SCArray.sat_1.10.1    SCArray_1.18.0        DelayedArray_0.36.0
##  [4] SparseArray_1.10.8    S4Arrays_1.10.1       abind_1.4-8
##  [7] IRanges_2.44.0        S4Vectors_0.48.0      MatrixGenerics_1.22.0
## [10] matrixStats_1.5.0     BiocGenerics_0.56.0   generics_0.1.4
## [13] Matrix_1.7-4          gdsfmt_1.46.0         Seurat_5.4.0
## [16] SeuratObject_5.3.0    sp_2.2-1              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              spatstat.utils_3.2-1
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] vctrs_0.7.1                 ROCR_1.0-12
##   [9] DelayedMatrixStats_1.32.0   spatstat.explore_3.7-0
##  [11] htmltools_0.5.9             sass_0.4.10
##  [13] sctransform_0.4.3           parallelly_1.46.1
##  [15] KernSmooth_2.23-26          bslib_0.10.0
##  [17] htmlwidgets_1.6.4           ica_1.0-3
##  [19] plyr_1.8.9                  plotly_4.12.0
##  [21] zoo_1.8-15                  cachem_1.1.0
##  [23] igraph_2.2.2                mime_0.13
##  [25] lifecycle_1.0.5             pkgconfig_2.0.3
##  [27] rsvd_1.0.5                  R6_2.6.1
##  [29] fastmap_1.2.0               fitdistrplus_1.2-6
##  [31] future_1.69.0               shiny_1.13.0
##  [33] digest_0.6.39               patchwork_1.3.2
##  [35] tensor_1.5.1                RSpectra_0.16-2
##  [37] irlba_2.3.7                 GenomicRanges_1.62.1
##  [39] beachmat_2.26.0             progressr_0.18.0
##  [41] spatstat.sparse_3.1-0       httr_1.4.8
##  [43] polyclip_1.10-7             compiler_4.5.2
##  [45] S7_0.2.1                    BiocParallel_1.44.0
##  [47] fastDummies_1.7.5           MASS_7.3-65
##  [49] tools_4.5.2                 lmtest_0.9-40
##  [51] otel_0.2.0                  httpuv_1.6.16
##  [53] future.apply_1.20.2         goftest_1.2-3
##  [55] glue_1.8.0                  nlme_3.1-168
##  [57] promises_1.5.0              grid_4.5.2
##  [59] Rtsne_0.17                  cluster_2.1.8.2
##  [61] reshape2_1.4.5              gtable_0.3.6
##  [63] spatstat.data_3.1-9         tidyr_1.3.2
##  [65] data.table_1.18.2.1         ScaledMatrix_1.18.0
##  [67] BiocSingular_1.26.1         XVector_0.50.0
##  [69] spatstat.geom_3.7-0         RcppAnnoy_0.0.23
##  [71] ggrepel_0.9.7               RANN_2.6.2
##  [73] pillar_1.11.1               stringr_1.6.0
##  [75] spam_2.11-3                 RcppHNSW_0.6.0
##  [77] later_1.4.7                 splines_4.5.2
##  [79] dplyr_1.2.0                 lattice_0.22-9
##  [81] survival_3.8-6              deldir_2.0-4
##  [83] tidyselect_1.2.1            SingleCellExperiment_1.32.0
##  [85] miniUI_0.1.2                pbapply_1.7-4
##  [87] knitr_1.51                  gridExtra_2.3
##  [89] bookdown_0.46               Seqinfo_1.0.0
##  [91] SummarizedExperiment_1.40.0 scattermore_1.2
##  [93] xfun_0.56                   Biobase_2.70.0
##  [95] stringi_1.8.7               lazyeval_0.2.2
##  [97] yaml_2.3.12                 evaluate_1.0.5
##  [99] codetools_0.2-20            tibble_3.3.1
## [101] BiocManager_1.30.27         cli_3.6.5
## [103] uwot_0.2.4                  xtable_1.8-8
## [105] reticulate_1.45.0           jquerylib_0.1.4
## [107] dichromat_2.0-0.1           Rcpp_1.1.1
## [109] globals_0.19.0              spatstat.random_3.4-4
## [111] png_0.1-8                   spatstat.univar_3.1-6
## [113] parallel_4.5.2              ggplot2_4.0.2
## [115] dotCall64_1.2               sparseMatrixStats_1.22.0
## [117] listenv_0.10.0              viridisLite_0.4.3
## [119] scales_1.4.0                ggridges_0.5.7
## [121] crayon_1.5.3                purrr_1.2.1
## [123] rlang_1.1.7                 cowplot_1.2.0
```