# Code example from 'monaLisa' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width = 7,
    fig.height = 5,
    out.width = "80%",
    fig.align = "center",
    crop = NULL # suppress "The magick package is required to crop" issue
)
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("monaLisa")

## ----quick, eval=FALSE--------------------------------------------------------
# # load package
# library(monaLisa)
# 
# # bin regions
# # - peak_change is a numerical vector
# # - peak_change needs to be created by the user to run this code
# peak_bins <- bin(x = peak_change, binmode = "equalN", nElement = 400)
# 
# # calculate motif enrichments
# # - peak_seqs is a DNAStringSet, pwms is a PWMatrixList
# # - peak_seqs and pwms need to be created by the user to run this code
# se <- calcBinnedMotifEnrR(seqs = peak_seqs,
#                           bins = peak_bins,
#                           pwmL = pwms)

## ----loadlib, message=FALSE---------------------------------------------------
library(GenomicRanges)
library(SummarizedExperiment)
library(JASPAR2020)
library(TFBSTools)
library(BSgenome.Mmusculus.UCSC.mm10)
library(monaLisa)
library(ComplexHeatmap)
library(circlize)

## ----loadLMRs-----------------------------------------------------------------
lmrfile <- system.file("extdata", "LMRsESNPmerged.gr.rds", 
                       package = "monaLisa")
lmr <- readRDS(lmrfile)
lmr

## ----alternativeInputs, eval=FALSE--------------------------------------------
# # starting from a bed file
# #   import as `GRanges` using `rtracklayer::import`
# #   remark: if the bed file also contains scores (5th column), these will be
# #           also be imported and available in the "score" metadata column,
# #           in this example in `lmr$score`
# lmr <- rtracklayer::import(con = "file.bed", format = "bed")
# 
# # starting from sequences in a FASTA file
# #   import as `DNAStringSet` using `Biostrings::readDNAStringSet`
# #   remark: contrary to the coordinates in a `GRanges` object like `lmr` above,
# #           the sequences in `lmrseqs` can be directly used as input to
# #           monaLisa::calcBinnedMotifEnrR (no need to extract sequences from
# #           the genome, just skip that step below)
# lmrseqs <- Biostrings::readDNAStringSet(filepath = "myfile.fa", format = "fasta")

## ----deltameth----------------------------------------------------------------
hist(lmr$deltaMeth, 100, col = "gray", main = "",
     xlab = "Change of methylation (NP - ES)", ylab = "Number of LMRs")

## ----lmrsel-------------------------------------------------------------------
set.seed(1)
lmrsel <- lmr[ sample(x = length(lmr), size = 10000, replace = FALSE) ]

## ----binlmrs------------------------------------------------------------------
bins <- bin(x = lmrsel$deltaMeth, binmode = "equalN", nElement = 800, 
            minAbsX = 0.3)
table(bins)

## -----------------------------------------------------------------------------
# find the index of the level representing the zero bin 
levels(bins)
getZeroBin(bins)

## ----plotbins-----------------------------------------------------------------
plotBinDensity(lmrsel$deltaMeth, bins)

## ----getmotifs----------------------------------------------------------------
pwms <- getMatrixSet(JASPAR2020,
                     opts = list(matrixtype = "PWM",
                                 tax_group = "vertebrates"))

## ----makewidthequal-----------------------------------------------------------
summary(width(lmrsel))
lmrsel <- trim(resize(lmrsel, width = median(width(lmrsel)), fix = "center"))
summary(width(lmrsel))

## ----getseqs------------------------------------------------------------------
lmrseqs <- getSeq(BSgenome.Mmusculus.UCSC.mm10, lmrsel)

## ----bindiag------------------------------------------------------------------
plotBinDiagnostics(seqs = lmrseqs, bins = bins, aspect = "GCfrac")
plotBinDiagnostics(seqs = lmrseqs, bins = bins, aspect = "dinucfreq")

## ----runbinned, eval=FALSE----------------------------------------------------
# se <- calcBinnedMotifEnrR(seqs = lmrseqs, bins = bins, pwmL = pwms)

## ----getresults---------------------------------------------------------------
se <- readRDS(system.file("extdata", "results.binned_motif_enrichment_LMRs.rds",
                          package = "monaLisa"))

## ----summarizedexperiment-----------------------------------------------------
# summary
se
dim(se) # motifs-by-bins

# motif info
rowData(se)
head(rownames(se))

# bin info
colData(se)
head(colnames(se))

# assays: the motif enrichment results
assayNames(se)
assay(se, "log2enr")[1:5, 1:3]

## ----plottfs, fig.height=10---------------------------------------------------
# select strongly enriched motifs
sel <- apply(assay(se, "negLog10Padj"), 1, 
             function(x) max(abs(x), 0, na.rm = TRUE)) > 4.0
sum(sel)
seSel <- se[sel, ]

