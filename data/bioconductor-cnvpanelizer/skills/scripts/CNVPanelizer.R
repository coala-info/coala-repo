# Code example from 'CNVPanelizer' vignette. See references/ for full tutorial.

## ----InstallingPackage, echo=TRUE, eval=FALSE, message=FALSE------------------
# # To install from Bioconductor
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("CNVPanelizer")

## ----LoadingPackage, echo=TRUE, message=FALSE, warning = FALSE----------------
# To load the package
library(CNVPanelizer)

## ----LoadingBED, echo=TRUE, eval=FALSE----------------------------------------
# 
# # Bed file defining the amplicons
# bedFilepath <- "/somePath/someFile.bed"
# 
# # The column number of the gene Names in the BED file.
# amplColumnNumber <- 4
# 
# # Extract the information from a bed file
# genomicRangesFromBed <- BedToGenomicRanges(bedFilepath,
#                                            ampliconColumn = amplColumnNumber,
#                                            split = "_")
# 
# metadataFromGenomicRanges <- elementMetadata(genomicRangesFromBed)
# geneNames = metadataFromGenomicRanges["geneNames"][, 1]
# ampliconNames = metadataFromGenomicRanges["ampliconNames"][, 1]

## ----LoadingPathsAndFilenames, echo = TRUE, eval=FALSE------------------------
# 
# # Directory with the test data
# sampleDirectory <- "/somePathToTestData"
# 
# # Directory with the reference data
# referenceDirectory <- "/somePathToReferenceData"
# 
# # Vector with test filenames
# sampleFilenames <- list.files(path = sampleDirectory,
#                               pattern = ".bam$",
#                               full.names = TRUE)
# 
# # Vector with reference filenames
# referenceFilenames <- list.files(path = referenceDirectory,
#                                  pattern = ".bam$",
#                                  full.names = TRUE)

## ----LoadingReadCountsData, echo = TRUE, eval=FALSE---------------------------
# 
# # Should duplicated reads (same start, end site and strand) be removed
# removePcrDuplicates <- FALSE # TRUE is only recommended for Ion Torrent data
# 
# # Read the Reference data set
# referenceReadCounts <- ReadCountsFromBam(referenceFilenames,
#                                          genomicRangesFromBed,
#                                          sampleNames = referenceFilenames,
#                                          ampliconNames = ampliconNames,
#                                          removeDup = removePcrDuplicates)
# 
# # Read the sample of interest data set
# sampleReadCounts <- ReadCountsFromBam(sampleFilenames,
#                                       genomicRangesFromBed,
#                                       sampleNames = sampleFilenames,
#                                       ampliconNames = ampliconNames,
#                                       removeDup = removePcrDuplicates)

## ----LoadingSyntheticData, echo = TRUE----------------------------------------
data(sampleReadCounts)
data(referenceReadCounts)

# Gene names should be same size as row columns
# For real data this is a vector of the genes associated
# with each row/amplicon. For example Gene1, Gene1, Gene2, Gene2, Gene3, ...
geneNames <- row.names(referenceReadCounts)

# Not defined for synthetic data
# For real data this gives a unique name to each amplicon.
# For example Gene1:Amplicon1, Gene1:Amplicon2, Gene2:Amplicon1,
# Gene2:Amplicon2, Gene3:Amplicon1 ...
ampliconNames <- NULL


## ----NormalizedReadCounts, echo = TRUE----------------------------------------

normalizedReadCounts <- CombinedNormalizedCounts(sampleReadCounts,
                                                 referenceReadCounts,
                                                 ampliconNames = ampliconNames)

# After normalization data sets need to be splitted again to perform bootstrap
samplesNormalizedReadCounts = normalizedReadCounts["samples"][[1]]
referenceNormalizedReadCounts = normalizedReadCounts["reference"][[1]]


## ----NumberOfReplicates, echo = TRUE,message=FALSE,warning=FALSE--------------

# Number of bootstrap replicates to be used
replicates <- 10000

