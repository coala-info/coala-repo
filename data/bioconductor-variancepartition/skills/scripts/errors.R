# Code example from 'errors' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"------------------------------------------------------------
knitr::opts_chunk$set(
  tidy = FALSE, cache = TRUE,
  dev = "png",
  package.startup.message = FALSE,
  message = FALSE, error = FALSE, warning = TRUE
)
options(width = 100)

## ----error, eval=FALSE----------------------------------------------------------------------------
# library(variancePartition)
# data(varPartData)
# 
# # Redundant formula
# # This example is an extreme example of redundancy
# # but more subtle cases often show up in real data
# form <- ~ Tissue + (1 | Tissue)
# 
# fit <- dream(geneExpr[1:30, ], form, info)
# 
# ## Warning in dream(geneExpr[1:30, ], form, info): Model failed for 29 responses.
# ##   See errors with attr(., 'errors')
# 
# # Extract gene-level errors
# attr(fit, "errors")[1:2]
# 
# ## gene1
# ## "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol): (converted from warning)
# ## Model may not have converged with 1 eigenvalue close to zero: -2.0e-09\n"
# 
# ## gene2
# ## "Error: (converted from warning) Model failed to converge
# ##   with 1 negative eigenvalue: -1.5e-08\n"

## ----eval=FALSE, echo=TRUE------------------------------------------------------------------------
# library(BiocParallel)
# 
# # globally specify that all multithreading using bpiterate from BiocParallel
# # should use 8 cores
# register(SnowParam(8))

## ----eval=FALSE, echo=TRUE------------------------------------------------------------------------
# fitExtractVarPartModel(..., BPPARAM = SnowParam(8))
# 
# fitVarPartModel(..., BPPARAM = SnowParam(8))
# 
# dream(..., BPPARAM = SnowParam(8))
# 
# voomWithDreamWeights(..., BPPARAM = SnowParam(8))

## ----session, echo=FALSE--------------------------------------------------------------------------
sessionInfo()

