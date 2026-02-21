# Code example from 'calm_intro' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("calm")

## ----echo=TRUE----------------------------------------------------------------
library(calm)
data("pso")
dim(pso)
head(pso)
summary(pso$len_gene)
hist(pso$len_gene, main="")

## ----echo=TRUE----------------------------------------------------------------
# number of genes with matching microarray data
sum(!is.na(pso$tval_mic))

## ----echo=TRUE----------------------------------------------------------------
# indicator for RNA-seq genes without matching microarray data
ind.nm <- is.na(pso$tval_mic)
x <- pso$len_gene[ind.nm]
# normalize covariate
x <- rank(x)/length(x)
y <- pso$zval[ind.nm]
names(y) <- row.names(pso)[ind.nm]

fit.nm <- CLfdr(x=x, y=y)
fit.nm$fdr[1:5]

## ----echo=TRUE----------------------------------------------------------------
# indicator for RNA-seq genes with matching microarray data
ind.m <- !ind.nm
# normalize covariate
m <- sum(ind.m)
x1 <- rank(pso$tval_mic[ind.m])/m
x2 <- rank(pso$len_gene[ind.m])/m

xmat <- cbind(x1, x2)
colnames(xmat) <- c("tval", "len")
y <- pso$zval[ind.m]
names(y) <- row.names(pso)[ind.m]

fit.m <- CLfdr(x=xmat, y=y, bw=c(0.028, 0.246, 0.253))

## ----echo=TRUE----------------------------------------------------------------
fdr <- c(fit.m$fdr, fit.nm$fdr)
FDR <- EstFDR(fdr)
o <- order(FDR)
FDR[o][1:5]
sum(FDR<0.01)

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

