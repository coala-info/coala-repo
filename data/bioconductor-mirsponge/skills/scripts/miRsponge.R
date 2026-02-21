# Code example from 'miRsponge' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE----------------------
BiocStyle::markdown()
knitr::opts_chunk$set(tidy = FALSE,
    warning = FALSE,
    message = FALSE)

## ----echo=FALSE, results='hide', message=FALSE-----------------------------
library(miRsponge)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
head(miRHomologyceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
head(pcceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
sppcceRInt <- spongeMethod(miRTarget, ExpData, senscorcutoff = 0.1, method = "sppc")
head(sppcceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
hermesceRInt <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "hermes")
head(hermesceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
ppcceRInt <- spongeMethod(miRTarget, ExpData, num_perm = 10, method = "ppc")
head(ppcceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRsponge")
mres <- read.csv(MREs, header=TRUE, sep=",")
muTaMEceRInt <- spongeMethod(miRTarget, mres = mres, method = "muTaME")
head(muTaMEceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
MREs <- system.file("extdata", "MREs.csv", package="miRsponge")
mres <- read.csv(MREs, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
cerniaceRInt <- spongeMethod(miRTarget, ExpData, mres, method = "cernia")
head(cerniaceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
sppcceRInt <- spongeMethod(miRTarget, ExpData, method = "sppc")
Interlist <- list(miRHomologyceRInt[, 1:2], pcceRInt[, 1:2], sppcceRInt[, 1:2])
IntegrateceRInt <- integrateMethod(Interlist, Intersect_num = 2)
head(IntegrateceRInt)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
Groundtruthcsv <- system.file("extdata", "Groundtruth.csv", package="miRsponge")
Groundtruth <- read.csv(Groundtruthcsv, header=TRUE, sep=",")
spongenetwork_validated <- spongeValidate(miRHomologyceRInt[, 1:2], directed = FALSE, Groundtruth)
spongenetwork_validated

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
spongenetwork_Cluster

## ---- eval=FALSE, include=TRUE---------------------------------------------
#  miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
#  miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
#  miRHomologyceRInt <- spongeMethod(miRTarget, method = "miRHomology")
#  spongenetwork_Cluster <- netModule(miRHomologyceRInt[, 1:2], modulesize = 2)
#  sponge_Module_DEA <- moduleDEA(spongenetwork_Cluster)
#  sponge_Module_FEA <- moduleFEA(spongenetwork_Cluster)

## --------------------------------------------------------------------------
miR2Target <- system.file("extdata", "miR2Target.csv", package="miRsponge")
miRTarget <- read.csv(miR2Target, header=TRUE, sep=",")
ExpDatacsv <- system.file("extdata", "ExpData.csv", package="miRsponge")
ExpData <- read.csv(ExpDatacsv, header=FALSE, sep=",")
SurvDatacsv <- system.file("extdata", "SurvData.csv", package="miRsponge")
SurvData <- read.csv(SurvDatacsv, header=TRUE, sep=",")
pcceRInt <- spongeMethod(miRTarget, ExpData, method = "pc")
spongenetwork_Cluster <- netModule(pcceRInt[, 1:2], modulesize = 2)
sponge_Module_Survival <- moduleSurvival(spongenetwork_Cluster, 
    ExpData, SurvData, devidePercentage=.5)
sponge_Module_Survival

## --------------------------------------------------------------------------
sessionInfo()

