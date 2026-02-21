# Code example from 'ToPASeq' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE-----------------------------------------------------
suppressPackageStartupMessages({ 
    library(ToPASeq)
    library(EnrichmentBrowser)
    library(graphite)
})

## ----lib-------------------------------------------------------------------
library(ToPASeq)

## ----loadAirway------------------------------------------------------------
library(airway)
data(airway)

## ----processAirway---------------------------------------------------------
airSE <- airway[grep("^ENSG", rownames(airway)),]
dim(airSE)
assay(airSE)[1:4,1:4]

## ----pdataAirway-----------------------------------------------------------
airSE$GROUP <- ifelse(airway$dex == "trt", 1, 0)
table(airSE$GROUP)

## ----pdataAirway2----------------------------------------------------------
airSE$BLOCK <- airway$cell
table(airSE$BLOCK)

## ----deAirway--------------------------------------------------------------
library(EnrichmentBrowser)
airSE <- deAna(airSE, de.method="edgeR")
rowData(airSE, use.names=TRUE)

## ----pwys------------------------------------------------------------------
library(graphite)
pwys <- pathways(species="hsapiens", database="kegg")
pwys

## ----nodes-----------------------------------------------------------------
nodes(pwys[[1]])

## ----mapIDs----------------------------------------------------------------
airSE <- idMap(airSE, org="hsa", from="ENSEMBL", to="ENTREZID")

## ----genes-----------------------------------------------------------------
all <- names(airSE)
de.ind <- rowData(airSE)$ADJ.PVAL < 0.01
de <- rowData(airSE)$FC[de.ind]
names(de) <- all[de.ind]

## ----nrGenes---------------------------------------------------------------
length(all)
length(de)

## ----prs-------------------------------------------------------------------
res <- prs(de, all, pwys[1:100], nperm=100)
head(res)

## ----prsWeights------------------------------------------------------------
ind <- grep("Ras signaling pathway", names(pwys))
weights <- prsWeights(pwys[[ind]], de, all)
weights

## ----maxWeight-------------------------------------------------------------
weights[weights == max(weights)]

