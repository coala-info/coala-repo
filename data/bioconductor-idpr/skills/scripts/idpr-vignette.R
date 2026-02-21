# Code example from 'idpr-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4
)

## ----setup--------------------------------------------------------------------
library(idpr)

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## -----------------------------------------------------------------------------
P53_HUMAN <- TP53Sequences[2] #Getting a preloaded sequence from idpr
print(P53_HUMAN)

P53_ID <- "P04637" #Human TP53 UniProt ID

## -----------------------------------------------------------------------------
idprofile(sequence = P53_HUMAN,
          uniprotAccession = P53_ID)

## -----------------------------------------------------------------------------
iupredAnchor(P53_ID) #IUPred2 long + ANCHOR2 prediction of scaffolding

## -----------------------------------------------------------------------------
iupredRedox(P53_ID) #IUPred2 long with environmental context

## -----------------------------------------------------------------------------
p53_tendency_DF <- structuralTendency(P53_HUMAN)
head(p53_tendency_DF) #see the first few rows of the generated data frame

sequenceMap(sequence = P53_HUMAN,
            property = p53_tendency_DF$Tendency,
            customColors = c("#F0B5B3", "#A2CD5A", "#BF3EFF")) #generate the map

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## -----------------------------------------------------------------------------
sessionInfo()

## ----results="asis"-----------------------------------------------------------
citation()

