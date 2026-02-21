# Code example from 'salmon' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>", collapse = TRUE, fig.align = 'center',
  eval = AnVILGCP::gcloud_exists()
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("AnVILWorkflow")

## ----results="hide", message=FALSE, warning=FALSE-----------------------------
# library(AnVIL)
# library(AnVILGCP)
# library(AnVILWorkflow)

## -----------------------------------------------------------------------------
# AnVILGCP::gcloud_exists()

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("rstudio/cloudml")
# cloudml::gcloud_install()

## ----eval=FALSE---------------------------------------------------------------
# accountEmail <- "YOUR_EMAIL@gmail.com"
# billingProjectName <- "YOUR_BILLING_ACCOUNT"
# 
# setCloudEnv(accountEmail = accountEmail,
#             billingProjectName = billingProjectName)

## ----echo=FALSE---------------------------------------------------------------
# ## In case the environment is set already.
# accountEmail <- AnVILGCP::gcloud_account()
# billingProjectName <- AnVILGCP::gcloud_project()
# 
# setCloudEnv(accountEmail = accountEmail,
#             billingProjectName = billingProjectName,
#             message = FALSE)

## -----------------------------------------------------------------------------
# analysis <- "salmon"

## -----------------------------------------------------------------------------
# AnVILBrowse("malaria")
# AnVILBrowse("resistance")
# AnVILBrowse("resistance", searchFrom = "workflow")

## ----echo=FALSE, eval=FALSE, error=TRUE---------------------------------------
try({
# # If you attempt to clone the template workspace using the existing
# # workspaceName, you will get the error message.
# cloneWorkspace(workspaceName = "salmon_test", analysis = analysis)
})

## -----------------------------------------------------------------------------
# salmonWorkspaceName <- basename(tempfile("salmon_")) # unique workspace name
# salmonWorkspaceName
# cloneWorkspace(workspaceName = salmonWorkspaceName, analysis = analysis)

## ----cleanup, echo=FALSE, message=FALSE, error=TRUE, warning=FALSE------------
try({
# ## Delete test workspaces
# resp <- AnVIL::Terra()$deleteWorkspace(workspaceNamespace = billingProjectName,
#                                        workspaceName = salmonWorkspaceName)
# rm(resp)
})

## ----eval=FALSE---------------------------------------------------------------
# cnvWorkspaceName <- basename(tempfile("cnv_")) # unique workspace name
# cnvWorkspaceName
# cloneWorkspace(workspaceName = cnvWorkspaceName,
#                templateName = "Tumor_Only_CNV")

## ----echo=FALSE---------------------------------------------------------------
# ## workspace used in this vignette
# salmonWorkspaceName <- "salmon_test"

## -----------------------------------------------------------------------------
# config <- getWorkflowConfig(workspaceName = salmonWorkspaceName)
# current_input <- currentInput(salmonWorkspaceName, config = config)
# current_input

## -----------------------------------------------------------------------------
# new_input <- current_input
# new_input[4,4] <- "athal_index"
# new_input
# 
# updateInput(salmonWorkspaceName, inputs = new_input, config = config)

## ----eval=FALSE---------------------------------------------------------------
# runWorkflow(slamonWorkspaceName, config = config)
# # You should provide the inputName from the followings:
# # [1] "AnVILBulkRNASeq_set"
# #> Error in runWorkflow(salmonWorkspaceName):

## -----------------------------------------------------------------------------
# runWorkflow(salmonWorkspaceName,
#             inputName = "AnVILBulkRNASeq_set",
#             config = config)

## -----------------------------------------------------------------------------
# submissions <- monitorWorkflow(workspaceName = salmonWorkspaceName)
# submissions

## -----------------------------------------------------------------------------
# stopWorkflow(salmonWorkspaceName)

## -----------------------------------------------------------------------------
# submissions <- monitorWorkflow(workspaceName = "Bioconductor-Workflow-DESeq2")
# submissions

## ----no-run-examples, eval=FALSE----------------------------------------------
# ## Output from the successfully-done submission
# successful_submissions <- submissions$submissionId[submissions$succeeded == 1]
# out <- getOutput(workspaceName = "Bioconductor-Workflow-DESeq2",
#                  submissionId = successful_submissions[1])

## ----echo=FALSE---------------------------------------------------------------
# ## Save the previous submission results from the above chunk
# ## write.table(out, "vignettes/salmon_test_outputs.csv")
# out <- read.table("salmon_test_outputs.csv", header = TRUE) %>%
#     tibble::tibble()

## -----------------------------------------------------------------------------
# head(out)

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

