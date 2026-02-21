# Code example from 'vignette_03_assessing_synteny' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# BiocManager::install("cogeqc")

## ----load_package, message = FALSE--------------------------------------------
# Load package after installation
library(cogeqc)
set.seed(123) # for reproducibility

## ----data_description---------------------------------------------------------
# Load synteny network for 
data(synnet)

head(synnet)

## ----assess_synnet------------------------------------------------------------
assess_synnet(synnet)

## ----assess_list--------------------------------------------------------------
# Simulate networks
net1 <- synnet
net2 <- synnet[-sample(1:10000, 500), ]
net3 <- synnet[-sample(1:10000, 1000), ]
synnet_list <- list(
  net1 = net1, 
  net2 = net2, 
  net3 = net3
)

# Assess original network + 2 simulations
synnet_assesment <- assess_synnet_list(synnet_list)
synnet_assesment

# Determine the best network
synnet_assesment$Network[which.max(synnet_assesment$Score)]

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

