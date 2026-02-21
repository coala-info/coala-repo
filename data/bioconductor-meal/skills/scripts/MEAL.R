# Code example from 'MEAL' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----message = FALSE----------------------------------------------------------
library(MEAL)
library(MultiDataSet)
library(minfiData)
library(minfi)
library(ggplot2)

data("MsetEx")

## ----subset Methy-------------------------------------------------------------
meth <- mapToGenome(ratioConvert(MsetEx))
rowData(meth) <- getAnnotation(meth)[, -c(1:3)]

## Remove probes measuring SNPs
meth <- dropMethylationLoci(meth)

## Remove probes with SNPs
meth <- dropLociWithSnps(meth)

## Remove probes with NAs
meth <- meth[!apply(getBeta(meth), 1, function(x) any(is.na(x))), ]

## Select a subset of samples
set.seed(0)
meth <- meth[sample(nrow(meth), 100000), ]

## ----Pipeline,  warning=FALSE, eval = FALSE-----------------------------------
# res <- runPipeline(set = meth, variable_names = "status")

## ----Pipeline Adj,  warning=FALSE---------------------------------------------
resAdj <- runPipeline(set = meth, variable_names = "status", 
                      covariable_names = "age", analyses = c("DiffMean", "DiffVar"))
resAdj

## -----------------------------------------------------------------------------
names(resAdj)

## -----------------------------------------------------------------------------
head(getAssociation(resAdj, "DiffMean"))
head(getAssociation(resAdj, "DiffVar"))

## ----get Probe Res several coefs----------------------------------------------
head(getProbeResults(resAdj, rid = 1, coef = 2:3, 
                     fNames = c("chromosome", "start")))

## ----getGeneVals--------------------------------------------------------------
getGeneVals(resAdj, "ARMS2", genecol = "UCSC_RefGene_Name", fNames = c("chromosome", "start"))

## ----Manhattan 1--------------------------------------------------------------
targetRange <- GRanges("23:13000000-23000000")
plot(resAdj, rid = "DiffMean", type = "manhattan", highlight = targetRange)
plot(resAdj, rid = "DiffMean", type = "manhattan", subset = targetRange)

## ----Manhattan 2--------------------------------------------------------------
plot(resAdj, rid = "DiffMean", type = "manhattan", suggestiveline = 3, 
     genomewideline = 6, main = "My custom Manhattan")
abline(h = 13, col = "yellow")

## ----Volcano 1----------------------------------------------------------------
plot(resAdj, rid = "DiffMean", type = "volcano", tPV = 14, tFC = 0.4, 
     show.labels = FALSE) + ggtitle("My custom Volcano")

## ----QQ-----------------------------------------------------------------------
plot(resAdj, rid = "DiffMean", type = "qq") + ggtitle("My custom QQplot")

## ----Plot_Features, warning = FALSE-------------------------------------------
plotFeature(set = meth, feat = "cg09383816", variables = "status") + 
  ggtitle("Diff Means")
plotFeature(set = meth, feat = "cg11847929", variables = "status") + 
  ggtitle("Diff Vars")

## ----Regional plot 1----------------------------------------------------------
targetRange <- GRanges("chrX:13000000-14000000")
plotRegion(resAdj, targetRange)

## ----Regional plot 2----------------------------------------------------------
plotRegion(resAdj, targetRange, results = c("DiffMean"), tPV = 10)

## ----DiffMean, eval = FALSE---------------------------------------------------
# resDM <- runDiffMeanAnalysis(set = meth, model = ~ status)

## ----DiffVar, eval = FALSE----------------------------------------------------
# resDV <- runDiffVarAnalysis(set = meth, model = ~ status, coefficient = 2)

## ----RDA----------------------------------------------------------------------
targetRange <- GRanges("chrX:13000000-23000000")
resRDA <- runRDA(set = meth, model = ~ status, range = targetRange)

## ----RDA res------------------------------------------------------------------
getAssociation(resRDA, rid = "RDA")

## ----getRDAresults------------------------------------------------------------
getRDAresults(resRDA)

## ----topRDAhits---------------------------------------------------------------
topRDAhits(resRDA)

## ----plotRDA------------------------------------------------------------------
plotRDA(object = resRDA, pheno = colData(meth)[, "status", drop = FALSE])

## ----plotRDA 2----------------------------------------------------------------
plotRDA(object = resRDA, pheno = colData(meth)[, "status", drop = FALSE])
abline(h = -1)

## ----session Info-------------------------------------------------------------
sessionInfo()

