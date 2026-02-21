# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----config, include=FALSE----------------------------------------------------
library(knitr)
opts_chunk$set(dev = "jpeg", fig.height = 7.25, dpi = 72, fig.retina = 1)

## ----setup, warning=FALSE, message=FALSE, results="hide"----------------------
library(mimager)
library(affydata)
data("Dilution")

## ----default-image-n1, warning=FALSE, message=FALSE, fig.small=TRUE, fig.height=4----
mimage(Dilution, select = 1)

## ----default-image-n4---------------------------------------------------------
mimage(Dilution)

## ----default-image-1row, fig.wide=TRUE, fig.height=2.5------------------------
mimage(Dilution, select = c("10A", "20A", "10B", "20B"), nrow = 1)

## ----dilution-plm, message=FALSE----------------------------------------------
library(affyPLM)
DilutionPLM <- fitPLM(Dilution)

mimage(DilutionPLM)

## ----affyplm-signed-residuals-------------------------------------------------
# use a divergent color palette for RLEs
div.colors <- scales::brewer_pal(palette = "RdBu")(9)

mimage(Dilution, transform = arle, legend.label = "RLE", colors = div.colors)

## ----dilution-array-----------------------------------------------------------
DilutionArray <- marray(Dilution)
dim(DilutionArray)

## ----dilution-arank-----------------------------------------------------------
DilutionRank <- arank(DilutionArray)
dim(DilutionRank)

