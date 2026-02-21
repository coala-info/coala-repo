# Code example from 'biosigner-vignette' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.width = 6, fig.height = 6)

## ----loading, message = FALSE-------------------------------------------------
library(biosigner)

## ----diaplasma----------------------------------------------------------------
data(diaplasma)

## ----diaplasma_strF-----------------------------------------------------------
attach(diaplasma)
library(ropls)
ropls::view(dataMatrix)
ropls::view(sampleMetadata, standardizeL = TRUE)
ropls::view(variableMetadata, standardizeL = TRUE)

## ----diaplasma_plot-----------------------------------------------------------
with(sampleMetadata,
plot(age, bmi, cex = 1.5, col = ifelse(type == "T1", "blue", "red"), pch = 16))
legend("topleft", cex = 1.5, legend = paste0("T", 1:2),
text.col = c("blue", "red"))

## ----select-------------------------------------------------------------------
featureSelVl <- variableMetadata[, "mzmed"] >= 450 &
variableMetadata[, "mzmed"] < 500
sum(featureSelVl)
dataMatrix <- dataMatrix[, featureSelVl]
variableMetadata <- variableMetadata[featureSelVl, ]

## ----biosign------------------------------------------------------------------
diaSign <- biosign(dataMatrix, sampleMetadata[, "type"], bootI = 5)

## ----boxplot------------------------------------------------------------------
plot(diaSign, typeC = "boxplot")

## ----signature----------------------------------------------------------------
variableMetadata[getSignatureLs(diaSign)[["complete"]], ]

## ----train--------------------------------------------------------------------
trainVi <- 1:floor(0.8 * nrow(dataMatrix))
testVi <- setdiff(1:nrow(dataMatrix), trainVi)

## ----biosign_train, warning = FALSE-------------------------------------------
diaTrain <- biosign(dataMatrix[trainVi, ], sampleMetadata[trainVi, "type"],
bootI = 5)

## ----predict------------------------------------------------------------------
diaFitDF <- predict(diaTrain)

## ----confusion----------------------------------------------------------------
lapply(diaFitDF, function(predFc) table(actual = sampleMetadata[trainVi,
"type"], predicted = predFc))

## ----accuracy-----------------------------------------------------------------
sapply(diaFitDF, function(predFc) {
conf <- table(sampleMetadata[trainVi, "type"], predFc)
conf <- sweep(conf, 1, rowSums(conf), "/")
round(mean(diag(conf)), 3)
})

## ----getAccuracy--------------------------------------------------------------
round(getAccuracyMN(diaTrain)["S", ], 3)

## ----performance--------------------------------------------------------------
diaTestDF <- predict(diaTrain, newdata = dataMatrix[testVi, ])
sapply(diaTestDF, function(predFc) {
conf <- table(sampleMetadata[testVi, "type"], predFc)
conf <- sweep(conf, 1, rowSums(conf), "/")
round(mean(diag(conf)), 3)
})

