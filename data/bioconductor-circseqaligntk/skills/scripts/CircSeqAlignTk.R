# Code example from 'CircSeqAlignTk' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      error = TRUE,
                      warning = FALSE,
                      message = FALSE,
                      dev = 'png')
library(CircSeqAlignTk)
set.seed(1)

## ----install_package, eval=FALSE----------------------------------------------
# if (!requireNamespace('BiocManager', quietly = TRUE))
#     install.packages('BiocManager')
# 
# BiocManager::install('CircSeqAlignTk')

## ----quick_start__tempws------------------------------------------------------
ws <- tempdir()

## ----quick_start__ws, eval=FALSE----------------------------------------------
# ws <- '/home/username/desktop/viroid_project'

## ----quick_start__preparation_fastq-------------------------------------------
fq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'srna.fq.gz')

## ----quick_start__preparation_reference---------------------------------------
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')

## ----quick_start__triming-----------------------------------------------------
library(R.utils)
library(Rbowtie2)
adapter <- 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC'

# decompressed the gzip file for trimming to avoid errors from `remove_adapters`
gunzip(fq, destname = file.path(ws, 'srna.fq'), overwrite = TRUE, remove = FALSE)

trimmed_fq <- file.path(ws, 'srna_trimmed.fq')
params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
remove_adapters(file1 = file.path(ws, 'srna.fq'),
                adapter1 = adapter,
                adapter2 = NULL,
                output1 = trimmed_fq,
                params,
                basename = file.path(ws, 'AdapterRemoval.log'),
                overwrite = TRUE)

## ----quick_start__alignment---------------------------------------------------
ref_index <- build_index(input = genome_seq, 
                         output = file.path(ws, 'index'))
aln <- align_reads(input = trimmed_fq, 
                   index = ref_index,
                   output = file.path(ws, 'align_results'))

## ----quick_start__summary-----------------------------------------------------
alncov <- calc_coverage(aln)
head(slot(alncov, 'forward'))  # alignment coverage in forward strand 
head(slot(alncov, 'reverse'))  # alignment coverage in reverse strand 

## ----quickStartVisualization, fig.cap='Alignment coverage. The alignment coverage of the case study.'----
plot(alncov)

## ----packageImplementation, fig.cap='Two-stage alignment process. Overview of the two-stage alignment process and the related functions in the CircSeqAlignTk package', echo=FALSE, fig.wide=TRUE----
knitr::include_graphics('overview.png')

## ----implementation__build_index----------------------------------------------
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq, output = file.path(ws, 'index'))

## ----implementation__build_index_output---------------------------------------
str(ref_index)

## ----implementation__build_index_output_refseq--------------------------------
slot(ref_index, 'fasta')

## ----implementation__build_index_output_index---------------------------------
slot(ref_index, 'index')

## ----access_slot_content, eval=FALSE------------------------------------------
# ref_index@fasta
# ref_index@index

## ----implementation__build_index_cutloci--------------------------------------
slot(ref_index, 'cut_loc')

## ----implementation__build_bt2index, eval=FALSE-------------------------------
# ref_bt2index <- build_index(input = genome_seq,
#                             output = file.path(ws, 'bt2index'),
#                             aligner = 'bowtie2')

## ----implementation__align_read-----------------------------------------------
fq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'srna.fq.gz')
# trimming the adapter sequences if needed before alignment, omitted here.

aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'))

## ----implementation__align_read_output----------------------------------------
str(aln)

## ----implementation__align_read_output_bam------------------------------------
slot(aln, 'bam')
slot(aln, 'clean_bam')

## ----implementation__align_read_stats-----------------------------------------
slot(aln, 'stats')

## ----implementation__align_read__mismatch-------------------------------------
aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_mismatch = 0)

## ----implementation__align_read__threads--------------------------------------
aln <- align_reads(input = fq,
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_threads = 4)

## ----implementation__align_read__add_params, eval=FALSE-----------------------
# aln <- align_reads(input = fq,
#                    index = ref_index,
#                    output = file.path(ws, 'align_results'),
#                    add_args = '--no-spliced-alignment')

## ----implementation__align_read__bt2, eval=FALSE------------------------------
# aln <- align_reads(input = fq,
#                    index = ref_bt2index ,
#                    output = file.path(ws, 'align_results'),
#                    aligner = 'bowtie2',
#                    add_args = '-L 20 -N 1')

