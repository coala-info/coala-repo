# Code example from 'How_to_use_TDbasedUFEadv' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  crop = NULL,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(TDbasedUFEadv)
library(Biobase)
library(RTCGA.rnaseq)
library(TDbasedUFE)
library(MOFAdata)
library(TDbasedUFE)
library(RTCGA.clinical)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("TDbasedUFEadv")

## -----------------------------------------------------------------------------
Cancer_cell_lines <- list(ACC.rnaseq, BLCA.rnaseq, BRCA.rnaseq, CESC.rnaseq)
Drug_and_Disease <- prepareexpDrugandDisease(Cancer_cell_lines)
expDrug <- Drug_and_Disease$expDrug
expDisease <- Drug_and_Disease$expDisease
rm(Cancer_cell_lines)

## -----------------------------------------------------------------------------
Z <- prepareTensorfromMatrix(
  exprs(expDrug[seq_len(200), seq_len(100)]),
  exprs(expDisease[seq_len(200), seq_len(100)])
)
sample <- outer(
  colnames(expDrug)[seq_len(100)],
  colnames(expDisease)[seq_len(100)], function(x, y) {
    paste(x, y)
  }
)
Z <- PrepareSummarizedExperimentTensor(
  sample = sample, feature = rownames(expDrug)[seq_len(200)], value = Z
)

## -----------------------------------------------------------------------------
HOSVD <- computeHosvd(Z)

## -----------------------------------------------------------------------------
Cond <- prepareCondDrugandDisease(expDrug)
cond <- list(NULL, Cond[, colnames = "Cisplatin"][seq_len(100)], rep(1:2, each = 50))

## -----------------------------------------------------------------------------
input_all <- selectSingularValueVectorLarge(HOSVD,cond,input_all=c(2,9)) #Batch mode

## -----------------------------------------------------------------------------
index <- selectFeature(HOSVD,input_all,de=0.05)

## -----------------------------------------------------------------------------
head(tableFeatures(Z,index))

## -----------------------------------------------------------------------------
rm(Z)
rm(HOSVD)
detach("package:RTCGA.rnaseq")
rm(SVD)

## -----------------------------------------------------------------------------
SVD <- computeSVD(exprs(expDrug), exprs(expDisease))
Z <- t(exprs(expDrug)) %*% exprs(expDisease)
sample <- outer(
  colnames(expDrug), colnames(expDisease),
  function(x, y) {
    paste(x, y)
  }
)
Z <- PrepareSummarizedExperimentTensor(
  sample = sample,
  feature = rownames(expDrug), value = Z
)

## -----------------------------------------------------------------------------
cond <- list(NULL,Cond[,colnames="Cisplatin"],rep(1:2,each=dim(SVD$SVD$v)[1]/2))

## -----------------------------------------------------------------------------
index_all <- selectFeatureRect(SVD,cond,de=c(0.01,0.01),
                               input_all=3) #batch mode

## -----------------------------------------------------------------------------
head(tableFeatures(Z,index_all[[1]]))
head(tableFeatures(Z,index_all[[2]]))

## -----------------------------------------------------------------------------
table(index_all[[1]]$index,index_all[[2]]$index)

## -----------------------------------------------------------------------------
rm(Z)
rm(SVD)

## -----------------------------------------------------------------------------
data("CLL_data")
data("CLL_covariates")

## -----------------------------------------------------------------------------
Z <- prepareTensorfromMatrix(
  t(CLL_data$Drugs[seq_len(200), seq_len(50)]),
  t(CLL_data$Methylation[seq_len(200), seq_len(50)])
)
Z <- prepareTensorRect(
  sample = colnames(CLL_data$Drugs)[seq_len(50)],
  feature = list(
    Drugs = rownames(CLL_data$Drugs)[seq_len(200)],
    Methylatiion = rownames(CLL_data$Methylation)[seq_len(200)]
  ),
  sampleData = list(CLL_covariates$Gender[seq_len(50)]),
  value = Z
)

## -----------------------------------------------------------------------------
HOSVD <- computeHosvd(Z)

## -----------------------------------------------------------------------------
cond <- list(attr(Z,"sampleData")[[1]],NULL,NULL)

## -----------------------------------------------------------------------------
index_all <- selectFeatureTransRect(HOSVD,cond,de=c(0.01,0.01),
                                    input_all=8) #batch mode

