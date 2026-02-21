# Code example from 'pathway_databases' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(tidyverse)
library(ggplot2)

library(dce)

set.seed(42)

## -----------------------------------------------------------------------------
dce::df_pathway_statistics %>%
  sample_n(10) %>%
  arrange(desc(node_num)) %>%
  knitr::kable()

## -----------------------------------------------------------------------------
dce::df_pathway_statistics %>%
  count(database, sort = TRUE, name = "pathway_number") %>%
  knitr::kable()

## -----------------------------------------------------------------------------
dce::df_pathway_statistics %>%
  ggplot(aes(x = node_num)) +
    geom_histogram(bins = 30) +
    facet_wrap(~ database, scales = "free") +
    theme_minimal()

## -----------------------------------------------------------------------------
pathways <- get_pathways(
  pathway_list = list(
    kegg = c("Citrate cycle (TCA cycle)")
  )
)

lapply(pathways, function(x) {
  plot_network(as(x$graph, "matrix"), visualize_edge_weights = FALSE) +
    ggtitle(x$pathway_name)
})

## -----------------------------------------------------------------------------
sessionInfo()

