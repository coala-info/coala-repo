# Code example from 'TargetDecoy' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL,
    fig.width = 6,
    dpi = 72
)

## ----"libraries", message=FALSE, warning=FALSE--------------------------------
library(TargetDecoy)
library(ggplot2)

## ----"install", eval=FALSE----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("TargetDecoy")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"install-devel", eval=FALSE----------------------------------------------
# BiocManager::install("statOmics/TargetDecoy")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("TargetDecoy")

## ----echo=FALSE, fig.cap="Illustration of the target and decoy distributions. The green bars are the histogram of the target PSM scores. The orange bars are the histogram of the decoy PSM scores. We see that the decoy PSMs match well with the incorrect target hits that are more likely to occur at low scores.", warning=FALSE----
data(ModSwiss)
hlp <- decoyScoreTable(ModSwiss, "isdecoy", "ms-gf:specevalue", TRUE)

hlp_scores <- sort(hlp$score, decreasing = TRUE)
FP <- cumsum(hlp$decoy)
nTar <- cumsum(!hlp$decoy)
FDR  <- FP / nTar

thresh <- min(hlp_scores[FDR <= 0.01])
nTarFdrThresh <- max(nTar[FDR <= 0.01])

evalTargetDecoysHist(ModSwiss, "isdecoy", "ms-gf:specevalue", TRUE) +
  annotate("rect", xmin = 5, xmax = 35, ymin = -10, ymax = 1000, alpha = .2) +
  xlim(c(0, 35)) +
  annotate(
    geom = "text", x = thresh, y = 990, label = "x > t",
    color = "black", hjust = 0
  ) +
  ggtitle(
    "Histogram of Targets and Decoys",
    subtitle = paste(nTarFdrThresh, "PSMs significant at the 1% FDR level")
  )

## ----fig.cap="Histogram of the scores of targets and decoys."-----------------
data("ModSwiss")
evalTargetDecoysHist(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE, nBins = 50
)

## ----fig.cap="PP plot"--------------------------------------------------------
evalTargetDecoysPPPlot(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE
)

## ----data-loading-examples, warning=FALSE-------------------------------------
filename <- system.file("extdata/55merge_omssa.mzid", package = "mzID")

## mzID
mzID_object <- mzID::mzID(filename)
class(mzID_object)

## mzRIdent
mzR_object <- mzR::openIDfile(filename)
class(mzR_object)

## ----example1.1-data----------------------------------------------------------
## Load the example SwissProt dataset
data("ModSwiss")

## ----evalTargetDecoys-plot, fig.cap="Histogram and PP plot, as well as a zoom for both plots."----
evalTargetDecoys(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE, nBins = 50
)

## -----------------------------------------------------------------------------
msgfSwiss_ppPlot <- evalTargetDecoysPPPlot(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE
)
msgfSwiss_ppPlot_zoomed <- evalTargetDecoysPPPlot(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE, zoom = TRUE
)
msgfSwiss_hist <- evalTargetDecoysHist(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE, nBins = 50
)
msgfSwiss_hist_zoomed <- evalTargetDecoysHist(ModSwiss,
    decoy = "isdecoy", score = "ms-gf:specevalue",
    log10 = TRUE, nBins = 50, zoom = TRUE
)

## ----fig.cap="Zoom of the first part of the PP plot"--------------------------
msgfSwiss_ppPlot +
    coord_cartesian(xlim = c(NA, 0.25), ylim = c(NA, 0.05))

## -----------------------------------------------------------------------------
## Load X!Tandem example data
data("ModSwissXT")

## ----fig.cap="Histogram and PP plot, each with a zoom level."-----------------
evalTargetDecoys(ModSwissXT,
    decoy = "isdecoy", score = "x!tandem:expect",
    log10 = TRUE, nBins = 50
)

## ----fig.asp=1, fig.cap="PP plot and standardized PP plot"--------------------
## Run createPPlotScores with necessary arguments
## Omitting 'decoy', 'scores' or 'log10' will launch the Shiny app
createPPlotScores(ModSwissXT,
    decoy = "isdecoy",
    scores = c("omssa:evalue", "ms-gf:specevalue",
               "x!tandem:expect", "peptideshaker psm score"),
    ## We can choose to log-transform some scores but not others
    log10 = c(TRUE, TRUE, TRUE, FALSE)
)

## ----fig.asp=1, fig.cap="PP plot and standardized PP plot for two searches (same search engine)"----
## Create list of input objects, list names will be reused in the plots
mzObjects <- list(
    ModSwiss_data = ModSwiss,
    pyroSwissprot_data = ModSwissXT
)

createPPlotObjects(
    mzObjects, decoy = "isdecoy",
    score = "ms-gf:specevalue"
)

## ----fig.asp=1, fig.cap="PP plot and standardized PP plot for two searches (different search engine)"----
## Create list of input objects, list names will be reused in the plots
mzObjects <- list(
    ModSwiss_data = ModSwiss,
    ModSwissXT_data = ModSwissXT
)

plotDiffEngine <- createPPlotObjects(mzObjects,
    decoy = "isdecoy",
    score = c("ms-gf:specevalue", "x!tandem:expect")
)
plotDiffEngine

## -----------------------------------------------------------------------------
# Zoom in on the relevant or desired part of the plot
plotZoom <- plotDiffEngine +
    coord_cartesian(xlim = c(NA, 0.25), ylim = c(NA, 0.05))
plotZoom 

## ----fig.cap="Histogram and PP plot, each with a zoom level."-----------------
evalTargetDecoys(mzObjects$ModSwissXT_data,
    decoy = "isdecoy", score = "x!tandem:expect",
    log10 = TRUE, nBins = 50
)

## ----echo=FALSE, fig.cap="The Shiny gadget opens after calling `evalTargetDecoys()` with only an input object but no variables specified."----
include_graphics("img/gadget-screenshot.png")

## ----echo=FALSE, fig.cap="A histogram and PP-plot can be previewed in the respective tabs."----
include_graphics("img/gadget-screenshot2.png")

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

