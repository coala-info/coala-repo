# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
#     if (!requireNamespace("BiocManager", quietly = TRUE))
#         install.packages("BiocManager")
#     BiocManager::install("SUITOR")

## -----------------------------------------------------------------------------
library(SUITOR)

## -----------------------------------------------------------------------------
    data(SimData, package="SUITOR")
    dim(SimData)
    SimData[1:6, 1:6]

## ----table1, echo=FALSE-------------------------------------------------------
v1 <- c("min.value", "min.rank", "max.rank", "k.fold", "em.eps", "max.iter",
        "n.starts", "get.summary", "plot", "print")       
v2 <- c("Minimum value of matrix before factorizing", "Minimum rank",
        "Maximum rank", "Number of folds", "EM algorithm stopping tolerance", 
        "Maximum number of iterations in EM algorithm", 
        "Number of starting points", 
        "0 or 1 to create summary results", "0 or 1 to produce an error plot",
        "0 or 1 to print info (0=no printing)")
v3 <- c("1e-4", "1", "10", "10", "1e-5", "2000", "30", "1", "1", "1")
tab1 <- data.frame(Name=v1, Description=v2, "Default Value"=v3,
                   stringsAsFactors=FALSE, check.names=FALSE)
knitr::kable(tab1)

## -----------------------------------------------------------------------------
OP  <- list(max.rank=3, k.fold=5, n.starts=4)
set.seed(123)
re <- suitor(SimData, op=OP)
str(re)

## ----table2, echo=FALSE-------------------------------------------------------
v1 <- c("min.value", "n.starts", "print")
v2 <- c("Minimum value of matrix before factorizing", 
        "Number of starting points",
        "0 or 1 to print info (0=no printing)")
v3 <- c("1e-4", "30", "1")
tab2 <- data.frame(Name=v1, Description=v2, "Default Value"=v3,
                   stringsAsFactors=FALSE, check.names=FALSE)
knitr::kable(tab2)

## -----------------------------------------------------------------------------
re$rank
set.seed(123)
Extract <- suitorExtractWH(SimData, re$rank)
head(Extract$W)
Extract$H[,1:3]

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(MutationalPatterns))
COSMIC <- get_known_signatures(source = "COSMIC_v3.2")
plot_96_profile(Extract$W, condensed=TRUE, ymax=0.3)
CS <- cos_sim_matrix(Extract$W, COSMIC)
CS[, 1:3]

## -----------------------------------------------------------------------------
sessionInfo()

