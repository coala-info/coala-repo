# Code example from 'using_epistack' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  cache = FALSE,
  fig.width = 4, fig.height = 5, fig.show = "hold",
  global.par = FALSE
)

## ----epidata, message=FALSE---------------------------------------------------
library(GenomicRanges)
library(SummarizedExperiment)
library(epistack)

data("stackepi")
stackepi

## ----epistack1----------------------------------------------------------------
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1)
)

## ----bining-------------------------------------------------------------------
stackepi <- addBins(stackepi, nbins = 5)

plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1)
)

## ----colours------------------------------------------------------------------
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1),
  tints = "dodgerblue",
  bin_palette = rainbow
)

## ----par, collapse=TRUE-------------------------------------------------------
plotEpistack(
  stackepi,
  assay = "DNAme", metric_col = "exp",
  ylim = c(0, 1), zlim = c(0, 1),
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  titles = "DNA methylation", legends = "%mCpG",
  metric_title = "Expression", metric_label = "log10(TPM+1)",
  metric_transfunc = function(x) log10(x+1),
  cex = 0.4, cex.main = 0.6
)


## ----plotAvgerageProfile, fig.small = TRUE------------------------------------
plotAverageProfile(
  stackepi,
  ylim = c(0, 1),
  assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
)


## ----plotStackProfile, fig.small = TRUE---------------------------------------
plotStackProfile(
  stackepi,
  assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"),
  palette = hcl.colors,
  zlim = c(0, 1)
)

## ----customPanels-------------------------------------------------------------
layout(matrix(1:3, ncol = 1), heights = c(1.5, 3, 0.5))
old_par <- par(mar = c(2.5, 4, 0.6, 0.6))

plotAverageProfile(
  stackepi, assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"), ylim = c(0, 1),
)

plotStackProfile(
  stackepi, assay = "DNAme",
  x_labels = c("-2.5kb", "TSS", "+2.5kb"), zlim = c(0, 1),
  palette = hcl.colors
)

plotStackProfileLegend(
  zlim = c(0, 1),
  palette = hcl.colors
)

par(old_par)
layout(1)


## ----examplepath--------------------------------------------------------------
path_reads <- c(
    rep1 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/H3K27ac_rep1_filtered_ucsc_chr6.bed",
    rep2 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/H3K27ac_rep2_filtered_ucsc_chr6.bed",
    input = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/ES_input_filtered_ucsc_chr6.bed"
)

path_peaks <- c(
    peak1 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/Rep1_peaks_ucsc_chr6.bed",
    peak2 = "https://raw.githubusercontent.com/Bioconductor/CSAMA2016/master/lab-5-chipseq/EpigeneticsCSAMA/inst/bedfiles/Rep2_peaks_ucsc_chr6.bed"
)

## ----peak_loading, message=FALSE----------------------------------------------
library(rtracklayer)
peaks <- lapply(path_peaks, import)

## ----peak_merge, message=FALSE------------------------------------------------
merged_peaks <- GenomicRanges::union(peaks[[1]], peaks[[2]])

scores_rep1 <- double(length(merged_peaks))
scores_rep1[findOverlaps(peaks[[1]], merged_peaks, select = "first")] <- peaks[[1]]$score

scores_rep2 <- double(length(merged_peaks))
scores_rep2[findOverlaps(peaks[[2]], merged_peaks, select = "first")] <- peaks[[2]]$score

peak_type <- ifelse(
    scores_rep1 != 0 & scores_rep2 != 0, "Both", ifelse(
        scores_rep1 != 0, "Rep1 only", "Rep2 only"
    )
)

mcols(merged_peaks) <- DataFrame(scores_rep1, scores_rep2, peak_type)
merged_peaks$mean_scores <- apply((mcols(merged_peaks)[, c("scores_rep1", "scores_rep2")]), 1, mean)
merged_peaks <- merged_peaks[order(merged_peaks$mean_scores, decreasing = TRUE), ]
rm(scores_rep1, scores_rep2, peak_type)

merged_peaks

