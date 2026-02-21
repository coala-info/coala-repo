# Code example from 'roastgsaExample_main' vignette. See references/ for full tutorial.

## ----message = FALSE, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("roastgsa")
# 

## ----load-packages, message=FALSE, warning=FALSE------------------------------
library( roastgsa )

## ----message = FALSE----------------------------------------------------------
library(GSEABenchmarkeR)
geo2keggR <- loadEData("geo2kegg", nr.datasets=4)
geo2kegg <- maPreproc(list(geo2keggR[[4]]))
y <- assays(geo2kegg[[1]])$expr
covar <- colData(geo2kegg[[1]])
covar$GROUP <- as.factor(covar$GROUP)
covar$BLOCK <- as.factor(covar$BLOCK)

## ----message = FALSE----------------------------------------------------------
#library(EnrichmentBrowser)
#kegg.hs <- getGenesets(org="hsa", db="kegg")
data(kegg.hs)
kegg.gs <- kegg.hs[which(sapply(kegg.hs,length)>10&sapply(kegg.hs,length)<500)]

## ----fig.height=5,fig.width=7, message = FALSE--------------------------------
library(preprocessCore)
ynorm <- normalize.quantiles(y)
rownames(ynorm) <- rownames(y)
colnames(ynorm) <- colnames(y)
par(mfrow=c(1,2))
boxplot(y, las = 2)
boxplot(ynorm, las = 2)
y <- ynorm

## ----message = FALSE----------------------------------------------------------
form = as.formula("~ BLOCK + GROUP")
design <- model.matrix(form, covar)
contrast = "GROUP1"

## ----message = FALSE----------------------------------------------------------
fit.maxmean.comp <- roastgsa(y, form = form, covar = covar,
contrast = contrast, index = kegg.gs, nrot = 500,
mccores = 1, set.statistic = "maxmean",
self.contained = FALSE, executation.info = FALSE)
f1 <- fit.maxmean.comp$res
rownames(f1) <- substr(rownames(f1),1,8)
head(f1)

fit.meanrank <- roastgsa(y, form = form, covar = covar,
    contrast = 2, index = kegg.gs, nrot = 500,
    mccores = 1, set.statistic = "mean.rank",
    self.contained = FALSE, executation.info = FALSE)
f2 <- fit.meanrank$res
rownames(f2) <- substr(rownames(f2),1,8)
head(f2)

## ----fig.height=5,fig.width=7,message = FALSE---------------------------------
plot(fit.maxmean.comp, type ="stats", whplot = 2,  gsainfo = TRUE,
    cex.sub = 0.5, lwd = 2)

## ----fig.height=5,fig.width=7, message = FALSE--------------------------------
plot(fit.meanrank,  type ="stats",  whplot = 1, gsainfo = TRUE,
    cex.sub = 0.4, lwd = 2)

## ----fig.height=5,fig.width=7, message = FALSE--------------------------------
plot(fit.maxmean.comp, type = "GSEA", whplot = 2, gsainfo = TRUE,
    maintitle = "",  cex.sub = 0.5, statistic = "mean")

plot(fit.meanrank, type = "GSEA",  whplot = 1, gsainfo = TRUE,
    maintitle = "",  cex.sub = 0.5, statistic = "mean")

## ----fig.height=8,fig.width=7,message = FALSE---------------------------------
hm <- heatmaprgsa_hm(fit.maxmean.comp, y, intvar = "GROUP", whplot = 3,
        toplot = TRUE, pathwaylevel = FALSE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)

## ----fig.height=8,fig.width=7, message = FALSE--------------------------------
hm2 <- heatmaprgsa_hm(fit.maxmean.comp, y, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)

## ----message = FALSE----------------------------------------------------------
## Computationally intensive
# varrot <- varrotrand(fit.maxmean.comp, y,
#   testedsizes = c(3:30, seq(32,50, by=2), seq(55,200,by=5)), nrep = 200)

## ----message = FALSE----------------------------------------------------------
# ploteffsignaturesize(fit.maxmean.comp, varrot,  whplot = 1)

## ----message = FALSE----------------------------------------------------------
#htmlrgsa(fit.maxmean.comp, htmlpath = getwd(), htmlname = "file.html",
#  plotpath = paste0(getwd(),"/plotsroast/"), geneDEhtmlfiles = NULL,
#  plotstats = TRUE, plotgsea = TRUE, indheatmap = TRUE,
#  ploteffsize = TRUE, y = y, intvar = "GROUP", whplot = 1:50,
#  mycol = c("orange","green","white"), varrot=varrot,
#  sorttable = sorttable,dragtable = dragtable)

## ----message = FALSE----------------------------------------------------------
ss1 <- ssGSA(y, obj=fit.maxmean.comp, method = c("GScor"))

## ----fig.height=5,fig.width=7, message = FALSE--------------------------------
plot(ss1, orderby = covar$GROUP, whplot = 1, col = as.numeric(covar$GROUP),
samplename = FALSE, pch =16, maintitle = "", ssgsaInfo = TRUE,
cex.sub = 0.8, xlab = "Group", ylab = "zscore - GS")

## ----message = FALSE----------------------------------------------------------
sessionInfo()

