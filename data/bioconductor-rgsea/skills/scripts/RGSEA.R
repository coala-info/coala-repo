# Code example from 'RGSEA' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----RGSEA-DOWNLOAD, message=FALSE, warning= FALSE-------------------------
library(GEOquery)
g4100 <- GDS2eSet(getGEO("GDS4100"))
g4102 <- GDS2eSet(getGEO("GDS4102"))

## ----RGSEA-transform-------------------------------------------------------
e4102<-exprs(g4102)
e4100<-exprs(g4100)

## ----RSGEA-data------------------------------------------------------------
e1<-e4102[,c(1,51)]
e2<-e4100[,c(1,2,23,24)]
colnames(e1)<-c("tumor", "normal")
colnames(e2)<-c("tumor","tumor","normal","normal")

## --------------------------------------------------------------------------
library(RGSEA)
data(e1)
data(e2)
RGSEAfix(e1,e2, queryclasses=colnames(e1), refclasses=colnames(e2), random=20000, 
featurenum=1000, iteration=100)->test

## --------------------------------------------------------------------------
test[[1]]

## --------------------------------------------------------------------------
RGSEApredict(test[[1]], colnames(e2))

## --------------------------------------------------------------------------
data(cmap)
test2<-RGSEAsd(cmap[,1],cmap[,2:6], queryclasses=colnames(cmap)[1], 

refclasses=colnames(cmap)[2:6], random=5000, sd=2, iteration=100)
test2[[1]]

