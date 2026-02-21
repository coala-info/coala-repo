# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::knit_hooks$set(optipng = knitr::hook_optipng)
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE,
                      optipng = '-o7')
this.dpi = 100

## ----echo=FALSE, results="hide", warning=FALSE--------------------------------
suppressPackageStartupMessages({
    library(GenomicRanges)
    library(GenomicAlignments)
    library(rtracklayer)
    library(ggplot2)
    library(tidyr)
    library(ComplexHeatmap)
    library(BindingSiteFinder)
    library(forcats)
    library(dplyr)
})

## ----BiocManager, eval=FALSE--------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("BindingSiteFinder")

## -----------------------------------------------------------------------------
files <- system.file("extdata", package="BindingSiteFinder")
load(list.files(files, pattern = ".rda$", full.names = TRUE))
bds

## -----------------------------------------------------------------------------
load(list.files(files, pattern = ".rds$", full.names = TRUE)[1])
gns

## -----------------------------------------------------------------------------
load(list.files(files, pattern = ".rds$", full.names = TRUE)[2])
regions

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# # run BSFind to compute binding sites
# bdsQuick = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions, est.subsetChromosome = "chr22")
# # export output as .bed
# exportToBED(bdsQuick, con = "./myBindingSites.bed")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# # not run
# quickFigure(bdsQuick, what = "main", save.filename = "./my_fig_main.pdf", save.device = "pdf")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# # not run
# quickFigure(bdsQuick, what = "supp", save.filename = "./my_fig_supp.pdf", save.device = "pdf")

## -----------------------------------------------------------------------------
# load crosslink sites
csFile <- system.file("extdata", "PureCLIP_crosslink_sites_examples.bed", 
                      package="BindingSiteFinder")
cs = rtracklayer::import(con = csFile, format = "BED", extraCols=c("additionalScores" = "character"))
cs$additionalScores = NULL
cs

## -----------------------------------------------------------------------------
# Load clip signal files and define meta data object
files <- system.file("extdata", package="BindingSiteFinder")
clipFilesP <- list.files(files, pattern = "plus.bw$", full.names = TRUE)
clipFilesM <- list.files(files, pattern = "minus.bw$", full.names = TRUE)

## -----------------------------------------------------------------------------
# make the meta table
meta = data.frame(
  id = c(1:4),
  condition = factor(rep("WT", 4)), 
  clPlus = clipFilesP, clMinus = clipFilesM)
meta

## ----eval=FALSE---------------------------------------------------------------
# library(BindingSiteFinder)
# bds = BSFDataSetFromBigWig(ranges = cs, meta = meta, silent = TRUE)

## ----eval=TRUE----------------------------------------------------------------
exampleFile <- list.files(files, pattern = ".rda$", full.names = TRUE)
load(exampleFile)
bds

## ----eval=TRUE, echo=FALSE----------------------------------------------------
# exampleFile <- list.files(files, pattern = ".rda$", full.names = TRUE)
# load(exampleFile)
# meta = data.frame(
#   id = c(1:4),
#   condition = factor(rep("WT", 4)), 
#   clPlus = clipFilesP, clMinus = clipFilesM)
# bds@meta = meta
# names(bds@signal$signalPlus) = c("1_WT", "2_WT", "3_WT", "4_WT")
# names(bds@signal$signalMinus) = c("1_WT", "2_WT", "3_WT", "4_WT")

## ----eval=FALSE---------------------------------------------------------------
# # exampleFile <- list.files(files, pattern = ".rda$", full.names = TRUE)
# # load(exampleFile)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# library(txdbmaker)
# # Make annotation database from gff3 file
# annoFile = "./gencode_v37_annotation.gff3"
# 
# annoDb = txdbmaker::makeTxDbFromGFF(file = annoFile, format = "gff3")
# annoInfo = rtracklayer::import(annoFile, format = "gff3")
# # Get genes as GRanges
# gns = genes(annoDb)
# idx = match(gns$gene_id, annoInfo$gene_id)
# meta = cbind(elementMetadata(gns),
#              elementMetadata(annoInfo)[idx,])
# meta = meta[,!duplicated(colnames(meta))]
# elementMetadata(gns) = meta

