# Code example from 'consensusSeekeR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()
library(knitr)

## ----peakRegion, echo=FALSE, fig.cap = "Two ChIP-Seq peaks. A ChIP-seq peak is defined by a enriched region an a peak position."----
knitr::include_graphics('figures/peak_and_region.jpg')

## ----loadingPackage, warning=FALSE, message=FALSE-----------------------------
library(consensusSeekeR)

## ----input, echo=FALSE--------------------------------------------------------
### Load dataset
data(A549_FOSL2_01_NarrowPeaks_partial)

### Remove dataset metadata field "name"
A549_FOSL2_01_NarrowPeaks_partial$name        <- NULL
A549_FOSL2_01_NarrowPeaks_partial$score       <- NULL
A549_FOSL2_01_NarrowPeaks_partial$qValue      <- NULL
A549_FOSL2_01_NarrowPeaks_partial$pValue      <- NULL
A549_FOSL2_01_NarrowPeaks_partial$signalValue <- NULL
A549_FOSL2_01_NarrowPeaks_partial$peak        <- NULL

## ----setName, collapse=TRUE---------------------------------------------------
### Initial dataset without metadata field
head(A549_FOSL2_01_NarrowPeaks_partial, n = 3)

### Adding a new metadata field "name" unique to each entry
A549_FOSL2_01_NarrowPeaks_partial$name <- paste0("FOSL2_01_entry_", 
                                1:length(A549_FOSL2_01_NarrowPeaks_partial))

### Assign the same row name to each entry
names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01", 
                                length(A549_FOSL2_01_NarrowPeaks_partial))

### Final dataset with metadata field 'name' and row names
head(A549_FOSL2_01_NarrowPeaks_partial, n = 3)

## ----inputClean, echo=FALSE, message=FALSE------------------------------------
### Remove dataset
rm(A549_FOSL2_01_NarrowPeaks_partial)

## ----knownGenome, collapse=TRUE, eval=FALSE-----------------------------------
# ### Import library
# library(Seqinfo)
# 
# ### Get the information for Human genome version 19
# hg19Info <- Seqinfo(genome="hg19")
# 
# ### Subset the object to keep only the analyzed chromosomes
# hg19Subset <- hg19Info[c("chr1", "chr10", "chrX")]

## ----newGenome, collapse=FALSE------------------------------------------------
### Create an Seqinfo Object
chrInfo <- Seqinfo(seqnames=c("chr1", "chr2", "chr3"),
            seqlengths=c(1000, 2000, 1500), isCircular=c(FALSE, FALSE, FALSE),
            genome="BioconductorAlien")

## ----deleteChr, echo=FALSE, message=FALSE-------------------------------------
if (exists("chrInfo", inherits = FALSE)) rm(chrInfo)
if (exists("hg19Subset", inherits = FALSE)) rm(hg19Subset)
if (exists("hg19Info", inherits = FALSE)) rm(hg19Info)

## ----rtracklayer, collapse=TRUE-----------------------------------------------
### Load the needed packages
library(rtracklayer)
library(GenomicRanges)

### Demo file contained within the consensusSeekeR package
file_narrowPeak <- system.file("extdata",
        "A549_FOSL2_ENCSR000BQO_MZW_part_chr_1_and_12.narrowPeak", package = "consensusSeekeR")

### Information about the extra columns present in the file need
### to be specified
extraCols <- c(signalValue = "numeric", pValue = "numeric", qValue = "numeric", peak = "integer")

### Create genomic ranges for the regions
regions <- import(file_narrowPeak, format = "BED", extraCols = extraCols)

### Create genomic ranges for the peaks
peaks           <-  regions
ranges(peaks)   <-  IRanges(start = (start(regions) + regions$peak), width = rep(1, length(regions$peak)))

### First rows of each GRanges object
head(regions, n = 2)
head(peaks, n = 2)

## ----secretRM, echo=FALSE, collapse=TRUE--------------------------------------
rm(peaks)
rm(regions)

## ----readNarrowPeak_1, collapse=TRUE------------------------------------------
library(consensusSeekeR)

