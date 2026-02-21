# Code example from 'ImportingProcessingData' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)

## -----------------------------------------------------------------------------
bfile <- system.file("extdata", "PROseq_dm6_chr4.bam", 
                     package = "BRGenomics")

## -----------------------------------------------------------------------------
ps_reads <- import_bam(bfile, mapq = 20, revcomp = TRUE, paired_end = FALSE)
ps_reads

## -----------------------------------------------------------------------------
sum(score(ps_reads))

## -----------------------------------------------------------------------------
reads_expanded <- import_bam(bfile, mapq = 20, revcomp = TRUE, 
                             field = NULL, paired_end = FALSE)
ps_reads[1:8]
reads_expanded[1:8]

## -----------------------------------------------------------------------------
length(reads_expanded) == sum(score(ps_reads))

## -----------------------------------------------------------------------------
ps <- import_bam(bfile, 
                 mapq = 20, 
                 revcomp = TRUE,
                 shift = -1,
                 trim.to = "3p",
                 paired_end = FALSE)
ps

## ---- collapse = TRUE---------------------------------------------------------
length(ps_reads)
length(ps)

## ---- collapse = TRUE---------------------------------------------------------
sum(score(ps)) == sum(score(ps_reads))

## ---- collapse = TRUE---------------------------------------------------------
isBRG(ps)

## ---- eval=FALSE--------------------------------------------------------------
#  # import bam, automatically applying processing steps for PRO-seq
#  ps <- import_bam_PROseq(bfile, mapq = 30, paired_end = FALSE)
#  
#  # separate strands, and make minus-strand scores negative
#  ps_plus <- subset(ps, strand == "+")
#  ps_minus <- subset(ps, strand == "-")
#  score(ps_minus) <- -score(ps_minus)
#  
#  # use rtracklayer to export bigWig files
#  export.bw(ps_plus, "~/Data/PROseq_plus.bw")
#  export.bw(ps_minus, "~/Data/PROseq_minus.bw")

## -----------------------------------------------------------------------------
# local paths to included bedGraph files
bg.p <- system.file("extdata", "PROseq_dm6_chr4_plus.bedGraph",
                    package = "BRGenomics")
bg.m <- system.file("extdata", "PROseq_dm6_chr4_minus.bedGraph",
                    package = "BRGenomics")

import_bedGraph(bg.p, bg.m, genome = "dm6")

## -----------------------------------------------------------------------------
# local paths to included bigWig files
bw.p <- system.file("extdata", "PROseq_dm6_chr4_plus.bw",
                    package = "BRGenomics")
bw.m <- system.file("extdata", "PROseq_dm6_chr4_minus.bw",
                    package = "BRGenomics")

import_bigWig(bw.p, bw.m, genome = "dm6")

## -----------------------------------------------------------------------------
ps_list <- lapply(1:6, function(i) ps[seq(i, length(ps), 6)])
names(ps_list) <- c("A_rep1", "A_rep2", 
                    "B_rep1", "B_rep2",
                    "C_rep1", "C_rep2")

## -----------------------------------------------------------------------------
ps_list[1:2]
names(ps_list)

## -----------------------------------------------------------------------------
mergeGRangesData(ps_list, ncores = 1)

## -----------------------------------------------------------------------------
merge_ps <- mergeGRangesData(ps_list[[1]], ps_list[[2]], ps, ncores = 1)
merge_ps

## ---- collapse = TRUE---------------------------------------------------------
isBRG(merge_ps)

## -----------------------------------------------------------------------------
mergeReplicates(ps_list, ncores = 1)

