# Code example from 'dcanr_vignette' vignette. See references/ for full tutorial.

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("dcanr")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("DavisLaboratory/dcanr")

## ----Load, message=FALSE------------------------------------------------------
library(dcanr)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
library(dcanr)
dcMethods()

## -----------------------------------------------------------------------------
#load data
data(sim102)
#get available conditions
getConditionNames(sim102)
#get expression data and conditions for 'UME6' knock-down
simdata <- getSimData(sim102, cond.name = 'UME6', full = FALSE)
emat <- simdata$emat
ume6_kd <- simdata$condition
print(emat[1:5, 1:5]) #149 genes and 406 samples
head(ume6_kd) #NOTE: binary conditions encoded with 1's and 2's

## -----------------------------------------------------------------------------
#apply the z-score method with Spearman correlations
z_scores <- dcScore(emat, ume6_kd, dc.method = 'zscore', cor.method = 'spearman')
print(z_scores[1:5, 1:5])

## -----------------------------------------------------------------------------
#perform a statistical test: the z-test is selected automatically
raw_p <- dcTest(z_scores, emat, ume6_kd)
print(raw_p[1:5, 1:5])

## -----------------------------------------------------------------------------
#adjust p-values (raw p-values from dcTest should NOT be modified)
adj_p <- dcAdjust(raw_p, f = p.adjust, method = 'fdr')
print(adj_p[1:5, 1:5])

## ----message=FALSE, warning=FALSE, fig.wide=TRUE------------------------------
library(igraph)

#get the differential network
dcnet <- dcNetwork(z_scores, adj_p)
plot(dcnet, vertex.label = '')
#convert to an adjacency matrix
adjmat <- as_adj(dcnet, sparse = FALSE)
print(adjmat[1:5, 1:5])
#convert to a data.frame
edgedf <- as_data_frame(dcnet, what = 'edges')
print(head(edgedf))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

