# Code example from 'General_overview' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# # Install via BioConductor
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("katdetectr")
# 
# # or the latest version
# BiocManager::install("katdetectr", version = "devel")
# 
# # or from github
# devtools::install_github("https://github.com/ErasmusMC-CCBC/katdetectr")

## -----------------------------------------------------------------------------
library(katdetectr)

## ----label = "Importing genomic variants", eval = TRUE------------------------
# Genomic variants stored within the VCF format.
pathToVCF <- system.file(package = "katdetectr", "extdata/CPTAC_Breast.vcf")

# Genomic variants stored within the MAF format.
pathToMAF <- system.file(package = "katdetectr", "extdata/APL_primary.maf")

# In addition, we can generate synthetic genomic variants including kataegis foci using generateSyntheticData().
# This functions returns a VRanges object.
syntheticData <- generateSyntheticData(nBackgroundVariants = 2500, nKataegisFoci = 1)

## ----label = "Detection of kataegis foci", eval = TRUE------------------------
# Detect kataegis foci within the given VCF file.
kdVCF <- detectKataegis(genomicVariants = pathToVCF)

# # Detect kataegis foci within the given MAF file.
# As this file contains multiple samples, we set aggregateRecords = TRUE.
kdMAF <- detectKataegis(genomicVariants = pathToMAF, aggregateRecords = TRUE)

# Detect kataegis foci within the synthetic data.
kdSynthetic <- detectKataegis(genomicVariants = syntheticData)

## ----label = "Overview of KatDetect objects", eval = TRUE---------------------
summary(kdVCF)
print(kdVCF)
show(kdVCF)

# Or simply:
kdVCF

## ----label = "Retrieving information from KatDetect objects", eval = TRUE-----
getGenomicVariants(kdVCF)

getSegments(kdVCF)

getKataegisFoci(kdVCF)

getInfo(kdVCF)

## ----label = "Visualisation of KatDetect objects", eval = TRUE----------------
rainfallPlot(kdVCF)

# With showSegmentation, the detected segments (changepoints) as visualized with their mean IMD.
rainfallPlot(kdMAF, showSegmentation = TRUE)

# With showSequence, we can display specific chromosomes or all chromosomes in which a putative kataegis foci has been detected.
rainfallPlot(kdSynthetic, showKataegis = TRUE, showSegmentation = TRUE, showSequence = "Kataegis")

## -----------------------------------------------------------------------------
# function for modeling sample mutation rate
modelSampleRate <- function(IMDs) {
    lambda <- log(2) / median(IMDs)

    return(lambda)
}

# function for calculating the nth root of x
nthroot <- function(x, n) {
    y <- x^(1 / n)

    return(y)
}

# Function that defines the IMD cutoff specific for each segment
# Within this function you can use all variables available in the slots: genomicVariants and segments
IMDcutoffFun <- function(genomicVariants, segments) {
    IMDs <- genomicVariants$IMD
    totalVariants <- segments$totalVariants
    width <- segments |>
        dplyr::as_tibble() |>
        dplyr::pull(width)

    sampleRate <- modelSampleRate(IMDs)

    IMDcutoff <- -log(1 - nthroot(0.01 / width, ifelse(totalVariants != 0, totalVariants - 1, 1))) / sampleRate

    IMDcutoff <- replace(IMDcutoff, IMDcutoff > 1000, 1000)

    return(IMDcutoff)
}

kdCustom <- detectKataegis(syntheticData, IMDcutoff = IMDcutoffFun)

## -----------------------------------------------------------------------------
# generate data that contains non standard sequences
syndata1 <- generateSyntheticData(seqnames = c("chr1_gl000191_random", "chr4_ctg9_hap1"))
syndata2 <- generateSyntheticData(seqnames = "chr1")
syndata <- suppressWarnings(c(syndata1, syndata2))

# construct a dataframe that contains the length of the sequences
# each column name (name of the sequence)
sequenceLength <- data.frame(
    chr1 = 249250621,
    chr1_gl000191_random = 106433,
    chr4_ctg9_hap1 = 590426
)

# provide the dataframe with the sequence lengths using the refSeq argument
kdNonStandard <- detectKataegis(genomicVariants = syndata, refSeq = sequenceLength)

## ----label = "Session Information", eval = TRUE-------------------------------
utils::sessionInfo()

