# Code example from 'getting-started-with-rprimer' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----internal setup, echo=FALSE, warning=FALSE, message=FALSE-----------------
library(kableExtra)

## ----warning=FALSE, message=FALSE---------------------------------------------
library(rprimer)
library(Biostrings)

## -----------------------------------------------------------------------------
filepath <- system.file("extdata", "example_alignment.txt", package = "rprimer")

myAlignment <- readDNAMultipleAlignment(filepath, format = "fasta")

## -----------------------------------------------------------------------------
## Mask everything but position 3000 to 4000 and 5000 to 6000
myMaskedAlignment <- myAlignment

colmask(myMaskedAlignment, invert = TRUE) <- c(3000:4000, 5000:6000)

## -----------------------------------------------------------------------------
myConsensusProfile <- consensusProfile(myAlignment, ambiguityThreshold = 0.05)

## ----echo=FALSE---------------------------------------------------------------
myConsensusProfile[100:105, ] %>%
  kbl(., digits = 2) %>%
  kable_material(c("striped", "hover"), position = "right") %>%
  scroll_box(width = "650px")

## ----fig.width=12, fig.height=6-----------------------------------------------
plotData(myConsensusProfile)

## ----fig.width=12, fig.height=6-----------------------------------------------
## Select position 5000 to 5800 in the consensus profile 
selection <- myConsensusProfile[
  myConsensusProfile$position >= 5000 & myConsensusProfile$position <= 5800, 
  ]

plotData(selection)

## -----------------------------------------------------------------------------
myOligos <- designOligos(myConsensusProfile)

## ----echo=FALSE---------------------------------------------------------------
myOligos[1:5, ] %>%
  kbl(., digits = 2) %>%
  kable_material(c("striped", "hover"), position = "right") %>%
  scroll_box(width = "650px")

## -----------------------------------------------------------------------------
myOligos$sequence[[1]] ## All sequence variants of the first oligo (i.e., first row) 
myOligos$gcContent[[1]] ## GC-content of all variants of the first oligo 
myOligos$tm[[1]] ## Tm of all variants of the first oligo 

## ----fig.align="center", fig.width=12, fig.height=8---------------------------
plotData(myOligos)

## -----------------------------------------------------------------------------
## I first need to make a consensus profile of the masked alignment 
myMaskedConsensusProfile <- consensusProfile(myMaskedAlignment, ambiguityThreshold = 0.05)

myMaskedMixedPrimers <- designOligos(myMaskedConsensusProfile,
                                     maxDegeneracyPrimer = 8,
                                     lengthPrimer = c(24:28),
                                     tmPrimer = c(65,70),
                                     designStrategyPrimer = "mixed", 
                                     probe = FALSE)

## ----fig.align="center", fig.width=12, fig.height=8, warn=FALSE---------------
plotData(myMaskedMixedPrimers)

## ----fig.align="center", fig.width=12, fig.height=8---------------------------
## Get the minimum score from myOligos 
bestOligoScore <- min(myOligos$score)
bestOligoScore

## Make a subset that only oligos with the best score are included 
oligoSelection <- myOligos[myOligos$score == bestOligoScore, ]

## -----------------------------------------------------------------------------
## Get the binding region of the first oligo in the selection above (first row): 
bindingRegion <- myConsensusProfile[
  myConsensusProfile$position >= oligoSelection[1, ]$start & 
    myConsensusProfile$position <= oligoSelection[1, ]$end,
  ]

## -----------------------------------------------------------------------------
plotData(bindingRegion, type = "nucleotide")

## -----------------------------------------------------------------------------
myAssays <- designAssays(myOligos)  

## ----echo=FALSE---------------------------------------------------------------
myAssays[1:5, ] %>%
  kbl(., digits = 2) %>%
  kable_material(c("striped", "hover"), position = "right") %>%
  scroll_box(width = "650px")

## ----fig.width=12, fig.height=6-----------------------------------------------
plotData(myAssays)

## -----------------------------------------------------------------------------
## Get the minimum (best) score from myAssays
bestAssayScore <- min(myAssays$score)
bestAssayScore

## Make a subset that only contains the assays with the best score 
myAssaySelection <- myAssays[myAssays$score == bestAssayScore, ]

## -----------------------------------------------------------------------------
from <- myAssaySelection[1, ]$start
to <- myAssaySelection[1, ]$end

## ----fig 3, fig.width=12, fig.height=6----------------------------------------
plotData(myConsensusProfile, highlight = c(from, to))

## -----------------------------------------------------------------------------
myAssayRegion <- myConsensusProfile[
  myConsensusProfile$position >= from & 
    myConsensusProfile$position <= to, 
] 

## ----fig.width=12, fig.height=6, fig.align="center"---------------------------
plotData(myAssayRegion, type = "nucleotide")

## -----------------------------------------------------------------------------
paste(myAssayRegion$iupac, collapse = "")

## -----------------------------------------------------------------------------
## Check the first three candidates in the oligoSelection dataset
oligoSelectionMatch <- checkMatch(oligoSelection[1:3, ], target = myAlignment)

## ----echo=FALSE---------------------------------------------------------------
oligoSelectionMatch %>%
  kbl(., digits = 2) %>%
  kable_material(c("striped", "hover"), position = "right") %>%
  scroll_box(width = "650px")

## -----------------------------------------------------------------------------
## Get the id of all sequences that has one mismatch to the first oligo in the input dataset
oligoSelectionMatch$idOneMismatch[[1]] 

## ----fig.width=12, fig.height=8-----------------------------------------------
plotData(oligoSelectionMatch)

## -----------------------------------------------------------------------------
## Convert the first two oligos 
as(myOligos[1:2, ], "DNAStringSet")

## -----------------------------------------------------------------------------
## Convert the first two assays 
as(myAssays[1:2, ], "DNAStringSet")

## ----warning=FALSE------------------------------------------------------------
data("exampleRprimerProfile")
data("exampleRprimerOligo")
data("exampleRprimerAssay")
data("exampleRprimerMatchOligo")
data("exampleRprimerMatchAssay")

## -----------------------------------------------------------------------------
sessionInfo()

