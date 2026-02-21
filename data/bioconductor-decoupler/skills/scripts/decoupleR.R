# Code example from 'decoupleR' vignette. See references/ for full tutorial.

## ----chunk_setup, include = FALSE---------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignette_setup, echo=FALSE, message=FALSE, warning = FALSE---------------
# Track time spent on making the vignette.
start_time <- Sys.time()

# Bib setup.
library(RefManageR)

# Write bibliography information
bib <- c(
    decoupleR = citation("decoupleR")[1],
    AUCell = citation("AUCell")[1],
    fgsea = citation("fgsea")[1],
    GSVA = citation("GSVA")[1],
    viper = citation("viper")[1]
)

## ----bioconductor_install, eval=FALSE-----------------------------------------
# install.packages("BiocManager")
# BiocManager::install("decoupleR")

## ----github_install, eval=FALSE-----------------------------------------------
# BiocManager::install("saezlab/decoupleR")

## ----load_library, message=FALSE----------------------------------------------
library(decoupleR)

# Extra libraries
library(dplyr)
library(pheatmap)

## ----read_example_data--------------------------------------------------------
data <- get_toy_data()

mat <- data$mat
head(mat,5)[,1:5]

network <- data$network
network

## ----show_matrix, message=TRUE------------------------------------------------
pheatmap(mat, cluster_rows = F, cluster_cols = F)

## ----usage-show_methods, message=TRUE-----------------------------------------
show_methods()

## ----usage-fgsea, message=TRUE------------------------------------------------
res_gsea <- run_fgsea(mat, network, .source='source', .target='target', nproc=1, minsize = 0)
res_gsea

## ----usage-ulm, message=TRUE--------------------------------------------------
res_ulm <- run_ulm(mat, network, .source='source', .target='target', .mor='mor', minsize = 0)
res_ulm

## ----res_gsea, message=TRUE---------------------------------------------------
# Transform to matrix
mat_gsea <- res_gsea %>%
  filter(statistic=='fgsea') %>%
  pivot_wider_profile(id_cols = source, names_from = condition, 
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_gsea, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)

## ----res_ulm, message=TRUE----------------------------------------------------
# Transform to matrix
mat_ulm <- res_ulm %>%
  filter(statistic=='ulm') %>%
  pivot_wider_profile(id_cols = source, names_from = condition, 
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_ulm, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)

## ----usage-decouple, message=TRUE---------------------------------------------
res_decouple <- decouple(mat, 
                         network, 
                         .source='source', 
                         .target='target',
                         minsize = 0)
res_decouple

## ----res_decouple, message=TRUE-----------------------------------------------
# Transform to matrix
mat_consensus <- res_decouple %>%
  filter(statistic=='consensus') %>%
  pivot_wider_profile(id_cols = source, names_from = condition, 
                      values_from = score) %>%
  as.matrix()

pheatmap(mat_consensus, cluster_rows = F, cluster_cols = F, cellwidth = 15, cellheight = 40)

## ----session_info, echo=FALSE-----------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

