# Code example from 'prostateCancerVarambally' vignette. See references/ for full tutorial.

### R code from vignette source 'prostateCancerVarambally.Rnw'

###################################################
### code chunk number 1: prostateCancerVarambally.Rnw:17-18 (eval = FALSE)
###################################################
## library(GEOquery)


###################################################
### code chunk number 2: prostateCancerVarambally.Rnw:24-26 (eval = FALSE)
###################################################
## geoData <- getGEO("GSE3325")[[1]]
## geoData


###################################################
### code chunk number 3: prostateCancerVarambally.Rnw:31-44 (eval = FALSE)
###################################################
## pData(geoData) <- pData(geoData)[,c("geo_accession","title","description")]
## Sample_Group <- NULL
## 
## Sample_Group[grep("Benign", pData(geoData)$title)] <- "Benign"
## 
## Sample_Group[grep("prostate cancer",pData(geoData)$title)] <- "Tumour"
## 
## Sample_Group[grep("Metastatic", pData(geoData)$title)] <- "Metastatic"
## pData(geoData)$Sample_Group <- factor(Sample_Group,levels=c("Benign","Tumour","Metastatic"))
## 
## colnames(fData(geoData))[which(colnames(fData(geoData)) == "Gene Symbol")] <- "Symbol"
## varambally <- geoData
## save(varambally, file="data/varambally.rda",compress="xz")


