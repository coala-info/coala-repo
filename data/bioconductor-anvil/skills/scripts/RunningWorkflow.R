# Code example from 'RunningWorkflow' vignette. See references/ for full tutorial.

## ----include = FALSE-----------------------------------------------------
has_gcloud <- AnVILBase::has_avworkspace(
    strict = TRUE, platform = AnVILGCP::gcp()
)
knitr::opts_chunk$set(
    eval =  has_gcloud, collapse = TRUE, cache = TRUE
)
options(width=75)

## ----eval = FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager", repos = "https://cran.r-project.org")
# BiocManager::install("AnVIL")

## ----message = FALSE, eval = TRUE, cache = FALSE-------------------------
library(AnVILGCP)
library(AnVIL)

## ----workspace, eval = has_gcloud----------------------------------------
# avworkspace("bioconductor-rpci-anvil/Bioconductor-Workflow-DESeq2")

## ----workflows, eval = has_gcloud----------------------------------------
# avworkflows()

## ----workflow, eval = has_gcloud-----------------------------------------
# avworkflow("bioconductor-rpci-anvil/AnVILBulkRNASeq")

## ----configuration, eval = has_gcloud------------------------------------
# config <- avworkflow_configuration_get()
# config

## ----inputs_outputs, eval = has_gcloud-----------------------------------
# inputs <- avworkflow_configuration_inputs(config)
# inputs
# 
# outputs <- avworkflow_configuration_outputs(config)
# outputs

## ----change_input, eval = has_gcloud-------------------------------------
# inputs <-
#     inputs |>
#     mutate(
#         attribute = ifelse(
#             name == "salmon.transcriptome_index_name",
#             '"new_index_name"',
#             attribute
#         )
#     )
# inputs

## ----update_config, eval = has_gcloud------------------------------------
# new_config <- avworkflow_configuration_update(config, inputs)
# new_config

## ----set_config, eval = has_gcloud---------------------------------------
# avworkflow_configuration_set(new_config)

## ----set_config_not_dry--------------------------------------------------
# ## avworkflow_configuration_set(new_config, dry = FALSE)

## ----entityName, eval = has_gcloud---------------------------------------
# entityName <- avtable("participant_set") |>
#     pull(participant_set_id) |>
#     head(1)
# avworkflow_run(new_config, entityName)

## ----run_not_dry---------------------------------------------------------
# ## avworkflow_run(new_config, entityName, dry = FALSE)

## ----checking_workflow, eval = has_gcloud--------------------------------
# avworkflow_jobs()

## ----stop_workflow, eval = has_gcloud------------------------------------
# avworkflow_stop() # dry = FALSE to stop
# 
# avworkflow_jobs()

## ----files, eval = has_gcloud--------------------------------------------
# submissionId <- "fb8e35b7-df5d-49e6-affa-9893aaeebf37"
# avworkflow_files(submissionId)

## ----localize, eval = has_gcloud-----------------------------------------
# avworkflow_localize(
#     submissionId,
#     type = "output"
#     ## dry = FALSE to localize
# )

## ----eval = FALSE--------------------------------------------------------
# avworkspace("bioconductor-rpci-yubo/Rcollectlworkflowh5ad")
# submissionId <- "9385fd75-4cb7-470f-9e07-1979e2c8f193"
# info_1 <- avworkflow_info(submissionId)

## ----message=FALSE, warning=FALSE----------------------------------------
# info_file_1 <-
#     system.file(package = "AnVIL", "extdata", "avworkflow_info_1.rds")
# info_1 <- readRDS(info_file_1)
# 
# ## view result of avworkflow_info()
# info_1

## ------------------------------------------------------------------------
# info_1 |>
#     select(workflowId, status, inputs, outputs)

## ------------------------------------------------------------------------
# info_1 |>
#     select(workflowId, status, inputs) |>
#     tidyr::unnest_wider(inputs)

## ------------------------------------------------------------------------
# info_1 |>
#     select(workflowId, outputs) |>
#     tidyr::unnest_wider(outputs) |>
#     tidyr::unnest_longer(starts_with("Rcollectl"), keep_empty = TRUE)

## ----eval = FALSE, eval = has_gcloud-------------------------------------
# submissionId <- "35280de1-42d8-492b-aa8c-5feff984bffa"
# info_2 <- avworkflow_info(submissionId)

## ----message=FALSE, warning=FALSE----------------------------------------
# info_file_2 <-
#     system.file(package = "AnVIL", "extdata", "avworkflow_info_2.rds")
# info_2 <- readRDS(info_file_2)
# info_2

## ----message=FALSE, warning=FALSE----------------------------------------
# info_2 |>
#     select(workflowId, outputs) |>
#     tidyr::unnest_wider(outputs)

## ------------------------------------------------------------------------
# output_files <-
#     info_2 |>
#     select(workflowId, outputs) |>
#     tidyr::unnest_wider(outputs) |>
#     select(RcollectlWorkflowDelayedArrayParameters.Rcollectl_result) |>
#     tidyr::unnest_longer(
#         "RcollectlWorkflowDelayedArrayParameters.Rcollectl_result"
#     )
# output_files

## ------------------------------------------------------------------------
# output_files |>
#     as.vector()

## ----sessionInfo---------------------------------------------------------
# sessionInfo()

