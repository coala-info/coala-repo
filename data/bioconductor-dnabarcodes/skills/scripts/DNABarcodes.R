# Code example from 'DNABarcodes' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', warnings=FALSE, messages=FALSE----
BiocStyle::markdown()

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache=FALSE)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
library("DNABarcodes")
mySet <- create.dnabarcodes(5)
show(mySet)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
mySetAshlock <- create.dnabarcodes(5, heuristic="ashlock")
show(mySetAshlock)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
mySetDist5 <- create.dnabarcodes(5, dist=5, heuristic="ashlock")
show(mySetDist5)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
show(length(create.dnabarcodes(5, dist=5, heuristic="ashlock")))
show(length(create.dnabarcodes(6, dist=5, heuristic="ashlock")))
show(length(create.dnabarcodes(7, dist=5, heuristic="ashlock")))

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
mySeqlevSet <- create.dnabarcodes(5, metric="seqlev", heuristic="ashlock")
show(mySeqlevSet)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
mySetTriplets <- create.dnabarcodes(5, heuristic="ashlock", filter.triplets=FALSE)
show(mySetTriplets)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
data(supplierSet)
myRobustSet <- create.dnabarcodes(7, dist=5, pool=supplierSet, heuristic="ashlock")
show(myRobustSet)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
myRobustSetSeqlev <- create.dnabarcodes(7, metric="seqlev", pool=supplierSet, heuristic="ashlock")
show(myRobustSetSeqlev)

## ----eval=TRUE, collapse=TRUE-------------------------------------------------
data(mutatedReads)
demultiplex(head(mutatedReads), supplierSet)

## ----eval=TRUE,collapse=TRUE--------------------------------------------------
analyse.barcodes(supplierSet)

## ----eval=FALSE, collapse=TRUE------------------------------------------------
# length(create.dnabarcodes(10, metric="seqlev", heuristic="ashlock",cores=32))
# ## 1) Creating pool ...  of size 488944
# ## 2) Initiating Chromosomes done
# ## 3) Running Greedy Evolutionary done
# ##  2126
# length(create.dnabarcodes(10, metric="seqlev", heuristic="ashlock",cores=32, population=500, iterations=250))
# ## 1) Creating pool ...  of size 488944
# ## 2) Initiating Chromosomes done
# ## 3) Running Greedy Evolutionary done
# ##  2133

