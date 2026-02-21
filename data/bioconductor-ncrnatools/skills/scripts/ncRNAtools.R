# Code example from 'ncRNAtools' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, fig.path='figures/')

## ----tidy = TRUE, eval = FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # The following line initializes usage of Bioc devel, and therefore should be
# # skipped in order to install the stable release version
# BiocManager::install(version='devel')
# 
# BiocManager::install("ncRNAtools")

## ----include = FALSE----------------------------------------------------------
library(ncRNAtools)
library(GenomicRanges)
library(IRanges)
library(S4Vectors)
library(ggplot2)

## ----tidy = TRUE--------------------------------------------------------------
rnaCentralTextSearch("HOTAIR")

## ----tidy = TRUE--------------------------------------------------------------
rnaCentralTextSearch("FMN AND species:\"Bacillus subtilis\"")

## ----tidy = TRUE--------------------------------------------------------------
rnaCentralRetrieveEntry("URS000037084E_1423")

## ----tidy = TRUE, tidy.opts=list(width.cutoff = 80)---------------------------
## Generate a GRanges object with the genomic ranges to be used to search the RNAcentral database

genomicCoordinates <- GenomicRanges::GRanges(seqnames=S4Vectors::Rle(c("chrC", "chrD")), 
                                             ranges=IRanges::IRanges(c(200000, 500000), c(300000, 550000)))

## Use the generated GRanges object to search the RNAcentral database

RNAcentralHits <- rnaCentralGenomicCoordinatesSearch(genomicCoordinates, "Yarrowia lipolytica")

## Check the number of hits in each provided genomic range

length(RNAcentralHits[[1]]) # 22 known ncRNA between positions 200000 and 300000 of chromosome C
length(RNAcentralHits[[2]]) # No known ncRNA between positions 500000 and 550000 of chromosome D


## ----tidy = TRUE--------------------------------------------------------------
tRNAfragment <- "UGCGAGAGGCACAGGGUUCGAUUCCCUGCAUCUCCA"

centroidFoldPrediction <- predictSecondaryStructure(tRNAfragment, "centroidFold")
centroidFoldPrediction$secondaryStructure

centroidHomFoldPrediction <- predictSecondaryStructure(tRNAfragment, "centroidHomFold")
centroidFoldPrediction$secondaryStructure

IPknotPrediction <- predictSecondaryStructure(tRNAfragment, "IPknot")
IPknotPrediction$secondaryStructure

## ----tidy = TRUE--------------------------------------------------------------
tRNAfragment2 <- "AAAGGGGUUUCCC"

RintWPrediction <- predictAlternativeSecondaryStructures(tRNAfragment2)

length(RintWPrediction) # A total of 2 alternative secondary structures were identified by RintW

RintWPrediction[[1]]$secondaryStructure
RintWPrediction[[2]]$secondaryStructure

## ----tidy = TRUE--------------------------------------------------------------
basePairProbabilityMatrix <- generatePairsProbabilityMatrix(centroidFoldPrediction$basePairProbabilities)

plotPairsProbabilityMatrix(basePairProbabilityMatrix)

## ----tidy = TRUE--------------------------------------------------------------
pairedBases <- findPairedBases(sequence=tRNAfragment, secondaryStructureString=IPknotPrediction$secondaryStructure)

plotCompositePairsMatrix(basePairProbabilityMatrix, pairedBases)

## ----tidy = TRUE--------------------------------------------------------------
## Read an example CT file corresponding to E. coli tmRNA

exampleCTFile <- system.file("extdata", "exampleCT.ct", package="ncRNAtools")

tmRNASequence <- "GGGGCUGAUUCUGGAUUCGACGGGAUUUGCGAAACCCAAGGUGCAUGCCGAGGGGCGGUUGGCCUCGUAAAAAGCCGCAAAAAAUAGUCGCAAACGACGAAAACUACGCUUUAGCAGCUUAAUAACCUGCUUAGAGCCCUCUCUCCCUAGCCUCCGCUCUUAGGACGGGGAUCAAGAGAGGUCAAACCCAAAAGAGAUCGCGUGGAAGCCCUGCCUGGGGUUGAAGCGUUAAAACUUAAUCAGGCUAGUUUGUUAGUGGCGUGUCCGUCCGCAGCUGGCAAGCGAAUGUAAAGACUGACUAAGCAUGUAGUACCGAGGAUGUAGGAAUUUCGGACGCGGGUUCAACUCCCGCCAGCUCCACCA"

tmRNASecondaryStructure <- readCT(exampleCTFile, tmRNASequence)

## Write a complete CT file for E. coli tmRNA

tempDir <- tempdir()
testCTFile <- paste(tempDir, "testCTfile.ct", sep="")

tmRNASecondaryStructureString <- pairsToSecondaryStructure(pairedBases=tmRNASecondaryStructure$pairsTable, sequence=tmRNASequence)

writeCT(testCTFile, sequence=tmRNASequence, 
        secondaryStructure=tmRNASecondaryStructureString, sequenceName="tmRNA")

## Read an example Dot-Bracket file

exampleDotBracketFile <- system.file("extdata", "exampleDotBracket.dot", 
                                     package="ncRNAtools")

exampleDotBracket <- readDotBracket(exampleDotBracketFile)

exampleDotBracket$freeEnergy # The structure has a free energy of -41.2 kcal/mol

## Write a Dot-Bracket file

tempDir2 <- tempdir()
testDotBracketFile <- paste(tempDir2, "testDotBracketFile.dot", sep="")

writeDotBracket(testDotBracketFile, sequence=exampleDotBracket$sequence, 
                secondaryStructure=exampleDotBracket$secondaryStructure, 
                sequenceName="Test sequence")

## ----tidy = TRUE--------------------------------------------------------------
extendedDotBracketString <- "...((((..[[[.))))]]]..."

plainDotBracketString <- flattenDotBracket(extendedDotBracketString)

## ----tidy = TRUE--------------------------------------------------------------
sessionInfo()

