# Code example from 'DelayedTensor_4' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----Matrix Multiplication 1, echo=TRUE---------------------------------------
A <- matrix(runif(3*4), nrow=3, ncol=4)
B <- matrix(runif(4*5), nrow=4, ncol=5)
C <- matrix(0, nrow=3, ncol=5)

I <- nrow(A)
J <- ncol(A)
K <- ncol(B)

for(i in 1:I){
  for(j in 1:J){
    for(k in 1:K){
      C[i,k] = C[i,k] + A[i,j] * B[j,k]
    }
  }
}

## ----Matrix Multiplication 2, echo=TRUE---------------------------------------
C <- A %*% B

## ----Matrix Multiplication 3, echo=TRUE---------------------------------------
suppressPackageStartupMessages(library("einsum"))
C <- einsum('ij,jk->ik', A, B)

## ----Setting, echo=TRUE-------------------------------------------------------
suppressPackageStartupMessages(library("DelayedTensor"))
suppressPackageStartupMessages(library("DelayedArray"))

arrA <- array(runif(3), dim=c(3))
arrB <- array(runif(3*3), dim=c(3,3))
arrC <- array(runif(3*4), dim=c(3,4))
arrD <- array(runif(3*3*3), dim=c(3,3,3))
arrE <- array(runif(3*4*5), dim=c(3,4,5))

darrA <- DelayedArray(arrA)
darrB <- DelayedArray(arrB)
darrC <- DelayedArray(arrC)
darrD <- DelayedArray(arrD)
darrE <- DelayedArray(arrE)

## ----Print 1, echo=TRUE-------------------------------------------------------
einsum::einsum('i->i', arrA)
DelayedTensor::einsum('i->i', darrA)

## ----Print 2, echo=TRUE-------------------------------------------------------
einsum::einsum('ij->ij', arrC)
DelayedTensor::einsum('ij->ij', darrC)

## ----Print 3, echo=TRUE-------------------------------------------------------
einsum::einsum('ijk->ijk', arrE)
DelayedTensor::einsum('ijk->ijk', darrE)

## ----Diag 1, echo=TRUE--------------------------------------------------------
einsum::einsum('ii->i', arrB)
DelayedTensor::einsum('ii->i', darrB)

## ----Diag 2, echo=TRUE--------------------------------------------------------
einsum::einsum('iii->i', arrD)
DelayedTensor::einsum('iii->i', darrD)

## ----Hadamard Product 1, echo=TRUE--------------------------------------------
einsum::einsum('i,i->i', arrA, arrA)
DelayedTensor::einsum('i,i->i', darrA, darrA)

## ----Hadamard Product 2, echo=TRUE--------------------------------------------
einsum::einsum('ij,ij->ij', arrC, arrC)
DelayedTensor::einsum('ij,ij->ij', darrC, darrC)

## ----Hadamard Product 3, echo=TRUE--------------------------------------------
einsum::einsum('ijk,ijk->ijk', arrE, arrE)
DelayedTensor::einsum('ijk,ijk->ijk', darrE, darrE)

## ----Outer Product 1, echo=TRUE-----------------------------------------------
einsum::einsum('i,j->ij', arrA, arrA)
DelayedTensor::einsum('i,j->ij', darrA, darrA)

## ----Outer Product 2, echo=TRUE-----------------------------------------------
einsum::einsum('ij,klm->ijklm', arrC, arrE)
DelayedTensor::einsum('ij,klm->ijklm', darrC, darrE)

## ----Summation 1, echo=TRUE---------------------------------------------------
einsum::einsum('i->', arrA)
DelayedTensor::einsum('i->', darrA)

## ----Summation 2, echo=TRUE---------------------------------------------------
einsum::einsum('ij->', arrC)
DelayedTensor::einsum('ij->', darrC)

## ----Summation 3, echo=TRUE---------------------------------------------------
einsum::einsum('ijk->', arrE)
DelayedTensor::einsum('ijk->', darrE)

## ----rowSums, echo=TRUE-------------------------------------------------------
einsum::einsum('ij->i', arrC)
DelayedTensor::einsum('ij->i', darrC)

## ----colSums, echo=TRUE-------------------------------------------------------
einsum::einsum('ij->j', arrC)
DelayedTensor::einsum('ij->j', darrC)

