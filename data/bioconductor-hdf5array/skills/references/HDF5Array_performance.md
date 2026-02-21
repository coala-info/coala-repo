# *HDF5Array* performance

Hervé Pagès1

1Fred Hutch Cancer Center, Seattle, WA

#### Compiled 30 October 2025; Modified 18 February 2025

#### Package

HDF5Array 1.38.0

# Contents

* [1 Introduction](#introduction)
* [2 Install and load the required packages](#install-and-load-the-required-packages)
* [3 The test datasets](#the-test-datasets)
  + [3.1 *Sparse* vs *dense* representation](#sparse-vs-dense-representation)
  + [3.2 TENxMatrix vs HDF5Matrix objects](#tenxmatrix-vs-hdf5matrix-objects)
    - [3.2.1 Bring the sparse dataset in R](#bring-the-sparse-dataset-in-r)
    - [3.2.2 Bring the dense dataset in R](#bring-the-dense-dataset-in-r)
  + [3.3 Create the test datasets](#create-the-test-datasets)
* [4 Block-processed normalization and PCA](#block-processed-normalization-and-pca)
  + [4.1 Code used for normalization and PCA](#code-used-for-normalization-and-pca)
  + [4.2 Block processing and block size](#block-processing-and-block-size)
  + [4.3 Monitoring memory usage](#monitoring-memory-usage)
* [5 Normalization and PCA of the 27,998 x 12,500 test dataset](#normalization-and-pca-of-the-27998-x-12500-test-dataset)
  + [5.1 Normalization](#normalization)
    - [5.1.1 TENxMatrix (sparse)](#tenxmatrix-sparse)
    - [5.1.2 HDF5Matrix (dense)](#hdf5matrix-dense)
    - [5.1.3 HDF5Matrix as sparse](#hdf5matrix-as-sparse)
  + [5.2 On-disk realization of the normalized datasets](#on-disk-realization-of-the-normalized-datasets)
    - [5.2.1 TENxMatrix (sparse)](#tenxmatrix-sparse-1)
    - [5.2.2 HDF5Matrix (dense)](#hdf5matrix-dense-1)
    - [5.2.3 HDF5Matrix as sparse](#hdf5matrix-as-sparse-1)
  + [5.3 PCA](#pca)
    - [5.3.1 TENxMatrix (sparse)](#tenxmatrix-sparse-2)
    - [5.3.2 HDF5Matrix (dense)](#hdf5matrix-dense-2)
    - [5.3.3 HDF5Matrix as sparse](#hdf5matrix-as-sparse-2)
* [6 Comprehensive timings obtained on various machines](#comprehensive-timings-obtained-on-various-machines)
  + [6.1 Timings for DELL XPS 15 laptop](#timings-for-dell-xps-15-laptop)
  + [6.2 Timings for Supermicro SuperServer 1029GQ-TRT](#timings-for-supermicro-superserver-1029gq-trt)
  + [6.3 Timings for Apple Silicon Mac Pro](#timings-for-apple-silicon-mac-pro)
  + [6.4 Timings for Intel Mac Pro](#timings-for-intel-mac-pro)
* [7 Discussion](#discussion)
  + [7.1 TENxMatrix (sparse) vs HDF5Matrix (dense)](#tenxmatrix-sparse-vs-hdf5matrix-dense)
    - [7.1.1 Normalization](#normalization-1)
    - [7.1.2 PCA](#pca-1)
    - [7.1.3 Hybrid approach](#hybrid-approach)
    - [7.1.4 A note about memory usage](#a-note-about-memory-usage)
  + [7.2 Main takeaways](#main-takeaways)
* [8 Session information](#session-information)

# 1 Introduction

The aim of this document is to measure the performance of
the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package for normalization and PCA
(Principal Component Analysis) of *on-disk* single cell data, two
computationally intensive operations at the core of single cell analysis.

The benchmarks presented in the document were specifically designed
to observe the impact of two critical parameters on performance:

1. data representation (i.e. *sparse* vs *dense*);
2. size of the blocks used for *block-processed* operations.

Hopefully these benchmarks will also facilitate comparing performance
of single cell analysis workflows based on *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)*
with workflows based on other tools like Seurat or Scanpy.

# 2 Install and load the required packages

Let’s install and load *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* as well as the other
packages used in this vignette:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

pkgs <- c("HDF5Array", "ExperimentHub", "DelayedMatrixStats", "RSpectra")
BiocManager::install(pkgs)
```

Load the packages:

```
library(HDF5Array)
library(ExperimentHub)
library(DelayedMatrixStats)
library(RSpectra)
```

# 3 The test datasets

## 3.1 *Sparse* vs *dense* representation

The datasets that we will use for our benchmarks are subsets of the
*1.3 Million Brain Cell Dataset* from 10x Genomics. This is a sparse
27,998 x 1,306,127 matrix of counts, with one gene per row and one cell
per column. Around 7% of the matrix values are nonzero counts.
The dataset is available via the *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* package
in two forms:

1. As a *sparse* HDF5 file: This is the original HDF5 file provided by
   10x Genomics. It uses the CSR/CSC/Yale representation to store the
   sparse data.
2. As a *dense* HDF5 file: The same data as the above but stored as a
   regular HDF5 dataset with (compressed) chunks of dimensions 100 x 100.

The two files are hosted on *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* under resource
ids `EH1039` and `EH1040`:

```
hub <- ExperimentHub()
hub["EH1039"]$description  # sparse representation
```

```
## [1] "Single-cell RNA-seq data for 1.3 million brain cells from E18 mice. 'HDF5-based 10X Genomics' format originally provided by TENx Genomics"
```

```
hub["EH1040"]$description  # dense representation
```

```
## [1] "Single-cell RNA-seq data for 1.3 million brain cells from E18 mice. Full rectangular, block-compressed format, 1GB block size."
```

Let’s download them to the local *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* cache
if they are not there yet:

```
## Note that this will be quick if the HDF5 files are already in the
## local ExperimentHub cache. Otherwise, it will take a while!
brain_s_path <- hub[["EH1039"]]
brain_D_path <- hub[["EH1040"]]
```

`brain_s_path` and `brain_D_path` are the paths to the downloaded files.

## 3.2 TENxMatrix vs HDF5Matrix objects

We use the `TENxMatrix()` and `HDF5Array()` constructors to bring the
sparse and dense datasets in R, as DelayedArray derivatives. Note that
this does *not* load the matrix data in memory.

### 3.2.1 Bring the sparse dataset in R

```
## Use 'h5ls(brain_s_path)' to find out the group.
brain_s <- TENxMatrix(brain_s_path, group="mm10")
```

`brain_s` is a 27,998 x 1,306,127 TENxMatrix object:

```
class(brain_s)
```

```
## [1] "TENxMatrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
dim(brain_s)
```

```
## [1]   27998 1306127
```

```
is_sparse(brain_s)
```

```
## [1] TRUE
```

See `?TENxMatrix` in the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package for more
information about TENxMatrix objects.

### 3.2.2 Bring the dense dataset in R

```
## Use 'h5ls(brain_D_path)' to find out the name of the dataset.
brain_D <- HDF5Array(brain_D_path, name="counts")
```

`brain_D` is a 27,998 x 1,306,127 HDF5Matrix object
that contains the same data as `brain_s`:

```
class(brain_D)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
dim(brain_D)
```

```
## [1]   27998 1306127
```

```
chunkdim(brain_D)
```

```
## [1] 100 100
```

```
is_sparse(brain_D)
```

```
## [1] FALSE
```

See `?HDF5Matrix` in the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package for more
information about HDF5Matrix objects.

Even though the data in `brain_D_path` is stored in a dense format,
we can flag it as *quantitatively* sparse. This is done by calling
the `HDF5Array()` constructor function with `as.sparse=TRUE`:

```
brain_Ds <- HDF5Array(brain_D_path, name="counts", as.sparse=TRUE)
```

The only difference between `brain_D` and `brain_Ds` is that
the latter is now seen as a sparse object, and will be treated as such:

```
class(brain_Ds)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
dim(brain_Ds)
```

```
## [1]   27998 1306127
```

```
chunkdim(brain_Ds)
```

```
## [1] 100 100
```

```
is_sparse(brain_Ds)
```

```
## [1] TRUE
```

Concretely this means that, when blocks of data are loaded from
the *dense* HDF5 file to memory during *block-processed* operations,
they end up directly in an in-memory *sparse* representation without going
thru an in-memory *dense* representation first. This is expected to reduce
memory footprint and (hopefully) will help with overall performance.

Finally note that the dense HDF5 file does not contain the dimnames of the
matrix, so we manually add them to `brain_s` and `brain_Ds`:

```
dimnames(brain_Ds) <- dimnames(brain_D) <- dimnames(brain_s)
```

## 3.3 Create the test datasets

For our benchmarks below, we create subsets of the *1.3 Million Brain
Cell Dataset* of increasing sizes: subsets with 12,500 cells, 25,000 cells,
50,000 cells, 100,000 cells, and 200,000 cells. Note that subsetting a
TENxMatrix or HDF5Matrix object with `[` is a delayed operation so has
virtually no cost:

```
brain1_s  <- brain_s[  , 1:12500]
brain1_D  <- brain_D[  , 1:12500]
brain1_Ds <- brain_Ds[ , 1:12500]

brain2_s  <- brain_s[  , 1:25000]
brain2_D  <- brain_D[  , 1:25000]
brain2_Ds <- brain_Ds[ , 1:25000]

brain3_s  <- brain_s[  , 1:50000]
brain3_D  <- brain_D[  , 1:50000]
brain3_Ds <- brain_Ds[ , 1:50000]

brain4_s  <- brain_s[  , 1:100000]
brain4_D  <- brain_D[  , 1:100000]
brain4_Ds <- brain_Ds[ , 1:100000]

brain5_s  <- brain_s[  , 1:200000]
brain5_D  <- brain_D[  , 1:200000]
brain5_Ds <- brain_Ds[ , 1:200000]
```

# 4 Block-processed normalization and PCA

## 4.1 Code used for normalization and PCA

We’ll use the following code for normalization:

```
## Also selects the most variable genes (1000 by default).
simple_normalize <- function(mat, num_var_genes=1000)
{
    stopifnot(length(dim(mat)) == 2, !is.null(rownames(mat)))
    mat <- mat[rowSums(mat) > 0, ]
    col_sums <- colSums(mat) / 10000
    mat <- t(t(mat) / col_sums)
    row_vars <- rowVars(mat)
    row_vars_order <- order(row_vars, decreasing=TRUE)
    variable_idx <- head(row_vars_order, n=num_var_genes)
    mat <- log1p(mat[variable_idx, ])
    mat / rowSds(mat)
}
```

and the following code for PCA:

```
simple_PCA <- function(mat, k=25)
{
    stopifnot(length(dim(mat)) == 2)
    row_means <- rowMeans(mat)
    Ax <- function(x, args)
        (as.numeric(mat %*% x) - row_means * sum(x))
    Atx <- function(x, args)
        (as.numeric(x %*% mat) - as.vector(row_means %*% x))
    RSpectra::svds(Ax, Atrans=Atx, k=k, dim=dim(mat))
}
```

## 4.2 Block processing and block size

Note that the implementations of `simple_normalize()` and `simple_PCA()`
are expected to work on any matrix-like object regardless of its exact
type/representation e.g. it can be an ordinary matrix, a SparseMatrix
object from the *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* package, a dgCMatrix object
from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package, a DelayedMatrix derivative
(TENxMatrix, HDF5Matrix, TileDBMatrix), etc…

However, when the input is a DelayedMatrix object or derivative,
it’s important to be aware that:

* Summarization methods like `sum()`, `colSums()`, `rowVars()`, or `rowSds()`,
  and matrix multiplication (`%*%`), are *block-processed* operations.
* The block size is 100 Mb by default. Increasing or decreasing the block
  size will typically increase or decrease the memory usage
  of *block-processed* operations. It will also impact performance,
  but sometimes in unexpected or counter-intuitive ways.
* The block size can be controlled with `DelayedArray::getAutoBlockSize()`
  and `DelayedArray::setAutoBlockSize()`.

For our benchmarks below, we’ll use the following block sizes:

|  | NORMALIZATION | PCA |
| --- | --- | --- |
| TENxMatrix (sparse) | 250 Mb | 40 Mb |
| HDF5Matrix (dense) | 16 Mb | 100 Mb |
| HDF5Matrix as sparse | 250 Mb | 40 Mb |

## 4.3 Monitoring memory usage

While manually running our benchmarks below on a Linux or macOS system,
we will also monitor memory usage at the command line in a terminal with:

```
(while true; do ps u -p <PID>; sleep 1; done) >ps.log 2>&1 &
```

where `<PID>` is the process id of our R session. This will allow us
to measure the maximum amount of memory used by the calls
to `simple_normalize()` or `simple_PCA()`.

# 5 Normalization and PCA of the 27,998 x 12,500 test dataset

## 5.1 Normalization

In this section we run `simple_normalize()` on the three different
representations (TENxMatrix, HDF5Matrix, and “HDF5Matrix as sparse”)
of the smaller test dataset only (27,998 x 12,500), and we report the
time of each run.

See the **Comprehensive timings obtained on various machines** section
below in this document for `simple_normalize()` and `simple_pca()` timings
obtained on various machines on all our test datasets and using four different
block sizes: 16 Mb, 40 Mb, 100 Mb, and 250 Mb.

### 5.1.1 TENxMatrix (sparse)

```
dim(brain1_s)
```

```
## [1] 27998 12500
```

```
DelayedArray::setAutoBlockSize(250e6)  # set block size to 250 Mb
```

```
## automatic block size set to 2.5e+08 bytes (was 1e+08)
```

```
system.time(norm_brain1_s <- simple_normalize(brain1_s))
```

```
##    user  system elapsed
##  71.045   4.658  75.678
```

```
dim(norm_brain1_s)
```

```
## [1]  1000 12500
```

### 5.1.2 HDF5Matrix (dense)

```
dim(brain1_D)
```

```
## [1] 27998 12500
```

```
DelayedArray::setAutoBlockSize(16e6)   # set block size to 16 Mb
```

```
## automatic block size set to 1.6e+07 bytes (was 2.5e+08)
```

```
system.time(norm_brain1_D <- simple_normalize(brain1_D))
```

```
##    user  system elapsed
##  99.088   1.272 100.394
```

```
dim(norm_brain1_D)
```

```
## [1]  1000 12500
```

### 5.1.3 HDF5Matrix as sparse

```
dim(brain1_Ds)
```

```
## [1] 27998 12500
```

```
DelayedArray::setAutoBlockSize(250e6)  # set block size to 250 Mb
```

```
## automatic block size set to 2.5e+08 bytes (was 1.6e+07)
```

```
system.time(norm_brain1_Ds <- simple_normalize(brain1_Ds))
```

```
##    user  system elapsed
##  69.245   3.039  72.181
```

```
dim(norm_brain1_Ds)
```

```
## [1]  1000 12500
```

## 5.2 On-disk realization of the normalized datasets

Note that the normalized datasets obtained in the previous section
are DelayedMatrix objects that carry delayed operations. These operations
can be displayed with `showtree()` e.g. for `norm_brain1_s`:

```
class(norm_brain1_s)
```

```
## [1] "DelayedMatrix"
## attr(,"package")
## [1] "DelayedArray"
```

```
showtree(norm_brain1_s)
```

```
## 1000x12500 double, sparse: DelayedMatrix object
## └─ 1000x12500 double, sparse: Unary iso op with args
##    └─ 1000x12500 double, sparse: Stack of 1 unary iso op(s)
##       └─ 1000x12500 double, sparse: Aperm (perm=c(2,1))
##          └─ 12500x1000 double, sparse: Unary iso op with args
##             └─ 12500x1000 integer, sparse: Aperm (perm=c(2,1))
##                └─ 1000x12500 integer, sparse: Subset
##                   └─ 27998x1306127 integer, sparse: [seed] TENxMatrixSeed object
```

The other `norm_brain1_*` objects carry similar operations.

Before we proceed with PCA, we’re going to write the normalized datasets to
new HDF5 files. This introduces an additional cost, but, on the other hand,
it has the benefit of triggering *on-disk realization* of the object. This
means that all the delayed operations carried by the object will get realized
on-the-fly before the matrix data actually lands on the disk, making the new
object (TENxMatrix or HDF5Matrix) more efficient for PCA or whatever
block-processed operations will come next.

We will use blocks of 100 Mb for all the writing operations.

```
DelayedArray::setAutoBlockSize(1e8)
```

```
## automatic block size set to 1e+08 bytes (was 2.5e+08)
```

### 5.2.1 TENxMatrix (sparse)

```
dim(norm_brain1_s)
```

```
## [1]  1000 12500
```

```
system.time(norm_brain1_s <- writeTENxMatrix(norm_brain1_s, level=0))
```

```
##    user  system elapsed
##   8.080   0.374   8.455
```

The new `norm_brain1_s` object is a *pristine* TENxMatrix object:

```
class(norm_brain1_s)
```

```
## [1] "TENxMatrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
showtree(norm_brain1_s)  # "pristine" object (i.e. no more delayed operations)
```

```
## 1000x12500 double, sparse: TENxMatrix object
## └─ 1000x12500 double, sparse: [seed] TENxMatrixSeed object
```

### 5.2.2 HDF5Matrix (dense)

```
dim(norm_brain1_D)
```

```
## [1]  1000 12500
```

```
system.time(norm_brain1_D <- writeHDF5Array(norm_brain1_D, level=0))
```

```
##    user  system elapsed
##   5.227   0.412   5.641
```

The new `norm_brain1_D` object is a *pristine* HDF5Matrix object:

```
class(norm_brain1_D)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
showtree(norm_brain1_D)  # "pristine" object (i.e. no more delayed operations)
```

```
## 1000x12500 double: HDF5Matrix object
## └─ 1000x12500 double: [seed] HDF5ArraySeed object
```

### 5.2.3 HDF5Matrix as sparse

```
dim(norm_brain1_Ds)
```

```
## [1]  1000 12500
```

```
system.time(norm_brain1_Ds <- writeHDF5Array(norm_brain1_Ds, level=0))
```

```
##    user  system elapsed
##   9.319   0.463   9.784
```

The new `norm_brain1_Ds` object is a *pristine* sparse HDF5Matrix object:

```
class(norm_brain1_Ds)
```

```
## [1] "HDF5Matrix"
## attr(,"package")
## [1] "HDF5Array"
```

```
showtree(norm_brain1_Ds)  # "pristine" object (i.e. no more delayed operations)
```

```
## 1000x12500 double, sparse: HDF5Matrix object
## └─ 1000x12500 double, sparse: [seed] HDF5ArraySeed object
```

## 5.3 PCA

In this section we run `simple_pca()` on the normalized datasets obtained
in the previous section and report the time of each run.

See the **Comprehensive timings obtained on various machines** section
below in this document for `simple_normalize()` and `simple_pca()` timings
obtained on various machines on all our test datasets and using four different
block sizes: 16 Mb, 40 Mb, 100 Mb, and 250 Mb.

### 5.3.1 TENxMatrix (sparse)

```
DelayedArray::setAutoBlockSize(40e6)   # set block size to 40 Mb
```

```
## automatic block size set to 4e+07 bytes (was 1e+08)
```

```
dim(norm_brain1_s)
```

```
## [1]  1000 12500
```

```
system.time(pca1s <- simple_PCA(norm_brain1_s))
```

```
##    user  system elapsed
##  89.852   3.401  85.348
```

### 5.3.2 HDF5Matrix (dense)

```
DelayedArray::setAutoBlockSize(1e8)    # set block size to 100 Mb
```

```
## automatic block size set to 1e+08 bytes (was 4e+07)
```

```
dim(norm_brain1_D)
```

```
## [1]  1000 12500
```

```
system.time(pca1D <- simple_PCA(norm_brain1_D))
```

```
##    user  system elapsed
##  74.672  20.595  95.297
```

Sanity check:

```
stopifnot(all.equal(pca1D, pca1s))
```

### 5.3.3 HDF5Matrix as sparse

```
DelayedArray::setAutoBlockSize(40e6)   # set block size to 40 Mb
```

```
## automatic block size set to 4e+07 bytes (was 1e+08)
```

```
dim(norm_brain1_Ds)
```

```
## [1]  1000 12500
```

```
system.time(pca1Ds <- simple_PCA(norm_brain1_Ds))
```

```
##    user  system elapsed
## 274.678  11.348 278.396
```

Sanity check:

```
stopifnot(all.equal(pca1Ds, pca1s))
```

# 6 Comprehensive timings obtained on various machines

Here we report timings (and memory usage) observed on various machines.
For each machine, the results are presented in a table that shows the
normalization & realization & PCA timings obtained for all our test datasets
and using four different block sizes: 16 Mb, 40 Mb, 100 Mb, and 250 Mb.
For each operation, the best time across the four different block
sizes is displayed in **bold**.

All the timings (and memory usage) were produced by running
the `run_benchmarks.sh` script located in the `HDF5Array/inst/scripts/`
folder of the package, using R 4.5 and *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* 1.35.12
(Bioconductor 3.21).

## 6.1 Timings for DELL XPS 15 laptop

| Specs for DELL XPS 15 laptop (model 9520) | | | |
| --- | --- | --- | --- |
| OS | Linux Ubuntu 24.04 | Disk performance | Output of `sudo hdparm -Tt <device>`: `Timing cached reads: 35188 MB in 2.00 seconds = 17620.75 MB/sec Timing buffered disk reads: 7842 MB in 3.00 seconds = 2613.57 MB/sec` |
| RAM | 32GB |
| Disk | 1TB SSD |

Table 1: Timings for DELL XPS 15 laptop

| Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | Normalized Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| nrow x ncol  (# genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | nrow x ncol  (# sel. genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  1000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 74 | 1.2Gb | 57 | 1.2Gb | 40 | 1.6Gb | 34 | 1.9Gb | 1000 x 12500 | [s] | 3 | 1.1Gb | 3 | 1.3Gb | 4 | 1.6Gb | 4 | 1.7Gb | 41 | 1.2Gb | 39 | 1.3Gb | 51 | 1.5Gb | 39 | 1.6Gb |
| [D] | 51 | 1.3Gb | 50 | 1.4Gb | 52 | 1.6Gb | 46 | 2.2Gb | [D] | 3 | 1.3Gb | 2 | 1.2Gb | 2 | 1.7Gb | 2 | 2.2Gb | 49 | 1.4Gb | 41 | 1.4Gb | 55 | 1.3Gb | 35 | 1.7Gb |
| [Ds] | 46 | 1.2Gb | 47 | 1.3Gb | 37 | 1.6Gb | 36 | 2.2Gb | [Ds] | 6 | 1.2Gb | 5 | 1.3Gb | 4 | 1.6Gb | 4 | 2.1Gb | 135 | 1.4Gb | 119 | 1.7Gb | 159 | 1.8Gb | 132 | 2.0Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 152 | 1.2Gb | 122 | 1.3Gb | 90 | 1.7Gb | 63 | 2.3Gb | 1000 x 25000 | [s] | 6 | 1.2Gb | 6 | 1.3Gb | 7 | 1.9Gb | 7 | 2.1Gb | 84 | 1.2Gb | 76 | 1.5Gb | 94 | 1.7Gb | 76 | 2.0Gb |
| [D] | 94 | 1.3Gb | 98 | 1.5Gb | 114 | 1.7Gb | 99 | 2.2Gb | [D] | 7 | 1.3Gb | 4 | 1.3Gb | 5 | 1.5Gb | 4 | 1.8Gb | 94 | 1.4Gb | 78 | 1.5Gb | 81 | 1.7Gb | 130 | 1.5Gb |
| [Ds] | 91 | 1.3Gb | 89 | 1.4Gb | 88 | 1.9Gb | 75 | 2.3Gb | [Ds] | 11 | 1.3Gb | 8 | 1.4Gb | 8 | 1.8Gb | 9 | 2.3Gb | 241 | 1.5Gb | 221 | 2.0Gb | 285 | 2.0Gb | 244 | 2.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 328 | 1.2Gb | 238 | 1.5Gb | 178 | 2.0Gb | 140 | 2.5Gb | 1000 x 50000 | [s] | 13 | 1.2Gb | 15 | 1.4Gb | 13 | 1.8Gb | 12 | 2.5Gb | 165 | 1.2Gb | 156 | 1.4Gb | 193 | 1.8Gb | 176 | 2.2Gb |
| [D] | 183 | 1.4Gb | 198 | 1.5Gb | 219 | 1.7Gb | 209 | 2.4Gb | [D] | 17 | 1.3Gb | 13 | 1.3Gb | 9 | 1.5Gb | 9 | 1.6Gb | 241 | 1.4Gb | 215 | 1.5Gb | 189 | 1.6Gb | 167 | 2.2Gb |
| [Ds] | 183 | 1.2Gb | 174 | 1.5Gb | 167 | 1.9Gb | 165 | 2.5Gb | [Ds] | 27 | 1.2Gb | 20 | 1.5Gb | 16 | 1.7Gb | 15 | 2.4Gb | 535 | 1.6Gb | 474 | 1.9Gb | 620 | 1.9Gb | 472 | 3.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 642 | 1.2Gb | 458 | 1.6Gb | 365 | 2.0Gb | 280 | 2.9Gb | 1000 x 100000 | [s] | 23 | 1.3Gb | 25 | 1.5Gb | 25 | 1.8Gb | 23 | 2.7Gb | 304 | 1.3Gb | 268 | 1.5Gb | 305 | 1.7Gb | 332 | 2.6Gb |
| [D] | 344 | 1.4Gb | 392 | 1.6Gb | 439 | 1.7Gb | 417 | 2.3Gb | [D] | 34 | 1.3Gb | 25 | 1.3Gb | 18 | 1.6Gb | 17 | 1.9Gb | 520 | 1.5Gb | 424 | 1.6Gb | 260 | 1.7Gb | 310 | 2.2Gb |
| [Ds] | 354 | 1.2Gb | 340 | 1.5Gb | 323 | 2.0Gb | 334 | 3.0Gb | [Ds] | 52 | 1.3Gb | 40 | 1.5Gb | 34 | 1.9Gb | 30 | 3.1Gb | 1057 | 1.7Gb | 1016 | 2.0Gb | 1080 | 2.2Gb | 944 | 3.9Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 1284 | 1.3Gb | 985 | 1.6Gb | 738 | 2.0Gb | 610 | 3.7Gb | 1000 x 200000 | [s] | 46 | 1.3Gb | 47 | 1.6Gb | 52 | 2.0Gb | 46 | 3.4Gb | 585 | 1.3Gb | 535 | 1.6Gb | 703 | 1.8Gb | 665 | 2.9Gb |
| [D] | 694 | 1.4Gb | 796 | 1.9Gb | 886 | 1.7Gb | 855 | 3.0Gb | [D] | 78 | 1.3Gb | 62 | 1.8Gb | 49 | 1.6Gb | 36 | 2.8Gb | 1588 | 1.6Gb | 1088 | 2.1Gb | 892 | 1.8Gb | 676 | 3.0Gb |
| [Ds] | 775 | 1.3Gb | 680 | 1.6Gb | 642 | 2.4Gb | 677 | 3.6Gb | [Ds] | 113 | 1.4Gb | 93 | 1.6Gb | 74 | 2.2Gb | 62 | 3.4Gb | 2756 | 2.0Gb | 2327 | 2.1Gb | 2525 | 2.6Gb | 2103 | 3.8Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  2000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 81 | 1.1Gb | 58 | 1.3Gb | 45 | 1.6Gb | 34 | 2.0Gb | 2000 x 12500 | [s] | 4 | 1.1Gb | 4 | 1.3Gb | 4 | 1.5Gb | 5 | 1.8Gb | 76 | 1.1Gb | 55 | 1.3Gb | 70 | 1.4Gb | 121 | 1.7Gb |
| [D] | 55 | 1.3Gb | 50 | 1.4Gb | 56 | 1.7Gb | 48 | 2.3Gb | [D] | 5 | 1.3Gb | 3 | 1.3Gb | 4 | 1.6Gb | 3 | 1.8Gb | 91 | 1.4Gb | 84 | 1.5Gb | 86 | 1.6Gb | 75 | 2.0Gb |
| [Ds] | 54 | 1.1Gb | 49 | 1.3Gb | 45 | 1.6Gb | 38 | 2.2Gb | [Ds] | 9 | 1.1Gb | 6 | 1.4Gb | 6 | 1.7Gb | 6 | 2.2Gb | 198 | 1.5Gb | 183 | 1.8Gb | 233 | 1.9Gb | 224 | 2.5Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 162 | 1.2Gb | 127 | 1.3Gb | 95 | 1.6Gb | 75 | 2.2Gb | 2000 x 25000 | [s] | 8 | 1.2Gb | 9 | 1.3Gb | 9 | 1.7Gb | 8 | 2.1Gb | 128 | 1.2Gb | 127 | 1.3Gb | 127 | 1.5Gb | 155 | 2.0Gb |
| [D] | 103 | 1.3Gb | 102 | 1.5Gb | 117 | 1.6Gb | 105 | 2.1Gb | [D] | 13 | 1.3Gb | 9 | 1.4Gb | 7 | 1.5Gb | 6 | 1.6Gb | 217 | 1.4Gb | 186 | 1.5Gb | 184 | 1.6Gb | 150 | 2.1Gb |
| [Ds] | 102 | 1.3Gb | 94 | 1.4Gb | 95 | 1.7Gb | 91 | 2.6Gb | [Ds] | 18 | 1.3Gb | 15 | 1.5Gb | 11 | 1.5Gb | 11 | 2.4Gb | 401 | 1.6Gb | 398 | 1.8Gb | 426 | 1.8Gb | 435 | 3.1Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 341 | 1.1Gb | 250 | 1.3Gb | 181 | 1.8Gb | 146 | 2.7Gb | 2000 x 50000 | [s] | 18 | 1.1Gb | 18 | 1.3Gb | 18 | 1.7Gb | 17 | 2.7Gb | 238 | 1.1Gb | 205 | 1.4Gb | 256 | 1.6Gb | 229 | 2.3Gb |
| [D] | 194 | 1.4Gb | 204 | 1.5Gb | 226 | 1.7Gb | 214 | 2.2Gb | [D] | 27 | 1.4Gb | 18 | 1.3Gb | 13 | 1.4Gb | 13 | 1.8Gb | 358 | 1.4Gb | 341 | 1.5Gb | 403 | 1.3Gb | 360 | 2.0Gb |
| [Ds] | 210 | 1.2Gb | 183 | 1.5Gb | 176 | 2.0Gb | 172 | 2.5Gb | [Ds] | 40 | 1.2Gb | 28 | 1.5Gb | 22 | 1.9Gb | 21 | 2.6Gb | 701 | 1.7Gb | 653 | 2.0Gb | 732 | 2.3Gb | 684 | 3.4Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 684 | 1.2Gb | 471 | 1.4Gb | 374 | 1.9Gb | 292 | 2.9Gb | 2000 x 100000 | [s] | 33 | 1.2Gb | 30 | 1.4Gb | 32 | 1.9Gb | 29 | 2.7Gb | 434 | 1.2Gb | 351 | 1.4Gb | 496 | 1.7Gb | 410 | 2.5Gb |
| [D] | 376 | 1.4Gb | 407 | 1.5Gb | 452 | 1.7Gb | 433 | 2.3Gb | [D] | 61 | 1.4Gb | 44 | 1.4Gb | 33 | 1.6Gb | 25 | 2.0Gb | 990 | 1.5Gb | 788 | 1.6Gb | 656 | 1.9Gb | 859 | 1.4Gb |
| [Ds] | 405 | 1.2Gb | 359 | 1.5Gb | 341 | 2.1Gb | 349 | 2.8Gb | [Ds] | 88 | 1.3Gb | 68 | 1.5Gb | 51 | 2.1Gb | 44 | 2.7Gb | 1621 | 1.8Gb | 1425 | 2.0Gb | 1591 | 2.4Gb | 1451 | 3.4Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 1373 | 1.3Gb | 1033 | 1.6Gb | 774 | 1.9Gb | 643 | 2.9Gb | 2000 x 200000 | [s] | 62 | 1.4Gb | 62 | 1.6Gb | 66 | 1.9Gb | 69 | 2.8Gb | 787 | 1.4Gb | 692 | 1.6Gb | 929 | 1.7Gb | 944 | 2.4Gb |
| [D] | 762 | 1.4Gb | 820 | 1.9Gb | 925 | 1.7Gb | 930 | 3.3Gb | [D] | 138 | 1.3Gb | 102 | 1.9Gb | 75 | 1.5Gb | 57 | 2.5Gb | 2487 | 1.6Gb | 1725 | 2.1Gb | 1361 | 1.8Gb | 1285 | 2.2Gb |
| [Ds] | 860 | 1.3Gb | 718 | 1.8Gb | 686 | 2.3Gb | 748 | 3.4Gb | [Ds] | 185 | 1.4Gb | 141 | 1.8Gb | 119 | 2.1Gb | 92 | 2.9Gb | 3745 | 1.9Gb | 3048 | 2.1Gb | 3196 | 2.9Gb | 3187 | 3.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Formats: [s] TENxMatrix (sparse) — [D] HDF5Matrix (dense) — [Ds] HDF5Matrix as sparse. For each operation, the best time across the four different block sizes is displayed in bold. In addition, if it’s also the best time across the three formats ([s],[D], and [Ds]), then we  box  it (only for Normalization and PCA). The “max. mem. used” is the max RSS (Resident Set Size) value obtained by running `ps u -p <PID>` every second while performing a given operation. | | | | | | | | | | | | | | | | | | | | | | | | | | | |

## 6.2 Timings for Supermicro SuperServer 1029GQ-TRT

| Specs for Supermicro SuperServer 1029GQ-TRT | | | |
| --- | --- | --- | --- |
| OS | Linux Ubuntu 22.04 | Disk performance | Output of `sudo hdparm -Tt <device>`: `Timing cached reads: 20592 MB in 1.99 seconds = 10361.41 MB/sec Timing buffered disk reads: 1440 MB in 3.00 seconds = 479.66 MB/sec` |
| RAM | 384GB |
| Disk | 1.3TB ATA Disk |

Table 2: Timings for Supermicro SuperServer 1029GQ-TRT

| Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | Normalized Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| nrow x ncol  (# genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | nrow x ncol  (# sel. genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  1000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 129 | 1.0Gb | 96 | 1.2Gb | 69 | 1.5Gb | 56 | 2.0Gb | 1000 x 12500 | [s] | 5 | 1.0Gb | 5 | 1.2Gb | 6 | 1.4Gb | 6 | 1.6Gb | 85 | 1.1Gb | 77 | 1.2Gb | 91 | 1.4Gb | 171 | 1.5Gb |
| [D] | 79 | 1.2Gb | 83 | 1.3Gb | 83 | 1.7Gb | 75 | 2.2Gb | [D] | 5 | 1.2Gb | 4 | 1.2Gb | 3 | 1.0Gb | 3 | 1.6Gb | 75 | 1.3Gb | 67 | 1.3Gb | 77 | 1.5Gb | 60 | 1.6Gb |
| [Ds] | 71 | 1.1Gb | 74 | 1.3Gb | 59 | 1.5Gb | 59 | 2.1Gb | [Ds] | 9 | 1.1Gb | 7 | 1.3Gb | 7 | 1.6Gb | 8 | 1.6Gb | 239 | 1.3Gb | 239 | 1.5Gb | 276 | 1.7Gb | 253 | 1.8Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 255 | 1.1Gb | 186 | 1.2Gb | 152 | 1.6Gb | 112 | 1.9Gb | 1000 x 25000 | [s] | 11 | 1.1Gb | 12 | 1.3Gb | 11 | 1.5Gb | 12 | 1.9Gb | 167 | 1.1Gb | 168 | 1.3Gb | 166 | 1.5Gb | 158 | 1.8Gb |
| [D] | 149 | 1.2Gb | 159 | 1.4Gb | 181 | 1.6Gb | 160 | 2.1Gb | [D] | 11 | 1.2Gb | 6 | 1.3Gb | 7 | 1.4Gb | 7 | 1.3Gb | 161 | 1.3Gb | 122 | 1.3Gb | 142 | 1.6Gb | 215 | 1.4Gb |
| [Ds] | 141 | 1.1Gb | 144 | 1.2Gb | 127 | 1.9Gb | 115 | 2.1Gb | [Ds] | 21 | 1.1Gb | 14 | 1.3Gb | 13 | 1.6Gb | 13 | 2.1Gb | 432 | 1.5Gb | 425 | 1.7Gb | 514 | 1.8Gb | 451 | 2.4Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 496 | 1.1Gb | 377 | 1.4Gb | 301 | 1.7Gb | 241 | 2.4Gb | 1000 x 50000 | [s] | 22 | 1.1Gb | 21 | 1.4Gb | 22 | 1.7Gb | 21 | 2.6Gb | 311 | 1.1Gb | 286 | 1.4Gb | 367 | 1.7Gb | 334 | 2.3Gb |
| [D] | 282 | 1.3Gb | 331 | 1.4Gb | 347 | 1.6Gb | 329 | 2.2Gb | [D] | 24 | 1.3Gb | 20 | 1.3Gb | 14 | 1.3Gb | 14 | 1.6Gb | 376 | 1.3Gb | 360 | 1.4Gb | 298 | 1.2Gb | 282 | 2.1Gb |
| [Ds] | 275 | 1.1Gb | 280 | 1.3Gb | 251 | 1.8Gb | 255 | 2.6Gb | [Ds] | 39 | 1.1Gb | 30 | 1.4Gb | 26 | 1.7Gb | 25 | 2.3Gb | 934 | 1.5Gb | 894 | 1.8Gb | 1087 | 1.8Gb | 897 | 3.5Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 1015 | 1.1Gb | 721 | 1.4Gb | 615 | 1.9Gb | 456 | 3.1Gb | 1000 x 100000 | [s] | 44 | 1.1Gb | 42 | 1.4Gb | 43 | 1.7Gb | 38 | 2.8Gb | 620 | 1.1Gb | 569 | 1.4Gb | 662 | 1.7Gb | 624 | 2.7Gb |
| [D] | 558 | 1.3Gb | 630 | 1.4Gb | 707 | 1.6Gb | 688 | 2.2Gb | [D] | 51 | 1.2Gb | 35 | 1.3Gb | 28 | 1.3Gb | 27 | 1.9Gb | 797 | 1.4Gb | 570 | 1.5Gb | 595 | 1.6Gb | 544 | 2.1Gb |
| [Ds] | 557 | 1.2Gb | 534 | 1.5Gb | 493 | 2.0Gb | 507 | 3.1Gb | [Ds] | 79 | 1.2Gb | 68 | 1.4Gb | 59 | 1.7Gb | 49 | 2.9Gb | 1901 | 1.5Gb | 1906 | 2.0Gb | 1989 | 2.3Gb | 1778 | 3.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 2163 | 1.2Gb | 1579 | 1.4Gb | 1204 | 2.1Gb | 1014 | 3.3Gb | 1000 x 200000 | [s] | 77 | 1.2Gb | 92 | 1.4Gb | 88 | 2.1Gb | 81 | 3.1Gb | 1131 | 1.3Gb | 1102 | 1.4Gb | 1218 | 1.9Gb | 1133 | 3.0Gb |
| [D] | 1132 | 1.3Gb | 1294 | 1.6Gb | 1437 | 1.6Gb | 1368 | 3.2Gb | [D] | 114 | 1.3Gb | 93 | 1.4Gb | 75 | 1.4Gb | 57 | 2.9Gb | 2379 | 1.4Gb | 1698 | 1.7Gb | 1489 | 1.7Gb | 1133 | 2.9Gb |
| [Ds] | 1120 | 1.2Gb | 1082 | 1.5Gb | 989 | 2.3Gb | 1003 | 3.7Gb | [Ds] | 172 | 1.3Gb | 149 | 1.5Gb | 123 | 2.1Gb | 99 | 3.1Gb | 4643 | 1.8Gb | 4203 | 1.9Gb | 4064 | 2.5Gb | 3697 | 3.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  2000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 139 | 1.0Gb | 100 | 1.2Gb | 78 | 1.6Gb | 59 | 2.0Gb | 2000 x 12500 | [s] | 7 | 1.1Gb | 8 | 1.2Gb | 9 | 1.5Gb | 8 | 1.7Gb | 141 | 1.1Gb | 122 | 1.2Gb | 155 | 1.4Gb | 120 | 1.8Gb |
| [D] | 85 | 1.2Gb | 85 | 1.4Gb | 89 | 1.7Gb | 77 | 2.2Gb | [D] | 7 | 1.2Gb | 5 | 1.3Gb | 5 | 1.4Gb | 5 | 1.8Gb | 147 | 1.3Gb | 133 | 1.1Gb | 143 | 1.5Gb | 126 | 1.9Gb |
| [Ds] | 83 | 1.1Gb | 81 | 1.3Gb | 70 | 1.7Gb | 63 | 2.1Gb | [Ds] | 15 | 1.1Gb | 10 | 1.3Gb | 9 | 1.6Gb | 11 | 2.1Gb | 351 | 1.5Gb | 437 | 1.5Gb | 432 | 1.8Gb | 361 | 2.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 266 | 1.1Gb | 193 | 1.3Gb | 159 | 1.5Gb | 130 | 2.0Gb | 2000 x 25000 | [s] | 14 | 1.1Gb | 15 | 1.3Gb | 19 | 1.5Gb | 13 | 2.1Gb | 269 | 1.1Gb | 252 | 1.3Gb | 284 | 1.5Gb | 273 | 1.8Gb |
| [D] | 162 | 1.2Gb | 166 | 1.4Gb | 188 | 1.6Gb | 174 | 2.0Gb | [D] | 19 | 1.2Gb | 14 | 1.3Gb | 11 | 1.3Gb | 11 | 1.6Gb | 336 | 1.3Gb | 299 | 1.4Gb | 284 | 1.2Gb | 452 | 1.3Gb |
| [Ds] | 163 | 1.1Gb | 155 | 1.3Gb | 138 | 1.7Gb | 139 | 2.3Gb | [Ds] | 33 | 1.1Gb | 24 | 1.3Gb | 19 | 1.5Gb | 18 | 2.1Gb | 752 | 1.4Gb | 705 | 1.7Gb | 731 | 1.9Gb | 702 | 3.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 530 | 1.1Gb | 383 | 1.3Gb | 315 | 1.5Gb | 258 | 2.3Gb | 2000 x 50000 | [s] | 27 | 1.1Gb | 31 | 1.2Gb | 31 | 1.6Gb | 29 | 2.2Gb | 430 | 1.1Gb | 403 | 1.3Gb | 431 | 1.6Gb | 500 | 2.0Gb |
| [D] | 307 | 1.3Gb | 343 | 1.4Gb | 362 | 1.6Gb | 340 | 2.2Gb | [D] | 39 | 1.2Gb | 28 | 1.2Gb | 21 | 1.4Gb | 20 | 1.9Gb | 568 | 1.3Gb | 565 | 1.4Gb | 682 | 1.1Gb | 452 | 2.1Gb |
| [Ds] | 316 | 1.1Gb | 293 | 1.5Gb | 277 | 1.8Gb | 279 | 2.5Gb | [Ds] | 62 | 1.2Gb | 48 | 1.4Gb | 38 | 1.8Gb | 38 | 2.5Gb | 1235 | 1.5Gb | 1149 | 1.9Gb | 1317 | 2.1Gb | 1291 | 3.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 1075 | 1.1Gb | 756 | 1.3Gb | 636 | 1.8Gb | 484 | 2.9Gb | 2000 x 100000 | [s] | 55 | 1.1Gb | 55 | 1.3Gb | 55 | 1.8Gb | 56 | 2.7Gb | 827 | 1.2Gb | 729 | 1.4Gb | 782 | 1.8Gb | 822 | 2.4Gb |
| [D] | 609 | 1.3Gb | 663 | 1.4Gb | 730 | 1.6Gb | 720 | 2.2Gb | [D] | 92 | 1.2Gb | 67 | 1.3Gb | 51 | 1.6Gb | 42 | 2.1Gb | 1534 | 1.4Gb | 1322 | 1.5Gb | 996 | 1.7Gb | 914 | 2.1Gb |
| [Ds] | 627 | 1.2Gb | 570 | 1.5Gb | 533 | 2.0Gb | 550 | 2.8Gb | [Ds] | 131 | 1.2Gb | 106 | 1.5Gb | 83 | 1.9Gb | 74 | 2.8Gb | 2821 | 1.6Gb | 2635 | 1.9Gb | 2907 | 2.3Gb | 2663 | 3.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 2245 | 1.2Gb | 1599 | 1.4Gb | 1271 | 1.9Gb | 1069 | 3.0Gb | 2000 x 200000 | [s] | 107 | 1.2Gb | 111 | 1.4Gb | 117 | 1.9Gb | 110 | 3.0Gb | 1578 | 1.2Gb | 1494 | 1.4Gb | 1642 | 1.8Gb | 1718 | 2.6Gb |
| [D] | 1240 | 1.3Gb | 1345 | 1.6Gb | 1501 | 1.6Gb | 1429 | 3.2Gb | [D] | 199 | 1.2Gb | 151 | 1.5Gb | 113 | 1.5Gb | 84 | 2.6Gb | 3766 | 1.4Gb | 2798 | 1.7Gb | 2316 | 1.7Gb | 1836 | 2.7Gb |
| [Ds] | 1266 | 1.2Gb | 1142 | 1.6Gb | 1207 | 2.0Gb | 1102 | 3.0Gb | [Ds] | 288 | 1.2Gb | 219 | 1.6Gb | 191 | 1.8Gb | 148 | 2.6Gb | 6365 | 1.7Gb | 5369 | 2.0Gb | 5751 | 2.5Gb | 5848 | 3.2Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Formats: [s] TENxMatrix (sparse) — [D] HDF5Matrix (dense) — [Ds] HDF5Matrix as sparse. For each operation, the best time across the four different block sizes is displayed in bold. In addition, if it’s also the best time across the three formats ([s],[D], and [Ds]), then we  box  it (only for Normalization and PCA). The “max. mem. used” is the max RSS (Resident Set Size) value obtained by running `ps u -p <PID>` every second while performing a given operation. | | | | | | | | | | | | | | | | | | | | | | | | | | | |

## 6.3 Timings for Apple Silicon Mac Pro

| Specs for Apple Silicon Mac Pro (Apple M2 Ultra) | | | |
| --- | --- | --- | --- |
| OS | macOS 13.7.1 | Disk performance | N/A |
| RAM | 192GB |
| Disk | 2TB SSD |

Table 3: Timings for Apple Silicon Mac Pro

| Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | Normalized Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| nrow x ncol  (# genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | nrow x ncol  (# sel. genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  1000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 66 | 1.4Gb | 48 | 2.2Gb | 35 | 2.5Gb | 28 | 3.2Gb | 1000 x 12500 | [s] | 3 | 1.6Gb | 2 | 2.2Gb | 4 | 2.5Gb | 3 | 3.4Gb | 40 | 1.7Gb | 29 | 2.0Gb | 29 | 2.7Gb | 29 | 3.4Gb |
| [D] | 41 | 1.6Gb | 36 | 2.1Gb | 35 | 2.5Gb | 31 | 3.6Gb | [D] | 3 | 1.7Gb | 2 | 2.1Gb | 2 | 2.5Gb | 2 | 3.6Gb | 38 | 1.9Gb | 34 | 2.2Gb | 30 | 2.8Gb | 23 | 3.7Gb |
| [Ds] | 36 | 1.6Gb | 35 | 2.1Gb | 30 | 2.5Gb | 29 | 3.0Gb | [Ds] | 5 | 1.6Gb | 3 | 2.2Gb | 4 | 2.6Gb | 4 | 3.1Gb | 104 | 1.9Gb | 101 | 2.4Gb | 125 | 3.2Gb | 104 | 3.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 138 | 1.8Gb | 102 | 2.3Gb | 76 | 3.1Gb | 54 | 3.6Gb | 1000 x 25000 | [s] | 5 | 1.8Gb | 5 | 2.5Gb | 6 | 3.1Gb | 6 | 3.7Gb | 61 | 1.8Gb | 60 | 2.5Gb | 76 | 3.1Gb | 62 | 4.0Gb |
| [D] | 73 | 1.9Gb | 70 | 2.4Gb | 73 | 2.4Gb | 65 | 3.8Gb | [D] | 6 | 1.7Gb | 3 | 2.4Gb | 4 | 2.4Gb | 3 | 3.8Gb | 74 | 1.8Gb | 53 | 2.4Gb | 54 | 2.4Gb | 50 | 4.0Gb |
| [Ds] | 71 | 1.6Gb | 71 | 2.1Gb | 68 | 3.2Gb | 58 | 4.1Gb | [Ds] | 10 | 1.6Gb | 8 | 2.2Gb | 7 | 3.3Gb | 7 | 4.3Gb | 204 | 2.1Gb | 207 | 2.6Gb | 218 | 3.6Gb | 178 | 4.8Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 257 | 1.8Gb | 199 | 2.7Gb | 150 | 3.2Gb | 116 | 5.0Gb | 1000 x 50000 | [s] | 11 | 1.9Gb | 12 | 2.7Gb | 12 | 3.2Gb | 11 | 4.7Gb | 128 | 2.1Gb | 124 | 2.7Gb | 162 | 3.1Gb | 147 | 4.9Gb |
| [D] | 144 | 1.8Gb | 140 | 2.9Gb | 144 | 2.3Gb | 139 | 3.5Gb | [D] | 13 | 1.9Gb | 11 | 2.9Gb | 7 | 2.4Gb | 6 | 3.5Gb | 189 | 2.0Gb | 157 | 2.7Gb | 140 | 2.5Gb | 123 | 3.7Gb |
| [Ds] | 144 | 1.7Gb | 138 | 2.2Gb | 132 | 3.2Gb | 129 | 5.5Gb | [Ds] | 21 | 1.9Gb | 16 | 2.2Gb | 14 | 3.4Gb | 13 | 5.9Gb | 418 | 2.6Gb | 400 | 3.2Gb | 479 | 4.1Gb | 365 | 7.1Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 575 | 1.9Gb | 398 | 2.9Gb | 308 | 3.5Gb | 237 | 4.9Gb | 1000 x 100000 | [s] | 22 | 1.9Gb | 22 | 3.0Gb | 22 | 3.5Gb | 21 | 4.6Gb | 256 | 1.9Gb | 237 | 3.0Gb | 249 | 3.5Gb | 260 | 5.1Gb |
| [D] | 281 | 2.2Gb | 276 | 2.5Gb | 295 | 3.0Gb | 289 | 3.8Gb | [D] | 28 | 2.0Gb | 20 | 2.5Gb | 14 | 3.0Gb | 14 | 3.9Gb | 407 | 2.1Gb | 297 | 2.6Gb | 345 | 3.0Gb | 223 | 3.9Gb |
| [Ds] | 285 | 2.0Gb | 269 | 2.2Gb | 259 | 4.1Gb | 255 | 6.0Gb | [Ds] | 43 | 2.1Gb | 33 | 2.7Gb | 27 | 3.9Gb | 25 | 6.3Gb | 887 | 3.0Gb | 935 | 3.9Gb | 910 | 5.0Gb | 730 | 7.0Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 1122 | 2.6Gb | 834 | 3.3Gb | 631 | 4.1Gb | 514 | 7.6Gb | 1000 x 200000 | [s] | 41 | 2.6Gb | 41 | 3.4Gb | 44 | 4.1Gb | 41 | 7.5Gb | 466 | 2.7Gb | 495 | 3.4Gb | 655 | 4.2Gb | 547 | 7.4Gb |
| [D] | 561 | 2.2Gb | 554 | 3.3Gb | 588 | 2.7Gb | 595 | 4.4Gb | [D] | 62 | 2.2Gb | 48 | 3.3Gb | 37 | 2.8Gb | 28 | 4.6Gb | 1244 | 2.5Gb | 809 | 3.4Gb | 652 | 2.9Gb | 453 | 4.7Gb |
| [Ds] | 583 | 2.0Gb | 529 | 2.8Gb | 501 | 4.2Gb | 525 | 7.5Gb | [Ds] | 91 | 2.2Gb | 78 | 2.9Gb | 62 | 4.2Gb | 52 | 7.2Gb | 2221 | 3.2Gb | 1977 | 4.2Gb | 1992 | 5.3Gb | 1718 | 7.9Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  2000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 68 | 1.5Gb | 50 | 1.9Gb | 39 | 2.3Gb | 29 | 3.3Gb | 2000 x 12500 | [s] | 4 | 1.7Gb | 4 | 2.0Gb | 3 | 2.3Gb | 4 | 3.3Gb | 58 | 1.7Gb | 54 | 2.1Gb | 48 | 2.2Gb | 52 | 3.7Gb |
| [D] | 44 | 1.8Gb | 37 | 2.1Gb | 38 | 2.5Gb | 32 | 3.8Gb | [D] | 4 | 1.8Gb | 3 | 2.2Gb | 2 | 2.5Gb | 2 | 3.8Gb | 72 | 2.1Gb | 55 | 2.3Gb | 56 | 2.6Gb | 51 | 3.8Gb |
| [Ds] | 42 | 1.6Gb | 39 | 2.1Gb | 35 | 2.5Gb | 31 | 3.3Gb | [Ds] | 7 | 1.6Gb | 5 | 2.1Gb | 5 | 2.5Gb | 5 | 3.4Gb | 149 | 2.0Gb | 151 | 2.8Gb | 166 | 3.3Gb | 159 | 4.4Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 148 | 1.6Gb | 104 | 2.0Gb | 80 | 2.7Gb | 62 | 4.0Gb | 2000 x 25000 | [s] | 8 | 1.8Gb | 7 | 2.1Gb | 7 | 2.7Gb | 7 | 4.2Gb | 119 | 1.8Gb | 94 | 2.3Gb | 107 | 2.7Gb | 127 | 4.5Gb |
| [D] | 80 | 2.1Gb | 72 | 2.4Gb | 76 | 2.5Gb | 71 | 3.8Gb | [D] | 10 | 2.1Gb | 7 | 2.6Gb | 5 | 2.5Gb | 5 | 3.8Gb | 174 | 2.3Gb | 138 | 2.7Gb | 108 | 2.5Gb | 107 | 4.4Gb |
| [Ds] | 82 | 1.6Gb | 77 | 2.1Gb | 74 | 3.1Gb | 69 | 5.1Gb | [Ds] | 16 | 1.7Gb | 13 | 2.3Gb | 9 | 3.1Gb | 9 | 5.2Gb | 327 | 2.5Gb | 368 | 3.0Gb | 336 | 3.6Gb | 334 | 6.2Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 272 | 1.8Gb | 208 | 2.2Gb | 155 | 3.4Gb | 122 | 4.8Gb | 2000 x 50000 | [s] | 14 | 2.0Gb | 14 | 2.4Gb | 13 | 3.1Gb | 14 | 4.8Gb | 175 | 2.2Gb | 158 | 2.3Gb | 242 | 3.1Gb | 172 | 5.0Gb |
| [D] | 157 | 2.2Gb | 144 | 3.0Gb | 149 | 2.3Gb | 144 | 3.6Gb | [D] | 22 | 2.2Gb | 14 | 2.9Gb | 10 | 2.3Gb | 9 | 3.7Gb | 296 | 2.3Gb | 240 | 3.0Gb | 157 | 2.3Gb | 178 | 3.7Gb |
| [Ds] | 163 | 1.8Gb | 147 | 2.2Gb | 141 | 3.5Gb | 137 | 5.4Gb | [Ds] | 33 | 1.9Gb | 25 | 2.4Gb | 20 | 3.4Gb | 17 | 5.4Gb | 563 | 2.8Gb | 561 | 3.2Gb | 591 | 4.2Gb | 526 | 7.0Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 596 | 1.9Gb | 414 | 2.5Gb | 318 | 3.6Gb | 247 | 5.6Gb | 2000 x 100000 | [s] | 30 | 2.1Gb | 27 | 2.5Gb | 28 | 3.8Gb | 28 | 5.5Gb | 355 | 2.6Gb | 299 | 2.5Gb | 385 | 3.8Gb | 341 | 5.1Gb |
| [D] | 309 | 2.3Gb | 284 | 2.6Gb | 305 | 2.9Gb | 299 | 3.7Gb | [D] | 52 | 2.4Gb | 35 | 2.7Gb | 27 | 2.9Gb | 18 | 3.7Gb | 771 | 2.4Gb | 621 | 3.0Gb | 525 | 3.1Gb | 676 | 3.9Gb |
| [Ds] | 323 | 1.9Gb | 282 | 2.6Gb | 276 | 4.0Gb | 269 | 6.4Gb | [Ds] | 73 | 1.9Gb | 54 | 2.7Gb | 43 | 4.1Gb | 34 | 6.3Gb | 1337 | 3.0Gb | 1241 | 3.8Gb | 1297 | 5.2Gb | 1120 | 6.8Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 1200 | 2.6Gb | 876 | 2.8Gb | 661 | 4.0Gb | 527 | 7.1Gb | 2000 x 200000 | [s] | 55 | 2.6Gb | 55 | 2.8Gb | 55 | 4.1Gb | 58 | 7.1Gb | 662 | 3.0Gb | 570 | 3.0Gb | 584 | 4.2Gb | 775 | 7.0Gb |
| [D] | 612 | 2.6Gb | 569 | 3.1Gb | 611 | 2.8Gb | 617 | 4.1Gb | [D] | 112 | 2.6Gb | 80 | 3.1Gb | 56 | 2.8Gb | 38 | 4.1Gb | 1924 | 2.7Gb | 1318 | 3.3Gb | 1020 | 3.1Gb | 960 | 4.1Gb |
| [Ds] | 658 | 1.8Gb | 560 | 3.0Gb | 537 | 4.3Gb | 556 | 7.1Gb | [Ds] | 149 | 2.2Gb | 117 | 3.2Gb | 94 | 4.2Gb | 74 | 6.9Gb | 3107 | 3.4Gb | 2693 | 4.2Gb | 2571 | 5.8Gb | 2528 | 8.2Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Formats: [s] TENxMatrix (sparse) — [D] HDF5Matrix (dense) — [Ds] HDF5Matrix as sparse. For each operation, the best time across the four different block sizes is displayed in bold. In addition, if it’s also the best time across the three formats ([s],[D], and [Ds]), then we  box  it (only for Normalization and PCA). The “max. mem. used” is the max RSS (Resident Set Size) value obtained by running `ps u -p <PID>` every second while performing a given operation. “max. mem. used” values > 4Gb are displayed in light red. | | | | | | | | | | | | | | | | | | | | | | | | | | | |

## 6.4 Timings for Intel Mac Pro

| Specs for Intel Mac Pro (24-Core Intel Xeon W) | | | |
| --- | --- | --- | --- |
| OS | macOS 12.7.6 | Disk performance | N/A |
| RAM | 96GB |
| Disk | 1TB SSD |

Table 4: Timings for Intel Mac Pro

| Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | Normalized Test Dataset | F o r m a t | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | | block size = 16 Mb | | block size = 40 Mb | | block size = 100 Mb | | block size = 250 Mb | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| nrow x ncol  (# genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | nrow x ncol  (# sel. genes x # cells) | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used | time in sec. | max. mem. used |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  1000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 106 | 2.0Gb | 76 | 2.3Gb | 58 | 2.6Gb | 45 | 3.0Gb | 1000 x 12500 | [s] | 5 | 1.9Gb | 6 | 2.3Gb | 6 | 2.7Gb | 5 | 3.1Gb | 73 | 2.2Gb | 58 | 2.6Gb | 58 | 3.0Gb | 76 | 3.7Gb |
| [D] | 77 | 2.4Gb | 63 | 2.4Gb | 64 | 2.6Gb | 56 | 3.7Gb | [D] | 4 | 2.5Gb | 3 | 2.5Gb | 3 | 2.6Gb | 2 | 3.7Gb | 84 | 2.8Gb | 65 | 2.7Gb | 59 | 3.0Gb | 44 | 4.0Gb |
| [Ds] | 62 | 2.1Gb | 58 | 2.7Gb | 48 | 2.8Gb | 47 | 3.3Gb | [Ds] | 7 | 2.2Gb | 5 | 2.8Gb | 6 | 2.8Gb | 6 | 3.6Gb | 194 | 4.1Gb | 200 | 3.8Gb | 240 | 3.9Gb | 202 | 4.7Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 219 | 2.2Gb | 167 | 2.6Gb | 129 | 3.5Gb | 91 | 3.8Gb | 1000 x 25000 | [s] | 9 | 2.2Gb | 10 | 2.5Gb | 11 | 3.5Gb | 11 | 3.8Gb | 124 | 2.6Gb | 119 | 2.9Gb | 150 | 3.8Gb | 126 | 4.8Gb |
| [D] | 137 | 2.7Gb | 125 | 2.7Gb | 132 | 2.6Gb | 115 | 3.9Gb | [D] | 9 | 2.7Gb | 5 | 2.7Gb | 6 | 2.7Gb | 5 | 3.9Gb | 155 | 3.3Gb | 103 | 2.8Gb | 107 | 2.8Gb | 94 | 4.3Gb |
| [Ds] | 123 | 2.7Gb | 110 | 3.0Gb | 110 | 4.1Gb | 96 | 4.3Gb | [Ds] | 16 | 2.8Gb | 11 | 3.0Gb | 11 | 4.2Gb | 12 | 4.4Gb | 397 | 4.4Gb | 373 | 4.3Gb | 427 | 5.2Gb | 361 | 6.1Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 448 | 2.7Gb | 336 | 3.1Gb | 255 | 4.0Gb | 189 | 5.4Gb | 1000 x 50000 | [s] | 18 | 2.6Gb | 18 | 3.1Gb | 23 | 3.9Gb | 19 | 5.3Gb | 245 | 2.8Gb | 227 | 3.2Gb | 257 | 4.4Gb | 288 | 5.9Gb |
| [D] | 268 | 2.9Gb | 248 | 3.4Gb | 260 | 2.5Gb | 240 | 4.8Gb | [D] | 19 | 3.0Gb | 16 | 3.4Gb | 10 | 2.6Gb | 9 | 4.8Gb | 402 | 3.3Gb | 314 | 3.5Gb | 258 | 2.9Gb | 216 | 5.2Gb |
| [Ds] | 237 | 3.2Gb | 222 | 3.9Gb | 213 | 4.4Gb | 206 | 6.1Gb | [Ds] | 34 | 3.4Gb | 27 | 3.9Gb | 24 | 4.6Gb | 22 | 6.5Gb | 836 | 4.7Gb | 810 | 5.2Gb | 936 | 6.2Gb | 701 | 8.5Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 964 | 2.9Gb | 635 | 3.5Gb | 523 | 4.1Gb | 372 | 5.7Gb | 1000 x 100000 | [s] | 37 | 2.9Gb | 37 | 3.4Gb | 41 | 4.0Gb | 38 | 5.6Gb | 461 | 3.3Gb | 417 | 3.7Gb | 490 | 4.7Gb | 534 | 6.3Gb |
| [D] | 515 | 3.8Gb | 491 | 2.7Gb | 528 | 3.3Gb | 495 | 5.1Gb | [D] | 44 | 3.8Gb | 27 | 2.8Gb | 20 | 3.3Gb | 19 | 5.2Gb | 836 | 4.0Gb | 567 | 3.2Gb | 663 | 3.6Gb | 400 | 5.6Gb |
| [Ds] | 485 | 3.6Gb | 542 | 5.4Gb | 448 | 4.7Gb | 435 | 6.7Gb | [Ds] | 70 | 3.7Gb | 81 | 5.5Gb | 51 | 4.9Gb | 42 | 6.9Gb | 1737 | 5.3Gb | 1993 | 6.6Gb | 1865 | 6.7Gb | 1497 | 8.4Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 1947 | 3.4Gb | 1461 | 4.2Gb | 1062 | 5.2Gb | 840 | 7.9Gb | 1000 x 200000 | [s] | 75 | 3.5Gb | 77 | 4.2Gb | 87 | 5.1Gb | 79 | 7.5Gb | 912 | 3.7Gb | 913 | 4.3Gb | 1082 | 5.7Gb | 1005 | 8.1Gb |
| [D] | 1013 | 3.7Gb | 982 | 3.4Gb | 1059 | 2.9Gb | 1019 | 5.4Gb | [D] | 88 | 3.8Gb | 67 | 3.6Gb | 51 | 3.0Gb | 43 | 5.5Gb | 2372 | 4.7Gb | 1477 | 4.4Gb | 1219 | 3.8Gb | 795 | 5.9Gb |
| [Ds] | 990 | 4.2Gb | 947 | 5.1Gb | 805 | 7.0Gb | 843 | 8.8Gb | [Ds] | 140 | 4.3Gb | 127 | 5.1Gb | 101 | 6.8Gb | 88 | 8.7Gb | 4205 | 5.8Gb | 3974 | 7.3Gb | 3654 | 8.2Gb | 3303 | 10.2Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  | 1. NORMALIZATION  & selection of  2000  most variable genes | | | | | | | |  |  | 2. ON-DISK REALIZATION  of the normalized dataset | | | | | | | | 3. PCA of the normalized dataset | | | | | | | |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 12500 | [s] | 114 | 2.0Gb | 79 | 2.0Gb | 65 | 2.7Gb | 47 | 3.1Gb | 2000 x 12500 | [s] | 7 | 2.2Gb | 7 | 2.0Gb | 6 | 2.7Gb | 7 | 3.2Gb | 121 | 2.9Gb | 109 | 2.1Gb | 101 | 2.9Gb | 112 | 3.8Gb |
| [D] | 82 | 2.3Gb | 65 | 2.4Gb | 69 | 2.6Gb | 57 | 3.9Gb | [D] | 6 | 2.4Gb | 3 | 2.4Gb | 4 | 2.6Gb | 4 | 3.9Gb | 149 | 3.5Gb | 96 | 2.6Gb | 111 | 2.9Gb | 94 | 4.0Gb |
| [Ds] | 70 | 2.4Gb | 64 | 2.3Gb | 58 | 3.4Gb | 51 | 3.6Gb | [Ds] | 10 | 2.4Gb | 9 | 2.4Gb | 8 | 3.4Gb | 9 | 3.7Gb | 308 | 4.1Gb | 303 | 4.2Gb | 330 | 4.6Gb | 321 | 5.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 25000 | [s] | 225 | 2.4Gb | 181 | 2.3Gb | 132 | 3.2Gb | 106 | 4.4Gb | 2000 x 25000 | [s] | 14 | 2.7Gb | 14 | 2.4Gb | 13 | 3.3Gb | 13 | 4.5Gb | 218 | 3.9Gb | 199 | 2.4Gb | 212 | 3.6Gb | 273 | 5.3Gb |
| [D] | 147 | 3.0Gb | 131 | 2.6Gb | 137 | 2.6Gb | 125 | 4.9Gb | [D] | 16 | 3.0Gb | 12 | 2.9Gb | 9 | 2.7Gb | 7 | 4.9Gb | 377 | 3.3Gb | 283 | 3.3Gb | 209 | 3.0Gb | 191 | 5.3Gb |
| [Ds] | 137 | 2.6Gb | 123 | 2.8Gb | 123 | 4.0Gb | 117 | 5.0Gb | [Ds] | 26 | 2.8Gb | 21 | 3.1Gb | 17 | 3.9Gb | 15 | 5.3Gb | 649 | 4.5Gb | 634 | 4.7Gb | 652 | 5.7Gb | 623 | 7.3Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 50000 | [s] | 448 | 2.7Gb | 344 | 2.9Gb | 265 | 3.9Gb | 203 | 5.7Gb | 2000 x 50000 | [s] | 27 | 3.1Gb | 24 | 2.9Gb | 25 | 3.9Gb | 28 | 5.5Gb | 357 | 4.6Gb | 300 | 3.0Gb | 436 | 3.8Gb | 399 | 6.4Gb |
| [D] | 289 | 3.3Gb | 257 | 3.3Gb | 270 | 2.5Gb | 249 | 4.8Gb | [D] | 35 | 3.3Gb | 21 | 3.3Gb | 15 | 2.5Gb | 14 | 4.9Gb | 637 | 3.6Gb | 488 | 3.5Gb | 311 | 2.6Gb | 339 | 5.2Gb |
| [Ds] | 270 | 3.2Gb | 245 | 3.2Gb | 227 | 4.5Gb | 224 | 6.0Gb | [Ds] | 54 | 3.4Gb | 39 | 3.2Gb | 36 | 4.5Gb | 33 | 5.8Gb | 1105 | 4.9Gb | 1091 | 5.2Gb | 1124 | 6.0Gb | 1011 | 8.0Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 100000 | [s] | 1148 | 2.6Gb | 745 | 3.0Gb | 588 | 4.3Gb | 420 | 6.2Gb | 2000 x 100000 | [s] | 60 | 3.1Gb | 54 | 3.0Gb | 55 | 4.2Gb | 48 | 6.3Gb | 849 | 4.2Gb | 650 | 3.1Gb | 675 | 4.4Gb | 807 | 7.0Gb |
| [D] | 557 | 4.1Gb | 508 | 2.7Gb | 547 | 3.3Gb | 512 | 4.9Gb | [D] | 84 | 4.1Gb | 51 | 3.0Gb | 43 | 3.4Gb | 27 | 5.0Gb | 1616 | 4.2Gb | 1160 | 3.9Gb | 977 | 3.9Gb | 1205 | 5.5Gb |
| [Ds] | 544 | 3.6Gb | 474 | 4.4Gb | 448 | 5.5Gb | 435 | 7.4Gb | [Ds] | 110 | 3.8Gb | 92 | 4.3Gb | 80 | 5.3Gb | 58 | 7.1Gb | 2567 | 5.3Gb | 2327 | 6.0Gb | 2331 | 7.3Gb | 2130 | 9.2Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| 27998 x 200000 | [s] | 2135 | 4.3Gb | 1570 | 4.4Gb | 1136 | 5.5Gb | 869 | 8.5Gb | 2000 x 200000 | [s] | 121 | 4.8Gb | 113 | 4.4Gb | 107 | 5.5Gb | 114 | 8.2Gb | 1408 | 6.2Gb | 1236 | 4.5Gb | 1532 | 5.7Gb | 1761 | 9.3Gb |
| [D] | 1109 | 5.0Gb | 1005 | 3.4Gb | 1105 | 2.9Gb | 1043 | 5.2Gb | [D] | 152 | 5.0Gb | 111 | 3.5Gb | 83 | 3.0Gb | 58 | 5.3Gb | 3937 | 5.3Gb | 2364 | 4.3Gb | 1792 | 3.9Gb | 1328 | 5.7Gb |
| [Ds] | 1124 | 4.7Gb | 952 | 5.9Gb | 882 | 6.7Gb | 911 | 8.5Gb | [Ds] | 231 | 4.9Gb | 191 | 6.1Gb | 168 | 6.7Gb | 119 | 8.4Gb | 5913 | 7.1Gb | 4940 | 7.7Gb | 4822 | 8.6Gb | 4874 | 10.6Gb |
|  | | | | | | | | | | | | | | | | | | | | | | | | | | | |
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Formats: [s] TENxMatrix (sparse) — [D] HDF5Matrix (dense) — [Ds] HDF5Matrix as sparse. For each operation, the best time across the four different block sizes is displayed in bold. In addition, if it’s also the best time across the three formats ([s],[D], and [Ds]), then we  box  it (only for Normalization and PCA). The “max. mem. used” is the max RSS (Resident Set Size) value obtained by running `ps u -p <PID>` every second while performing a given operation. “max. mem. used” values > 4Gb are displayed in light red. | | | | | | | | | | | | | | | | | | | | | | | | | | | |

# 7 Discussion

The “**[Ds]** HDF5Matrix as sparse” representation didn’t live up to
its promise so we leave it alone for now. Note that the code for loading
blocks of data from the *dense* HDF5 file to memory does not currently
take full advantage of the SVT\_SparseArray representation, a new
efficient data structure for multidimensional *sparse* data implemented
in the *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)* package that overcomes some of the
limitations of the dgCMatrix representation from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)*
package. This will need to be addressed.

## 7.1 TENxMatrix (sparse) vs HDF5Matrix (dense)

### 7.1.1 Normalization

There’s no obvious best choice between the “**[s]** TENxMatrix (sparse)”
and “**[D]** HDF5Matrix (dense)” representations. More precisely, for
normalization, the former tends to give the best times when using bigger
blocks (e.g. 250 Mb), whereas the latter tends to give the best times when
using smaller blocks (e.g. 16 Mb).

Therefore, on a machine with enough memory to support big block sizes,
one will get the best results with the **[s]** representation and
blocks of 250 Mb or more. However, on a machine with not enough memory
to support such big blocks, one should instead use the **[D]** representation
with blocks of 16 Mb.

*[TODO: Add some plots to help vizualize the above observations.]*

### 7.1.2 PCA

For PCA, choosing the “**[s]** TENxMatrix (sparse)” representation
and using small block sizes (40 Mb) tends to give the best performance.

*[TODO: Add some plots to help vizualize this observation.]*

### 7.1.3 Hybrid approach

Note that, on a machine where using blocks of 250 Mb or more for
normalization is not an option, one should use the following hybrid
approach:

* Start with the “**[D]** HDF5Matrix (dense)” representation.
* Perform normalization, using very small blocks (16 Mb).
* Switch to the “**[s]** TENxMatrix (sparse)” format when writing
  the normalized dataset to disk, that is, use `writeTENxMatrix()`
  instead of `writeHDF5Array()` for on-disk realization of the
  intermediate dataset.
* Perform PCA on the object returned by the on-disk realization step
  (`writeTENxMatrix()`), using small blocks (40 Mb).

### 7.1.4 A note about memory usage

The machines running macOS use between 2x and 3x more memory than the
machines running Linux for the same task using the same block size.

Overall, on Linux, and for a given choice of block size, memory usage
doesn’t seem to be affected too much by the number of cells in the
dataset, that is, all operations seem to perform at *almost* constant
memory.

However, the “**[D]** HDF5Matrix (dense)” representation appears to
be better than the “**[s]** TENxMatrix (sparse)” representation at
keeping memory usage (mostly) flat as the number of cells in the
dataset increases. This is even more accentuated on macOS where, somehow
counter intuitively, using the dense representation manages to keep memory
usage at a reasonable level (and more or less capped with respect to the
number of cells), while using the sparse representation fails to do that.

## 7.2 Main takeaways

1. Using the TENxMatrix representation (sparse format), one can perform
   **normalization and PCA** of the bigger dataset (200,000 cells) on an
   average consumer-grade laptop like the DELL XPS 15 laptop (model 9520)
   **in less than 25 minutes and using less than 4Gb of memory**, as shown
   in the table below.
   For comparison, normalization and PCA on an *in-memory* representation
   of the same dataset (e.g. on a SparseMatrix object) takes less then
   4 minutes. However, that consumes about 18.5Gb of memory! This will be
   the subject of an upcoming vignette in the *[SparseArray](https://bioconductor.org/packages/3.22/SparseArray)*
   package.

Comparing times across machines

| Machine | NORMALIZATION time block size = 250 Mb | REALIZATION time block size = 250 Mb | PCA time block size = 40 Mb | TOTAL time | Max. mem. |
| --- | --- | --- | --- | --- | --- |
| DELL XPS 15 laptop | 643 | 69 | 692 | 1404 | 2.9Gb |
| Supermicro SuperServer 1029GQ-TRT | 1069 | 110 | 1494 | 2673 | 3.0Gb |
| Apple Silicon Mac Pro | 527 | 58 | 570 | 1155 | 7.1Gb |
| Intel Mac Pro | 869 | 114 | 1236 | 2219 | 8.5Gb |
|  |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| For each machine, we show the normalization, realization, and PCA times (plus total time) obtained on the 27998 x 200000 dataset, using the “[s] TENxMatrix (sparse)” format, and selecting the 2000 most variable genes during the normalization step. All times are in seconds. | | | | | |

2. Normalization and PCA are roughly **linear in time** with respect to the
   number of cells in the dataset, regardless of representation (sparse or
   dense) or block size.
3. Block size matters. When using the TENxMatrix representation (sparse format),
   the bigger the blocks the faster normalization will be (at the cost of
   increased memory usage). On the other hand, it seems that PCA prefers
   small blocks, at least with our naive `simple_PCA()` implementation.
4. Disk performance is important (not surprisingly) as attested by the lower
   performance of the Supermicro SuperServer 1029GQ-TRT machine, likely due
   to its slower disk.

# 8 Session information

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
##  [1] TENxBrainData_1.29.0        SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] RSpectra_0.16-2             DelayedMatrixStats_1.32.0
##  [9] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [11] BiocFileCache_3.0.0         dbplyr_2.5.1
## [13] HDF5Array_1.38.0            h5mread_1.2.0
## [15] rhdf5_2.54.0                DelayedArray_0.36.0
## [17] SparseArray_1.10.0          S4Arrays_1.10.0
## [19] IRanges_2.44.0              abind_1.4-8
## [21] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [23] matrixStats_1.5.0           BiocGenerics_0.56.0
## [25] generics_0.1.4              Matrix_1.7-4
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          xfun_0.53                bslib_0.9.0
##  [4] httr2_1.2.1              lattice_0.22-7           rhdf5filters_1.22.0
##  [7] vctrs_0.6.5              tools_4.5.1              curl_7.0.0
## [10] tibble_3.3.0             AnnotationDbi_1.72.0     RSQLite_2.4.3
## [13] blob_1.2.4               pkgconfig_2.0.3          sparseMatrixStats_1.22.0
## [16] lifecycle_1.0.4          compiler_4.5.1           Biostrings_2.78.0
## [19] htmltools_0.5.8.1        sass_0.4.10              yaml_2.3.10
## [22] pillar_1.11.1            crayon_1.5.3             jquerylib_0.1.4
## [25] cachem_1.1.0             tidyselect_1.2.1         digest_0.6.37
## [28] purrr_1.1.0              dplyr_1.1.4              bookdown_0.45
## [31] BiocVersion_3.22.0       fastmap_1.2.0            grid_4.5.1
## [34] cli_3.6.5                magrittr_2.0.4           withr_3.0.2
## [37] filelock_1.0.3           rappdirs_0.3.3           bit64_4.6.0-1
## [40] rmarkdown_2.30           XVector_0.50.0           httr_1.4.7
## [43] bit_4.6.0                png_0.1-8                memoise_2.0.1
## [46] evaluate_1.0.5           knitr_1.50               rlang_1.1.6
## [49] Rcpp_1.1.0               glue_1.8.0               DBI_1.2.3
## [52] BiocManager_1.30.26      jsonlite_2.0.0           R6_2.6.1
## [55] Rhdf5lib_1.32.0
```