# Code example from 'spiky_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(devtools)
load_all("./")

## ----eval = FALSE,message=FALSE-----------------------------------------------
# #To install this package, start R (version "3.6" or later) and enter:
#   #if (!requireNamespace("BiocManager", quietly = TRUE))
#   #  install.packages("BiocManager")
#   #
#   #BiocManager::install("spiky")
# 
# library(spiky)

## -----------------------------------------------------------------------------
data(spike)

## -----------------------------------------------------------------------------
sb <- system.file("extdata", "example.spike.bam", package="spiky",              mustWork=TRUE)
outFasta <- paste(system.file("extdata", package="spiky", mustWork=TRUE),"/spike_contigs.fa",sep="")
show(generate_spike_fasta(sb, spike=spike,fa=outFasta))

## -----------------------------------------------------------------------------
spikes <- system.file("extdata", "spikes.fa", package="spiky", mustWork=TRUE)
spikemeth <- spike$methylated
process_spikes(spikes, spikemeth)

## ----eval=TRUE----------------------------------------------------------------
genomic_bam_path <- system.file("extdata", "example_chr21.bam", package="spiky", mustWork=TRUE)
genomic_coverage <- scan_genomic_contigs(genomic_bam_path,spike=spike)
spike_bam_path <- system.file("extdata", "example.spike.bam", package="spiky", mustWork=TRUE)
spikes_coverage <- scan_spike_contigs(spike_bam_path,spike=spike)


## -----------------------------------------------------------------------------
genomic_bedpe_path <- system.file("extdata", "example_chr21_bedpe.bed.gz", package="spiky", mustWork=TRUE)
genomic_coverage <- scan_genomic_bedpe(genomic_bedpe_path,genome="hg38")
spike_bedpe_path <- system.file("extdata", "example_spike_bedpe.bed.gz", package="spiky", mustWork=TRUE)
spikes_coverage <- scan_spike_bedpe(spike_bedpe_path,spike=spike)

## ----eval=TRUE----------------------------------------------------------------
##Calculate methylation specificity
methyl_spec <- methylation_specificity(spikes_coverage,spike=spike)
print(methyl_spec)

## ----eval=TRUE----------------------------------------------------------------
## Build the Gaussian generalized linear model on the spike-in control data
gaussian_glm <- model_glm_pmol(spikes_coverage,spike=spike)
summary(gaussian_glm)

## ----eval=TRUE----------------------------------------------------------------
# Predict pmol concentration
# To select a genome other than hg38, use BSgenome::available.packages() to find valid BSgenome name
#library("BSgenome.Hsapiens.UCSC.hg38")
sample_data_pmol <- predict_pmol(gaussian_glm, genomic_coverage,bsgenome="BSgenome.Hsapiens.UCSC.hg38",ret="df")
head(sample_data_pmol,n=1)


## ----eval=TRUE----------------------------------------------------------------
sample_binned_data <- bin_pmol(sample_data_pmol)
head(sample_binned_data,n=1)

## -----------------------------------------------------------------------------
sessionInfo()

