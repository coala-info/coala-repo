# Code example from 'crisprScore' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
options("knitr.graphics.auto_pdf"=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version="devel")
# BiocManager::install("crisprScore")

## ----eval=FALSE---------------------------------------------------------------
# options(reticulate.useImportHook=FALSE)

## ----warnings=FALSE, message=FALSE--------------------------------------------
library(crisprScore)

## -----------------------------------------------------------------------------
data(scoringMethodsInfo)
print(scoringMethodsInfo)

## ----echo=FALSE,fig.cap="Sequence inputs for Cas9 scoring methods"------------
knitr::include_graphics("./figures/sequences_cas9.svg")

## ----eval=TRUE----------------------------------------------------------------
flank5 <- "ACCT" #4bp
spacer <- "ATCGATGCTGATGCTAGATA" #20bp
pam    <- "AGG" #3bp 
flank3 <- "TTG" #3bp
input  <- paste0(flank5, spacer, pam, flank3) 
results <- getRuleSet1Scores(input)

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCT" #4bp
# spacer <- "ATCGATGCTGATGCTAGATA" #20bp
# pam    <- "AGG" #3bp
# flank3 <- "TTG" #3bp
# input  <- paste0(flank5, spacer, pam, flank3)
# results <- getAzimuthScores(input)

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCT" #4bp
# spacer <- "ATCGATGCTGATGCTAGATA" #20bp
# pam    <- "AGG" #3bp
# flank3 <- "TTG" #3bp
# input  <- paste0(flank5, spacer, pam, flank3)
# results <- getRuleSet3Scores(input, tracrRNA="Hsu2013")

## ----eval=FALSE---------------------------------------------------------------
# spacer  <- "ATCGATGCTGATGCTAGATA" #20bp
# pam     <- "AGG" #3bp
# input   <- paste0(spacer, pam)
# results <- getDeepHFScores(input)

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCT" #4bp
# spacer <- "ATCGATGCTGATGCTAGATA" #20bp
# pam    <- "AGG" #3bp
# flank3 <- "TTG" #3bp
# input  <- paste0(flank5, spacer, pam, flank3)
# results <- getDeepSpCas9Scores(input)

## ----eval=TRUE----------------------------------------------------------------
flank5 <- "ACCTAA" #6bp
spacer <- "ATCGATGCTGATGCTAGATA" #20bp
pam    <- "AGG" #3bp 
flank3 <- "TTGAAT" #6bp
input  <- paste0(flank5, spacer, pam, flank3) 
results <- getCRISPRscanScores(input)

## ----eval=TRUE----------------------------------------------------------------
spacer <- "ATCGATGCTGATGCTAGATA" #20bp
results <- getCRISPRaterScores(spacer)

## ----eval=TRUE----------------------------------------------------------------
head(tssExampleCrispri)

## ----eval=TRUE----------------------------------------------------------------
head(sgrnaExampleCrispri)

## ----eval=FALSE---------------------------------------------------------------
# results <- getCrispraiScores(tss_df=tssExampleCrispri,
#                              sgrna_df=sgrnaExampleCrispri,
#                              modality="CRISPRi",
#                              fastaFile="your/path/hg38.fa",
#                              chromatinFiles=c(mnase="path/to/mnaseFile.bw",
#                                                  dnase="path/to/dnaseFile.bw",
#                                                  faire="oath/to/faireFile.bw"))

## ----echo=FALSE, fig.cap="Sequence inputs for Cas12a scoring methods"---------
knitr::include_graphics("./figures/sequences_cas12a.svg")

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCA" #4bp
# pam    <- "TTTT" #4bp
# spacer <- "AATCGATGCTGATGCTAGATATT" #23bp
# flank3 <- "AAG" #3bp
# input  <- paste0(flank5, pam, spacer, flank3)
# results <- getDeepCpf1Scores(input)

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCG" #4bp
# pam    <- "TTTT" #4bp
# spacer <- "AATCGATGCTGATGCTAGATATT" #23bp
# flank3 <- "AAG" #3bp
# input  <- paste0(flank5, pam, spacer, flank3)
# results <- getEnPAMGBScores(input)

## ----eval=FALSE---------------------------------------------------------------
# fasta <- file.path(system.file(package="crisprScore"),
#                    "casrxrf/test.fa")
# mrnaSequence <- Biostrings::readDNAStringSet(filepath=fasta
#                                              format="fasta",
#                                              use.names=TRUE)
# results <- getCasRxRFScores(mrnaSequence)

## -----------------------------------------------------------------------------
spacer   <- "ATCGATGCTGATGCTAGATA"
protospacers  <- c("ACCGATGCTGATGCTAGATA",
                   "ATCGATGCTGATGCTAGATT",
                   "ATCGATGCTGATGCTAGATA")
pams <- c("AGG", "AGG", "AGA")
getMITScores(spacers=spacer,
             protospacers=protospacers,
             pams=pams)

## -----------------------------------------------------------------------------
spacer   <- "ATCGATGCTGATGCTAGATA"
protospacers  <- c("ACCGATGCTGATGCTAGATA",
                   "ATCGATGCTGATGCTAGATT",
                   "ATCGATGCTGATGCTAGATA")
pams <- c("AGG", "AGG", "AGA")
getCFDScores(spacers=spacer,
             protospacers=protospacers,
             pams=pams)

## ----eval=FALSE---------------------------------------------------------------
# flank5 <- "ACCTTTTAATCGA" #13bp
# spacer <- "TGCTGATGCTAGATATTAAG" #20bp
# pam    <- "TGG" #3bp
# flank3 <- "CTTTTAATCGATGCTGATGCTAGATATTA" #29bp
# input <- paste0(flank5, spacer, pam, flank3)
# results <- getLindelScores(input)

## -----------------------------------------------------------------------------
sessionInfo()

