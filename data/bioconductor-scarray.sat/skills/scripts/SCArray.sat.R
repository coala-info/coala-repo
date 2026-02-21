# Code example from 'SCArray.sat' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(warning=FALSE, error=FALSE, message=FALSE)

## ----workflow, echo=FALSE, fig.cap="Overview of the SCArray framework.", fig.wide=TRUE----
knitr::include_graphics("scarray_sat.svg")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SCArray.sat")

## -----------------------------------------------------------------------------
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
scClose(f)    # close the file


# Create a Seurat object from the GDS file
d <- scNewSeuratGDS(fn)
class(GetAssay(d))    # SCArrayAssay, derived from Assay

d <- NormalizeData(d)
d <- FindVariableFeatures(d, nfeatures=500)
d <- ScaleData(d)

## -----------------------------------------------------------------------------
# get the file name for the on-disk object
scGetFiles(d)

# raw counts
m <- GetAssayData(d, slot="counts")
scGetFiles(m)    # the file name storing raw count data
m

# normalized expression
# the normalized data does not save in neither the file nor the memory
GetAssayData(d, slot="data")

# scaled and centered data matrix
# in this example, the scaled data does not save in neither the file nor the memory
GetAssayData(d, slot="scale.data")

## ----fig.wide=TRUE------------------------------------------------------------
d <- RunPCA(d, ndims.print=1:2)
DimPlot(d, reduction="pca")

d <- RunUMAP(d, dims=1:50)    # use all PCs calculated by RunPCA()
DimPlot(d, reduction="umap")

## ----benchmark, echo=FALSE, fig.cap="The benchmark on PCA & UMAP with large datasets (CPU: Intel Xeon Gold 6248 @2.50GHz, RAM: 176GB).", fig.wide=TRUE----
knitr::include_graphics("benchmark.svg")

## -----------------------------------------------------------------------------
d    # the example for the small dataset

save_fn <- tempfile(fileext=".rds")  # or specify an appropriate location
save_fn
saveRDS(d, save_fn)  # save to a RDS file

remove(d)  # delete the variable d
gc()       # trigger a garbage collection

d <- readRDS(save_fn)  # load from a RDS file
d
GetAssayData(d, slot="counts")  # reopens the GDS file automatically

## -----------------------------------------------------------------------------
is(GetAssay(d))

new_d <- scMemory(d)  # downgrade the active assay
is(GetAssay(new_d))

## -----------------------------------------------------------------------------
is(GetAssayData(d, slot="scale.data"))  # it is a DelayedMatrix

new_d <- scMemory(d, slot="scale.data")  # downgrade "scale.data" in the active assay
is(GetAssay(new_d))  # it is still SCArrayAssay
is(GetAssayData(new_d, slot="scale.data"))  # in-memory matrix

## -----------------------------------------------------------------------------
is(d)

sce <- as.SingleCellExperiment(d)
is(sce)
sce

counts(sce)  # raw counts

## -----------------------------------------------------------------------------
options(SCArray.verbose=TRUE)

d <- ScaleData(d)

## -----------------------------------------------------------------------------
# print version information about R, the OS and attached or loaded packages
sessionInfo()

## ----echo=FALSE---------------------------------------------------------------
unlink("test.rds", force=TRUE)