### Demo file contained within the consensusSeekeR package
file_narrowPeak <- system.file("extdata",
    "A549_FOSL2_ENCSR000BQO_MZW_part_chr_1_and_12.narrowPeak", package = "consensusSeekeR")

### Create genomic ranges for both the regions and the peaks
result <- readNarrowPeakFile(file_narrowPeak, extractRegions = TRUE, extractPeaks = TRUE)

### First rows of each GRanges object
head(result$narrowPeak, n = 2)
head(result$peak, n = 2)

## ----secretRM_02, echo=FALSE, collapse=TRUE-----------------------------------
rm(result)

## ----libraryLoadNucl, warning=FALSE, message=FALSE----------------------------
library(consensusSeekeR)

## ----loadingDatasetsNucl------------------------------------------------------
### Loading dataset from NOrMAL
data(NOrMAL_nucleosome_positions) ; data(NOrMAL_nucleosome_ranges)

### Loading dataset from PING
data(PING_nucleosome_positions) ; data(PING_nucleosome_ranges)

### Loading dataset from NucPosSimulator
data(NucPosSimulator_nucleosome_positions) ; data(NucPosSimulator_nucleosome_ranges)

## ----prepareData, echo=FALSE--------------------------------------------------
rownames(NOrMAL_nucleosome_positions) <- NULL
rownames(NOrMAL_nucleosome_ranges)    <- NULL

## ----datasetNuc, collapse=TRUE------------------------------------------------
### Each entry in the positions dataset has an equivalent metadata 
### "name" entry in the ranges dataset
head(NOrMAL_nucleosome_positions, n = 2)

head(NOrMAL_nucleosome_ranges, n = 2)

## ----nuclAssignment, collapse=TRUE--------------------------------------------
### Assigning software name "NOrMAL" 
names(NOrMAL_nucleosome_positions) <- rep("NOrMAL", length(NOrMAL_nucleosome_positions))
names(NOrMAL_nucleosome_ranges) <- rep("NOrMAL", length(NOrMAL_nucleosome_ranges))

### Assigning experiment name "PING"
names(PING_nucleosome_positions) <- rep("PING", length(PING_nucleosome_positions))
names(PING_nucleosome_ranges) <- rep("PING", length(PING_nucleosome_ranges))

### Assigning experiment name "NucPosSimulator"
names(NucPosSimulator_nucleosome_positions) <- rep("NucPosSimulator", 
                                length(NucPosSimulator_nucleosome_positions))
names(NucPosSimulator_nucleosome_ranges) <- rep("NucPosSimulator", 
                                length(NucPosSimulator_nucleosome_ranges))

### Row names are unique to each software
head(NOrMAL_nucleosome_positions, n = 2)

head(PING_nucleosome_positions, n = 2)

head(NucPosSimulator_nucleosome_positions, n = 2)

## ----nuclConsensus, collapse=FALSE--------------------------------------------
### Only choromsome 1 is going to be analyzed
chrList <- Seqinfo("chr1", 135534747, NA)

### Find consensus regions with both replicates inside it
results <- findConsensusPeakRegions(
            narrowPeaks = c(NOrMAL_nucleosome_ranges, PING_nucleosome_ranges,
                                NucPosSimulator_nucleosome_ranges),
            peaks = c(NOrMAL_nucleosome_positions, PING_nucleosome_positions,
                                NucPosSimulator_nucleosome_positions),
            chrInfo = chrList,
            extendingSize = 25,
            expandToFitPeakRegion = TRUE,
            shrinkToFitPeakRegion = TRUE,
            minNbrExp = 2,
            nbrThreads = 1)

## ----nuclResults, collapse=TRUE-----------------------------------------------
### Print the call 
results$call

### Print the 3 first consensus regions
head(results$consensusRanges, n = 3)

## ----nucleosomes, echo=FALSE, fig.cap = "Consensus regions. The consensus regions obtained for peaks called from three software on the same dataset."----
knitr::include_graphics('figures/nucleosomes.jpg')

