# Code example from 'methylInheritance' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', warning=FALSE, message=FALSE------
BiocStyle::markdown()
library(knitr)
library(methylKit)

## ----loadingPackage, warning=FALSE, message=FALSE-----------------------------
library(methylInheritance)

## ----caseStudy01, warning=FALSE, message=FALSE, collapse=TRUE-----------------
## Load dataset containing information over three generations
data(demoForTransgenerationalAnalysis)

## The length of the dataset corresponds to the number of generation
## The generations are stored in order (first entry = first generation, 
## second entry = second generation, etc..)
length(demoForTransgenerationalAnalysis)


## All samples related to one generation are contained in a methylRawList 
## object.
## The methylRawList object contains two Slots:
## 1- treatment: a numeric vector denoting controls and cases.
## 2- .Data: a list of methylRaw objects. Each object stores the raw 
##           mehylation data of one sample.


## A section of the methylRaw object containing the information of the 
## first sample from the second generation 
head(demoForTransgenerationalAnalysis[[2]][[1]]) 

## The treatment vector for each generation
## The number of treatments and controls is the same in each generation
## However, it could also be different.
## Beware that getTreatment() is a function from the methylKit package.
getTreatment(demoForTransgenerationalAnalysis[[1]])
getTreatment(demoForTransgenerationalAnalysis[[2]])
getTreatment(demoForTransgenerationalAnalysis[[3]])

## ----caseStudy02, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-----
## The observation analysis is only done on differentially methylated sites
runObservation(methylKitData = demoForTransgenerationalAnalysis, 
                        type = "sites",     # Only sites
                        outputDir = "demo_01",   # RDS result files are saved 
                                                 # in the directory
                        nbrCores = 1,       # Number of cores used 
                        minReads = 10,      # Minimum read coverage
                        minMethDiff = 10,   # Minimum difference in methylation 
                                            # to be considered DMS
                        qvalue = 0.01,
                        vSeed = 2101)       # Ensure reproducible results

## The results can be retrived using loadAllRDSResults() method
observedResults <- loadAllRDSResults(
                    analysisResultsDir = "demo_01/",  # Directory containing
                                                      # the observation
                                                      # results
                    permutationResultsDir = NULL, 
                    doingSites = TRUE, 
                    doingTiles = FALSE)

observedResults

## ----caseStudy03, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-----
## The permutation analysis is only done on differentially methylated sites
runPermutation(methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "sites",     # Only sites
                        outputDir = "demo_02",   # RDS permutation files are 
                                                 # saved in the directory
                        runObservationAnalysis = FALSE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        minReads = 10,          # Minimum read coverage
                        minMethDiff = 10,   # Minimum difference in methylation
                                            # to be considered DMS
                        qvalue = 0.01,
                        vSeed = 2101)         # Ensure reproducible results

## The results can be retrived using loadAllRDSResults() method
permutationResults <- loadAllRDSResults(
                    analysisResultsDir = NULL, 
                    permutationResultsDir = "demo_02",   # Directory containing
                                                    # the permutation
                                                    # results
                    doingSites = TRUE, 
                    doingTiles = FALSE)

permutationResults

## ----caseStudy04, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-----
## Merge observation and permutation results
allResults <- mergePermutationAndObservation(permutationResults = 
                                                    permutationResults,
                                    observationResults = observedResults)
allResults

## ----remove01, warning=FALSE, message=FALSE, echo=FALSE, cache=FALSE----------
rm(permutationResults)
rm(observedResults)

## ----caseStudy05, warning=FALSE, message=FALSE, collapse=TRUE, cache=FALSE----
## Conserved differentially methylated sites between F1 and F2 generations
F1_and_F2_results <- extractInfo(allResults = allResults, type = "sites", 
                                    inter = "i2", position = 1)

head(F1_and_F2_results)

## ----caseStudyLoad, warning=FALSE, message=FALSE, cache=TRUE,  echo = FALSE, cache=TRUE----
demoFile <- system.file("extdata", "resultsForTransgenerationalAnalysis.RDS",
                package="methylInheritance")

demoResults <- readRDS(demoFile)

## ----caseStudy06, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE-----
## Differentially conserved sites between F1 and F2 generations
F1_and_F2 <- extractInfo(allResults = demoResults, type = "sites", 
                            inter = "i2", position = 1)
## Differentially conserved sites between F2 and F3 generations
F2_and_F3 <- extractInfo(allResults = demoResults, type = "sites", 
                            inter = "i2", position = 2)
## Differentially conserved sites between F1 and F2 and F3 generations
F2_and_F3 <- extractInfo(allResults = demoResults, type = "sites", 
                            inter = "iAll", position = 1)

