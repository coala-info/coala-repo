# Code example from 'EWCE' vignette. See references/ for full tutorial.

## ----setup, include=TRUE------------------------------------------------------
library(EWCE) 
set.seed(1234)

#### Package name ####
pkg <- tolower("EWCE")
#### Username of DockerHub account ####
docker_user <- "neurogenomicslab"

## -----------------------------------------------------------------------------
ctd <- ewceData::ctd()

## ----fig.width=7, fig.height=5, error=TRUE------------------------------------
try({
plt_exp <- EWCE::plot_ctd(ctd = ctd,
                        level = 1,
                        genes = c("Apoe","Gfap","Gapdh"),
                        metric = "mean_exp")
})

## ----fig.width=9, fig.height=5, error=TRUE------------------------------------
try({
plt_spec <- EWCE::plot_ctd(ctd = ctd,
                         level = 2,
                         genes = c("Apoe","Gfap","Gapdh"),
                         metric = "specificity")
})

## -----------------------------------------------------------------------------
hits <- ewceData::example_genelist()
print(hits)

## -----------------------------------------------------------------------------
reps <- 100
annotLevel <- 1

## -----------------------------------------------------------------------------
full_results <- EWCE::bootstrap_enrichment_test(sct_data = ctd,
                                                sctSpecies = "mouse",
                                                genelistSpecies = "human",
                                                hits = hits, 
                                                reps = reps,
                                                annotLevel = annotLevel)

## -----------------------------------------------------------------------------
knitr::kable(full_results$results)

## ----error=TRUE---------------------------------------------------------------
try({
plot_list <- EWCE::ewce_plot(total_res = full_results$results,
                           mtc_method = "BH",
                           ctd = ctd)
print(plot_list$withDendro)
})

## ----Session Info-------------------------------------------------------------
utils::sessionInfo()

