# Code example from 'PIPETS' vignette. See references/ for full tutorial.

## ----echo=TRUE, message=FALSE, eval=FALSE-------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("PIPETS")

## ----echo=TRUE, message=FALSE-------------------------------------------------

library(PIPETS)


#Bed File Input
PIPETS_FullRun(inputData = "PIPETS_TestData.bed"
               ,readScoreMinimum = 30, OutputFileID = "ExampleResultsRun", 
               OutputFileDir = tempdir(),
               inputDataFormat = "bedFile")



## ----echo=TRUE, message=FALSE-------------------------------------------------
library(PIPETS)
library(BiocGenerics)
library(GenomicRanges)
#GRanges object input
#When run on GRanges objects, PIPETS also outputs the strand split GRanges objects to a list for the user
#The first item in the list are the + strand reads, and the second are the - strand reads
GRanges_Object <- read.delim(file = "PIPETS_TestData.bed",
        header = FALSE, stringsAsFactors = FALSE)

GRanges_Object <- GRanges(seqnames = GRanges_Object$V1,
        ranges = IRanges(start = GRanges_Object$V2,end = GRanges_Object$V3
        ),score = GRanges_Object$V5 ,strand = GRanges_Object$V6)

ResultsList <- PIPETS_FullRun(inputData = GRanges_Object, readScoreMinimum = 30, 
               OutputFileDir = tempdir(),
               OutputFileID = "ExampleResultsRun", inputDataFormat = "GRanges")

head(ResultsList)


## ----echo=TRUE, message=FALSE-------------------------------------------------

library(PIPETS)


#Bed File Input
PIPETS_FullRun(inputData = "PIPETS_TestData.bed"
               ,readScoreMinimum = 30, OutputFileID = "ExampleResultsRun", 
               OutputFileDir = tempdir(), threshAdjust = NA, 
               threshAdjust_TopStrand = 0.75, threshAdjust_CompStrand = 0.55,
               highOutlierTrim = NA, highOutlierTrim_TopStrand = 0.01,
               highOutlierTrim_CompStrand = 0.05,
               inputDataFormat = "bedFile")



## ----echo=FALSE, out.width="100%", fig.align = 'center'-----------------------
knitr::include_graphics("Sample_PIPETS_Smaller.png")

## ----echo=FALSE, out.width="125%", fig.align = 'center'-----------------------
knitr::include_graphics("Sample_PIPETS_TotalOutput.png")

## ----echo=FALSE, out.width="150%", fig.align = 'center'-----------------------
knitr::include_graphics("PIPETS_StepOne_One.png")

## ----echo=FALSE, out.width="150%", fig.align = 'center'-----------------------
knitr::include_graphics("PIPETS_StepOne_Two.png")

## ----echo=FALSE, out.width="150%", fig.align = 'center'-----------------------
knitr::include_graphics("PIPETS_StepTwo_One.png")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

