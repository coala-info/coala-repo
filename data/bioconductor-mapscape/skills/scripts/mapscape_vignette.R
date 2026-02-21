# Code example from 'mapscape_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# # try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mapscape")

## ----eval=FALSE---------------------------------------------------------------
# example("mapscape")

## ----echo=FALSE---------------------------------------------------------------
library(mapscape)  
# EXAMPLE 1 - Patient A21, Gundem et al., 2015

# clonal prevalences
clonal_prev <- read.csv(system.file("extdata", "A21_clonal_prev.csv", package = "mapscape"))
# mutations
mutations <- read.csv(system.file("extdata", "A21_mutations.csv", package = "mapscape"))
# locations of each tumour sample on user-provided image
sample_locations <- read.csv(system.file("extdata", "A21_sample_locations.csv", package = "mapscape"))
# genotype tree edges
tree_edges <- read.csv(system.file("extdata", "A21_tree.csv", package = "mapscape"))
# image reference
img_ref <- system.file("extdata", "A21_anatomical_image.png", package = "mapscape")
# radial order of samples
sample_ids <- c("H","F","J","D","A","I","C","E","G")
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, 
img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE)

## ----echo=FALSE---------------------------------------------------------------
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, 
img_ref = img_ref, show_warnings=FALSE)

## ----echo=FALSE---------------------------------------------------------------
sample_ids <- c("H","F","J","D","A","I","C","E","G")
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, 
img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE)

## ----echo=FALSE---------------------------------------------------------------
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE)

## ----echo=FALSE---------------------------------------------------------------
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE, n_cells=300)

## ----echo=FALSE---------------------------------------------------------------
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE, show_low_prev_gtypes = TRUE)

## ----echo=FALSE---------------------------------------------------------------
# run mapscape
mapscape(clonal_prev = clonal_prev, tree_edges = tree_edges, sample_locations = sample_locations, img_ref = img_ref, sample_ids = sample_ids, show_warnings=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# ?mapscape

## ----eval=FALSE---------------------------------------------------------------
# browseVignettes("mapscape")

