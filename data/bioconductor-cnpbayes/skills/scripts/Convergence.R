# Code example from 'Convergence' vignette. See references/ for full tutorial.

## ----packages, message=FALSE-----------------------------------------------
# load CNPBayes
suppressMessages(library(CNPBayes))
# load packages for manipulating and visualizing data
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(ggplot2))

## ----post-sim--------------------------------------------------------------
set.seed(1)
N <- 200
n <- 81
lrr <- c(rnorm(100, -0.5, sd=0.1), rnorm(100, 0, sd=0.1))
mp <- McmcParams(iter=600, burnin=10, nStarts=4)
mlist <- gibbs(model="SBP", mp=mp, dat=lrr, k_range=c(2, 2))

## ----chains----------------------------------------------------------------
model <- mlist[[1]]
figs <- ggChains(model)
figs[[1]]
figs[[2]]

## ----marginal-lik, eval=FALSE----------------------------------------------
#  m.lik <- round(sapply(mlist, marginal_lik), 1)
#  m.lik