## ----caseStudy07, warning=FALSE, message=FALSE, collapse=TRUE-----------------
## Show graph and significant level for differentially conserved sites 
## between F1 and F2 
output <- plotGraph(F1_and_F2)

## ----restartAnalysis, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE----
## The permutation analysis is only done on differentially methylated tiles
## The "output" directory must be specified
## The "vSeed" must be specified to ensure reproducible results
## The "restartCalculation" is not important the first time the analysis is run
permutationResult <- runPermutation(
                        methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "tiles",     # Only tiles
                        outputDir = "test_restart",   # RDS files are created
                        runObservationAnalysis = TRUE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        vSeed = 212201,     # Ensure reproducible results
                        restartCalculation = FALSE)

## Assume that the process was stopped before it has done all the permutations

## The process can be restarted
## All parameters must be identical to the first analysis except "restartCalculation"
## The "restartCalculation" must be set to TRUE
permutationResult <- runPermutation(
                        methylKitData = demoForTransgenerationalAnalysis, # multi-generational dataset
                        type = "tiles",     # Only tiles
                        outputDir = "test_restart",   # RDS files are created
                        runObservationAnalysis = TRUE,
                        nbrCores = 1,           # Number of cores used
                        nbrPermutations = 2,    # Should be much higher for a
                                                # real analysis
                        vSeed = 212201,     # Ensure reproducible results
                        restartCalculation = TRUE)         

## ----demoRaw1, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE--------
## The list of methylRaw objects for all controls and cases related to F1
f1_list <- list()
f1_list[[1]] <- new("methylRaw", 
                    data.frame(chr = c("chr21", "chr21"), 
                    start = c(9764513, 9764542), 
                    end = c(9764513, 9764542), strand = c("+", "-"), 
                    coverage = c(100, 15), numCs = c(88, 2), 
                    numTs = c(100, 15) - c(88, 2)), 
                    sample.id = "F1_control_01", assembly = "hg19", 
                    context = "CpG", resolution = 'base')
f1_list[[2]] <- new("methylRaw", 
                    data.frame(chr = c("chr21", "chr21"), 
                    start = c(9764513, 9764522), 
                    end = c(9764513, 9764522), strand = c("-", "-"), 
                    coverage = c(38, 21), numCs = c(12, 2), 
                    numTs = c(38, 21) - c(12, 2)), 
                    sample.id = "F1_case_02", assembly = "hg19", 
                    context = "CpG", resolution = 'base')

## The list of methylRaw objects for all controls and cases related to F2
f2_list <- list()
f2_list[[1]] <- new("methylRaw", 
                    data.frame(chr = c("chr21", "chr21"), 
                    start = c(9764514, 9764522), 
                    end = c(9764514, 9764522), strand = c("+", "+"), 
                    coverage = c(40, 30), numCs = c(0, 2), 
                    numTs = c(40, 30) - c(0, 2)), 
                    sample.id = "F2_control_01", assembly = "hg19", 
                    context = "CpG", resolution = 'base')
f2_list[[2]] <- new("methylRaw", 
                    data.frame(chr = c("chr21", "chr21"), 
                    start = c(9764513, 9764533), 
                    end = c(9764513, 9764533), strand = c("+", "-"), 
                    coverage = c(33, 23), numCs = c(12, 1), 
                    numTs = c(33, 23) - c(12, 1)), 
                    sample.id = "F2_case_01", assembly = "hg19", 
                    context = "CpG", resolution = 'base')

## The list to use as input for methylInheritance 
final_list <- list()

## The methylRawList for F1 - the first generation is on the first position
final_list[[1]] <- new("methylRawList", f1_list, treatment = c(0,1))
## The methylRawList for F2 - the second generation is on the second position
final_list[[2]] <- new("methylRawList", f2_list, treatment = c(0,1))

## A list of methylRawList ready for methylInheritance
final_list

## ----demoRaw2, warning=FALSE, message=FALSE, collapse=TRUE, cache=TRUE--------
library(methylKit)

## The methylRawList for F1
generation_01 <- methRead(location = list("demo/F1_control_01.txt", "demo/F1_case_01.txt"), 
                    sample.id = list("F1_control_01", "F1_case_01"), 
                    assembly = "hg19", treatment = c(0, 1), context = "CpG")

## The methylRawList for F2
generation_02 <- methRead(location = list("demo/F2_control_01.txt", "demo/F2_case_01.txt"), 
                    sample.id = list("F2_control_01", "F2_case_01"), 
                    assembly = "hg19", treatment = c(0, 1), context = "CpG")

## A list of methylRawList ready for methylInheritance
final_list <- list(generation_01, generation_02)
final_list

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

