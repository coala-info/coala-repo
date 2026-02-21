# Code example from 'CBNplot_basic_usage' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("CBNplot")

## ----deg, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE, warning=FALSE, comment=FALSE, fig.height = 10, fig.width = 10----
library(CBNplot)
library(bnlearn)
library(org.Hs.eg.db)

## Load data
data(gaussian.test)

## Draw genes in the KEGG pathway as DEG
kegg <- org.Hs.egPATH2EG
mapped <- mappedkeys(kegg)
genes <- as.list(kegg[mapped])[["00532"]]

## Random data
counts <- head(gaussian.test, length(genes))
row.names(counts) <- genes

## Perform enrichment analysis
pway <- clusterProfiler::enrichKEGG(gene = genes)
pway <- clusterProfiler::setReadable(pway, org.Hs.eg.db, keyType="ENTREZID")

## ----usecase, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE, warning=FALSE, comment=FALSE, fig.height = 10, fig.width = 10----
bngeneplot(results = pway,exp = counts, pathNum = 1, expRow="ENTREZID")

## ----usecase2, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE, warning=FALSE, comment=FALSE, fig.height = 10, fig.width = 10----
ret <- bngeneplot(results = pway,exp = counts, pathNum = 1, returnNet=TRUE, , expRow="ENTREZID")
head(ret$str)

## ----igraph, include=TRUE, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE----
g <- bnlearn::as.igraph(ret$av)
igraph::evcent(g)$vector

## ----usecase3, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE, warning=FALSE, comment=FALSE, fig.height = 10, fig.width = 10----
bnpathplot(results = pway,exp = counts, nCategory=5, shadowText = TRUE, expRow="ENTREZID")

## ----usecase4, include=TRUE, echo=TRUE, message=FALSE, cache=FALSE, warning=FALSE, comment=FALSE, fig.height = 10, fig.width = 10----
bnpathplotCustom(results = pway, exp = counts, expRow="ENTREZID",
                 fontFamily="serif", glowEdgeNum=1, hub=1)
bngeneplotCustom(results = pway, exp = counts, expRow="ENTREZID",
                 pathNum=1, fontFamily="sans", glowEdgeNum=NULL, hub=1)

## -----------------------------------------------------------------------------
sessionInfo()

