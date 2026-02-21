# Code example from 'panviz_howto' vignette. See references/ for full tutorial.

## ---- eval=TRUE, echo=TRUE, results='hide', message=FALSE------------------
library(PanVizGenerator)
getGO()

## ---- eval=FALSE-----------------------------------------------------------
#  PanVizGenerator()

## ---- echo=TRUE, eval=TRUE, warning=FALSE----------------------------------
csvFile <- system.file('extdata', 'exampleData.csv', 
                       package = 'PanVizGenerator')
outputDir <- tempdir()

# Generate the visualization
panviz(csvFile, location = outputDir)

## ---- echo=TRUE, eval=TRUE, warning=FALSE----------------------------------
# Get data from csv
pangenome <- read.csv(csvFile, quote='', stringsAsFactors = FALSE)
name <- pangenome$name
go <- pangenome$go
ec <- pangenome$ec
pangenome <- pangenome[, !names(pangenome) %in% c('name', 'go', 'ec')]

# Annotation can come in many ways
# This is valid
head(go)
# And this is valid too
head(strsplit(go, '; '))
# Or another delimiter
head(gsub('; ', 'delimiter', go))

# Generate the visualization
panviz(pangenome, name=name, go=go, ec=ec, location=outputDir)

## ---- echo=TRUE, eval=TRUE, warning=FALSE, message=FALSE-------------------
# Get an example pangenome with annotation
library(FindMyFriends)
pangenome <- .loadPgExample(withNeighborhoodSplit = TRUE)
annotation <- readAnnot(system.file('extdata', 
                                    'examplePG', 
                                    'example.annot', 
                                    package = 'FindMyFriends'))
head(annotation)
pangenome <- addGroupInfo(pangenome, annotation, key = 'name')
pangenome

# Generate the visualization
panviz(pangenome, location = outputDir)

## ---- echo=TRUE, eval=TRUE, warning=FALSE----------------------------------
panviz(pangenome, location = outputDir, consolidate = FALSE)

## ---- echo=TRUE, eval=FALSE, warning=FALSE---------------------------------
#  panviz(pangenome, location = outputDir, showcase = TRUE)

## ---- echo=TRUE, eval=TRUE, warning=FALSE----------------------------------
panviz(pangenome, location = outputDir, dist = 'binary', clust = 'complete',
       center = FALSE, scale = FALSE)

## ---- echo=FALSE, eval=TRUE------------------------------------------------
sessionInfo()

