# Code example from 'AS_events_preparation' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(psichomics)
library(plyr)

## ----include=FALSE------------------------------------------------------------
suppaOutput <- system.file("extdata/eventsAnnotSample/suppa_output/suppaEvents",
                           package="psichomics")
suppaFile <- tempfile(fileext=".RDS")

## ----results="hide"-----------------------------------------------------------
# suppaOutput <- "path/to/SUPPA/output"

# Replace `genome` for the string with the identifier before the first
# underscore in the filenames of that directory (for instance, if one of your 
# filenames of interest is "hg19_A3.ioe", the string would be "hg19")
suppa <- parseSuppaAnnotation(suppaOutput, genome="hg19")
annot <- prepareAnnotationFromEvents(suppa)

# suppaFile <- "suppa_hg19_annotation.RDS"
saveRDS(annot, file=suppaFile)

## ----include=FALSE------------------------------------------------------------
matsOutput <- system.file("extdata/eventsAnnotSample/mats_output/ASEvents/",
                          package="psichomics")
matsFile <- tempfile("mats", fileext=".RDS")

## ----results="hide"-----------------------------------------------------------
# matsOutput <- "path/to/rMATS/output"
mats <- parseMatsAnnotation(
    matsOutput,         # Output directory from rMATS
    genome = "fromGTF", # Identifier of the filenames
    novelEvents=TRUE)   # Parse novel events?
annot <- prepareAnnotationFromEvents(mats)

# matsFile <- "mats_hg19_annotation.RDS"
saveRDS(annot, file=matsFile)

## ----include=FALSE------------------------------------------------------------
misoAnnotation <- system.file("extdata/eventsAnnotSample/miso_annotation",
                              package="psichomics")
misoFile <- tempfile("miso", fileext=".RDS")

## ----results="hide"-----------------------------------------------------------
# misoAnnotation <- "path/to/MISO/annotation"
miso <- parseMisoAnnotation(misoAnnotation)
annot <- prepareAnnotationFromEvents(miso)

# misoFile <- "miso_AS_annotation_hg19.RDS"
saveRDS(annot, file=misoFile)

## ----include=FALSE------------------------------------------------------------
vastAnnotation <- system.file("extdata/eventsAnnotSample/VASTDB/Hsa/TEMPLATES/",
                              package="psichomics")
vastFile <- tempfile("vast", fileext=".RDS")

## ----results="hide"-----------------------------------------------------------
# vastAnnotation <- "path/to/VASTDB/libs/TEMPLATES"
vast <- parseVastToolsAnnotation(vastAnnotation, genome="Hsa")
annot <- prepareAnnotationFromEvents(vast)

# vastFile <- "vast_AS_annotation_hg19.RDS"
saveRDS(annot, file=vastFile)

## ----include=FALSE------------------------------------------------------------
annotFile <- tempfile(fileext=".RDS")

## ----results="hide"-----------------------------------------------------------
# Combine the annotation from SUPPA, MISO, rMATS and VAST-TOOLS
annot <- prepareAnnotationFromEvents(suppa, vast, mats, miso)

# annotFile <- "AS_annotation_hg19.RDS"
saveRDS(annot, file=annotFile)

## ----results="hide"-----------------------------------------------------------
annot <- readRDS(annotFile) # "annotFile" is the path to the annotation file
junctionQuant <- readFile("ex_junctionQuant.RDS") # example set

psi <- quantifySplicing(annot, junctionQuant)

## -----------------------------------------------------------------------------
psi # may have 0 rows because of the small junction quantification set