## ----implementation__summary--------------------------------------------------
alncov <- calc_coverage(aln)

## ----implementation__summary_fwd----------------------------------------------
head(slot(alncov, 'forward'))
head(slot(alncov, 'reverse'))

## ----implementationVisualization, fig.cap='Alignment coverage.'---------------
plot(alncov)

## ----implementationVisualizationReadlen, fig.cap='Alignment coverage of reads with the specific lengths.'----
plot(alncov, read_lengths = c(21, 22))

## ----implementationVisualizationOption1, fig.cap='Alignment coverage arranged with ggplot2.'----
library(ggplot2)
plot(alncov) + facet_grid(strand ~ read_length, scales = 'free_y')

## ----implementationVisualizationOption2, fig.cap='Alignment coverage represented in polar coordinate system.'----
plot(alncov) + coord_polar()

## ----sim__default_params------------------------------------------------------
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'))

## ----sim__default_params_str--------------------------------------------------
str(sim)

## ----sim__default_params_peak-------------------------------------------------
head(slot(sim, 'peak'))

## ----sim__default_params_readinfo---------------------------------------------
dim(slot(sim, 'read_info'))
head(slot(sim, 'read_info'))

## ----simDefaultParamsCoverageFig, fig.cap='Alignment coverage of the synthetic data.'----
alncov <- slot(sim, 'coverage')
head(slot(alncov, 'forward'))
head(slot(alncov, 'reverse'))
plot(alncov)

## ----sim__args_n--------------------------------------------------------------
sim <- generate_reads(n = 1e3, output = file.path(ws, 'synthetic_reads.fq.gz'))

## ----sim__args_seq------------------------------------------------------------
genome_seq <- 'CGGAACTAAACTCGTGGTTCCTGTGGTTCACACCTGACCTCCTGACAAGAAAAGAAAAAAGAAGGCGGCTCGGAGGAGCGCTTCAGGGATCCCCGGGGAAACCTGGAGCGAACTGGCAAAAAAGGACGGTGGGGAGTGCCCAGCGGCCGACAGGAGTAATTCCCGCCGAAACAGGGTTTTCACCCTTCCTTTCTTCGGGTGTCCTTCCTCGCGCCCGCAGGACCACCCCTCGCCCCCTTTGCGCTGTCGCTTCGGCTACTACCCGGTGGAAACAACTGAAGCTCCCGAGAACCGCTTTTTCTCTATCTTACTTGCTCCGGGGCGAGGGTGTTTAGCCCTTGGAACCGCAGTTGGTTCCT'

sim <- generate_reads(seq = genome_seq,
                      output = file.path(ws, 'synthetic_reads.fq.gz'))

## ----sim__args_adapter--------------------------------------------------------
adapter <- 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
sim <- generate_reads(adapter = adapter, 
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      read_length = 150)

## ----sim__args_adapter_NA-----------------------------------------------------
sim <- generate_reads(adapter = NA, 
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      read_length = 150)

## ----sim__args_mismatch_1-----------------------------------------------------
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'),
                      mismatch_prob = 0.05)

## ----sim__args_mismatch_2-----------------------------------------------------
sim <- generate_reads(output = file.path(ws, 'synthetic_reads.fq.gz'),
                      mismatch_prob = c(0.05, 0.1))

## ----simSetLengthAndPeaksScripts----------------------------------------------
peaks <- data.frame(
    mean   = c(   0,   25,   70,   90,  150,  240,  260,  270,  330,  350),
    std    = c(   5,    5,    5,    5,   10,    5,    5,    1,    2,    1),
    strand = c( '+',  '+',  '-',  '-',  '+',  '+',  '-',  '+',  '+',  '-'),
    prob   = c(0.10, 0.10, 0.18, 0.05, 0.03, 0.18, 0.15, 0.10, 0.06, 0.05)
)
srna_length <- data.frame(
    length = c(  21,   22,   23,   24),
    prob   = c(0.45, 0.40, 0.10, 0.05)
)

sim <- generate_reads(n = 1e4,
                      output = file.path(ws, 'synthetic_reads.fq.gz'),
                      srna_length = srna_length, 
                      peaks = peaks)

## ----simSetLengthAndPeaks, fig.cap='Alignment coverage of the synthetic data.'----
plot(slot(sim, 'coverage'))

