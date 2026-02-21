# Code example from 'RAIDS' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', warning=FALSE, message=FALSE----------
BiocStyle::markdown()

suppressPackageStartupMessages({
    library(knitr)
    library(RAIDS)
})

set.seed(121444)

## ----installDemo01, eval=FALSE, warning=FALSE, message=FALSE------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#         install.packages("BiocManager")
# 
# BiocManager::install("RAIDS")

## ----graphMainSteps, echo=FALSE, fig.align="center", fig.cap="An overview of the genetic ancestry inference procedure.", out.width='130%', results='asis', warning=FALSE, message=FALSE----
knitr::include_graphics("MainSteps_v05.png")

## ----createDir, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

#############################################################################
## Create a temporary working directory structure
##    using the tempdir() function
#############################################################################
pathWorkingDirectory <- file.path(tempdir(), "workingDirectory")
pathWorkingDirectoryData <- file.path(pathWorkingDirectory, "data")

if (!dir.exists(pathWorkingDirectory)) {
        dir.create(pathWorkingDirectory)
        dir.create(pathWorkingDirectoryData)
        dir.create(file.path(pathWorkingDirectoryData, "refGDS"))
        dir.create(file.path(pathWorkingDirectoryData, "profileGDS"))
}


## ----copyRefFile, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

#############################################################################
## Load RAIDS package
#############################################################################
library(RAIDS)   

#############################################################################
## The population reference GDS file and SNV Annotation GDS file
##    need to be located in the same sub-directory.
## Note that the mini-reference GDS file used for this example is
##    NOT sufficient for reliable inference.
#############################################################################
## Path to the demo 1KG GDS file is located in this package
dataDir <- system.file("extdata", package="RAIDS")
pathReference <- file.path(dataDir, "tests")

fileGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")
fileAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

file.copy(fileGDS, file.path(pathWorkingDirectoryData, "refGDS"))
file.copy(fileAnnotGDS, file.path(pathWorkingDirectoryData, "refGDS"))


## ----installRaids, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

#############################################################################
## The file path to the population reference GDS file 
##     is required (refGenotype will be used as input later)
## The file path to the population reference SNV Annotation GDS file
##     is also required (refAnnotation will be used as input later)
#############################################################################
pathReference <- file.path(pathWorkingDirectoryData, "refGDS")

refGenotype <- file.path(pathReference, "ex1_good_small_1KG.gds")
refAnnotation <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

#############################################################################
## The output profileGDS directory, inside workingDirectory/data, must be 
##    created (pathProfileGDS will be used as input later)
#############################################################################
pathProfileGDS <- file.path(pathWorkingDirectoryData, "profileGDS")

if (!dir.exists(pathProfileGDS)) {
    dir.create(pathProfileGDS)
}


## ----samplingProfiles, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

#############################################################################
## Set up the following random number generator seed to reproduce  
##    the expected results
#############################################################################
set.seed(3043)

#############################################################################
## Choose the profiles from the population reference GDS file for 
##   data synthesis.
## Here we choose 2 profiles per subcontinental population 
##   from the mini 1KG GDS file.
## Normally, we would use 30 randomly chosen profiles per 
##   subcontinental population.
#############################################################################
dataRef <- select1KGPopForSynthetic(fileReferenceGDS=refGenotype,
                                        nbProfiles=2L)


## ----infere, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

###########################################################################
## Seqinfo and BSgenome are required libraries to run this example
###########################################################################
if (requireNamespace("Seqinfo", quietly=TRUE) &&
      requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly=TRUE)) {

    #######################################################################
    ## Chromosome length information is required
    ## chr23 is chrX, chr24 is chrY and chrM is 25
    #######################################################################
    genome <- BSgenome.Hsapiens.UCSC.hg38::Hsapiens
    chrInfo <- Seqinfo::seqlengths(genome)[1:25]

    #######################################################################
    ## The demo SNP VCF file of the DNA profile donor
    #######################################################################
    fileDonorVCF <- file.path(dataDir, "example", "snpPileup", "ex1.vcf.gz")

    #######################################################################
    ## The ancestry inference call
    #######################################################################
    resOut <- inferAncestry(profileFile=fileDonorVCF, 
        pathProfileGDS=pathProfileGDS,
        fileReferenceGDS=refGenotype,
        fileReferenceAnnotGDS=refAnnotation,
        chrInfo=chrInfo,
        syntheticRefDF=dataRef,
        genoSource=c("VCF"))
}


## ----removeTmp, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

#######################################################################
## Remove temporary files created for this demo
#######################################################################
unlink(pathWorkingDirectory, recursive=TRUE, force=TRUE)
      

## ----printRes, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

###########################################################################
## The output is a list object with multiple entries
###########################################################################
class(resOut)
names(resOut)


## ----print, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----

###########################################################################
## The ancestry information is stored in the 'Ancestry' entry 
###########################################################################
print(resOut$Ancestry)


## ----visualize, echo=TRUE, eval=TRUE, fig.align="center", fig.cap="RAIDS performance for the synthtic data.", results='asis', collapse=FALSE, warning=FALSE, message=FALSE----

###########################################################################
## Create a graph showing the perfomance for the synthetic data
## The output is a ggplot object
###########################################################################
createAUROCGraph(dfAUROC=resOut$paraSample$dfAUROC, title="Example ex1")


## ----graphStep1, echo=FALSE, fig.align="center", fig.cap="Step 1 - Provide population reference data", out.width='120%', results='asis', warning=FALSE, message=FALSE----
knitr::include_graphics("Step1_population_file_v01.png")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

