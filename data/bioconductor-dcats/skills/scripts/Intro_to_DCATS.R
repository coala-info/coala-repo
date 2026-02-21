# Code example from 'Intro_to_DCATS' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(BiocStyle)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----warning=FALSE------------------------------------------------------------
library(DCATS)

## -----------------------------------------------------------------------------
set.seed(6171)
K <- 3
totals1 = c(100, 800, 1300, 600)
totals2 = c(250, 700, 1100)
diri_s1 = rep(1, K) * 20
diri_s2 = rep(1, K) * 20
simil_mat = create_simMat(K, confuse_rate=0.2)
sim_dat <- DCATS::simulator_base(totals1, totals2, diri_s1, diri_s2, simil_mat)

## -----------------------------------------------------------------------------
print(sim_dat$numb_cond1)
print(sim_dat$numb_cond2)

## -----------------------------------------------------------------------------
simil_mat = create_simMat(K = 3, confuse_rate = 0.2)
print(simil_mat)

## -----------------------------------------------------------------------------
data(simulation)
print(simulation$knnGraphs[1:10, 1:10])
head(simulation$labels, 10)
## estimate the knn matrix
knn_mat = knn_simMat(simulation$knnGraphs, simulation$labels)
print(knn_mat)

## -----------------------------------------------------------------------------
data(Kang2017)
head(Kang2017$svmDF)

## ----eval=FALSE---------------------------------------------------------------
# library(tidyverse)
# library(tidymodels)
# ## estimate the svm matrix
# svm_mat = svm_simMat(Kang2017$svmDF)
# print(svm_mat)

## ----echo=FALSE---------------------------------------------------------------
print(Kang2017$svm_mat)

## ----warning=FALSE------------------------------------------------------------
sim_count = rbind(sim_dat$numb_cond1, sim_dat$numb_cond2)
print(sim_count)
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"))
print(sim_design)
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat)

## ----warning=FALSE------------------------------------------------------------
## add another factor for testing
set.seed(123)
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"), 
                        gender = sample(c("Female", "Male"), 7, replace = TRUE))
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, base_model='FULL')

## ----warning=FALSE------------------------------------------------------------
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"))
phi = DCATS::getPhi(sim_count, sim_design)
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, fix_phi = phi)

## -----------------------------------------------------------------------------
colnames(sim_count) = c("A", "B", "C")
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = c("A", "B"))

## -----------------------------------------------------------------------------
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = c("A"))

## -----------------------------------------------------------------------------
reference_cell = detect_reference(sim_count, sim_design, similarity_mat = simil_mat)
print(reference_cell)
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = reference_cell$ordered_celltype[1:2])

## -----------------------------------------------------------------------------
sessionInfo()

