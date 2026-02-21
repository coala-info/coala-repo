# Code example from 'tutorial' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # install from bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("cosmosR")
# 
# 
# # install the newest (development) version from GitHub
# # install.packages("remotes")
# # install CARNIVAL from github
# remotes::install_github("saezlab/CARNIVAL")
# remotes::install_github("saezlab/cosmosR")

## ----warning=FALSE, message=FALSE---------------------------------------------
library(cosmosR)

## ----warning=FALSE, message=FALSE---------------------------------------------
CARNIVAL_options <- default_CARNIVAL_options(solver = "lpSolve")

# To use CBC
# CARNIVAL_options <- default_CARNIVAL_options(solver = "cbc")
# CARNIVAL_options$solverPath <- "~/Documents/cbc"
# CARNIVAL_options$threads <- 2
# CARNIVAL_options$mipGAP <- 0.05

# To use CPLEX:
# CARNIVAL_options <- default_CARNIVAL_options(solver = "cplex")
# CARNIVAL_options$solverPath <- "C:/Program Files/CPLEX_solver/cplex/bin/x64_win64/cplex.exe"
# CARNIVAL_options$threads <- 2
# CARNIVAL_options$mipGAP <- 0.05


CARNIVAL_options$timelimit <- 3600


## ----warning=FALSE, message=FALSE---------------------------------------------
data(toy_network)
data(toy_signaling_input)
data(toy_metabolic_input)
data(toy_RNA)
test_for <- preprocess_COSMOS_signaling_to_metabolism(meta_network = toy_network,
                                        signaling_data = toy_signaling_input,
                                        metabolic_data = toy_metabolic_input,
                                                      diff_expression_data = toy_RNA,
                                                      maximum_network_depth = 15,
                                                      remove_unexpressed_nodes = TRUE,
                                                      CARNIVAL_options = CARNIVAL_options)

## ----warning=FALSE, message=FALSE---------------------------------------------
CARNIVAL_options$timelimit <- 14400
CARNIVAL_options$mipGAP <- 0.05
CARNIVAL_options$threads <- 2

## ----warning=FALSE, message=FALSE---------------------------------------------
test_result_for <- run_COSMOS_signaling_to_metabolism(data = test_for,
                                                      CARNIVAL_options = CARNIVAL_options)

## ----warning=FALSE, message=FALSE---------------------------------------------
formated_result_for <- format_COSMOS_res(test_result_for)

## ----warning=FALSE, message=FALSE---------------------------------------------
CARNIVAL_options$timelimit <- 3600
CARNIVAL_options$mipGAP <- 0.05
CARNIVAL_options$threads <- 2

## ----warning=FALSE, message=FALSE---------------------------------------------
test_back <- preprocess_COSMOS_metabolism_to_signaling(meta_network = toy_network,
                                        signaling_data = toy_signaling_input,
                                        metabolic_data = toy_metabolic_input,
                                                       diff_expression_data = toy_RNA,
                                                       maximum_network_depth = 15,
                                                       remove_unexpressed_nodes = FALSE,
                                                       CARNIVAL_options = CARNIVAL_options)


## ----warning=FALSE, message=FALSE---------------------------------------------
CARNIVAL_options$timelimit <- 28800

test_result_back <- run_COSMOS_metabolism_to_signaling(data = test_back,
                                                       CARNIVAL_options = CARNIVAL_options)

## ----warning=FALSE, message=FALSE---------------------------------------------
formated_result_back <- format_COSMOS_res(test_result_back)

## ----warning=FALSE, message=FALSE---------------------------------------------
full_sif <- as.data.frame(rbind(formated_result_for[[1]], formated_result_back[[1]]))
full_sif <- full_sif[full_sif$Weight>0,]
full_attributes <- as.data.frame(rbind(formated_result_for[[2]], formated_result_back[[2]]))

full_sif <- unique(full_sif)
full_attributes <- unique(full_attributes)

## ----warning=FALSE, message=FALSE---------------------------------------------
network_plot <- display_node_neighboorhood(central_node = 'Metab__D-Glucitol_c', 
                                           sif = full_sif, 
                                           att = full_attributes, 
                                           n = 7)

network_plot

## ----warning=FALSE, message=FALSE---------------------------------------------
sif_forward = formated_result_for[[1]]
att_forward = formated_result_for[[2]]
nodes_ORA = extract_nodes_for_ORA(
    sif = sif_forward, 
    att = att_forward)

## ----warning=FALSE, message=FALSE---------------------------------------------
sessionInfo()

