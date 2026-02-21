# Code example from 'scruff' vignette. See references/ for full tutorial.

## ----echo = FALSE, results = 'hide', warning = FALSE, message = FALSE---------
suppressPackageStartupMessages(library(BiocStyle))

## ----load_files1--------------------------------------------------------------
# Run scruff on example dataset
# NOTE: Requires Rsubread index and TxDb objects for the reference genome.
# For generation of these files, please refer to the Stepwise Tutorial.

library(scruff)
library(patchwork)

# Get the paths to example FASTQ, FASTA, and GTF files.
# Please note that because the following files are included in
# scruff R package, we use system.file() function to extract the paths
# to these files. If the user is running scruff on real data, the
# paths to the input FASTQ, FASTA, and GTF files should be provided,
# and there is no need to call system.file() function. For example,
# v1h1R1 <- "/PATH/TO/vandenBrink_1h1_L001_R1_001.fastq.gz"
# fasta <- "/Path/TO/GRCm38_MT.fa"
v1h1R1 <- system.file("extdata",
    "vandenBrink_1h1_L001_R1_001.fastq.gz",
    package = "scruff")
v1h1R2 <- system.file("extdata",
    "vandenBrink_1h1_L001_R2_001.fastq.gz",
    package = "scruff")
fasta <- system.file("extdata", "GRCm38_MT.fa", package = "scruff")
gtf <- system.file("extdata", "GRCm38_MT.gtf", package = "scruff")

## ----buildindex1, results = 'hide'--------------------------------------------
# Create index files for GRCm38_MT.
# For details, please refer to Rsubread user manual.
# Specify the basename for Rsubread index
indexBase <- "GRCm38_MT"
Rsubread::buildindex(basename = indexBase,
    reference = fasta,
    indexSplit = FALSE)

## ----scruff, eval = FALSE, results = 'hide', warning = FALSE, message = FALSE----
# data(barcodeExample, package = "scruff")
# 
# sce <- scruff(project = "example",
#     experiment = c("1h1"),
#     lane = c("L001"),
#     read1Path = c(v1h1R1),
#     read2Path = c(v1h1R2),
#     bc = barcodeExample,
#     index = indexBase,
#     unique = FALSE,
#     nBestLocations = 1,
#     reference = gtf,
#     bcStart = 1,
#     bcStop = 8,
#     bcEdit = 1,
#     umiStart = 9,
#     umiStop = 12,
#     umiEdit = 1,
#     keep = 75,
#     cellPerWell = c(rep(1, 46), 0, 0),
#     cores = 2,
#     verbose = TRUE)

## ----qc1, warning = FALSE, message = FALSE, results = 'hide'------------------
data(sceExample, package = "scruff")
qc <- qcplots(sceExample)

## ----loadfiles2---------------------------------------------------------------
library(scruff)

# Get the paths to example FASTQ files.
# Please note that because the following files are included in
# scruff R package, we use system.file() function to extract the paths
# to these files. If the user is running scruff on real data, the
# paths to the input FASTQ, FASTA, and GTF files should be provided,
# and there is no need to call system.file() function. For example,
# v1h1R1 <- "/PATH/TO/vandenBrink_1h1_L001_R1_001.fastq.gz"
# fasta <- "/Path/TO/GRCm38_MT.fa"
v1h1R1 <- system.file("extdata",
    "vandenBrink_1h1_L001_R1_001.fastq.gz",
    package = "scruff")
v1h1R2 <- system.file("extdata",
    "vandenBrink_1h1_L001_R2_001.fastq.gz",
    package = "scruff")

## ----de, results = 'hide', warning = FALSE, message = FALSE-------------------
data(barcodeExample, package = "scruff")
de <- demultiplex(project = "example",
    experiment = c("1h1"),
    lane = c("L001"),
    read1Path = c(v1h1R1),
    read2Path = c(v1h1R2),
    barcodeExample,
    bcStart = 1,
    bcStop = 8,
    bcEdit = 1,
    umiStart = 9,
    umiStop = 12,
    keep = 75,
    minQual = 10,
    yieldReads = 1e+06,
    verbose = TRUE,
    overwrite = TRUE,
    cores = 2)

