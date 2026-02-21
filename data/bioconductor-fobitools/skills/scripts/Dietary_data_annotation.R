# Code example from 'Dietary_data_annotation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("fobitools")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(fobitools)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(tidyverse)
library(kableExtra)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
load("data/sample_ffq.rda")

sample_ffq %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE----------------------------------------------------------
annotated_text <- fobitools::annotate_foods(sample_ffq)

annotated_text$annotated %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE----------------------------------------------------------
annotated_text_95 <- fobitools::annotate_foods(sample_ffq, similarity = 0.95)

annotated_text_95$annotated %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE----------------------------------------------------------
annotated_text$annotated %>%
  filter(!FOOD_ID %in% annotated_text_95$annotated$FOOD_ID) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE, fig.width = 12, fig.height = 10----
terms <- annotated_text$annotated %>%
  pull(FOBI_ID)

fobitools::fobi_graph(terms = terms,
                      get = NULL,
                      layout = "lgl",
                      labels = TRUE,
                      legend = TRUE,
                      labelsize = 6,
                      legendSize = 20)

## ----warning = FALSE----------------------------------------------------------
inverse_rel <- fobitools::fobi %>%
  filter(id_BiomarkerOf %in% annotated_text$annotated$FOBI_ID) %>%
  dplyr::select(id_code, name, id_BiomarkerOf, FOBI) %>%
  dplyr::rename(METABOLITE_ID = 1, METABOLITE_NAME = 2, FOBI_ID = 3, METABOLITE_FOBI_ID = 4)

annotated_foods_and_metabolites <- left_join(annotated_text$annotated, inverse_rel, by = "FOBI_ID")

annotated_foods_and_metabolites %>%
  filter(!is.na(METABOLITE_ID)) %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## -----------------------------------------------------------------------------
sessionInfo()

