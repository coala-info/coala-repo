# Code example from 'IntramiRExploreR_vignettes' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# 
#  source("https://bioconductor.org/biocLite.R")
#  biocLite("IntramiRExploreR")
# 

## ----eval=TRUE----------------------------------------------------------------
library("IntramiRExploreR")

## ----eval=TRUE----------------------------------------------------------------
miR="dme-miR-12"
a<-miRTargets_Stat(miR,method=c("Both"),Platform=c("Affy1"),Text=FALSE)
a[1:4,1:5]

## ----eval=TRUE----------------------------------------------------------------
gene ="Ank2"
a<-genes_Stat(gene,geneIDType="GeneSymbol", method=c("Both"),Platform=c("Affy1"))
a[1:4,1:5]

## ----eval=TRUE----------------------------------------------------------------
miR=c("dme-miR-12","dme-miR-283")
a<-Visualisation(miR,mRNA_type=c("GeneSymbol"),method=c("Both"),platform=c("Affy1"),
                visualisation=c("console"),thresh=10)
a[1:10,1:5]

## ----eval=TRUE----------------------------------------------------------------
mRNA="Syb"
a<-Gene_Visualisation(mRNA,mRNA_type=c("GeneSymbol"),method=c("Pearson"),
            platform=c("Affy1"),visualisation= "console")
a[1:10,1:5]

## ----eval=FALSE---------------------------------------------------------------
# miR="dme-miR-12"
# a<-Visualisation(miR,mRNA_type=c("GeneSymbol"),method=c("Both"),platform=c("Affy1"),thresh=100,
#             visualisation="console")
# genes<-a$Target_GeneSymbol
# GetGOS_ALL(genes,GO=c("topGO"),term=c("GO_BP"),path="C://",filename="test")

