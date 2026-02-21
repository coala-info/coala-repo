# Code example from 'pulsedsilac' vignette. See references/ for full tutorial.

## ---- eval = FALSE------------------------------------------------------------
#  
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("pulsedSilac")
#  

## ---- eval = FALSE------------------------------------------------------------
#  
#  BiocManager::install('marcpaga/pulsedSilac')
#  

## ---- message = FALSE---------------------------------------------------------
require(pulsedSilac)

## assays
assays_protein <- list(expression = matrix(1:9, ncol = 3))

## colData
colData <- data.frame(sample = c('A1', 'A2', 'A3'),
                      condition = c('A', 'A', 'A'),
                      time = c(1, 2, 3))
## rowData
rowData_protein <- data.frame(prot_id = LETTERS[1:3])

## construct the SilacProteinExperiment
protExp <- SilacProteinExperiment(assays = assays_protein, 
                                  rowData = rowData_protein, 
                                  colData = colData, 
                                  conditionCol = 'condition', 
                                  timeCol = 'time')
protExp

## -----------------------------------------------------------------------------

## assays
assays_peptide <- list(expression = matrix(1:15, ncol = 3))

## colData
colData <- data.frame(sample = c('A1', 'A2', 'A3'),
                      condition = c('A', 'A', 'A'),
                      time = c(1, 2, 3))
## rowData
rowData_peptide <- data.frame(pept_id = letters[1:5], 
                              prot_id = c('A', 'A', 'B', 'C', 'C')) 
## construct the SilacProteinExperiment
peptExp <- SilacPeptideExperiment(assays = assays_peptide, 
                                  rowData = rowData_peptide, 
                                  colData = colData, 
                                  conditionCol = 'condition', 
                                  timeCol = 'time')
peptExp

## -----------------------------------------------------------------------------
## assays
assays(protExp)
assays(peptExp)

## -----------------------------------------------------------------------------
## rowData
rowData(protExp)
rowData(peptExp)

## -----------------------------------------------------------------------------
## colData
colData(protExp)
colData(peptExp)

## -----------------------------------------------------------------------------
## metaoptions
metaoptions(protExp)

metaoptions(peptExp)[['proteinCol']] <- 'prot_id'
metaoptions(peptExp)

## -----------------------------------------------------------------------------
## subsetting by rows and columns
protExp[1, 1:2]
peptExp[1, 1:2]

## subsetting by rows based on rowData
subset(protExp, prot_id == 'A')
subset(peptExp, pept_id %in% c('a', 'b'))

## quick acces to colData
protExp$sample
peptExp$condition

## -----------------------------------------------------------------------------
## combining by columns
cbind(protExp[, 1], protExp[, 2:3])

## combining by rows
rbind(peptExp[1:3,], peptExp[4:5, ])

## combine rows and columns
merge(peptExp[1:3, 1], peptExp[3:5, 2:3])

## -----------------------------------------------------------------------------
ProteomicsExp <- SilacProteomicsExperiment(SilacProteinExperiment = protExp, 
                                           SilacPeptideExperiment = peptExp)
ProteomicsExp

## -----------------------------------------------------------------------------
## list with the relationships
protein_to_peptide <- list(A = c('a', 'b'), B = c('c'), C = c('d', 'e'))
## function to build the data.frame
linkerDf <- buildLinkerDf(protIDs = LETTERS[1:3], 
                          pepIDs  = letters[1:5], 
                          protToPep = protein_to_peptide)
linkerDf

ProteomicsExp <- SilacProteomicsExperiment(SilacProteinExperiment = protExp, 
                                           SilacPeptideExperiment = peptExp, 
                                           linkerDf = linkerDf)

## -----------------------------------------------------------------------------
## colData
colData(ProteomicsExp)

## -----------------------------------------------------------------------------
## linkerDf
linkerDf(ProteomicsExp)

## -----------------------------------------------------------------------------
## metaoptions
metaoptions(ProteomicsExp)

