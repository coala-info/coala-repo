# Code example from 'EPICv2' vignette. See references/ for full tutorial.

## ----bioconductor, message=FALSE, warning=FALSE, eval=FALSE-------------------
# if (!require("BiocManager"))
# 	install.packages("BiocManager")
# BiocManager::install("DMRcate")

## ----libr, message=FALSE, warning=FALSE---------------------------------------
library(DMRcate)

## ----libreh, message=FALSE, warning=FALSE-------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
ALLbetas <- eh[["EH9451"]]
head(ALLbetas)

## ----density------------------------------------------------------------------
plot(density(ALLbetas[,1]), col="forestgreen", xlab="Beta value", ylim=c(0, 6), 
     main="Noguera-Castells et al. 2023 ALL samples", lwd=2)
invisible(sapply(2:5, function (x) lines(density(ALLbetas[,x]), col="forestgreen", lwd=2)))
invisible(sapply(6:10, function (x) lines(density(ALLbetas[,x]), col="orange", lwd=2)))
legend("topleft", c("B cell ALL", "T cell ALL"), text.col=c("forestgreen", "orange"))

## ----Ms-----------------------------------------------------------------------
ALLMs <- minfi::logit2(ALLbetas)

## ----rmSNPandCH---------------------------------------------------------------
nrow(ALLMs)
ALLMs.noSNPs <- rmSNPandCH(ALLMs, rmcrosshyb = FALSE)
nrow(ALLMs.noSNPs)

## ----hypothesis---------------------------------------------------------------
type <- gsub("_.*", "", colnames(ALLMs.noSNPs))
type
design <- model.matrix(~type)
design

## ----cpg.annotate-------------------------------------------------------------
myannotation <- cpg.annotate("array", object=ALLMs.noSNPs, what = "M", 
                             arraytype = "EPICv2", epicv2Filter = "mean", 
                             epicv2Remap = TRUE,  analysis.type="differential", 
                             design=design, coef=2, fdr=0.001)

## ----dmrcate------------------------------------------------------------------
dmrcoutput <- dmrcate(myannotation, lambda=1000, C=2)
results.ranges <- extractRanges(dmrcoutput, genome = "hg38")
results.ranges

## ----plot---------------------------------------------------------------------
groups <- c(BALL="forestgreen", TALL="orange")
cols <- groups[as.character(type)]
DMR.plot(ranges=results.ranges, dmr=3, CpGs=myannotation, 
         what = "Beta", arraytype = "EPICv2", phen.col=cols, genome = "hg38") 

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

