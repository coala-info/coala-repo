# Code example from 'BumpyMatrix' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)
library(BiocStyle)
set.seed(0)

## -----------------------------------------------------------------------------
library(S4Vectors)
df <- DataFrame(
    x=rnorm(10000), y=rnorm(10000), 
    gene=paste0("GENE_", sample(100, 10000, replace=TRUE)),
    cell=paste0("CELL_", sample(20, 10000, replace=TRUE))
)
df 

## -----------------------------------------------------------------------------
library(BumpyMatrix)
mat <- splitAsBumpyMatrix(df[,c("x", "y")], row=df$gene, column=df$cell)
mat
mat[1,1][[1]]

## -----------------------------------------------------------------------------
chosen <- df[1:100,]
smat <- splitAsBumpyMatrix(chosen[,c("x", "y")], row=chosen$gene, 
    column=chosen$cell, sparse=TRUE)
smat

## -----------------------------------------------------------------------------
dim(mat)
dimnames(mat)
rbind(mat, mat)
cbind(mat, mat)
t(mat)

## -----------------------------------------------------------------------------
mat[c("GENE_2", "GENE_20"),]
mat[,1:5]
mat["GENE_10",]

## -----------------------------------------------------------------------------
out.x <- mat[,,"x"]
out.x
out.x[,1]

## -----------------------------------------------------------------------------
pos <- out.x > 0
pos[,1]
shift <- 10 * out.x + 1
shift[,1]
out.y <- mat[,,"y"]
greater <- out.x < out.y
greater[,1]
diff <- out.y - out.x
diff[,1]

## -----------------------------------------------------------------------------
i <- mat[,,'x'] > 0 & mat[,,'y'] > 0
i
i[,1]
sub <- mat[i]
sub
sub[,1]

## -----------------------------------------------------------------------------
mat[,,'x']
mat[,,'x',drop=FALSE]

## -----------------------------------------------------------------------------
mat[1,1,'x']
mat[1,1,'x',.dropk=FALSE]
mat[1,1,'x',drop=FALSE]
mat[1,1,'x',.dropk=TRUE,drop=FALSE]

## -----------------------------------------------------------------------------
copy <- mat
copy[,,'x'] <- copy[,,'x'] * 20
copy[,1]

## -----------------------------------------------------------------------------
mean(out.x)[1:5,1:5] # matrix
var(out.x)[1:5,1:5] # matrix

## -----------------------------------------------------------------------------
quantile(out.x)[1:5,1:5,]
range(out.x)[1:5,1:5,]

## -----------------------------------------------------------------------------
pmax(out.x, out.y) 

## -----------------------------------------------------------------------------
sessionInfo()