## ----removeDatasetsNucl, echo=FALSE-------------------------------------------
### Remove dataset from NOrMAL
rm(NOrMAL_nucleosome_positions)
rm(NOrMAL_nucleosome_ranges)

### Remove dataset from PING
rm(PING_nucleosome_positions)
rm(PING_nucleosome_ranges)

### Remove dataset from NucPosSimulator
rm(NucPosSimulator_nucleosome_positions)
rm(NucPosSimulator_nucleosome_ranges)

## ----libraryLoad, warning=FALSE, message=FALSE--------------------------------
library(consensusSeekeR)

## ----loadingDatasets----------------------------------------------------------
### Loading datasets
data(A549_CTCF_MYN_NarrowPeaks_partial) ; data(A549_CTCF_MYN_Peaks_partial)
data(A549_CTCF_MYJ_NarrowPeaks_partial) ; data(A549_CTCF_MYJ_Peaks_partial)

## ----repAssignment------------------------------------------------------------
### Assigning experiment name "rep01" to the first replicate
names(A549_CTCF_MYJ_NarrowPeaks_partial) <- rep("rep01", length(A549_CTCF_MYJ_NarrowPeaks_partial))
names(A549_CTCF_MYJ_Peaks_partial)       <- rep("rep01", length(A549_CTCF_MYJ_Peaks_partial))

### Assigning experiment name "rep02" to the second replicate
names(A549_CTCF_MYN_NarrowPeaks_partial) <- rep("rep02", length(A549_CTCF_MYN_NarrowPeaks_partial))
names(A549_CTCF_MYN_Peaks_partial)       <- rep("rep02", length(A549_CTCF_MYN_Peaks_partial))

## ----replicateConsensus, collapse=FALSE---------------------------------------
### Only choromsome 10 is going to be analyzed
chrList <- Seqinfo("chr10", 135534747, NA)

### Find consensus regions with both replicates inside it
results <- findConsensusPeakRegions(
            narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial, A549_CTCF_MYN_NarrowPeaks_partial),
            peaks = c(A549_CTCF_MYJ_Peaks_partial, A549_CTCF_MYN_Peaks_partial),
            chrInfo = chrList,
            extendingSize = 100,
            expandToFitPeakRegion = TRUE,
            shrinkToFitPeakRegion = TRUE,
            minNbrExp = 2,
            nbrThreads = 1)

## ----replicateResults, collapse=TRUE------------------------------------------
### Print the call 
results$call

### Print the 3 first consensus regions
head(results$consensusRanges, n = 3)

## ----ctcf, echo=FALSE, fig.cap = "One consensus region for 2 ChIP-Seq replicates."----
knitr::include_graphics('figures/ctcf_consensus.jpg')

## ----rmCurrentDatasets, echo=FALSE, message=FALSE-----------------------------
### Remove datasets
rm(A549_CTCF_MYN_NarrowPeaks_partial)
rm(A549_CTCF_MYN_Peaks_partial)
rm(A549_CTCF_MYJ_NarrowPeaks_partial)
rm(A549_CTCF_MYJ_Peaks_partial)

## ----libLoad, warning=FALSE, message=FALSE------------------------------------
library(consensusSeekeR)

## ----loadingDatasetsExp-------------------------------------------------------
### Loading datasets
data(A549_NR3C1_CFQ_NarrowPeaks_partial) ; data(A549_NR3C1_CFQ_Peaks_partial)
data(A549_NR3C1_CFR_NarrowPeaks_partial) ; data(A549_NR3C1_CFR_Peaks_partial)
data(A549_NR3C1_CFS_NarrowPeaks_partial) ; data(A549_NR3C1_CFS_Peaks_partial)

## ----expAssignment------------------------------------------------------------
### Assign experiment name "ENCFF002CFQ" to the first experiment
names(A549_NR3C1_CFQ_NarrowPeaks_partial) <- rep("ENCFF002CFQ", 
                                length(A549_NR3C1_CFQ_NarrowPeaks_partial))
names(A549_NR3C1_CFQ_Peaks_partial) <- rep("ENCFF002CFQ", 
                                length(A549_NR3C1_CFQ_Peaks_partial))

