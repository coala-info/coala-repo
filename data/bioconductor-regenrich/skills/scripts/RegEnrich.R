# Code example from 'RegEnrich' vignette. See references/ for full tutorial.

## ----global_options, echo=FALSE, results="hide", eval=TRUE--------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, 
                      comment = "#>", 
                      fig.width = 5, 
                      fig.height = 4.5, 
                      fig.align = "center",
                      echo=TRUE, 
                      warning=FALSE, 
                      message=TRUE, 
                      tidy.opts=list(width.cutoff=80), 
                      tidy=FALSE)
rm(list = ls())
gc(reset = TRUE)
options(max.print = 200, width = 110)

## ----setup, warning=FALSE, message=FALSE, results="hide"----------------------------------------------------
library(RegEnrich)

## ----quickExample_Initializing, eval=FALSE, warning=FALSE, message=FALSE, results="hide"--------------------
# object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
#                       colData = sampleInfo, # sample information (data frame)
#                       reg = regulators, # regulators
#                       method = "limma", # differentila expression analysis method
#                       design = designMatrix, # desing model matrix
#                       contrast = contrast, # contrast
#                       networkConstruction = "COEN", # network inference method
#                       enrichTest = "FET") # enrichment analysis method

## ----quickExample_4Steps, eval=FALSE, warning=FALSE, message=FALSE, results="hide"--------------------------
# # Differential expression analysis
# object = regenrich_diffExpr(object)
# # Regulator-target network inference
# object = regenrich_network(object)
# # Enrichment analysis
# object = regenrich_enrich(object)
# # Regulator scoring and ranking
# object = regenrich_rankScore(object)
# 
# # Obtaining results
# res = results_score(object)

## ----quickExample_simpler, eval=FALSE, warning=FALSE, message=FALSE, results="hide"-------------------------
# # Perform 4 steps in RegEnrich analysis
# object = regenrich_diffExpr(object) %>%
#   regenrich_network() %>%
#   regenrich_enrich() %>%
#   regenrich_rankScore()
# 
# res = results_score(object)

## ----loadExpr-----------------------------------------------------------------------------------------------
data(Lyme_GSE63085)
FPKM = Lyme_GSE63085$FPKM

## ----transformFPKM------------------------------------------------------------------------------------------
log2FPKM = log2(FPKM + 1)
print(log2FPKM[1:6, 1:5])

## ----loadSampleInformation----------------------------------------------------------------------------------
sampleInfo = Lyme_GSE63085$sampleInfo
head(sampleInfo)

## ----loadTFs------------------------------------------------------------------------------------------------
data(TFs)
head(TFs)

## ----design-------------------------------------------------------------------------------------------------
method = "LRT_LM"
# design and reduced formulae
design = ~ patientID + week
reduced = ~ patientID

## ----networkConstruction------------------------------------------------------------------------------------
networkConstruction = "COEN"

## ----enrichTest---------------------------------------------------------------------------------------------
enrichTest = "FET"

## ----Initializing-------------------------------------------------------------------------------------------
object = RegenrichSet(expr = log2FPKM[1:2000, ],
                      colData = sampleInfo,
                      method = "LRT_LM", 
                      minMeanExpr = 0.01,
                      design = ~ patientID + week,
                      reduced = ~ patientID,
                      networkConstruction = "COEN", 
                      enrichTest = "FET")
print(object)

## ----regenrich_diffExpr-------------------------------------------------------------------------------------
object = regenrich_diffExpr(object)
print(object)
print(results_DEA(object))

## ----regenrich_diffExprLimma--------------------------------------------------------------------------------
object2 = regenrich_diffExpr(object, method = "limma", coef = "week3")
print(object2)
print(results_DEA(object2))

## ----network_COEN-------------------------------------------------------------------------------------------
set.seed(123)
object = regenrich_network(object)
print(object)

## ----network_COEN_topNet------------------------------------------------------------------------------------
# TopNetwork class
print(results_topNet(object))

## ----object_paramsIn_reg------------------------------------------------------------------------------------
# All parameters are stored in object@paramsIn slot
head(slot(object, "paramsIn")$reg)

## ----save_object, eval=FALSE--------------------------------------------------------------------------------
# # Saving object to 'fileName.Rdata' file in '/folderName' directory
# save(object, file = "/folderName/fileName.Rdata")

## ----regenrich_network_GRN, eval=FALSE----------------------------------------------------------------------
# ### not run
# library(BiocParallel)
# # on non-Windows computers (use 2 workers)
# bpparam = register(MulticoreParam(workers = 2, RNGseed = 1234))
# # on Windows computers (use 2 workers)
# bpparam = register(SnowParam(workers = 2, RNGseed = 1234))
# 
# object3 = regenrich_network(object, networkConstruction = "GRN",
#                            BPPARAM = bpparam, minR = 0.3)
# print(object3)
# print(results_topNet(object3))
# save(object3, file = "/folderName/fileName3.Rdata")