# plot
plotMotifHeatmaps(x = seSel, which.plots = c("log2enr", "negLog10Padj"), 
                  width = 2.0, cluster = TRUE, maxEnr = 2, maxSig = 10, 
                  show_motif_GC = TRUE)

## ----selsigvariants-----------------------------------------------------------
# significantly enriched in bin 8
levels(bins)[8]
sel.bin8 <- assay(se, "negLog10Padj")[, 8] > 4.0
sum(sel.bin8, na.rm = TRUE)

# significantly enriched in any "non-zero" bin
getZeroBin(bins)
sel.nonZero <- apply(
    assay(se, "negLog10Padj")[, -getZeroBin(bins), drop = FALSE], 1,
    function(x) max(abs(x), 0, na.rm = TRUE)) > 4.0
sum(sel.nonZero)

## ----wmclustering-------------------------------------------------------------
SimMatSel <- motifSimilarity(rowData(seSel)$motif.pfm)
range(SimMatSel)

## ----plottfsclustered, fig.height=10, fig.width=8-----------------------------
# create hclust object, similarity defined by 1 - Pearson correlation
hcl <- hclust(as.dist(1 - SimMatSel), method = "average")
plotMotifHeatmaps(x = seSel, which.plots = c("log2enr", "negLog10Padj"), 
                  width = 1.8, cluster = hcl, maxEnr = 2, maxSig = 10,
                  show_dendrogram = TRUE, show_seqlogo = TRUE,
                  width.seqlogo = 1.2)

## -----------------------------------------------------------------------------
# get PFMs from JASPAR2020 package (vertebrate subset)
pfms <- getMatrixSet(JASPAR2020,
                     opts = list(matrixtype = "PFM",
                                 tax_group = "vertebrates"))

# convert PFMs to PWMs
pwms <- toPWM(pfms)

# convert JASPAR2020 PFMs (vertebrate subset) to Homer motif file
tmp <- tempfile()
convert <- dumpJaspar(filename = tmp,
                      pkg = "JASPAR2020",
                      pseudocount = 0,
                      opts = list(tax_group = "vertebrates"))

# convert Homer motif file to PFMatrixList
pfms_ret <- homerToPFMatrixList(filename = tmp, n = 100L)

# compare the first PFM
# - notice the different magnitude of counts (controlled by `n`)
# - notice that with the default (recommended) value of `pseudocount = 1.0`,
#   there would be no zero values in pfms_ret matrices, making
#   pfms and pfms_ret even more different
as.matrix(pfms[[1]])
as.matrix(pfms_ret[[1]])

# compare position probability matrices with the original PFM 
round(sweep(x = as.matrix(pfms[[1]]), MARGIN = 2, 
            STATS = colSums(as.matrix(pfms[[1]])), FUN = "/"), 3)
round(sweep(x = as.matrix(pfms_ret[[1]]), MARGIN = 2, 
            STATS = colSums(as.matrix(pfms_ret[[1]])), FUN = "/"), 3)

## ----defineSetsBinary---------------------------------------------------------
lmr.unchanged <- lmrsel[abs(lmrsel$deltaMeth) < 0.05]
length(lmr.unchanged)

lmr.up <- lmrsel[lmrsel$deltaMeth > 0.6]
length(lmr.up)

## ----fuseSetsBinary-----------------------------------------------------------
# combine the two sets or genomic regions
lmrsel2 <- c(lmr.unchanged, lmr.up)

# extract sequences from the genome
lmrseqs2 <- getSeq(BSgenome.Mmusculus.UCSC.mm10, lmrsel2)

## ----createBins2--------------------------------------------------------------
# define binning vector
bins2 <- rep(c("unchanged", "up"), c(length(lmr.unchanged), length(lmr.up)))
bins2 <- factor(bins2)
table(bins2)

## ----enrBinary----------------------------------------------------------------
se2 <- calcBinnedMotifEnrR(seqs = lmrseqs2, bins = bins2,
                           pwmL = pwms[rownames(seSel)])
se2

## ----plotBinary, fig.height=6, fig.width=8------------------------------------
sel2 <- apply(assay(se2, "negLog10Padj"), 1, 
             function(x) max(abs(x), 0, na.rm = TRUE)) > 4.0
sum(sel2)

plotMotifHeatmaps(x = se2[sel2,], which.plots = c("log2enr", "negLog10Padj"), 
                  width = 1.8, cluster = TRUE, maxEnr = 2, maxSig = 10,
                  show_seqlogo = TRUE)

## ----singleBinSeqs------------------------------------------------------------
lmrseqs3 <- lmrseqs[bins == levels(bins)[1]]
length(lmrseqs3)

se3 <- calcBinnedMotifEnrR(seqs = lmrseqs3,
                           pwmL = pwms[rownames(seSel)],
                           background = "genome",
                           genome = BSgenome.Mmusculus.UCSC.mm10,
                           genome.regions = NULL, # sample from full genome
                           genome.oversample = 2, 
                           BPPARAM = BiocParallel::SerialParam(RNGseed = 42),
                           verbose = TRUE)