## -----------------------------------------------------------------------------
# Load GRanges with genes
geneFile <- list.files(files, pattern = "gns.rds$", full.names = TRUE)
load(geneFile)
gns

## ----eval=FALSE---------------------------------------------------------------
# # Count the overlaps of each binding site for each region of the transcript.
# cdseq = cds(annoDb)
# intrns = unlist(intronsByTranscript(annoDb))
# utrs3 = unlist(threeUTRsByTranscript(annoDb))
# utrs5 = unlist(fiveUTRsByTranscript(annoDb))
# regions = GRangesList(CDS = cdseq, Intron = intrns, UTR3 = utrs3, UTR5 = utrs5)

## -----------------------------------------------------------------------------
# Load list with transcript regions
regionFile <- list.files(files, pattern = "regions.rds$", full.names = TRUE)
load(regionFile)

## -----------------------------------------------------------------------------
bdsOut = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions,
              est.subsetChromosome = "chr22", veryQuiet = TRUE, est.maxBsWidth = 29)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="processingStepsFlowChart"-------
processingStepsFlowChart(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="pureClipGlobalFilterPlot. The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability. The selected cutoff is indicated by the dashed line. ", fig.small=TRUE----
pureClipGlobalFilterPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="estimateBsWidthPlot. The diagnostic show the ratio between the crosslink events within binding sites and the crosslink events in adjacent windows to the binding sites. This is effectively a 'percent-bound' type ratio, with the higher the better the associated binding site width captures the distribution of the underlying crosslink events. The plot shows how that ratio behaves for different binding site width under varying levels of the gene-wise filter.", fig.small=TRUE----
estimateBsWidthPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="duplicatedSitesPlot. Diagnostic plot that show how many crosslink sites overlap how many different genes in the annotation. The grey area for 2 and 3 overlaps indicates what proportion the option overlaps='keepSingle' removes in order to keep crosslink site numbers stable. ", fig.small=TRUE----
duplicatedSitesPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="mergeCrosslinkDiagnosticsPlot. Diagnostic plot with number and region size at each fitting itteration loop. ", fig.small=TRUE----
mergeCrosslinkDiagnosticsPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="makeBsSummaryPlot. Diagnostic bar chart indicating the number of binding site after each of the indicated filter options is applied given their input values.", fig.small=TRUE----
makeBsSummaryPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="reproducibilityFilterPlot. Reproducibility crosslink histogram, with the number of crosslink sites over the number of crosslinks per binding site for each replicate. The dashed line indicates the replicate-specific cutoff."----
reproducibilityFilterPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="reproducibilitySamplesPlot. UpSet plot indicating the degree of reproducibility overlap between each replicate. "----
reproducibilitySamplesPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, message=FALSE, fig.cap="reproducibilityScatterPlot. Bottom left) Pairwise correlations between all replicates as scatter. Upper right) Pairwise pearson correlation coefficient. Diagnoal) Coverage distribution as density."----
reproducibilityScatterPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="geneOverlapsPlot. UpSet plot with the number of binding sites overlapping a specific gene type from the annotation before overlaps were resolved. "----
geneOverlapsPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="targetGeneSpectrumPlot. Bar chart with the number of gene and binding sites of a given gene type after overlaps were resolved. ", fig.small=TRUE----
targetGeneSpectrumPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="transcriptRegionOverlapsPlot. UpSet plot with the number of binding sites overlapping a specific transcript region from the annotation before overlaps were resolved."----
transcriptRegionOverlapsPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="transcriptRegionSpectrumPlot. Bar chart with the number of binding sites for each transcript region after overlaps were resolved. ", fig.small=TRUE----
transcriptRegionSpectrumPlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="globalScorePlot. The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability.", fig.small=TRUE----
globalScorePlot(bdsOut)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="bindingSiteDefinednessPlot. Density distribution of binding site definedness as percent bound grouped by transcript region.", fig.small=TRUE----
bindingSiteDefinednessPlot(bdsOut, by = "transcript")

## -----------------------------------------------------------------------------
getRanges(bdsOut)

## ----eval=FALSE---------------------------------------------------------------
# exportToBED(bdsOut, con = "./myResults.bed")

## ----eval=FALSE---------------------------------------------------------------
# exportTargetGenes(bdsOut, format = "xslx", split = "transcriptRegion")

## ----fig.retina = 1, dpi = this.dpi, fig.cap="bindingSiteCoveragePlot. Coverage plot on replicate level."----
bindingSiteCoveragePlot(bdsOut, plotIdx = 8, flankPos = 100, autoscale = TRUE)

## ----fig.retina = 1, dpi = this.dpi-------------------------------------------
rangesBeforeRepFilter = getRanges(bds)
rangesAfterRepFilter = getRanges(bdsOut)
idx = which(!match(rangesBeforeRepFilter, rangesAfterRepFilter, nomatch = 0) > 0)
rangesRemovedByFilter = rangesBeforeRepFilter[idx]
bdsRemovedRanges = setRanges(bds, rangesRemovedByFilter)

bindingSiteCoveragePlot(bdsRemovedRanges, plotIdx = 2, flankPos = 50)

## ----fig.retina = 1, dpi = this.dpi, eval=FALSE-------------------------------
# pSites = getRanges(bds)
# bindingSiteCoveragePlot(bdsOut, plotIdx = 8, flankPos = 20, autoscale = TRUE,
#                         customRange = pSites, customRange.name = "pSites", shiftPos = -10)

## ----fig.retina = 1, dpi = this.dpi, eval=FALSE-------------------------------
# bindingSiteCoverage = coverageOverRanges(bdsOut, returnOptions = "merge_positions_keep_replicates")
# idxMaxCountsBs = which.max(rowSums(as.data.frame(mcols(bindingSiteCoverage))))
# bindingSiteCoveragePlot(bdsOut, plotIdx = idxMaxCountsBs, flankPos = 100, mergeReplicates = FALSE, shiftPos = 50)

## ----fig.retina = 1, dpi = this.dpi, eval=FALSE-------------------------------
# bdsCDS = setRanges(bdsOut, regions$CDS)
# cdsWithMostBs = which.max(countOverlaps(regions$CDS, getRanges(bdsOut)))
# 
# bindingSiteCoveragePlot(bdsCDS, plotIdx = cdsWithMostBs, showCentralRange = FALSE,
#                        flankPos = 250, shiftPos = 50, mergeReplicates = TRUE,
#                        highlight = FALSE, customRange = getRanges(bdsOut),
#                        customAnnotation = regions$CDS)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="transcriptRegionSpectrumPlot. Without region size normalization.", fig.small=TRUE, eval=FALSE----
# transcriptRegionSpectrumPlot(bdsOut, normalize = FALSE, values = "percentage")

## ----fig.retina = 1, dpi = this.dpi, fig.cap="transcriptRegionSpectrumPlot. With region size normalization.", fig.small=TRUE, eval=FALSE----
# transcriptRegionSpectrumPlot(bdsOut, normalize = TRUE, values = "percentage", normalize.factor = "median")

## -----------------------------------------------------------------------------
# compute binding sites
bds1 <- makeBindingSites(object = bds, bsSize = 3)
bds2 <- makeBindingSites(object = bds, bsSize = 9)
bds3 <- makeBindingSites(object = bds, bsSize = 19)
bds4 <- makeBindingSites(object = bds, bsSize = 29)
# summarize in list
l = list(`1. bsSize = 3` = bds1, `2. bsSize = 9` = bds2, 
         `3. bsSize = 19` = bds3, `4. bsSize = 29` = bds4)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="rangeCoveragePlot. Crosslink coverage summarized at potential binding sites, with current size given by the grey area."----
rangeCoveragePlot(l, width = 20, show.samples = TRUE, subset.chromosome = "chr22") 

## -----------------------------------------------------------------------------
bdsManual = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions, bsSize = 9, cutoff.geneWiseFilter = 0)

