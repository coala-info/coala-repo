# Code example from 'make-data' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# NL42_100K <- NestLink:::.getReadsFromFastq("inst/extdata/NL42_100K.fastq.gz")
# save(NL42_100K, file="inst/extdata/NestLink_NL42_100K.RData")

## ----eval=FALSE---------------------------------------------------------------
# 
# expFile <- query(eh, c("NestLink", "NL42_100K.fastq.gz"))[[1]]
# expect_true(file.exists(expFile))
# scratchFolder <- tempdir()
# setwd(scratchFolder)
# 
# knownNB_File <- query(eh, c("NestLink", "knownNB.txt"))[[1]]
# knownNB_data <- read.table(knownNB_File,
#                            sep='\t',
#                            header = TRUE,
#                            row.names = 1,
#                            stringsAsFactors = FALSE)
# 
# knownNB <- Biostrings::translate(DNAStringSet(knownNB_data$Sequence))
# names(knownNB) <- rownames(knownNB_data)
# knownNB <- sapply(knownNB, toString)
# 
# param <- list()
# param[['NB_Linker1']] <- "GGCCggcggGGCC"
# param[['NB_Linker2']] <- "GCAGGAGGA"
# param[['ProteaseSite']] <- "TTAGTCCCAAGA"
# param[['FC_Linker']] <- "GGCCaaggaggcCGG"
# param[['knownNB']] <- knownNB
# param[['nReads']] <- 100
# param[['minRelBestHitFreq']] <- 0.8
# param[['minConsensusScore']] <- 0.9
# param[['maxMismatch']] <- 1
# param[['minNanobodyLength']] <- 348
# param[['minFlycodeLength']] <- 33
# param[['FCminFreq']] <- 1
# 
# nanobodyFlycodeLinkage.RData <- runNGSAnalysis(file = expFile[1], param)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------
library(NestLink)
NB <- getNB()
FC <- getFC()

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(knitr)
kable(head(NB))
kable(head(FC))

## ----eval=FALSE---------------------------------------------------------------
# load("~/Downloads/444589.RData")
# library(protViz)
# library(NestLink)
# WU160118 <- do.call('rbind', lapply(list("F255737", "F255744", "F255747",
#   "F255749", "F255751", "F255760", "F255761", "F255762"),
#   function(datfilename){
#       df <- as.data.frame.mascot(get(datfilename))
#       df$datfilename <- datfilename
#       df
#     }
#   ))
# save(WU160118, file = "../inst/extdata/WU160118.RData",
#      compress = TRUE, compression_level = 9)

## ----echo=TRUE, message=FALSE, warning=FALSE----------------------------------

library(ExperimentHub)
eh <- ExperimentHub(); 
load(query(eh, c("NestLink", "WU160118.RData"))[[1]])
class(WU160118)
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
idx <- grepl(PATTERN, WU160118$pep_seq)
WU <- WU160118[idx & WU160118$pep_score > 25,]

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
kable(unique(unlist(lapply(strsplit(x=as.character(WU$pep_scan_title), split=";"), function(x)gsub("File:", "", gsub("\\\\", "/", x[1]))))))

## ----eval=TRUE----------------------------------------------------------------
fl <- system.file("extdata", "metadata.csv", package='NestLink')
kable(metadata <- read.csv(fl, stringsAsFactors=FALSE))

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(ExperimentHub)

eh <- ExperimentHub(); 
query(eh, "NestLink")

load(query(eh, c("NestLink", "F255744.RData"))[[1]])
dim(F255744)

load(query(eh, c("NestLink", "WU160118.RData"))[[1]])
dim(WU160118)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

