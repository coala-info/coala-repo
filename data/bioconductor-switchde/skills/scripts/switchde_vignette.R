# Code example from 'switchde_vignette' vignette. See references/ for full tutorial.

## ----load-data, cache = FALSE, message = FALSE, warning = FALSE, include = FALSE----
library(SingleCellExperiment)
library(dplyr)
library(tidyr)
library(switchde)
library(ggplot2)
knitr::opts_chunk$set( cache = TRUE )

## ----sigmoid-plot, fig.width = 4, fig.height = 3, warning = FALSE-------------
example_sigmoid()


## ----install-bioc, eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("switchde")

## ----install-github, eval = FALSE---------------------------------------------
# devtools::install_github("kieranrcampbell/switchde")

## ----x-filter, eval = FALSE---------------------------------------------------
# X_filtered <- X[rowMeans(X) > 0.1 & rowMeans(X > 0) > 0.2,]

## ----plot-expression----------------------------------------------------------
data(synth_gex)
data(ex_pseudotime)

gex_cleaned <- as_data_frame(t(synth_gex)) %>% 
  dplyr::mutate(Pseudotime = ex_pseudotime) %>% 
  tidyr::gather(Gene, Expression, -Pseudotime)

ggplot(gex_cleaned, aes(x = Pseudotime, y = Expression)) +
  facet_wrap(~ Gene) + geom_point(shape = 21, fill = 'grey', color = 'black') +
  theme_bw() + stat_smooth(color = 'darkred', se = FALSE)

## ----test-de------------------------------------------------------------------
sde <- switchde(synth_gex, ex_pseudotime)

## ----de-from-scater-----------------------------------------------------------
sce <- SingleCellExperiment(assays = list(exprs = synth_gex))
sde <- switchde(sce, ex_pseudotime)

## ----view-results-------------------------------------------------------------
dplyr::arrange(sde, qval)

## ----plot, fig.width = 5, fig.height = 3--------------------------------------
gene <- sde$gene[which.min(sde$qval)]
pars <- extract_pars(sde, gene)
print(pars)

switchplot(synth_gex[gene, ], ex_pseudotime, pars)

## ----zi-----------------------------------------------------------------------
zde <- switchde(synth_gex, ex_pseudotime, zero_inflated = TRUE)

## ----disp-zi------------------------------------------------------------------
dplyr::arrange(zde, qval)

## ----compare------------------------------------------------------------------
gene <- zde$gene[which.min(zde$lambda)]
pars <- extract_pars(sde, gene)
zpars <- extract_pars(zde, gene)


switchplot(synth_gex[gene, ], ex_pseudotime, pars)
switchplot(synth_gex[gene, ], ex_pseudotime, zpars)

## ----first-quater, eval = FALSE-----------------------------------------------
# pst_quantiles <- quantile(pst, c(0, 0.25))
# filter(sde, qval < 0.01, t0 > pst_quantiles[1], t0 < pst_quantiles[2])

## ----session-info-------------------------------------------------------------
sessionInfo()

