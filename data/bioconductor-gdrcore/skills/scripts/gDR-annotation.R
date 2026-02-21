# Code example from 'gDR-annotation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(GDR_CELLLINE_ANNOTATION = "some/path/to/cell_line_annotation.csv")
# Sys.setenv(GDR_DRUG_ANNOTATION = "some/path/to/drug_annotation.csv")

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(GDR_CELLLINE_ANNOTATION = "")
# Sys.setenv(GDR_DRUG_ANNOTATION = "")

## ----eval=FALSE---------------------------------------------------------------
# # Example for SummarizedExperiment
# se <- SummarizedExperiment::SummarizedExperiment(
#   rowData = data.table::data.table(Gnumber = c("D1", "D2", "D3"))
# )
# drug_annotation <- get_drug_annotation(data.table::as.data.table(SummarizedExperiment::rowData(se)))
# annotated_se <- annotate_se_with_drug(se, drug_annotation)
# 
# # Example for MultiAssayExperiment
# mae <- MultiAssayExperiment::MultiAssayExperiment(
#   experiments = list(exp1 = SummarizedExperiment::SummarizedExperiment(
#     rowData = data.table::data.table(clid = c("CL1", "CL2", "CL3"))
#   ))
# )
# cell_line_annotation <- get_cell_line_annotation(data.table::as.data.table(
#   SummarizedExperiment::rowData(
#     MultiAssayExperiment::experiments(mae)[[1]])))
# annotated_mae <- annotate_mae_with_cell_line(mae, cell_line_annotation)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

