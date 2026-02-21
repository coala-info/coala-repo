# Code example from 'Importing_Data' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Use bam file that exists in ORFik package
library(ORFik)
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
footprints <- fimport(bam_file)
# This is identical to:
footprints <- readBam(bam_file)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Use bam file that exists in ORFik package
ofst_file <- system.file("extdata/Danio_rerio_sample/ofst", "ribo-seq.ofst", package = "ORFik")
footprints <- fimport(ofst_file)
# This is identical to:
footprints <- import.ofst(ofst_file)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
ofst_out_dir <- file.path(tempdir(), "ofst/")
convert_bam_to_ofst(NULL, bam_file, ofst_out_dir)
# Find the file again
ofst_file <- list.files(ofst_out_dir, full.names = TRUE)[1]
# Load it
fimport(ofst_file)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
bigwig_out_dir <- file.path(tempdir(), "bigwig/")
convert_to_bigWig(NULL, bam_file, bigwig_out_dir, 
                  seq_info = seqinfo(BamFile(bam_file)))
# Find the file again
bigwig_file <- list.files(bigwig_out_dir, full.names = TRUE) 
# You see we have 2 files here, 1 for forward strand, 1 for reverse
# Load it
fimport(bigwig_file)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
bigwig_file <- list.files(bigwig_out_dir, full.names = TRUE) 
# Let us access a location without loading the full file.
random_point <- GRangesList(GRanges("chr24", 22711508, "-"))
# Getting raw vector (Then you need to know which strand it is on:)
bigwig_for_random_point <- bigwig_file[2] # the reverse strand file
rtracklayer::import.bw(bigwig_for_random_point, as = "NumericList",
                              which = random_point[[1]])
# 4 reads were there

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------

dt <- coveragePerTiling(random_point, bigwig_file)
dt # Position is 1, because it is relative to first

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
library(ORFik)
organism <- "Saccharomyces cerevisiae" # Baker's yeast
# This is where you should usually store you annotation references ->
#output_dir <- file.path(ORFik::config()["ref"], gsub(" ", "_", organism))
output_dir <- tempdir()
annotation <- getGenomeAndAnnotation(
                    organism = organism,
                    output.dir = output_dir,
                    assembly_type = "toplevel"
                    )
genome <- annotation["genome"]
gtf <- annotation["gtf"]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Index fasta genome
indexFa(genome)
# Make TxDb object for large speedup:
txdb <- makeTxdbFromGenome(gtf, genome, organism, optimize = TRUE, return = TRUE)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Access a FaFile
fa <- findFa(genome)
# Get chromosome information
seqinfo(findFa(genome))
# Load a 10 first bases from chromosome 1
txSeqsFromFa(GRangesList(GRanges("I", 1:10, "+")), fa, TRUE)
# Load a 10 first bases from chromosome 1 and 2.
txSeqsFromFa(GRangesList(GRanges("I", 1:10, "+"), GRanges("II", 1:10, "+")), fa, TRUE)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  txdb_path <- paste0(gtf, ".db")
  txdb <- loadTxdb(txdb_path)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  loadRegion(txdb, "tx")[1]
  loadRegion(txdb, "mrna")[1]
  loadRegion(txdb, "leaders")[1]
  loadRegion(txdb, "cds")[1]
  loadRegion(txdb, "trailers")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  tx_to_keep <- filterTranscripts(txdb, minFiveUTR = 1, minCDS = 150, minThreeUTR = 0)
  loadRegion(txdb, "mrna", names.keep = tx_to_keep)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
#   # This fails!
#   filterTranscripts(txdb, minFiveUTR = 10, minCDS = 150, minThreeUTR = 0)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  txdb <- makeTxdbFromGenome(gtf, genome, organism, optimize = TRUE, return = TRUE, 
                             pseudo_5UTRS_if_needed = 100)
  filterTranscripts(txdb, minFiveUTR = 10, minCDS = 150, minThreeUTR = 0)[1:3]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  filterTranscripts(txdb, minFiveUTR = 0, minCDS = 1, minThreeUTR = 0, 
                    longestPerGene = TRUE)[1:3]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  findUORFs_exp(txdb, findFa(genome), startCodon = "ATG|CTG", save_optimized = TRUE)
  loadRegion(txdb, "uorfs") # For later use, output like this

