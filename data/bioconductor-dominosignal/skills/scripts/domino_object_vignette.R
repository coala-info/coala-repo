# Code example from 'domino_object_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  fig.cap = "",
  tidy = TRUE
)
options(timeout = 600)

## ----setup--------------------------------------------------------------------
set.seed(42)
library(dominoSignal)

# BiocFileCache helps with file management across sessions
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
data_url <- "https://zenodo.org/records/10951634/files/pbmc_domino_built.rds"
tmp_path <- BiocFileCache::bfcrpath(bfc, data_url)
dom <- readRDS(tmp_path)

## ----show---------------------------------------------------------------------
dom

## ----print--------------------------------------------------------------------
print(dom)

## ----list-functions-----------------------------------------------------------
ls("package:dominoSignal", pattern = "^dom_")

## ----cluster-names------------------------------------------------------------
dom_clusters(dom)

## ----counts-------------------------------------------------------------------
count_matrix <- dom_counts(dom)
knitr::kable(count_matrix[1:5, 1:5])

## ----zcounts------------------------------------------------------------------
z_matrix <- dom_zscores(dom)
knitr::kable(z_matrix[1:5, 1:5])

## ----tf_activation------------------------------------------------------------
activation_matrix <- dom_tf_activation(dom)
knitr::kable(activation_matrix[1:5, 1:5])

## ----db-name------------------------------------------------------------------
dom_database(dom)

## ----db-all-------------------------------------------------------------------
db_matrix <- dom_database(dom, name_only = FALSE)
knitr::kable(db_matrix[1:5, 1:5])

## ----de-----------------------------------------------------------------------
de_matrix <- dom_de(dom)
knitr::kable(de_matrix[1:5, 1:5])

## ----correlations-------------------------------------------------------------
cor_matrix <- dom_correlations(dom)
knitr::kable(cor_matrix[1:5, 1:5])

## ----complex------------------------------------------------------------------
complex_links <- dom_linkages(dom, link_type = "complexes")
# Look for components of NODAL receptor complex
complex_links$NODAL_receptor

## ----lig-by-clust-------------------------------------------------------------
incoming_links <- dom_linkages(dom, link_type = "incoming-ligand", by_cluster = TRUE)
# Check incoming signals to dendritic cells
incoming_links$dendritic_cell

## ----link---------------------------------------------------------------------
all_linkages <- slot(dom, "linkages")
# Names of all sub-structures:
names(all_linkages)

## ----collate------------------------------------------------------------------
dc_tfs <- dom_network_items(dom, "dendritic_cell", return = "features")
head(dc_tfs)

## ----global-signalling--------------------------------------------------------
signal_matrix <- dom_signaling(dom)
knitr::kable(signal_matrix)

## ----clust-signal-------------------------------------------------------------
dc_matrix <- dom_signaling(dom, "dendritic_cell")
knitr::kable(dc_matrix)

## ----info---------------------------------------------------------------------
dom_info(dom)

## -----------------------------------------------------------------------------
Sys.Date()
sessionInfo()