## ----read_loading-------------------------------------------------------------
reads <- lapply(path_reads, import)

## ----coverage_matrices, message=FALSE-----------------------------------------
library(EnrichedHeatmap)

coverage_matrices <- lapply(
    reads,
    function(x) {
        normalizeToMatrix(
            x,
            resize(merged_peaks, width = 1, fix = "center"),
            extend = 5000, w = 250, 
            mean_mode = "coverage"
        )
    }
)

xlabs <- c("-5kb", "peak center", "+5kb")

## ----ready_to_plot------------------------------------------------------------
merged_peaks <- SummarizedExperiment(
    rowRanges = merged_peaks,
    assays = coverage_matrices
)

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
  fig.width=6, fig.height=5
)

## ----peak_plot----------------------------------------------------------------
plotEpistack(
    merged_peaks,
    assays = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"), 
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4), 
    metric_col = "mean_scores", metric_title = "Peak score",
    metric_label = "score"
)

## ----peak_plot_bin------------------------------------------------------------

rowRanges(merged_peaks)$bin <- rowRanges(merged_peaks)$peak_type

plotEpistack(
    merged_peaks,
    assays = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"), 
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4), 
    metric_col = "mean_scores", metric_title = "Peak score", metric_label = "score",
    bin_palette = colorRampPalette(c("darkorchid1", "dodgerblue", "firebrick1")),
    npix_height = 300
)


## ----peak_plot_bin2-----------------------------------------------------------
merged_peaks <- merged_peaks[order(
  rowRanges(merged_peaks)$bin, rowRanges(merged_peaks)$mean_scores,
  decreasing = c(FALSE, TRUE), method = "radix"
), ]

plotEpistack(
    merged_peaks,
    patterns = c("rep1", "rep2", "input"),
    tints = c("dodgerblue", "firebrick1", "grey"), 
    titles = c("Rep1", "Rep2" , "Input"),
    x_labels = xlabs,
    zlim = c(0, 4), ylim = c(0, 4), 
    metric_col = "mean_scores", metric_title = "Peak score", metric_label = "score",
    bin_palette = colorRampPalette(c("darkorchid1", "dodgerblue", "firebrick1")),
    npix_height = 300
)


## ----example2_tss-------------------------------------------------------------
load(
    system.file("extdata", "chr21_test_data.RData",
                package = "EnrichedHeatmap"),
    verbose = TRUE
)

tss <- promoters(genes, upstream = 0, downstream = 1)
tss$gene_id <- names(tss)

tss

## ----expression_data----------------------------------------------------------
expr <- data.frame(
    gene_id = names(rpkm),
    expr = rpkm
)

epidata <- addMetricAndArrangeGRanges(
    tss, expr,
    gr_key = "gene_id",
    order_key = "gene_id", order_value = "expr"
)

epidata

## ----adding_bins--------------------------------------------------------------
epidata <- addBins(epidata, nbins = 5)
epidata

## ----signal_extraction--------------------------------------------------------
methstack <- normalizeToMatrix(
    meth, epidata, value_column = "meth",
    extend = 5000, w = 250, mean_mode = "absolute"
)

h3k4me3stack <- normalizeToMatrix(
    H3K4me3, epidata, value_column = "coverage",
    extend = 5000, w = 250, mean_mode = "coverage"
)

epidata <- SummarizedExperiment(
    rowRanges = epidata,
    assays = list(DNAme = methstack, H3K4me3 = h3k4me3stack)
)

## ----example2_plotting--------------------------------------------------------
plotEpistack(
    epidata,
    tints = c("dodgerblue", "orange"),
    zlim = list(c(0, 1), c(0, 25)), ylim = list(c(0, 1), c(0, 50)),
    x_labels = c("-5kb", "TSS", "+5kb"),
    legends = c("%mCpG", "Coverage"),
    metric_col = "expr", metric_title = "Gene expression",
    metric_label = "log10(RPKM+1)",
    metric_transfunc = function(x) log10(x + 1),
    npix_height = 300
)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

