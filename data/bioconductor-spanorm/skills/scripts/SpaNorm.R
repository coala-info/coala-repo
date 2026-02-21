# Code example from 'SpaNorm' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

# load libraries without messages
library(SpaNorm)
library(ggplot2)
library(patchwork)
library(SpatialExperiment)

update_geom_defaults("point", aes(size = 0.5))

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # release version
# BiocManager::install("SpaNorm")
# # development version from GitHub
# BiocManager::install("bhuvad/SpaNorm")

## ----fig.width=4, fig.height=4.25---------------------------------------------
library(SpaNorm)
library(SpatialExperiment)
library(ggplot2)

# load sample data
data(HumanDLPFC)
# change gene IDs to gene names
rownames(HumanDLPFC) = rowData(HumanDLPFC)$gene_name
HumanDLPFC

# plot regions
p_region = plotSpatial(HumanDLPFC, colour = AnnotatedCluster, size = 0.5) +
  scale_colour_brewer(palette = "Paired", guide = guide_legend(override.aes = list(shape = 15, size = 5))) +
  ggtitle("Region")
p_region

## -----------------------------------------------------------------------------
# filter genes expressed in 20% of spots
keep = filterGenes(HumanDLPFC, 0.2)
table(keep)
# subset genes
HumanDLPFC = HumanDLPFC[keep, ]

## ----fig.width=7.5, fig.height=4.25-------------------------------------------
logcounts(HumanDLPFC) = log2(counts(HumanDLPFC) + 1)

p_counts = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logCounts")
p_region + p_counts

## ----message=TRUE-------------------------------------------------------------
set.seed(36)
HumanDLPFC = SpaNorm(HumanDLPFC)
HumanDLPFC

## ----fig.width=7.5, fig.height=4.25-------------------------------------------
p_logpac = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC")
p_region + p_logpac

## -----------------------------------------------------------------------------
# manually retrieve model
fit.spanorm = metadata(HumanDLPFC)$SpaNorm
fit.spanorm

## ----fig.width=11.5, fig.height=8.5-------------------------------------------
# Pearson residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "pearson")
p_pearson = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Pearson")

# meanbio residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "meanbio")
p_meanbio = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Mean biology")

# meanbio residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "medbio")
p_medbio = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Median biology")

p_region + p_counts + p_logpac + p_pearson + p_meanbio + p_medbio + plot_layout(ncol = 3)

## ----fig.width=7.5, fig.height=4.25-------------------------------------------
# df.tps = 2
HumanDLPFC_df2 = SpaNorm(HumanDLPFC, df.tps = 2)
p_logpac_2 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (df.tps = 2)")

# df.tps = 6 (default)
p_logpac_6 = p_logpac +
  ggtitle("logPAC (df.tps = 6)")

p_logpac_2 + p_logpac_6

## ----fig.width=7.5, fig.height=4.25-------------------------------------------
# scale.factor = 1 (default)
HumanDLPFC = SpaNorm(HumanDLPFC, scale.factor = 1)
p_logpac_sf1 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (scale.factor = 1)")

# scale.factor = 4
HumanDLPFC = SpaNorm(HumanDLPFC, scale.factor = 4)
p_logpac_sf4 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (scale.factor = 4)")

p_logpac_sf1 + p_logpac_sf4 + plot_layout(ncol = 2)

## -----------------------------------------------------------------------------
sessionInfo()

