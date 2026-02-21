# Code example from 'macrophage' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
dir <- system.file("extdata", package="macrophage")
coldata <- read.csv(file.path(dir,"coldata.csv"))
coldata <- coldata[,c(1,2,3,5)]
coldata

## -----------------------------------------------------------------------------
sessionInfo()

