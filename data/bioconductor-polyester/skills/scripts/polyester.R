# Code example from 'polyester' vignette. See references/ for full tutorial.

## ----installme, eval=FALSE-----------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("polyester")

## ----fcmat---------------------------------------------------------------
fold_changes = matrix(c(4,4,rep(1,18),1,1,4,4,rep(1,16)), nrow=20)
head(fold_changes)

## ----builtinex, warning=FALSE, message=FALSE-----------------------------
library(polyester)
library(Biostrings)

# FASTA annotation
fasta_file = system.file('extdata', 'chr22.fa', package='polyester')
fasta = readDNAStringSet(fasta_file)

# subset the FASTA file to first 20 transcripts
small_fasta = fasta[1:20]
writeXStringSet(small_fasta, 'chr22_small.fa')

# ~20x coverage ----> reads per transcript = transcriptlength/readlength * 20
# here all transcripts will have ~equal FPKM
readspertx = round(20 * width(small_fasta) / 100)

# simulation call:
simulate_experiment('chr22_small.fa', reads_per_transcript=readspertx, 
    num_reps=c(10,10), fold_changes=fold_changes, outdir='simulated_reads') 

## ----countmat------------------------------------------------------------
# set up transcript-by-timepoint matrix:
num_timepoints = 12
countmat = matrix(readspertx, nrow=length(small_fasta), ncol=num_timepoints)

# add spikes in expression at certain timepoints to certain transcripts:
up_early = c(1,2) 
up_late = c(3,4)
countmat[up_early, 2] = 3*countmat[up_early, 2]
countmat[up_early, 3] = round(1.5*countmat[up_early, 3])
countmat[up_late, 10] = 6*countmat[up_late, 10]
countmat[up_late, 11] = round(1.2*countmat[up_late, 11])

# simulate reads:
simulate_experiment_countmat('chr22_small.fa', readmat=countmat, 
    outdir='timecourse_reads') 

## ----installbg, eval=FALSE-----------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("ballgown")
#  library(ballgown)
#  data(bg)
#  bg = subset(bg, "chr=='22'")
#  
#  # load gtf file for annotation:
#  gtfpath = system.file('extdata', 'bg.gtf.gz', package='polyester')
#  gtf = subset(gffRead(gtfpath), seqname=='22')
#  
#  # load chromosome sequence corresponding to gtf file (just for this example -- requires download because of file size)
#  system('wget https://www.dropbox.com/s/04i6msi9vu2snif/chr22seq.rda')
#  load('chr22seq.rda')
#  names(chr22seq) = '22'
#  
#  # simulate reads based on this experiment's FPKMs
#  simulate_experiment_empirical(bg, grouplabels=pData(bg)$group, gtf=gtf,
#      seqpath=chr22seq, mean_rps=5000, outdir='empirical_reads', seed=1247)

## ----info, results='markup'----------------------------------------------
sessionInfo()

