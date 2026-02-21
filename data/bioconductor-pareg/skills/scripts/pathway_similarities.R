# Code example from 'pathway_similarities' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(tidyverse)
library(ComplexHeatmap)
library(circlize)
library(GGally)

library(pareg)
data(pathway_similarities, package = "pareg")

set.seed(42)

## -----------------------------------------------------------------------------
mat <- pathway_similarities$`C2@CP:KEGG`$jaccard %>%
  as_dense_sim()
mat[1:3, 1:3]

Heatmap(
  mat,
  name = "similarity",
  col = colorRamp2(c(0, 1), c("white", "black")),
  show_row_names = FALSE,
  show_column_names = FALSE
)

## -----------------------------------------------------------------------------
df_sim <- pathway_similarities$`C5@GO:BP` %>%
  map_dfr(function(mat) {
    if (is.null(mat)) {
      return(NULL)
    }

    mat %>%
      as_dense_sim() %>%
      as.data.frame %>%
      rownames_to_column() %>%
      pivot_longer(-rowname)
  }, .id = "measure") %>%
  filter(value > 0) %>%
  pivot_wider(names_from = measure, values_from = value) %>%
  select(-rowname, -name)

ggpairs(df_sim) +
  theme_minimal()

## -----------------------------------------------------------------------------
sessionInfo()