## -----------------------------------------------------------------------------
## assays
assays(ProteomicsExp)

## -----------------------------------------------------------------------------
## rowData
rowData(ProteomicsExp)

## -----------------------------------------------------------------------------
## assays of protein level
assaysProt(ProteomicsExp)

## assays of peptide level
assaysPept(ProteomicsExp)

## -----------------------------------------------------------------------------
## rowData of protein level
rowDataProt(ProteomicsExp)

## rowData of peptide level
rowDataPept(ProteomicsExp)

## -----------------------------------------------------------------------------

ProtExp(ProteomicsExp)

PeptExp(ProteomicsExp)


## -----------------------------------------------------------------------------
## indicate which rowDat columns have unique ids for proteins and peptides
metaoptions(ProteomicsExp)[['idColProt']] <- 'prot_id'
metaoptions(ProteomicsExp)[['idColPept']] <- 'pept_id'
## indicate that we want to apply the subset at protein level
metaoptions(ProteomicsExp)[['subsetMode']] <- 'protein'
## and not extend it to the peptide level
metaoptions(ProteomicsExp)[['linkedSubset']] <- FALSE

ProteomicsExp[1:2,]

## -----------------------------------------------------------------------------
## to extend we set the metaoption to TRUE
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE

ProteomicsExp[1:2,]

## -----------------------------------------------------------------------------
## indicate that we want to apply the subset at protein level
metaoptions(ProteomicsExp)[['subsetMode']] <- 'peptide'
## to extend we set the metaoption to TRUE
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE

ProteomicsExp[1:2,]

## -----------------------------------------------------------------------------
## without linked Subset
metaoptions(ProteomicsExp)[['linkedSubset']] <- FALSE
subsetProt(ProteomicsExp, prot_id == 'B')

## -----------------------------------------------------------------------------
## with linked Subset
metaoptions(ProteomicsExp)[['linkedSubset']] <- TRUE
subsetProt(ProteomicsExp, prot_id == 'B')

## -----------------------------------------------------------------------------
## cbind
cbind(ProteomicsExp[, 1], ProteomicsExp[, 2])

## -----------------------------------------------------------------------------
## rbind
rbind(ProteomicsExp[1:2,], ProteomicsExp[3,])

## -----------------------------------------------------------------------------
## merge
merge(ProteomicsExp[1:3, 1], ProteomicsExp[3:4, 2:3])

## ---- echo = FALSE------------------------------------------------------------
## load objects required for the vignette
data('wormsPE')
data('mefPE')
data('recycleLightLysine')

## -----------------------------------------------------------------------------
wormsPE

## -----------------------------------------------------------------------------
barplotCounts(wormsPE, assayName = 'ratio')

## -----------------------------------------------------------------------------
barplotTimeCoverage(wormsPE, assayName = 'ratio')

## -----------------------------------------------------------------------------

wormsPE2 <- filterByMissingTimepoints(wormsPE, 
                                      assayName = 'ratio', 
                                      maxMissing = 2, 
                                      strict = FALSE)

barplotTimeCoverage(wormsPE2, assayName = 'ratio')


## -----------------------------------------------------------------------------

upsetTimeCoverage(ProtExp(wormsPE2), 
                  assayName = 'ratio', 
                  maxMissing = 2)


## ---- eval = FALSE------------------------------------------------------------
#  
#  subsetProt(wormsPE, Unique.peptides > 2)
#  

## ---- eval = FALSE------------------------------------------------------------
#  
#  subsetProt(wormsPE, Potential.contaminant != '+')
#  subsetProt(wormsPE, Reverse != '+')
#  
#  

## ---- eval = FALSE------------------------------------------------------------
#  
#  ## calculate the ratio of new istope over old isotope
#  wormsPE <- calculateIsotopeRatio(x = wormsPE,
#                                   newIsotopeAssay = 'int_heavy',
#                                   oldIsotopeAssay = 'int_light')
#  

