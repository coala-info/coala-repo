# Code example from 'tapseq_primer_design' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/full/path/to/primer3-x.x.x/src", sep = ":"))
# 
# Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/full/path/to/blast+/ncbi-blast-x.x.x+/bin",
#                         sep = ":"))

## ----message=FALSE, warning=FALSE---------------------------------------------
library(TAPseq)
library(GenomicRanges)
library(BiocParallel)

# gene annotations for chromosome 11 genomic region
data("chr11_genes")

# convert to GRangesList containing annotated exons per gene. for the sake of time we only use
# a small subset of the chr11 genes. use the full set for a more realistic example
target_genes <- split(chr11_genes, f = chr11_genes$gene_name)
target_genes <- target_genes[18:27]

# K562 Drop-seq read data (this is just a small example file within the R package)
dropseq_bam <- system.file("extdata", "chr11_k562_dropseq.bam", package = "TAPseq")

# register backend for parallelization
register(MulticoreParam(workers = 2))

# infer polyA sites from Drop-seq data
polyA_sites <- inferPolyASites(target_genes, bam = dropseq_bam, polyA_downstream = 50,
                               wdsize = 100, min_cvrg = 1, parallel = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# library(rtracklayer)
# export(polyA_sites, con = "path/to/polyA_sites.bed", format = "bed")
# export(unlist(target_genes), con = "path/to/target_genes.gtf", format = "gtf")

## ----message=FALSE------------------------------------------------------------
# truncate transcripts at inferred polyA sites
truncated_txs <- truncateTxsPolyA(target_genes, polyA_sites = polyA_sites, parallel = TRUE)

## ----message=FALSE------------------------------------------------------------
library(BSgenome)

# human genome BSgenome object (needs to be istalled from Bioconductor)
hg38 <- getBSgenome("BSgenome.Hsapiens.UCSC.hg38")

# get sequence for all truncated transcripts
txs_seqs <- getTxsSeq(truncated_txs, genome = hg38)

## -----------------------------------------------------------------------------
# create TAPseq IO for outer forward primers from truncated transcript sequences
outer_primers <- TAPseqInput(txs_seqs, target_annot = truncated_txs,
                             product_size_range = c(350, 500), primer_num_return = 5)

## ----eval=FALSE---------------------------------------------------------------
# # design 5 outer primers for each target gene
# outer_primers <- designPrimers(outer_primers)

## ----include=FALSE------------------------------------------------------------
# Primer3 and BLAST are not run in this vignette, because they might be missing on the build system.
# already designed primers are loaded from internal data
outer_primers <- TAPseq:::vignette_data$outer_primers

## ----results="hide"-----------------------------------------------------------
# get primers and pcr products for specific genes
tapseq_primers(outer_primers$HBE1)
pcr_products(outer_primers$HBE1)

# these can also be accessed for all genes
tapseq_primers(outer_primers)
pcr_products(outer_primers)

## ----eval=FALSE---------------------------------------------------------------
# # chromosome 11 sequence
# chr11_genome <- DNAStringSet(getSeq(hg38, "chr11"))
# names(chr11_genome) <- "chr11"
# 
# # create blast database
# blastdb <- file.path(tempdir(), "blastdb")
# createBLASTDb(genome = chr11_genome, annot = unlist(target_genes), blastdb = blastdb)

## ----eval=FALSE---------------------------------------------------------------
# library(BSgenome)
# 
# # human genome BSgenome object (needs to be istalled from Bioconductor)
# hg38 <- getBSgenome("BSgenome.Hsapiens.UCSC.hg38")
# 
# # download and import gencode hg38 annotations
# url <- "ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/gencode.v32.annotation.gtf.gz"
# annot <- import(url, format = "gtf")
# 
# # extract exon annotations for protein-coding genes to build transcripts
# tx_exons <- annot[annot$type == "exon" & annot$gene_type == "protein_coding"]
# 
# # create blast database
# blastdb <- file.path(tempdir(), "blastdb")
# createBLASTDb(genome = hg38, annot = tx_exons, blastdb = blastdb)

## ----eval=FALSE---------------------------------------------------------------
# # now we can blast our outer primers against the create database
# outer_primers <- blastPrimers(outer_primers, blastdb = blastdb, max_mismatch = 0,
#                               min_aligned = 0.75)
# 
# # the primers now contain the number of estimated off-targets
# tapseq_primers(outer_primers$IFITM1)

## ----results="hide"-----------------------------------------------------------
# select best primer per target gene based on the number of potential off-targets
best_outer_primers <- pickPrimers(outer_primers, n = 1, by = "off_targets")

# each object now only contains the best primer
tapseq_primers(best_outer_primers$IFITM1)

## ----eval=FALSE---------------------------------------------------------------
# # create new TsIO objects for inner primers, note the different product size
# inner_primers <- TAPseqInput(txs_seqs, target_annot = truncated_txs,
#                              product_size_range = c(150, 300), primer_num_return = 5)
# 
# # design inner primers
# inner_primers <- designPrimers(inner_primers)
# 
# # blast inner primers
# inner_primers <- blastPrimers(inner_primers, blastdb = blastdb, max_mismatch = 0,
#                               min_aligned = 0.75)
# 
# # pick best primer per target gene
# best_inner_primers <- pickPrimers(inner_primers, n = 1, by = "off_targets")

## ----include=FALSE------------------------------------------------------------
best_inner_primers <- TAPseq:::vignette_data$best_inner_primers

## ----eval=FALSE---------------------------------------------------------------
# # use checkPrimers to run Primer3's "check_primers" functionality for every possible primer pair
# outer_comp <- checkPrimers(best_outer_primers)
# inner_comp <- checkPrimers(best_inner_primers)

## ----include=FALSE------------------------------------------------------------
outer_comp <- TAPseq:::vignette_data$outer_comp
inner_comp <- TAPseq:::vignette_data$inner_comp

## ----message=FALSE, fig.height=3.4, fig.width=7.15----------------------------
library(dplyr)
library(ggplot2)

# merge outer and inner complementarity scores into one data.frame
comp <- bind_rows(outer = outer_comp, inner = inner_comp, .id = "set")

# add variable for pairs with any complemetarity score higher than 47
comp <- comp %>%
  mutate(high_compl = if_else(primer_pair_compl_any_th > 47 | primer_pair_compl_end_th > 47,
                              true = "high", false = "ok")) %>% 
  mutate(high_compl = factor(high_compl, levels = c("ok", "high")))
                              
# plot complementarity scores
ggplot(comp, aes(x = primer_pair_compl_any_th, y = primer_pair_compl_end_th)) +
  facet_wrap(~set, ncol = 2) +
  geom_point(aes(color = high_compl), alpha = 0.25) +
  scale_color_manual(values = c("black", "red"), drop = FALSE) +
  geom_hline(aes(yintercept = 47), colour = "darkgray", linetype = "dashed") +
  geom_vline(aes(xintercept = 47), colour = "darkgray", linetype = "dashed") +
  labs(title = "Complementarity scores TAP-seq primer combinations",
       color = "Complementarity") +
  theme_bw()

## ----results="hide"-----------------------------------------------------------
# create data.frames for outer and inner primers
outer_primers_df <- primerDataFrame(best_outer_primers)
inner_primers_df <- primerDataFrame(best_inner_primers)

# the resulting data.frames contain all relevant primer data
head(outer_primers_df)

## ----results="hide"-----------------------------------------------------------
# create BED tracks for outer and inner primers with custom colors
outer_primers_track <- createPrimerTrack(best_outer_primers, color = "steelblue3")
inner_primers_track <- createPrimerTrack(best_inner_primers, color = "goldenrod1")

# the output data.frames contain lines in BED format for every primer
head(outer_primers_track)
head(inner_primers_track)

# export tracks to .bed files ("" writes to the standard output, replace by a file name)
exportPrimerTrack(outer_primers_track, con = "")
exportPrimerTrack(inner_primers_track, con = "")

## ----eval=FALSE---------------------------------------------------------------
# exportPrimerTrack(createPrimerTrack(best_outer_primers, color = "steelblue3"),
#                   createPrimerTrack(best_inner_primers, color = "goldenrod1"),
#                   con = "path/to/primers.bed")

## -----------------------------------------------------------------------------
sessionInfo()

