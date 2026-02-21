# Code example from 'blast' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library("rBLAST")

## ----include = FALSE----------------------------------------------------------
# only run code if blast+ is installed
run <- has_blast()

## ----echo = FALSE, eval = !run, results='asis'--------------------------------
cat("**Note: BLAST was not installed when this vignette was built. Some output is not available in this vignette!**")

## ----eval=run-----------------------------------------------------------------
# Sys.which("blastn")

## ----eval=run-----------------------------------------------------------------
# Sys.setenv(PATH = paste(Sys.getenv("PATH"),
#    "path_to_your_BLAST_installation", sep=.Platform$path.sep))

## ----eval=run-----------------------------------------------------------------
# ## download the 16S Microbial rRNA data base from NCBI
# tgz_file <- blast_db_get("16S_ribosomal_RNA.tar.gz")
# untar(tgz_file, exdir = "16S_rRNA_DB")

## ----eval=run-----------------------------------------------------------------
# list.files("./16S_rRNA_DB/")

## ----eval=run-----------------------------------------------------------------
# bl <- blast(db = "./16S_rRNA_DB/16S_ribosomal_RNA")
# bl

## ----eval=run-----------------------------------------------------------------
# seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
#     package = "rBLAST"
# ))[1]
# seq
# 
# cl <- predict(bl, seq)
# nrow(cl)
# cl[1:5, ]

## ----eval=run-----------------------------------------------------------------
# fmt <- paste(
#     "qaccver saccver pident length mismatch gapopen qstart qend",
#     "sstart send evalue bitscore qseq sseq"
# )
# cl <- predict(bl, seq,
#     BLAST_args = "-perc_identity 99",
#     custom_format = fmt
# )
# cl

## ----include = FALSE, eval=run------------------------------------------------
# ## clean up
# unlink("16S_rRNA_DB", recursive = TRUE)

## -----------------------------------------------------------------------------
seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
    package = "rBLAST"
))
seq

## -----------------------------------------------------------------------------
writeXStringSet(seq, filepath = "seqs.fasta")

## ----eval=run-----------------------------------------------------------------
# makeblastdb("seqs.fasta", db_name = "db/small", dbtype = "nucl")

## ----eval=run-----------------------------------------------------------------
# db <- blast("db/small")
# db

## ----eval=run-----------------------------------------------------------------
# fragment <- subseq(seq[1], start = 101, end = 200)
# fragment
# 
# predict(db, fragment)

## -----------------------------------------------------------------------------
unlink("seqs.fasta")
unlink("db", recursive = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

