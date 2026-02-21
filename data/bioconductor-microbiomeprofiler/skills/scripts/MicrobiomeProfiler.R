# Code example from 'MicrobiomeProfiler' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("MicrobiomeProfiler")

## ----echo=FALSE, fig.width = 20, dpi=600, fig.align="center", fig.cap="**KEGG enrichment analysis**"----
knitr::include_graphics("./screenshot_1.png")

## ----echo=FALSE, fig.width = 20, dpi=600, fig.align="center", fig.cap="**Customize the universe**"----
knitr::include_graphics("./screenshot_2.png")
knitr::include_graphics("./screenshot_3.png")

## ----echo=FALSE, fig.width = 20, dpi=600, fig.align="center", fig.cap="**Case study**"----
knitr::include_graphics("./screenshot_4.png")

## ----echo=FALSE, fig.width = 20, dpi=600, fig.align="center", fig.cap="**To show interested tetms**"----
knitr::include_graphics("./screenshot_5.png")

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

