# Code example from 'Appendix' vignette. See references/ for full tutorial.

## ----download-data---------------------------------------------------------
d <- tempdir()
download.file(url = paste0("https://www.ebi.ac.uk/arrayexpress/files/",
                           "E-MTAB-4119/E-MTAB-4119.processed.3.zip"),
              destfile = file.path(d, "samples.zip"))
unzip(file.path(d, "samples.zip"), exdir = d)

fl <- list.files(d, pattern = "*_rsem.txt", full.names=TRUE)
names(fl) <- gsub("sample(.*)_rsem.txt", "\\1", basename(fl))
library(tximport)
library(readr)

txi <- tximport(fl, txIn = TRUE, txOut = TRUE,
                geneIdCol = "gene_id",
                txIdCol = "transcript_id",
                countsCol = "expected_count",
                lengthCol = "effective_length",
                abundanceCol = "TPM",
                countsFromAbundance = "scaledTPM",
                importer = function(x){ read_tsv(x) })


## --------------------------------------------------------------------------
download.file(url = paste0("https://www.ebi.ac.uk/arrayexpress/files/",
                           "E-MTAB-4119/E-MTAB-4119.processed.2.zip"),
              destfile = file.path(d, "truth.zip"))
unzip(file.path(d, "truth.zip"), exdir = d)

truthdat <- read_tsv(file.path(d, "truth_transcript.txt"))
#save( txi, truthdat, file="../data/soneson2016.rda" )

## ----cobraData, message=FALSE, warning=FALSE-------------------------------
library(iCOBRA)
data(cobradata_example)

## ----arrangeLists----------------------------------------------------------
assays <- list(
  qvalue=cobradata_example@padj,
  logFC=cobradata_example@score )
assays[["qvalue"]]$DESeq2 <- p.adjust(cobradata_example@pval$DESeq2, method="BH")
head( assays[["qvalue"]], 3)
head( assays[["logFC"]], 3)

## ----groundTruths----------------------------------------------------------
library(S4Vectors)
groundTruth <- DataFrame( cobradata_example@truth[,c("status", "logFC")] )
colnames(groundTruth) <- names( assays )
groundTruth <- groundTruth[rownames(assays[[1]]),]
head( groundTruth )

## ----buildColData----------------------------------------------------------
colData <- DataFrame( method=colnames(assays[[1]]) )
colData

## ----buildSB---------------------------------------------------------------
library(SummarizedBenchmark)
sb <- SummarizedBenchmark(
  assays=assays, 
  colData=colData,
  groundTruth=groundTruth )

