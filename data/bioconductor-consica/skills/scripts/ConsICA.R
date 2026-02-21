# Code example from 'ConsICA' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("consICA")

## ----warning=FALSE,message=FALSE----------------------------------------------
library('consICA')

## ----warning=FALSE,message=FALSE----------------------------------------------
library(SummarizedExperiment)
data("samples_data")
samples_data

# According to our terminology expression matrix X of 2454 genes and 472 samples
X <- data.frame(assay(samples_data))
dim(X)
# variables described each sample
Var <- data.frame(colData(samples_data))
dim(Var)
colnames(Var)[1:20] # print first 20
# survival time and event for each sample
Sur <- data.frame(colData(samples_data))[,c("time", "event")]
Var <- Var[,which(colnames(Var) != "time" & colnames(Var) != "event")]


## ----echo=FALSE, out.width='95%', fig.align="center"--------------------------
knitr::include_graphics('./Picture1.jpg')

## -----------------------------------------------------------------------------
set.seed(2022)
cica <- consICA(samples_data, ncomp=20, ntry=10, ncores=1, show.every=0)

## -----------------------------------------------------------------------------
str(cica, max.level=1)

## -----------------------------------------------------------------------------
features <- getFeatures(cica, alpha = 0.05, sort = TRUE)
#Positive and negative affecting features for first components are
head(features$ic.1$pos)
head(features$ic.1$neg)

## -----------------------------------------------------------------------------
icomp <- 1
plot(sort(cica$S[,icomp]),col = "#0000FF", type="l", ylab=("involvement"),xlab="genes",las=2,cex.axis=0.4, main=paste0("Metagene #", icomp, "\n(involvement of features)"),cex.main=0.6)

## -----------------------------------------------------------------------------
var_ic <- estimateVarianceExplained(cica)
p <- plotICVarianceExplained(cica)

## -----------------------------------------------------------------------------
## Run ANOVA for components 1 and 5
# Get metadata from SummarizedExperiment object
# Var <- data.frame(SummarizedExperiment::colData(samples_data))
var_ic1 <- anovaIC(cica, Var, icomp = 1, color_by_pv = TRUE, plot = TRUE)
var_ic5 <- anovaIC(cica, Var, icomp = 5, mode = 'box', plot = FALSE)

head(var_ic1, 3)
head(var_ic5, 5)

## ----results='hide'-----------------------------------------------------------
## To save time for this example load result of getGO(cica, alpha = 0.05, db = c("BP", "MF", "CC"))
if(!file.exists("cica_GOs_20_s2022.rds")){
  
  # Old version < 1.1.1 - GO was an external object. Add it to cica and rotate if need
  # GOs <- readRDS(url("http://edu.modas.lu/data/consICA/GOs_40_s2022.rds", "r"))
  # cica$GO <- GOs
  # cica <- setOrientation(cica)
  
  # Actual version >= 1.1.1
  cica <- readRDS(url("http://edu.modas.lu/data/consICA/cica_GOs_20_s2022.rds", "r"))
  saveRDS(cica, "cica_GOs_20_s2022.rds")
} else{
  cica <- readRDS("cica_GOs_20_s2022.rds")
}

## Search GO (biological process)
# cica <- getGO(cica, alpha = 0.05, db = "BP", ncores = 4)
## Search GO (biological process, molecular function, cellular component)
# cica <- getGO(cica, alpha = 0.05, db = c("BP", "MF", "CC"), ncores = 4)

## -----------------------------------------------------------------------------
RS <- survivalAnalysis(cica, surv = Sur)
cat("Hazard score for significant components")
RS$hazard.score

## -----------------------------------------------------------------------------
# Generate report with independent components description
if(FALSE){
  saveReport(cica, Var=Var, surv = Sur)
}

## -----------------------------------------------------------------------------
# delete loaded file after vignette run
unlink("cica_GOs_20_s2022.rds")

## -----------------------------------------------------------------------------
sessionInfo()

