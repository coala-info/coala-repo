# Code example from 'GISPA_manual' vignette. See references/ for full tutorial.

## ---- message=F, warning=F, eval=F---------------------------------------
#  install.packages( c("changepoint", "data.table", "genefilter", "graphics", "HH", "knitr", "latticeExtra", "lattice", "plyr", "scatterplot3d", "stats", "Biobase", "GSEABase") )

## ---- message=F, warning=F-----------------------------------------------
library("GISPA")
load("data.rda")
exprset
varset
cnvset

## ---- message=F, warning=F-----------------------------------------------
results <- GISPA(feature=2, f.sets=c(exprset,cnvset), g.set=NULL,
                 ref.samp.idx=1, comp.samp.idx=c(2,3), 
                 f.profiles=c("up", "up"), 
                 cpt.data="var", cpt.method="BinSeg", cpt.max=5)

## ---- message=F, warning=F-----------------------------------------------
cptSlopeplot(gispa.output=results,feature=2,type=c("EXP","VAR"))

## ---- message=F, warning=F, fig.width = 7, fig.height = 6----------------
stackedBarplot(gispa.output=results,feature=2,cpt=1,type=c("EXP","CNV"),
               input.cex=1.5,input.cex.lab=1.5,input.gap=0.5,
               samp.col=c("red", "green", "blue"),
               strip.col=c("yellow", "bisque"))

## ---- message=F, warning=F, fig.width = 6, fig.height = 6----------------
propBarplot(gispa.output=results,feature=2,cpt=1,input.cex=0.5,input.cex.lab=0.5,ft.col=c("grey0", "grey60"),strip.col="yellow")

## ---- message=F, warning=F-----------------------------------------------
results <- GISPA(feature=1, f.sets=c(exprset), g.set=NULL,
                 ref.samp.idx=1, comp.samp.idx=c(2,3), 
                 f.profiles=c("up"),
                 cpt.data="var", cpt.method="BinSeg", cpt.max=5)
head(results)

## ---- message=F, warning=F, eval=F---------------------------------------
#  results <- GISPA(feature=3, f.sets=c(exprset,cnvset,varset), g.set=NULL,
#                   ref.samp.idx=1, comp.samp.idx=c(2,3),
#                   f.profiles=c("down", "down", "down"),
#                   cpt.data="var", cpt.method="BinSeg", cpt.max=5)
#  head(results)

