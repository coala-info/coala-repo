# Code example from 'RNAmodR.AlkAnilineSeq' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
  library(rtracklayer)
  library(GenomicRanges)
  library(RNAmodR.AlkAnilineSeq)
  library(RNAmodR.Data)
})

## ----eval = FALSE-------------------------------------------------------------
# library(rtracklayer)
# library(GenomicRanges)
# library(RNAmodR.AlkAnilineSeq)
# library(RNAmodR.Data)

## ----message=FALSE, results='hide'--------------------------------------------
annotation <- GFF3File(RNAmodR.Data.example.AAS.gff3())
sequences <- RNAmodR.Data.example.AAS.fasta()
files <- list("wt" = c(treated = RNAmodR.Data.example.wt.1(),
                       treated = RNAmodR.Data.example.wt.2(),
                       treated = RNAmodR.Data.example.wt.3()),
              "Bud23del" = c(treated = RNAmodR.Data.example.bud23.1(),
                             treated = RNAmodR.Data.example.bud23.2()),
              "Trm8del" = c(treated = RNAmodR.Data.example.trm8.1(),
                            treated = RNAmodR.Data.example.trm8.2()))

## -----------------------------------------------------------------------------
msaas <- ModSetAlkAnilineSeq(files, annotation = annotation, sequences = sequences)
msaas

## -----------------------------------------------------------------------------
mod <- modifications(msaas)
lapply(mod,head, n = 2L)

## -----------------------------------------------------------------------------
coord <- mod[[1L]]
alias <- data.frame(tx_id = c(1L,3L,5L,6L,7L,8L,10L,11L),
                    name = c("18S rRNA","tF(GAA)B","tG(GCC)B","tT(AGT)B",
                             "tQ(TTG)B","tC(GCA)B","tS(CGA)C","tV(AAC)E1"),
                    stringsAsFactors = FALSE)

## ----plot1, fig.cap="Heatmap showing Stop ratio scores for detected m7G, m3C and D positions.", fig.asp=1----
plotCompareByCoord(msaas, coord, score = "scoreSR", alias = alias,
                   normalize = TRUE)

## ----plot2, fig.cap="Heatmap showing Stop ratio scores for detected m7G1575 on the 18S rRNA.", fig.asp=0.5----
plotCompareByCoord(msaas, coord[1L], score = "scoreSR", alias = alias)

## ----plot3, fig.cap="Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence.", fig.asp=1----
plotData(msaas, "1", from = 1550L, to = 1600L)

## ----plot4, fig.cap="Stop ratio scores for detected m7G1575 on the 18S rRNA plotted as bar plots along the sequence. The raw sequence data is shown by setting `showSequenceData = TRUE.", fig.asp=1----
plotData(msaas[1L:2L], "1", from = 1550L, to = 1600L, showSequenceData = TRUE)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

