# Code example from 'RNAmodR.RiboMethSeq' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
  library(rtracklayer)
  library(GenomicRanges)
  library(RNAmodR.RiboMethSeq)
  library(RNAmodR.Data)
})

## ----eval = FALSE-------------------------------------------------------------
# library(rtracklayer)
# library(GenomicRanges)
# library(RNAmodR.RiboMethSeq)
# library(RNAmodR.Data)

## ----message=FALSE, results='hide'--------------------------------------------
annotation <- GFF3File(RNAmodR.Data.example.RMS.gff3())
sequences <- RNAmodR.Data.example.RMS.fasta()
files <- list("Sample1" = c(treated = RNAmodR.Data.example.RMS.1()),
              "Sample2" = c(treated = RNAmodR.Data.example.RMS.2()))

## -----------------------------------------------------------------------------
msrms <- ModSetRiboMethSeq(files, annotation = annotation, sequences = sequences)
msrms

## -----------------------------------------------------------------------------
table <- read.csv2(RNAmodR.Data.snoRNAdb(), stringsAsFactors = FALSE)
table <- table[table$hgnc_id == "53533",] # Subset to RNA5.8S
# keep only the current coordinates
table <- table[,1L:7L]
snoRNAdb <- GRanges(seqnames = "chr1",
              ranges = IRanges(start = table$position,
                               width = 1),
              strand = "+",
              type = "RNAMOD",
              mod = table$modification,
              Parent = "1", #this is the transcript id
              Activity = IRanges::CharacterList(strsplit(table$guide,",")))
coord <- split(snoRNAdb,snoRNAdb$Parent)

## -----------------------------------------------------------------------------
ranges(msrms)
alias <- data.frame(tx_id = "1", name = "5.8S rRNA", stringsAsFactors = FALSE)

## ----plot1, fig.cap="Heatmap showing RiboMethSeq scores for 2'-O methylated positions on the 5.8S rRNA."----
plotCompareByCoord(msrms[c(2L,1L)], coord, alias = alias)

## ----plot2, fig.cap="RiboMethSeq scores around Um(14) on 5.8S rRNA.", fig.asp=1----
singleCoord <- coord[[1L]][1L,]
plotDataByCoord(msrms, singleCoord)

## ----plot3, fig.cap="RiboMethSeq scores around Um(14) on 5.8S rRNA. Sequence data is shown by setting `showSequenceData = TRUE`.", fig.asp=1----
singleCoord <- coord[[1L]][1L,]
plotDataByCoord(msrms, singleCoord, showSequenceData = TRUE)

## ----plot4, fig.cap="TPR versus FPR plot.", fig.asp=1-------------------------
plotROC(msrms,coord)

## ----settings-----------------------------------------------------------------
settings(msrms) <- list(minScoreMean = 0.7)
msrms

## ----udpate-------------------------------------------------------------------
msrms2 <- modify(msrms,force = TRUE)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

