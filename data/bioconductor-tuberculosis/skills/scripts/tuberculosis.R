# Code example from 'tuberculosis' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("tuberculosis")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("schifferl/tuberculosis", dependencies = TRUE, build_vignettes = TRUE)

## ----message = FALSE----------------------------------------------------------
library(tuberculosis)

## -----------------------------------------------------------------------------
tuberculosis("GSE103147")

## -----------------------------------------------------------------------------
tuberculosis("GSE103147", dryrun = FALSE)

## -----------------------------------------------------------------------------
tuberculosis("GSE10799.", dryrun = FALSE)

## -----------------------------------------------------------------------------
zak_data <-
    tuberculosis("GSE103147", dryrun = FALSE) |>
    magrittr::use_series("2021-09-15.GSE103147")

## -----------------------------------------------------------------------------
row_names <-
    base::colnames(zak_data)

## -----------------------------------------------------------------------------
col_names <-
    purrr::map_chr(1:2, ~ base::paste("UMAP", .x, sep = ""))

## ----fig.width = 8, fig.height = 8--------------------------------------------
scater::calculateUMAP(zak_data, exprs_values = "exprs") |>
    magrittr::set_rownames(row_names) |>
    magrittr::set_colnames(col_names) |>
    base::as.data.frame() |>
    ggplot2::ggplot(mapping = ggplot2::aes(UMAP1, UMAP2)) +
    ggplot2::geom_point()

## -----------------------------------------------------------------------------
utils::sessionInfo()

