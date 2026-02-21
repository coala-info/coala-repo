# Code example from 'food_enrichment_analysis' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# # install.packages("BiocManager")
# BiocManager::install("fobitools")

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(fobitools)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
library(dplyr)
library(kableExtra)

## ----warning = FALSE, message = FALSE, comment = FALSE------------------------
# select 300 random metabolites from FOBI
idx_universe <- sample(nrow(fobitools::idmap), 300, replace = FALSE)
metaboliteUniverse <- fobitools::idmap %>%
  dplyr::slice(idx_universe) %>%
  pull(FOBI)

# select 10 random metabolites from metaboliteUniverse that are associated with 'Red meat' (FOBI:0193), 
# 'Lean meat' (FOBI:0185) , 'egg food product' (FOODON:00001274), 
# or 'grape (whole, raw)' (FOODON:03301702)
fobi_subset <- fobitools::fobi %>% # equivalent to `parse_fobi()`
  filter(FOBI %in% metaboliteUniverse) %>%
  filter(id_BiomarkerOf %in% c("FOBI:0193", "FOBI:0185", "FOODON:00001274", "FOODON:03301702")) %>%
  dplyr::slice(sample(nrow(.), 10, replace = FALSE))

metaboliteList <- fobi_subset %>%
  pull(FOBI)

## ----warning = FALSE, eval = FALSE--------------------------------------------
# fobitools::ora(metaboliteList = metaboliteList,
#                metaboliteUniverse = metaboliteUniverse,
#                subOntology = "food",
#                pvalCutoff = 0.01)

## ----warning = FALSE, message = FALSE, comment = FALSE, echo = FALSE----------
res_ora <- fobitools::ora(metaboliteList = metaboliteList, 
                          metaboliteUniverse = metaboliteUniverse, 
                          subOntology = "food", 
                          pvalCutoff = 0.01)

## ----warning = FALSE, message = FALSE, comment = FALSE, echo = FALSE----------
kbl(res_ora, 
    row.names = FALSE,
    booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))

## ----warning = FALSE, message = FALSE, comment = FALSE, fig.align = "center", fig.height = 8, fig.width = 10----
terms <- fobi_subset %>%
  pull(id_code)

# create the associated graph
fobitools::fobi_graph(terms = terms, 
                      get = "anc",
                      labels = TRUE,
                      legend = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

