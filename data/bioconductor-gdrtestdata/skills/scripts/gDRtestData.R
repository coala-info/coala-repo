# Code example from 'gDRtestData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE---------------------------------------------------------------
library(gDRtestData)

## -----------------------------------------------------------------------------
cell_lines <- create_synthetic_cell_lines()
drugs <- create_synthetic_drugs()

## ----eval=FALSE---------------------------------------------------------------
# cl_rep <- add_data_replicates(cell_lines)
# head(cl_rep)

## ----eval=FALSE---------------------------------------------------------------
# cl_conc <- add_concentration(cell_lines)
# head(cl_conc)

## ----eval=FALSE---------------------------------------------------------------
# df_layout <- prepareData(cell_lines, drugs)
# head(df_layout)

## ----eval=FALSE---------------------------------------------------------------
# df_layout_small <- prepareData(cell_lines[seq_len(2), ], drugs[seq_len(4), ])
# df_layout_small$Duration <- 72
# df_layout_small$ReadoutValue <- 0
# df_layout_small_with_Day0 <- add_day0_data(df_layout_small)
# head(df_layout_small_with_Day0)

## -----------------------------------------------------------------------------
hill <- generate_hill_coef(cell_lines, drugs) 

## -----------------------------------------------------------------------------
ec50_met <- generate_ec50(cell_lines, drugs) 

## -----------------------------------------------------------------------------
einf_met <- generate_e_inf(cell_lines, drugs)

## ----eval=FALSE---------------------------------------------------------------
# response_data <- prepareMergedData(cell_lines, drugs)
# head(response_data)

## ----echo=FALSE---------------------------------------------------------------
yml_path <- system.file(package = "gDRtestData", "testdata", "synthetic_list.yml")
cat(paste0("* ", names(yaml::read_yaml(yml_path)), collapse = ", \n"), ".")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

