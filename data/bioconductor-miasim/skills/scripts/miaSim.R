# Code example from 'miaSim' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(cache = FALSE,
                        fig.width = 9,
                        message = FALSE,
                        warning = FALSE)

## ----install-bioc, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# if (!requireNamespace("miaSim", quietly = TRUE))
#     BiocManager::install("miaSim")

## ----load, eval=TRUE----------------------------------------------------------
library(miaSim)

## ----Anormal------------------------------------------------------------------
A_normal <- powerlawA(n_species = 4, alpha = 3)

## ----Auniform-----------------------------------------------------------------
A_uniform <- randomA(n_species = 10,
	     	     diagonal = -0.4,
                     connectance = 0.5,
		     interactions = runif(n = 10^2, min = -0.8, max = 0.8))

## -----------------------------------------------------------------------------
tse_hubbell <- simulateHubbell(n_species = 8,
                               M = 10,
			       carrying_capacity = 1000,
                               k_events = 50,
			       migration_p = 0.02,
			       t_end = 100)

## -----------------------------------------------------------------------------
params_hubbell <- simulateHubbellRates(x0 = c(0,5,10),
    migration_p = 0.1, metacommunity_probability = NULL, k_events = 1, 
    growth_rates = NULL, norm = FALSE, t_end=1000)

## -----------------------------------------------------------------------------
tse_logistic <- simulateStochasticLogistic(n_species = 5)

## -----------------------------------------------------------------------------
tse_soi <- simulateSOI(n_species = 4, carrying_capacity = 1000,
                       A = A_normal, k_events=5,
		       x0 = NULL,t_end = 150, norm = TRUE)

## ----cr-----------------------------------------------------------------------
# Consumer-resource model as a TreeSE object
tse_crm <- simulateConsumerResource(n_species = 2,
                                    n_resources = 4,
                                    E = randomE(n_species = 2, n_resources = 4))

## ----glv----------------------------------------------------------------------
tse_glv <- simulateGLV(n_species = 4,
                       A = A_normal,
		       t_start = 0, 
                       t_store = 1000,
		       stochastic = FALSE,
		       norm = FALSE)

## ----ricker-------------------------------------------------------------------
tse_ricker <- simulateRicker(n_species=4, A = A_normal, t_end=100, norm = FALSE)

## ----eval=FALSE, include=FALSE------------------------------------------------
# library(miaViz)
# p1 <- plotAbundanceDensity(tse_hubbell, assay.type = "counts")
# p2 <- plotSeries(tse_hubbell, assay.type = "counts",
#                  time.col = "time",
#                  colour.by  = "rownames")
# print(p1+p2)

## -----------------------------------------------------------------------------
sessionInfo()