## -----------------------------------------------------------------------------
bdsSimple = makeBindingSites(object = bds, bsSize = 9)

## -----------------------------------------------------------------------------
customBSFind <- function(object) {
    this.obj = pureClipGlobalFilter(object)
    this.obj = makeBindingSites(this.obj, bsSize = 9)
    this.obj = calculateSignalToFlankScore(this.obj)
    return(this.obj)
}
bdsSimple = customBSFind(bds)

## -----------------------------------------------------------------------------
noAnnotationBSFind <- function(object) {
    this.obj = pureClipGlobalFilter(object)
    this.obj = makeBindingSites(this.obj, bsSize = 9)
    this.obj = reproducibilityFilter(this.obj)
    this.obj = annotateWithScore(this.obj, getRanges(object))
    this.obj = calculateSignalToFlankScore(this.obj)
    return(this.obj)
}
bdsSimple = noAnnotationBSFind(bds)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="reproducibilityScatterPlot. Before reproducibility filter.", eval=FALSE----
# bds.before = makeBindingSites(bds, bsSize = 9)
# reproducibilityScatterPlot(bds.before)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="reproducibilityScatterPlot. After reproducibility filter.", eval=FALSE----
# bds.after = reproducibilityFilter(bds.before, minCrosslinks = 2)
# reproducibilityScatterPlot(bds.after)

