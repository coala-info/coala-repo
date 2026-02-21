# Code example from 'structuralTendency-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4
)

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## ----setup--------------------------------------------------------------------
library(idpr)

## -----------------------------------------------------------------------------
P53_HUMAN <- TP53Sequences[2]
print(P53_HUMAN)

## -----------------------------------------------------------------------------
tendencyDF <- structuralTendency(P53_HUMAN)
head(tendencyDF)

## -----------------------------------------------------------------------------
structuralTendencyPlot(P53_HUMAN)

structuralTendencyPlot(P53_HUMAN,
                       graphType = "bar")

## -----------------------------------------------------------------------------
P53_MOUSE <- TP53Sequences[1]
print(P53_MOUSE)

## -----------------------------------------------------------------------------
tendencyDF <- structuralTendency(P53_MOUSE)
head(tendencyDF)

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  customColors = c("#999999", "#E69F00", "#56B4E9"))

## -----------------------------------------------------------------------------
tendencyDF <- structuralTendency(P53_MOUSE,
                 disorderPromoting = c("A", "R", "G", "Q", "S", "P", "E", "K"),
                 disorderNeutral = c("H", "M", "T", "D"),
                 orderPromoting = c("W", "C", "F", "I", "Y", "V", "L", "N"))
head(tendencyDF)

sequenceMap(
  sequence = P53_MOUSE,
  property = tendencyDF$Tendency,
  customColors = c("#999999", "#E69F00", "#56B4E9"))

## -----------------------------------------------------------------------------
structuralTendencyPlot(P53_MOUSE)

structuralTendencyPlot(P53_MOUSE,
                       graphType = "bar",
                       proteinName = names(P53_MOUSE))

## -----------------------------------------------------------------------------
structuralTendencyPlot(P53_MOUSE,
                       summarize = TRUE)

structuralTendencyPlot(P53_MOUSE,
                       graphType = "bar",
                       proteinName = names(P53_MOUSE),
                       summarize = TRUE)

## -----------------------------------------------------------------------------
compositionDF <- structuralTendencyPlot(P53_MOUSE,
                                        graphType = "none")
head(compositionDF)


summaryDF <- structuralTendencyPlot(P53_MOUSE,
                                    graphType = "none",
                                    summarize = TRUE)
head(summaryDF)

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## ----results="asis"-----------------------------------------------------------
citation()

