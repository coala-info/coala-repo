# Code example from 'vin1_Introduction_to_coMethDMR_geneBasedPipeline' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("coMethDMR")

## ----load_comethDMR, message=FALSE--------------------------------------------
library(coMethDMR)

## -----------------------------------------------------------------------------
data(betasChr22_df)
betasChr22_df[1:5, 1:5]

## -----------------------------------------------------------------------------
data(pheno_df)
head(pheno_df)

## -----------------------------------------------------------------------------
CpGisland_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)

## ----CoMethAllRegions---------------------------------------------------------
system.time(
  coMeth_ls <- CoMethAllRegions(
    dnam = betasChr22_df,
    betaToM = TRUE, # converts beta to m-values
    method = "pearson",
    CpGs_ls = CpGisland_ls,
    arrayType = "450k",
    returnAllCpGs = FALSE, 
    output = "CpGs",
    nCores_int = 1
  )
)
# ~15 seconds

coMeth_ls

## ----message=FALSE------------------------------------------------------------
WriteCorrPlot <- function(beta_mat){

  require(corrplot)
  require(coMethDMR)

  CpGs_char <- row.names(beta_mat)

  CpGsOrd_df <- OrderCpGsByLocation(
    CpGs_char, arrayType = c("450k"), output = "dataframe"
  )

  betaOrdered_mat <- t(beta_mat[CpGsOrd_df$cpg ,])

  corr <- cor(
    betaOrdered_mat, method = "spearman", use = "pairwise.complete.obs"
  )

  corrplot(corr, method = "number", number.cex = 1, tl.cex = 0.7)
}

# subsetting beta values to include only co-methylated probes
betas_df <- subset(
  betasChr22_df, 
  row.names(betasChr22_df) %in% coMeth_ls[[1]]
)

WriteCorrPlot(betas_df)

## ----lmmTestAllRegions_1------------------------------------------------------
out_df <- lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls,
  pheno_df,
  contPheno_char = "stage",
  covariates_char = NULL,
  modelType = "randCoef",
  arrayType = "450k"
  # generates a log file in the current directory
  # outLogFile = paste0("lmmLog_", Sys.Date(), ".txt")
)

out_df


## ----AnnotateResults, message = FALSE-----------------------------------------
system.time(
  outAnno_df <- AnnotateResults(
    lmmRes_df = out_df,
    arrayType = "450k"
  )
)
# ~12 seconds

outAnno_df

## ----CpGsInfoOneRegion--------------------------------------------------------
outCpGs_df <- CpGsInfoOneRegion(
 regionName_char = "chr22:18268062-18268249",
 betas_df = betasChr22_df,
 pheno_df = pheno_df,
 contPheno_char = "stage",
 covariates_char = NULL,
 arrayType = "450k"
)

outCpGs_df


## ----message = FALSE----------------------------------------------------------
# library("GenoGAM")
# NOTE 2022-03-28: what are we using this package for again?

## ----CpGsInfoOneRegion_2------------------------------------------------------
CpGsInfoOneRegion(
  regionName_char = "chr22:19709548-19709755",
  betas_df = betasChr22_df,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  covariates_char = NULL,
  arrayType = "450k"
)

## -----------------------------------------------------------------------------
gene_ls <- readRDS(
  system.file(
    "extdata",
    "450k_Gene_3_200.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)

## ----reduce_data--------------------------------------------------------------
Cgi_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)
betasChr22_df <-
  betasChr22_df[rownames(betasChr22_df) %in% unlist(Cgi_ls)[1:20], ]

## ----GetResiduals-------------------------------------------------------------
resid_mat <- GetResiduals(
  dnam = betasChr22_df,
  # converts to Mvalues for fitting linear model 
  betaToM = TRUE, 
  pheno_df = pheno_df,
  covariates_char = c("age.brain", "sex", "slide")
)

## ----CoMethAllRegions_2-------------------------------------------------------
Cgi_ls <- readRDS(
  system.file(
    "extdata",
    "CpGislandsChr22_ex.rds",
    package = 'coMethDMR',
    mustWork = TRUE
    )
)

coMeth_ls <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  method = "pearson",
  CpGs_ls = Cgi_ls[1],
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "CpGs"
)

coMeth_ls


## ----CoMethAllRegions_3-------------------------------------------------------
coMeth_ls <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  CpGs_ls = Cgi_ls[5],
  arrayType = "450k",
  returnAllCpGs = FALSE, 
  output = "CpGs"
)

coMeth_ls

## ----CoMethAllRegions_4-------------------------------------------------------
coMethData_df <- CoMethAllRegions(
  dnam = resid_mat,
  betaToM = FALSE,
  CpGs_ls = Cgi_ls[5],
  arrayType = "450k",
  returnAllCpGs = FALSE, 
  output = "dataframe"
) [[1]]

coMethData_df

## ----lmmTestAllRegions_2, message = FALSE-------------------------------------
lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls[1],
  pheno_df,
  contPheno_char = "stage",
  covariates_char = "age.brain",
  modelType = "randCoef",
  arrayType = "450k"
)

## -----------------------------------------------------------------------------
data(betasChr22_df)

## ----message = FALSE----------------------------------------------------------
# list probes for this gene
ARFGAP3_CpGs_char <- c(
  "cg00079563", "cg01029450", "cg02351223", "cg04527868", "cg09861871",
  "cg26529516", "cg00539564", "cg05288033", "cg09367092", "cg10648908",
  "cg14570855", "cg15656623", "cg23778094", "cg27120833"
)

# list probes located closely on this gene
gene3_200 <- CloseBySingleRegion(
  CpGs_char = ARFGAP3_CpGs_char,
  arrayType = "450k",
  maxGap = 200,
  minCpGs = 3
)
CpGsOrdered_ls <- lapply(
  gene3_200,
  OrderCpGsByLocation,
  arrayType = "450k",
  output = "dataframe"
)
names(gene3_200) <- lapply(CpGsOrdered_ls, NameRegion)

# List of regions
gene3_200

## ----find_and_test_regions----------------------------------------------------
# co-methlyated region within the gene
coMeth_ls <- CoMethAllRegions(
  dnam = betasChr22_df,
  betaToM = TRUE,
  method = "pearson",
  CpGs_ls = gene3_200,
  arrayType = "450k",
  returnAllCpGs = FALSE,
  output = "CpGs"
)

coMeth_ls 

# test the co-methylated regions within the gene
results <- lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls,
  pheno_df,
  contPheno_char = "stage",
  covariates_char = "age.brain",
  modelType = "randCoef",
  arrayType = "450k"
  # generates a log file in the current directory
  # outLogFile = paste0("lmmLog_", Sys.Date(), ".txt")
)

## -----------------------------------------------------------------------------
AnnotateResults(lmmRes_df = results, arrayType = "450k")

## -----------------------------------------------------------------------------
utils::sessionInfo()

