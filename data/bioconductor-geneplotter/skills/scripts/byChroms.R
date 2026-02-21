# Code example from 'byChroms' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE)

## ----loaddata, message=F,warning=F--------------------------------------------
library("annotate")
library("hu6800.db")
lens <- unlist(eapply(hu6800CHR, length))
table(lens)
wh2 = mget(names(lens)[lens==2], env = hu6800CHR)
wh2[1]

## ----fixdata------------------------------------------------------------------
chrs2 <- unlist(eapply(hu6800CHR, function(x) x[1]))
chrs2 <- factor(chrs2)
length(chrs2)
table(unlist(chrs2))

## ----strandloc----------------------------------------------------------------
strand <- as.list(hu6800CHRLOC)
splits <- split(strand, chrs2)
length(splits)
names(splits)

## ----chrloc-------------------------------------------------------------------
 newChrClass <- buildChromLocation("hu6800")

## ----cPlot, fig=TRUE----------------------------------------------------------
library(geneplotter)
## Reorder Chromosomes
newChrClass@chromLocs <- newChrClass@chromLocs[order(as.numeric(names(newChrClass@chromLocs)))]
newChrClass@chromInfo <- newChrClass@chromInfo[order(as.numeric(names(newChrClass@chromInfo)))]
cPlot(newChrClass,useChroms = as.character(c(names(splits),"X","Y","M")))

