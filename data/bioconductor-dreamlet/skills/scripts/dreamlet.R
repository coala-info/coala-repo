# Code example from 'dreamlet' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  error = FALSE,
  tidy = FALSE,
  dev = c("png"),
  cache = TRUE
)

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# # Select release #1 or #2
# 
# # 1) Bioconductor release
# BiocManager::install("dreamlet")
# 
# # 2) Latest stable release
# devtools::install_github("DiseaseNeurogenomics/dreamlet")

## ----preprocess.data----------------------------------------------------------
library(dreamlet)
library(muscat)
library(ExperimentHub)
library(zenith)
library(scater)

# Download data, specifying EH2259 for the Kang, et al study
eh <- ExperimentHub()
sce <- eh[["EH2259"]]

sce$ind = as.character(sce$ind)

# only keep singlet cells with sufficient reads
sce <- sce[rowSums(counts(sce) > 0) > 0, ]
sce <- sce[, colData(sce)$multiplets == "singlet"]

# compute QC metrics
qc <- perCellQCMetrics(sce)

# remove cells with few or many detected genes
ol <- isOutlier(metric = qc$detected, nmads = 2, log = TRUE)
sce <- sce[, !ol]

# set variable indicating stimulated (stim) or control (ctrl)
sce$StimStatus <- sce$stim

## ----aggregate----------------------------------------------------------------
# Since 'ind' is the individual and 'StimStatus' is the stimulus status,
# create unique identifier for each sample
sce$id <- paste0(sce$StimStatus, sce$ind)

# Create pseudobulk data by specifying cluster_id and sample_id
# Count data for each cell type is then stored in the `assay` field
# assay: entry in assayNames(sce) storing raw counts
# cluster_id: variable in colData(sce) indicating cell clusters
# sample_id: variable in colData(sce) indicating sample id for aggregating cells
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",
  cluster_id = "cell",
  sample_id = "id",
  verbose = FALSE
)

# one 'assay' per cell type
assayNames(pb)

## ----dreamlet, fig.width=8, fig.height=8--------------------------------------
# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, ~StimStatus, min.count = 5)

# the resulting object of class dreamletProcessedData stores
# normalized data and other information
res.proc

## ----details------------------------------------------------------------------
# view details of dropping samples
details(res.proc)

## ----voom.plots, fig.height=7-------------------------------------------------
# show voom plot for each cell clusters
plotVoom(res.proc)

# Show plots for subset of cell clusters
# plotVoom( res.proc[1:3] )

# Show plots for one cell cluster
# plotVoom( res.proc[["B cells"]])

## ----vp-----------------------------------------------------------------------
# run variance partitioning analysis
vp.lst <- fitVarPart(res.proc, ~StimStatus)

## ----vp.barplt, fig.height=3--------------------------------------------------
# Show variance fractions at the gene-level for each cell type
genes <- vp.lst$gene[2:4]
plotPercentBars(vp.lst[vp.lst$gene %in% genes, ])

## ----vp.violin, fig.height=7--------------------------------------------------
# Summarize variance fractions genome-wide for each cell type
plotVarPart(vp.lst, label.angle = 60)

## ----test---------------------------------------------------------------------
# Differential expression analysis within each assay,
# evaluated on the voom normalized data
res.dl <- dreamlet(res.proc, ~StimStatus)

# names of estimated coefficients
coefNames(res.dl)

# the resulting object of class dreamletResult
# stores results and other information
res.dl

## ----plotVolcano, fig.width=8, fig.height=8-----------------------------------
plotVolcano(res.dl, coef = "StimStatusstim")

## ----plotGeneHeatmap, fig.height=3--------------------------------------------
genes <- c("ISG20", "ISG15")
plotGeneHeatmap(res.dl, coef = "StimStatusstim", genes = genes)

## ----extract------------------------------------------------------------------
# results from full analysis
topTable(res.dl, coef = "StimStatusstim")

# only B cells
topTable(res.dl[["B cells"]], coef = "StimStatusstim")

## ----forrest------------------------------------------------------------------
plotForest(res.dl, coef = "StimStatusstim", gene = "ISG20")

## ----boxplot------------------------------------------------------------------
# get data
df <- extractData(res.proc, "CD14+ Monocytes", genes = "ISG20")

# set theme
thm <- theme_classic() +
  theme(aspect.ratio = 1, plot.title = element_text(hjust = 0.5))

# make plot
ggplot(df, aes(StimStatus, ISG20)) +
  geom_boxplot() +
  thm +
  ylab(bquote(Expression ~ (log[2] ~ CPM))) +
  ggtitle("ISG20")

## ----dreamlet.contrasts-------------------------------------------------------
# create a contrasts called 'Diff' that is the difference between expression
# in the stimulated and controls.
# More than one can be specified
contrasts <- c(Diff = "StimStatusstim - StimStatusctrl")

# Evalaute the regression model without an intercept term.
# Instead estimate the mean expression in stimulated, controls and then
# set Diff to the difference between the two
res.dl2 <- dreamlet(res.proc, ~ 0 + StimStatus, contrasts = contrasts)

# see estimated coefficients
coefNames(res.dl2)

# Volcano plot of Diff
plotVolcano(res.dl2[1:2], coef = "Diff")

## ----zenith-------------------------------------------------------------------
# Load Gene Ontology database
# use gene 'SYMBOL', or 'ENSEMBL' id
# use get_MSigDB() to load MSigDB
# Use Cellular Component (i.e. CC) to reduce run time here
go.gs <- get_GeneOntology("CC", to = "SYMBOL")

# Run zenith gene set analysis on result of dreamlet
res_zenith <- zenith_gsa(res.dl, coef = "StimStatusstim", go.gs)

# examine results for each ell type and gene set
head(res_zenith)

## ----heatmap, fig.height=10, fig.width=8--------------------------------------
# for each cell type select 5 genesets with largest t-statistic
# and 1 geneset with the lowest
# Grey boxes indicate the gene set could not be evaluted because
#    to few genes were represented
plotZenithResults(res_zenith, 5, 1)

## ----heatmap2, fig.height=10, fig.width=8-------------------------------------
# get genesets with FDR < 30%
# Few significant genesets because uses Cellular Component (i.e. CC)
gs <- unique(res_zenith$Geneset[res_zenith$FDR < 0.3])

# keep only results of these genesets
df <- res_zenith[res_zenith$Geneset %in% gs, ]

# plot results, but with no limit based on the highest/lowest t-statistic
plotZenithResults(df, Inf, Inf)

## ----dreamletCompareClusters--------------------------------------------------
# test differential expression between B cells and the rest of the cell clusters
ct.pairs <- c("CD4 T cells", "rest")

fit <- dreamletCompareClusters(pb, ct.pairs, method = "fixed")

# The coefficient 'compare' is the value logFC between test and baseline:
# compare = cellClustertest - cellClusterbaseline
df_Bcell <- topTable(fit, coef = "compare")

head(df_Bcell)

## ----cellTypeSpecificity------------------------------------------------------
df_cts <- cellTypeSpecificity(pb)

# retain only genes with total CPM summed across cell type > 100
df_cts <- df_cts[df_cts$totalCPM > 100, ]

# Violin plot of specificity score for each cell type
plotViolin(df_cts)

## ----plotPercentBars----------------------------------------------------------
genes <- rownames(df_cts)[apply(df_cts, 2, which.max)]
plotPercentBars(df_cts, genes = genes)

dreamlet::plotHeatmap(df_cts, genes = genes)

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

