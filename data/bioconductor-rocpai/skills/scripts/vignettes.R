# Code example from 'vignettes' vignette. See references/ for full tutorial.

## ----style, include=FALSE, results='hide'-------------------------------------
BiocStyle::markdown()
library(boot)
library(fission)
library(SummarizedExperiment)
library(ROCpAI)


## ----installation, eval=FALSE-------------------------------------------------
# devtools::install_github("juanpegarcia/ROCpAI")

## ----echo=FALSE, include=FALSE, results='hide'--------------------------------
data("fission")
genes <- as.data.frame(cbind(strain <- colData(fission)$strain, t(assay(fission)[c("SPNCRNA.1080","SPAC186.08c","SPNCRNA.1420","SPCC70.08c","SPAC212.04c"),])))
colnames(genes) <- c("Strain", "Gene1", "Gene2", "Gene3", "Gene4", "Gene5"  )


## -----------------------------------------------------------------------------
genes 

## -----------------------------------------------------------------------------
pointsCurve(genes[,1], genes[,2])

## -----------------------------------------------------------------------------
resultMc <- mcpAUC(genes, low.value = 0, up.value = 0.25, plot=TRUE)
resultMc

## -----------------------------------------------------------------------------
test.Mc<- assay(resultMc)
test.Mc$St_pAUC

## -----------------------------------------------------------------------------
test.Mc$pAUC

## -----------------------------------------------------------------------------
resultsT <- tpAUC(genes, low.value = 0, up.value = 0.25, plot=TRUE)
resultsT

## -----------------------------------------------------------------------------
test.tpAUC <- assay(resultsT)


## -----------------------------------------------------------------------------
test.tpAUC$St_pAUC


## -----------------------------------------------------------------------------
test.tpAUC$pAUC

## ----warning='hide'-----------------------------------------------------------
resultstboot<- tpAUCboot(genes,low.value = 0, up.value = 0.25)

## ----echo='hide'--------------------------------------------------------------
test.tpAUCboot <- assay(resultstboot)
resultT <- t(as.data.frame(cbind(test.tpAUCboot$Tp_AUC,test.tpAUCboot$sd,test.tpAUCboot$lwr,test.tpAUCboot$upr)))
colnames(resultT) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")
rownames(resultT) <- c("Tp_AUC","sd","lwr","upr")

## -----------------------------------------------------------------------------
resultT

## ----warning='hide'-----------------------------------------------------------
resultsMcboot <- mcpAUCboot(genes,low.value = 0, up.value = 0.25)


## ----echo='hide', results='hide'----------------------------------------------
test.mcpAUCboot <- assay(resultsMcboot)
resultMc <- t(as.data.frame(cbind(test.mcpAUCboot$MCp_AUC,test.mcpAUCboot$sd,test.mcpAUCboot$lwr,test.mcpAUCboot$upr)))
colnames(resultMc) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")
rownames(resultMc) <- c("MCp_AUC","sd","lwr","upr")

## -----------------------------------------------------------------------------
resultMc

## ----sessionInfo, eval=TRUE---------------------------------------------------
sessionInfo()