## ---- eval = TRUE-------------------------------------------------------------

wormsPE <- calculateIsotopeFraction(wormsPE, ratioAssay = 'ratio')

assaysProt(wormsPE)
assaysPept(wormsPE)


## ---- eval = FALSE------------------------------------------------------------
#  
#  wormsPE <- calculateIsotopeFraction(wormsPE,
#                                      newIsoAssay = 'int_heavy',
#                                      oldIsoAssay = 'int_light',
#                                      earlyTimepoints = 1,
#                                      lateTimepoints = 7)
#  

## ---- warning = FALSE---------------------------------------------------------

plotDistributionAssay(wormsPE, assayName = 'fraction')


## -----------------------------------------------------------------------------

protPE <- ProtExp(wormsPE)

scatterCompareAssays(x = protPE, 
                     conditions = c('OW40', 'OW450'), 
                     assayName = 'ratio')


## -----------------------------------------------------------------------------

scatterCompareAssays(x = protPE, 
                     conditions = c('OW40', 'OW450'),
                     assayName = 'int_total')


## ---- warning = FALSE---------------------------------------------------------

modelList <- modelTurnover(x = wormsPE, 
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein',
                           returnModel = TRUE)


## -----------------------------------------------------------------------------
modelList[['half_life']] <- log(0.5)/(-modelList$param_values$k)


## ---- warning = FALSE---------------------------------------------------------

modelList <- modelTurnover(x = wormsPE, 
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein', 
                           returnModel = TRUE)

plotIndividualModel(x = wormsPE, 
                    modelList = modelList, 
                    num = 2)


## ---- warning = FALSE---------------------------------------------------------

## to indicate which column of rowDataPept indicates the assigned protein
metaoptions(wormsPE)[['proteinCol']] <- 'Protein.group.IDs'
modelList <- modelTurnover(x = wormsPE, 
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'grouped', 
                           returnModel = TRUE)

plotIndividualModel(x = wormsPE, 
                    modelList = modelList, 
                    num = 2)


## ---- eval = TRUE, include = TRUE, warning = FALSE----------------------------
modelList <- modelTurnover(x = wormsPE, 
                           assayName = 'fraction',
                           formula = 'fraction ~ 1 - exp(-k*t)',
                           start = list(k = 0.02),
                           mode = 'protein', 
                           robust = TRUE,
                           returnModel = TRUE)


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList,
                      value = 'stderror',
                      plotType = 'density')


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList,
                      value = 'param_values',
                      plotType = 'density')


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList,
                      value = 'residuals',
                      plotType = 'density')


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList,
                      value = 'weights',
                      plotType = 'density')


## ----echo=FALSE---------------------------------------------------------------
modelList[['half_life']] <- log(0.5)/(-modelList$param_values$k)


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList,
                      value = 'half_life',
                      plotType = 'density')


## -----------------------------------------------------------------------------

scatterCompareModels(modelList = modelList, 
                     conditions = c('OW40', 'OW450'), 
                     value = 'param_values')

scatterCompareModels(modelList = modelList, 
                     conditions = c('OW40', 'OW450'), 
                     value = 'stderror')

## ---- warning = FALSE, message = FALSE----------------------------------------

modelList <- calculateAIC(modelList, smallSampleSize = TRUE)


## -----------------------------------------------------------------------------

names(modelList)


## ---- warning = FALSE, message = FALSE----------------------------------------

plotDistributionModel(modelList = modelList, value = 'AIC')


## ---- warning = FALSE, include=TRUE-------------------------------------------
modelList1 <- modelTurnover(x = wormsPE, 
                            assayName = 'fraction',
                            formula = 'fraction ~ 1 - exp(-k*t)',
                            start = list(k = 0.02),
                            mode = 'protein', 
                            robust = FALSE,
                            returnModel = TRUE)

modelList1 <- calculateAIC(modelList = modelList1, 
                           smallSampleSize = TRUE)

