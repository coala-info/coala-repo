# Code example from 'mastR_customized_design' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 5
)

## ----installation, eval=FALSE-------------------------------------------------
# # if (!requireNamespace("devtools", quietly = TRUE)) {
# #   install.packages("devtools")
# # }
# # if (!requireNamespace("mastR", quietly = TRUE)) {
# #   devtools::install_github("DavisLaboratory/mastR")
# # }
# 
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# if (!requireNamespace("mastR", quietly = TRUE)) {
#   BiocManager::install("mastR")
# }
# packages <- c(
#   "BiocStyle",
#   "clusterProfiler",
#   "ComplexHeatmap",
#   "depmap",
#   "enrichplot",
#   "ggrepel",
#   "Glimma",
#   "gridExtra",
#   "jsonlite",
#   "knitr",
#   "rmarkdown",
#   "RobustRankAggreg",
#   "rvest",
#   "singscore",
#   "UpSetR"
# )
# for (i in packages) {
#   if (!requireNamespace(i, quietly = TRUE)) {
#     install.packages(i)
#   }
#   if (!requireNamespace(i, quietly = TRUE)) {
#     BiocManager::install(i)
#   }
# }

## ----lib, message=FALSE-------------------------------------------------------
library(mastR)
library(edgeR)
library(ggplot2)
library(GSEABase)

## ----im_data_6----------------------------------------------------------------
data("im_data_6")
im_data_6

## ----customized contrast matrix-----------------------------------------------
## DE of NK vs B and B vs T
con_mat <- makeContrasts(
  'NK-CD4' = 'NK - CD4',
  'NK-T' = 'NK - (CD4 + CD8)/2',
  levels = levels(factor(make.names(im_data_6$`celltype:ch1`)))
)
con_mat

## ----customized contrast matrix from design matrix----------------------------
proc_data <- mastR::process_data(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  summary = FALSE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
con_mat2 <- makeContrasts(
  'NK-CD4' = 'NK - CD4',
  'NK-T' = 'NK - (CD4 + CD8)/2',
  levels = proc_data$vfit$design
)
con_mat2

identical(con_mat, con_mat2)

## ----process data-------------------------------------------------------------
proc_data <- mastR::process_data(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  contrast_mat = con_mat, ## specify contrast of NK vs B and B vs T
  summary = TRUE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)

## plot mean-var
mastR::plot_mean_var(proc_data)

## ----DE results---------------------------------------------------------------
## contrast names
colnames(proc_data$tfit)

## DE results for 'NK-B' contrast
na.omit(limma::topTreat(
  proc_data$tfit,
  coef = 1, # or 'NK-B' for the first contrast
  number = Inf # get all DE results
)) |> head()

## ----DE results from proc_data------------------------------------------------
## DE results for all contrasts
DE_table <- mastR::get_de_table(
  im_data_6,
  group_col = 'celltype:ch1',
  target_group = 'NK',
  contrast_mat = con_mat, ## specify contrast of NK vs B and B vs T
  summary = TRUE,
  gene_id = "ENSEMBL" ## rownames of im_data_6 is ENSEMBL ID
)
names(DE_table)

head(DE_table[[1]])

## ----visualization, eval=FALSE------------------------------------------------
# ## MDS plot
# Glimma::glimmaMDS(proc_data)
# 
# ## MA plot
# Glimma::glimmaMA(proc_data$tfit, dge = proc_data)
# 
# ## volcano plot
# Glimma::glimmaVolcano(proc_data$tfit, dge = proc_data)
# 

## ----session info-------------------------------------------------------------
sessionInfo()

