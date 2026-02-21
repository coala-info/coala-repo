# Code example from 'iupred-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4
)

## -----------------------------------------------------------------------------
library(idpr) #Attach the package

p53_ID <- "P04637"
iupred(p53_ID,
       proteinName = "HUMAN P53")

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## -----------------------------------------------------------------------------
library(idpr) #Attach the package

## -----------------------------------------------------------------------------
p53_ID <- "P04637"
iupred(p53_ID,
       proteinName = "HUMAN P53",
       iupredType = "long")

## -----------------------------------------------------------------------------
iupredLongDF <- iupred(p53_ID,
                       proteinName = "HUMAN P53",
                       iupredType = "long",
                       plotResults = FALSE)
head(iupredLongDF)

## -----------------------------------------------------------------------------
p53_ID <- "P04637"
iupred(p53_ID,
       proteinName = "HUMAN P53",
       iupredType = "short")

## -----------------------------------------------------------------------------
iupredShortDF <- iupred(p53_ID,
                        iupredType = "short",
                        plotResults = FALSE)
head(iupredShortDF)

## -----------------------------------------------------------------------------
p53_ID <- "P04637"
iupred(p53_ID,
       proteinName = "HUMAN P53",
       iupredType = "glob")

## -----------------------------------------------------------------------------
iupredGlobDF <- iupred(p53_ID,
                       iupredType = "glob",
                       plotResults = FALSE)
head(iupredGlobDF)

## -----------------------------------------------------------------------------
p53_ID <- "P04637"
iupredAnchor(p53_ID,
             proteinName = "HUMAN P53")

## -----------------------------------------------------------------------------
iupredAnchorDF <- iupredAnchor(p53_ID,
                               plotResults = FALSE)
head(iupredAnchorDF)

## -----------------------------------------------------------------------------
p53_ID <- "P04637"
iupredRedox(p53_ID,
             proteinName = "HUMAN P53")

## -----------------------------------------------------------------------------
iupredRedoxDF <- iupredRedox(p53_ID,
                             plotResults = FALSE)
head(iupredRedoxDF)

## -----------------------------------------------------------------------------
iupredLongDF <- iupred(p53_ID,
                       proteinName = "HUMAN P53",
                       iupredType = "long",
                       plotResults = FALSE)

sequenceMap(sequence = iupredLongDF$AA,
            property = iupredLongDF$IUPred2,
            customColors = c("darkolivegreen3", "grey65", "darkorchid1")) +
  ggplot2::labs(title = "Prediction of Intrinsic Disorder in HUMAN P53",
                subtitle = "By IUPred2A long")

## -----------------------------------------------------------------------------
citation("ggplot2")

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## ----results="asis"-----------------------------------------------------------
citation()

