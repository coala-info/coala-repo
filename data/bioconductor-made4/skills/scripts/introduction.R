# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
    BiocStyle::markdown(css.files = c('custom.css'))

## -----------------------------------------------------------------------------
library(ade4)
library(made4)
library(scatterplot3d)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("made4")

## -----------------------------------------------------------------------------
 library(made4)
 library(ade4)
 data(khan)

## -----------------------------------------------------------------------------
names(khan)
k.data<-khan$train
k.class<-khan$train.classes

## ----overview.extra, eval=FALSE-----------------------------------------------
# overview(k.data)

## ----overviewKhan,fig.width=7,fig.height=6, fig.cap="\\label{fig:fig1}Overview of Khan data."----

overview(k.data, labels=k.class)

## ----overviewKhan2,fig.width=7,fig.height=6, fig.cap="\\label{fig:fig2}Overview of Khan data."----

overview(k.data, classvec=k.class, labels=k.class)

## -----------------------------------------------------------------------------
k.coa<- ord(k.data, type="coa")

## ----output.coa---------------------------------------------------------------
names(k.coa)
summary(k.coa$ord)

## ----see.classes--------------------------------------------------------------
k.class

## ----plotcoa------------------------------------------------------------------
plot(k.coa, classvec=k.class, genecol="grey3")

## ----plotgenesCOA,eval=FALSE--------------------------------------------------
# plotgenes(k.coa)

## ----plotarrays---------------------------------------------------------------
plotarrays(k.coa, arraylabels=k.class)

## ----plotarays2---------------------------------------------------------------
k.coa2<-ord(k.data, classvec=k.class)
plot(k.coa2)

## ----plotgenes----------------------------------------------------------------
plotgenes(k.coa, n=5, col="red")

## ----plotgenescmd-------------------------------------------------------------
gene.symbs<- khan$annotation$Symbol 
gene.symbs[1:4]

## ----plotgenesSym-------------------------------------------------------------
plotgenes(k.coa, n=10, col="red", genelabels=gene.symbs)

## ----topgenes, eval=FALSE-----------------------------------------------------
# topgenes(k.coa, axis = 1, n=5)

## ----topgenes2----------------------------------------------------------------
topgenes(k.coa, labels=gene.symbs, end="neg") 

## ----do3d---------------------------------------------------------------------
do3d(k.coa$ord$co, classvec=k.class, cex.symbols=3)

## ----eval=FALSE---------------------------------------------------------------
# html3D(k.coa$ord$co, k.class, writehtml=TRUE)

## ----html3D, echo=FALSE, fig.cap="Output from html3D"-------------------------
knitr::include_graphics("html3D.png")

## ----bga----------------------------------------------------------------------
k.bga<-bga(k.data, type="coa", classvec=k.class)

## ----BGAplot------------------------------------------------------------------
plot(k.bga, genelabels=gene.symbs) # Use the gene symbols earlier

## ----between.graph, fig.width=6, fig.height=4---------------------------------
between.graph(k.bga, ax=1)  # Show the separation on the first axes(ax)

## ----CIA----------------------------------------------------------------------
# Example data are "G1_Ross_1375.txt" and "G5_Affy_1517.txt"
data(NCI60)
coin <- cia(NCI60$Ross, NCI60$Affy)
names(coin)
coin$coinertia$RV

## ----CIAplot------------------------------------------------------------------
plot(coin, classvec=NCI60$classes[,2], clab=0, cpoint=3)