### Assign experiment name "ENCFF002CFQ" to the second experiment
names(A549_NR3C1_CFR_NarrowPeaks_partial) <- rep("ENCFF002CFR", 
                                length(A549_NR3C1_CFR_NarrowPeaks_partial))
names(A549_NR3C1_CFR_Peaks_partial)       <- rep("ENCFF002CFR", 
                                length(A549_NR3C1_CFR_Peaks_partial))

### Assign experiment name "ENCFF002CFQ" to the third experiment
names(A549_NR3C1_CFS_NarrowPeaks_partial) <- rep("ENCFF002CFS", 
                                length(A549_NR3C1_CFS_NarrowPeaks_partial))
names(A549_NR3C1_CFS_Peaks_partial)       <- rep("ENCFF002CFS", 
                                length(A549_NR3C1_CFS_Peaks_partial))

## ----rowNames-----------------------------------------------------------------
### Assign specific name to each entry of to first experiment
### NarrowPeak name must fit Peaks name for same experiment
A549_NR3C1_CFQ_NarrowPeaks_partial$name <- paste0("NR3C1_CFQ_region_", 
                                1:length(A549_NR3C1_CFQ_NarrowPeaks_partial))
A549_NR3C1_CFQ_Peaks_partial$name       <- paste0("NR3C1_CFQ_region_",
                                1:length(A549_NR3C1_CFQ_NarrowPeaks_partial))

### Assign specific name to each entry of to second experiment
### NarrowPeak name must fit Peaks name for same experiment
A549_NR3C1_CFR_NarrowPeaks_partial$name <- paste0("NR3C1_CFR_region_", 
                                1:length(A549_NR3C1_CFR_NarrowPeaks_partial))
A549_NR3C1_CFR_Peaks_partial$name       <- paste0("NR3C1_CFR_region_", 
                                1:length(A549_NR3C1_CFR_Peaks_partial))

### Assign specific name to each entry of to third experiment
### NarrowPeak name must fit Peaks name for same experiment
A549_NR3C1_CFS_NarrowPeaks_partial$name <- paste0("NR3C1_CFS_region_", 
                                1:length(A549_NR3C1_CFS_NarrowPeaks_partial))
A549_NR3C1_CFS_Peaks_partial$name       <- paste0("NR3C1_CFS_region_", 
                                1:length(A549_NR3C1_CFS_Peaks_partial))

## ----experimentConsensus, collapse=FALSE--------------------------------------
### Only choromsome 2 is going to be analyzed
chrList <- Seqinfo("chr2", 243199373, NA)

### Find consensus regions with both replicates inside it
results <- findConsensusPeakRegions(
            narrowPeaks = c(A549_NR3C1_CFQ_NarrowPeaks_partial, 
                        A549_NR3C1_CFR_NarrowPeaks_partial,
                        A549_NR3C1_CFS_NarrowPeaks_partial),
            peaks = c(A549_NR3C1_CFQ_Peaks_partial, 
                        A549_NR3C1_CFR_Peaks_partial,
                        A549_NR3C1_CFS_Peaks_partial),
            chrInfo = chrList,
            extendingSize = 200,
            expandToFitPeakRegion = FALSE,
            shrinkToFitPeakRegion = TRUE,
            minNbrExp = 2,
            nbrThreads = 1)

## ----experimentResults, collapse=TRUE-----------------------------------------
### Print the call 
results$call

### Print the first 3 consensus regions
head(results$consensusRanges, n = 3)

## ----NR3C1, echo=FALSE, fig.cap = "Consensus regions. The consensus regions obtained for peaks called for 3 NR2C1 ChIP-Seq experiments."----
knitr::include_graphics('figures/NR3C1_consensus.jpg')

## ----rmDatasetsExp, echo=FALSE, message=FALSE---------------------------------
### Remove datasets
rm(A549_NR3C1_CFQ_NarrowPeaks_partial)
rm(A549_NR3C1_CFQ_Peaks_partial)
rm(A549_NR3C1_CFR_NarrowPeaks_partial)
rm(A549_NR3C1_CFR_Peaks_partial)
rm(A549_NR3C1_CFS_NarrowPeaks_partial)
rm(A549_NR3C1_CFS_Peaks_partial)

