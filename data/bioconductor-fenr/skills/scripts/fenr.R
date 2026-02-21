# Code example from 'fenr' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(width = 72)

## ----bioconductor_install, eval=FALSE---------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("fenr")

## ----figure, fig.cap="Overview of fenr data pipeline.", echo=FALSE----
knitr::include_graphics("figures/overview.png")

## ----load_fenr--------------------------------------------------------
library(fenr)
data(exmpl_all, exmpl_sel)

## ----load_go_data, include=FALSE--------------------------------------
library(tibble)
data(go)
data(go_species)

## ----fetch_go, eval=FALSE---------------------------------------------
# go <- fetch_go(species = "sgd")

## ----species, eval=FALSE----------------------------------------------
# go_species <- fetch_go_species()

## ----show_species-----------------------------------------------------
go_species

## ----go_terms---------------------------------------------------------
go$terms

## ----go_mapping-------------------------------------------------------
go$mapping

## ----prepare_for_enrichment-------------------------------------------
go_terms <- prepare_for_enrichment(go$terms, go$mapping, exmpl_all,
                                   feature_name = "gene_symbol")

## ----enrichment-------------------------------------------------------
enr <- functional_enrichment(exmpl_all, exmpl_sel, go_terms)

## ----enrichment_result------------------------------------------------
enr |>
  head(10)

## ----interactive_prepare, eval=FALSE----------------------------------
# data(yeast_de)
# term_data <- fetch_terms_for_example(yeast_de)

## ----shiny_app, eval=FALSE--------------------------------------------
# enrichment_interactive(yeast_de, term_data)

## ----topGO------------------------------------------------------------
suppressPackageStartupMessages({
  library(topGO)
})

# Preparing the gene set
all_genes <- setNames(rep(0, length(exmpl_all)), exmpl_all)
all_genes[exmpl_all %in% exmpl_sel] <- 1

# Define the gene selection function
gene_selection <- function(genes) {
  genes > 0
}

# Mapping genes to GO, we use the go2gene downloaded above and convert it to a
# list
go2gene <- go$mapping |> 
  dplyr::select(gene_symbol, term_id) |> 
  dplyr::distinct() |> 
  dplyr::group_by(term_id) |> 
  dplyr::summarise(ids = list(gene_symbol)) |> 
  tibble::deframe()

# Setting up the GO data for analysis
go_data <- new(
  "topGOdata",
  ontology = "BP",
  allGenes = all_genes,
  geneSel = gene_selection,
  annot = annFUN.GO2genes,
  GO2genes = go2gene
)

# Performing the enrichment test
fisher_test <- runTest(go_data, algorithm = "classic", statistic = "fisher")

## ----fenr_speed, eval = FALSE-----------------------------------------
# # Setting up data for enrichment
# go <- fetch_go(species = "sgd")
# go_terms <- prepare_for_enrichment(go$terms, go$mapping, exmpl_all,
#                                    feature_name = "gene_symbol")
# 
# # Executing the enrichment test
# enr <- functional_enrichment(exmpl_all, exmpl_sel, go_terms)

## ----session_info, echo=FALSE-----------------------------------------
sessionInfo()

