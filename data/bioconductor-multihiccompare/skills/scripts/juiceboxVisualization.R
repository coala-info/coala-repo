# Code example from 'juiceboxVisualization' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# exportJuicebox(rao2017, logfc_cutoff = 2, logcpm_cutoff = 1, p.adj_cutoff = 0.001, file_name = "rao2017Annotations.txt")

## ----echo=FALSE---------------------------------------------------------------
githubURL <- "https://raw.githubusercontent.com/jstansfield0/Rao2017Annotations/master/juicebox.png"
download.file(githubURL,'juicebox.png', mode = 'wb')

