# Code example from 'miRspongeR' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(tidy = FALSE,
    warning = FALSE,
    message = FALSE)

## ----echo=FALSE, results='hide', message=FALSE--------------------------------
library(miRspongeR)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt_original <- spongeMethod(miRTarget, method = "miRHomology")
miRHomologyceRInt_parallel <- spongeMethod(miRTarget, method = "miRHomology_parallel")
head(miRHomologyceRInt_original)
head(miRHomologyceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
pcceRInt_original <- spongeMethod(miRTarget, ExpData, method = "pc")
pcceRInt_parallel <- spongeMethod(miRTarget, ExpData, method = "pc_parallel")
head(pcceRInt_original)
head(pcceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
sppcceRInt_original <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
sppcceRInt_parallel <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc_parallel")
head(sppcceRInt_original)
head(sppcceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
hermesceRInt_original <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes")
hermesceRInt_parallel <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes_parallel")
head(hermesceRInt_original)
head(hermesceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
ppcceRInt_original <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc")
ppcceRInt_parallel <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc_parallel")
head(ppcceRInt_original)
head(ppcceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRspongeR")
mres <- read.csv(MREs, header=TRUE, sep=",")
muTaMEceRInt_original <- spongeMethod(miRTarget, mres = mres, method = "muTaME")
muTaMEceRInt_parallel <- spongeMethod(miRTarget, mres = mres, method = "muTaME_parallel")
head(muTaMEceRInt_original)
head(muTaMEceRInt_parallel)

## ----eval=FALSE---------------------------------------------------------------
# miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
# miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
# MREs <- system.file("extdata", "MREs.csv", package="miRspongeR")
# mres <- read.csv(MREs, header=TRUE, sep=",")
# ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
# ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
# cerniaceRInt_original <- spongeMethod(miRTarget, ExpData, mres, method = "cernia")
# cerniaceRInt_parallel <- spongeMethod(miRTarget, ExpData, mres, method = "cernia_parallel")
# head(cerniaceRInt_original)
# head(cerniaceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
null_model_file <- system.file("extdata", "precomputed_null_model.rda", package="miRspongeR")
load(null_model_file)
spongeceRInt_parallel <- spongeMethod(miRTarget, ExpData, padjustvaluecutoff = 0.05, senscorcutoff = 0.1, null_model = precomputed_null_model, method = "sponge_parallel")
head(spongeceRInt_parallel)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
sppcceRInt <- spongeMethod(miRTarget, ExpData, method = "sppc")
Interlist <- list(miRHomologyceRInt[, 1:2], pcceRInt[, 1:2], sppcceRInt[, 1:2])
IntegrateceRInt <- integrateMethod(Interlist, Intersect_num = 2)
head(IntegrateceRInt)

## -----------------------------------------------------------------------------
ExpDatacsv <- system.file("extdata","ExpData.csv",package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
sponge_sample_specific_net <- sponge_sample_specific(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
head(sponge_sample_specific_net[[1]])

## -----------------------------------------------------------------------------
ExpDatacsv <- system.file("extdata","ExpData.csv",package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
sponge_sample_specific_net <- sponge_sample_specific(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
sample_cor_network_res <- sample_cor_network(sponge_sample_specific_net, genes_num = 31, padjustvaluecutoff = 0.05)
head(sample_cor_network_res)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
Groundtruthcsv <- system.file("extdata", "Groundtruth.csv", package="miRspongeR")
Groundtruth <- read.csv(Groundtruthcsv, header=TRUE, sep=",")
spongenetwork_validated <- spongeValidate(miRHomologyceRInt[, 1:2], directed = FALSE, Groundtruth)
spongenetwork_validated

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
spongenetwork_Cluster

## ----eval=FALSE, include=TRUE-------------------------------------------------
# miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
# miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
# miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
# spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
# sponge_Module_DEA <- moduleDEA(spongenetwork_Cluster)
# sponge_Module_FEA <- moduleFEA(spongenetwork_Cluster)

## -----------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRspongeR")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRspongeR")
ExpData <- read.csv(ExpDatacsv, header=TRUE, sep=",")
SurvDatacsv <- system.file("extdata", "SurvData.csv", package="miRspongeR")
SurvData <- read.csv(SurvDatacsv, header=TRUE, sep=",")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
spongenetwork_Cluster <- netModule(pcceRInt[, 1:2], modulesize = 2)
sponge_Module_Survival <- moduleSurvival(spongenetwork_Cluster, 
    ExpData, SurvData, devidePercentage=.5)
sponge_Module_Survival

## -----------------------------------------------------------------------------
sessionInfo()