## ----simMergeMultiSimObjectsScripts-------------------------------------------
peaks_1 <- data.frame(
    mean   = c( 100,  150,  250,  300),
    std    = c(   5,    5,    5,    5),
    strand = c( '+',  '+',  '-',  '-'),
    prob   = c(0.25, 0.25, 0.40, 0.05)
)
srna_length_1 <- data.frame(
    length = c(  21,   22),
    prob   = c(0.45, 0.65)
)
sim_1 <- generate_reads(n = 1e4,
                        output = file.path(ws, 'synthetic_reads_1.fq.gz'),
                        srna_length = srna_length_1, 
                        peaks = peaks_1)

peaks_2 <- data.frame(
    mean   = c(  50,  200,  300),
    std    = c(   5,    5,    5),
    strand = c( '+',  '-',  '+'),
    prob   = c(0.80, 0.10, 0.10)
)
srna_length_2 <- data.frame(
    length = c(  21,   22,   23),
    prob   = c(0.10, 0.10, 0.80)
)
sim_2 <- generate_reads(n = 1e3,
                        output = file.path(ws, 'synthetic_reads_2.fq.gz'),
                        srna_length = srna_length_2, 
                        peaks = peaks_2)

peaks_3 <- data.frame(
    mean   = c(   80,  100,  220,  270),
    std    = c(    5,    5,    1,    2),
    strand = c(  '-',  '+',  '+',  '-'),
    prob   = c( 0.20, 0.30, 0.20, 0.30)
)
srna_length_3 <- data.frame(
    length = c(  19,   20,   21,   22),
    prob   = c(0.30, 0.30, 0.20, 0.20)
)
sim_3 <- generate_reads(n = 5e3,
                        output = file.path(ws, 'synthetic_reads_3.fq.gz'),
                        srna_length = srna_length_3, 
                        peaks = peaks_3)

# merge the three data sets
sim <- merge(sim_1, sim_2, sim_3, 
             output = file.path(ws, 'synthetic_reads.fq.gz'))

## ----simMergeMultiSimObjects, fig.cap='Alignment coverage of the synthetic data.'----
plot(slot(sim, 'coverage'))

## ----simeval__chk_workflow_align----------------------------------------------
sim <- generate_reads(adapter = NA,
                      mismatch_prob = 0,
                      output = file.path(ws, 'synthetic_reads.fq.gz'))

genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq, 
                         output = file.path(ws, 'index'))
aln <- align_reads(input = file.path(ws, 'synthetic_reads.fq.gz'),
                   index = ref_index, 
                   output = file.path(ws, 'align_results'))
alncov <- calc_coverage(aln)

## ----simeval__chk_workflow_rmse-----------------------------------------------
# coverage of reads in forward strand
fwd_pred <- slot(alncov, 'forward')
fwd_true <- slot(slot(sim, 'coverage'), 'forward')
sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
# coverage of reads in reverse strand
rev_pred <- slot(alncov, 'reverse')
rev_true <- slot(slot(sim, 'coverage'), 'reverse')
sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))

## ----simeval__sim1_syn--------------------------------------------------------
sim <- generate_reads(mismatch_prob = c(0.1, 0.2),
                      output = file.path(ws, 'synthetic_reads.fq'))

## ----simeval__sim1_align------------------------------------------------------
library(R.utils)
library(Rbowtie2)

# quality control
params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
remove_adapters(file1 = file.path(ws, 'synthetic_reads.fq'),
                adapter1 = slot(sim, 'adapter'), 
                adapter2 = NULL,
                output1 = file.path(ws, 'srna_trimmed.fq'),
                params,
                basename = file.path(ws, 'AdapterRemoval.log'),
                overwrite = TRUE)

# alignment
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq, 
                         output = file.path(ws, 'index'))
aln <- align_reads(input = file.path(ws, 'srna_trimmed.fq'),
                   index = ref_index,
                   output = file.path(ws, 'align_results'),
                   n_mismatch = 2)

# calculate alignment coverage
alncov <- calc_coverage(aln)

## ----simeval__sim1_rmse-------------------------------------------------------
# coverage of reads in forward strand
fwd_pred <- slot(alncov, 'forward')
fwd_true <- slot(slot(sim, 'coverage'), 'forward')
sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
# coverage of reads in reverse strand
rev_pred <- slot(alncov, 'reverse')
rev_true <- slot(slot(sim, 'coverage'), 'reverse')
sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))

