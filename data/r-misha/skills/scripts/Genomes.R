# Code example from 'Genomes' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(misha)

## ----eval = FALSE-------------------------------------------------------------
# gdb.create_genome("hg19") # creates a database for the hg19 genome
# gdb.create_genome("hg38") # creates a database for the hg38 genome
# gdb.create_genome("mm10") # creates a database for the mm10 genome
# gdb.create_genome("mm9") # creates a database for the mm9 genome
# gdb.create_genome("mm39") # creates a database for the mm39 genome

## ----eval = FALSE-------------------------------------------------------------
# ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/hg19"
# gdb.create(
#     "hg19",
#     paste(ftp, "chromosomes", paste0("chr", c(1:22, "X", "Y", "M"), ".fa.gz"), sep = "/"),
#     paste(ftp, "database/knownGene.txt.gz", sep = "/"),
#     paste(ftp, "database/kgXref.txt.gz", sep = "/"),
#     c(
#         "kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
#         "refseq", "protAcc", "description", "rfamAcc",
#         "tRnaName"
#     )
# )
# gdb.init("hg19")

## ----eval = FALSE-------------------------------------------------------------
# ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/hg38"
# gdb.create(
#     "hg38",
#     paste(ftp, "chromosomes", paste0("chr", c(1:22, "X", "Y", "M"), ".fa.gz"), sep = "/"),
#     paste(ftp, "database/knownGene.txt.gz", sep = "/"),
#     paste(ftp, "database/kgXref.txt.gz", sep = "/"),
#     c(
#         "kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
#         "refseq", "protAcc", "description", "rfamAcc",
#         "tRnaName"
#     )
# )
# gdb.init("hg38")

## ----eval = FALSE-------------------------------------------------------------
# ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/mm9"
# gdb.create(
#     "mm9",
#     paste(ftp, "chromosomes", paste0("chr", c(1:19, "X", "Y", "M"), ".fa.gz"), sep = "/"),
#     paste(ftp, "database/knownGene.txt.gz", sep = "/"),
#     paste(ftp, "database/kgXref.txt.gz", sep = "/"),
#     c(
#         "kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
#         "refseq", "protAcc", "description"
#     )
# )
# gdb.init("mm9")

## ----eval = FALSE-------------------------------------------------------------
# ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/mm10"
# gdb.create(
#     "mm10",
#     paste(ftp, "chromosomes", paste0("chr", c(1:19, "X", "Y", "M"), ".fa.gz"), sep = "/"),
#     paste(ftp, "database/knownGene.txt.gz", sep = "/"),
#     paste(ftp, "database/kgXref.txt.gz", sep = "/"),
#     c(
#         "kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
#         "refseq", "protAcc", "description", "rfamAcc",
#         "tRnaName"
#     )
# )
# gdb.init("mm10")

## ----eval = FALSE-------------------------------------------------------------
# ftp <- "ftp://hgdownload.soe.ucsc.edu/goldenPath/mm39"
# gdb.create(
#     "mm39",
#     paste(ftp, "chromosomes", paste0("chr", c(1:19, "X", "Y", "M"), ".fa.gz"), sep = "/"),
#     paste(ftp, "database/knownGene.txt.gz", sep = "/"),
#     paste(ftp, "database/kgXref.txt.gz", sep = "/"),
#     c(
#         "kgID", "mRNA", "spID", "spDisplayID", "geneSymbol",
#         "refseq", "protAcc", "description", "rfamAcc",
#         "tRnaName"
#     )
# )
# gdb.init("mm39")

