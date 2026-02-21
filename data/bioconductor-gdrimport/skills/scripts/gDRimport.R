# Code example from 'gDRimport' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(gDRimport)
log_level <- futile.logger::flog.threshold("ERROR")

## -----------------------------------------------------------------------------
# primary test data
td1 <- get_test_data()
summary(td1)
td1

# test data in Tecan format
td2 <- get_test_Tecan_data()
summary(td2)

# test data in D300 format
td3 <- get_test_D300_data()
summary(td3)

# test data obtained from EnVision
td4 <- get_test_EnVision_data()
summary(td4)

## -----------------------------------------------------------------------------
ml <- load_manifest(manifest_path(td1))
summary(ml)

t_df <- load_templates(template_path(td1))
summary(t_df)

r_df <- suppressMessages(load_results(result_path(td1)))
summary(r_df)

l_tbl <-
  suppressMessages(
    load_data(manifest_path(td1), template_path(td1), result_path(td1)))
summary(l_tbl)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# convert_LEVEL5_prism_to_gDR_input("path_to_file")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# convert_LEVEL6_prism_to_gDR_input("prism_data_path", "cell_line_data_path", "treatment_data_path")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

