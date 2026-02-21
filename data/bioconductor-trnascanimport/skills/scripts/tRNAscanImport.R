# Code example from 'tRNAscanImport' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(tRNAscanImport)
})

## -----------------------------------------------------------------------------
library(tRNAscanImport)
yeast_file <- system.file("extdata",
                          file = "yeast.tRNAscan",
                          package = "tRNAscanImport")

# output for sacCer3
# Before
readLines(con = yeast_file, n = 7L)

## -----------------------------------------------------------------------------
# output for sacCer3
# After
gr <- import.tRNAscanAsGRanges(yeast_file)
head(gr, 2)
# Any GRanges passing this, can be used for subsequent function
istRNAscanGRanges(gr)

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(Biostrings)
  library(rtracklayer)
})

## -----------------------------------------------------------------------------
library(Biostrings)
library(rtracklayer)
# suppressMessages(library(rtracklayer, quietly = TRUE))
# Save tRNA sequences
writeXStringSet(gr$tRNA_seq, filepath = tempfile())
# to be GFF3 compliant use tRNAscan2GFF
gff <- tRNAscan2GFF(gr)
export.gff3(gff, con = tempfile())

## -----------------------------------------------------------------------------
# tRNAscan-SE output for hg38
human_file <- system.file("extdata",
                          file = "human.tRNAscan",
                          package = "tRNAscanImport")
# tRNAscan-SE output for E. coli MG1655
eco_file <- system.file("extdata",
                        file = "ecoli.tRNAscan",
                        package = "tRNAscanImport")
# import tRNAscan-SE files
gr_human <- import.tRNAscanAsGRanges(human_file)
gr_eco <- import.tRNAscanAsGRanges(eco_file)

# get summary plots
grl <- GRangesList(Sce = gr,
                   Hsa = gr_human,
                   Eco = gr_eco)
plots <- gettRNAFeaturePlots(grl)

## ----plot1, fig.cap = "tRNA length."------------------------------------------
plots$length

## ----plot2, fig.cap = "tRNAscan-SE scores."-----------------------------------
plots$tRNAscan_score

## ----plot3, fig.cap = "tRNA GC content."--------------------------------------
plots$gc

## ----plot4, fig.cap = "tRNAs with introns."-----------------------------------
plots$tRNAscan_intron

## ----plot5, fig.cap = "Length of the variable loop."--------------------------
plots$variableLoop_length

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(BSgenome.Scerevisiae.UCSC.sacCer3)
})

## ----tRNA_precursor-----------------------------------------------------------
library(BSgenome.Scerevisiae.UCSC.sacCer3)
genome <- getSeq(BSgenome.Scerevisiae.UCSC.sacCer3)
# renaming chromosome to match tRNAscan output
names(genome) <- c(names(genome)[-17L],"chrmt")
tRNAprecursor <- get.tRNAprecursor(gr, genome)
head(tRNAprecursor)

## -----------------------------------------------------------------------------
sessionInfo()