## ----get_se, message = FALSE--------------------------------------------------
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(diaplasma)
data.mn <- diaplasma[["dataMatrix"]] # matrix: samples x variables
samp.df <- diaplasma[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- diaplasma[["variableMetadata"]] # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(SummarizedExperiment)
dia.se <- SummarizedExperiment(assays = list(diaplasma = t(data.mn)),
                               colData = samp.df,
                               rowData = feat.df)
# note that colData and rowData main format is DataFrame, but data frames are accepted when building the object
stopifnot(validObject(dia.se))

# Viewing the SummarizedExperiment
# ropls::view(dia.se)

## ----se_biosign, echo = TRUE, results = "hide"--------------------------------
dia.se <- dia.se[1:100, ]
dia.se <- biosign(dia.se, "type", bootI = 5)

## ----se_updated---------------------------------------------------------------
feat.DF <- SummarizedExperiment::rowData(dia.se)
head(feat.DF[, grep("type_", colnames(feat.DF))])

## ----se_model-----------------------------------------------------------------
dia_type.biosign <- getBiosign(dia.se)
names(dia_type.biosign)
plot(dia_type.biosign[["type_plsda.forest.svm"]], typeC = "tier")

## ----get_eset, message = FALSE------------------------------------------------
# Preparing the data (matrix) and sample and variable metadata (data frames):
data(diaplasma)
data.mn <- diaplasma[["dataMatrix"]] # matrix: samples x variables
samp.df <- diaplasma[["sampleMetadata"]] # data frame: samples x sample metadata
feat.df <- diaplasma[["variableMetadata"]] # data frame: features x feature metadata

# Creating the SummarizedExperiment (package SummarizedExperiment)
library(Biobase)
dia.eset <- Biobase::ExpressionSet(assayData = t(data.mn))
Biobase::pData(dia.eset) <- samp.df
Biobase::fData(dia.eset) <- feat.df
stopifnot(validObject(dia.eset))
# Viewing the ExpressionSet
# ropls::view(dia.eset)

## ----dia_se_biosign, echo = TRUE, results = "hide"----------------------------
dia.eset <- dia.eset[1:100, ]
dia_type.biosign <- biosign(dia.eset, "type", bootI = 5)

## ----dia_se_plot--------------------------------------------------------------
plot(dia_type.biosign, typeC = "tier")

## ----dia_se_updated-----------------------------------------------------------
dia.eset <- getEset(dia_type.biosign)
feat.df <- Biobase::fData(dia.eset)
head(feat.df[, grep("type_", colnames(feat.df))])

## ----detach-------------------------------------------------------------------
detach(diaplasma)

## ----nci60_mae, message = FALSE-----------------------------------------------
data("NCI60", package = "ropls")
nci.mae <- NCI60[["mae"]]
library(MultiAssayExperiment)
# Cancer types
table(nci.mae$cancer)
# Restricting to the 'ME' and 'LE' cancer types and to the 'agilent' and 'hgu95' datasets
nci.mae <- nci.mae[, nci.mae$cancer %in% c("ME", "LE"), c("agilent", "hgu95")]

## ----mae_biosign--------------------------------------------------------------
nci.mae <- biosign(nci.mae, "cancer", bootI = 5)

## ----mae_updated--------------------------------------------------------------
SummarizedExperiment::rowData(nci.mae[["agilent"]])

## ----mae_model----------------------------------------------------------------
mae_biosign.ls <- getBiosign(nci.mae)
for (set.c in names(mae_biosign.ls))
plot(mae_biosign.ls[[set.c]][["cancer_plsda.forest.svm"]],
     typeC = "tier",
     plotSubC = set.c)

## ----get_mds------------------------------------------------------------------
data("NCI60", package = "ropls")
nci.mds <- NCI60[["mds"]]

## ----mds_biosign, echo = TRUE, results = "hide"-------------------------------
# Restricting to the "agilent" and "hgu95" datasets
nci.mds <- nci.mds[, c("agilent", "hgu95")]
# Restricting to the 'ME' and 'LE' cancer types
library(Biobase)
sample_names.vc <- Biobase::sampleNames(nci.mds[["agilent"]])
cancer_type.vc <- Biobase::pData(nci.mds[["agilent"]])[, "cancer"]
nci.mds <- nci.mds[sample_names.vc[cancer_type.vc %in% c("ME", "LE")], ]
# Selecting the features
nci_cancer.biosign <- biosign(nci.mds, "cancer", bootI = 5)

## ----mds_getmset--------------------------------------------------------------
nci.mds <- getMset(nci_cancer.biosign)

## ----sacurine-----------------------------------------------------------------
data(sacurine)
sacSign <- biosign(sacurine[["dataMatrix"]],
sacurine[["sampleMetadata"]][, "gender"],
methodVc = "plsda")

## ----apple, warning = FALSE, message = FALSE----------------------------------
data(SpikePos)
group1Vi <- which(SpikePos[["classes"]] %in% c("control", "group1"))
appleMN <- SpikePos[["data"]][group1Vi, ]
spikeFc <- factor(SpikePos[["classes"]][group1Vi])
annotDF <- SpikePos[["annotation"]]
rownames(annotDF) <- colnames(appleMN)

## ----apple_pca----------------------------------------------------------------
apple.pca <- ropls::opls(appleMN, fig.pdfC = "none")
ropls::plot(apple.pca, parAsColFcVn = spikeFc)

## ----apple_pls----------------------------------------------------------------
apple.pls <- ropls::opls(appleMN, spikeFc)

## ----apple_biosign, warning = FALSE-------------------------------------------
appleSign <- biosign(appleMN, spikeFc)

## ----annotation---------------------------------------------------------------
annotDF <- SpikePos[["annotation"]]
rownames(annotDF) <- colnames(appleMN)
annotDF[getSignatureLs(appleSign)[["complete"]], c("adduct", "found.in.standards")]

## ----golub, warning = FALSE, message = FALSE----------------------------------
library(golubEsets)
data(Golub_Merge)
Golub_Merge
# restricting to the last 500 features
golub.eset <- Golub_Merge[1501:2000, ]
table(Biobase::pData(golub.eset)[, "ALL.AML"])
golubSign <- biosign(golub.eset, "ALL.AML", methodVc = "svm")

## ----hu6800, warning = FALSE, message = FALSE---------------------------------
library(hu6800.db)
sapply(getSignatureLs(golubSign)[["complete"]],
       function(probeC)
       get(probeC, env = hu6800GENENAME))

## ----empty, echo = FALSE------------------------------------------------------
rm(list = ls())

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

