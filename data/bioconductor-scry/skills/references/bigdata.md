# Scry Methods For Larger Datasets

## Will Townes

### 30 October, 2025

```
suppressPackageStartupMessages(library(TENxPBMCData))
require(scry)
```

```
## Loading required package: scry
```

We illustrate the application of scry methods to disk-based data from the
TENxPBMCData package. Each dataset in this package is stored in an HDF5 file
that is accessed through a DelayedArray interface. This avoids the need to
load the entire dataset into memory for analysis.

## Feature Selection with Deviance

```
sce<-TENxPBMCData(dataset="pbmc3k")
```

```
## see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
```

```
## loading from cache
```

```
h5counts<-counts(sce)
seed(h5counts) #print information about object
```

```
## An object of class "HDF5ArraySeed"
## Slot "filepath":
## [1] "/home/biocbuild/.cache/R/ExperimentHub/2a3f825c07391_1605"
##
## Slot "name":
## [1] "/counts"
##
## Slot "as_sparse":
## [1] TRUE
##
## Slot "type":
## [1] NA
##
## Slot "dim":
## [1] 32738  2700
##
## Slot "chunkdim":
## [1] 631  52
##
## Slot "first_val":
## [1] 0
```

```
h5counts<-h5counts[rowSums(h5counts)>0,]
system.time(h5devs<-devianceFeatureSelection(h5counts)) # 26 sec
```

```
##    user  system elapsed
##  28.595   3.984  32.556
```

We now compare the computation speed when the same data is converted to an
ordinary array in-memory. Note this would not be possible with larger
HDF5Array objects.

```
denseCounts<-as.matrix(h5counts)
system.time(denseDevs<-devianceFeatureSelection(denseCounts)) # 5 sec
```

```
##    user  system elapsed
##   5.224   1.018   6.242
```

```
max(abs(denseDevs-h5devs)) #should be close to zero
```

```
## [1] 0
```

Finally we compare the speed when the counts data are stored in a sparse
in-memory Matrix format

```
mean(denseCounts>0) #shows that the data are mostly zeros so sparsity useful
```

```
## [1] 0.05091945
```

```
sparseCounts<-Matrix::Matrix(denseCounts,sparse=TRUE)
system.time(sparseDevs<-devianceFeatureSelection(sparseCounts)) #1.6 sec
```

```
##    user  system elapsed
##   1.088   0.446   1.533
```

```
max(abs(sparseDevs-h5devs)) #should be close to zero
```

```
## [1] 1.629815e-09
```

Using disk-based data saves memory but slows computation time. When the data
contain mostly zeros, and are not too large, the sparse in-memory Matrix
object achieves fastest computation times. The resulting deviance statistics
are the same for all of the different data formats.

## Null residuals

One can run `nullResiduals` on `HDF5Matrix`, `DelayedArray` matrices, and sparse
matrices from the `Matrix` package with the same syntax used for the base
matrix case.

We illustrate this with the same dataset from the `TENxPBMCData` package.

```
sce <- nullResiduals(sce, assay="counts", type="deviance")
str(sce)
```