## ----fig.retina = 1, dpi = this.dpi, fig.small=TRUE, eval=FALSE---------------
# set.seed(1234)
# bdsSub = bds[sample(seq_along(getRanges(bds)), 100, replace = FALSE)]
# 
# cov = coverageOverRanges(bdsSub, returnOptions = "merge_positions_keep_replicates")
# df = mcols(cov) %>%
#     as.data.frame() %>%
#     pivot_longer(everything())
# 
# ggplot(df, aes(x = name, y = log2(value+1), fill = name)) +
#     geom_violin() +
#     geom_boxplot(width = 0.1, fill = "white") +
#     scale_fill_brewer(palette = "Greys") +
#     theme_bw() +
#     theme(legend.position = "none") +
#     labs(x = "Samples", y = "#Crosslinks (log2)")

## ----fig.retina = 1, dpi = this.dpi, fig.small=TRUE, eval=FALSE---------------
# bdsMerge = collapseReplicates(bds)[1:100]
# covTotal = coverageOverRanges(bdsMerge, returnOptions = "merge_positions_keep_replicates")
# 
# covRep = coverageOverRanges(bds[1:100], returnOptions = "merge_positions_keep_replicates")
# 
# df = cbind.data.frame(mcols(covTotal), mcols(covRep)) %>%
#     mutate(rep1 = round(`1_WT`/ WT, digits = 2) * 100,
#            rep2 = round(`2_WT`/ WT, digits = 2) * 100,
#            rep3 = round(`3_WT`/ WT, digits = 2) * 100,
#            rep4 = round(`4_WT`/ WT, digits = 2) * 100) %>%
#     tibble::rowid_to_column("BsID") %>%
#     dplyr::select(BsID, rep1, rep2, rep3, rep4) %>%
#     pivot_longer(-BsID) %>%
#     group_by(BsID) %>%
#     arrange(desc(value), .by_group = TRUE) %>%
#     mutate(name = factor(name, levels = name)) %>%
#     group_by(name) %>%
#     arrange(desc(value), .by_group = TRUE) %>%
#     mutate(BsID = factor(BsID, levels = BsID))
# 
# 
# ggplot(df, aes(x = BsID, y = value, fill = name)) +
#     geom_col(position = "fill", width = 1) +
#     theme_bw() +
#     scale_fill_brewer(palette = "Set3") +
#     theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 7)) +
#     labs(x = "Binding site ID",
#          y = "Percentage",
#          fill = "Replicate"
#          ) +
#     scale_y_continuous(labels = scales::percent)

## ----eval=FALSE---------------------------------------------------------------
# sgn = getSignal(bds)
# export(sgn$signalPlus$`1_WT`, con = "./WT_1_plus.bw", format = "bigwig")
# export(sgn$signalMinus$`1_WT`, con = "./WT_1_minus.bw", format = "bigwig")

## ----eval=FALSE---------------------------------------------------------------
# bdsMerge = collapseReplicates(bds)
# sgn = getSignal(bdsMerge)
# export(sgn$signalPlus$WT, con = "./sgn_plus.bw", format = "bigwig")
# export(sgn$signalPlus$WT, con = "./sgn_minus.bw", format = "bigwig")

## -----------------------------------------------------------------------------
cov = clipCoverage(bdsOut, ranges.merge = TRUE, samples.merge = FALSE, positions.merge = FALSE)
cov

