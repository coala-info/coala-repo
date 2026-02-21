# Code example from 'dce' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#  if (!require("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("dce")

## ----message=FALSE------------------------------------------------------------
# fix "object 'guide_edge_colourbar' of mode 'function' was not found"
# when building vignettes
# (see also https://github.com/thomasp85/ggraph/issues/75)
library(ggraph)

library(curatedTCGAData)
library(TCGAutils)
library(SummarizedExperiment)

library(tidyverse)
library(cowplot)
library(graph)
library(dce)

set.seed(42)

## -----------------------------------------------------------------------------
graph_wt <- matrix(c(0, 0, 0, 1, 0, 0, 1, 1, 0), 3, 3)
rownames(graph_wt) <- colnames(graph_wt) <- c("A", "B", "C")
graph_wt

## -----------------------------------------------------------------------------
graph_mt <- graph_wt
graph_mt["A", "B"] <- 2.5 # dysregulation happens here!
graph_mt

cowplot::plot_grid(
  plot_network(graph_wt, edgescale_limits = c(-3, 3)),
  plot_network(graph_mt, edgescale_limits = c(-3, 3)),
  labels = c("WT", "MT")
)

## -----------------------------------------------------------------------------
X_wt <- simulate_data(graph_wt)
X_mt <- simulate_data(graph_mt)

X_wt %>%
  head

## -----------------------------------------------------------------------------
res <- dce(graph_wt, X_wt, X_mt, solver = "lm")

res %>%
  as.data.frame %>%
  drop_na

## -----------------------------------------------------------------------------
plot(res) +
  ggtitle("Differential Causal Effects between WT and MT condition")

## -----------------------------------------------------------------------------
brca <- curatedTCGAData(
  diseaseCode = "BRCA",
  assays = c("RNASeq2*"),
  version = "2.0.1",
  dry.run = FALSE
)

## -----------------------------------------------------------------------------
sampleTables(brca)

data(sampleTypes, package = "TCGAutils")
sampleTypes %>%
  filter(Code %in% c("01", "06", "11"))

## -----------------------------------------------------------------------------
# split assays
brca_split <- splitAssays(brca, c("01", "11"))

# only retain matching samples
brca_matched <- as(brca_split, "MatchedAssayExperiment")

brca_wt <- assay(brca_matched, "01_BRCA_RNASeq2GeneNorm-20160128")
brca_mt <- assay(brca_matched, "11_BRCA_RNASeq2GeneNorm-20160128")

## -----------------------------------------------------------------------------
pathways <- get_pathways(pathway_list = list(kegg = c("Breast cancer")))
brca_pathway <- pathways[[1]]$graph

## -----------------------------------------------------------------------------
shared_genes <- intersect(nodes(brca_pathway), rownames(brca_wt))
glue::glue(
  "Covered nodes: {length(shared_genes)}/{length(nodes(brca_pathway))}"
)

## ----warning=FALSE------------------------------------------------------------
res <- dce::dce(brca_pathway, t(brca_wt), t(brca_mt), solver = "lm")

## -----------------------------------------------------------------------------
res %>%
  as.data.frame %>%
  drop_na %>%
  arrange(desc(abs(dce))) %>%
  head

plot(res, nodesize = 20, labelsize = 1, use_symlog = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

