# Code example from 'crisprScoreData' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version="devel")
# BiocManager::install("crisprScoreData")

## -----------------------------------------------------------------------------
library(crisprScoreData)

## -----------------------------------------------------------------------------
# For DeepHF model:
DeepWt.hdf5()
DeepWt_T7.hdf5()
DeepWt_U6.hdf5()
esp_rnn_model.hdf5()
hf_rnn_model.hdf5()

# For Lindel model:
Model_weights.pkl()

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
query(eh, "crisprScoreData")
eh[["EH6127"]]

## -----------------------------------------------------------------------------
sessionInfo()