## ----eval=TRUE, echo=FALSE----------------------------------------------------
makeExampleDataSets <- function() {
    # load clip data
    files <- system.file("extdata", package="BindingSiteFinder")
    load(list.files(files, pattern = ".rda$", full.names = TRUE))
    # make binding sites
    bds = makeBindingSites(bds, bsSize = 5, quiet = TRUE)
    bds = assignToGenes(bds, anno.genes = gns, quiet = TRUE)
    # create artificial changes between binding sites
    bds = imputeBsDifferencesForTestdata(bds)
    
    # handle ranges
    bs.all = getRanges(bds)
    set.seed(1234)
    idx = sample(c(TRUE,FALSE), size = length(bs.all), replace = TRUE)       
    bs.wt = bs.all[idx]
    bs.ko = bs.all[!idx]
    
    # handle meta
    meta.all = getMeta(bds)
    meta.wt = meta.all[c(1:2),]
    meta.ko = meta.all[c(3:4),]
    meta.ko$id = 1:2
    
    # handle signal
    signal.all = getSignal(bds)
    signal.wt.p = signal.all$signalPlus[1:2]
    signal.wt.m = signal.all$signalMinus[1:2]
    signal.wt = list(signalPlus = signal.wt.p, signalMinus = signal.wt.m)
    
    signal.all = getSignal(bds)
    signal.ko.p = signal.all$signalPlus[3:4]
    signal.ko.m = signal.all$signalMinus[3:4]
    signal.ko = list(signalPlus = signal.ko.p, signalMinus = signal.ko.m)
    
    # set objects
    bds.wt = setRanges(bds, bs.wt)
    bds.wt = setMeta(bds.wt, meta.wt)
    bds.wt = setSignal(bds.wt, signal.wt)
    bds.wt = setName(bds.wt, "Example.WT")
    
    bds.ko = setRanges(bds, bs.ko)
    bds.ko = setMeta(bds.ko, meta.ko)
    bds.ko = setSignal(bds.ko, signal.ko)
    bds.ko = setName(bds.ko, "Example.KO")
    
    # return
    l = list(wt = bds.wt, ko = bds.ko)
    return(l)
}

## -----------------------------------------------------------------------------
# make artifical data sets
myDataSets = makeExampleDataSets()

bds.wt = myDataSets$wt
bds.ko = myDataSets$ko

bds.wt
bds.ko

## -----------------------------------------------------------------------------
bds.comb = bds.wt + bds.ko
getRanges(bds.comb)

## ----warning=FALSE, message=FALSE---------------------------------------------
bds.diff = calculateBsBackground(bds.comb, anno.genes = gns)
getRanges(bds.diff)

## -----------------------------------------------------------------------------
bds.diff = filterBsBackground(bds.diff)

## -----------------------------------------------------------------------------
bds.diff = calculateBsFoldChange(bds.diff)
getRanges(bds.diff)

## ----fig.retina = 1, dpi = this.dpi, fig.cap="plotBsMA. MA plot for binding site changes.", fig.small=TRUE----
plotBsMA(bds.diff, what = "bs")

## -----------------------------------------------------------------------------
bds.diff = assignToTranscriptRegions(bds.diff, anno.transcriptRegionList = regions)
geneRegulationPlot(bds.diff, plot.geneID = "ENSG00000180957.18", anno.genes = gns)

## ----eval=FALSE---------------------------------------------------------------
# ############################
# # Construct WT binding sites
# ############################
# # Locate peak calling result
# peaks.wt = "./myFolder/wt/pureclip.bed"
# peaks.wt = import(con = peaks.wt, format = "BED", extraCols=c("additionalScores" = "character"))
# peaks.wt = keepStandardChromosomes(peaks.wt, pruning.mode = "coarse")
# # Locate bigwig files
# clipFiles = "./myFolder/wt/bigwig/"
# clipFiles = list.files(clipFiles, pattern = ".bw$", full.names = TRUE)
# clipFiles = clipFiles[grepl("WT", clipFiles)]
# clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
# clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# # Organize clip data in dataframe
# colData = data.frame(
#     name = "Example.WT", id = c(1:2),
#     condition = factor(c("WT", "WT"), levels = c("WT")),
#     clPlus = clipFilesP, clMinus = clipFilesM)
# # Construct BSFDataSet object
# bdsWT.initial = BSFDataSetFromBigWig(ranges = peaksInitial, meta = colData)
# # Define binding sites
# bdsWT = BSFind(bdsWT.initial, anno.genes = gns, anno.transcriptRegionList = trl)

