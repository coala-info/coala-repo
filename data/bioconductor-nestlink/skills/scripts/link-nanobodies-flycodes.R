# Code example from 'link-nanobodies-flycodes' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----workflow_chunk0, message=FALSE, warning=FALSE----------------------------
library(NestLink)

## -----------------------------------------------------------------------------
library(ExperimentHub)

eh <- ExperimentHub()

query(eh, "NestLink")

## ----define.input.output------------------------------------------------------
# dataFolder <- file.path(path.package(package = 'NestLink'), 'extdata')
# expFile <- list.files(dataFolder, pattern='*.fastq.gz', full.names = TRUE)

expFile <- query(eh, c("NestLink", "NL42_100K.fastq.gz"))[[1]]
scratchFolder <- tempdir()
setwd(scratchFolder)

## ----load.knownNB-------------------------------------------------------------
# knownNB_File <- list.files(dataFolder,
#      pattern='knownNB.txt', full.names = TRUE)
knownNB_File <- query(eh, c("NestLink", "knownNB.txt"))[[1]]

knownNB_data <- read.table(knownNB_File, sep='\t',
      header = TRUE, row.names = 1, stringsAsFactors = FALSE)

knownNB <- Biostrings::translate(DNAStringSet(knownNB_data$Sequence))
names(knownNB) <- rownames(knownNB_data)
knownNB <- sapply(knownNB, toString)

## ----setupParameter-----------------------------------------------------------
param <- list()
param[['nReads']] <- 100 #Number of Reads from the start of fastq file to process
param[['maxMismatch']] <- 1 #Number of accepted mismatches for all pattern search steps
param[['NB_Linker1']] <- "GGCCggcggGGCC" #Linker Sequence left to nanobody
param[['NB_Linker2']] <- "GCAGGAGGA" #Linker Sequence right to nanobody
param[['ProteaseSite']] <- "TTAGTCCCAAGA" #Sequence next to flycode
param[['FC_Linker']] <- "GGCCaaggaggcCGG" #Linker Sequence next to flycode
param[['knownNB']] <- knownNB
param[['minRelBestHitFreq']] <- 0.8 #minimal fraction of the dominant nanobody for a specific flycode
param[['minConsensusScore']] <- 0.9 #minimal fraction per sequence position in nanabody consensus sequence calculation
param[['minNanobodyLength']] <- 348 #minimal nanobody length in [nt]
param[['minFlycodeLength']] <- 33  #minimal flycode length in [nt]
param[['FCminFreq']] <- 1 #minimal number of subreads for a specific flycode to keep it in the analysis

## ----filterExtractTranslateSequences, message=FALSE---------------------------
system.time(NB2FC <- runNGSAnalysis(file = expFile[1], param))

## ----sanityCheck.NB.FC.linkage------------------------------------------------
head(NB2FC, 2)

## ----write.AA.FASTA-----------------------------------------------------------
head(nanobodyFlycodeLinking.as.fasta(NB2FC))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

# References

