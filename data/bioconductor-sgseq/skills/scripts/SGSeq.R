# Code example from 'SGSeq' vignette. See references/ for full tutorial.

## ----echo = FALSE, results = 'hide'-------------------------------------------
library(knitr)
opts_chunk$set(error = FALSE)

## ----style, echo = FALSE, results = 'asis'------------------------------------
##BiocStyle::markdown()

## ----message = FALSE----------------------------------------------------------
library(SGSeq)

## -----------------------------------------------------------------------------
si

## -----------------------------------------------------------------------------
path <- system.file("extdata", package = "SGSeq")
si$file_bam <- file.path(path, "bams", si$file_bam)

## ----message = FALSE----------------------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GenomeInfoDb)  # for keepSeqlevels() and seqlevelsStyle()
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txdb <- keepSeqlevels(txdb, "chr16")
seqlevelsStyle(txdb) <- "NCBI"

## -----------------------------------------------------------------------------
txf_ucsc <- convertToTxFeatures(txdb)
txf_ucsc <- txf_ucsc[txf_ucsc %over% gr]
head(txf_ucsc)

## -----------------------------------------------------------------------------
type(txf_ucsc)
head(txName(txf_ucsc))
head(geneName(txf_ucsc))

## -----------------------------------------------------------------------------
sgf_ucsc <- convertToSGFeatures(txf_ucsc)
head(sgf_ucsc)

## ----message = FALSE----------------------------------------------------------
sgfc_ucsc <- analyzeFeatures(si, features = txf_ucsc)
sgfc_ucsc

## ----eval = FALSE-------------------------------------------------------------
# colData(sgfc_ucsc)
# rowRanges(sgfc_ucsc)
# head(counts(sgfc_ucsc))
# head(FPKM(sgfc_ucsc))

## ----figure-1, fig.width=4.5, fig.height=4.5----------------------------------
df <- plotFeatures(sgfc_ucsc, geneID = 1)

## ----message = FALSE----------------------------------------------------------
sgfc_pred <- analyzeFeatures(si, which = gr)
head(rowRanges(sgfc_pred))

## -----------------------------------------------------------------------------
sgfc_pred <- annotate(sgfc_pred, txf_ucsc)
head(rowRanges(sgfc_pred))

## ----figure-2, fig.width=4.5, fig.height=4.5----------------------------------
df <- plotFeatures(sgfc_pred, geneID = 1, color_novel = "red")

## ----message = FALSE----------------------------------------------------------
sgvc_pred <- analyzeVariants(sgfc_pred)
sgvc_pred

## -----------------------------------------------------------------------------
mcols(sgvc_pred)

## -----------------------------------------------------------------------------
variantFreq(sgvc_pred)

## ----figure-3, fig.width=1.5, fig.height=4.5----------------------------------
plotVariants(sgvc_pred, eventID = 1, color_novel = "red")

## ----message = FALSE----------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
seqlevelsStyle(Hsapiens) <- "NCBI"
vep <- predictVariantEffects(sgv_pred, txdb, Hsapiens)
vep

## ----eval = FALSE-------------------------------------------------------------
# plotFeatures(sgfc_pred, geneID = 1)
# plotFeatures(sgfc_pred, geneName = "79791")
# plotFeatures(sgfc_pred, which = gr)

## ----eval = FALSE-------------------------------------------------------------
# plotFeatures(sgfc_pred, geneID = 1, include = "junctions")
# plotFeatures(sgfc_pred, geneID = 1, include = "exons")
# plotFeatures(sgfc_pred, geneID = 1, include = "both")

## ----eval = FALSE-------------------------------------------------------------
# plotFeatures(sgfc_pred, geneID = 1, toscale = "gene")
# plotFeatures(sgfc_pred, geneID = 1, toscale = "exon")
# plotFeatures(sgfc_pred, geneID = 1, toscale = "none")

## ----figure-4, fig.width=4.5, fig.height=4.5----------------------------------
par(mfrow = c(5, 1), mar = c(1, 3, 1, 1))
plotSpliceGraph(rowRanges(sgfc_pred), geneID = 1, toscale = "none", color_novel = "red")
for (j in 1:4) {
  plotCoverage(sgfc_pred[, j], geneID = 1, toscale = "none")
}

## ----message = FALSE----------------------------------------------------------
sgv <- rowRanges(sgvc_pred)
sgvc <- getSGVariantCounts(sgv, sample_info = si)
sgvc

## -----------------------------------------------------------------------------
x <- counts(sgvc)
vid <- variantID(sgvc)
eid <- eventID(sgvc)

## ----message = FALSE----------------------------------------------------------
txf <- predictTxFeatures(si, gr)
sgf <- convertToSGFeatures(txf)
sgf <- annotate(sgf, txf_ucsc)
sgfc <- getSGFeatureCounts(si, sgf)
sgv <- findSGVariants(sgf)
sgvc <- getSGVariantCounts(sgv, sgfc)

## -----------------------------------------------------------------------------
sessionInfo()

