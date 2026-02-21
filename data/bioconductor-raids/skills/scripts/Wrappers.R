# Code example from 'Wrappers' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', warning=FALSE, message=FALSE----------
BiocStyle::markdown()

suppressPackageStartupMessages({
    library(knitr)
    library(RAIDS)
    library(gdsfmt)
})

set.seed(121444)

## ----graphMainSteps, echo=FALSE, fig.align="center", fig.cap="An overview of the genetic ancestry inference process.", out.width='130%', results='asis', warning=FALSE, message=FALSE----
knitr::include_graphics("MainSteps_v04.png")

## ----graphWrapper, echo=FALSE, fig.align="center", fig.cap="Final step - The wrapper function encapsulates multiple steps of the workflow.", out.width='120%', results='asis', warning=FALSE, message=FALSE----
knitr::include_graphics("MainSteps_Wrapper_v04.png")

## ----runExomeAncestry, echo=TRUE, eval=TRUE, collapse=FALSE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(gdsfmt)

## Path to the demo 1KG GDS file is located in this package
dataDir <- system.file("extdata", package="RAIDS")

#############################################################################
## Load the information about the profile
#############################################################################
data(demoPedigreeEx1)
head(demoPedigreeEx1)

#############################################################################
## The population reference GDS file and SNV Annotation GDS file
## need to be located in the same directory.
## Note that the population reference GDS file used for this example is a
## simplified version and CANNOT be used for any real analysis
#############################################################################
pathReference <- file.path(dataDir, "tests")

fileGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")
fileAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

#############################################################################
## A data frame containing general information about the study
## is also required. The data frame must have
## those 3 columns: "study.id", "study.desc", "study.platform"
#############################################################################
studyDF <- data.frame(study.id="MYDATA",
                   study.desc="Description",
                   study.platform="PLATFORM",
                   stringsAsFactors=FALSE)

#############################################################################
## The Sample SNP VCF files (one per sample) need
## to be all located in the same directory.
#############################################################################
pathGeno <- file.path(dataDir, "example", "snpPileup")

#############################################################################
## Fix RNG seed to ensure reproducible results
#############################################################################
set.seed(3043)

#############################################################################
## Select the profiles from the population reference GDS file for 
## the synthetic data.
## Here we select 2 profiles from the simplified 1KG GDS for each 
## subcontinental-level.
## Normally, we use 30 profile for each 
## subcontinental-level but it is too big for the example.
## The 1KG files in this example only have 6 profiles for each 
## subcontinental-level (for demo purpose only).
#############################################################################
gds1KG <- snpgdsOpen(fileGDS)
dataRef <- select1KGPop(gds1KG, nbProfiles=2L)
closefn.gds(gds1KG)

## Seqinfo and BSgenome are required libraries to run this example
if (requireNamespace("Seqinfo", quietly=TRUE) &&
      requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly=TRUE)) {

    ## Chromosome length information
    ## chr23 is chrX, chr24 is chrY and chrM is 25
    chrInfo <- Seqinfo::seqlengths(BSgenome.Hsapiens.UCSC.hg38::Hsapiens)[1:25]

    ###########################################################################
    ## The path where the Sample GDS files (one per sample)
    ## will be created needs to be specified.
    ###########################################################################
    pathProfileGDS <- file.path(tempdir(), "exampleDNA", "out.tmp")

    ###########################################################################
    ## The path where the result files will be created needs to 
    ## be specified
    ###########################################################################
    pathOut <- file.path(tempdir(), "exampleDNA", "res.out")

    ## Example can only be run if the current directory is in writing mode
    if (!dir.exists(file.path(tempdir(), "exampleDNA"))) {

        dir.create(file.path(tempdir(), "exampleDNA"))
        dir.create(pathProfileGDS)
        dir.create(pathOut)
    
        #########################################################################
        ## The wrapper function generates the synthetic dataset and uses it 
        ## to selected the optimal parameters before calling the genetic 
        ## ancestry on the current profiles.
        ## All important information, for each step, are saved in 
        ## multiple output files.
        ## The 'genoSource' parameter has 2 options depending on how the 
        ##   SNP files have been generated: 
        ##   SNP VCF files have been generated: 
        ##  "VCF" or "generic" (other software)
        ##
        #########################################################################
        runExomeAncestry(pedStudy=demoPedigreeEx1, studyDF=studyDF,
                 pathProfileGDS=pathProfileGDS,
                 pathGeno=pathGeno,
                 pathOut=pathOut,
                 fileReferenceGDS=fileGDS,
                 fileReferenceAnnotGDS=fileAnnotGDS,
                 chrInfo=chrInfo,
                 syntheticRefDF=dataRef,
                 genoSource="VCF")
        list.files(pathOut)
        list.files(file.path(pathOut, demoPedigreeEx1$Name.ID[1]))

        #######################################################################
        ## The file containing the ancestry inference (SuperPop column) and 
        ## optimal number of PCA component (D column)
        ## optimal number of neighbours (K column)
        #######################################################################
        resAncestry <- read.csv(file.path(pathOut, 
                        paste0(demoPedigreeEx1$Name.ID[1], ".Ancestry.csv")))
        print(resAncestry)

        ## Remove temporary files created for this demo
        unlink(pathProfileGDS, recursive=TRUE, force=TRUE)
        unlink(pathOut, recursive=TRUE, force=TRUE)
        unlink(file.path(tempdir(), "exampleDNA"), recursive=TRUE, force=TRUE)
    }
}
  


