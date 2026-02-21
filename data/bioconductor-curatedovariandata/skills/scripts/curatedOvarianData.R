# Code example from 'curatedOvarianData' vignette. See references/ for full tutorial.

## ----example1tcgastep1,include=TRUE,results="hide",message=FALSE,warning=FALSE----
library(curatedOvarianData)
library(sva)
library(logging)

## ----example1tcgastep2_list, eval=FALSE---------------------------------------
# data(package="curatedOvarianData")

## ----example1tcgastep2--------------------------------------------------------
data(TCGA_eset)
TCGA_eset

## ----example2loadstep1--------------------------------------------------------
source(system.file("extdata",
"patientselection.config",package="curatedOvarianData"))
ls()

## ----showls-------------------------------------------------------------------
#remove.samples and duplicates are too voluminous:
sapply(
    ls(),
    function(x) if(!x %in% c("remove.samples", "duplicates")) print(get(x))
)

## ----example2loadstep2--------------------------------------------------------
source(system.file("extdata", "createEsetList.R", package =
"curatedOvarianData"))

## ----example2loadstep3--------------------------------------------------------
names(esets)

## ----example3prepare----------------------------------------------------------
esets[[1]]$y
forestplot <- function(esets, y="y", probeset, formula=y~probeset,
mlab="Overall", rma.method="FE", at=NULL,xlab="Hazard Ratio",...) {
    require(metafor)
    esets <- esets[sapply(esets, function(x) probeset %in% featureNames(x))]
    coefs <- sapply(1:length(esets), function(i) {
        tmp   <- as(phenoData(esets[[i]]), "data.frame")
        tmp$y <- esets[[i]][[y]]
        tmp$probeset <- exprs(esets[[i]])[probeset,]

        summary(coxph(formula,data=tmp))$coefficients[1,c(1,3)]
    })

    res.rma <- metafor::rma(yi = coefs[1,], sei = coefs[2,],
        method=rma.method)

    if (is.null(at)) at <- log(c(0.25,1,4,20))
    forest.rma(res.rma, xlab=xlab, slab=gsub("_eset$","",names(esets)),
    atransf=exp, at=at, mlab=mlab,...)
    return(res.rma)
}

## ----example3plot, fig.width=8, fig.height=6----------------------------------
res <- forestplot(esets=esets,probeset="CXCL12",at=log(c(0.5,1,2,4)))

## ----filterdatasets-----------------------------------------------------------
idx.tumorstage <- sapply(esets, function(X)
    sum(!is.na(X$tumorstage)) > 0 & length(unique(X$tumorstage)) > 1)

idx.debulking <- sapply(esets, function(X)
    sum(X$debulking=="suboptimal",na.rm=TRUE)) > 0

## ----example4plot, fig.width=8, fig.height=6----------------------------------
res <- forestplot(esets=esets[idx.debulking & idx.tumorstage],
    probeset="CXCL12",formula=y~probeset+debulking+tumorstage,
    at=log(c(0.5,1,2,4)))

## ----example5plot, fig.width=8, fig.height=6----------------------------------
res <- forestplot(esets=esets,probeset="CXCR4",at=log(c(0.5,1,2,4)))

## ----combine2-----------------------------------------------------------------
combine2 <- function(X1, X2) {
    fids <- intersect(featureNames(X1), featureNames(X2))
    X1 <- X1[fids,]
    X2 <- X2[fids,]
    ExpressionSet(cbind(exprs(X1),exprs(X2)),
        AnnotatedDataFrame(rbind(as(phenoData(X1),"data.frame"),
                                 as(phenoData(X2),"data.frame")))
    )
}

## ----boxplot1, fig.width=8, fig.height=6--------------------------------------
data(E.MTAB.386_eset)
data(GSE30161_eset)
X <- combine2(E.MTAB.386_eset, GSE30161_eset)
boxplot(exprs(X))

