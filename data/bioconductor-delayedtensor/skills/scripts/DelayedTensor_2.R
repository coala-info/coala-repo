# Code example from 'DelayedTensor_2' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----Setting 1, echo=TRUE-----------------------------------------------------
suppressPackageStartupMessages(library("DelayedTensor"))
suppressPackageStartupMessages(library("DelayedArray"))
suppressPackageStartupMessages(library("HDF5Array"))
suppressPackageStartupMessages(library("DelayedRandomArray"))

darr1 <- RandomUnifArray(c(2,3,4))
darr2 <- RandomUnifArray(c(2,3,4))

## ----Setting 2, echo=TRUE-----------------------------------------------------
DelayedTensor::setSparse(as.sparse=FALSE)

## ----Setting 3, echo=TRUE-----------------------------------------------------
DelayedTensor::setVerbose(as.verbose=FALSE)

## ----Setting 4, echo=TRUE-----------------------------------------------------
setAutoBlockSize(size=1E+8)

## ----Setting 5, echo=TRUE-----------------------------------------------------
# tmpdir <- paste(sample(c(letters,1:9), 10), collapse="")
# dir.create(tmpdir, recursive=TRUE))
tmpdir <- tempdir()
setHDF5DumpDir(tmpdir)

## ----Setting 6, echo=TRUE-----------------------------------------------------
DelayedTensor::getSparse()
DelayedTensor::getVerbose()
getAutoBlockSize()
getHDF5DumpDir()

## ----Unfold/Fold operations 1, echo=TRUE--------------------------------------
dmat1 <- DelayedTensor::unfold(darr1, row_idx=c(1,2), col_idx=3)
dmat1

## ----Unfold/Fold operations 2, echo=TRUE--------------------------------------
dmat1_to_darr1 <- DelayedTensor::fold(dmat1,
    row_idx=c(1,2), col_idx=3, modes=dim(darr1))
dmat1_to_darr1
identical(as.array(darr1), as.array(dmat1_to_darr1))

## ----Unfold/Fold operations 3, echo=TRUE--------------------------------------
dmat2 <- DelayedTensor::k_unfold(darr1, m=1)
dmat2_to_darr1 <- k_fold(dmat2, m=1, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat2_to_darr1))

dmat3 <- DelayedTensor::k_unfold(darr1, m=2)
dmat3_to_darr1 <- k_fold(dmat3, m=2, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat3_to_darr1))

dmat4 <- DelayedTensor::k_unfold(darr1, m=3)
dmat4_to_darr1 <- k_fold(dmat4, m=3, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat4_to_darr1))

## ----Unfold/Fold operations 4, echo=TRUE--------------------------------------
dmat8 <- DelayedTensor::cs_unfold(darr1, m=1)
dmat8_to_darr1 <- DelayedTensor::cs_fold(dmat8, m=1, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat8_to_darr1))

dmat9 <- DelayedTensor::cs_unfold(darr1, m=2)
dmat9_to_darr1 <- DelayedTensor::cs_fold(dmat9, m=2, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat9_to_darr1))

dmat10 <- DelayedTensor::cs_unfold(darr1, m=3)
dmat10_to_darr1 <- DelayedTensor::cs_fold(dmat10, m=3, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat10_to_darr1))

## ----Unfold/Fold operations 5, echo=TRUE--------------------------------------
dmat11 <- DelayedTensor::matvec(darr1)
dmat11_darr1 <- DelayedTensor::unmatvec(dmat11, modes=dim(darr1))
identical(as.array(darr1), as.array(dmat11_darr1))

## ----Unfold/Fold operations 7, echo=TRUE--------------------------------------
dmatZ <- RandomUnifArray(c(10,4))
DelayedTensor::ttm(darr1, dmatZ, m=3)

## ----Unfold/Fold operations 6, echo=TRUE--------------------------------------
dmatX <- RandomUnifArray(c(10,2))
dmatY <- RandomUnifArray(c(10,3))
dlizt <- list(dmatX = dmatX, dmatY = dmatY)
DelayedTensor::ttl(darr1, dlizt, ms=c(1,2))

## ----Vectorization, echo=TRUE-------------------------------------------------
DelayedTensor::vec(darr1)

## ----Norm operations 1, echo=TRUE---------------------------------------------
DelayedTensor::fnorm(darr1)

## ----Norm operations 2, echo=TRUE---------------------------------------------
DelayedTensor::innerProd(darr1, darr2)

## ----Outer Product, echo=TRUE-------------------------------------------------
DelayedTensor::outerProd(darr1[,,1], darr2[,,1])

## ----Diagonal operations 1, echo=TRUE-----------------------------------------
dgdarr <- DelayedTensor::DelayedDiagonalArray(c(5,6,7), 1:5)
dgdarr

## ----Diagonal operations 2, echo=TRUE-----------------------------------------
DelayedTensor::diag(dgdarr)

## ----Diagonal operations 3, echo=TRUE-----------------------------------------
DelayedTensor::diag(dgdarr) <- c(1111, 2222, 3333, 4444, 5555)
DelayedTensor::diag(dgdarr)

## ----Mode-wise operations 1, echo=TRUE----------------------------------------
DelayedTensor::modeSum(darr1, m=1)
DelayedTensor::modeSum(darr1, m=2)
DelayedTensor::modeSum(darr1, m=3)

## ----Mode-wise operations 2, echo=TRUE----------------------------------------
DelayedTensor::modeMean(darr1, m=1)
DelayedTensor::modeMean(darr1, m=2)
DelayedTensor::modeMean(darr1, m=3)

## ----Tensor product operations 1, echo=TRUE-----------------------------------
prod_h <- DelayedTensor::hadamard(darr1, darr2)
dim(prod_h)

## ----Tensor product operations 2, echo=TRUE-----------------------------------
prod_hl <- DelayedTensor::hadamard_list(list(darr1, darr2))
dim(prod_hl)

## ----Tensor product operations 3, echo=TRUE-----------------------------------
prod_kron <- DelayedTensor::kronecker(darr1, darr2)
dim(prod_kron)

## ----Tensor product operations 4, echo=TRUE-----------------------------------
prod_kronl <- DelayedTensor::kronecker_list(list(darr1, darr2))
dim(prod_kronl)

## ----Tensor product operations 5, echo=TRUE-----------------------------------
prod_kr <- DelayedTensor::khatri_rao(darr1[,,1], darr2[,,1])
dim(prod_kr)

## ----Tensor product operations 6, echo=TRUE-----------------------------------
prod_krl <- DelayedTensor::khatri_rao_list(list(darr1[,,1], darr2[,,1]))
dim(prod_krl)

## ----Utilities 1, echo=TRUE---------------------------------------------------
str(DelayedTensor::list_rep(darr1, 3))

## ----Utilities 2, echo=TRUE---------------------------------------------------
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=1))
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=2))
dim(DelayedTensor::modebind_list(list(darr1, darr2), m=3))

## ----Utilities 3, echo=TRUE---------------------------------------------------
dim(DelayedTensor::rbind_list(list(darr1[,,1], darr2[,,1])))

## ----Utilities 4, echo=TRUE---------------------------------------------------
dim(DelayedTensor::cbind_list(list(darr1[,,1], darr2[,,1])))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

