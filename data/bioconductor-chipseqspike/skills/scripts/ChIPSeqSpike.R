# Code example from 'ChIPSeqSpike' vignette. See references/ for full tutorial.

## ----message = FALSE, warning = FALSE--------------------------------------
library("ChIPSeqSpike")

## Preparing testing data
info_file_csv <- system.file("extdata/info.csv", package="ChIPSeqSpike")
bam_path <- system.file("extdata/bam_files", package="ChIPSeqSpike")
bigwig_path <- system.file("extdata/bigwig_files", package="ChIPSeqSpike")
gff_vec <- system.file("extdata/test_coord.gff", package="ChIPSeqSpike")
genome_name <- "hg19"
output_folder <- "test_chipseqspike"
bigwig_files <- system.file("extdata/bigwig_files", 
                            c("H3K79me2_0-filtered.bw",
                              "H3K79me2_100-filtered.bw",
                              "H3K79me2_50-filtered.bw",
                              "input_0-filtered.bw",
                              "input_100-filtered.bw",
                              "input_50-filtered.bw"), package="ChIPSeqSpike")

## Copying example files
dir.create("./test_chipseqspike")
mock <- file.copy(bigwig_files, "test_chipseqspike")

## Performing spike-in normalization
if (.Platform$OS.type != "windows") {
    csds_test <- spikePipe(info_file_csv, bam_path, bigwig_path, gff_vec, 
                           genome_name, outputFolder = output_folder)
}

## ----message = FALSE, warning = FALSE--------------------------------------
info_file <- read.csv(info_file_csv)
head(info_file)

## ----message = FALSE, warning = FALSE--------------------------------------
csds_test <- spikeDataset(info_file_csv, bam_path, bigwig_path)
is(csds_test)

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_testBoost <- spikeDataset(info_file_csv, bam_path, bigwig_path, 
    boost = TRUE)
    is(csds_testBoost)
}

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    getLoadedData(csds_testBoost[[1]])
}

## ----message = FALSE, warning = FALSE--------------------------------------
csds_test <- estimateScalingFactors(csds_test, verbose = FALSE)

## ----message = FALSE, warning = FALSE--------------------------------------
## Scores on testing sub-samples
spikeSummary(csds_test)

##Scores on whole dataset
data(result_estimateScalingFactors)
spikeSummary(csds)

## ----message = FALSE-------------------------------------------------------
getRatio(csds_test)

## Result on the whole dataset
data(ratio)
ratio

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_test <- scaling(csds_test, outputFolder = output_folder)
}

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_test <- inputSubtraction(csds_test)
}

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_test <- scaling(csds_test, reverse = TRUE)
}

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_test <- scaling(csds_test, type = "exo")
}

## ----message = FALSE, warning = FALSE--------------------------------------
if (.Platform$OS.type != "windows") {
    csds_test <- extractBinding(csds_test, gff_vec, genome_name)
}

## ----message = FALSE, warning = FALSE, fig.cap="Spiked experiment upon different percentages concentrations of inhibitor treatment \\label{figure1}", fig.height = 6----
data(result_extractBinding)
plotProfile(csds, legend = TRUE)

## ----message = FALSE, warning = FALSE, fig.cap="Same as figure 1 including unspiked data \\label{figure2}", fig.height = 7----
plotProfile(csds, legend = TRUE, notScaled = TRUE)

## ----message = FALSE, warning = FALSE--------------------------------------
plotTransform(csds, legend = TRUE, separateWindows = TRUE)

## ----message = FALSE, warning = FALSE, fig.cap="kmeans clustering of spiked data \\label{figure3}", fig.height = 5----
plotHeatmaps(csds, nb_of_groups = 2, clustering_method = "kmeans")

## ----message = FALSE, warning = FALSE, fig.cap="Complete representation of the whole procedure using boxplots (without outliers)\\label{figure5}", fig.height = 6----
par(cex.axis=0.5)
boxplotSpike(csds, rawFile = TRUE, rpmFile = TRUE, bgsubFile = TRUE, 
revFile = TRUE, spiked = TRUE, outline = FALSE)

## ----message = FALSE, warning = FALSE, fig.cap="Spiked data with mean and standard deviation - Each point represents a mean binding value on a given gene \\label{figure6}", fig.height = 6----
boxplotSpike(csds, outline = FALSE, violin=TRUE, mean_with_sd = TRUE,
 jitter = TRUE)

## ----message = FALSE, warning = FALSE, fig.cap="Correlation table of spiked data with circle (left) or numbers (right)\\label{figure7}", fig.height = 6, fig.width=10----
par(mfrow=c(1,2))
plotCor(csds, heatscatterplot = FALSE)
plotCor(csds, heatscatterplot = FALSE, method_corrplot = "number")

## ----message = FALSE, warning =  FALSE, fig.cap="Heatscatter of spiked data after log transformation \\label{figure8}", fig.height=6----
plotCor(csds, method_scale = "log")

## ----message = FALSE, warning = FALSE, include = FALSE---------------------
unlink("test_chipseqspike/", recursive = TRUE)

## --------------------------------------------------------------------------
sessionInfo(package="ChIPSeqSpike")

