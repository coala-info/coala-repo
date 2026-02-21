# Code example from 'timescape_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# # try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("timescape")

## ----eval=FALSE---------------------------------------------------------------
# example("timescape")

## ----echo=FALSE---------------------------------------------------------------
library(timescape)  

## ----echo=FALSE---------------------------------------------------------------
# EXAMPLE 1 - Acute myeloid leukemia patient, Ding et al., 2012
# genotype tree edges
tree_edges <- read.csv(system.file("extdata", "AML_tree_edges.csv", package = "timescape"))
# clonal prevalences
clonal_prev <- read.csv(system.file("extdata", "AML_clonal_prev.csv", package = "timescape"))
# targeted mutations
mutations <- read.csv(system.file("extdata", "AML_mutations.csv", package = "timescape"))
# perturbations
perturbations <- data.frame( pert_name = c("Chemotherapy"), 
                             prev_tp = c("Diagnosis"))
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, perturbations = perturbations, height=260)

## ----echo=FALSE---------------------------------------------------------------
# EXAMPLE 2 - Patient 7, McPherson and Roth et al., 2016
# genotype tree edges
tree_edges <- read.csv(system.file("extdata", "px7_tree_edges.csv", package = "timescape"))
# clonal prevalences
clonal_prev <- read.csv(system.file("extdata", "px7_clonal_prev.csv", package = "timescape"))
# clone colours
clone_colours <- data.frame(clone_id = c("A","B","C","D","E"), 
                            colour = c("d0ced0", "2CD0AB", "FFD94B", "FD8EE5", "F8766D"))
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, clone_colours = clone_colours, height=260, alpha=15)

## ----echo=FALSE---------------------------------------------------------------

# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15)

## ----echo=FALSE---------------------------------------------------------------
# clone colours
clone_colours <- data.frame(clone_id = c("A","B","C","D","E"), 
                            colour = c("#e41a1c", "#377eb8", "#4daf4a", "#984ea3", "#ff7f00"))
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, clone_colours = clone_colours, height=260, alpha=15)

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=10)

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=90)

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15, xaxis_title="My X Axis", yaxis_title="My Y Axis", phylogeny_title="My Phylogeny")

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15, genotype_position="stack")

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15, genotype_position="space")

## ----echo=FALSE---------------------------------------------------------------
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15, genotype_position="centre")

## ----echo=FALSE---------------------------------------------------------------
# EXAMPLE 1 - Acute myeloid leukemia patient, Ding et al., 2012
# genotype tree edges
tree_edges <- read.csv(system.file("extdata", "AML_tree_edges.csv", package = "timescape"))
# clonal prevalences
clonal_prev <- read.csv(system.file("extdata", "AML_clonal_prev.csv", package = "timescape"))
# targeted mutations
mutations <- read.csv(system.file("extdata", "AML_mutations.csv", package = "timescape"))

# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260)

## ----echo=FALSE---------------------------------------------------------------
# perturbations
perturbations <- data.frame( pert_name = c("Chemotherapy"), 
                             prev_tp = c("Diagnosis"))
# run timescape
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, perturbations = perturbations, height=260)

## ----eval=FALSE---------------------------------------------------------------
# ?timescape

## ----eval=FALSE---------------------------------------------------------------
# browseVignettes("timescape")

