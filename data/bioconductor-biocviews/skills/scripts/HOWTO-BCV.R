# Code example from 'HOWTO-BCV' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(biocViews)

## ----Establishing a vocabulary of terms, echo=TRUE, message=FALSE, warning=FALSE----
vocabFile <- system.file("dot/biocViewsVocab.dot", package="biocViews")
cat(readLines(vocabFile)[1:20], sep="\n")
cat("...\n")

## ----Querying a repository, echo=TRUE, message=FALSE, warning=FALSE-----------
data(biocViewsVocab)
reposPath <- system.file("doc", package="biocViews")
reposUrl <- paste("file://", reposPath, sep="") 
biocViews <- getBiocSubViews(reposUrl, biocViewsVocab, topTerm="Software")
print(biocViews[1:2])

## ----getSubTerms, message=FALSE, warning=FALSE--------------------------------
getSubTerms(biocViewsVocab, term="Technology")

## ----Generating HTML, echo=TRUE, message=FALSE, warning=FALSE-----------------
viewsDir <- file.path(tempdir(), "biocViews")
dir.create(viewsDir)
writeBiocViews(biocViews, dir=viewsDir)
dir(viewsDir)[1:2]

