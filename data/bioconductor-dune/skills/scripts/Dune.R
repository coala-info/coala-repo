# Code example from 'Dune' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("Dune")

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
  library(RColorBrewer)
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  library(knitr)
  library(purrr)
  library(Dune)
})
data("nuclei", package = "Dune")
theme_set(theme_classic())

## -----------------------------------------------------------------------------
ggplot(nuclei, aes(x = x, y = y, col = subclass_label)) +
  geom_point()

## ----fig.hold='hold', out.width="33%", fig.height=9---------------------------
walk(c("SC3", "Seurat", "Monocle"), function(clus_algo){
  df <- nuclei
  df$clus_algo <- nuclei[, clus_algo]
  p <- ggplot(df, aes(x = x, y = y, col = as.character(clus_algo))) +
    geom_point(size = 1.5) +
    # guides(color = FALSE) +
    labs(title = clus_algo, col = "clusters") +
    theme(legend.position = "bottom")
  print(p)
})

## -----------------------------------------------------------------------------
plotARIs(nuclei %>% select(SC3, Seurat, Monocle))

## -----------------------------------------------------------------------------
merger <- Dune(clusMat = nuclei %>% select(SC3, Seurat, Monocle), verbose = TRUE)

## -----------------------------------------------------------------------------
names(merger)

## -----------------------------------------------------------------------------
plotARIs(clusMat = merger$currentMat)

## -----------------------------------------------------------------------------
plotPrePost(merger)

## -----------------------------------------------------------------------------
ConfusionPlot(merger$initialMat[, "SC3"], merger$currentMat[, "SC3"]) +
  labs(x = "Before merging", y = "After merging")

## -----------------------------------------------------------------------------
ARItrend(merger)

## -----------------------------------------------------------------------------
sessionInfo()