## ----user_defined_network1----------------------------------------------------------------------------------
network_user = results_topNet(object)
print(class(network_user))
regenrich_network(object2) = network_user
print(object2)

## ----user_defined_network_edges-----------------------------------------------------------------------------
network_user = slot(results_topNet(object), "elementset")
print(class(network_user))
regenrich_network(object2) = as.data.frame(network_user)
print(object2)

## ----regenrich_enrich_FET-----------------------------------------------------------------------------------
object = regenrich_enrich(object)
print(results_enrich(object))
# enrich_FET = results_enrich(object)@allResult
enrich_FET = slot(results_enrich(object), "allResult")
head(enrich_FET[, 1:6])

## ----regenrich_enrich_GSEA----------------------------------------------------------------------------------
set.seed(123)
object2 = regenrich_enrich(object, enrichTest = "GSEA", nperm = 5000)
print(results_enrich(object))
# enrich_GSEA = results_enrich(object2)@allResult
enrich_GSEA = slot(results_enrich(object2), "allResult")
head(enrich_GSEA[, 1:6])

## ----comparingFET_GSEA, fig.height=5, fig.width=5, eval=FALSE-----------------------------------------------
# plotOrders(enrich_FET[[1]][1:20], enrich_GSEA[[1]][1:20])

## ----regenrich_rankScore------------------------------------------------------------------------------------
object = regenrich_rankScore(object)
results_score(object)

## ----plotExpressionRegulatorTarget, fig.height=4.5, fig.width=6, eval=FALSE---------------------------------
# plotRegTarExpr(object, reg = "ARNTL2")

## ----case1ReadData1_1, eval=FALSE, include=FALSE------------------------------------------------------------
# # Download all .cel files from GEO database (GSE31193 dataset) to current folder
# # and then decompress it to GSE31193_RAW folder.
# library(affy)
# abatch = ReadAffy(celfile.path = "./GSE31193_RAW/")
# 
# # Data normalization
# eset <- rma(abatch)
# 
# # Annotation
# library(annotate)
# library(hgu133plus2.db)
# 
# ID <- featureNames(eset)
# Symbol <- getSYMBOL(ID, "hgu133plus2.db")
# fData(eset) <- data.frame(Symbol=Symbol)
# 

## ----case1ReadData1_2, warning=FALSE, message=FALSE---------------------------------------------------------
if (!requireNamespace("GEOquery"))
 BiocManager::install("GEOquery")

library(GEOquery)
eset <- getGEO(GEO = "GSE31193")[[1]]

## ----case1ReadData1_3---------------------------------------------------------------------------------------
# Samples information
pd0 = pData(eset)
pd = pd0[, c("title", "time:ch1", "agent:ch1")]
colnames(pd) = c("title", "time", "group")
pd$time = factor(c(`n/a` = "0", `6` = "6", `24` = "24")[pd$time],
                 levels = c("0", "6", "24"))
pd$group = factor(pd$group, levels = c("none", "IFN", "IL28B"))
pData(eset) = pd

# Only samples without or after 6 and 24 h IFN-α treatment
eset_IFN = eset[, pd$group %in% c("none", "IFN")]

# Order the samples based on time of treatment
pData(eset_IFN) = pData(eset_IFN)[order(pData(eset_IFN)$time),]

# Rename samples
colnames(eset_IFN) = pData(eset_IFN)$title

# Probes information
probeGene = fData(eset_IFN)[, "Gene Symbol", drop = FALSE]

## ----case1ReadData1_4---------------------------------------------------------------------------------------
probeGene$meanExpr = rowMeans(exprs(eset_IFN))
probeGene = probeGene[order(probeGene$meanExpr, decreasing = TRUE),]

# Keep a single probe for a gene, and remove the probe matching no gene.
probeGene_noDu = probeGene[!duplicated(probeGene$`Gene Symbol`), ][-1,]

data = eset_IFN[rownames(probeGene_noDu), ]
rownames(data) = probeGene_noDu$`Gene Symbol`

## ----case1ReadData1_5---------------------------------------------------------------------------------------
set.seed(1234)
data = data[sample(1:nrow(data), 5000), ]

## ----case1RegEnrichAnalyais, message=FALSE------------------------------------------------------------------
expressionMatrix = exprs(data) # expression data
# rownames(expressionMatrix) = probeGene_noDu$`Gene Symbol`
sampleInfo = pData(data) # sample information

