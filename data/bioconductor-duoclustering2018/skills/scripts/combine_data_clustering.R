# Code example from 'combine_data_clustering' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(SingleCellExperiment)
  library(DuoClustering2018)
  library(dplyr)
  library(tidyr)
})

## -----------------------------------------------------------------------------
dat <- sce_filteredExpr10_Koh()

## -----------------------------------------------------------------------------
res <- clustering_summary_filteredExpr10_Koh_v2()

## -----------------------------------------------------------------------------
res <- res %>% dplyr::filter(run == 1 & k %in% c(3, 5, 9)) %>%
  dplyr::group_by(method, k) %>% 
  dplyr::filter(is.na(resolution) | resolution == resolution[1]) %>%
  dplyr::ungroup() %>% 
  tidyr::unite(col = method_k, method, k, sep = "_", remove = TRUE) %>% 
  dplyr::select(cell, method_k, cluster) %>%
  tidyr::spread(key = method_k, value = cluster)

colData(dat) <- DataFrame(
  as.data.frame(colData(dat)) %>%
    dplyr::left_join(res, by = c("Run" = "cell"))
)
head(colData(dat))

## ----eval=FALSE---------------------------------------------------------------
# if (require(iSEE)) {
#   iSEE(dat)
# }

## -----------------------------------------------------------------------------
sessionInfo()

