# Code example from 'IntroductionToAnVILAz' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
az_ok <- AnVILAz::has_avworkspace(strict = TRUE, platform = AnVILAz::azure())
knitr::opts_chunk$set(
    collapse = TRUE,
## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
    crop = NULL,
    eval = az_ok
)
options(width = 75)

## ----install, eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager", repos = "https://cran.r-project.org")
# BiocManager::install("Bioconductor/AnVILAz")

## ----library, message = FALSE, eval = TRUE, cache = FALSE----------------
library(AnVILAz)

## ----eval=az_ok----------------------------------------------------------
# avlist()

## ----eval=az_ok----------------------------------------------------------
# data("mtcars", package = "datasets")
# test <- head(mtcars)
# save(test, file = "mydata.Rda")

## ----eval=az_ok----------------------------------------------------------
# avcopy("mydata.Rda", "analyses/")

## ----eval=az_ok----------------------------------------------------------
# avcopy("jupyter.log", "analyses/")

## ----eval=az_ok----------------------------------------------------------
# avremove("analyses/mydata.Rda")

## ----eval=az_ok----------------------------------------------------------
# avcopy("analyses/jupyter.log", "./test/")

## ----eval=az_ok----------------------------------------------------------
# avbackup("./test/", "analyses/")

## ----eval=az_ok----------------------------------------------------------
# avrestore("analyses/test")

## ----eval=az_ok----------------------------------------------------------
# avrestore("analyses/test", "test")

## ----eval=az_ok----------------------------------------------------------
# library(dplyr)
# mtcars_tbl <-
#     mtcars |>
#     as_tibble(rownames = "model_id") |>
#     mutate(model_id = gsub(" ", "-", model_id))

## ----eval=az_ok----------------------------------------------------------
# mtcars_tbl |> avtable_import(table = "testData", primaryKey = "model_id")

## ----eval=az_ok----------------------------------------------------------
# model_data <- avtable(table = "testData")
# head(model_data)

## ----eval=az_ok----------------------------------------------------------
# avtable_delete_values(table = "testData", values = "AMC-Javelin")

## ----eval=az_ok----------------------------------------------------------
# avtable_delete(table = "testData")

## ----sessionInfo, echo = FALSE, eval = TRUE------------------------------
sessionInfo()

