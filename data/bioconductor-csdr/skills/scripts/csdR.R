# Code example from 'csdR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("csdR")

## -----------------------------------------------------------------------------
library(csdR)

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
    library(magrittr)
    library(igraph)
    library(glue)
    library(dplyr)
})
set.seed(45394534)

## -----------------------------------------------------------------------------
data("sick_expression")
data("normal_expression")
csd_results <- run_csd(
    x_1 = sick_expression, x_2 = normal_expression,
    n_it = 10, nThreads = 2L, verbose = FALSE
)

## -----------------------------------------------------------------------------
pairs_to_pick <- 100L
c_filter <- partial_argsort(csd_results$cVal, pairs_to_pick)
c_frame <- csd_results[c_filter, ]
s_filter <- partial_argsort(csd_results$sVal, pairs_to_pick)
s_frame <- csd_results[s_filter, ]
d_filter <- partial_argsort(csd_results$dVal, pairs_to_pick)
d_frame <- csd_results[d_filter, ]

## -----------------------------------------------------------------------------
csd_filter <- c_filter %>%
    union(s_filter) %>%
    union(d_filter)
csd_frame <- csd_results[csd_filter, ]

## -----------------------------------------------------------------------------
c_network <- graph_from_data_frame(c_frame, directed = FALSE)
s_network <- graph_from_data_frame(s_frame, directed = FALSE)
d_network <- graph_from_data_frame(d_frame, directed = FALSE)
E(c_network)$edge_type <- "C"
E(s_network)$edge_type <- "S"
E(d_network)$edge_type <- "D"
combined_network <- igraph::union(c_network, s_network, d_network)
# Auxillary function for combining
# the attributes of the three networks in a proper way
join_attributes <- function(graph, attribute) {
    ifelse(
        test = is.na(edge_attr(graph, glue("{attribute}_1"))),
        yes = ifelse(
            test = is.na(edge_attr(graph, glue("{attribute}_2"))),
            yes = edge_attr(graph, glue("{attribute}_3")),
            no = edge_attr(graph, glue("{attribute}_2"))
        ),
        no = edge_attr(graph, glue("{attribute}_1"))
    )
}
E(combined_network)$edge_type <- join_attributes(combined_network, "edge_type")
layout <- layout_nicely(combined_network)
E(combined_network)$color <- recode(E(combined_network)$edge_type,
    C = "darkblue", S = "green", D = "darkred"
)
plot(combined_network, layout = layout,
    vertex.size = 3, edge.width = 2, vertex.label.cex = 0.001)

## -----------------------------------------------------------------------------
sessionInfo()

