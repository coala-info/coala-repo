# Code example from 'geva' vignette. See references/ for full tutorial.

## ----load-packages, include=FALSE---------------------------------------------
if (!("package:geva" %in% search()))
{
  if (!exists('lev'))
    lev = 0
  devtools::load_all(getwd())
}

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  results='hide',
  message=FALSE,
  warning=FALSE,
  comment = "#>",
  fig.pos='H',
  fig.show='hold',
  dev = 'png',
  fig.width = 9,
  fig.height = 6,
  dpi=300
)

## ----pkg-install, eval=FALSE--------------------------------------------------
# BiocManager::install("geva")

## ----lib-load, eval=FALSE-----------------------------------------------------
# library(geva)

## ----geva-read-tables, eval=FALSE---------------------------------------------
# # Replace the file names below with actual file paths
# filenms <- c("cond_A_2h.txt", "cond_B_2h.txt", "cond_C_2h.txt",
#              "cond_A_4h.txt", "cond_B_4h.txt", "cond_C_4h.txt")
# ginput <- geva.read.tables(filenms)

## ----geva-merge-input-1, eval=FALSE-------------------------------------------
# # dt1 and dt2 are examples of input data.frames
# # containing logFC and adj.P.Val columns
# ginput <- geva.merge.input(dt1, dt2)

## ----geva-merge-input-2, eval=FALSE-------------------------------------------
# # malm1 and malm2 are MArrayLM objects produced by
# # limma (e.g., using eBayes)
# dt1 <- topTable(malm1, number=999999, sort.by="none")
# dt2 <- topTable(malm2, number=999999, sort.by="none")
# ginput <- geva.merge.input(dt1, dt2)

## ----geva-ideal-example, eval=TRUE--------------------------------------------
# (optional) Sets the initial seed to reproduce the
# results presented here
set.seed(1)
# Generates a random GEVAInput with 10000 probes
# and 6 columns
ginput <- geva.ideal.example()

## ----geva-input-correct, eval=TRUE--------------------------------------------
# Removes the rows containing missing and infinite values
ginput <- geva.input.correct(ginput)

## ----geva-input-filter, eval=FALSE--------------------------------------------
# # Removes the rows that are entirely composed by
# # insignificant values
# ginput <- geva.input.filter(ginput, p.value.cutoff = 0.05)

## ----geva-input-rename-rows, eval=FALSE---------------------------------------
# # Replaces the row names with the "Symbol" column while
# # selecting the most significant duplicates
# ginput <- geva.input.rename.rows(ginput,
#                                  attr.column = "Symbol")

## ----geva-summarize-1, eval=TRUE----------------------------------------------
# Summarizes ginput to find the SV points
gsummary <- geva.summarize(ginput)

## ----geva-summarize-2, eval=FALSE---------------------------------------------
# # Summarizes ginput using median and MAD
# gsummary <- geva.summarize(ginput,
#                            summary.method = "median",
#                            variation.method = "mad")

## ----plot-geva-summary, fig.cap="SV-plot produced from a `GEVASummary` object using the `geva.summarize` function with default parameters."----
plot(gsummary)

## ----geva-quantiles-1, eval=TRUE----------------------------------------------
# Calculates the quantiles from a GEVASummary object
gquants <- geva.quantiles(gsummary)

## ----plot-geva-quantiles-1, fig.cap="SV-plot produced from a `GEVAQuantiles` object using the `geva.quantiles` function with default parameters."----
plot(gquants)

## ----geva-quantiles-2, eval=FALSE---------------------------------------------
# # Calculates the quantiles from a GEVASummary object
# # using custom delimiters
# gquants <- geva.quantiles(gsummary,
#                           initial.thresholds = c(S=1, V=0.5))

## ----plot-geva-quantiles-2, echo=FALSE, fig.cap="SV-plot produced from a `GEVAQuantiles` object using the `geva.quantiles` function using the `initial.thresholds = c(S=1, V=0.5)` parameter."----
if (!exists("gquants2"))
  gquants2 <- geva.quantiles(gsummary, initial.thresholds = c(S=1, V=0.5))
plot(gquants2)

## ----geva-cluster, eval=FALSE-------------------------------------------------
# # Applies cluster analysis (30% resolution)
# gcluster <- geva.cluster(gsummary,
#                          cluster.method="hierarchical",
#                          resolution=0.3)

## ----include=FALSE------------------------------------------------------------
if (!exists("gcluster"))
{
  gcluster <- geva.cluster(gsummary, cluster.method="hierarchical", resolution=0.3)
  infolist(gcluster)$colors <- color.values(gcluster)
}

