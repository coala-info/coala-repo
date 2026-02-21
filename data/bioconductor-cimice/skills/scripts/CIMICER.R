# Code example from 'CIMICER' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----echo=F-------------------------------------------------------------------
#knitr::opts_chunk$set(echo = TRUE, fig.align = "left")

## ----include = FALSE----------------------------------------------------------
show_matrix <- function(M, w, h){
    M[1:h,1:w] %>% as.matrix %>%  as.data.frame
}
size_matrix <- function(df){
    paste("ncol:", ncol(df), " - nrow:", nrow(df))
}

## ----error=F, message=F, results = "hide"-------------------------------------
library(CIMICE)

## ----error=F, message=F, results = "hide"-------------------------------------
# Dataframe manipulation
library(dplyr) 
# Plot display
library(ggplot2)
# Improved string operations
library(glue)
# Dataframe manipulation
library(tidyr)
# Graph data management
library(igraph)
# Remove transitive edges on a graph
# library(relations)
# Interactive graph visualization
library(networkD3)
# Interactive graph visualization
library(visNetwork)
# Correlation plot visualization
library(ggcorrplot)
# Functional R programming
library(purrr)
# Graph Visualization
library(ggraph)
# sparse matrices
library(Matrix)

## ----results = 'hide'---------------------------------------------------------
# Read input dataset in CAPRI/CAPRESE format
dataset.big <- read_CAPRI(system.file("extdata", "example.CAPRI", package = "CIMICE", mustWork = TRUE))

## ----echo=F-------------------------------------------------------------------
dataset.big %>% show_matrix(6,6) 
dataset.big %>% size_matrix()

## -----------------------------------------------------------------------------
# genes
dataset <- make_dataset(A,B,C,D) %>%
    # samples
    update_df("S1", 0, 0, 0, 1) %>%
    update_df("S2", 1, 0, 0, 0) %>%
    update_df("S3", 1, 0, 0, 0) %>%
    update_df("S4", 1, 0, 0, 1) %>%
    update_df("S5", 1, 1, 0, 1) %>%
    update_df("S6", 1, 1, 0, 1) %>%
    update_df("S7", 1, 0, 1, 1) %>%
    update_df("S8", 1, 1, 0, 1) 

## ----echo=FALSE---------------------------------------------------------------
dataset

## -----------------------------------------------------------------------------
#        path to MAF file
read_MAF(system.file("extdata", "paac_jhu_2014_500.maf", package = "CIMICE", mustWork = TRUE))[1:5,1:5]

## -----------------------------------------------------------------------------
gene_mutations_hist(dataset.big)

## -----------------------------------------------------------------------------
sample_mutations_hist(dataset.big, binwidth = 10)

## ----eval = FALSE-------------------------------------------------------------
# select_genes_on_mutations(dataset.big, 100)

## ----echo = FALSE-------------------------------------------------------------
temp <- select_genes_on_mutations(dataset.big, 100)
temp %>% show_matrix(6,6) 
temp %>% size_matrix()

## ----eval = FALSE-------------------------------------------------------------
# select_samples_on_mutations(dataset.big, 100, desc = FALSE)

## ----echo=FALSE---------------------------------------------------------------
temp <- select_samples_on_mutations(dataset.big, 100, desc = FALSE)
temp %>% show_matrix(6,6) 
temp %>% size_matrix()

## ----eval = FALSE-------------------------------------------------------------
# select_samples_on_mutations(dataset.big , 100, desc = FALSE) %>% select_genes_on_mutations(100)

## ----echo=FALSE---------------------------------------------------------------
temp <- select_samples_on_mutations(dataset.big , 100, desc = FALSE) %>% select_genes_on_mutations(100)
temp %>% show_matrix(6,6) 
temp %>% size_matrix()

## -----------------------------------------------------------------------------
corrplot_genes(dataset)

## -----------------------------------------------------------------------------
corrplot_samples(dataset)

## -----------------------------------------------------------------------------
# groups and counts equal genotypes
compactedDataset <- compact_dataset(dataset)

## ----echo = FALSE-------------------------------------------------------------
compactedDataset

## -----------------------------------------------------------------------------
samples <- compactedDataset$matrix

## ----echo=F-------------------------------------------------------------------
samples

## -----------------------------------------------------------------------------
genes <- colnames(samples)

## ----echo=F-------------------------------------------------------------------
genes

## -----------------------------------------------------------------------------
freqs <- compactedDataset$counts/sum(compactedDataset$counts)

## ----echo = FALSE-------------------------------------------------------------
freqs

## -----------------------------------------------------------------------------
# prepare node labels listing the mutated genes for each node
labels <- prepare_labels(samples, genes)
if( is.null(compactedDataset$row_names) ){
    compactedDataset$row_names <- rownames(compactedDataset$matrix)
}
matching_samples <- compactedDataset$row_names
# fix Colonal genotype absence, if needed
fix <- fix_clonal_genotype(samples, freqs, labels, matching_samples)
samples = fix[["samples"]]
freqs = fix[["freqs"]]
labels = fix[["labels"]]
matching_samples <- fix[["matching_samples"]]

## ----echo=F-------------------------------------------------------------------
samples

## -----------------------------------------------------------------------------
# compute edges based on subset relation
edges <- build_topology_subset(samples)

## -----------------------------------------------------------------------------
# remove transitive edges and prepare igraph object
g <- build_subset_graph(edges, labels)

## ----echo=F, out.height="300px",dpi=300---------------------------------------
V(g)$vertex.size <- rep(10, length(V(g)))
plot(g, vertex.size=rep(55, length(V(g))))

## -----------------------------------------------------------------------------
A <- as_adj(g)

## ----echo=F-------------------------------------------------------------------
A

## -----------------------------------------------------------------------------
no.of.children <- get_no_of_children(A,g)

## ----echo=F-------------------------------------------------------------------
no.of.children

## -----------------------------------------------------------------------------
upWeights <- computeUPW(g, freqs, no.of.children, A)

## ----echo=F-------------------------------------------------------------------
upWeights

## -----------------------------------------------------------------------------
normUpWeights <- normalizeUPW(g, freqs, no.of.children, A, upWeights)

## ----echo=F-------------------------------------------------------------------
normUpWeights

## -----------------------------------------------------------------------------
downWeights <- computeDWNW(g, freqs, no.of.children, A, normUpWeights)

## ----echo=F-------------------------------------------------------------------
downWeights

## -----------------------------------------------------------------------------
normDownWeights <- normalizeDWNW(g, freqs, no.of.children, A, downWeights)

## ----echo=F-------------------------------------------------------------------
normDownWeights

## -----------------------------------------------------------------------------
draw_ggraph(quick_run(example_dataset()))

## ----results = 'hide'---------------------------------------------------------
draw_networkD3(quick_run(example_dataset()))

## ----echo=FALSE, out.width = "100%", out.height="100%"------------------------
knitr::include_graphics("networkD3.png")

## ----results = 'hide'---------------------------------------------------------
draw_visNetwork(quick_run(example_dataset()))

## ----echo=FALSE, out.width = "100%", out.height="100%"------------------------
knitr::include_graphics("visGraph.png")

## -----------------------------------------------------------------------------
cat(to_dot(quick_run(example_dataset())))

## -----------------------------------------------------------------------------
sessionInfo()

## ----echo=FALSE---------------------------------------------------------------
# run ALL

