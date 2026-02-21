# Code example from 'methrix' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(tinytex.verbose = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# #Installing stable version from BioConductor
# BiocManager::install("methrix")
# 
# #Installing developmental version from GitHub
# BiocManager::install("CompEpigen/methrix")

## ----message=FALSE, warning=FALSE, eval=TRUE----------------------------------
#Load library
library(methrix)

## ----eval=FALSE---------------------------------------------------------------
# #Genome of your preference to work with
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# library(BiocManager)
# 
# if(!requireNamespace("BSgenome.Hsapiens.UCSC.hg19")) {
# BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
# }
# library(BSgenome.Hsapiens.UCSC.hg19)

## -----------------------------------------------------------------------------
#Example bedgraph files
bdg_files <- list.files(
  path = system.file('extdata', package = 'methrix'),
  pattern = "*bedGraph\\.gz$",
  full.names = TRUE
)

print(basename(bdg_files))

#Generate some sample annotation table
sample_anno <- data.frame(
  row.names = gsub(
    pattern = "\\.bedGraph\\.gz$",
    replacement = "",
    x = basename(bdg_files)
  ),
  Condition = c("cancer", 'cancer', "normal", "normal"),
  Pair = c("pair1", "pair2", "pair1", "pair2"),
  stringsAsFactors = FALSE
)

print(sample_anno)

## ----warning=FALSE, eval=TRUE-------------------------------------------------
#First extract genome wide CpGs from the desired reference genome
hg19_cpgs <- suppressWarnings(methrix::extract_CPGs(ref_genome = "BSgenome.Hsapiens.UCSC.hg19"))

## ----eval=TRUE----------------------------------------------------------------
#Read the files 
meth <- methrix::read_bedgraphs(
  files = bdg_files,
  ref_cpgs = hg19_cpgs,
  chr_idx = 1,
  start_idx = 2,
  M_idx = 3,
  U_idx = 4,
  stranded = FALSE,
  zero_based = FALSE, 
  collapse_strands = FALSE, 
  coldata = sample_anno
)

## ----eval=TRUE----------------------------------------------------------------
#Typing meth shows basic summary.
meth

## ----eval=FALSE---------------------------------------------------------------
# methrix::methrix_report(meth = meth, output_dir = tempdir())

## ----eval=TRUE----------------------------------------------------------------
meth = methrix::remove_uncovered(m = meth)

## ----eval=TRUE----------------------------------------------------------------
meth

## ----eval=FALSE---------------------------------------------------------------
# if(!require(MafDb.1Kgenomes.phase3.hs37d5)) {
# BiocManager::install("MafDb.1Kgenomes.phase3.hs37d5")}
# if(!require(GenomicScores)) {
# BiocManager::install("GenomicScores")}

## ----eval=TRUE----------------------------------------------------------------
library(MafDb.1Kgenomes.phase3.hs37d5)
library(GenomicScores)

meth_snps_filtered <- methrix::remove_snps(m = meth)

## -----------------------------------------------------------------------------
#Example data bundled, same as the previously generated meth 
data("methrix_data")

#Coverage matrix
coverage_mat <- methrix::get_matrix(m = methrix_data, type = "C")
head(coverage_mat)

## -----------------------------------------------------------------------------
#Methylation matrix
meth_mat <- methrix::get_matrix(m = methrix_data, type = "M")
head(meth_mat)

## -----------------------------------------------------------------------------
#If you prefer you can attach loci info to the matrix and output in GRanges format
meth_mat_with_loci <- methrix::get_matrix(m = methrix_data, type = "M", add_loci = TRUE, in_granges = TRUE)
meth_mat_with_loci

## -----------------------------------------------------------------------------
#e.g; Retain all loci which are covered at-least in two sample by 3 or more reads
methrix::coverage_filter(m = methrix_data, cov_thr = 3, min_samples = 2)

## -----------------------------------------------------------------------------
#Retain sites only from chromosme chr21
methrix::subset_methrix(m = methrix_data, contigs = "chr21")

## -----------------------------------------------------------------------------
#e.g; Retain sites only in TP53 loci 
target_loci <- GenomicRanges::GRanges("chr21:27867971-27868103")

print(target_loci)

methrix::subset_methrix(m = methrix_data, regions = target_loci)


## -----------------------------------------------------------------------------
methrix::subset_methrix(m = methrix_data, samples = "C1")

#Or you could use [] operator to subset by index
methrix_data[,1]

## -----------------------------------------------------------------------------
meth_stats <- get_stats(m = methrix_data)
print(meth_stats)

## -----------------------------------------------------------------------------
#Draw mean coverage per sample
plot_stats(plot_dat = meth_stats, what = "C", stat = "mean")
#Draw mean methylation per sample
plot_stats(plot_dat = meth_stats, what = "M", stat = "mean")

## -----------------------------------------------------------------------------
mpca <- methrix_pca(m = methrix_data, do_plot = FALSE)

#Plot PCA results
plot_pca(pca_res = mpca, show_labels = TRUE)

#Color code by an annotation
plot_pca(pca_res = mpca, m = methrix_data, col_anno = "Condition")

## -----------------------------------------------------------------------------
#Violin plots
methrix::plot_violin(m = methrix_data)

## -----------------------------------------------------------------------------
methrix::plot_coverage(m = methrix_data, type = "dens")

## ----eval=FALSE---------------------------------------------------------------
# if(!require(bsseq)) {
# BiocManager::install("bsseq")}
# 

## -----------------------------------------------------------------------------
library(bsseq)
bs_seq <- methrix::methrix2bsseq(m = methrix_data)

bs_seq

## -----------------------------------------------------------------------------
sessionInfo()