## ----eval=FALSE---------------------------------------------------------------
# ############################
# # Construct KO binding sites
# ############################
# # Locate peak calling result
# peaks.ko = "./myFolder/ko/pureclip.bed"
# peaks.ko = import(con = peaks.ko, format = "BED", extraCols=c("additionalScores" = "character"))
# peaks.ko = keepStandardChromosomes(peaks.ko, pruning.mode = "coarse")
# # Locate bigwig files
# clipFiles = "./myFolder/ko/bigwig/"
# clipFiles = list.files(clipFiles, pattern = ".bw$", full.names = TRUE)
# clipFiles = clipFiles[grepl("KO", clipFiles)]
# clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
# clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# # Organize clip data in dataframe
# colData = data.frame(
#     name = "Example.KO", id = c(1:2),
#     condition = factor(c("KO", "KO"), levels = c("KO")),
#     clPlus = clipFilesP, clMinus = clipFilesM)
# # Construct BSFDataSet object
# bdsKO.initial = BSFDataSetFromBigWig(ranges = peaksInitial, meta = colData)
# # Define binding sites
# bdsKO = BSFind(bdsKO.initial, anno.genes = gns, anno.transcriptRegionList = trl)

## ----eval=FALSE---------------------------------------------------------------
# # Locate bigwig files - KO
# clipFilesKO = "./myFolder/ko/bigwig/"
# clipFilesKO = list.files(clipFilesKO, pattern = ".bw$", full.names = TRUE)
# clipFilesKO = clipFilesKO[grepl("KO", clipFilesKO)]
# # Locate bigwig files - WT
# clipFilesWT = "./myFolder/wt/bigwig/"
# clipFilesWT = list.files(clipFilesWT, pattern = ".bw$", full.names = TRUE)
# clipFilesWT = clipFilesWT[grepl("WT", clipFilesWT)]
# # Merge both conditions
# clipFiles = c(clipFilesWT, clipFilesKO)
# # Split by strand
# clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
# clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# # Organize clip data in dataframe
# colData = data.frame(
#     name = "Example.KO", id = c(1:4),
#     condition = factor(c("WT", "WT", "KO", "KO"), levels = c("WT", "KO")),
#     clPlus = clipFilesP, clMinus = clipFilesM)
# # Construct BSFDataSet object from pre-defined binding sites
# # -> myBindingSites must be a GRanges object
# bds.comb = BSFDataSetFromBigWig(ranges = myBindingSites, meta = colData)

## ----eval=FALSE---------------------------------------------------------------
# bds.complex = combineBSF(list(ctrl = bds.ctrl, wt = bds.wt, ko = bds.ko))

## ----eval=FALSE---------------------------------------------------------------
# # extract binding site ranges from complex merge
# bindingSites.complex = getRanges(bds.complex)
# # Locate bigwig files - KO
# clipFilesKO = "./myFolder/ko/bigwig/"
# clipFilesKO = list.files(clipFilesKO, pattern = ".bw$", full.names = TRUE)
# clipFilesKO = clipFilesKO[grepl("KO", clipFilesKO)]
# # Locate bigwig files - WT
# clipFilesWT = "./myFolder/wt/bigwig/"
# clipFilesWT = list.files(clipFilesWT, pattern = ".bw$", full.names = TRUE)
# clipFilesWT = clipFilesWT[grepl("WT", clipFilesWT)]
# # Merge both conditions
# clipFiles = c(clipFilesWT, clipFilesKO)
# # Split by strand
# clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
# clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# # Organize clip data in dataframe
# colData = data.frame(
#     name = "Example.KO", id = c(1:2),
#     condition = factor(c("KO", "KO"), levels = c("KO")),
#     clPlus = clipFilesP, clMinus = clipFilesM)
# # Construct BSFDataSet object from pre-defined binding sites
# bds.comb = BSFDataSetFromBigWig(ranges = bindingSites.complex, meta = colData)

## -----------------------------------------------------------------------------
sessionInfo()

