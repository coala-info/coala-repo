# Code example from 'celarefData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh = ExperimentHub()
ExperimentHub::listResources(eh, "celarefData")

de_table.10X_pbmc4k_k7        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_10X_pbmc4k_k7')[[1]]
de_table.Watkins2009PBMCs     <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Watkins2009_pbmcs')[[1]]
de_table.zeisel.cortex        <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_cortex')[[1]]
de_table.zeisel.hippo         <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zeisel2015_hc')[[1]]
de_table.Farmer2017lacrimalP4 <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Farmer2017_lacrimalP4')[[1]]

de_table.Zheng2017purePBMC         <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zheng2017purePBMC')[[1]]
de_table.Zheng2017purePBMC_ensembl <- ExperimentHub::loadResources(eh, "celarefData", 'de_table_Zheng2017purePBMC_ensembl')[[1]]

head(de_table.10X_pbmc4k_k7)

