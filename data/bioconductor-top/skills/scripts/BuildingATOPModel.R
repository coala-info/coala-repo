# Code example from 'BuildingATOPModel' vignette. See references/ for full tutorial.

params <-
list(test = FALSE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(BiocStyle)

## ----warning = FALSE, message = FALSE-----------------------------------------
suppressPackageStartupMessages({
  library(tidyverse)
  library(survival)
  library(dplyr)
  library(survminer)
  library(Biobase)
  library(ggsci)
  library(ggbeeswarm)
  library(TOP)
  library(curatedOvarianData)
})

theme_set(theme_bw())

## ----eval = FALSE-------------------------------------------------------------
# # Install the package from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("TOP")

## -----------------------------------------------------------------------------
data("GSE12418_eset", package = "curatedOvarianData")
data("GSE30009_eset", package = "curatedOvarianData")

## ----japan_a------------------------------------------------------------------
data("GSE32062.GPL6480_eset")
japan_a <- GSE32062.GPL6480_eset

data("GSE9891_eset")
tothill <- GSE9891_eset

data("GSE32063_eset")
japan_b <- GSE32063_eset

data("TCGA.RNASeqV2_eset")
selection <- TCGA.RNASeqV2_eset$tumorstage %in% c(3, 4) & TCGA.RNASeqV2_eset$site_of_tumor_first_recurrence == "metastasis"
selection[is.na(selection)] <- FALSE
tcgarnaseq <- TCGA.RNASeqV2_eset[, selection]

data("E.MTAB.386_eset")
bentink <- E.MTAB.386_eset

data("GSE13876_eset")
crijns <- GSE13876_eset
crijns <- crijns[, crijns$grade %in% c(3, 4)]

data("GSE18520_eset")
mok <- GSE18520_eset

data("GSE17260_eset")
yoshihara2010 <- GSE17260_eset

data("GSE26712_eset")
bonome <- GSE26712_eset

list_ovarian_eset <- lst(
  japan_a, tothill, japan_b,
  tcgarnaseq, bonome, mok, yoshihara2010,
  bentink, crijns
)

list_ovarian_eset %>%
  sapply(dim)

## -----------------------------------------------------------------------------
raw_gene_list <- purrr::map(list_ovarian_eset, rownames)
common_genes <- Reduce(f = intersect, x = raw_gene_list)
length(common_genes)

## -----------------------------------------------------------------------------
ov_pdata <- purrr::map(list_ovarian_eset, pData)
list_pdata <- list_ovarian_eset %>%
  purrr::map(pData) %>%
  purrr::map(tibble::rownames_to_column, var = "sample_id")

ov_surv_raw <- purrr::map(
  .x = list_pdata,
  .f = ~ data.frame(
    sample_id = .x$sample_id,
    time = .x$days_to_death %>% as.integer(),
    dead = ifelse(.x$vital_status == "deceased", 1, 0)
  ) %>%
    na.omit() %>%
    dplyr::filter(
      time > 0,
      !is.nan(time),
      !is.nan(dead)
    )
)
ov_surv_raw %>% sapply(nrow)
ov_surv_y <- ov_surv_raw %>%
  purrr::map(~ .x %>%
    dplyr::select(-sample_id)) %>%
  purrr::map(~ Surv(time = .x$time, event = .x$dead))

## -----------------------------------------------------------------------------
ov_surv_exprs <- purrr::map2(
  .x = list_ovarian_eset,
  .y = ov_surv_raw,
  .f = ~ exprs(.x[common_genes, .y$sample_id])
)

ov_surv_tbl <- ov_surv_raw %>%
  bind_rows(.id = "data_source")
ov_surv_tbl %>%
  ggplot(aes(
    x = time,
    y = ..density..,
    fill = data_source
  )) +
  geom_density(alpha = 0.25) +
  scale_fill_d3()

## -----------------------------------------------------------------------------
surv_list <- ov_surv_tbl %>%
  split(ov_surv_tbl$data_source)
surv_list <- lapply(surv_list, function(x) x[, 3:4])

surv_counts <- ov_surv_exprs %>% lapply(t)
surv_list <- surv_list[names(surv_counts)]
surv_model <- TOP_survival(
  x_list = surv_counts, y_list = surv_list, nFeatures = 10
)

## -----------------------------------------------------------------------------
conf_results <- unlist(lapply(seq_along(surv_counts), function(x) {
  Surv_TOP_CI(
    surv_model,
    newx = surv_counts[[x]], newy = surv_list[[x]]
  )$concordance
}))

conf_results %>%
  tibble::enframe() %>%
  mutate(Metric = "C-index") %>%
  ggplot(aes(y = value, x = Metric)) +
  geom_boxplot(width = 0.5) +
  ylab("C-index") +
  geom_jitter(alpha = 0.7, width = 0.1) +
  theme(axis.text.x = element_blank()) +
  xlab("Survival Model")

## -----------------------------------------------------------------------------
sessionInfo()

