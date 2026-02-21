# Code example from 'SPIAT' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  crop = NULL,
  echo = TRUE, fig.width = 3.8, fig.height = 3.8, dpi = 72, out.width = "60%")

## ----echo=FALSE, fig.height=4.2, fig.width=2.6, fig.align='centre', out.width = "85%"----
knitr::include_graphics("SPIAT-overview.jpg")

## ----install, eval = FALSE----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")}
# BiocManager::install("SPIAT")

## ----install_github, eval = FALSE---------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE)) {
#       install.packages("devtools")}
# devtools::install_github("TrigosTeam/SPIAT")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("SPIAT")

