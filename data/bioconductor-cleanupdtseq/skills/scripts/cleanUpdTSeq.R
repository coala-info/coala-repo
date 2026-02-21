# Code example from 'cleanUpdTSeq' vignette. See references/ for full tutorial.

## ----1------------------------------------------------------------------------
suppressPackageStartupMessages(library(cleanUpdTSeq))
testFile <- system.file("extdata", "test.bed", 
                        package = "cleanUpdTSeq")
peaks <- BED6WithSeq2GRangesSeq(file = testFile, 
                               skip = 1L, withSeq = FALSE)

## ----2------------------------------------------------------------------------
peaks <- BED6WithSeq2GRangesSeq(file = testFile, 
                                skip = 1L, withSeq = TRUE)

## ----3------------------------------------------------------------------------
head(read.delim(testFile, header = TRUE, skip = 0))

## ----4------------------------------------------------------------------------
suppressPackageStartupMessages(library(BSgenome.Drerio.UCSC.danRer7))
testSet.NaiveBayes <- buildFeatureVector(peaks, 
                                         genome = Drerio,
                                         upstream = 40L, 
                                         downstream = 30L, 
                                         wordSize = 6L,
                                         alphabet = c("ACGT"),
                                         sampleType = "unknown", 
                                         replaceNAdistance = 30, 
                                         method = "NaiveBayes",
                                         fetchSeq = TRUE,
                                         return_sequences = TRUE)

## ----5------------------------------------------------------------------------
data(data.NaiveBayes)
if(interactive()){
   out <- predictTestSet(data.NaiveBayes$Negative,
                         data.NaiveBayes$Positive, 
                         testSet.NaiveBayes = testSet.NaiveBayes, 
                         outputFile = file.path(tempdir(), 
                                          "test-predNaiveBayes.tsv"), 
                        assignmentCutoff = 0.5)
}

## ----6------------------------------------------------------------------------
data(classifier)
testResults <- predictTestSet(testSet.NaiveBayes = testSet.NaiveBayes,
                              classifier = classifier,
                              outputFile = NULL, 
                              assignmentCutoff = 0.5,
                              return_sequences = TRUE)
head(testResults)

## ----sessionInfo, results = 'asis'--------------------------------------------
sessionInfo()