## ----simeval__sim2------------------------------------------------------------
library(R.utils)
library(Rbowtie2)

params <- '--maxns 1 --trimqualities --minquality 30 --minlength 21 --maxlength 24'
genome_seq <- system.file(package = 'CircSeqAlignTk', 'extdata', 'FR851463.fa')
ref_index <- build_index(input = genome_seq, 
                         output = file.path(ws, 'index'))

fwd_rmse <- rev_rmse <- rep(NA, 10)

for (i in seq(fwd_rmse)) {
    # prepare file names and directory to store the simulation results
    simset_dpath <- file.path(ws, paste0('sim_tries_', i))
    dir.create(simset_dpath)
    syn_fq <- file.path(simset_dpath, 'synthetic_reads.fq')
    trimmed_syn_fq <- file.path(simset_dpath, 'srna_trimmed.fq')
    align_result <- file.path(simset_dpath, 'align_results')
    fig_coverage <- file.path(simset_dpath, 'alin_coverage.png')
    
    # generate synthetic reads
    set.seed(i)
    sim <- generate_reads(mismatch_prob = c(0.1, 0.2), 
                          output = syn_fq)
    
    # quality control
    remove_adapters(file1 = syn_fq,
                    adapter1 = slot(sim, 'adapter'), 
                    adapter2 = NULL,
                    output1 = trimmed_syn_fq,
                    params,
                    basename = file.path(ws, 'AdapterRemoval.log'),
                    overwrite = TRUE)
    
    # alignment
    aln <- align_reads(input = trimmed_syn_fq, 
                       index = ref_index, 
                       output = align_result,
                       n_mismatch = 2)
    
    # calculate alignment coverage
    alncov <- calc_coverage(aln)
    
    # calculate RMSE
    fwd_pred <- slot(alncov, 'forward')
    fwd_true <- slot(slot(sim, 'coverage'), 'forward')
    fwd_rmse[i] <- sqrt(sum((fwd_pred - fwd_true) ^ 2) / length(fwd_true))
    rev_pred <- slot(alncov, 'reverse')
    rev_true <- slot(slot(sim, 'coverage'), 'reverse')
    rev_rmse[i] <- sqrt(sum((rev_pred - rev_true) ^ 2) / length(rev_true))
}

## ----simeval__sim2_rmse-------------------------------------------------------
rmse <- data.frame(forward = fwd_rmse, reverse = rev_rmse)
rmse

## ----tutorial_viroid__preparation---------------------------------------------
library(utils)

project_dpath <- tempdir()

dir.create(project_dpath)

options(timeout = 60 * 10)
download.file(url = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=U23058&rettype=fasta&retmode=text',
              destfile = file.path(project_dpath, 'U23058.fa'))
download.file(url = 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE70166&format=file',
              destfile = file.path(project_dpath, 'GSE70166.tar'))
untar(file.path(project_dpath, 'GSE70166.tar'), exdir = project_dpath)

## ----tutorial_viorid__alignment-----------------------------------------------
genome_seq <- file.path(project_dpath, 'U23058.fa')
fq <- file.path(project_dpath, 'GSM1717894_PSTVd_RG1.txt.gz')

ref_index <- build_index(input = genome_seq,
                         output = file.path(project_dpath, 'index'))
aln <- align_reads(input = fq, index = ref_index,
                   output = file.path(project_dpath, 'align_results'))

## ----tutorial_viroid__alignment_result, echo = FALSE--------------------------
x <- as.matrix(slot(aln, 'stats'))

## ----tutorial_viroid__alignment_stats-----------------------------------------
slot(aln, 'stats')

## ----tutorial_viroid__alignment_stats_calcov----------------------------------
alncov <- calc_coverage(aln)

## ----tutorialViroidCoverage, fig.cap='Alignment coverage of small RNA-Seq data obtained from the viroid-infected tomato plants.'----
head(slot(alncov, 'forward'))
head(slot(alncov, 'reverse'))
plot(alncov)

## ----tutorial_gui, eval=FALSE-------------------------------------------------
# library(shiny)
# library(CircSeqAlignTk)
# app <- build_app()
# shiny::runApp(app)

## -----------------------------------------------------------------------------
sessionInfo()

