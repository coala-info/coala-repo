# Code example from 'creating_a_new_reference' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, crop = NULL)

## ----load-packages------------------------------------------------------------
library(VariantAnnotation)
library(rtracklayer)
library(extraChIPs)
library(transmogR)
library(GenomicFeatures)
library(BSgenome.Hsapiens.UCSC.hg38)

## ----chr1---------------------------------------------------------------------
chr1 <- getSeq(BSgenome.Hsapiens.UCSC.hg38, "chr1")
chr1 <- as(chr1, "DNAStringSet")
names(chr1) <- "chr1"
chr1

## ----sq-----------------------------------------------------------------------
sq <- seqinfo(chr1)
genome(sq) <- "GRCh38"
sq

## ----vcf----------------------------------------------------------------------
vcf <- system.file("extdata/1000GP_subset.vcf.gz", package = "transmogR")
vcf <- VcfFile(vcf)

## ----var----------------------------------------------------------------------
var <- cleanVariants(vcf)
seqinfo(var) <- sq
var

## ----gtf----------------------------------------------------------------------
f <- system.file("extdata/gencode.v44.subset.gtf.gz", package = "transmogR")
gtf <- import.gff(f, which = GRanges(sq))
seqinfo(gtf) <- sq
gtf

## ----gtf-split----------------------------------------------------------------
gtf <- splitAsList(gtf, gtf$type)

## ----upset-var, fig.cap = "Included variants which overlap exonic sequences, summarised by unique gene ids"----
upsetVarByCol(gtf$exon, var, mcol = "gene_id")

## ----overlaps-by-var----------------------------------------------------------
regions <- defineRegions(gtf$gene, gtf$transcript, gtf$exon, proximal = 0)
regions$exon <- granges(gtf$exon)
overlapsByVar(regions, var)

## ----trans-mod----------------------------------------------------------------
trans_mod <- transmogrify(chr1, var, gtf$exon, tag = "1000GP", var_tags = TRUE)
trans_mod
names(trans_mod)[grepl("_si", names(trans_mod))]

## ----chr1-mod-----------------------------------------------------------------
chr1_mod <- genomogrify(chr1, var)
chr1_mod

## ----gentrome, eval=FALSE-----------------------------------------------------
# c(trans_mod, chr1_mod) %>% writeXStringSet("gentrome.fa.gz", compress = TRUE)
# writeLines(names(chr1_mod), "decoys.txt")

## ----ref-trans----------------------------------------------------------------
ref_exons_by_trans <- gtf$exon %>% splitAsList(.$transcript_id) 
ref_trans <- extractTranscriptSeqs(chr1, ref_exons_by_trans)
ref_trans

## ----new-exons----------------------------------------------------------------
new_exons <- shiftByVar(gtf$exon, var)

## ----compare-seqinfo----------------------------------------------------------
seqinfo(new_exons)
seqinfo(chr1_mod)

## ----new-exon-by-trans--------------------------------------------------------
new_exon_by_trans <- splitAsList(new_exons, new_exons$transcript_id)

## ----tags---------------------------------------------------------------------
tags <- varTags(ref_exons_by_trans, var, tag = "1000GP")
names(new_exon_by_trans) <- paste0(names(new_exon_by_trans), tags)

## ----new-trans-mod------------------------------------------------------------
new_trans_mod <- extractTranscriptSeqs(chr1_mod, new_exon_by_trans)

## ----check-modified-----------------------------------------------------------
modified <- grepl("_", names(new_trans_mod))
all(new_trans_mod[!modified] == ref_trans[!modified])
all(new_trans_mod[modified] == trans_mod[modified])

## ----par-y--------------------------------------------------------------------
sq_hg38 <- seqinfo(BSgenome.Hsapiens.UCSC.hg38)
parY(sq_hg38)

## ----sj-----------------------------------------------------------------------
ec <- c("transcript_id", "transcript_name", "gene_id", "gene_name")
sj <- sjFromExons(gtf$exon, extra_cols = ec)
sj

## ----chop-sj------------------------------------------------------------------
chopMC(sj)

## ----sj-as-gi-----------------------------------------------------------------
sj <- sjFromExons(gtf$exon, extra_cols = ec, as = "GInteractions")
subset(sj, transcript_name == "DDX11L17-201")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

