# Code example from 'DelayedTensor_3' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----Setting, echo=TRUE-------------------------------------------------------
suppressPackageStartupMessages(library("DelayedTensor"))
suppressPackageStartupMessages(library("DelayedArray"))
suppressPackageStartupMessages(library("HDF5Array"))
suppressPackageStartupMessages(library("DelayedRandomArray"))

darr <- RandomUnifArray(c(3,4,5))

setVerbose(FALSE)
setSparse(FALSE)
setAutoBlockSize(1E+8)
tmpdir <- tempdir()
setHDF5DumpDir(tmpdir)

## ----Tensor Decomposition 1, echo=TRUE----------------------------------------
out_hosvd <- hosvd(darr, ranks=c(2,1,3))
str(out_hosvd)
out_tucker <- tucker(darr, ranks=c(2,3,2))
str(out_tucker)

## ----Tensor Decomposition 2, echo=TRUE----------------------------------------
out_cp <- cp(darr, num_components=2)
str(out_cp)

## ----Tensor Decomposition 3, echo=TRUE----------------------------------------
out_mpca <- mpca(darr, ranks=c(2,2))
str(out_mpca)

## ----Tensor Decomposition 4, echo=TRUE----------------------------------------
out_pvd <- pvd(darr,
  uranks=rep(2,dim(darr)[3]), wranks=rep(3,dim(darr)[3]), a=2, b=3)
str(out_pvd)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