design = ~time
contrast = c(0, 0, 1) # to extract the coefficient "time24"

data(TFs)
# Initializing a RegenrichSet object
object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
                      colData = sampleInfo, # sample information (data frame)
                      reg = unique(TFs$TF_name), # regulators
                      method = "limma", # differentila expression analysis method
                      design = design, # desing fomula
                      contrast = contrast, # contrast
                      networkConstruction = "COEN", # network inference method
                      enrichTest = "FET") # enrichment analysis method

# Perform RegEnrich analysis
set.seed(123)

# This procedure takes quite a bit of time.
object = regenrich_diffExpr(object) %>%
  regenrich_network() %>%
  regenrich_enrich() %>%
  regenrich_rankScore()

## ----case1RegEnrichResults, message=FALSE-------------------------------------------------------------------
res = results_score(object)
res

## ----case1Plot, , fig.height=4.5, fig.width=6, eval=FALSE---------------------------------------------------
# plotRegTarExpr(object, reg = "STAT1")

## ----case2ReadData1, message = FALSE------------------------------------------------------------------------
library(GEOquery)
eset <- getGEO(GEO = "GSE130567")[[1]]
pdata = pData(eset)[, c("title", "geo_accession", "cultured in:ch1", "treatment:ch1")]
colnames(pdata) = c("title", "accession", "cultured", "treatment")
pData(eset) = pdata

# Only samples cultured with M-CSF in the presence or absence of IFN-γ
eset = eset[, pdata$treatment %in% c("NT", "IFNG-3h") & pdata$cultured == "M-CSF"]

# Sample information
sampleInfo = pData(eset)
rownames(sampleInfo) = paste0(rep(c("Resting", "IFNG"), each = 3), 1:3)
sampleInfo$treatment = factor(rep(c("Resting", "IFNG"), each = 3),
                              levels = c("Resting", "IFNG"))

## ----case2DownloadReads, message=FALSE, warning=FALSE-------------------------------------------------------
tmpFolder = tempdir()
tmpFile = tempfile(pattern = "GSE130567_", tmpdir = tmpFolder, fileext = ".tar")
download.file("https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE130567&format=file",
              destfile = tmpFile, mode = "wb")
untar(tmpFile, exdir = tmpFolder)
files = untar(tmpFile, list = TRUE)
filesFull = file.path(tmpFolder, files)

## ----case2ReadData2, message=FALSE, warning=FALSE-----------------------------------------------------------
dat = list()
for (file in filesFull){
  accID = gsub(".*(GSM\\d{7}).*", "\\1", file)
  if(accID %in% sampleInfo$accession){
    zz = gzfile(file, "rt")
    zzdata = read.csv(zz, header = FALSE, sep = "\t", skip = 4, row.names = 1)
    close(zz)
    zzdata = zzdata[,1, drop = FALSE] # Extract the first numeric column
    colnames(zzdata) = accID
    dat = c(dat, list(zzdata))
  }
}
edata = do.call(cbind, dat)

edata = edata[grep(".*[0-9]+$", rownames(edata)),] # remove PAR locus genes
rownames(edata) = substr(rownames(edata), 1, 15)
colnames(edata) = rownames(sampleInfo)

# Retain genes with average read counts higher than 1
edata = edata[rowMeans(edata) > 1,]

## ----case2ReadData1_3---------------------------------------------------------------------------------------
set.seed(1234)
edata = edata[sample(1:nrow(edata), 5000), ]

## ----case2RegEnrich-----------------------------------------------------------------------------------------
expressionMatrix = as.matrix(edata) # expression data

design = ~ treatment
reduced = ~ 1

data(TFs)
# Initializing a RegenrichSet object
object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
                      colData = sampleInfo, # sample information (data frame)
                      reg = unique(TFs$TF), # regulators
                      method = "LRT_DESeq2", # differentila expression analysis method
                      design = design, # desing fomula
                      reduced = reduced, # reduced
                      networkConstruction = "COEN", # network inference method
                      enrichTest = "FET") # enrichment analysis method

# Perform RegEnrich analysis
set.seed(123)

# This procedure takes quite a bit of time.
object = regenrich_diffExpr(object) %>%
  regenrich_network() %>%
  regenrich_enrich() %>%
  regenrich_rankScore()

## ----case2RegEnrichResults, message=FALSE-------------------------------------------------------------------
res = results_score(object)
res$name = TFs[res$reg, "TF_name"]
res

## ----case2Plot, , fig.height=4.5, fig.width=6, eval=FALSE---------------------------------------------------
# plotRegTarExpr(object, reg = "ENSG00000028277")

## ----session------------------------------------------------------------------------------------------------
sessionInfo()

