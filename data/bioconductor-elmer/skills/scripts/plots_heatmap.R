# Code example from 'plots_heatmap' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER.data)
library(ELMER)
library(DT)
library(dplyr)
library(BiocStyle)

## ----eval=TRUE, message=FALSE, warning = FALSE, results = "hide"--------------
# Load results from previous sections
mae <- get(load("mae.rda"))

## ----results='hide', echo=TRUE,eval=F, message=FALSE, warning=FALSE, fig.width=10, fig.height=5, fig.cap="Heatmap of paired pairs."----
# 
# pair <- read.csv("result/getPair.hypo.pairs.significant.csv")
# 
# heatmapPairs(data = mae,
#              group.col = "definition",
#              group1 = "Primary solid Tumor",
#              annotation.col = c("years_smoked","gender"),
#              group2 = "Solid Tissue Normal",
#              pairs = pair,
#              filename =  NULL)
# 

