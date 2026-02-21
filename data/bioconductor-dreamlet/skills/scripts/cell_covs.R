# Code example from 'cell_covs' vignette. See references/ for full tutorial.

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

## ----preprocess.data----------------------------------------------------------
library(dreamlet)
library(muscat)
library(ExperimentHub)
library(scater)

# Download data, specifying EH2259 for the Kang, et al study
eh <- ExperimentHub()
sce <- eh[["EH2259"]]

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

## ----variable-----------------------------------------------------------------
sce$value1 <- rnorm(ncol(sce))
sce$value2 <- rnorm(ncol(sce))

## ----aggregate----------------------------------------------------------------
sce$id <- paste0(sce$StimStatus, sce$ind)

# Create pseudobulk
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",
  cluster_id = "cell",
  sample_id = "id",
  verbose = FALSE
)

## ----aggr_means---------------------------------------------------------------
metadata(pb)$aggr_means

## ----processAssays, fig.height=8----------------------------------------------
form <- ~ StimStatus + value1 + value2

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# run variance partitioning analysis
vp.lst <- fitVarPart(res.proc, form)

# Summarize variance fractions genome-wide for each cell type
plotVarPart(vp.lst, label.angle = 60)

# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# dreamlet results include coefficients for value1 and value2
res.dl

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

