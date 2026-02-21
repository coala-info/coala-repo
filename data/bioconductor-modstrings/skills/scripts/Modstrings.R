# Code example from 'Modstrings' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(Modstrings)
  library(GenomicRanges)
})

## ----eval=FALSE---------------------------------------------------------------
# library(Modstrings)
# library(GenomicRanges)

## ----object_creation2---------------------------------------------------------
r <- RNAString("ACGUG")
mr2 <- modifyNucleotides(r,5L,"m7G")
mr2
mr3 <- modifyNucleotides(r,5L,"7G",nc.type = "nc")
mr3

## ----object_creation3---------------------------------------------------------
mr4 <- ModRNAString(paste0("ACGU",alphabet(ModRNAString())[33L]))
mr4

## ----object_creation4---------------------------------------------------------
gr <- GRanges("1:5", mod = "m7G")
mr5 <- combineIntoModstrings(r, gr)
mr5

## ----object_creation5---------------------------------------------------------
rs <- RNAStringSet(list(r,r,r,r,r))
names(rs) <- paste0("Sequence", seq_along(rs))
gr2 <- GRanges(seqnames = names(rs)[c(1L,1L,2L,3L,3L,4L,5L,5L)],
               ranges = IRanges(start = c(4L,5L,5L,4L,5L,5L,4L,5L),
                                width = 1L),
               mod = c("D","m7G","m7G","D","m7G","m7G","D","m7G"))
gr2
mrs <- combineIntoModstrings(rs, gr2)
mrs

## ----object_separation--------------------------------------------------------
gr3 <- separate(mrs)
rs2 <- RNAStringSet(mrs)
gr3
rs2

## ----object_comparison_teaser-------------------------------------------------
r <- RNAString("ACGUG")
mr2 <- modifyNucleotides(r,5L,"m7G")
r == RNAString(mr2)

## ----object_comparison--------------------------------------------------------
r == ModRNAString(r)
r == mr
rs == ModRNAStringSet(rs)
rs == c(mrs[1L:3L],rs[4L:5L])

## ----object_conversion--------------------------------------------------------
RNAString(mr)

## ----object_qual--------------------------------------------------------------
qmrs <- QualityScaledModRNAStringSet(mrs,
                                     PhredQuality(c("!!!!h","!!!!h","!!!!h",
                                                    "!!!!h","!!!!h")))
qmrs

## ----object_qual_sep_combine--------------------------------------------------
qgr <- separate(qmrs)
qgr
combineIntoModstrings(mrs,qgr, with.qualities = TRUE)

## ----object_io----------------------------------------------------------------
writeModStringSet(mrs, file = "test.fasta")
# note the different function name. Otherwise empty qualities will be written
writeQualityScaledModStringSet(qmrs, file = "test.fastq")
mrs2 <- readModRNAStringSet("test.fasta", format = "fasta")
mrs2
qmrs2 <- readQualityScaledModRNAStringSet("test.fastq")
qmrs2

## ----object_io_unlink, include=FALSE------------------------------------------
unlink("test.fasta")
unlink("test.fastq")

## ----object_pattern-----------------------------------------------------------
matchPattern("U7",mr)
vmatchPattern("D7",mrs)
mrl <- unlist(mrs)
matchLRPatterns("7ACGU","U7ACG",100L,mrl)

## -----------------------------------------------------------------------------
# read the lines
test <- readLines(system.file("extdata","test.fasta",package = "Modstrings"),
                      encoding = "UTF-8")
head(test,2L)
# keep every second line as sequence, the other one as name
names <- test[seq.int(from = 1L, to = 104L, by = 2L)]
seq <- test[seq.int(from = 2L, to = 104L, by = 2L)]
# sanitize input. This needs to be adapt to the individual case
names <- gsub(" ","_",
              gsub("> ","",
                   gsub(" \\| ","-",
                        names)))
seq <- gsub("-","",gsub("_","",seq))
names(seq) <- names

## -----------------------------------------------------------------------------
# sanitize special characters to Modstrings equivalent
seq <- sanitizeFromModomics(seq)
seq <- ModRNAStringSet(seq)
seq

## -----------------------------------------------------------------------------
# convert the contained modifications into a tabular format
separate(seq)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

