# Code example from 'UsingAssessORF' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("AssessORF")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("AssessORFData")

## ----error = FALSE, warning = FALSE, message = FALSE--------------------------
library(DECIPHER)

## Path to the SQL database file (will be created if necessary)
## In this example, a temporary file will be used, but it is recommended that
## the user specify a file path they prefer to use as the location of the 
## database instead.
databaseFile <- tempfile()
## Here is what the alternate option would like:
# databaseFile <- "<insert file path to database here>"

## Path to the file containing the links to the related genomes
## In this example, the file comes from NCBI's genome browser site and is in
## CSV format. If the user is also using a CSV file downloaded from NCBI's
## genome browser site as the source for the related genomes links, the user
## can replace the 'system.file' function call below with  the path to their
## CSV file instead. The rest of this example assumes that the links are
## provided in this format. For help on adding genome sequences provided in
## other formats to a database, consult DECIPHER's manual and vignettes.
relGenomesFile <- system.file("extdata",
                           "AdenoviridaeGenomes.csv",
                           package = "AssessORF")
## Here is what the alternate option would like:
# relGenomesFile <- "<insert path to CSV file here>"

## Extract the FTP links from the CSV file and make sure they are in the right
## format so they can be downloaded from the NCBI server. In order to minimize
## the time spent running the example, only the first 13 rows of the table are
## used. The user should drop the '[1:13, ]' part if they plan on using this
## example as a starting point for putting sequences into a database.
genomesTable <- read.csv(relGenomesFile, stringsAsFactors = FALSE)[1:13, ]
ftps <- genomesTable$GenBank.FTP
ftps <- paste(ftps, paste0(basename(ftps), "_genomic.fna.gz"), sep="/")
ftps <- ftps[(substring(ftps, 1, 6) == "ftp://")]

## In this example, the first genome in the table is the central genome.
## In most user scenarios however, the path to the central genome will not be in
## the related genomes file. The user should instead specify the path to the
## file containing the sequence of the central genome (in FASTA format) and 
## append that file path to the start of the vector containing the FTP links.
## Here is what that would look like:
# genomeFile <- "<insert file path to genome here>"
# ftps <- c(genomeFile, ftps)

## This vector will hold which genomes were succesfully added to the database.
pass <- logical(length(ftps))

## Add the sequences to the database.
## The loop can cause timeout errors if there is no internet connection
## when the package is built so it has been commented out so the example
## runs smoothly. Users should uncomment this loop when adapting the
## example for their own use.
# for (pIdx in seq_along(pass)) {
#   t <- try(Seqs2DB(ftps[pIdx], "FASTA", databaseFile, as.character(pIdx),
#                    compressRepeats=TRUE, verbose=FALSE),
#            silent=TRUE)
#   
#   if (!(is(t, "try-error"))) {
#     pass[pIdx] <- TRUE
#   }
# }

## This vector contains the list of identifers for the genomes in the database,
## based on which ones were successfully added. Identifers are character
## strings. The first one, identifier "1", corresponds to the central genome.
## The remaining identifers, in this case "2":"13", correspond to the related
## genomes.
identifiers <- as.character(which(pass))

## ----echo = FALSE-------------------------------------------------------------
## If some (or all) of the genome sequences were not added to the database,
## copy over the database file within the package and use it as the database
## for the vignette examples instead. Next, fix 'identifiers' appropriately.
if (length(identifiers) < length(pass)) {
  file.copy(system.file("extdata", "Adenoviridae.sqlite", package = "AssessORF"),
            databaseFile,
            overwrite = TRUE)
  
  identifiers <- as.character(seq_along(pass))
}

## ----results = FALSE----------------------------------------------------------
library(AssessORF)

## Reminder: the first identifier in the database, in this case identifier "1",
## corresponds to the central genome. The remaining identifers, in this case
## "2":"13", correspond to the related genomes.
myMapObj <- MapAssessmentData(databaseFile,
                              central_ID = identifiers[1],
                              related_IDs = identifiers[-1],
                              speciesName = "Human adenovirus 1",
                              useProt = FALSE)

## -----------------------------------------------------------------------------
## Remember to use 'unlink' to remove a database once it is no longer needed.
unlink(databaseFile)

## ----eval = FALSE-------------------------------------------------------------
# myMapObj <- MapAssessmentData(databaseFile, ## File path to the SQL database containing the genomes
#                               central_ID = identifiers[1], ## Identifier for the central genome
#                               related_IDs = identifiers[-1], ## Identifers for the related genomes
#                               protHits_Seqs = protSeqs, ## Sequences for the proteomics hits
#                               protHits_Scores = protScores, ## Confidence scores for the proteomics hits
#                               strainID = strain, ## The identifer for the strain
#                               speciesName = species) ## The name of the species

## ----results = FALSE----------------------------------------------------------
currMapObj <- readRDS(system.file("extdata",
                                  "MGAS5005_PreSaved_DataMapObj.rds",
                                  package = "AssessORF"))

currProdigal <- readLines(system.file("extdata",
                                      "MGAS5005_Prodigal.sco",
                                      package = "AssessORF"))[-1:-2]

prodigalLeft <- as.numeric(sapply(strsplit(currProdigal, "_", fixed=TRUE), `[`, 2L))
prodigalRight <- as.numeric(sapply(strsplit(currProdigal, "_", fixed=TRUE), `[`, 3L))
prodigalStrand <- sapply(strsplit(currProdigal, "_", fixed=TRUE), `[`, 4L)

currResObj <- AssessGenes(geneLeftPos = prodigalLeft,
                          geneRightPos = prodigalRight,
                          geneStrand = prodigalStrand,
                          inputMapObj = currMapObj,
                          geneSource = "Prodigal")

## -----------------------------------------------------------------------------
print(currResObj)

## ----fig.height=7, fig.width=7, fig.align="center"----------------------------
plot(currResObj)

## ----fig.height=15, fig.width=15, fig.align="center"--------------------------
plot(currMapObj, currResObj, interactive_GV = FALSE,
     rangeStart_GV = 106000, rangeEnd_GV = 120000)

## ----fig.height=15, fig.width=15, fig.align="center"--------------------------
mosaicplot(currResObj)

## -----------------------------------------------------------------------------
resObj2 <- readRDS(system.file("extdata",
                                  "MGAS5005_PreSaved_ResultsObj_GeneMarkS2.rds",
                                  package = "AssessORF"))

CompareAssessmentResults(currResObj, resObj2)

## ----echo = FALSE-------------------------------------------------------------
print(sessionInfo(), locale = FALSE)