## ----shrink, echo=FALSE, fig.cap = "Effect of the shrinkToFitPeakRegion parameter."----
knitr::include_graphics('figures/shrink.jpg')

## ----extend, echo=FALSE, fig.cap = "Effect of the expandToFitPeakRegion parameter."----
knitr::include_graphics('figures/extendNew.jpg')

## ----sizeEffect, collapse=TRUE, eval=FALSE------------------------------------
# ### Set different values for the extendingSize parameter
# size <- c(1, 10, 50, 100, 300, 500, 750, 1000)
# 
# ### Only chrompsome 10 is going to be analyzed
# chrList <- Seqinfo("chr10", 135534747, NA)
# 
# ### Find consensus regions using all the size values
# resultsBySize <- lapply(size, FUN = function(size) findConsensusPeakRegions(
#                     narrowPeaks = c(A549_CTCF_MYJ_NarrowPeaks_partial,
#                                     A549_CTCF_MYN_NarrowPeaks_partial),
#                     peaks = c(A549_CTCF_MYJ_Peaks_partial,
#                                     A549_CTCF_MYN_Peaks_partial),
#                     chrInfo = chrList,
#                     extendingSize = size,
#                     expandToFitPeakRegion = TRUE,
#                     shrinkToFitPeakRegion = TRUE,
#                     minNbrExp = 2,
#                     nbrThreads = 1))
# 
# ### Extract the number of consensus regions obtained for each extendingSize
# nbrRegions <- mapply(resultsBySize,
#                 FUN = function(x) return(length(x$consensusRanges)))

## ----graphSizeEffect, warning=FALSE, eval=FALSE-------------------------------
# 
# library(ggplot2)
# 
# data <- data.frame(extendingSize = size, nbrRegions = nbrRegions)
# 
# ggplot(data, aes(extendingSize, nbrRegions)) + scale_x_log10("Extending size") +
#         stat_smooth(se = FALSE, method = "loess", size=1.4) +
#         ylab("Number of consensus regions") +
#         ggtitle(paste0("Number of consensus regions in function of the extendingSize"))

## ----sizeEffectG, echo=FALSE, fig.cap = "Effect of the extendingSize parameter."----
knitr::include_graphics('figures/sizeEffect.jpg')

## ----parallelExample, eval=FALSE, collapse=TRUE-------------------------------
# ### Load data
# data(A549_FOSL2_01_NarrowPeaks_partial) ; data(A549_FOSL2_01_Peaks_partial)
# data(A549_FOXA1_01_NarrowPeaks_partial) ; data(A549_FOXA1_01_Peaks_partial)
# 
# ### Assigning name "FOSL2"
# names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2",
#                                     length(A549_FOSL2_01_NarrowPeaks_partial))
# names(A549_FOSL2_01_Peaks_partial)       <- rep("FOSL2",
#                                     length(A549_FOSL2_01_Peaks_partial))
# 
# ### Assigning name "FOXA1"
# names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1",
#                                     length(A549_FOXA1_01_NarrowPeaks_partial))
# names(A549_FOXA1_01_Peaks_partial)       <- rep("FOXA1",
#                                     length(A549_FOXA1_01_Peaks_partial))
# 
# ### Two chromosomes to analyse
# chrList <- Seqinfo(paste0("chr", c(1,10)), c(249250621, 135534747), NA)
# 
# ### Find consensus regions using 2 threads
# results <- findConsensusPeakRegions(
#             narrowPeaks = c(A549_FOSL2_01_NarrowPeaks_partial,
#                             A549_FOXA1_01_Peaks_partial),
#             peaks = c(A549_FOSL2_01_Peaks_partial,
#                             A549_FOXA1_01_NarrowPeaks_partial),
#             chrInfo = chrList, extendingSize = 200, minNbrExp = 2,
#             expandToFitPeakRegion = FALSE, shrinkToFitPeakRegion = FALSE,
#             nbrThreads = 4)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

