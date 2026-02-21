# Code example from 'netprioR' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
fileidentifier <- "netprioR_cache"
library(knitr)
library(dplyr)
library(pander)
library(ggplot2)
library(BiocStyle)
library(netprioR)
library(pROC)
library(Matrix)
# library(gdata)
# library(tidyr)
knitr::opts_chunk$set(
  cache.path = paste("./cache/", fileidentifier, "/", sep = ""),
  fig.width = 7,
  fig.height = 7,
  fig.align = "center",
  fig.path = paste("./figs/", fileidentifier, "/", sep = ""),
  cache = FALSE, #Default cache off
  echo = FALSE,
  warning = FALSE, 
  message = FALSE,
  comment = NA,
  tidy = TRUE)
rm(list = ls())

## ----echo = TRUE--------------------------------------------------------------
members_per_class <-  c(N/2, N/2) %>% floor

## ----echo = TRUE--------------------------------------------------------------
class.labels <- simulate_labels(values = c("Positive", "Negative"), 
                                sizes = members_per_class, 
                                nobs = c(nlabel/2, nlabel/2))

## ----echo = TRUE--------------------------------------------------------------
names(class.labels)

## ----echo = TRUE, cache = TRUE------------------------------------------------
networks <- list(LOW_NOISE1 = simulate_network_scalefree(nmemb = members_per_class, pclus = 0.8),
          LOW_NOISE2 = simulate_network_scalefree(nmemb = members_per_class, pclus = 0.8),
          HIGH_NOISE = simulate_network_random(nmemb = members_per_class, nnei = 1)
          )

## ----echo = TRUE, cache = TRUE------------------------------------------------
image(networks$LOW_NOISE1)

## ----echo = TRUE--------------------------------------------------------------
effect_size <- 0.25

## ----echo = TRUE--------------------------------------------------------------
phenotypes <- simulate_phenotype(labels.true = class.labels$labels.true, meandiff = effect_size, sd = 1)

## ----echo = TRUE--------------------------------------------------------------
data.frame(Phenotype = phenotypes[,1], Class = rep(c("Positive", "Negative"), each = N/2)) %>%
  ggplot() +
  geom_density(aes(Phenotype, fill = Class), alpha = 0.25, adjust = 2) +
  theme_bw()

## ----echo = TRUE, cache = TRUE------------------------------------------------
np <- netprioR(networks = networks, 
               phenotypes = phenotypes, 
               labels = class.labels$labels.obs, 
               nrestarts = 1, 
               thresh = 1e-6, 
               a = 0.1, 
               b = 0.1,
               fit.model = TRUE,
               use.cg = FALSE,
               verbose = FALSE)

## ----echo = TRUE--------------------------------------------------------------
summary(np)

## ----echo = TRUE--------------------------------------------------------------
plot(np, which = "all")

## ----echo = TRUE--------------------------------------------------------------
roc.np <- ROC(np, true.labels = class.labels$labels.true, plot = TRUE, main = "Prioritisation: netprioR")

## ----echo = TRUE--------------------------------------------------------------
unlabelled <- which(is.na(class.labels$labels.obs))
roc.x <- roc(cases = phenotypes[intersect(unlabelled, which(class.labels$labels.true == levels(class.labels$labels.true)[1])),1],
             controls = phenotypes[intersect(unlabelled, which(class.labels$labels.true == levels(class.labels$labels.true)[2])),1],
             direction = ">")
plot.roc(roc.x, main = "Prioritisation: Phenotype-only", print.auc = TRUE, print.auc.x = 0.2, print.auc.y = 0.1)

## -----------------------------------------------------------------------------
sessionInfo()

