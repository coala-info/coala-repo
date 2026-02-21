# Code example from 'non_lin_eff' vignette. See references/ for full tutorial.

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

sce$id <- paste0(sce$StimStatus, sce$ind)

# Create pseudobulk
pb <- aggregateToPseudoBulk(sce,
  assay = "counts",
  cluster_id = "cell",
  sample_id = "id",
  verbose = FALSE
)

## ----Age----------------------------------------------------------------------
# Simulate age between 18 and 65
pb$Age <- runif(ncol(pb), 18, 65)

# formula included non-linear effects of Age
# by using a natural spline of degree 3
# This corresponds to using 3 coefficients instead of 1
form <- ~ splines::ns(Age, 3)

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# The spline has degree 3, so there are 3 coefficients
# estimated for Age effects
coefNames(res.dl)

# Jointly test effects of the 3 spline components
# The test of the 3 coefficients is performed with an F-statistic
topTable(res.dl, coef = coefNames(res.dl)[2:4], number = 3)

## ----eval=FALSE---------------------------------------------------------------
# ord <- c("time_1", "time_2", "time_3", "time_4")
# ordered(factor(TimePoint), ord)

## ----timepoint----------------------------------------------------------------
# Consider data generated across 4 time points
# While there are no time points in the real data
# we can add some for demonstration purposes
pb$TimePoint <- ordered(paste0("time_", rep(1:4, 4)))

# examine the ordering
pb$TimePoint

# Use formula including time point
form <- ~TimePoint

# Normalize and apply voom/voomWithDreamWeights
res.proc <- processAssays(pb, form, min.count = 5)

# Differential expression analysis within each assay
res.dl <- dreamlet(res.proc, form)

# Examine the coefficient estimated
# for TimePoint it estimates
# linear (i.e. L)
# quadratic (i.e. Q)
# and cubic (i.e. C) effects
coefNames(res.dl)

# Test only linear effect
topTable(res.dl, coef = "TimePoint.L", number = 3)

# Test linear, quadratic and cubic effcts
coefs <- c("TimePoint.L", "TimePoint.Q", "TimePoint.C")
topTable(res.dl, coef = coefs, number = 3)

## ----details------------------------------------------------------------------
details(res.dl)

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