## ----combat-------------------------------------------------------------------
mod <- model.matrix(~as.factor(tumorstage), data=X)
batch <- as.factor(grepl("DFCI",sampleNames(X)))
combat_edata <- ComBat(dat=exprs(X), batch=batch, mod=mod)

## ----boxplot2, fig.width=8, fig.height=6--------------------------------------
boxplot(combat_edata)

## ----expand-------------------------------------------------------------------
expandProbesets <- function (eset, sep = "///")
{
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    eset <- eset[order(sapply(x, length)), ]
    x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])
    idx <- unlist(sapply(1:length(x), function(i) rep(i, length(x[[i]]))))
    xx <- !duplicated(unlist(x))
    idx <- idx[xx]
    x <- unlist(x)[xx]
    eset <- eset[idx, ]
    featureNames(eset) <- x
    eset
}

X <- TCGA_eset[head(grep("///", featureNames(TCGA_eset))),]
exprs(X)[,1:3]
exprs(expandProbesets(X))[,1:3]

## ----featureData--------------------------------------------------------------
head(pData(featureData(GSE18520_eset)))

## ----annotationeg-------------------------------------------------------------
annotation(GSE18520_eset)

## ----loadallsamples, echo=FALSE, results='hide'-------------------------------
rm(list=ls())
source(system.file("extdata",
    "patientselection_all.config",package="curatedOvarianData"))
source(system.file("extdata", "createEsetList.R", package =
    "curatedOvarianData"))

## ----heatmap, echo=FALSE, fig.width=10, fig.height=8--------------------------
.esetsStats <- function(esets) {
    res <- lapply(varLabels(esets[[1]]), function(covar) unlist(sapply(esets,
        function(X) sum(!is.na(X[[covar]]))>0)))
    names(res) <- varLabels(esets[[1]])
    do.call(rbind, res)
}

df.r <- .esetsStats(esets)
M <- as.matrix(apply(df.r,c(1,2),ifelse,0,1))
colnames(M) <- gsub("_eset$", "", colnames(M))
# no need to show the sample ids
M <- M[-(1:2),]
heatmap(M[nrow(M):1,],scale="none",margins=c(8,10),Rowv=NA)

## ----esetToTableFuns----------------------------------------------------------
source(system.file("extdata", "summarizeEsets.R", package =
    "curatedOvarianData"))

## ----esettable, echo=FALSE----------------------------------------------------
summary.table <- t(sapply(esets, getEsetData))
rownames(summary.table) <- sub("_eset", "", rownames(summary.table))

## ----writeesettable-----------------------------------------------------------
(myfile <- tempfile())
write.table(summary.table, file=myfile, row.names=FALSE, quote=TRUE, sep=",")

## ----display_table, echo=FALSE------------------------------------------------
# Display a subset of the table for the R markdown document
knitr::kable(
    summary.table[, c(2, 3, 4, 5, 7)],
    caption="Datasets provided by curatedOvarianData. This is an abbreviated
    version of Table 1 of the manuscript; the full version is written by the
    write.table command above. Stage column is early/late/unknown, histology
    column is ser/clearcell/endo/mucinous/other/unknown."
)

## ----simplygetdata, eval=FALSE------------------------------------------------
# library(curatedOvarianData)
# data(GSE30161_eset)
# write.csv(exprs(GSE30161_eset), file="GSE30161_eset_exprs.csv")
# write.csv(pData(GSE30161_eset), file="GSE30161_eset_clindata.csv")

## ----simplyseveraldatasets, eval=FALSE----------------------------------------
# data.to.fetch <- c("GSE30161_eset", "E.MTAB.386_eset")
# for (onedata in data.to.fetch){
#     print(paste("Fetching", onedata))
#     data(list=onedata)
#     write.csv(exprs(get(onedata)), file=paste(onedata, "_exprs.csv", sep=""))
#     write.csv(pData(get(onedata)), file=paste(onedata, "_clindata.csv", sep=""))
# }

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

