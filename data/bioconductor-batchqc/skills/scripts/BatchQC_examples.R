# Code example from 'BatchQC_examples' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(BatchQC)
data(protein_data)
data(protein_sample_info)
se_object <- BatchQC::summarized_experiment(protein_data, protein_sample_info)

## -----------------------------------------------------------------------------
data(signature_data)
data(batch_indicator)
se_object <- BatchQC::summarized_experiment(signature_data, batch_indicator)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("bladderbatch", quietly = TRUE))
#     BiocManager::install("bladderbatch")
# se_object <- BatchQC::bladder_data_upload()

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("curatedTBData", quietly = TRUE))
#     BiocManager::install("curatedTBData")
# se_object <- BatchQC::tb_data_upload()

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

