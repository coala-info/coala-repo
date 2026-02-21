# BiocSklearn – exposing python Scikit machine learning elements for Bioconductor

Vincent J. Carey, stvjc at channing.harvard.edu, Shweta Gopaulakrishnan, reshg at channing.harvard.edu, Samuela Pollack, spollack at jimmy.harvard.edu

#### October 29, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Basic concepts](#basic-concepts)
  + [2.1 Module references](#module-references)
  + [2.2 Python documentation](#python-documentation)
  + [2.3 Importing data for direct handling by python functions](#importing-data-for-direct-handling-by-python-functions)
* [3 Dimension reduction with sklearn: illustration with iris dataset](#dimension-reduction-with-sklearn-illustration-with-iris-dataset)
  + [3.1 PCA](#pca)
  + [3.2 Incremental PCA](#incremental-pca)
  + [3.3 Manual incremental PCA with explicit chunking](#manual-incremental-pca-with-explicit-chunking)
* [4 Interoperation with HDF5 matrix](#interoperation-with-hdf5-matrix)
  + [4.1 How to expand scope of BiocSklearn](#how-to-expand-scope-of-biocsklearn)
* [5 Conclusions](#conclusions)

# 1 Introduction

Scientific computing in python is well-established. This
package takes advantage of new work at Rstudio that fosters
python-R interoperability. Identifying
good practices of interface
design will require extensive discussion and experimentation,
and this package takes an initial step in this direction.

A key motivation is experimenting with an incremental PCA
implementation with very large out-of-memory data. We have
also provided an interface to the sklearn.cluster.KMeans
procedure.

# 2 Basic concepts

## 2.1 Module references

The package includes a list of references to python
modules.

```
library(BiocSklearn)
```

## 2.2 Python documentation

We can acquire python documentation of included modules with
reticulate’s `py_help`: The following result could
get stale:

```
skd = reticulate::import("sklearn")$decomposition
py_help(skd)
Help on package sklearn.decomposition in sklearn:

NAME
    sklearn.decomposition

FILE
    /Users/stvjc/anaconda2/lib/python2.7/site-packages/sklearn/decomposition/__init__.py

DESCRIPTION
    The :mod:`sklearn.decomposition` module includes matrix decomposition
    algorithms, including among others PCA, NMF or ICA. Most of the algorithms of
    this module can be regarded as dimensionality reduction techniques.

PACKAGE CONTENTS
    _online_lda
    base
    cdnmf_fast
    dict_learning
    factor_analysis
    fastica_
    incremental_pca
...
```

## 2.3 Importing data for direct handling by python functions

The reticulate package is designed to limit the amount
of effort required to convert data from R to python
for natural use in each language.

```
library(BiocSklearn)
np = reticulate::import("numpy", convert=FALSE, delay_load=TRUE)
irloc = system.file("csv/iris.csv", package="BiocSklearn")
irismat = np$genfromtxt(irloc, delimiter=',')
```

To examine a submatrix, we use the take method from numpy.
The bracket format seen below notifies us that we are not looking at
data native to R.

```
np$take(irismat, 0:2, 0L )
```

```
## array([[5.1, 3.5, 1.4, 0.2],
##        [4.9, 3. , 1.4, 0.2],
##        [4.7, 3.2, 1.3, 0.2]])
```

# 3 Dimension reduction with sklearn: illustration with iris dataset

We’ll use R’s prcomp as a first
test to demonstrate performance of the sklearn modules
with the iris data.

```
fullpc = prcomp(data.matrix(iris[,1:4]))$x
```

## 3.1 PCA

We have a python representation of the iris data. We
compute the PCA as follows:

```
ppca = skPCA(data.matrix(iris[,1:4]))
ppca
```

```
## SkDecomp instance, method:  PCA
## use getTransformed() to acquire projected input.
```

This returns an object that can be reused through python methods.
The numerical transformation is accessed via `getTransformed`.

```
tx = getTransformed(ppca)
dim(tx)
```

```
## [1] 150   4
```

```
head(tx)
```

```
##           [,1]       [,2]        [,3]         [,4]
## [1,] -2.684126  0.3193972 -0.02791483  0.002262437
## [2,] -2.714142 -0.1770012 -0.21046427  0.099026550
## [3,] -2.888991 -0.1449494  0.01790026  0.019968390
## [4,] -2.745343 -0.3182990  0.03155937 -0.075575817
## [5,] -2.728717  0.3267545  0.09007924 -0.061258593
## [6,] -2.280860  0.7413304  0.16867766 -0.024200858
```

Concordance with the R computation can be checked:

```
round(cor(tx, fullpc),3)
```

```
##      PC1 PC2 PC3 PC4
## [1,]   1   0   0   0
## [2,]   0  -1   0   0
## [3,]   0   0  -1   0
## [4,]   0   0   0   1
```

## 3.2 Incremental PCA

A computation supporting *a priori* bounding of memory
consumption is available. In this procedure one can
also select the number of principal components to compute.

In August 2022 this chunk is blocked. Basilisk discipline is needed.

```
ippca = skIncrPCA(irismat) # problematic, needs basilisk cover
ippcab = skIncrPCA(irismat, batch_size=25L)
round(cor(getTransformed(ippcab), fullpc),3)
```

## 3.3 Manual incremental PCA with explicit chunking

This procedure can be used when data are provided
in chunks, perhaps from a stream. We iteratively
update the object, for which there is no container
at present. Again the number of components computed
can be specified.

```
ta = np$take # provide slicer utility
ipc = skPartialPCA_step(ta(irismat,0:49,0L))
ipc = skPartialPCA_step(ta(irismat,50:99,0L), obj=ipc)
ipc = skPartialPCA_step(ta(irismat,100:149,0L), obj=ipc)
ipc$transform(ta(irismat,0:5,0L))
fullpc[1:5,]
```

# 4 Interoperation with HDF5 matrix

We have extracted methylation data for the Yoruban
subcohort of CEPH from the yriMulti package. Data
from chr6 and chr17 are available in an HDF5 matrix
in this BiocSklearn package. A reference to the
dataset through the h5py File interface is created by
`H5matref`.

Please run `example(H5matref)` for illustration.

## 4.1 How to expand scope of BiocSklearn

Consider the problem reported at [slack](https://community-bioc.slack.com/archives/CLUJWDQF4/p1661525488687379),
in which

```
>>> import sklearn.impute
>>> X = [[0, 1, 3], [3, 4, 5]]
>>> gen = sklearn.metrics.pairwise_distances_chunked(X)
>>> for chunk in gen:
...     print(chunk)
```

cannot be done in a certain docker container application.

We introduce the following function in BiocSklearn/R,
omitting the ‘chunked’ element:

```
skPWD = function(mat, ...) {
 proc = basilisk::basiliskStart(bsklenv) # avoid package-specific import
 on.exit(basilisk::basiliskStop(proc))
 basilisk::basiliskRun(proc, function(mat, ...) {
     sk = reticulate::import("sklearn")
     sk$metrics$pairwise_distances(mat, ...)
   }, mat=mat, ...)
}
```

`bsklenv` is defined for the BiocSklearn package as

```
# necessary for python module control
bsklenv <- basilisk::BasiliskEnvironment(envname="bsklenv",
    pkgname="BiocSklearn",
    packages=c("scikit-learn==1.0.2", "h5py==3.6.0", "pandas==1.3.5", "joblib==1.0.0"))
```

# 5 Conclusions

We need more applications and profiling.