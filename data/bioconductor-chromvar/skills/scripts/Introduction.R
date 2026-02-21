# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----message = FALSE, warning = FALSE-----------------------------------------
library(chromVAR)
library(motifmatchr)
library(Matrix)
library(SummarizedExperiment)
library(BiocParallel)
set.seed(2017)

## -----------------------------------------------------------------------------
register(MulticoreParam(8))

## -----------------------------------------------------------------------------
register(MulticoreParam(8, progressbar = TRUE))

## -----------------------------------------------------------------------------
register(SnowParam(workers = 1, type = "SOCK"))

## -----------------------------------------------------------------------------
register(SerialParam())

## -----------------------------------------------------------------------------
peakfile <- system.file("extdata/test_bed.txt", package = "chromVAR")
peaks <- getPeaks(peakfile, sort_peaks = TRUE)

## -----------------------------------------------------------------------------
bamfile <- system.file("extdata/test_RG.bam", package = "chromVAR")
fragment_counts <- getCounts(bamfile, 
                             peaks, 
                             paired =  TRUE, 
                             by_rg = TRUE, 
                             format = "bam", 
                             colData = DataFrame(celltype = "GM"))

## -----------------------------------------------------------------------------
data(example_counts, package = "chromVAR")
head(example_counts)

## ----message = FALSE----------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)
example_counts <- addGCBias(example_counts, 
                            genome = BSgenome.Hsapiens.UCSC.hg19)
head(rowData(example_counts))

## -----------------------------------------------------------------------------
#find indices of samples to keep
counts_filtered <- filterSamples(example_counts, min_depth = 1500, 
                                 min_in_peaks = 0.15, shiny = FALSE)

## ----filter_plot, fig.width = 6, fig.height = 6-------------------------------
#find indices of samples to keep
filtering_plot <- filterSamplesPlot(example_counts, min_depth = 1500, 
                                    min_in_peaks = 0.15, use_plotly = FALSE)
filtering_plot

## -----------------------------------------------------------------------------
ix <- filterSamples(example_counts, ix_return = TRUE, shiny = FALSE)

## -----------------------------------------------------------------------------
counts_filtered <- filterPeaks(counts_filtered, non_overlapping = TRUE)

## -----------------------------------------------------------------------------
motifs <- getJasparMotifs()

## -----------------------------------------------------------------------------
yeast_motifs <- getJasparMotifs(species = "Saccharomyces cerevisiae")

## -----------------------------------------------------------------------------
library(motifmatchr)
motif_ix <- matchMotifs(motifs, counts_filtered, 
                        genome = BSgenome.Hsapiens.UCSC.hg19)

## -----------------------------------------------------------------------------
kmer_ix <- matchKmers(6, counts_filtered, 
                      genome = BSgenome.Hsapiens.UCSC.hg19)

## -----------------------------------------------------------------------------
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix)

## -----------------------------------------------------------------------------
bg <- getBackgroundPeaks(object = counts_filtered)

## -----------------------------------------------------------------------------
dev <- computeDeviations(object = counts_filtered, annotations = motif_ix,
                         background_peaks = bg)

## ----variability, fig.width = 6, fig.height = 6-------------------------------
variability <- computeVariability(dev)

plotVariability(variability, use_plotly = FALSE) 

## -----------------------------------------------------------------------------
tsne_results <- deviationsTsne(dev, threshold = 1.5, perplexity = 10)

## -----------------------------------------------------------------------------
tsne_plots <- plotDeviationsTsne(dev, tsne_results, 
                                 annotation_name = "TEAD3", 
                                   sample_column = "Cell_Type", 
                                 shiny = FALSE)
tsne_plots[[1]]
tsne_plots[[2]]

## -----------------------------------------------------------------------------
Sys.Date()

## -----------------------------------------------------------------------------
sessionInfo()

