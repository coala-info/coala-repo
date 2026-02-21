# Code example from 'QuickStart' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    crop = NULL,
    comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("TDbasedUFE")

## ----setup--------------------------------------------------------------------
library(TDbasedUFE)

## -----------------------------------------------------------------------------
require(GenomicRanges)
require(rTensor)
library("readr")
library("tximport")
library("tximportData")
dir <- system.file("extdata", package="tximportData")
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
samples$condition <- factor(rep(c("A","B"),each=3))
rownames(samples) <- samples$run
samples[,c("pop","center","run","condition")]
files <- file.path(dir,"salmon", samples$run, "quant.sf.gz")
names(files) <- samples$run
tx2gene <- read_csv(file.path(dir, "tx2gene.gencode.v27.csv"))
txi <- tximport(files, type="salmon", tx2gene=tx2gene)

## -----------------------------------------------------------------------------
dim(txi$counts)

## -----------------------------------------------------------------------------
txi[seq_len(3)] <-
    lapply(txi[seq_len(3)],
    function(x){dim(x);x[seq_len(10000),]})

## -----------------------------------------------------------------------------
Z <- PrepareSummarizedExperimentTensor(matrix(samples$sample,c(3,2)),
    rownames(txi$abundance),array(txi$counts,c(dim(txi$counts)[1],3,2)))
dim(attr(Z,"value"))
HOSVD <- computeHosvd(Z)

## -----------------------------------------------------------------------------
input_all <- selectSingularValueVectorSmall(HOSVD,input_all= c(1,2)) #batch mode

## -----------------------------------------------------------------------------
index <- selectFeature(HOSVD,input_all)

## -----------------------------------------------------------------------------
head(tableFeatures(Z,index))

## -----------------------------------------------------------------------------
require(MOFAdata)
data("CLL_data")
data("CLL_covariates")
help(CLL_data)

## -----------------------------------------------------------------------------
Z <- PrepareSummarizedExperimentTensorSquare(
    sample=matrix(colnames(CLL_data$Drugs),1),
    feature=list(Drugs=rownames(CLL_data$Drugs),
    Methylation=rownames(CLL_data$Methylation),
    mRNA=rownames(CLL_data$mRNA),Mutations=rownames(CLL_data$Mutations)),
    value=convertSquare(CLL_data),sampleData=list(CLL_covariates[,1]))
HOSVD <- computeHosvdSqure(Z)

## -----------------------------------------------------------------------------
table(CLL_covariates[,1])
cond <- list(attr(Z,"sampleData")[[1]],attr(Z,"sampleData")[[1]],seq_len(4))

## -----------------------------------------------------------------------------
input_all <- selectSingularValueVectorLarge(HOSVD,cond,input_all=c(8,1))

## -----------------------------------------------------------------------------
index <- selectFeatureSquare(HOSVD,input_all,CLL_data,
    de=c(0.3,0.03,0.1,0.1),interact=FALSE) #for batch mode

## -----------------------------------------------------------------------------
for (id in seq_len(4)){print(head(tableFeaturesSquare(Z,index,id)))}

## -----------------------------------------------------------------------------
sessionInfo()

