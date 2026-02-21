# Code example from 'synlet-vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(fig.width = 12, fig.height = 10)

## ----load_data----------------------------------------------------------------
library(synlet)
data(example_dt)
head(example_dt)

## ----zFactor------------------------------------------------------------------
res <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1")
head(res)

## ----heatmap------------------------------------------------------------------
plateHeatmap(example_dt)

## -----------------------------------------------------------------------------
scatterPlot(example_dt, controlOnly = FALSE, control_name = c("PLK1 si1", "scrambled control si1", "lipid only"))

## ----ZPrime-------------------------------------------------------------------
zF_mean <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1")
zF_med <- zFactor(example_dt, negativeCon = "scrambled control si1", positiveCon = "PLK1 si1", useMean = FALSE)

## ----genePlot-----------------------------------------------------------------
siRNAPlot("AAK1", example_dt,
           controlsiRNA = c("lipid only", "scrambled control si1"),
           FILEPATH = ".",  zPrimeMed = zF_med, zPrimeMean = zF_mean,
           treatment = "treatment", control = "control",
           normMethod = c("PLATE", "lipid only", "scrambled control si1"))

## ----bscore-------------------------------------------------------------------
bscore_res <- sapply(unique(example_dt$MASTER_PLATE)[1], bScore, example_dt, treatment = "treatment", control = "control", simplify = FALSE)
head(bscore_res$P001)

## ----t_test-------------------------------------------------------------------
t_res <- tTest(bscore_res$P001, 3, 3)
head(t_res)

## ----madSelection-------------------------------------------------------------
mad_res <- sapply((unique(example_dt$MASTER_PLATE)),
                  madSelect,
                  example_dt,
                  control   = "control",
                  treatment = "treatment",
                  simplify  = FALSE)
head(mad_res$P001)

## ----rankProd-----------------------------------------------------------------

rp_res <- sapply(unique(example_dt$MASTER_PLATE),
                 rankProdHits,
                 example_dt,
                 control   = "control",
                 treatment = "treatment",
                 simplify  = FALSE)
head(rp_res)

## ----rsa----------------------------------------------------------------------
rsaHits(example_dt, treatment = "treatment", control = "control",
        normMethod = "PLATE", LB = 0.2, UB = 0.8, revHits = FALSE,
        Bonferroni = FALSE, outputFile = "RSAhits.csv")

## -----------------------------------------------------------------------------
sessionInfo()

