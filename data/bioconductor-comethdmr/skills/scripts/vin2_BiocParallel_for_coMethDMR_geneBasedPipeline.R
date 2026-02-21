# Code example from 'vin2_BiocParallel_for_coMethDMR_geneBasedPipeline' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("coMethDMR")

## ----packLoad, message=FALSE--------------------------------------------------
library(coMethDMR)
library(BiocParallel)

## ----ex_data------------------------------------------------------------------
data(betasChr22_df)

## -----------------------------------------------------------------------------
# Purge any probes or samples with excessive missing values
markCells_ls <- MarkMissing(dnaM_df = betasChr22_df)
betasChr22_df <- betasChr22_df[
  markCells_ls$keepProbes, 
  markCells_ls$keepSamples
]

# Inspect
betasChr22_df[1:5, 1:5]

## ----ex_pheno_data------------------------------------------------------------
data(pheno_df)
head(pheno_df)

## ----list_of_cgis-------------------------------------------------------------
closeByGeneAll_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)

## -----------------------------------------------------------------------------
closeByGeneAll_ls[1]

## -----------------------------------------------------------------------------
indx <- grep("chr22:", names(closeByGeneAll_ls))

closeByGene_ls <- closeByGeneAll_ls[indx]
rm(closeByGeneAll_ls)
length(closeByGene_ls)

## -----------------------------------------------------------------------------
closeByGene_ls[1:10]

## ----subset_betasChr22--------------------------------------------------------
keepCpGs_char <- unique(unlist(closeByGene_ls[1:10]))
betasChr22small_df <- 
  betasChr22_df[rownames(betasChr22_df) %in% keepCpGs_char, ]
dim(betasChr22small_df)

## ----results='hide'-----------------------------------------------------------
resid_mat <- GetResiduals(
  dnam = betasChr22small_df,
  # converts to Mvalues for fitting linear model
  betaToM = TRUE,  
  pheno_df = pheno_df,
  # Features in pheno_df used as covariates
  covariates_char = c("age.brain", "sex", "slide"),
  nCores_int = 2
)

## ----BiocParallel_Gene, message=FALSE-----------------------------------------
system.time(
  coMeth_ls <- CoMethAllRegions(
    dnam = resid_mat,
    betaToM = FALSE,
    method = "spearman",
    arrayType = "450k",
    CpGs_ls = closeByGene_ls[1:10],
    nCores_int = 2
  )
)
# Windows: NA
# Mac: ~14 seconds for 2 cores

## ----singleRegionType_lmmTest, warning=FALSE, results='hide', message = FALSE----
res_df <- lmmTestAllRegions(
  betas = betasChr22small_df,
  region_ls = coMeth_ls,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  covariates_char = c("age.brain", "sex"),
  modelType = "randCoef",
  arrayType = "450k",
  nCores_int = 2
  # outLogFile = "res_lmm_log.txt"
)

## -----------------------------------------------------------------------------
AnnotateResults(res_df)

## -----------------------------------------------------------------------------
closeByGene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)

closeByInterGene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_InterGene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
  )
)

# put them together in one list
closeBy_ls <- c(closeByInterGene_ls, closeByGene_ls)
length(closeBy_ls)
closeBy_ls[1:3]

## -----------------------------------------------------------------------------
utils::sessionInfo()

