# Code example from 'introduction_to_rnaEditr' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("rnaEditr")

## ----message=FALSE------------------------------------------------------------
library(rnaEditr)

## -----------------------------------------------------------------------------
data(rnaedit_df)

## -----------------------------------------------------------------------------
rnaedit_df[1:3, 1:3]

## -----------------------------------------------------------------------------
pheno_df <- readRDS(
  system.file(
    "extdata",
    "pheno_df.RDS",
    package = 'rnaEditr',
    mustWork = TRUE
  )
)

## -----------------------------------------------------------------------------
pheno_df[1:3, 1:3]

## -----------------------------------------------------------------------------
identical(pheno_df$sample, colnames(rnaedit_df))

## -----------------------------------------------------------------------------
rnaedit2_df <- CreateEditingTable(
  rnaEditMatrix = rnaedit_df
)

## -----------------------------------------------------------------------------
table(pheno_df$sample_type)

## ----results='hide'-----------------------------------------------------------
tumor_single_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function 
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = rnaedit2_df,
  # a phenotype dataset that must have variable "sample" whose values are a 
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to 
  #   test.
  responses_char = "sample_type",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "binary",
  # order the final results by p-values or not.
  orderByPval = TRUE
)

## -----------------------------------------------------------------------------
tumor_single_df[1:3, ]

## ----message=FALSE------------------------------------------------------------
tumor_annot_df <- AnnotateResults(
  # the output dataset from function TestAssociations().
  results_df = tumor_single_df,
  # close-by regions, since this is site-specific analysis, set to NULL.
  closeByRegions_gr = NULL,
  # input regions, since this is site-specific analysis, set to NULL.
  inputRegions_gr = NULL,
  genome = "hg19",
  # the type of analysis result from function TestAssociations(), since we are 
  #   running site-specific analysis, set to "site-specific".
  analysis = "site-specific"
)

## -----------------------------------------------------------------------------
tumor_annot_df[1:3, ]

## -----------------------------------------------------------------------------
allGenes_gr <- readRDS(
  system.file(
    "extdata",
    "hg19_annoGene_gr.RDS",
    package = 'rnaEditr',
    mustWork = TRUE
  )
)

## -----------------------------------------------------------------------------
allGenes_gr[1:3]

## -----------------------------------------------------------------------------
# If input is gene symbol
inputGenes_gr <- TransformToGR(
  # input a character vector of gene symbols
  genes_char = c("PHACTR4", "CCR5", "METTL7A"),
  # the type of "gene_char". As we input gene symbols above, set to "symbol"
  type = "symbol",
  genome = "hg19"
)

## -----------------------------------------------------------------------------
inputGenes_gr

## -----------------------------------------------------------------------------
# If input is region ranges
inputRegions_gr <- TransformToGR(
  # input a character vector of region ranges.
  genes_char = c("chr22:18555686-18573797", "chr22:36883233-36908148"),
  # the type of "gene_char". As we input region ranges above, set to "region".
  type = "region",
  genome = "hg19"
)

# Here we use AddMetaData() to find the gene symbols for inputRegions_gr.
AddMetaData(target_gr = inputRegions_gr, genome = "hg19")

## ----results="hide"-----------------------------------------------------------
closeByRegions_gr <- AllCloseByRegions(
  # a GRanges object of genomic regions retrieved or created in section 4.1.
  regions_gr = inputGenes_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  maxGap = 50,
  minSites = 3
)

## -----------------------------------------------------------------------------
closeByRegions_gr

## ----results="hide"-----------------------------------------------------------
closeByCoeditedRegions_gr <- AllCoeditedRegions(
  # a GRanges object of close-by regions created by AllCloseByRegions().
  regions_gr = closeByRegions_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  # type of output data.
  output = "GRanges",
  rDropThresh_num = 0.4,
  minPairCorr = 0.1,
  minSites = 3,
  # the method for computing correlations.
  method = "spearman",
  # When no co-edited regions are found in an input genomic region, you want to
  #   output the whole region (when set to TRUE) or NULL (when set to FALSE).
  returnAllSites = FALSE
)

## -----------------------------------------------------------------------------
closeByCoeditedRegions_gr

## ----fig.height=6, fig.width=6------------------------------------------------
PlotEditingCorrelations(
  region_gr = closeByCoeditedRegions_gr[1],
  rnaEditMatrix = rnaedit_df
)

## ----results='hide'-----------------------------------------------------------
summarizedRegions_df <- SummarizeAllRegions(
  # a GRanges object of close-by regions created by AllCoeditedRegions().
  regions_gr = closeByCoeditedRegions_gr,
  # an RNA editing matrix.
  rnaEditMatrix = rnaedit_df,
  # available methods: "MaxSites", "MeanSites", "MedianSites", and "PC1Sites".
  selectMethod = MedianSites
)

## -----------------------------------------------------------------------------
summarizedRegions_df[1:3, 1:5]

## ----results="hide"-----------------------------------------------------------
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function 
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a 
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to 
  #   test.
  responses_char = "sample_type",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "binary",
  # order the final results by p-values or not.
  orderByPval = TRUE
)

## -----------------------------------------------------------------------------
tumor_region_df[1:3, ]

## -----------------------------------------------------------------------------
tumor_annot_df <- AnnotateResults(
  # the output dataset from function TestAssociations().
  results_df = tumor_region_df,
  # close-by regions which is a output of AllCloseByRegions().
  closeByRegions_gr = closeByRegions_gr,
  # input regions, which are created in section 4.1.
  inputRegions_gr = inputGenes_gr,
  genome = "hg19",
  # the type of analysis result from function TestAssociations(), since we are 
  #   doing region-based analysis, use default here.
  analysis = "region-based"
)

## -----------------------------------------------------------------------------
tumor_annot_df[1:3, ]

## ----results="hide"-----------------------------------------------------------
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function 
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a 
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to 
  #   test.
  responses_char = "age_at_diagnosis",
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "continuous",
  # order the final results by p-values or not.
  orderByPval = TRUE
)

## -----------------------------------------------------------------------------
tumor_region_df[1:3, ]

## ----results="hide"-----------------------------------------------------------
tumor_region_df <- TestAssociations(
  # an RNA editing dataframe with special class "rnaEdit_df" from function
  #   CreateEditingTable() if site-specific analysis, from function 
  #   SummarizeAllRegions() if region-based analysis.
  rnaEdit_df = summarizedRegions_df,
  # a phenotype dataset that must have variable "sample" whose values are a 
  #   exact match to the colnames of "rnaEdit_df".
  pheno_df = pheno_df,
  # name of outcome variable in phenotype dataset "pheno_df" that you want to 
  #   test.
  responses_char = c("OS.time", "OS"),
  # names of covariate variables in phenotype dataset "pheno_df" that you want
  #   to add into the model.
  covariates_char = NULL,
  # type of outcome variable that you input in argument "responses_char".
  respType = "survival",
  # order the final results by p-values or not.
  orderByPval = TRUE
)

## -----------------------------------------------------------------------------
tumor_region_df[1:3, ]

## ----size = 'tiny'------------------------------------------------------------
sessionInfo()

