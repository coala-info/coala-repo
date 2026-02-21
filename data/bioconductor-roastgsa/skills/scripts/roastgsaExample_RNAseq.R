# Code example from 'roastgsaExample_RNAseq' vignette. See references/ for full tutorial.

## ----message = FALSE, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("roastgsa")
# 

## ----load-packages, message=FALSE, warning=FALSE------------------------------
library( roastgsa )

## ----message = FALSE----------------------------------------------------------
#library(GSEABenchmarkeR)
#tcga <- loadEData("tcga", nr.datasets=1,cache = TRUE)
#ysel <- assays(tcga[[1]])$expr
#fd <-  rowData(tcga[[1]])
#pd <- colData(tcga[[1]])
data(fd.tcga)
data(pd.tcga)
data(expr.tcga)

fd <- fd.tcga
ysel <- expr.tcga
pd <- pd.tcga
N  <- ncol(ysel)

head(pd)
cnames <- c("BLOCK","GROUP")
covar <- data.frame(pd[,cnames,drop=FALSE])
covar$GROUP <- as.factor(covar$GROUP)
colnames(covar) <- cnames
print(table(covar$GROUP))

## ----message = FALSE----------------------------------------------------------
library(DESeq2)
dds1 <- DESeqDataSetFromMatrix(countData=ysel,colData=pd,
    design= ~ BLOCK + GROUP)
dds1 <- estimateSizeFactors(dds1)
ynorm <- assays(vst(dds1))[[1]]
colnames(ynorm) <- rownames(covar) <- paste0("s",1:ncol(ynorm))

## ----message = FALSE----------------------------------------------------------
threshLR <- 10
dim(ysel)
min(apply(ysel,1,mean))

## ----message = FALSE----------------------------------------------------------
data(hallmarks.hs)
head(names(hallmarks.hs))

## ----message = FALSE----------------------------------------------------------
rownames(ynorm) <-fd[rownames(ynorm),1]


## ----message = FALSE----------------------------------------------------------
form <- as.formula(paste0("~ ", paste0(cnames, collapse = "+")))
design <- model.matrix(form , data = covar)
terms <- colnames(design)
contrast <- rep(0, length(terms))
contrast[length(colnames(design))] <- 1

## ----message = FALSE----------------------------------------------------------
fit.maxmean <- roastgsa(ynorm, form = form, covar = covar,
    contrast = contrast, index = hallmarks.hs, nrot = 500,
    mccores = 1, set.statistic = "maxmean",
    self.contained = FALSE, executation.info = FALSE)
f1 <- fit.maxmean$res
rownames(f1) <- gsub("HALLMARK_","",rownames(f1))
head(f1)

fit.mean <- roastgsa(ynorm, form = form, covar = covar,
    contrast = contrast, index = hallmarks.hs, nrot = 500,
    mccores = 1, set.statistic = "mean",
    self.contained = FALSE, executation.info = FALSE)
f2 <- fit.mean$res
rownames(f2) <- gsub("HALLMARK_","",rownames(f2))
head(f2)

## ----fig.height=7, fig.width=7, message = FALSE-------------------------------
hm1 <- heatmaprgsa_hm(fit.maxmean, ynorm, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)

## ----fig.height=7, fig.width=7, message = FALSE-------------------------------
hm2 <- heatmaprgsa_hm(fit.mean, ynorm, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)

## ----message = FALSE----------------------------------------------------------
sessionInfo()