## ----singleBinResult----------------------------------------------------------
ncol(se3)

## ----plotSingleBin, fig.height=8, fig.width=8---------------------------------
sel3 <- assay(se3, "negLog10Padj")[, 1] > 4.0
sum(sel3)

plotMotifHeatmaps(x = se3[sel3,], which.plots = c("log2enr", "negLog10Padj"), 
                  width = 1.8, maxEnr = 2, maxSig = 10,
                  show_seqlogo = TRUE)

# analyzed HOX motifs
grep("HOX", rowData(se3)$motif.name, value = TRUE)

# significant HOX motifs
grep("HOX", rowData(se3)$motif.name[sel3], value = TRUE)

## ----compareGenomeVsBinned, fig.width=7, fig.height=6-------------------------
cols <- rep("gray", nrow(se3))
cols[grep("HOX", rowData(se3)$motif.name)] <- "#DF536B"
cols[grep("KLF|Klf", rowData(se3)$motif.name)] <- "#61D04F"
par(mar = c(5, 5, 2, 2) + .1, mgp = c(1.75, 0.5, 0), cex = 1.25)
plot(assay(seSel, "log2enr")[,1], assay(se3, "log2enr")[,1],
     col = cols, pch = 20, asp = 1,
     xlab = "Versus other bins (log2 enr)",
     ylab = "Versus genome (log2 enr)")
legend("topleft", c("HOX family","KLF family","other"), pch = 20, bty = "n",
       col = c("#DF536B", "#61D04F", "gray"))
abline(a = 0, b = 1)
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)

## ----binnedkmerenr, eval=FALSE------------------------------------------------
# sekm <- calcBinnedKmerEnr(seqs = lmrseqs, bins = bins, kmerLen = 6,
#                           includeRevComp = TRUE)

## ----binnedkmerenr-load-------------------------------------------------------
sekm <- readRDS(system.file(
    "extdata", "results.binned_6mer_enrichment_LMRs.rds",
    package = "monaLisa"
))

## -----------------------------------------------------------------------------
sekm

## -----------------------------------------------------------------------------
selkm <- apply(assay(sekm, "negLog10Padj"), 1, 
               function(x) max(abs(x), 0, na.rm = TRUE)) > 4
sum(selkm)
sekmSel <- sekm[selkm, ]

## ----fig.width=10, fig.height=10----------------------------------------------
pfmSel <- rowData(seSel)$motif.pfm
sims <- motifKmerSimilarity(x = pfmSel,
                            kmers = rownames(sekmSel),
                            includeRevComp = TRUE)
dim(sims)

maxwidth <- max(sapply(TFBSTools::Matrix(pfmSel), ncol))
seqlogoGrobs <- lapply(pfmSel, seqLogoGrob, xmax = maxwidth)
hmSeqlogo <- rowAnnotation(logo = annoSeqlogo(seqlogoGrobs, which = "row"),
                           annotation_width = unit(1.5, "inch"), 
                           show_annotation_name = FALSE
)
Heatmap(sims, 
        show_row_names = TRUE, row_names_gp = gpar(fontsize = 8),
        show_column_names = TRUE, column_names_gp = gpar(fontsize = 8),
        name = "Similarity", column_title = "Selected TFs and enriched k-mers",
        col = colorRamp2(c(0, 1), c("white", "red")), 
        right_annotation = hmSeqlogo)

## ----findMotifs, warning=FALSE------------------------------------------------
# get sequences of promoters as a DNAStringSet
# (the `subject` of `findMotifHits` could also be a single DNAString,
#  or the name of a fasta file)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
gr <- trim(promoters(TxDb.Mmusculus.UCSC.mm10.knownGene,
                     upstream = 1000, downstream = 500)[c(1, 4, 5, 10)])
library(BSgenome.Mmusculus.UCSC.mm10)
seqs <- getSeq(BSgenome.Mmusculus.UCSC.mm10, gr)
seqs

# get motifs as a PWMatrixList
# (the `query` of `findMotifHits` could also be a single PWMatrix,
#  or the name of a motif file)
library(JASPAR2020)
library(TFBSTools)
pfms <- getMatrixByID(JASPAR2020, c("MA0885.1", "MA0099.3", "MA0033.2", 
                                    "MA0037.3", "MA0158.1"))
pwms <- toPWM(pfms)
pwms
name(pwms)

# predict hits in sequences
res <- findMotifHits(query = pwms,
                     subject = seqs,
                     min.score = 6.0,
                     method = "matchPWM",
                     BPPARAM = BiocParallel::SerialParam())
res

# create hit matrix:
# number of sites of each motif per sequence
m <- table(factor(seqnames(res), levels = names(seqs)),
           factor(res$pwmname, levels = name(pwms)))
m

## ----session------------------------------------------------------------------
sessionInfo()

