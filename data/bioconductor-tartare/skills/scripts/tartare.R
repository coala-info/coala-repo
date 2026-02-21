# Code example from 'tartare' vignette. See references/ for full tutorial.

## ----initial, echo=FALSE, warning=FALSE, message=FALSE------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
(fl <- system.file("extdata", "metadata.csv", package='tartare'))
metadata <- read.csv(fl, stringsAsFactors=FALSE)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
library(knitr)
kable(metadata[,c(1,5,15,16)])

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(ExperimentHub)

eh <- ExperimentHub(); 
query(eh, "tartare")

#### code snippets to be continued
# load(query(eh, c("NestLink", "F255744.RData"))[[1]])
# dim(F255744)
# load(query(eh, c("NestLink", "WU160118.RData"))[[1]])
# dim(WU160118)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

