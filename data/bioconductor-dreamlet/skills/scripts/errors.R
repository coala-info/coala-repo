# Code example from 'errors' vignette. See references/ for full tutorial.

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

## ----lme4, eval=FALSE---------------------------------------------------------
# library(lme4)
# 
# # Fit simple mixed model
# lmer(Reaction ~ (1 | Subject), sleepstudy)
# # Error in initializePtr() :
# #  function 'chm_factor_ldetL2' not provided by package 'Matrix'

## ----install, eval=FALSE------------------------------------------------------
# install.packages("lme4", type = "source")

## ----error, eval=FALSE--------------------------------------------------------
# library(dreamlet)
# library(muscat)
# library(SingleCellExperiment)
# 
# data(example_sce)
# 
# # create pseudobulk for each sample and cell cluster
# pb <- aggregateToPseudoBulk(example_sce,
#   assay = "counts",
#   cluster_id = "cluster_id",
#   sample_id = "sample_id",
#   verbose = FALSE
# )
# 
# # voom-style normalization for each cell cluster
# res.proc <- processAssays(
#   pb[1:300, ],
#   ~group_id
# )
# 
# # Redundant formula
# # This example is an extreme example of redundancy
# # but more subtle cases often show up in real data
# form <- ~ group_id + (1 | group_id)
# 
# # fit dreamlet model
# res.dl <- dreamlet(res.proc, form)
# ##  B cells...7.9 secs
# ##  CD14+ Monocytes...10 secs
# ##  CD4 T cells...9 secs
# ##  CD8 T cells...4.4 secs
# ##  FCGR3A+ Monocytes...11 secs
# ##
# ## Of 1,062 models fit across all assays, 96.2% failed
# 
# # summary of models
# res.dl
# ## class: dreamletResult
# ## assays(5): B cells CD14+ Monocytes CD4 T cells CD8 T cells FCGR3A+ Monocytes
# ## Genes:
# ##  min: 3
# ##  max: 11
# ## details(7): assay n_retain ... n_errors error_initial
# ## coefNames(2): (Intercept) group_idstim
# ##
# ## Of 1,062 models fit across all assays, 96.2% failed
# 
# # summary of models for each cell cluster
# details(res.dl)
# ##               assay n_retain                    formula formDropsTerms n_genes n_errors error_initial
# ## 1           B cells        4 ~group_id + (1 | group_id)          FALSE     201      190         FALSE
# ## 2   CD14+ Monocytes        4 ~group_id + (1 | group_id)          FALSE     269      263         FALSE
# ## 3       CD4 T cells        4 ~group_id + (1 | group_id)          FALSE     216      207         FALSE
# ## 4       CD8 T cells        4 ~group_id + (1 | group_id)          FALSE     118      115         FALSE
# ## 5 FCGR3A+ Monocytes        4 ~group_id + (1 | group_id)          FALSE     258      247         FALSE

## ----err1, eval=FALSE---------------------------------------------------------
# # Extract errors as a tibble
# res.err = seeErrors(res.dl)
# ##   Assay-level errors: 0
# ##   Gene-level errors: 1038
# 
# # No errors at the assay level
# res.err$assayLevel
# 
# # the most common error is:
# "Some predictor variables are on very different scales: consider rescaling"

## ----formula, eval=FALSE------------------------------------------------------
# form = ~ scale(x) + scale(y) + ...

## ----err2, eval=FALSE---------------------------------------------------------
# # See gene-level errors for each assay
# res.err$geneLevel[1:2,]
# ## # A tibble: 2 × 3
# ##   assay   feature  errorText
# ##   <chr>   <chr>    <chr>
# ## B cells ISG15    "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol):…
# ## B cells AURKAIP1 "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol):…
# 
# # See full error message text
# res.err$geneLevel$errorText[1]
# "Error in lmerTest:::as_lmerModLT(model, devfun, tol = tol): (converted from warning)
# Model may not have converged with 1 eigenvalue close to zero: 1.4e-09\n"

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