modelList2 <- modelTurnover(x = wormsPE, 
                            assayName = 'fraction',
                            formula = 'fraction ~ 1 - exp(-k*t) + b',
                            start = list(k = 0.02, b = 0),
                            mode = 'protein', 
                            robust = FALSE,
                            returnModel = TRUE)

modelList2 <- calculateAIC(modelList = modelList2, 
                           smallSampleSize = TRUE)

## ---- warning = FALSE, message = FALSE----------------------------------------

modelProbabilities <- compareAIC(modelList1, modelList2)

plotDistributionModel(modelList = modelProbabilities, 
                      value = 'aicprobabilities', 
                      returnDataFrame = FALSE)


## ---- warning = FALSE---------------------------------------------------------

mefPE


## ---- warning = FALSE---------------------------------------------------------

plotDistributionAssay(mefPE, assayName = 'fraction')


## ---- warning = FALSE---------------------------------------------------------

stablePE <- mostStable(mefPE, assayName = 'fraction', n = 50)

stablePE

## ---- warning = FALSE---------------------------------------------------------

stableModels  <- modelTurnover(x = stablePE, 
                               assayName = 'fraction',
                               formula = 'fraction ~ 1 - exp(-(log(2)/tc)*t)',
                               start = list(tc = 20),
                               mode = 'protein', 
                               robust = FALSE,
                               returnModel = FALSE)

plotDistributionModel(stableModels, value = 'param_values', plotType = 'boxplot')


## ---- warning = FALSE---------------------------------------------------------

apply(stableModels$param_values$tc, 2, mean)


## ---- warning = FALSE---------------------------------------------------------

modelsNoSerum <- modelTurnover(x = mefPE[, 1:5], 
                               assayName = 'fraction',
                               formula = 'fraction ~ 1 - exp(-(0.0074 + k)*t)',
                               start = list(k = 0.02),
                               mode = 'protein', 
                               robust = FALSE,
                               returnModel = TRUE)

modelsSerum <- modelTurnover(x = mefPE[, 6:10], 
                             assayName = 'fraction',
                             formula = 'fraction ~ 1 - exp(-(0.0276 + k)*t)',
                             start = list(k = 0.02),
                             mode = 'protein', 
                             robust = FALSE,
                             returnModel = TRUE)

modelsMef <- mergeModelsLists(modelsNoSerum, modelsSerum)


## ---- warning = FALSE---------------------------------------------------------


modelsNoCorrect <- modelTurnover(x = mefPE, 
                                 assayName = 'fraction',
                                 formula = 'fraction ~ 1 - exp(-(k)*t)',
                                 start = list(k = 0.02),
                                 mode = 'protein', 
                                 robust = FALSE,
                                 returnModel = TRUE)


## ---- warning = FALSE---------------------------------------------------------

plotDistributionModel(modelList = modelsMef,
                      value = 'param_values',
                      plotType = 'density') 


## ---- warning = FALSE---------------------------------------------------------

plotDistributionModel(modelList = modelsNoCorrect,
                      value = 'param_values',
                      plotType = 'density') 
 

## -----------------------------------------------------------------------------

protPE <- ProtExp(wormsPE)

missPE <- addMisscleavedPeptides(x = protPE, 
                                 newdata = recycleLightLysine, 
                                 idColPept = 'Sequence', 
                                 modCol = 'Modifications', 
                                 dataCols = c(18:31))

assays(missPE)

## -----------------------------------------------------------------------------

names(assays(missPE))[1:2] <- c('int_lys8lys8', 'int_lys8lys0')
missPE <- calculateOldIsotopePool(x = missPE, 'int_lys8lys8', 'int_lys8lys0')


## -----------------------------------------------------------------------------
plotDistributionAssay(missPE, assayName = 'oldIsotopePool')

## -----------------------------------------------------------------------------

protExp <- ProtExp(wormsPE)

as(protExp, 'SummarizedExperiment')


## -----------------------------------------------------------------------------
sessionInfo()

