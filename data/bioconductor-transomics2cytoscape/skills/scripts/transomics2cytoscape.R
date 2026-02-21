# Code example from 'transomics2cytoscape' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
    eval=FALSE
)

## ----setup--------------------------------------------------------------------
# # suppressPackageStartupMessages(library(dplyr))
# # suppressPackageStartupMessages(library(RCy3))
# # suppressPackageStartupMessages(library(KEGGREST))
# # Sys.setenv(LANGUAGE="en_US.UTF-8")
# library(transomics2cytoscape)
# networkDataDir <- tempfile(); dir.create(networkDataDir)
# 
# networkLayers <- system.file("extdata/usecase1", "yugi2014.tsv",
#                             package = "transomics2cytoscape")
# stylexml <- system.file("extdata/usecase1", "yugi2014.xml",
#                             package = "transomics2cytoscape")
# suid <- create3Dnetwork(networkDataDir, networkLayers, stylexml)
# 
# layer1to2 <- system.file("extdata/usecase1", "k2e.tsv",
#                             package = "transomics2cytoscape")
# suid <- createTransomicEdges(suid, layer1to2)
# 
# layer3to2 <- system.file("extdata/usecase1", "allosteric_ecnumber.tsv",
#                             package = "transomics2cytoscape")
# ec2reaction(layer3to2, 6, "allosteric_ec2rea.tsv")
# suid <- createTransomicEdges(suid, "allosteric_ec2rea.tsv")

## -----------------------------------------------------------------------------
# ecnum <- system.file("extdata", "allosteric_ecnumber.tsv",
#     package = "transomics2cytoscape")
# ec2reaction(ecnum, 6, "allosteric_ec2rea.tsv")

## -----------------------------------------------------------------------------
# networkDataDir <- tempfile(); dir.create(networkDataDir)
# tfs <- system.file("extdata/usecase2", "TFs.sif",
#                             package = "transomics2cytoscape")
# file.copy(tfs, networkDataDir)
# networkLayers <- system.file("extdata/usecase2", "kokaji2020.tsv",
#                             package = "transomics2cytoscape")
# stylexml <- system.file("extdata/usecase2", "Kokaji2020styles.xml",
#                             package = "transomics2cytoscape")
# suid <- create3Dnetwork(networkDataDir, networkLayers, stylexml)
# 
# layer1to2 <- system.file("extdata/usecase2", "s2t_name_updated.tsv",
#                             package = "transomics2cytoscape")
# suid <- createTransomicEdges(suid, layer1to2)
# 
# layer2to3 <- system.file("extdata/usecase2", "t2e_name_updated.tsv",
#                             package = "transomics2cytoscape")
# suid <- createTransomicEdges(suid, layer2to3)
# 
# layer3to4 <- system.file("extdata/usecase2", "e2r_updated.tsv",
#                             package = "transomics2cytoscape")
# ec2reaction(layer3to4, 6, "e2r_updated_ec2rea.tsv")
# suid <- createTransomicEdges(suid, "e2r_updated_ec2rea.tsv")
# 
# layer5to4 <- system.file("extdata/usecase2", "m2r_updated.tsv",
#                             package = "transomics2cytoscape")
# ec2reaction(layer5to4, 6, "m2r_updated_ec2rea.tsv")
# suid <- createTransomicEdges(suid, "m2r_updated_ec2rea.tsv")

## -----------------------------------------------------------------------------
# sessionInfo()