## ----RealNumberOfReplicatesToBeUsed, echo = FALSE-----------------------------
# To speed up vignette generation while debugging
#replicates <- 10

## ----BootList, echo = TRUE,message=FALSE,warning=FALSE------------------------

# Perform the bootstrap based analysis
bootList <- BootList(geneNames,
                     samplesNormalizedReadCounts,
                     referenceNormalizedReadCounts,
                     replicates = replicates)

## ----BackgroundNoise, echo = TRUE, message=FALSE, warning=FALSE---------------

# Estimate the background noise left after normalization
backgroundNoise <- Background(geneNames,
                              samplesNormalizedReadCounts,
                              referenceNormalizedReadCounts,
                              bootList,
                              replicates = replicates,
                              significanceLevel = 0.1,
                              robust = TRUE)

## ----ReportTables, echo=TRUE, message=FALSE, warning=FALSE--------------------
# Build report tables
reportTables <- ReportTables(geneNames,
                             samplesNormalizedReadCounts,
                             referenceNormalizedReadCounts,
                             bootList,
                             backgroundNoise)

## ----ReportTablesToShow, echo=FALSE, message=FALSE, warning=FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
options(width=500)  # to show the entire table..
# to avoid have to print to other page..
numberOfGenesViewport = 20

#if (nrow(reportTables[[1]]) > numberOfGenes) {
#  numberOfGenes = numberOfGenesViewport
#} else {
#  numberOfGenes = nrow(reportTables[[1]])
#}
#reportTables[[1]][1:numberOfGenes, ]

# index of the sample to show
sampleIndexToShow = 2

# TODO improve this.. remove the column..
# but for now just hide "Signif." column... no space available
#indexToHide <- which(colnames(reportTables[[1]])=="Signif.")
#indexToHide <- which(colnames(reportTables[[1]])=="MeanRatio")
indexToHide <- which(colnames(reportTables[[1]]) %in% c("MeanRatio", "Passed"))

reportTables[[sampleIndexToShow]][1:numberOfGenesViewport, -c(indexToHide)]
#reportTables[[sampleIndexToShow]][1:numberOfGenesViewport, ]

## ----HelperFunctions, echo = FALSE, message=FALSE, warning=FALSE, eval=FALSE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 
# # Directory where the generated files with the analysis results will be saved.
# outputDirectory <- "./tmp"
# dir.create(outputDirectory, recursive = TRUE)
# 
# # Export the report tables to excel format
# reportTablesFilepath <- file.path(outputDirectory, "report_tables.xlsx")
# WriteListToXLSX(reportTables, reportTablesFilepath)
# 
# # # Export read counts to excel format
# readCountsFilepath <- file.path(outputDirectory, "readCounts.xlsx")
# normalizedReadCountsFilepath <- file.path(outputDirectory,
#                                           "normalizedReadCounts.xlsx")
# WriteListToXLSX(list(samplesReadCount = sampleReadCounts,
#                      referenceReadCounts = referenceNormalizedReadCounts),
#                 readCountsFilepath)
# WriteListToXLSX(list(samplesReadCount = samplesNormalizedReadCounts,
#                      referenceReadCounts = referenceNormalizedReadCounts),
#                 normalizedReadCountsFilepath)
# 
# justToHide = PlotBootstrapDistributions(bootList, reportTables, outputFolder=outputDirectory, save=TRUE)
# 
# save.image(file = file.path(outputDirectory, "RSession.Rdata"))
# 

## ----JustToShowBootPlot, echo = TRUE, eval=FALSE, message=FALSE, warning=FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# PlotBootstrapDistributions(bootList, reportTables)

## ----RunCNVPanelizerShiny, echo = TRUE, eval=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# # default port is 8100
# RunCNVPanelizerShiny(port = 8080)

## ----BootstrapPlot, echo=F, fig.align='center', fig.cap='Plot for a single test sample', fig.height=4, fig.width=10, message=FALSE, warning=FALSE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PlotBootstrapDistributions(bootList, reportTables)[[sampleIndexToShow]]

