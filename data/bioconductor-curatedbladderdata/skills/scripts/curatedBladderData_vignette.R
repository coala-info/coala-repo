# Code example from 'curatedBladderData_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'curatedBladderData_vignette.rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: preliminaries
###################################################
library(sva)


###################################################
### code chunk number 3: example1
###################################################
library(curatedBladderData)


###################################################
### code chunk number 4: example1tcgastep2
###################################################
data(package="curatedBladderData")


###################################################
### code chunk number 5: example1
###################################################
data(GSE89_eset)
GSE89_eset


###################################################
### code chunk number 6: example2loadstep1
###################################################
source(system.file("extdata", 
"patientselection_all.config",package="curatedBladderData"))
ls()


###################################################
### code chunk number 7: showls
###################################################
sapply(ls(), get)


###################################################
### code chunk number 8: example2loadstep2
###################################################
source(system.file("extdata", "createEsetList.R", package =
"curatedBladderData"))


###################################################
### code chunk number 9: example2loadstep3
###################################################
names(esets)


###################################################
### code chunk number 10: expand
###################################################
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

X <- GSE89_eset[head(grep("///", featureNames(GSE89_eset))),]
exprs(X)[,1:3]
exprs(expandProbesets(X))[,1:3]


###################################################
### code chunk number 11: heatmap
###################################################
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


###################################################
### code chunk number 12: esetToTableFuns
###################################################
source(system.file("extdata", "summarizeEsets.R", package =
    "curatedBladderData"))


###################################################
### code chunk number 13: esettable
###################################################
summary.table <- t(sapply(esets, getEsetData, possible.stages=c("superficial",
"invasive"), possible.histological_types=c("tcc","cis", "squamous")))

rownames(summary.table) <- sub("_eset", "", rownames(summary.table))


###################################################
### code chunk number 14: writeesettable
###################################################
(myfile <- tempfile())
write.table(summary.table, file=myfile, row.names=FALSE, quote=TRUE, sep=",")


###################################################
### code chunk number 15: xtable
###################################################
library(xtable)
print(xtable(summary.table[, c(2, 3, 4, 5, 7)], 
             caption="Datasets provided by curatedBladderData.",
             table.placement="p", caption.placement="bottom"),
      floating.environment='sidewaystable')


###################################################
### code chunk number 16: simplygetdata (eval = FALSE)
###################################################
## library(curatedBladderData)
## library(affy)
## data(GSE89_eset)
## write.csv(exprs(GSE89_eset), file="GSE89_eset_exprs.csv")
## write.csv(pData(GSE89_eset), file="GSE89_eset_clindata.csv")


###################################################
### code chunk number 17: simplyseveraldatasets (eval = FALSE)
###################################################
## data.to.fetch <- c("GSE89_eset", "GSE37317_eset")
## for (onedata in data.to.fetch){
##     print(paste("Fetching", onedata))
##     data(list=onedata)
##     write.csv(exprs(get(onedata)), file=paste(onedata, "_exprs.csv", sep=""))
##     write.csv(pData(get(onedata)), file=paste(onedata, "_clindata.csv", sep=""))
## }


###################################################
### code chunk number 18: sessioninfo
###################################################
toLatex(sessionInfo())


