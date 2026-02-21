# Code example from 'prostateCancerGrasso' vignette. See references/ for full tutorial.

### R code from vignette source 'prostateCancerGrasso.Rnw'

###################################################
### code chunk number 1: prostateCancerGrasso.Rnw:17-18 (eval = FALSE)
###################################################
## library(GEOquery)


###################################################
### code chunk number 2: prostateCancerGrasso.Rnw:24-26 (eval = FALSE)
###################################################
## geoData <- getGEO("GSE35988")
## geoData


###################################################
### code chunk number 3: prostateCancerGrasso.Rnw:31-52 (eval = FALSE)
###################################################
## 
## pd <- rbind(pData(geoData[[1]]),pData(geoData[[2]]))
## 
## groups = NULL
## groups[grep('benign', pd$characteristics_ch2, perl=TRUE)] = "Benign"
## groups[grep('localized', pd$characteristics_ch2, perl=TRUE)] = "HormomeDependant"
## groups[grep('metastatic', pd$characteristics_ch2, perl=TRUE)] = "CastrateResistant"
## 
## pd <- data.frame(geo_accession=pd$geo_accession, Sample.Name= pd$title,Group=groups)
## 
## fd <- fData(geoData[[1]])[,c("ID","GENE","GENE_SYMBOL")]
## 
## exp <- cbind(exprs(geoData[[1]]), exprs(geoData[[2]]))
## 
## geoData <- geoData[[1]]
## exprs(geoData) <- exp
## pData(geoData) <- pd
## fData(geoData) <- fd
## 
## grasso <- geoData
## save(grasso, file="data/grasso.rda",compress="xz")


