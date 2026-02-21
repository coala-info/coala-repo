# Code example from 'epigraHMM' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE)

## ----introduction_workflow----------------------------------------------------
library(GenomicRanges)
library(epigraHMM)
library(SummarizedExperiment)

# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN'),replicate = c(1,2))

# Creating epigraHMM object
object <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                  colData = colData,
                                  genome = 'rn4',
                                  windowSize = 1000,
                                  gapTrack = TRUE)

# Creating normalizing offsets
object <- normalizeCounts(object = object,
                          control = controlEM())

# Initializing epigraHMM
object <- initializer(object = object,
                      control = controlEM())

# Running epigraHMM for consensus peak detection 
object <- epigraHMM(object = object,
                    control = controlEM(),
                    type = 'consensus')

# Calling peaks with FDR control of 0.05
peaks <- callPeaks(object = object,
                   control = controlEM(),
                   method = 0.05)

## ----data_input_countmatrixinput----------------------------------------------
countData <- list('counts' = matrix(rpois(4e5,10),ncol = 4),
                  'controls' = matrix(rpois(4e5,5),ncol = 4))

colData <- data.frame(condition = c('A','A','B','B'),
                      replicate = c(1,2,1,2))

rowRanges <- GRanges('chrA',IRanges(start = seq(1,by = 500, length.out = 1e5),
                                    width = 500))

object_matrix <- epigraHMMDataSetFromMatrix(countData = countData,
                                            colData = colData,
                                            rowRanges = rowRanges)

object_matrix

## ----data_input_baminput------------------------------------------------------
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K4me3-SHR-male-bio2-tech1.bam",
                          "lv-H3K4me3-SHR-male-bio3-tech1.bam"))

colData <- data.frame(condition = c('SHR','SHR'),
                      replicate = c(1,2))

# Creating epigraHMM object
object_bam <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                      colData = colData,
                                      genome = 'rn4',
                                      windowSize = 250,
                                      gapTrack = TRUE)

object_bam

## ----data_norm_offset---------------------------------------------------------
# Normalizing counts
object_normExample <- object_bam
object_normExample <- normalizeCounts(object_normExample,control = controlEM())

normCts <- as.matrix(assay(object_normExample)/
                       exp(assay(object_normExample,'offsets')))

# Summary of raw counts
summary(assay(object_normExample))
colSums(assay(object_normExample))/1e5

# Summary of normalized counts
summary(normCts)
colSums(normCts)/1e5

## ----gcnorm,fig.show='hide',results='hide'------------------------------------
library(gcapc)
library(BSgenome.Rnorvegicus.UCSC.rn4)

# Toy example of utilization of gcapc for GC-content normalization with model offsets
# See ?gcapc::refineSites for best practices

# Below, subset object_bam simply to illustrate the use of `gcapc::refineSites`
# with epigraHMM
object_gcExample <- object_bam[2e4:5e4,]

gcnorm <- gcapc::refineSites(counts = assay(object_gcExample),
                             sites = rowRanges(object_gcExample),
                             gcrange = c(0,1),
                             genome = 'rn4')

# gcapc::refineSites outputs counts/2^gce
gcnorm_offsets <- log2((assay(object_gcExample) + 1) / (gcnorm + 1))

# Adding offsets to epigraHMM object
object_gcExample <- addOffsets(object = object_gcExample,
                               offsets = gcnorm_offsets)

## ----data_input_controls------------------------------------------------------
# Creating input for epigraHMM
bamFiles <- list('counts' = system.file(package="chromstaRData",
                                        "extdata","euratrans",
                                        "lv-H4K20me1-BN-male-bio1-tech1.bam"),
                 'controls' = system.file(package="chromstaRData",
                                          "extdata","euratrans",
                                          "lv-input-BN-male-bio1-tech1.bam"))

colData <- data.frame(condition = 'BN',replicate = 1)

# Creating epigraHMM object
object_bam <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                      colData = colData,
                                      genome = 'rn4',
                                      windowSize = 1000,
                                      gapTrack = TRUE)

object_bam

## ----data_peak_consensus,message = FALSE--------------------------------------
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN'),
                      replicate = c(1,2))

