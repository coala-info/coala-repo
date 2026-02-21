# Code example from 'flowPloidy-gettingStarted' vignette. See references/ for full tutorial.

## ----bioconductor, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")

## ----install1, eval=FALSE-----------------------------------------------------
# BiocManager::install("flowPloidy")

## ----install2, eval=FALSE-----------------------------------------------------
# BiocManager::install("flowPloidyData")

## ----bioconductor2, eval=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install()

## ----bioc-dependencies, eval = FALSE------------------------------------------
# BiocManager::install("flowCore")
# BiocManager::install("flowPloidyData")

## ----devtools, eval = FALSE---------------------------------------------------
# install.packages("devtools", dependencies = TRUE)

## ----github, eval = FALSE-----------------------------------------------------
# library("devtools")
# install_github("plantarum/flowPloidy", dependencies = TRUE,
#                build_vignettes = TRUE)

## ----flowPloidy---------------------------------------------------------------
library(flowPloidy)

## ----flowPloidyData-----------------------------------------------------------
library(flowPloidyData)

## ----list.files1, eval = FALSE------------------------------------------------
# my.files <- list.files("~/flow/data", full.names = TRUE)

## ----list.files2, eval = FALSE------------------------------------------------
# my.files <- list.files("~/flow/data", full.names = TRUE, pattern = ".LMD")

## ----viewFlowChannel, output = "hold"-----------------------------------------
viewFlowChannels(flowPloidyFiles()[1])
## or viewFlowcChannels("my-flow-file.LMD")

## ----batchFlowHist, message = 1:10, collapse = TRUE, cache = TRUE-------------
batch1 <- batchFlowHist(flowPloidyFiles(), channel = "FL3.INT.LIN")

## ----browseFlowHist, eval = FALSE---------------------------------------------
# batch1 <- browseFlowHist(batch1) ## update the histograms in batch1

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse1.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse2.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse2c.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse3.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse3b.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse11.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_browse11b.png")

## ----echo = FALSE, out.width = "100%", fig.cap = "Annotating a Failed Histogram"----
knitr::include_graphics("gsFigs/gs_Fail.png")

## ----tabulateFlowHist---------------------------------------------------------
tabulateFlowHist(batch1)[1:4, ]

## ----tabulateFlowHist2, eval = FALSE------------------------------------------
# results <- tabulateFlowHist(batch1)

## ----tabulateFlowHist3, eval = FALSE------------------------------------------
# results <- tabulateFlowHist(batch1, file = "FCMresults.csv")

## ----saving FlowHist objects, eval = FALSE------------------------------------
# save(batch1, file = "my-FCM-analyses.Rdata")

## ----setting standards, eval = FALSE------------------------------------------
# batch1 <- batchFlowHist(flowPloidyFiles(), channel = "FL3.INT.LIN",
#                         standards = 1.11)

## ----multiple standards, eval = FALSE-----------------------------------------
# batch1 <- batchFlowHist(flowPloidyFiles(), channel = "FL3.INT.LIN",
#                         standards = c(1.11, 9.09))

## ----vac channel--------------------------------------------------------------
viewFlowChannels(fpVac())

## ----read vac-----------------------------------------------------------------
vac <- batchFlowHist(fpVac(), channel = "FL2.A")

## ----view vac, eval = FALSE---------------------------------------------------
# vac <- browseFlowHist(vac)

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/vac1.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gate_ui.png")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_gate.jpg")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gs_gate_zoom2.jpg")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/draw_gate.jpg")

## ----echo = FALSE, out.width = "100%"-----------------------------------------
knitr::include_graphics("gsFigs/gated_analysis.jpg")

