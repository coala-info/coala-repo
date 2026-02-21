# Code example from 'nondetects' vignette. See references/ for full tutorial.

## ----echo=TRUE----------------------------------------------------------------
library(HTqPCR)
library(mvtnorm)
library(nondetects)
data(oncogene2013)

## ----echo=TRUE----------------------------------------------------------------
normCt <- normalizeCtData(oncogene2013, norm = "deltaCt", deltaCt.genes = "Becn1")

## ----echo=TRUE----------------------------------------------------------------
conds <- paste(pData(normCt)$sampleType,pData(normCt)$treatment,sep=":")
resids <- matrix(nrow=nrow(normCt), ncol=ncol(normCt))
for(i in 1:nrow(normCt)){
  for(j in 1:ncol(normCt)){
    ind <- which(conds==conds[j])
    resids[i,j] <- exprs(normCt)[i,j]-mean(exprs(normCt)[i,ind])
  }
}

## ----echo=TRUE----------------------------------------------------------------
iND <- which(featureCategory(normCt)=="Undetermined", arr.ind=TRUE)
iD <- which(featureCategory(normCt)!="Undetermined", arr.ind=TRUE)
boxes <- list("observed"=-resids[iD], "non-detect"=-resids[iND])

## ----echo=TRUE----------------------------------------------------------------
boxplot(boxes, main="",ylim=c(-5,5),
        ylab=expression(paste("-",Delta,"Ct residuals",sep="")))

## ----echo=TRUE----------------------------------------------------------------
oncogene2013_1 <- qpcrImpute(oncogene2013, 
groupVars=c("sampleType","treatment"), outform = c("Multy"), 
vary_fit=FALSE, vary_model=TRUE, add_noise=TRUE, numsam=2,
linkglm = c("logit"))

## ----echo=TRUE----------------------------------------------------------------
normCt <- normalizeCtData(oncogene2013_1[[1]], norm = "deltaCt", deltaCt.genes = "Becn1")

## ----echo=TRUE----------------------------------------------------------------
normCt <- normCt[-which(featureNames(normCt)=="Becn1"),]

## ----echo=TRUE----------------------------------------------------------------
conds <- paste(pData(normCt)$sampleType,
               pData(normCt)$treatment,sep=":")
resids <- matrix(nrow=nrow(normCt), ncol=ncol(normCt))
for(i in 1:nrow(normCt)){
  for(j in 1:ncol(normCt)){
    ind <- which(conds==conds[j])
    resids[i,j] <- exprs(normCt)[i,j]-mean(exprs(normCt)[i,ind])
  }
}

## ----echo=TRUE----------------------------------------------------------------
iI <- which(featureCategory(normCt)=="Imputed", arr.ind=TRUE)
iD <- which(featureCategory(normCt)!="Imputed", arr.ind=TRUE)
boxes <- list("observed"=-resids[iD], "imputed"=-resids[iI])

## ----echo=TRUE----------------------------------------------------------------
boxplot(boxes, main="",ylim=c(-5,5),
        ylab=expression(paste("-",Delta,"Ct residuals",sep="")))

## ----echo=TRUE----------------------------------------------------------------
library(nondetects)
data(sagmb2011)

## ----echo=TRUE----------------------------------------------------------------
library(nondetects)
data(nature2008)

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

