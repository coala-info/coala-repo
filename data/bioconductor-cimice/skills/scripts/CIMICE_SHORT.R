# Code example from 'CIMICE_SHORT' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(CIMICE)
library(dplyr)
library(igraph)
library(Matrix)
library(purrr)

## ----cars, results=FALSE------------------------------------------------------
# read from file
read_CAPRI(system.file("extdata", "example.CAPRI", package = "CIMICE", mustWork = TRUE))

## -----------------------------------------------------------------------------
# from a string
read_CAPRI_string("
s\\g A B C D
S1 0 0 0 1
S2 1 0 0 0
S3 1 0 0 0
S4 1 0 0 1
S5 1 1 0 1
S6 1 1 0 1
S7 1 0 1 1
S8 1 1 0 1
")

## -----------------------------------------------------------------------------
# using CIMICE::make_dataset and CIMICE::update_df
# genes
make_dataset(A,B,C,D) %>% 
    # samples
    update_df("S1", 0, 0, 0, 1) %>%
    update_df("S2", 1, 0, 0, 0) %>%
    update_df("S3", 1, 0, 0, 0) %>%
    update_df("S4", 1, 0, 0, 1) %>%
    update_df("S5", 1, 1, 0, 1) %>%
    update_df("S6", 1, 1, 0, 1) %>%
    update_df("S7", 1, 0, 1, 1) %>%
    update_df("S8", 1, 1, 0, 1)

## -----------------------------------------------------------------------------
preproc <- dataset_preprocessing(example_dataset())
samples <- preproc[["samples"]]
freqs   <- preproc[["freqs"]]
labels  <- preproc[["labels"]]
genes   <- preproc[["genes"]]

## -----------------------------------------------------------------------------
g <- graph_non_transitive_subset_topology(samples,labels)

## ----echo=FALSE---------------------------------------------------------------
V(g)$vertex.size <- rep(10, length(V(g)))
plot(g, vertex.size=rep(55, length(V(g))))

## -----------------------------------------------------------------------------
W <- compute_weights_default(g, freqs)

## -----------------------------------------------------------------------------
out <- quick_run(example_dataset()) # quick_run summarizes all the previous steps
draw_visNetwork(out)

