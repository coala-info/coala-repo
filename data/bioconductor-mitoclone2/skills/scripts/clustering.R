# Code example from 'clustering' vignette. See references/ for full tutorial.

## ----results='hide', message=FALSE, warning=FALSE-----------------------------
library(mitoClone2)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy.opts=list(width.cutoff=70),
  tidy=TRUE
)

## ----setup--------------------------------------------------------------------
load(system.file("data/M_P1.RData",package = "mitoClone2"))
load(system.file("data/N_P1.RData",package = "mitoClone2"))
P1 <- mutationCallsFromMatrix(as.matrix(M_P1), as.matrix(N_P1))

## ----runTreebuilding, message=FALSE-------------------------------------------
## this next step takes approx 4.1 minutes to run
tmpd <- tempdir()
dir.create(paste0(tmpd,'/p1'))
P1 <- varCluster(P1, tempfolder=paste0(tmpd,'/p1'),method='SCITE')

## ----clusterClonesP1, fig.width=8,fig.height=6--------------------------------
P1 <- clusterMetaclones(P1, min.lik = 1)

## ----plotClonesP1, fig.width=8,fig.height=6-----------------------------------
plotClones(P1)

## ----getmut2clone, fig.width=8,fig.height=6-----------------------------------
m2c <- mitoClone2:::getMut2Clone(P1)
print(m2c)

##To e.g. treat the mt:2537G>A and mt:14462:G>A mutations as a subclone
##distinct from CEBPA, we can assign them a new clonal identity
m2c[c("X2537GA","X14462GA")] <- as.integer(6)

P1.new <- mitoClone2:::overwriteMetaclones(P1, m2c)
plotClones(P1.new)

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

