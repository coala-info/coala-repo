# Code example from 'UsingHDF5Array' vignette. See references/ for full tutorial.

## ----load_packages, include=TRUE, results="hide", message=FALSE, warning=FALSE----
library(MultiAssayExperiment)
library(HDF5Array)
library(SummarizedExperiment)

## ----create_small_matrix------------------------------------------------------
smallMatrix <- matrix(rnorm(10e5), ncol = 20)

## ----add_dimnames-------------------------------------------------------------
rownames(smallMatrix) <- paste0("GENE", seq_len(nrow(smallMatrix)))
colnames(smallMatrix) <- paste0("SampleID", seq_len(ncol(smallMatrix)))

## ----delayed_array_constructor------------------------------------------------
smallMatrix <- DelayedArray(smallMatrix)
class(smallMatrix)
# show method
smallMatrix

dim(smallMatrix)

## ----write_hdf5_array---------------------------------------------------------
testh5 <- tempfile(fileext = ".h5")
writeHDF5Array(smallMatrix, filepath = testh5, name = "smallMatrix",
    with.dimnames = TRUE)

## ----h5ls_output--------------------------------------------------------------
h5ls(testh5)

## ----import_hdf5_files--------------------------------------------------------
hdf5Data <- HDF5ArraySeed(file = testh5, name = "smallMatrix")
newDelayedMatrix <- DelayedArray(hdf5Data)
class(newDelayedMatrix)
newDelayedMatrix

## ----delayed_matrix_with_mae--------------------------------------------------
HDF5MAE <- MultiAssayExperiment(experiments = list(smallMatrix = smallMatrix))
sampleMap(HDF5MAE)
colData(HDF5MAE)

## ----se_with_delayed_matrix---------------------------------------------------
HDF5SE <- SummarizedExperiment(assays = smallMatrix)
assay(HDF5SE)
MultiAssayExperiment(list(HDF5SE = HDF5SE))

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