## ----Summation in each Mode 1, echo=TRUE--------------------------------------
einsum::einsum('ijk->i', arrE)
DelayedTensor::einsum('ijk->i', darrE)

## ----Summation in each Mode 2, echo=TRUE--------------------------------------
einsum::einsum('ijk->j', arrE)
DelayedTensor::einsum('ijk->j', darrE)

## ----Summation in each Mode 3, echo=TRUE--------------------------------------
einsum::einsum('ijk->k', arrE)
DelayedTensor::einsum('ijk->k', darrE)

## ----Mode Sum 1, echo=TRUE----------------------------------------------------
einsum::einsum('ijk->ij', arrE)
DelayedTensor::einsum('ijk->ij', darrE)

## ----Mode Sum 2, echo=TRUE----------------------------------------------------
einsum::einsum('ijk->jk', arrE)
DelayedTensor::einsum('ijk->jk', darrE)

## ----Mode Sum 3, echo=TRUE----------------------------------------------------
einsum::einsum('ijk->jk', arrE)
DelayedTensor::einsum('ijk->jk', darrE)

## ----Trace, echo=TRUE---------------------------------------------------------
einsum::einsum('ii->', arrB)
DelayedTensor::einsum('ii->', darrB)

## ----Permutation 1, echo=TRUE-------------------------------------------------
einsum::einsum('ij->ji', arrB)
DelayedTensor::einsum('ij->ji', darrB)

## ----Permutation 2, echo=TRUE-------------------------------------------------
einsum::einsum('ijk->jki', arrD)
DelayedTensor::einsum('ijk->jki', darrD)

## ----Inner Product 1, echo=TRUE-----------------------------------------------
einsum::einsum('i,i->', arrA, arrA)
DelayedTensor::einsum('i,i->', darrA, darrA)

## ----Inner Product 2, echo=TRUE-----------------------------------------------
einsum::einsum('ij,ij->', arrC, arrC)
DelayedTensor::einsum('ij,ij->', darrC, darrC)

## ----Inner Product 3, echo=TRUE-----------------------------------------------
einsum::einsum('ijk,ijk->', arrE, arrE)
DelayedTensor::einsum('ijk,ijk->', darrE, darrE)

## ----Contracted Product, echo=TRUE--------------------------------------------
einsum::einsum('ijk,ijk->jk', arrE, arrE)
DelayedTensor::einsum('ijk,ijk->jk', darrE, darrE)

## ----Matrix Multiplication, echo=TRUE-----------------------------------------
einsum::einsum('ij,jk->ik', arrC, t(arrC))
DelayedTensor::einsum('ij,jk->ik', darrC, t(darrC))

## ----Multiplication and Permutation 1, echo=TRUE------------------------------
einsum::einsum('ij,ij->ji', arrC, arrC)
DelayedTensor::einsum('ij,ij->ji', darrC, darrC)

## ----Multiplication and Permutation 2, echo=TRUE------------------------------
einsum::einsum('ijk,ijk->jki', arrE, arrE)
DelayedTensor::einsum('ijk,ijk->jki', darrE, darrE)

## ----Summation and Permutation, echo=TRUE-------------------------------------
einsum::einsum('ijk->ki', arrE)
DelayedTensor::einsum('ijk->ki', darrE)

## ----Multiplication, Summation, and Permutation, echo=TRUE--------------------
einsum::einsum('i,ij,ijk,ijk,ji->jki',
    arrA, arrC, arrE, arrE, t(arrC))
DelayedTensor::einsum('i,ij,ijk,ijk,ji->jki',
    darrA, darrC, darrE, darrE, t(darrC))

## ----Kronecker Function, echo=TRUE--------------------------------------------
darr1 <- DelayedArray(array(1:6, dim=c(2,3)))
darr2 <- DelayedArray(array(20:1, dim=c(4,5)))

mykronecker <- function(darr1, darr2){
    stopifnot((length(dim(darr1)) == 2) && (length(dim(darr2)) == 2))
    # Outer Product
    tmpdarr <- DelayedTensor::einsum('ij,kl->ikjl', darr1, darr2)
    # Reshape
    DelayedTensor::unfold(tmpdarr, row_idx=c(2,1), col_idx=c(4,3))
}

identical(as.array(DelayedTensor::kronecker(darr1, darr2)),
    as.array(mykronecker(darr1, darr2)))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

