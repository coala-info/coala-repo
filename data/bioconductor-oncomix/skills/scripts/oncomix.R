# Code example from 'oncomix' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
#devtools::install_github("dpique/oncomix", build_vignettes=T)
library(oncomix)

## -----------------------------------------------------------------------------
library(ggplot2)
oncoMixIdeal()

## -----------------------------------------------------------------------------
oncoMixTraditionalDE()

## -----------------------------------------------------------------------------
data(exprNmlIsof, exprTumIsof, package="oncomix")

##look at the matrix of mRNA expression data from adjacent normal samples
dim(exprNmlIsof)
exprNmlIsof[1:5, 1:5] 

##look at the matrix of mRNA expression data from tumors
dim(exprTumIsof)
exprTumIsof[1:5, 1:5] 

##fits the mixture models, will take a few minutes
mmParams <- mixModelParams(exprNmlIsof, exprTumIsof) 
head(mmParams)

## -----------------------------------------------------------------------------
topGeneQuant <- topGeneQuants(mmParams, deltMu2Thr=99, 
    deltMu1Thr=10, siThr=.99)
print(topGeneQuant)

## -----------------------------------------------------------------------------
mmParamsTop10 <- mmParams[1:10,]
print(mmParamsTop10)

## -----------------------------------------------------------------------------
isof = "uc002jxc.2"
plotGeneHist(mmParams, exprNmlIsof, exprTumIsof, isof)

## ----fig.width=7, fig.height=6.5----------------------------------------------
scatterMixPlot(mmParams)

## ----fig.width=7, fig.height=6.5----------------------------------------------
scatterMixPlot(mmParams, selIndThresh=.99)

## -----------------------------------------------------------------------------
scatterMixPlot(mmParams=mmParams, geneLabels=rownames(mmParamsTop10))

## -----------------------------------------------------------------------------
##The code that follows was used to generate the `queryRes` object
##in September 2017.
##
##install.packages("RMySQL")
##library(RMySQL)
##
##read in a table of known human oncogenes from the ONGene database
##ongene <- read.table("http://ongene.bioinfo-minzhao.org/ongene_human.txt",
##    header=TRUE, sep="\t", quote="", stringsAsFactors=FALSE, row.names=NULL)
##
##send a sql query to UCSC to map the human oncogenes to ucsc isoform ids
##ucscGenome <- dbConnect(MySQL(), user="genome", 
##    host="genome-mysql.cse.ucsc.edu", db='hg19')
##createGeneQuery <- function(name){ #name is a character vector
##    p1 <- paste(name, collapse='\',\'')
##    p2 <- paste('(\'',p1, '\')',sep="")
##    return(p2)
##}
##geneQ <- createGeneQuery(ongene$OncogeneName)
##queryRes <- dbGetQuery(ucscGenome, 
##    paste0("SELECT kgID, geneSymbol FROM kgXref WHERE geneSymbol IN ",
##        geneQ, " ;"))
##dbDisconnect(ucscGenome)

##The database mapping ucsc symbols to gene symbols is loaded below,
##without needing to access the internet.
data(queryRes, package="oncomix")

##Merge the queryRes & mmParams dataframes
queryRes$kgIDs <- substr(queryRes$kgID, 1, 8)
mmParams$kgIDs <- substr(rownames(mmParams), 1, 8)
mmParams$kgID <- rownames(mmParams)
mmParamsMg <- merge(mmParams, queryRes, by="kgIDs", all.x=TRUE)
rownames(mmParamsMg) <- mmParamsMg$kgID.x

## Show the top 5 isoforms with the highest score 
## in our dataset that map to known oncogenes
mmParamsMg <- mmParamsMg[with(mmParamsMg, order(-score)), ]
mmParamsMgSbst <- subset(mmParamsMg, !is.na(geneSymbol))[1:5,]
print(mmParamsMgSbst)

scatterMixPlot(mmParams=mmParams, geneLabels=rownames(mmParamsMgSbst))

## -----------------------------------------------------------------------------
library(RColorBrewer)
col <- brewer.pal(3, "Dark2")
ggplot(mmParamsMg, aes(x=score, y=..density.., fill=is.na(geneSymbol))) +
    geom_histogram(data=subset(mmParamsMg, is.na(geneSymbol)), 
        fill=col[2], alpha=0.5) + 
    geom_histogram(data=subset(mmParamsMg, !is.na(geneSymbol)), 
        fill=col[3], alpha=0.5) +   
    theme_classic() + xlab("OncoMix Score") + theme_classic() 

## -----------------------------------------------------------------------------
sessionInfo()

