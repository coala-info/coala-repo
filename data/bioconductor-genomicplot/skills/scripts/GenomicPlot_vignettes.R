# Code example from 'GenomicPlot_vignettes' vignette. See references/ for full tutorial.

## ----install1,  eval = FALSE--------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GenomicPlot")

## ----install2,  eval = FALSE--------------------------------------------------
# if (!require("remotes", quietly = TRUE))
#    install.packages("remotes")
# remotes::install_github("shuye2009/GenomicPlot",
#                         build_manual = TRUE,
#                         build_vignettes = TRUE)

## ----global code, eval = TRUE-------------------------------------------------
suppressPackageStartupMessages(library(GenomicPlot, quietly = TRUE))

txdb <- AnnotationDbi::loadDb(system.file("extdata", "txdb.sql", 
                                          package = "GenomicPlot"))


## ----metagene code, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7), fig.ncol=1, fig.sep="\n\n"----

data(gf5_meta)

queryfiles <- system.file("extdata", "treat_chr19.bam", 
                          package = "GenomicPlot")
names(queryfiles) <- "clip_bam"
inputfiles <- system.file("extdata", "input_chr19.bam", 
                          package = "GenomicPlot")
names(inputfiles) <- "clip_input"

bamimportParams <- setImportParams(
  offset = -1, fix_width = 0, fix_point = "start", norm = TRUE,
  useScore = FALSE, outRle = TRUE, useSizeFactor = FALSE, genome = "hg19"
)

plot_5parts_metagene(
  queryFiles = queryfiles,
  gFeatures_list = list("metagene" = gf5_meta),
  inputFiles = inputfiles,
  scale = FALSE,
  verbose = FALSE,
  transform = NA,
  smooth = TRUE,
  stranded = TRUE,
  outPrefix = NULL,
  importParams = bamimportParams,
  heatmap = TRUE,
  rmOutlier = 0,
  nc = 2
)

## ----region code, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7)----
centerfiles <- system.file("extdata", "test_chip_peak_chr19.narrowPeak", 
                           package = "GenomicPlot")
names(centerfiles) <- c("NarrowPeak")
queryfiles <- c(
  system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(queryfiles) <- c("chip_bam")
inputfiles <- c(
  system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot")
)
names(inputfiles) <- c("chip_input")

chipimportParams <- setImportParams(
  offset = 0, fix_width = 150, fix_point = "start", norm = TRUE,
  useScore = FALSE, outRle = TRUE, useSizeFactor = FALSE, genome = "hg19"
)

plot_region(
  queryFiles = queryfiles,
  centerFiles = centerfiles,
  inputFiles = inputfiles,
  nbins = 100,
  heatmap = TRUE,
  scale = FALSE,
  regionName = "narrowPeak",
  importParams = chipimportParams,
  verbose = FALSE,
  fiveP = -500,
  threeP = 500,
  smooth = TRUE,
  transform = NA,
  stranded = TRUE,
  outPrefix = NULL,
  Ylab = "Coverage/base/peak",
  rmOutlier = 0,
  nc = 2
)

## ----locus code, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7)----
centerfiles <- c(
  system.file("extdata", "test_clip_peak_chr19.bed", package = "GenomicPlot"),
  system.file("extdata", "test_chip_peak_chr19.bed", package = "GenomicPlot")
)
names(centerfiles) <- c("iCLIPPeak", "SummitPeak")
queryfiles <- c(
  system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(queryfiles) <- c("chip_bam")
inputfiles <- c(
  system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot")
)
names(inputfiles) <- c("chip_input")

plot_locus(
  queryFiles = queryfiles,
  centerFiles = centerfiles,
  ext = c(-500, 500),
  hl = c(-100, 100),
  shade = TRUE,
  smooth = TRUE,
  importParams = chipimportParams,
  binSize = 10,
  refPoint = "center",
  Xlab = "Center",
  inputFiles = inputfiles,
  stranded = TRUE,
  scale = FALSE,
  outPrefix = NULL,
  verbose = FALSE,
  transform = NA,
  rmOutlier = 0,
  Ylab = "Coverage/base/peak",
  statsMethod = "wilcox.test",
  heatmap = TRUE,
  nc = 2
)

## ----annotation code, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7)----
gtffile <- system.file("extdata", "gencode.v19.annotation_chr19.gtf", 
                       package = "GenomicPlot")

centerfile <- system.file("extdata", "test_chip_peak_chr19.bed", 
                          package = "GenomicPlot")
names(centerfile) <- c("SummitPeak")

bedimportParams <- setImportParams(
  offset = 0, fix_width = 100, fix_point = "center", norm = FALSE,
  useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE, genome = "hg19"
)

pa <- plot_peak_annotation(
  peakFile = centerfile,
  gtfFile = gtffile,
  importParams = bedimportParams,
  fiveP = -2000,
  dsTSS = 300,
  threeP = 1000,
  simple = FALSE,
  verbose = FALSE,
  outPrefix = NULL
)

## ----bam correlation, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7)----
bamQueryFiles <- c(
   system.file("extdata", "chip_input_chr19.bam", package = "GenomicPlot"),
   system.file("extdata", "chip_treat_chr19.bam", package = "GenomicPlot")
)
names(bamQueryFiles) <- c("chip_input", "chip_treat")

bamImportParams <- setImportParams(
   offset = 0, fix_width = 150, fix_point = "start", norm = FALSE,
   useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE, 
   genome = "hg19"
)

plot_bam_correlation(
   bamFiles = bamQueryFiles, binSize = 100000, outPrefix = NULL,
   importParams = bamImportParams, nc = 2, verbose = FALSE
)

## ----bed overlap, eval = TRUE, fig.show = 'hold', fig.keep = 'all', fig.align = 'center', fig.dim = c(7,7)----
queryFiles <- c(
   system.file("extdata", "test_chip_peak_chr19.narrowPeak", 
             package = "GenomicPlot"),
   system.file("extdata", "test_chip_peak_chr19.bed", 
             package = "GenomicPlot"),
   system.file("extdata", "test_clip_peak_chr19.bed", 
             package = "GenomicPlot")
)
names(queryFiles) <- c("narrowPeak", "summitPeak", "clipPeak")

bedimportParams <- setImportParams(
   offset = 0, fix_width = 100, fix_point = "center", norm = FALSE,
   useScore = FALSE, outRle = FALSE, useSizeFactor = FALSE, genome = "hg19"
)

plot_overlap_bed(
   bedList = queryFiles, importParams = bedimportParams, pairOnly = FALSE,
   stranded = FALSE, outPrefix = NULL
)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