## -----------------------------------------------------------------------------
head(tableFeaturesSquare(Z,index_all,1))
head(tableFeaturesSquare(Z,index_all,2))

## -----------------------------------------------------------------------------
SVD <- computeSVD(t(CLL_data$Drugs), t(CLL_data$Methylation))
Z <- CLL_data$Drugs %*% t(CLL_data$Methylation)
sample <- colnames(CLL_data$Methylation)
Z <- prepareTensorRect(
  sample = sample,
  feature = list(rownames(CLL_data$Drugs), rownames(CLL_data$Methylation)),
  value = array(NA, dim(Z)), sampleData = list(CLL_covariates[, 1])
)

## -----------------------------------------------------------------------------
cond <- list(NULL,attr(Z,"sampleData")[[1]],attr(Z,"sampleData")[[1]])

## -----------------------------------------------------------------------------
SVD <- transSVD(SVD)

## -----------------------------------------------------------------------------
index_all <- selectFeatureRect(SVD,cond,de=c(0.5,0.5),input_all=6) #batch mode

## -----------------------------------------------------------------------------
head(tableFeaturesSquare(Z,index_all,1))
head(tableFeaturesSquare(Z,index_all,2))

## -----------------------------------------------------------------------------
data("CLL_data")
data("CLL_covariates")
Z <- prepareTensorfromList(CLL_data, 10L)
Z <- PrepareSummarizedExperimentTensor(
  feature = character("1"),
  sample = array(colnames(CLL_data$Drugs), 1), value = Z,
  sampleData = list(CLL_covariates[, 1])
)

## -----------------------------------------------------------------------------
HOSVD <- computeHosvd(Z,scale=FALSE)

## -----------------------------------------------------------------------------
cond <- list(NULL,attr(Z,"sampleData")[[1]],seq_len(4))

## -----------------------------------------------------------------------------
input_all <- selectSingularValueVectorLarge(HOSVD,
  cond,
  input_all = c(12, 1)
) # batch mode

## -----------------------------------------------------------------------------
HOSVD$U[[1]] <- HOSVD$U[[2]]
index_all <- selectFeatureSquare(HOSVD, input_all, CLL_data,
  de = c(0.5, 0.1, 0.1, 1), interact = FALSE
) # Batch mode

## -----------------------------------------------------------------------------
for (id in c(1:4))
{
  attr(Z, "feature") <- rownames(CLL_data[[id]])
  print(tableFeatures(Z, index_all[[id]]))
}

## -----------------------------------------------------------------------------
library(RTCGA.rnaseq) #it must be here, not in the first chunk
Multi <- list(
  BLCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  BRCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  CESC.rnaseq[seq_len(100), 1 + seq_len(1000)],
  COAD.rnaseq[seq_len(100), 1 + seq_len(1000)]
)

## -----------------------------------------------------------------------------
Z <- prepareTensorfromList(Multi,10L)
Z <- aperm(Z,c(2,1,3))

## -----------------------------------------------------------------------------
Clinical <- list(BLCA.clinical, BRCA.clinical, CESC.clinical, COAD.clinical)
Multi_sample <- list(
  BLCA.rnaseq[seq_len(100), 1, drop = FALSE],
  BRCA.rnaseq[seq_len(100), 1, drop = FALSE],
  CESC.rnaseq[seq_len(100), 1, drop = FALSE],
  COAD.rnaseq[seq_len(100), 1, drop = FALSE]
)
# patient.stage_event.tnm_categories.pathologic_categories.pathologic_m
ID_column_of_Multi_sample <- c(770, 1482, 773, 791)
# patient.bcr_patient_barcode
ID_column_of_Clinical <- c(20, 20, 12, 14)
Z <- PrepareSummarizedExperimentTensor(
  feature = colnames(ACC.rnaseq)[1 + seq_len(1000)],
  sample = array("", 1), value = Z,
  sampleData = prepareCondTCGA(
    Multi_sample, Clinical,
    ID_column_of_Multi_sample, ID_column_of_Clinical
  )
)
HOSVD <- computeHosvd(Z)

## -----------------------------------------------------------------------------
cond<- attr(Z,"sampleData")

## -----------------------------------------------------------------------------
index <- selectFeatureProj(HOSVD,Multi,cond,de=1e-3,input_all=3) #Batch mode
head(tableFeatures(Z,index))

## -----------------------------------------------------------------------------
sessionInfo()

