# Code example from 'counting' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE)

## ----echo=FALSE, results="hide"-----------------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
# Our pool of known variable sequences, one per barcode:
known <- c("AAAAAAAA", "CCCCCCCC", "GGGGGGGG", "TTTTTTTT")

# Mocking up some sequence data, where each read randomly contains 
# one of the variable sequences, flanked by constant regions. 
library(Biostrings)
chosen <- sample(known, 1000, replace=TRUE)
reads <- sprintf("GTAC%sCATG", chosen)
names(reads) <- sprintf("READ_%i", seq_along(reads))

# Writing to a FASTQ file.
single.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(reads), file=single.fq, format="fastq")

## -----------------------------------------------------------------------------
library(screenCounter)
out <- matrixOfSingleBarcodes(single.fq, 
    flank5="GTAC", flank3="CATG", choices=known)
out
assay(out)

## -----------------------------------------------------------------------------
# Our pool of known variable sequences:
known1 <- c("AAAA", "CCCC", "GGGG", "TTTT")
known2 <- c("ATTA", "CGGC", "GCCG", "TAAT")

# Mocking up some sequence data, where each read randomly contains 
# two of the variable sequences within a template structure.
library(Biostrings)
chosen1 <- sample(known1, 1000, replace=TRUE)
chosen2 <- sample(known2, 1000, replace=TRUE)
reads <- sprintf("GTAC%sCATG%sGTAC", chosen1, chosen2)
names(reads) <- sprintf("READ_%i", seq_along(reads))

# Writing to a FASTQ file.
combo.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(reads), file=combo.fq, format="fastq")

## -----------------------------------------------------------------------------
out <- matrixOfComboBarcodes(combo.fq,
    template="GTACNNNNCATGNNNNGTAC",
    choices=list(first=known1, second=known2))
out

## -----------------------------------------------------------------------------
assay(out)

## -----------------------------------------------------------------------------
rowData(out)

## -----------------------------------------------------------------------------
# Creating an example dual barcode sequencing experiment.
known.pool1 <- c("AGAGAGAGA", "CTCTCTCTC",
    "GTGTGTGTG", "CACACACAC")
known.pool2 <- c("ATATATATA", "CGCGCGCGC",
    "GAGAGAGAG", "CTCTCTCTC")

# Mocking up the barcode sequences.
N <- 1000
read1 <- sprintf("CAGCTACGTACG%sCCAGCTCGATCG",
   sample(known.pool1, N, replace=TRUE))
names(read1) <- seq_len(N)

read2 <- sprintf("TGGGCAGCGACA%sACACGAGGGTAT",
   sample(known.pool2, N, replace=TRUE))
names(read2) <- seq_len(N)

# Writing them to FASTQ files.
tmp <- tempfile()
tmp1 <- paste0(tmp, "_1.fastq")
writeXStringSet(DNAStringSet(read1), filepath=tmp1, format="fastq")
tmp2 <- paste0(tmp, "_2.fastq")
writeXStringSet(DNAStringSet(read2), filepath=tmp2, format="fastq")

## -----------------------------------------------------------------------------
choices <- expand.grid(known.pool1, known.pool2)
choices <- DataFrame(barcode1=choices[,1], barcode2=choices[,2])
choices <- choices[sample(nrow(choices), nrow(choices)*0.9),]

## -----------------------------------------------------------------------------
out <- matrixOfDualBarcodes(list(c(tmp1, tmp2)), 
    choices=choices,
    template=c("CAGCTACGTACGNNNNNNNNNCCAGCTCGATCG",
               "TGGGCAGCGACANNNNNNNNNACACGAGGGTAT"))
out

## -----------------------------------------------------------------------------
assay(out)

## -----------------------------------------------------------------------------
colData(out)

## -----------------------------------------------------------------------------
rowData(out)

## -----------------------------------------------------------------------------
# Creating an example dual barcode sequencing experiment.
known.pool1 <- c("AGAGAGAGA", "CTCTCTCTC",
    "GTGTGTGTG", "CACACACAC")
known.pool2 <- c("ATATATATA", "CGCGCGCGC",
    "GAGAGAGAG", "CTCTCTCTC")

# Mocking up the barcode sequences.
N <- 1000
read <- sprintf("CAGCTACGTACG%sCCAGCTCGATCG%sACACGAGGGTAT",
   sample(known.pool1, N, replace=TRUE),
   sample(known.pool2, N, replace=TRUE))
names(read) <- seq_len(N)

# Writing them to FASTQ files.
tmp <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(read), filepath=tmp, format="fastq")

## -----------------------------------------------------------------------------
choices <- expand.grid(known.pool1, known.pool2)
choices <- DataFrame(barcode1=choices[,1], barcode2=choices[,2])
choices <- choices[sample(nrow(choices), nrow(choices)*0.9),]

## -----------------------------------------------------------------------------
out <- matrixOfDualBarcodesSingleEnd(tmp, choices=choices,
    template="CAGCTACGTACGNNNNNNNNNCCAGCTCGATCGNNNNNNNNNACACGAGGGTAT")
out

## -----------------------------------------------------------------------------
assay(out)

## -----------------------------------------------------------------------------
colData(out)

## -----------------------------------------------------------------------------
rowData(out)

## -----------------------------------------------------------------------------
# Mocking up a 8-bp random variable region.
N <- 1000
randomized <- lapply(1:N, function(i) {
    paste(sample(c("A", "C", "G", "T"), 8, replace=TRUE), collapse="")
})
barcodes <- sprintf("CCCAGT%sGGGATAC", randomized)
names(barcodes) <- sprintf("READ_%i", seq_along(barcodes))

# Writing to a FASTQ file.
single.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(barcodes), file=single.fq, format="fastq")

## -----------------------------------------------------------------------------
library(screenCounter)
out <- matrixOfRandomBarcodes(single.fq,
    template="CCCAGTNNNNNNNNGGGATAC")
out
head(assay(out))

## -----------------------------------------------------------------------------
# Pretend that these are different samples:
all.files <- c(single.fq, single.fq, single.fq)

# Parallel execution:
library(BiocParallel)
out <- matrixOfSingleBarcodes(all.files, 
    flank5="GTAC", flank3="CATG", choices=known,
    BPPARAM=SnowParam(2))
out

## -----------------------------------------------------------------------------
sessionInfo()