## ----plot-geva-cluster, fig.cap="SV-plot produced from a `GEVACluster` object using the `geva.cluster` function with the hierarchical method and 30% of resolution."----
plot(gcluster)

## ----geva-cluster-grouped-1, eval=TRUE----------------------------------------
# Applies cluster analysis with default parameters and
# returns a GEVAGroupedSummary
ggroupedsummary <- geva.cluster(gsummary,
                                grouped.return = TRUE)

## ----plot-geva-cluster-grouped, eval=TRUE, fig.cap="SV-plot produced from a `GEVAGroupedSummary` object after appending the `GEVAQuantiles` and `GEVACluster` objects from previous steps."----
# Makes a safe copy of the summary data
ggroupedsummary <- gsummary
# Appends the quantiles data
groupsets(ggroupedsummary) <- gquants
# Appends the clustered data
groupsets(ggroupedsummary) <- gcluster

# Draws a SV plot with grouped highlights (optional)
plot(ggroupedsummary)

## ----geva-finalize-1, eval=TRUE-----------------------------------------------
# Calculates the final classifications based on the
# intermediate results from previous steps
gresults <- geva.finalize(gsummary, gquants, gcluster)

## ----geva-finalize-grouped-1, eval=TRUE---------------------------------------
# Calculates the final classifications based on the
# intermediate results from previous steps
gresults <- geva.finalize(ggroupedsummary)

## ----factors-assign, eval=TRUE------------------------------------------------
# Assigning factors to an example input with 9 columns

# Example with GEVAInput
factors(ginput) <- c('g1', 'g1', 'g1',
                     'g2', 'g2', 'g2',
                     'g3', 'g3', 'g3')

# Example with GEVAInput (using factor class)
factors(ginput) <- factor(c('g1', 'g1', 'g1',
                            'g2', 'g2', 'g2',
                            'g3', 'g3', 'g3'))

# Example with GEVASummary
factors(gsummary) <- c('g1', 'g1', 'g1',
                       'g2', 'g2', 'g2',
                       'g3', 'g3', 'g3')


## ----geva-finalize-2, eval=TRUE-----------------------------------------------
# Calculates the final classifications based on the
# intermediate results from previous steps
gresults <- geva.finalize(gsummary, gquants, gcluster,
                          p.value=0.05)

## ----geva-finalize-grouped-2, eval=TRUE---------------------------------------
# Calculates the final classifications based on the
# intermediate results from previous steps
gresults <- geva.finalize(ggroupedsummary, p.value=0.05)

## ----include=FALSE------------------------------------------------------------
if (!exists("gresults"))
{
  gresults <- geva.finalize(ggroupedsummary)
}

## ----plot-geva-results, fig.cap="SV-plot produced from a `GEVAResults` object using the `geva.finalize` function with `0.05` as p-value cutoff."----
plot(gresults)

## ----results-table-1, eval=FALSE----------------------------------------------
# tail(results.table(gresults), 10)

## ----results-table-1-tail, echo=FALSE, results='asis'-------------------------
knitr::kable(tail(results.table(gresults), 10))

## ----top-genes, eval=FALSE----------------------------------------------------
# # Extracts the top genes only
# dtgens <- top.genes(gresults)
# 
# # Extracts the top genes and appends the "Symbol" column
# dtgens <- top.genes(gresults, add.cols = "Symbol")
# 
# # Prints the last lines of the top genes table (optional)
# print(tail(dtgens, 10))

## ----top-genes-tail, echo=FALSE, results='asis'-------------------------------
if (!exists("dtgens"))
  dtgens <- top.genes(gresults, add.cols = "Symbol")
knitr::kable(tail(dtgens, 10))

## ----geva-quick-1, eval=FALSE-------------------------------------------------
# # Generates a random GEVAInput example
# ginput <- geva.ideal.example()
# # Performs all intermediate steps with geva.quick
# # The resolution is used by the call to geva.cluster
# gresults <- geva.quick(ginput, resolution=0.25)
# ## > Found 4 clusters and 31 significant genes
# gresults <- geva.quick(ginput, resolution=0.4)
# ## > Found 16 clusters and 116 significant genes

## ----geva-quick-2, eval=FALSE-------------------------------------------------
# # Generates a random GEVAInput example
# ginput <- geva.ideal.example()
# # Performs all intermediate steps with geva.quick
# # The summary.method is used by the call to geva.summarize
# gresults <- geva.quick(ginput, summary.method='mean')
# ## > Found 60 significant genes
# gresults <- geva.quick(gresults, summary.method='median')
# ## > Found 95 significant genes

