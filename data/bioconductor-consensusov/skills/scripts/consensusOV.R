# Code example from 'consensusOV' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache=TRUE)

## ----load_pkgs, message=FALSE-------------------------------------------------
library(consensusOV)
library(Biobase)
library(genefu)

## ----load_data, message=FALSE-------------------------------------------------
data(GSE14764.eset)
dim(GSE14764.eset)
GSE14764.expression.matrix <- exprs(GSE14764.eset)
GSE14764.expression.matrix[1:5,1:5]
GSE14764.entrez.ids <- fData(GSE14764.eset)$EntrezGene.ID
head(GSE14764.entrez.ids)

## ----subtyping----------------------------------------------------------------
bentink.subtypes <- get.subtypes(GSE14764.eset, method = "Bentink")
bentink.subtypes$Bentink.subtypes
konecny.subtypes <- get.subtypes(GSE14764.eset, method = "Konecny")
konecny.subtypes$Konecny.subtypes
helland.subtypes <- get.subtypes(GSE14764.eset, method = "Helland")
helland.subtypes$Helland.subtypes

## ----subtyping2, results="hide"-----------------------------------------------

# to align with the Verhaak subtypes, we need to remove the "geneid." in the rownames
temp_eset <- GSE14764.eset
rownames(temp_eset) <- gsub("geneid.", "", rownames(temp_eset))

verhaak.subtypes <- get.subtypes(temp_eset, method = "Verhaak")

## ----subtyping3---------------------------------------------------------------
verhaak.subtypes$Verhaak.subtypes
consensus.subtypes <- get.subtypes(GSE14764.eset, method = "consensusOV")
consensus.subtypes$consensusOV.subtypes

## ----alternative_subtyping----------------------------------------------------
## Alternatively, e.g.
data(sigOvcAngiogenic)
bentink.subtypes <- get.subtypes(GSE14764.expression.matrix, GSE14764.entrez.ids, method = "Bentink")

## ----subtyping_ex_2-----------------------------------------------------------
bentink.subtypes <- get.bentink.subtypes(GSE14764.expression.matrix, GSE14764.entrez.ids)

## ----verhaak_helland, fig.height = 8, fig.width = 8---------------------------
vest <- verhaak.subtypes$gsva.out
vest <- vest[,c("IMR", "DIF", "PRO", "MES")]
hest <- helland.subtypes$subtype.scores
hest <- hest[, c("C2", "C4", "C5", "C1")]
dat <- data.frame(
	as.vector(vest), 
	rep(colnames(vest), each=nrow(vest)),
	as.vector(hest), 
	rep(colnames(hest), each=nrow(hest)))
colnames(dat) <- c("Verhaak", "vsc", "Helland", "hsc")
## plot
library(ggplot2)
ggplot(dat, aes(Verhaak, Helland)) + geom_point() + facet_wrap(vsc~hsc, nrow = 2, ncol = 2)

## ----konecny_helland, fig.height = 8, fig.width = 8---------------------------
kost <- konecny.subtypes$spearman.cc.vals
hest <- helland.subtypes$subtype.scores
hest <- hest[, c("C2", "C4", "C5", "C1")]
dat <- data.frame(
	as.vector(kost), 
	rep(colnames(kost), each=nrow(kost)),
	as.vector(hest), 
	rep(colnames(hest), each=nrow(hest)))
colnames(dat) <- c("Konecny", "ksc", "Helland", "hsc")
## plot
ggplot(dat, aes(Konecny, Helland)) + geom_point() + facet_wrap(ksc~hsc, nrow = 2, ncol = 2)

