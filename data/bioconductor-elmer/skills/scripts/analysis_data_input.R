# Code example from 'analysis_data_input' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER)
library(DT)
library(dplyr)
dir.create("result",showWarnings = FALSE)
library(BiocStyle)

## ----message=FALSE------------------------------------------------------------
# get distal probes that are 2kb away from TSS on chromosome 1
distal.probes <- get.feature.probe(
  genome = "hg19", 
  met.platform = "450K", 
  rm.chr = paste0("chr",c(2:22,"X","Y"))
)

## ----eval=TRUE, message=FALSE-------------------------------------------------
library(MultiAssayExperiment)
library(ELMER.data)
data(LUSC_RNA_refined,package = "ELMER.data")
data(LUSC_meth_refined,package = "ELMER.data")
GeneExp[1:5,1:5]
Meth[1:5,1:5]
mae <- createMAE(
  exp = GeneExp, 
  met = Meth,
  save = TRUE,
  linearize.exp = TRUE,
  save.filename = "mae.rda",
  filter.probes = distal.probes,
  met.platform = "450K",
  genome = "hg19",
  TCGA = TRUE
)
as.data.frame(colData(mae)[1:5,])  %>% datatable(options = list(scrollX = TRUE))
as.data.frame(sampleMap(mae)[1:5,])  %>% datatable(options = list(scrollX = TRUE))
as.data.frame(assay(getMet(mae)[1:5,1:5]))  %>% datatable(options = list(scrollX = TRUE))
as.data.frame(assay(getMet(mae)[1:5,1:5])) %>% datatable(options = list(scrollX = TRUE))

## ----eval=FALSE, message=FALSE------------------------------------------------
# library(ELMER)
# # example input
# met <- matrix(rep(0,15),ncol = 5)
# colnames(met) <- c(
#   "Sample1",
#   "Sample2",
#   "Sample3",
#   "Sample4",
#   "Sample5"
# )
# rownames(met) <- c("cg26928153","cg16269199","cg13869341")
# 
# exp <- matrix(rep(0,15),ncol = 5)
# colnames(exp) <- c(
#   "Sample1",
#   "Sample2",
#   "Sample3",
#   "Sample4",
#   "Sample5"
# )
# rownames(exp) <- c("ENSG00000073282","ENSG00000078900","ENSG00000141510")
# 
# 
# assay <- c(
#   rep("DNA methylation", ncol(met)),
#   rep("Gene expression", ncol(exp))
# )
# primary <- c(colnames(met),colnames(exp))
# colname <- c(colnames(met),colnames(exp))
# sampleMap <- data.frame(assay,primary,colname)
# 
# distal.probes <- get.feature.probe(
#   genome = "hg19",
#   met.platform = "EPIC"
# )
# 
# colData <- data.frame(sample = colnames(met))
# rownames(colData) <- colnames(met)
# 
# mae <- createMAE(
#   exp = exp,
#   met = met,
#   save = TRUE,
#   filter.probes = distal.probes,
#   colData = colData,
#   sampleMap = sampleMap,
#   linearize.exp = TRUE,
#   save.filename = "mae.rda",
#   met.platform = "EPIC",
#   genome = "hg19",
#   TCGA = FALSE
# )

