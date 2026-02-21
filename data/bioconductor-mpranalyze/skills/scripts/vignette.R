# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----load and examine data, include=TRUE--------------------------------------
library(MPRAnalyze)
data("ChrEpi")
summary(ce.colAnnot)
head(ce.colAnnot)

## ----init object, include=TRUE------------------------------------------------
obj <- MpraObject(dnaCounts = ce.dnaCounts, rnaCounts = ce.rnaCounts, 
                  dnaAnnot = ce.colAnnot, rnaAnnot = ce.colAnnot, 
                  controls = ce.control)

## ----library size estimation--------------------------------------------------
## If the library factors are different for the DNA and RNA data, separate 
## estimation of these factors is needed. We can also change the estimation 
## method (Upper quartile by default)
obj <- estimateDepthFactors(obj, lib.factor = c("batch", "condition"),
                            which.lib = "dna", 
                            depth.estimator = "uq")
obj <- estimateDepthFactors(obj, lib.factor = c("condition"),
                            which.lib = "rna", 
                            depth.estimator = "uq")

## In this case, the factors are the same - each combination of batch and 
## condition is a single library, and we'll use the default estimation
obj <- estimateDepthFactors(obj, lib.factor = c("batch", "condition"),
                            which.lib = "both")

## ----quant model fit----------------------------------------------------------
obj <- analyzeQuantification(obj = obj, 
                              dnaDesign = ~ batch + condition,
                              rnaDesign = ~ condition)

## ----quant extract and viz----------------------------------------------------
##extract alpha values from the fitted model
alpha <- getAlpha(obj, by.factor = "condition")

##visualize the estimates
boxplot(alpha)

## ----quant test and viz-------------------------------------------------------
## test 
res.epi <- testEmpirical(obj = obj, 
                               statistic = alpha$MT)
summary(res.epi)

res.chr <- testEmpirical(obj = obj,
                               statistic = alpha$WT)
par(mfrow=c(2,2))

hist(res.epi$pval.mad, main="episomal, all")
hist(res.epi$pval.mad[ce.control], main="episomal, controls")
hist(res.chr$pval.mad, main="chromosomal, all")
hist(res.chr$pval.mad[ce.control], main="chromosomal, controls")

par(mfrow=c(1,1))

## ----comp fit-----------------------------------------------------------------
obj <- analyzeComparative(obj = obj, 
                           dnaDesign = ~ barcode + batch + condition, 
                           rnaDesign = ~ condition, 
                           reducedDesign = ~ 1)

## ----comp lrt-----------------------------------------------------------------
res <- testLrt(obj)

head(res)
summary(res)

## ----foldchange---------------------------------------------------------------

## plot log Fold-Change
plot(density(res$logFC))
## plot volcano
plot(res$logFC, -log10(res$pval))

## ----allelic------------------------------------------------------------------
ce.colAnnot$barcode_allelic <- interaction(ce.colAnnot$barcode, ce.colAnnot$condition)
summary(ce.colAnnot)

## ----scale--------------------------------------------------------------------
obj <- analyzeComparative(obj = obj, 
                          rnaDesign = ~ condition, 
                          reducedDesign = ~ 1, 
                          mode="scale")
res.scale <- testLrt(obj)
head(res.scale)
plot(res$logFC, res.scale$logFC)