## ----runRNAAncestry, echo=TRUE, eval=TRUE, collapse=FALSE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(gdsfmt)

## Path to the demo 1KG GDS file is located in this package
dataDir <- system.file("extdata", package="RAIDS")

#############################################################################
## Load the information about the profile
#############################################################################
data(demoPedigreeEx1)
head(demoPedigreeEx1)

#############################################################################
## The population reference GDS file and SNV Annotation GDS file
## need to be located in the same directory.
## Note that the population reference GDS file used for this example is a
## simplified version and CANNOT be used for any real analysis
#############################################################################
pathReference <- file.path(dataDir, "tests")

fileGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")
fileAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG_Annot.gds")

#############################################################################
## A data frame containing general information about the study
## is also required. The data frame must have
## those 3 columns: "study.id", "study.desc", "study.platform"
#############################################################################
studyDF <- data.frame(study.id="MYDATA",
                   study.desc="Description",
                   study.platform="PLATFORM",
                   stringsAsFactors=FALSE)

#############################################################################
## The Sample SNP VCF files (one per sample) need
## to be all located in the same directory.
#############################################################################
pathGeno <- file.path(dataDir, "example", "snpPileupRNA")

#############################################################################
## Fix RNG seed to ensure reproducible results
#############################################################################
set.seed(3043)

#############################################################################
## Select the profiles from the population reference GDS file for 
## the synthetic data.
## Here we select 2 profiles from the simplified 1KG GDS for each 
## subcontinental-level.
## Normally, we use 30 profile for each 
## subcontinental-level but it is too big for the example.
## The 1KG files in this example only have 6 profiles for each 
## subcontinental-level (for demo purpose only).
#############################################################################
gds1KG <- snpgdsOpen(fileGDS)
dataRef <- select1KGPop(gds1KG, nbProfiles=2L)
closefn.gds(gds1KG)

## Seqinfo and BSgenome are required libraries to run this example
if (requireNamespace("Seqinfo", quietly=TRUE) &&
      requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly=TRUE)) {

  ## Chromosome length information
  ## chr23 is chrX, chr24 is chrY and chrM is 25
  chrInfo <- Seqinfo::seqlengths(BSgenome.Hsapiens.UCSC.hg38::Hsapiens)[1:25]

  #############################################################################
  ## The path where the Sample GDS files (one per sample)
  ## will be created needs to be specified.
  #############################################################################
  pathProfileGDS <- file.path(tempdir(), "exampleRNA", "outRNA.tmp")

  #############################################################################
  ## The path where the result files will be created needs to 
  ## be specified
  #############################################################################
  pathOut <- file.path(tempdir(), "exampleRNA", "resRNA.out")

  ## Example can only be run if the current directory is in writing mode
  if (!dir.exists(file.path(tempdir(), "exampleRNA"))) {

      dir.create(file.path(tempdir(), "exampleRNA"))
      dir.create(pathProfileGDS)
      dir.create(pathOut)
    
      #########################################################################
      ## The wrapper function generates the synthetic dataset and uses it 
      ## to selected the optimal parameters before calling the genetic 
      ## ancestry on the current profiles.
      ## All important information, for each step, are saved in 
      ## multiple output files.
      ## The 'genoSource' parameter has 2 options depending on how the 
      ##   SNP files have been generated: 
      ##   SNP VCF files have been generated: 
      ##  "VCF" or "generic" (other software)
      #########################################################################
      runRNAAncestry(pedStudy=demoPedigreeEx1, studyDF=studyDF,
                    pathProfileGDS=pathProfileGDS,
                    pathGeno=pathGeno,
                    pathOut=pathOut,
                    fileReferenceGDS=fileGDS,
                    fileReferenceAnnotGDS=fileAnnotGDS,
                    chrInfo=chrInfo,
                    syntheticRefDF=dataRef,
                    blockTypeID="GeneS.Ensembl.Hsapiens.v86",
                    genoSource="VCF")
    
      list.files(pathOut)
      list.files(file.path(pathOut, demoPedigreeEx1$Name.ID[1]))

      #########################################################################
      ## The file containing the ancestry inference (SuperPop column) and 
      ## optimal number of PCA component (D column)
      ## optimal number of neighbours (K column)
      #########################################################################
      resAncestry <- read.csv(file.path(pathOut, 
                        paste0(demoPedigreeEx1$Name.ID[1], ".Ancestry.csv")))
      print(resAncestry)

      ## Remove temporary files created for this demo
      unlink(pathProfileGDS, recursive=TRUE, force=TRUE)
      unlink(pathOut, recursive=TRUE, force=TRUE)
      unlink(file.path(tempdir(), "example"), recursive=TRUE, force=TRUE)
  }
}
 

## ----graphStep1, echo=FALSE, fig.align="center", fig.cap="Step 1 - Formatting the information from the population reference dataset (optional)", out.width='120%', results='asis', warning=FALSE, message=FALSE----
knitr::include_graphics("MainSteps_Step1_v04.png")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

