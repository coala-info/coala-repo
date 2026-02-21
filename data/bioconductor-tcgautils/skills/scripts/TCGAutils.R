# Code example from 'TCGAutils' vignette. See references/ for full tutorial.

## ----include=FALSE,results="hide",message=FALSE,warning=FALSE-----------------
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("TCGAutils")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(TCGAutils)
library(curatedTCGAData)
library(MultiAssayExperiment)
library(RTCGAToolbox)
library(rtracklayer)
library(R.utils)
library(GenomeInfoDb)

## -----------------------------------------------------------------------------
curatedTCGAData("COAD", "*", dry.run = TRUE, version = "1.1.38")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
coad <- curatedTCGAData(
    diseaseCode = "COAD", assays = c("CNASeq", "Mutation", "miRNA*",
    "RNASeq2*", "mRNAArray", "Methyl*"), version = "1.1.38", dry.run = FALSE
)

## -----------------------------------------------------------------------------
sampleTables(coad)

## -----------------------------------------------------------------------------
data("sampleTypes")
head(sampleTypes)

## -----------------------------------------------------------------------------
(tnmae <- TCGAsplitAssays(coad, c("01", "11")))

## -----------------------------------------------------------------------------
(matchmae <- as(tnmae[, , c(4, 6, 7)], "MatchedAssayExperiment"))

## -----------------------------------------------------------------------------
getSubtypeMap(coad)

## -----------------------------------------------------------------------------
getClinicalNames("COAD")

## -----------------------------------------------------------------------------
class(colData(coad)[["vital_status.x"]])
class(colData(coad)[["vital_status.y"]])

table(colData(coad)[["vital_status.x"]])
table(colData(coad)[["vital_status.y"]])

## -----------------------------------------------------------------------------
methcoad <- CpGtoRanges(coad)

## -----------------------------------------------------------------------------
rag <- "COAD_Mutation-20160128"
# add the appropriate genome annotation
genome(coad[[rag]]) <- "NCBI36"
# change the style to UCSC
seqlevelsStyle(rowRanges(coad[[rag]])) <- "UCSC"

# inspect changes
seqlevels(rowRanges(coad[[rag]]))
genome(coad[[rag]])

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(AnnotationHub)
ah <- AnnotationHub()

## -----------------------------------------------------------------------------
query(ah, "hg18ToHg19.over.chain.gz")
chain <- ah[["AH14220"]]
ranges19 <- rtracklayer::liftOver(rowRanges(coad[[rag]]), chain)

## -----------------------------------------------------------------------------
re19 <- coad[[rag]][as.logical(lengths(ranges19))]
ranges19 <- unlist(ranges19)
genome(ranges19) <- "hg19"
rowRanges(re19) <- ranges19
# replacement
coad[["COAD_Mutation-20160128"]] <- re19
rowRanges(re19)

## -----------------------------------------------------------------------------
coad <- qreduceTCGA(coad, keep.assay = TRUE)

## -----------------------------------------------------------------------------
symbolsToRanges(coad)

## -----------------------------------------------------------------------------
## Load example file found in package
pkgDir <- system.file("extdata", package = "TCGAutils", mustWork = TRUE)
exonFile <- list.files(pkgDir, pattern = "cation\\.txt$", full.names = TRUE)
exonFile

## We add the original file prefix to query for the UUID and get the
## TCGAbarcode
filePrefix <- "unc.edu.32741f9a-9fec-441f-96b4-e504e62c5362.1755371."

## Add actual file name manually
makeGRangesListFromExonFiles(exonFile, getBarcodes = FALSE,
    fileNames = paste0(filePrefix, basename(exonFile)))

## -----------------------------------------------------------------------------
grlFile <- system.file("extdata", "blca_cnaseq.txt", package = "TCGAutils")
grl <- read.table(grlFile)
head(grl)

makeGRangesListFromCopyNumber(grl, split.field = "Sample")

makeGRangesListFromCopyNumber(grl, split.field = "Sample",
    keep.extra.columns = TRUE)

## -----------------------------------------------------------------------------
tempDIR <- tempdir()
co <- getFirehoseData("COAD", clinical = FALSE, GISTIC = TRUE,
    destdir = tempDIR)

selectType(co, "GISTIC")
class(selectType(co, "GISTIC"))

makeSummarizedExperimentFromGISTIC(co, "Peaks")

## -----------------------------------------------------------------------------
race_df <- DataFrame(race_f = factor(colData(coad)[["race"]]),
    row.names = rownames(colData(coad)))
mergeColData(coad, race_df)

## -----------------------------------------------------------------------------
UUIDhistory("0001801b-54b0-4551-8d7a-d66fb59429bf")

## -----------------------------------------------------------------------------
(xbarcode <- head(colnames(coad)[["COAD_CNASeq-20160128_simplified"]], 4L))
barcodeToUUID(xbarcode)

## -----------------------------------------------------------------------------
UUIDtoBarcode("ae55b2d3-62a1-419e-9f9a-5ddfac356db4", from_type = "case_id")

## -----------------------------------------------------------------------------
UUIDtoBarcode("b4bce3ff-7fdc-4849-880b-56f2b348ceac", from_type = "file_id")

## -----------------------------------------------------------------------------
UUIDtoBarcode("d85d8a17-8aea-49d3-8a03-8f13141c163b", from_type = "aliquot_ids")

## -----------------------------------------------------------------------------
head(UUIDtoUUID("ae55b2d3-62a1-419e-9f9a-5ddfac356db4", to_type = "file_id"))

## -----------------------------------------------------------------------------
## Return participant barcodes
TCGAbarcode(xbarcode, participant = TRUE)

## Just return samples
TCGAbarcode(xbarcode, participant = FALSE, sample = TRUE)

## Include sample data as well
TCGAbarcode(xbarcode, participant = TRUE, sample = TRUE)

## Include portion and analyte data
TCGAbarcode(xbarcode, participant = TRUE, sample = TRUE, portion = TRUE)

## -----------------------------------------------------------------------------
## Select primary solid tumors
TCGAsampleSelect(xbarcode, "01")

## Select blood derived normals
TCGAsampleSelect(xbarcode, "10")

## -----------------------------------------------------------------------------
TCGAprimaryTumors(coad)

## -----------------------------------------------------------------------------
TCGAbiospec(xbarcode)

## -----------------------------------------------------------------------------
oncoPrintTCGA(coad, matchassay = rag)

## -----------------------------------------------------------------------------
## Obtained previously
sampleCodes <- TCGAbarcode(xbarcode, participant = FALSE, sample = TRUE)

## Lookup table
head(sampleTypes)

## Match codes found in the barcode to the lookup table
sampleTypes[match(unique(substr(sampleCodes, 1L, 2L)), sampleTypes[["Code"]]), ]

## -----------------------------------------------------------------------------
data("clinicalNames")

clinicalNames

lengths(clinicalNames)

## -----------------------------------------------------------------------------
sessionInfo()

