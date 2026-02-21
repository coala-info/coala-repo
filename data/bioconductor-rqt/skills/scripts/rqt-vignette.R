# Code example from 'rqt-vignette' vignette. See references/ for full tutorial.

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# devtools::install_github("izhbannikov/rqt", buildVignette=TRUE)

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header=TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pca", out.type = "D")
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pca", out.type = "C")
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------

library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
res <- geneTest(obj, method="pls", out.type = "C")
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------

library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header=TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj <- rqt(phenotype=pheno, genotype=geno.obj)
# Not yet supported, sorry!
#res <- geneTest(obj, method="pls", out.type = "D", scale = TRUE)
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------

library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.bin1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
covars <- read.table(system.file("extdata/test.cova1.dat",package="rqt"), 
    header=TRUE)
obj <- rqt(phenotype=pheno, genotype=geno.obj, covariates = covars)
res <- geneTest(obj, method="pca", out.type = "D")
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------

library(rqt)

data <- data.matrix(read.table(system.file("extdata/test.cont1.dat",
                                           package="rqt"), header = TRUE))
pheno <- data[,1]
geno <- data[, 2:dim(data)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
covars <- read.table(system.file("extdata/test.cova1.dat",package="rqt"), 
    header=TRUE)
obj <- rqt(phenotype=pheno, genotype=geno.obj, covariates = covars)
res <- geneTest(obj, method="pca", out.type = "C")
print(res)

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(rqt)

data1 <- data.matrix(read.table(system.file("extdata/phengen2.dat",
                                            package="rqt"), skip=1))
pheno <- data1[,1]
geno <- data1[, 2:dim(data1)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj1 <- rqt(phenotype=pheno, genotype=geno.obj)

data2 <- data.matrix(read.table(system.file("extdata/phengen3.dat",
                                            package="rqt"), skip=1))
pheno <- data2[,1]
geno <- data2[, 2:dim(data2)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj2 <- rqt(phenotype=pheno, genotype=geno.obj)

data3 <- data.matrix(read.table(system.file("extdata/phengen.dat",
                                            package="rqt"), skip=1))
pheno <- data3[,1]
geno <- data3[, 2:dim(data3)[2]]
colnames(geno) <- paste(seq(1, dim(geno)[2]))
geno.obj <- SummarizedExperiment(geno)
obj3 <- rqt(phenotype=pheno, genotype=geno.obj)

res.meta <- geneTestMeta(list(obj1, obj2, obj3))
print(res.meta)

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

