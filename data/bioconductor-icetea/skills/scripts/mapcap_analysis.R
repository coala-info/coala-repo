# Code example from 'mapcap_analysis' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----quickIntro, eval=FALSE---------------------------------------------------
# # load the package
# library(icetea)
# 
# # provide demultiplexing barcodes and sample names
# idxlist <- c("CAAGTG", "TTAGCC", "GTGGAA", "TGTGAG")
# dir <- system.file("extdata", package="icetea")
# # corresponding sample names
# fnames <- c("embryo1", "embryo2", "embryo3", "embryo4")
# ## create CapSet object
# cs <- newCapSet(expMethod = 'MAPCap',
#                 fastq_R1 = file.path(dir, 'mapcap_test_R1.fastq.gz'),
#                 fastq_R2 = file.path(dir, 'mapcap_test_R2.fastq.gz'),
#                 idxList = idxlist,
#                 sampleNames = fnames)
# 
# # demultiplex fastq and trim the barcodes
# dir.create("splitting")
# cs <- demultiplexFASTQ(cs, max_mismatch = 1, outdir = "splitting", ncores = 10)
# 
# # map fastq
# dir.create("mapping")
# cs <- mapCaps(cs, subread_idx, outdir = "mapping", ncores = 20, logfile = "mapping/subread_mapping.log")
# 
# # filter PCR duplicates
# dir.create("removedup")
# cs <- filterDuplicates(cs, outdir = "removedup")
# 
# # detect TSS
# dir.create("tssCalling")
# cs <- detectTSS(cs, groups = c("wt", "wt", "mut", "mut"), outfile_prefix = "tssCalling/testTSS")

## ----makeCS, eval=TRUE, results = "hold"--------------------------------------
# provide demultiplexing barcodes as strings
idxlist <- c("CAAGTG", "TTAGCC", "GTGGAA", "TGTGAG")

# provide corresponding sample names
fnames <- c("embryo1", "embryo2", "embryo3", "embryo4")

# `dir` contains example data provided with this package
dir <- system.file("extdata", package = "icetea")

## CapSet object from raw (multiplexed) fastq files
library(icetea)
cs <- newCapSet(expMethod = 'MAPCap',
                fastq_R1 = file.path(dir, 'mapcap_test_R1.fastq.gz'),
                fastq_R2 = file.path(dir, 'mapcap_test_R2.fastq.gz'),
                idxList = idxlist,
                sampleNames = fnames)

## ----sampleinfo, eval=TRUE, results = "hold"----------------------------------
si <- sampleInfo(cs)
dir <- system.file("extdata/bam", package = "icetea")
si$mapped_file <- list.files(dir, pattern = ".bam$", full.names = TRUE)
sampleInfo(cs) <- si

## ----cs2, eval = TRUE, results = "hold"---------------------------------------
dir <- system.file("extdata/filtered_bam", package = "icetea")
cs2 <- newCapSet(expMethod = 'MAPCap',
                 filtered_file = list.files(dir, pattern = ".bam$", full.names = TRUE),
                 sampleNames = fnames)


## ----demultiplex, eval=TRUE, results = "hold"---------------------------------
# demultiplex fastq and trim the barcodes
dir.create("splitting")
cs <- demultiplexFASTQ(cs, max_mismatch = 1, outdir = "splitting", ncores = 10)

## ----indexgenome, eval=FALSE--------------------------------------------------
# dir.create("genome_index")
# library(Rsubread)
# buildindex(basename = "genome_index/dm6", reference = "/path/to/dm6/genome.fa")

## ----mapcaps, eval=FALSE------------------------------------------------------
# # provide location of a subread index file
# subread_idx <- "genome_index/dm6"
# # map fastq
# cs <- mapCaps(cs, subread_idx, outdir = "mapping", ncores = 20, logfile = "mapping/subread_mapping.log")
# # you can save the CapSet object for later use
# save(cs, file = "myCapSet.Rdata")

## ----splitbam, eval=FALSE-----------------------------------------------------
# splitBAM_byIndex(bamFile, index_list, outfile_list, max_mismatch = 1, ncores = 10)

