# Code example from 'ggtreeDendro' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE)
library(yulab.utils)                      

## -----------------------------------------------------------------------------
library(ggtree)
library(ggtreeDendro)
library(aplot)
scale_color_subtree <- ggtreeDendro::scale_color_subtree

## ----fig.width=16, fig.height=6-----------------------------------------------
d <- dist(USArrests)

hc <- hclust(d, "ave")
den <- as.dendrogram(hc)

p1 <- autoplot(hc) + geom_tiplab()
p2 <- autoplot(den)
plot_list(p1, p2, ncol=2)

## ----fig.width=8, fig.height=8------------------------------------------------
library("mdendro")
lnk <- linkage(d, digits = 1, method = "complete")
autoplot(lnk, layout = 'circular') + geom_tiplab() + 
  scale_color_subtree(4) + theme_tree()

## ----fig.width=16, height=6---------------------------------------------------
library(cluster)
x1 <- agnes(mtcars)
x2 <- diana(mtcars)

p1 <- autoplot(x1) + geom_tiplab()
p2 <- autoplot(x2) + geom_tiplab()
plot_list(p1, p2, ncol=2)

## ----fig.width=8, height=6----------------------------------------------------
library(pvclust)
data(Boston, package = "MASS")

set.seed(123)
result <- pvclust(Boston, method.dist="cor", method.hclust="average", nboot=1000, parallel=TRUE)
autoplot(result, label_edge=TRUE, pvrect = TRUE) + geom_tiplab()

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