## ----al_files, eval = FALSE, results = 'hide'---------------------------------
# # Create index files for GRCm38_MT. For details, please refer to Rsubread
# # user manual.
# fasta <- system.file("extdata", "GRCm38_MT.fa", package = "scruff")
# 
# # Create index files for GRCm38_MT.
# # For details, please refer to Rsubread user manual.
# # Specify the basename for Rsubread index
# indexBase <- "GRCm38_MT"
# Rsubread::buildindex(basename = indexBase,
#     reference = fasta,
#     indexSplit = FALSE)

## ----al, eval = FALSE, results = 'hide', warning = FALSE, message = FALSE-----
# # Align the reads using Rsubread
# al <- alignRsubread(de,
#     indexBase,
#     unique = FALSE,
#     nBestLocations = 1,
#     format = "BAM",
#     overwrite = TRUE,
#     verbose = TRUE,
#     cores = 2)

## ----co, eval = FALSE, results = 'hide', warning = FALSE, message = FALSE-----
# gtf <- system.file("extdata", "GRCm38_MT.gtf", package = "scruff")
# # get the molecular counts of trancsripts for each cell
# # In experiment 1h1, cell barcodes 95 and 96 are empty well controls.
# # In experiment b1, cell barcode 95 is bulk sample containing 300 cells.
# sce <- countUMI(al,
#     gtf,
#     umiEdit = 1,
#     format = "BAM",
#     cellPerWell = c(rep(1, 46), 0, 0),
#     verbose = TRUE,
#     cores = 2)

## ----qc2, warning = FALSE, message = FALSE, echo = TRUE, results = "hide"-----
data(sceExample, package = "scruff")
qc <- qcplots(sceExample)
qc

## ----gtfEG, results = 'hide', warning = FALSE, message = FALSE----------------
# Visualize the reads mapped to gene "mt-Rnr2" in
# cell "vandenBrink_b1_cell_0095".
# bamExample is generated by GenomicAlignments::GAlignments function
data(bamExample, package = "scruff")

## ----visualize_reads----------------------------------------------------------
# gene mt-Rnr2 starts at 1094 and ends at 2675
start <- 1094
end <- 2675

g1 <- rview(bamExample, chr = "MT", start = start, end = end) +
    ggplot2::scale_x_continuous(limits = c(start, end))
g2 <- gview(gtf, chr = "MT", start = start, end = end) +
    ggplot2::scale_x_continuous(limits = c(start, end))
g <- (g1 + ggplot2::theme(axis.title.x = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    plot.margin = ggplot2::margin(t = 0, b = 0))) /
    (g2 + ggplot2::theme(plot.margin = ggplot2::margin(t = 0, b = 0))) /
    patchwork::plot_layout(ncol = 1,
        heights = c(4, 1))
g

## ----10x_bam_qc, warning = FALSE, message = FALSE-----------------------------
# The following example BAM file is the first 5000 BAM file records extracted
# from sample 01 of the 1.3 Million Brain Cells dataset from E18 Mice.
# (https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.3.0/
# 1M_neurons)
# The BAM file for sample 01 is downloaded from here:
# http://sra-download.ncbi.nlm.nih.gov/srapub_files/
# SRR5167880_E18_20160930_Neurons_Sample_01.bam
# see details here:
# https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP096558
# and here:
# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE93421
bamfile10x <- system.file("extdata",
    "SRR5167880_E18_20160930_Neurons_Sample_01_5000.bam",
    package = "scruff")

# The filtered cell barcodes are generated using the following script:
# library(TENxBrainData)
# library(data.table)
# tenx <- TENxBrainData()
# # get filtered barcodes for sample 01
# filteredBcIndex <- tstrsplit(colData(tenx)[, "Barcode"], "-")[[2]] == 1
# filteredBc <- colData(tenx)[filteredBcIndex, ][["Barcode"]]
filteredBc <- system.file("extdata",
    "SRR5167880_E18_20160930_Neurons_Sample_01_filtered_barcode.tsv",
    package = "scruff")
# QC results are saved to current working directory
sce <- tenxBamqc(bam = bamfile10x,
    experiment = "Neurons_Sample_01",
    filter = filteredBc)
sce

## ----bamqc1, warning = FALSE, message = FALSE, echo = TRUE, results = "hide"----
g <- qcplots(sce)
g

## ----session, echo = FALSE----------------------------------------------------
sessionInfo()

