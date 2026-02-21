# Code example from 'perturbatr' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'-------------------------------------
  BiocStyle::markdown()

## ----setup, include=FALSE--------------------------------------------------
  knitr::opts_chunk$set(echo = TRUE)
  options(warn = -1)
  library(dplyr)
  library(tibble)
  library(methods)
  library(perturbatr)
  data(rnaiscreen)
  rnaiscreen <- dataSet(rnaiscreen) %>%    
    dplyr::select(Condition, Replicate, GeneSymbol,
                  Perturbation, Readout, Control, 
                  Design, ScreenType, Screen) %>%
    as.tibble()

## ---- include=TRUE, size="tiny"--------------------------------------------
  head(rnaiscreen)

## ---- include=TRUE, eval=TRUE----------------------------------------------
  rnaiscreen <- methods::as(rnaiscreen, "PerturbationData")

## ---- eval=TRUE, include=TRUE----------------------------------------------
  rnaiscreen
  dataSet(rnaiscreen)

## ---- eval=TRUE, include=TRUE----------------------------------------------
  perturbatr::filter(rnaiscreen, Readout > 0)

## ---- eval=TRUE, include=TRUE----------------------------------------------
  perturbatr::filter(rnaiscreen, Readout > 0, Replicate == 2)

## ---- eval=TRUE, include=TRUE----------------------------------------------
  dh <- perturbatr::filter(rnaiscreen, Readout > 0, Replicate == 2)
  rbind(dh, dh)

## ---- eval=TRUE, include=TRUE, fig.align="center", fig.width=4, message=FALSE----
  plot(rnaiscreen)

## --------------------------------------------------------------------------
  dataSet(rnaiscreen) %>% str()

## --------------------------------------------------------------------------
  dataSet(rnaiscreen) %>% pull(ScreenType) %>% unique()

## ---- eval=TRUE, include=TRUE, warning=FALSE, message=FALSE----------------
  frm <- Readout ~ Condition +
                   (1|GeneSymbol) + (1|Condition:GeneSymbol) +
                   (1|ScreenType) + (1|Condition:ScreenType)
  res.hm <- hm(rnaiscreen, formula = frm)

## ---- include=TRUE, fig.align="center", fig.width=4, message=FALSE---------
  pl <- plot(res.hm)
  pl[[1]]

## ----include=TRUE, fig.align="center", fig.width=4, message=FALSE----------
  pl[[2]]

## ----include=TRUE, fig.align="center", fig.width=4, message=FALSE----------
  graph <- readRDS(
    system.file("extdata", "graph_small.rds",package = "perturbatr"))
  diffu <- diffuse(res.hm, graph=graph, r=0.3)

## ----include=TRUE, fig.align="center", fig.width=4, message=FALSE----------
  plot(diffu)

## ----eval=TRUE, include=TRUE-----------------------------------------------
  sessionInfo()

