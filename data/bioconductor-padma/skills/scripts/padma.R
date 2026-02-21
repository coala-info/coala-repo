# Code example from 'padma' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.align = "center", out.width = "50%", echo=FALSE----------------------
knitr::include_graphics("hex_padma_v2.png")

## ----message = FALSE----------------------------------------------------------
library(padma)

## ----eval = FALSE-------------------------------------------------------------
# run_padma <-
#   padma(mae, pathway_name = "c2_cp_BIOCARTA_D4GDI_PATHWAY")

## ----eval = FALSE-------------------------------------------------------------
# assay(run_padma)
# 
# factorMap(run_padma)
# factorMap(run_padma, partial_id = "TCGA-78-7536")
# omicsContrib(run_padma)

## ----explore_LUAD_subset------------------------------------------------------
names(LUAD_subset)

lapply(LUAD_subset, class)

lapply(LUAD_subset, dim)

## ----msigdb-------------------------------------------------------------------
head(msigdb)

## -----------------------------------------------------------------------------
head(mirtarbase)

## -----------------------------------------------------------------------------
library(MultiAssayExperiment)

LUAD_subset <- padma::LUAD_subset
omics_data <- 
  list(rnaseq = as.matrix(LUAD_subset$rnaseq),
       methyl = as.matrix(LUAD_subset$methyl),
       mirna = as.matrix(LUAD_subset$mirna),
       cna = as.matrix(LUAD_subset$cna))
pheno_data <- 
  data.frame(LUAD_subset$clinical, 
             row.names = LUAD_subset$clinical$bcr_patient_barcode)

mae <-
  suppressMessages(
    MultiAssayExperiment::MultiAssayExperiment(
      experiments = omics_data, 
      colData = pheno_data))

## ----runpadma-----------------------------------------------------------------
D4GDI <- msigdb[grep("D4GDI", msigdb$geneset), "geneset"]
run_padma <- 
  padma(mae, pathway_name = D4GDI, verbose = FALSE)

## ----runpadmalist-------------------------------------------------------------
clinical_data <- data.frame(LUAD_subset$clinical)
rownames(clinical_data) <- clinical_data$bcr_patient_barcode

run_padma_list <- 
  padma(omics_data,
        colData = clinical_data,
        pathway_name = D4GDI,
        verbose = FALSE)

## ----runpadma2----------------------------------------------------------------
D4GDI_genes <- unlist(strsplit(
  msigdb[grep("D4GDI", msigdb$geneset), "symbol"], ", "))
D4GDI_genes

run_padma_again <- 
  padma(mae, pathway_name = D4GDI_genes, verbose = FALSE)

## ----factorMAP----------------------------------------------------------------
factorMap(run_padma, dim_x = 1, dim_y = 2)

## ----factorMAP2---------------------------------------------------------------
factorMap(run_padma, dim_x = 1, dim_y = 2, ggplot = FALSE)

## ----factorMappartial---------------------------------------------------------
factorMap(run_padma,
           partial_id = "TCGA-78-7536",
           dim_x = 1, dim_y = 2)

## ----factorMappartial2--------------------------------------------------------
factorMap(run_padma,
           partial_id = "TCGA-78-7536",
           dim_x = 1, dim_y = 2, ggplot = FALSE)

## ----omicscontrib-------------------------------------------------------------
omicsContrib(run_padma, max_dim = 10)

## ----omicscontrib2------------------------------------------------------------
omicsContrib(run_padma, max_dim = 10, ggplot = FALSE)

## -----------------------------------------------------------------------------
run_padma_supp <- 
  padma(mae, pathway_name = D4GDI, verbose = FALSE,
        base_ids = sampleMap(mae)$primary[1:10],
        supp_ids = sampleMap(mae)$primary[15:20])

## -----------------------------------------------------------------------------
run_padma_impute <- 
  padma(mae, pathway_name = D4GDI, 
        impute = TRUE, verbose = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# run_padma_concise <-
#   padma(mae, pathway_name = D4GDI, full_results = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

