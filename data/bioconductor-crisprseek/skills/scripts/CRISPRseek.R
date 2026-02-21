# Code example from 'CRISPRseek' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, 
                      warning = FALSE,
          					  tidy = FALSE, 
          					  fig.width = 6, 
          					  fig.height = 6,
          					  fig.align = "center")
# Handle the biofilecache error
library(BiocFileCache)
bfc <- BiocFileCache()
res <- bfcquery(bfc, "annotationhub.index.rds", field = "rname", exact = TRUE) 
bfcremove(bfc, rids = res$rid)

## ----fig.cap = "Analytical workflow and core functions in CRISPRseek", echo = FALSE, out.width = "90%", out.height = "90%"----
png <- system.file("extdata", "core_functions.png", package = "CRISPRseek")

knitr::include_graphics(png)

## ----message = FALSE----------------------------------------------------------
library(CRISPRseek)
library(BSgenome.Hsapiens.UCSC.hg38)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)

## -----------------------------------------------------------------------------
inputFilePath <- system.file('extdata', 'inputseq.fa', package = 'CRISPRseek')
outputDir <- getwd()
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         chromToSearch= "chrX", 
                         
                         # Annotation packages required for annotation.
                         txdb = TxDb.Hsapiens.UCSC.hg38.knownGene, 
                         orgAnn = org.Hs.egSYMBOL,
                         
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy")])
head(res$offtarget[, c("name", "OffTargetSequence", "alignment", "score", "gRNAefficacy")])

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         outputDir = outputDir,
                         overwrite = TRUE)

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens, # optional
                         chromToSearch = "",
                         outputDir = outputDir,
                         overwrite = TRUE)
res

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         max.mismatch = 0,
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy")])

## ----eval = FALSE-------------------------------------------------------------
# Sys.setenv(PATH = paste("/anaconda2/bin", Sys.getenv("PATH"), sep = ":"))
# system("python --version") # Should output Python 2.7.15.

## ----eval = FALSE-------------------------------------------------------------
# m <- system.file("extdata", "Morenos-Mateo.csv", package = "CRISPRseek")
# res <- offTargetAnalysis(inputFilePath = inputFilePath,
#                          BSgenomeName = Hsapiens,
#                          annotateExon = FALSE,
#                          chromToSearch = "chrX",
#                          max.mismatch = 0,
#                          rule.set = "CRISPRscan",
#                          baseBeforegRNA = 6,
#                          baseAfterPAM = 6,
#                          featureWeightMatrixFile = m,
#                          outputDir = outputDir,
#                          overwrite = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# inputFilePath2 <- system.file("extdata", "inputseqWithoutBSgenome.fa", package = "CRISPRseek")
# genomeSeqFile <- system.file("extdata", "genomeSeq.fasta", package = "CRISPRseek")
# 
# res <- offTargetAnalysis(inputFilePath = inputFilePath2,
#                          genomeSeqFile = genomeSeqFile,
#                          outputDir = outputDir,
#                          overwrite = TRUE)
# head(res$summary)

## -----------------------------------------------------------------------------
if (interactive()) {
  res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         findOffTargetsWithBulge = TRUE,
                         BSgenomeName = Hsapiens,
                         chromToSearch = "chrX",
                         annotateExon = FALSE,
                         outputDir = outputDir,
                         overwrite = TRUE)
  head(res$offtarget[, c("name", "gRNAPlusPAM_bulge", "OffTargetSequence_bulge", "n.RNABulge", "n.DNABulge", "alignment")])
}


## -----------------------------------------------------------------------------
if (interactive()) {
  gRNA_PAM <- findgRNAs(inputFilePath = system.file("extdata",
                                                    "inputseq.fa",
                                                    package = "CRISPRseek"),
                        pairOutputFile = "testpairedgRNAs.xls",
                        findPairedgRNAOnly = TRUE)
  res <- getOfftargetWithBulge(gRNA_PAM,
                               BSgenomeName = Hsapiens, 
                               chromToSearch = "chrX")
  head(res)
}

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         chromToSearch = "chrX", 
                         annotateExon = FALSE,
                         scoring.method = "CFDscore", 
                         PAM.pattern = "NNG$|NGN$", 
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$offtarget[, c("name", "gRNAPlusPAM", "score", "alignment")])

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         findPairedgRNAOnly = TRUE,
                         findgRNAsWithREcutOnly = TRUE,
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy", "PairedgRNAName", "REname")])

## -----------------------------------------------------------------------------
inputFile1Path <- system.file("extdata", "rs362331C.fa", package="CRISPRseek") 
inputFile2Path <- system.file("extdata", "rs362331T.fa", package="CRISPRseek") 

res <- compare2Sequences(inputFile1Path,
                         inputFile2Path, 
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res[, c("name", "gRNAPlusPAM", "scoreForSeq1", "scoreForSeq2", "gRNAefficacy", "scoreDiff")])

## -----------------------------------------------------------------------------
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         chromToSearch = "",
                         baseEditing = TRUE,
                         targetBase = "C",
                         editingWindow = 4:8,
                         editingWindow.offtargets = 4:8,
                         outputDir = outputDir,
                         overwrite = TRUE)
res

## -----------------------------------------------------------------------------
inputFilePath <- DNAStringSet("CCAGTTTGTGGATCCTGCTCTGGTGTCCTCCACACCAGAATCAGGGATCGAAAACTCATCAGTCGATGCGAGTCATCTAAATTCCGATCAATTTCACACTTTAAACG")
res <- offTargetAnalysis(inputFilePath,
                         chromToSearch = "",
                         gRNAoutputName = "testPEgRNAs", # Required when inputFilePath is a DNAStringSet object.
                         primeEditing = TRUE,
                         targeted.seq.length.change = 0,
                         bp.after.target.end = 15,
                         PBS.length = 15,
                         RT.template.length = 8:30,
                         RT.template.pattern = "D$",
                         target.start = 20,
                         target.end = 20,
                         corrected.seq = "T",
                         findPairedgRNAOnly = TRUE,
                         paired.orientation = "PAMin",
                         outputDir = outputDir, 
                         overwrite = TRUE)
res

## ----citation, message = FALSE------------------------------------------------
citation(package = "CRISPRseek")

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo()

