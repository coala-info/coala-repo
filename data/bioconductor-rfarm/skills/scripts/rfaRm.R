# Code example from 'rfaRm' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, fig.path='figures/')

## ----include = FALSE----------------------------------------------------------
library(rfaRm)
library(rsvg)
library(R4RNA)
library(treeio)

## ----tidy = TRUE--------------------------------------------------------------
rfamTextSearchFamilyAccession("riboswitch")

## ----tidy = TRUE, tidy.opts=list(width.cutoff = 80)---------------------------
sequenceSearch <- rfamSequenceSearch("GGAUCUUCGGGGCAGGGUGAAAUUCCCGACCGGUGGUAUAGUCCACGAAAGUAUUUGCUUUGAUUUGGUGAAAUUCCAAAACCGACAGUAGAGUCUGGAUGAGAGAAGAUUC")

length(sequenceSearch)

names(sequenceSearch)

## Save the aligned consensus sequence and query sequence to a text file, together with secondary structure annotation

writeLines(c(sequenceSearch$FMN$alignmentQuerySequence, sequenceSearch$FMN$alignmentMatch, sequenceSearch$FMN$alignmentHitSequence, sequenceSearch$FMN$alignmentSecondaryStructure), con="searchAlignment.txt")

## ----tidy = TRUE--------------------------------------------------------------
rfamFamilyAccessionToID("RF00174")

rfamFamilyIDToAccession("FMN")

## ----tidy = TRUE--------------------------------------------------------------
rfamFamilySummary("RF00174")

# The summary includes, amongst other data, a brief paragraph describing the family

rfamFamilySummary("RF00174")$comment

## ----tidy = TRUE--------------------------------------------------------------
rfamConsensusSecondaryStructure("RF00174", format="WUSS")

rfamConsensusSecondaryStructure("RF00174", format="DB")

rfamConsensusSecondaryStructure("RF00174", filename="RF00174secondaryStructure.txt", format="DB")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
secondaryStructureTable <- readVienna("RF00174secondaryStructure.txt")

plotHelix(secondaryStructureTable)

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
## Retrieve an SVG with a normal representation of the secondary structure of Rfam family RF00174 and store it into a character string, which can be read by rsvg after conversion from SVG string to raw data

normalSecondaryStructureSVG = rfamSecondaryStructureXMLSVG("RF00174", plotType="norm")
rsvg(charToRaw(normalSecondaryStructureSVG))

## Retrieve an SVG with a sequence conservation representation added to the secondary structure of Rfam family RF00174, and save it to an SVG file

rfamSecondaryStructureXMLSVG("RF00174", filename="RF00174SSsequenceConservation.svg", plotType="cons")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
## Plot a normal representation of the secondary structure of  Rfam family RF00174

rfamSecondaryStructurePlot("RF00174", plotType="norm")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
## Save to a PNG file a plot of a representation of the secondary structure of Rfam family with ID FMN with sequence conservation annotation

rfamSecondaryStructurePlot("RF00050", filename="RF00050SSsequenceConservation.png", plotType="cons")

## ----tidy = TRUE--------------------------------------------------------------
rfamSeedAlignment("RF00174", filename="RF00174seedAlignment.stk", format="stockholm")

rfamSeedAlignment("RF00174", filename="RF00174seedAlignment.stk", format="fasta")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
seedTreeNHXString <- rfamSeedTree("RF00050", filename="RF00050tree.nhx")

treeioTree <- read.nhx("RF00050tree.nhx")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
rfamSeedTreeImage("RF00164", filename="RF00164seedTreePlot.png", label="species")

## ----tidy = TRUE, echo = TRUE, results = 'hide'-------------------------------
rfamCovarianceModel("RF00050", filename="RF00050covarianceModel.cm")

## ----tidy = TRUE--------------------------------------------------------------
## By providing a filename, the sequence regions will be written to a tab-delimited file

sequenceRegions <- rfamSequenceRegions("RF00050", "RF00050sequenceRegions.txt")

head(sequenceRegions)

## ----tidy = TRUE--------------------------------------------------------------
## By providing a filename, the matching PDB entries will be written to a tab-delimited file

PDBentries <- rfamPDBMapping("RF00050", "RF00050PDBentries.txt")

PDBentries

