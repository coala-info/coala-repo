# Code example from 'RLHub' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(RLHub)

## ----rlhub-types--------------------------------------------------------------
DT::datatable(
    read.csv(system.file("extdata", "metadata.csv", package = "RLHub")),
    options = list(
        scrollX=TRUE,
        pageLength = 5
    )
)

## ----get-rlhub, message=FALSE-------------------------------------------------
# Access the R-loop binding proteins (RLBPs) data set
rlbps <- RLHub::rlbps()
DT::datatable(rlbps)

## ---- message=FALSE-----------------------------------------------------------
library(ExperimentHub)

## ---- message=FALSE-----------------------------------------------------------
eh <- ExperimentHub()
rlhub <- query(eh, "RLHub")
rlhub

## ---- message=FALSE-----------------------------------------------------------
rlbps <- rlhub[["EH6797"]]
DT::datatable(rlbps)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

