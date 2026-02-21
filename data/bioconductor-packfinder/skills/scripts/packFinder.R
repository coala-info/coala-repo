# Code example from 'packFinder' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
BiocStyle::markdown()

library(packFinder)

dir.create("tempOutput")

## ----packFinderInstall, eval=FALSE--------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version='devel')
# 
# BiocManager::install("packFinder")

## ----biostrings---------------------------------------------------------------
# Convert a character vector to a DNAString
Biostrings::DNAString("CATG")

# Convert a list of character vectors to a DNAStringSet
Biostrings::DNAStringSet(c(
    "CATG",
    "GTAC"
))

# Convert a FASTA file to a DNAStringSet
Biostrings::readDNAStringSet(
    system.file("extdata", "packMatches.fasta", package = "packFinder"),
    format = "fasta"
)

## ----packSearch---------------------------------------------------------------
data("arabidopsisThalianaRefseq")

packMatches <- packSearch(
    Biostrings::DNAString("CACTACAA"),
    arabidopsisThalianaRefseq,
    elementLength = c(300, 3500),
    tsdLength = 3
)

head(packMatches)

## ----packClustData, include=FALSE---------------------------------------------
# We don't have the dependencies for clustering, so get pre-clustered results
data(packMatches)

## ----packClust, eval=FALSE----------------------------------------------------
# packMatches <- packClust(
#     packMatches,
#     arabidopsisThalianaRefseq,
#     saveFolder = "tempOutput"
# )

## ----readClust----------------------------------------------------------------
readUc(system.file(
    "extdata",
    "packMatches.uc",
    package = "packFinder"
))

readBlast(system.file(
    "extdata",
    "packMatches.blast6out",
    package = "packFinder"
))

## ----tirClust-----------------------------------------------------------------
consensusSeqs <- tirClust(packMatches,
    arabidopsisThalianaRefseq,
    tirLength = 25
)

head(consensusSeqs)

## ----align, eval=FALSE--------------------------------------------------------
# packMatches <- packAlign(
#     packMatches,
#     arabidopsisThalianaRefseq,
#     saveFolder = "tempOutput"
# )

## ----blast--------------------------------------------------------------------
# the packMatches dataframe is exported as a FASTA file for NCBI blast search
packsToFasta(
    packMatches,
    "tempOutput/packMatches.fasta",
    arabidopsisThalianaRefseq
)

## ----csvConvert---------------------------------------------------------------
packsToCsv(packMatches, "tempOutput/packMatches.csv")
print(getPacksFromCsv("tempOutput/packMatches.csv"))

## ----grangesConvert-----------------------------------------------------------
packsGRanges <- packsToGRanges(packMatches)
print(packsGRanges)

print(getPacksFromGRanges(packsGRanges))

## ----fastaConvert-------------------------------------------------------------
packsToFasta(
    packMatches,
    "tempOutput/packMatches.fasta",
    arabidopsisThalianaRefseq
)

print(getPacksFromFasta("tempOutput/packMatches.fasta"))

## ----identifyTirMatches-------------------------------------------------------
forwardMatches <- identifyTirMatches(
    Biostrings::DNAString("CACTACAA"),
    arabidopsisThalianaRefseq,
    strand = "+",
    tsdLength = 3
)
nrow(forwardMatches)

reverseMatches <- identifyTirMatches(
    Biostrings::reverseComplement(Biostrings::DNAString("CACTACAA")),
    arabidopsisThalianaRefseq,
    strand = "-",
    tsdLength = 3
)
nrow(reverseMatches)

## ----getTsds------------------------------------------------------------------
forwardMatches$TSD <- getTsds(
    forwardMatches,
    arabidopsisThalianaRefseq,
    3,
    strand = "+"
)

head(forwardMatches)

reverseMatches$TSD <- getTsds(
    reverseMatches,
    arabidopsisThalianaRefseq,
    3,
    strand = "-"
)

head(reverseMatches)

## ----identifyPotentialPackElements--------------------------------------------
identifyPotentialPackElements(
    forwardMatches,
    reverseMatches,
    arabidopsisThalianaRefseq,
    c(300, 3500)
)

## ----getPackSeqs--------------------------------------------------------------
getPackSeqs(packMatches, arabidopsisThalianaRefseq)

## ----SessionInfo--------------------------------------------------------------
sessionInfo()

## ----include=FALSE------------------------------------------------------------
unlink("tempOutput", recursive = TRUE)

