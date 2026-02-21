# Code example from 'NIMEB' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("MEB")

## -----------------------------------------------------------------------------
library(MEB)

## -----------------------------------------------------------------------------
data(sim_data_sp)
sim_data_sp

## -----------------------------------------------------------------------------
data(real_data_sp)
real_data_sp

## -----------------------------------------------------------------------------
data(sim_data_dsp)
sim_data_dsp

## -----------------------------------------------------------------------------
data(real_data_dsp)
real_data_dsp

## ----message = FALSE, warning = FALSE-----------------------------------------
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
data(sim_data_sp)
gamma <- seq(1e-06,5e-05,1e-06)
sim_model_sp <- NIMEB(countsTable=assay(sim_data_sp), train_id=1:1000, gamma,
nu = 0.01, reject_rate = 0.05, ds = FALSE)

## -----------------------------------------------------------------------------
data(real_data_sp)
gamma <- seq(1e-06,5e-05,1e-06)
real_model_sp <- NIMEB(countsTable=assay(real_data_sp), train_id=1:530,
gamma, nu = 0.01, reject_rate = 0.1, ds = FALSE)

## -----------------------------------------------------------------------------
data(sim_data_dsp)
gamma <- seq(1e-07,2e-05,1e-06)
sim_model_dsp <- NIMEB(countsTable=assay(sim_data_dsp), train_id=1:1000, gamma,
nu = 0.01, reject_rate = 0.1, ds = TRUE)

## -----------------------------------------------------------------------------
data(real_data_dsp)
gamma <- seq(5e-08,5e-07,1e-08)
real_model_dsp <- NIMEB(countsTable=assay(real_data_dsp), train_id=1:143, 
                        gamma, nu = 0.01, reject_rate = 0.1, ds = TRUE)

## -----------------------------------------------------------------------------
sim_model_sp_pred <- predict(sim_model_sp$model, assay(sim_data_sp))
summary(sim_model_sp_pred)

## ----message = FALSE, warning = FALSE-----------------------------------------
library(SingleCellExperiment)

## -----------------------------------------------------------------------------
data(sim_scRNA_data)
sim_scRNA_data

## -----------------------------------------------------------------------------
data(stable_gene)
head(stable_gene)
length(stable_gene)

## -----------------------------------------------------------------------------
sim_scRNA <- scMEB(sce=sim_scRNA_data, stable_idx=stable_gene, 
filtered = TRUE, gamma = seq(1e-04,0.001,1e-05), nu = 0.01, 
reject_rate = 0.1)

## -----------------------------------------------------------------------------
sim_scRNA_pred <- predict(sim_scRNA$model, sim_scRNA$dat_pca)
summary(sim_scRNA_pred)

## -----------------------------------------------------------------------------
table(sim_scRNA$dist>0)

## -----------------------------------------------------------------------------
sim_scRNA_dist <- data.frame(Gene=rownames(sim_scRNA_data),
                             Distance=sim_scRNA$dist)
head(sim_scRNA_dist)

## -----------------------------------------------------------------------------
sessionInfo()

