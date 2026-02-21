# Code example from 'scMOSim' vignette. See references/ for full tutorial.

## ----installing, eval = FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MOSim")
# 
# # For the latest development version
# install.packages("devtools")
# devtools::install_github("ConesaLab/MOSim")
# 

## ----test_run, eval = FALSE---------------------------------------------------
# library(MOSim)
# 
# # Create a list of omics data types (e.g., scRNA-seq and scATAC-seq)
# omicsList <- sc_omicData(list("scRNA-seq", "scATAC-seq"),
#                          data = NULL)
# 
# # Define cell types for your experiment
# cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
#       'Memory_B' = c(31:40))
# 
# # Load an association list containing peak IDs related to gene names
# associationList <- data(associationList)
# 
# # Simulate multi-omics data with specific parameters
# testing_groups <- sc_mosim(
#   omicsList,
#   cell_types,
#   numberReps = 2,
#   numberGroups = 3,
#   diffGenes = list(c(0.2, 0.3), c(0.2, 0.3)),
#   minFC = 0.25,
#   maxFC = 4,
#   numberCells = NULL,
#   mean = NULL,
#   sd = NULL,
#   regulatorEffect = list(c(0.1, 0.2), c(0.1, 0.2), c(0.1, 0.2)),
#   associationList = associationList,
#   TF = FALSE
# )

## ----custom data, eval = FALSE------------------------------------------------
# # This is done to get a dataset to extract a matrix (for example purposes)
# scRNA <- MOSim::sc_omicData("scRNA-seq", data = NULL)
# count <- scRNA[["scRNA-seq"]]
# options(Seurat.object.assay.version = "v3")
# Seurat_obj <- Seurat::CreateAssayObject(counts = count, assay = 'RNA')
# # To format the data into sc_mosim-ready format, we pass the seurat
# # object containing the count data we extracted into sc_omicData
# omic_list_user <- sc_omicData(c("scRNA-seq"), data = c(Seurat_obj))

## ----default, eval = FALSE----------------------------------------------------
# omic_list <- sc_omicData(list("scRNA-seq"))
# cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
#       'Memory_B' = c(31:40))
# 
# sim <- sc_mosim(omic_list, cell_types, TF = TRUE)

## ----testing, eval = FALSE----------------------------------------------------
# omic_list <- sc_omicData(c("scRNA-seq", "scATAC-seq"))
# cell_types <- list('Treg' = c(1:10),'cDC' = c(11:20),'CD4_TEM' = c(21:30),
#       'Memory_B' = c(31:40))
# sim <- sc_mosim(omic_list, cell_types, numberReps = 2,
#                numberGroups = 2, diffGenes = list(c(0.2, 0.3)), feature_no = 8000,
#                clusters = 3, mean = c(2*10^6, 1*10^6,2*10^6, 1*10^6),
#                sd = c(5*10^5, 2*10^5, 5*10^5, 2*10^5),
#                regulatorEffect = list(c(0.1, 0.2), c(0.1, 0.2)), TF = FALSE)

## ----settings, eval = FALSE---------------------------------------------------
# settings <- sc_omicSettings(sim)

## ----settingsTF, eval = FALSE-------------------------------------------------
# settings <- sc_omicSettings(sim, TF = TRUE)

## ----results, eval = FALSE----------------------------------------------------
# res <- sc_omicResults(sim)

