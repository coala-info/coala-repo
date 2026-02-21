# Code example from 'Create_Reference_GDS_File' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', warning=FALSE, message=FALSE----------
BiocStyle::markdown()

suppressPackageStartupMessages({
    library(knitr)
    library(RAIDS)
    library(SNPRelate)
    library(gdsfmt)
})

set.seed(121444)

## ----runRefGDS, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(SNPRelate)

pathRef <- system.file("extdata/", package="RAIDS")

fileReferenceGDS <- file.path(pathRef, "PopulationReferenceDemo.gds")

gdsRef <- snpgdsOpen(fileReferenceGDS)

## Show the file format
print(gdsRef)

closefn.gds(gdsRef)

## ----createRefGDS, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(SNPRelate)
library(gdsfmt)

## Create a temporary GDS Reference file in the temporary directory
fileNewReferenceGDS <- file.path(tempdir(), "reference_DEMO.gds")

gdsRefNew <- createfn.gds(fileNewReferenceGDS)

## The entry 'sample.id' contain the unique identifiers of 10 samples 
## that constitute the reference dataset
sample.id <- c("HG00243", "HG00150", "HG00149", "HG00246", "HG00138", 
                    "HG01334", "HG00268", "HG00275", "HG00290", "HG00364")
add.gdsn(node=gdsRefNew, name="sample.id", val=sample.id, 
            storage="string", check=TRUE)

## A data frame containing the information about the 10 samples 
## (in the same order than in the 'sample.id') is created and added to 
## the 'sample.annot' entry
## The data frame must contain those columns: 
##     'sex': '1'=male, '2'=female
##     'pop.group': acronym for the population (ex: GBR, CDX, MSL, ASW, etc..)
##     'superPop': acronym for the super-population (ex: AFR, EUR, etc...)
##     'batch': number identifying the batch of provenance 
sampleInformation <- data.frame(sex=c("1", "2", "1", "1", "1", 
        "1", "2", "2", "1", "2"), pop.group=c(rep("GBR", 6), rep("FIN", 4)), 
        superPop=c(rep("EUR", 10)), batch=rep(0, 10), stringsAsFactors=FALSE)
add.gdsn(node=gdsRefNew, name="sample.annot", val=sampleInformation, 
            check=TRUE)

## The identifier of each SNV is added in the 'snp.id' entry
snvID <- c("s29603", "s29605", "s29633", "s29634", "s29635", "s29637", 
            "s29638", "s29663", "s29664", "s29666", "s29667", "s29686", 
            "s29687", "s29711", "s29741", "s29742", "s29746", "s29750", 
            "s29751", "s29753")
add.gdsn(node=gdsRefNew, name="snp.id", val=snvID, check=TRUE)

## The chromosome of each SNV is added to the 'snp.chromosome' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvChrom <- c(rep(1, 20))
add.gdsn(node=gdsRefNew, name="snp.chromosome", val=snvChrom, storage="uint16",
            check=TRUE)

## The position on the chromosome of each SNV is added to 
## the 'snp.position' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvPos <- c(3467333, 3467428, 3469375, 3469387, 3469502, 3469527, 
                    3469737, 3471497, 3471565, 3471618)
add.gdsn(node=gdsRefNew, name="snp.position", val=snvPos, storage="int32",
            check=TRUE)

## The allele information of each SNV is added to the 'snp.allele' entry
## The order of the SNVs is the same than in the 'snp.allele' entry
snvAllele <- c("A/G", "C/G", "C/T", "C/T", "T/G", "C/T", 
                    "G/A", "A/G", "G/A", "G/A")
add.gdsn(node=gdsRefNew, name="snp.allele", val=snvAllele, storage="string",
            check=TRUE)

