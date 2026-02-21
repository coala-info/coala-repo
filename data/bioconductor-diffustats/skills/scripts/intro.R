# Code example from 'intro' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE, message = FALSE, error = FALSE, 
    fig.width = 7, fig.height = 6)

## -----------------------------------------------------------------------------
library(diffuStats)
data("graph_toy")

## -----------------------------------------------------------------------------
graph_toy
plot(graph_toy)

## -----------------------------------------------------------------------------
input_vec <- graph_toy$input_vec

head(input_vec, 15)

## -----------------------------------------------------------------------------
length(input_vec)

## -----------------------------------------------------------------------------
output_vec <- diffuStats::diffuse(
    graph = graph_toy, 
    method = "raw", 
    scores = input_vec)

head(output_vec, 15)

## -----------------------------------------------------------------------------
igraph::plot.igraph(
    graph_toy, 
    vertex.color = diffuStats::scores2colours(output_vec),
    vertex.shape = diffuStats::scores2shapes(input_vec),
    main = "Diffusion scores in our lattice"
)

## -----------------------------------------------------------------------------
input_mat <- graph_toy$input_mat

head(input_mat)

## -----------------------------------------------------------------------------
output_mc <- diffuStats::diffuse(
    graph = graph_toy, 
    method = "mc", 
    scores = input_mat)

head(output_mc)

## -----------------------------------------------------------------------------
score_col <- 4
igraph::plot.igraph(
    graph_toy, 
    vertex.color = diffuStats::scores2colours(output_mc[, score_col]),
    vertex.shape = diffuStats::scores2shapes(input_mat[, score_col]),
    main = "Diffusion scores in our lattice"
)

## -----------------------------------------------------------------------------
df_perf <- perf(
    graph = graph_toy,
    scores = graph_toy$input_mat,
    validation = graph_toy$input_mat[1:15, ],
    grid_param = expand.grid(method = c("raw", "ml")))
df_perf

## -----------------------------------------------------------------------------
df_perf <- perf(
    graph = graph_toy,
    scores = graph_toy$input_mat[1:20, 3:4],
    validation = graph_toy$input_mat[21:48, 3:4],
    grid_param = expand.grid(method = c("raw", "ml")))
df_perf

## -----------------------------------------------------------------------------
sessionInfo()