# Creating epigraHMM object
object_consensus <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                            colData = colData,
                                            genome = 'rn4',
                                            windowSize = 1000,
                                            gapTrack = TRUE)

# Normalizing counts
object_consensus <- normalizeCounts(object_consensus,
                                    control = controlEM())

# Initializing epigraHMM
object_consensus <- initializer(object_consensus,controlEM())

# Differential peak calling
object_consensus <- epigraHMM(object = object_consensus,
                              control = controlEM(),
                              type = 'consensus',
                              dist = 'zinb')

## ----data_peak_differential,message = FALSE-----------------------------------
# Creating input for epigraHMM
bamFiles <- system.file(package="chromstaRData","extdata","euratrans",
                        c("lv-H3K27me3-BN-male-bio2-tech1.bam",
                          "lv-H3K27me3-BN-male-bio2-tech2.bam",
                          "lv-H3K27me3-SHR-male-bio2-tech1.bam",
                          "lv-H3K27me3-SHR-male-bio2-tech2.bam"))

colData <- data.frame(condition = c('BN','BN','SHR','SHR'),
                      replicate = c(1,2,1,2))

# Creating epigraHMM object
object_differential <- epigraHMMDataSetFromBam(bamFiles = bamFiles,
                                               colData = colData,
                                               genome = 'rn4',
                                               windowSize = 1000,
                                               gapTrack = TRUE)

# Normalizing counts
object_differential <- normalizeCounts(object_differential,
                                       control = controlEM())

# Initializing epigraHMM
object_differential <- initializer(object_differential,controlEM())

# Differential peak calling
object_differential <- epigraHMM(object = object_differential,
                                 control = controlEM(),
                                 type = 'differential')

## ----peaks_consensus----------------------------------------------------------
peaks_consensus <- callPeaks(object = object_consensus)
peaks_consensus

## ----peaks_differential-------------------------------------------------------
peaks_differential <- callPeaks(object = object_differential)
peaks_differential

## ----viz_anno-----------------------------------------------------------------
library(GenomicRanges)
library(rtracklayer)
library(Seqinfo)

session <- browserSession()
genome(session) <- 'rn4'
refSeq <- getTable(ucscTableQuery(session, table = "refGene"))

annotation <- makeGRangesFromDataFrame(refSeq,
                                       starts.in.df.are.0based = TRUE,
                                       seqnames.field = 'chrom',
                                       start.field = 'txStart',
                                       end.field = 'txEnd',
                                       strand.field = 'strand',
                                       keep.extra.columns = TRUE)

## ----viz_consensus------------------------------------------------------------
plotCounts(object = object_consensus,
           ranges = GRanges('chr12',IRanges(19500000,20000000)),
           peaks = peaks_consensus,
           annotation = annotation)

## ----viz_differential---------------------------------------------------------
plotCounts(object = object_differential,
           ranges = GRanges('chr12',IRanges(19500000,20100000)),
           peaks = peaks_differential,
           annotation = annotation)

## ----viz_heatmap1-------------------------------------------------------------
# Selecting target differential peak
pattern_peak <- peaks_differential[peaks_differential$name == 'peak4']

pattern_peak

plotPatterns(object = object_differential,
             ranges = pattern_peak,
             peaks = peaks_differential)

## ----viz_heatmap2-------------------------------------------------------------
# Selecting target differential peak
pattern_peak <- peaks_differential[peaks_differential$name == 'peak3']

pattern_peak

plotPatterns(object = object_differential,
             ranges = pattern_peak,
             peaks = peaks_differential)

## ----misc_patterns------------------------------------------------------------
# Getting object information
info(object_differential)

## ----misc_probs---------------------------------------------------------------
# Getting posterior probabilties
callPatterns(object = object_differential,peaks = peaks_differential,type = 'all')

## ----misc_max-----------------------------------------------------------------
# Getting most likely differential enrichment
callPatterns(object = object_differential,peaks = peaks_differential,type = 'max')

## ----misc_pruning,message = TRUE----------------------------------------------
data('helas3')

control <- controlEM(pruningThreshold = 0.05,quietPruning = FALSE)

object <- normalizeCounts(object = helas3,control)

object <- initializer(object = object,control)

object <- epigraHMM(object = object,control = control,type = 'differential')

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