## ----filterdups, eval=TRUE, results = "hold"----------------------------------
# load a previously saved CapSet object (or create new one)
cs <- exampleCSobject()
# filter PCR duplicates and save output in a new directory
dir.create("removedup")
cs <- filterDuplicates(cs, outdir = "removedup")

## ----getTSS, eval=TRUE, results = "hold"--------------------------------------
# detect TSS
dir.create("tssCalling")
cs <- detectTSS(cs, groups = c("wt", "wt", "mut", "mut"),
                 outfile_prefix = "tssCalling/testTSS", restrictChr = "X", ncores = 1)
# export the detected TSS bed files
exportTSS(cs, merged = TRUE, outfile_prefix = "tssCalling/testTSS")

## ----plotstats, eval=TRUE, results = "hold", fig.width=7, fig.height=5--------
# separated barchart for numbers
plotReadStats(cs, plotValue = "numbers", plotType = "dodge")

## ----plotstats2, eval=TRUE, results = "hide", fig.width=7, fig.height=5-------
# stacked barchart for proportions
plotReadStats(cs, plotValue = "proportions", plotType = "stack" )

## ----plotPrecision, eval=TRUE, results = "hold", fig.width=7, fig.height=5----
library("TxDb.Dmelanogaster.UCSC.dm6.ensGene")
library(GenomeInfoDb)  # for seqlevelsStyle()
seqlevelsStyle(TxDb.Dmelanogaster.UCSC.dm6.ensGene) <- "ENSEMBL"
# only analyse genes on chrX to make the analysis faster
seqlevels(TxDb.Dmelanogaster.UCSC.dm6.ensGene) <- "X"
transcripts <- transcripts(TxDb.Dmelanogaster.UCSC.dm6.ensGene)

# Plotting the precision using a pre computed set of TSS (.bed files) :
tssfile <- system.file("extdata", "testTSS_merged.bed", package = "icetea")
plotTSSprecision(reference = transcripts, detectedTSS = tssfile, sampleNames = "testsample")

## ----diffTSS, eval=FALSE------------------------------------------------------
# ## fitDiffTSS returns a DGEGLM object
# csfit <- fitDiffTSS(cs, groups = rep(c("wt","mut"), each = 2), normalization = "windowTMM",
#                      outplots = NULL, plotref = "embryo1")
# save(csfit, file = "diffTSS_fit.Rdata")
# 
# ## This object is then used by the detectDiffTSS function to return differentially expressed TSSs
# de_tss <- detectDiffTSS(csfit, testGroup = "mut", contGroup = "wt",
#                TSSfile = file.path(dir, "testTSS_merged.bed"), MAplot_fdr = 0.05)
# ## export the output
# library(rtracklayer)
# export.bed(de_tss[de_tss$score < 0.05], con = "diffTSS_output.bed")

## ----spikeNorm, eval=FALSE----------------------------------------------------
# ## get gene counts for spike-in RNA mapped to human genome
# library("TxDb.Hsapiens.UCSC.hg38.knownGene")
# normfacs <- getNormFactors(cs_spike, features = genes(TxDb.Hsapiens.UCSC.hg38.knownGene))
# 
# csfit <- fitDiffTSS(cs, groups = rep(c("wt","mut"), each = 2),
#                     normalization = NULL, normFactors = normfacs,
#                     outplots = NULL, plotRefSample = "embryo1", ncores = 1)

## ----genecounts, eval=FALSE---------------------------------------------------
# # get transcripts
# dm6trans <- transcriptsBy(TxDb.Dmelanogaster.UCSC.dm6.ensGene, "gene")
# # get gene counts, counting reads around 500 bp of the TSS
# gcounts <- getGeneCounts(cs, dm6trans)

## ----annotateTSS, eval = TRUE, results = "hold", fig.width=7, fig.height=5----
# save the output as data.frame (outdf) + plot on screen
outdf <- annotateTSS(tssBED = tssfile,
            txdb = TxDb.Dmelanogaster.UCSC.dm6.ensGene,
            plotValue = "number",
            outFile = NULL)

