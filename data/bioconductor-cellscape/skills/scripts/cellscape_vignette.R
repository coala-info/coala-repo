# Code example from 'cellscape_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("cellscape")

## ----eval=FALSE---------------------------------------------------------------
# example("cellscape")

## ----echo=FALSE---------------------------------------------------------------
library(cellscape)
#' # single cell tree edges
tree_edges <- read.csv(system.file("extdata", "targeted_tree_edges.csv", package = "cellscape"))
#' # targeted mutations
targeted_data <- read.csv(system.file("extdata", "targeted_muts.csv", package = "cellscape"))
#' # genotype tree edges
gtype_tree_edges <- data.frame("source" = c("Ancestral", "Ancestral", "B", "C", "D"), "target" = c("A", "B", "C", "D", "E"))
#' # annotations
sc_annot <- read.csv(system.file("extdata", "targeted_annots.csv", package = "cellscape"))
#' # mutation order
mut_order <- scan(system.file("extdata", "targeted_mut_order.txt", package = "cellscape"), what = character())
#' # run cellscape
cellscape(mut_data = targeted_data, tree_edges = tree_edges, sc_annot = sc_annot, gtype_tree_edges = gtype_tree_edges, mut_order = mut_order)

## ----eval=FALSE---------------------------------------------------------------
# ?cellscape

## ----eval=FALSE---------------------------------------------------------------
# browseVignettes("cellscape")