## The allele frequency in the general population (between 0 and 1) of each 
## SNV is added to the 'snp.AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.86, 0.01, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.01)
add.gdsn(node=gdsRefNew, name="snp.AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the East Asian population (between 0 and 1) of each 
## SNV is added to the 'snp.EAS_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.80, 0.00, 0.00, 0.01, 0.00, 0.00, 0.01, 0.00, 0.02, 0.00)
add.gdsn(node=gdsRefNew, name="snp.EAS_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the European population (between 0 and 1) of each 
## SNV is added to the 'snp.EUR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.91, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.03)
add.gdsn(node=gdsRefNew, name="snp.EUR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the African population (between 0 and 1) of each 
## SNV is added to the 'snp.AFR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.85, 0.04, 0.00, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00)
add.gdsn(node=gdsRefNew, name="snp.AFR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the American population (between 0 and 1) of each 
## SNV is added to the 'snp.AMR_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.83, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.02)
add.gdsn(node=gdsRefNew, name="snp.AMR_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The allele frequency in the South Asian population (between 0 and 1) of each 
## SNV is added to the 'snp.SAS_AF' entry
## The order of the SNVs is the same than in the 'snp.id' entry
snvAF <- c(0.89, 0.00, 0.00, 0.00, 0.05, 0.00, 0.00, 0.01, 0.00, 0.00)
add.gdsn(node=gdsRefNew, name="snp.SAS_AF", val=snvAF, storage="packedreal24",
            check=TRUE)

## The genotype of each SNV for each sample is added to the 'genotype' entry
## The genotype correspond to the number of A alleles
## The rows represent the SNVs is the same order than in 'snp.id' entry
## The columns represent the samples is the same order than in 'sample.id' entry
genotypeInfo <- matrix(data=c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0), nrow=10, byrow=TRUE)
add.gdsn(node=gdsRefNew, name="genotype", val=genotypeInfo, 
            storage="bit2", check=TRUE)

## The entry 'sample.ref' is filled with 1 indicating that all 10 
## samples are retained to be used as reference
## The order of the samples is the same than in the 'sample.id' entry
add.gdsn(node=gdsRefNew, name="sample.ref", val=rep(1L, 10), 
            storage="bit1", check=TRUE)

## Show the file format
print(gdsRefNew)

closefn.gds(gdsRefNew)

unlink(fileNewReferenceGDS, force=TRUE)


## ----runRefAnnotGDS, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(SNPRelate)

pathReference <- system.file("extdata/tests", package="RAIDS")

fileReferenceAnnotGDS <- file.path(pathReference, "ex1_good_small_1KG.gds")

gdsRefAnnot <- openfn.gds(fileReferenceAnnotGDS)

## Show the file format
print(gdsRefAnnot)

closefn.gds(gdsRefAnnot)

## ----createRefAnnotGDS, echo=TRUE, eval=TRUE, collapse=TRUE, warning=FALSE, message=FALSE----
#############################################################################
## Load required packages
#############################################################################
library(RAIDS)    
library(gdsfmt)

## Create a temporary GDS Reference file in the temporary directory
fileNewReferenceAnnotGDS <- 
        file.path(tempdir(), "reference_SNV_Annotation_DEMO.gds")

gdsRefAnnotNew <- createfn.gds(fileNewReferenceAnnotGDS)

## The entry 'phase' contain the phase of the SNVs in the
## Population Annotation GDS file
## 0 means the first allele is a reference; 1 means the first allele is
## the alternative and 3 means unknown
## The SNVs (rows) and samples (columns) in phase are in the same order as
## in the Population Annotation GDS file.
phase <- matrix(data=c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                        0, 0, 0, 1, 1, 0, 0, 0, 1, 1,
                        0, 0, 0, 1, 1, 0, 0, 0, 0, 1,
                        1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1,
                        0, 0, 1, 0, 0, 0, 0, 1, 0, 0,
                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                        0, 1, 0, 1, 1, 0, 1, 1, 1, 1), ncol=10, byrow=TRUE)
add.gdsn(node=gdsRefAnnotNew, name="phase", val=phase, storage="bit2", 
                check=TRUE)

## The entry 'blockAnnot' contain the information for each group of blocks
## that are present in the 'block' entry.
blockAnnot <- data.frame(block.id=c("EAS.0.05.500k", "EUR.0.05.500k",
                    "AFR.0.05.500k", "AMR.0.05.500k", "SAS.0.05.500k"),
                block.desc=c(
                    "EAS populationblock base on SNP 0.05 and windows 500k",
                    "EUR populationblock base on SNP 0.05 and windows 500k",
                    "AFR populationblock base on SNP 0.05 and windows 500k",
                    "AMR populationblock base on SNP 0.05 and windows 500k",
                    "SAS populationblock base on SNP 0.05 and windows 500k"),
                stringsAsFactors=FALSE)
add.gdsn(node=gdsRefAnnotNew, name="block.annot", val=blockAnnot, check=TRUE)

## The entry 'block' contain the block information for the SNVs in the
## Population Annotation GDS file.
## The SNVs (rows) are in the same order as in 
## the Population Annotation GDS file.
## The block groups (columns) are in the same order as in 
## the 'block.annot' entry.
block <- matrix(data=c(-1, -1, -1, -1, -1,
                        -2, -2,  1, -2, -2,
                        -2,  1,  1,  1, -2,
                        -2,  1,  1,  1, -2,
                        -2, -3, -2, -3, -2,
                         1,  2,  2,  2,  1,
                         1,  2,  2,  2,  1,
                        -3, -4, -3, -4, -3,
                         2, -4,  3, -4, -3,
                         2, -4,  3, -4, -3), ncol=5, byrow=TRUE)
add.gdsn(node=gdsRefAnnotNew, name="block", val=block, storage="int32", 
            check=TRUE)

## Show the file format
print(gdsRefAnnotNew)

closefn.gds(gdsRefAnnotNew)

unlink(fileNewReferenceAnnotGDS, force=TRUE)


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

