# Code example from 'metapone' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(metapone)

## ----example input------------------------------------------------------------
data(pos)
head(pos)

## ----example input second matrix----------------------------------------------
data(neg)
head(neg)

## ----example load database----------------------------------------------------
data(hmdbCompMZ)
head(hmdbCompMZ)

## ----example load pathway-----------------------------------------------------
data(pa)
head(pa)

## ----example adduct ions------------------------------------------------------
pos.adductlist = c("M+H", "M+NH4", "M+Na", "M+ACN+H", "M+ACN+Na", "M+2ACN+H", "2M+H", "2M+Na", "2M+ACN+H")
neg.adductlist = c("M-H", "M-2H", "M-2H+Na", "M-2H+K", "M-2H+NH4", "M-H2O-H", "M-H+Cl", "M+Cl", "M+2Cl")

## ----example analysis, warning=FALSE------------------------------------------
dat <- list(pos, neg)
type <- list("pos", "neg")
# permutation test
r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=200,fractional.count.power=0.5, max.match.count=10, use.fgsea = FALSE)

# GSEA type testing based on metabolites
#r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=100,fractional.count.power=0.5, max.match.count=10, use.fgsea = TRUE, use.meta = TRUE)

# GSEA type testing based on features
#r<-metapone(dat, type, pa, hmdbCompMZ=hmdbCompMZ, pos.adductlist=pos.adductlist, neg.adductlist=neg.adductlist, p.threshold=0.05,n.permu=100,fractional.count.power=0.5, max.match.count=10, use.fgsea = TRUE, use.meta = FALSE)

hist(ptable(r)[,1])

## ----example continued--------------------------------------------------------
selection<-which(ptable(r)[,1]<0.025)
ptable(r)[selection,]

## ----example continued 2------------------------------------------------------
ftable(r)[which(ptable(r)[,1]<0.025 & ptable(r)[,2]>=2)]

## ----example visulization, warning=FALSE--------------------------------------
bbplot1d(r@test.result, 0.025)
bbplot2d(r@test.result, 0.025)

