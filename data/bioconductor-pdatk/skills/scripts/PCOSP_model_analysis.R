# Code example from 'PCOSP_model_analysis' vignette. See references/ for full tutorial.

## ----include=FALSE, echo=FALSE, eval=TRUE-------------------------------------
library(BiocParallel)

if (Sys.info()['sysname'] == 'windows') {
    BiocParallel::register(BiocParallel::SerialParam())
}

## ----load_dependencies, message=FALSE, warning=FALSE, include=FALSE-----------
library(PDATK)
library(msigdbr)
library(data.table)

## ----load_sample_data---------------------------------------------------------
data(sampleCohortList)
sampleCohortList

## ----subset_and_split_data----------------------------------------------------
commonGenes <- findCommonGenes(sampleCohortList)
# Subsets all list items, with subset for specifying rows and select for
# specifying columns
cohortList <- subset(sampleCohortList, subset=commonGenes)

ICGCcohortList <- cohortList[grepl('ICGC', names(cohortList), ignore.case=TRUE)]
validationCohortList <- cohortList[!grepl('icgc', names(cohortList),
    ignore.case=TRUE)]

## ----drop_not_censored_patients-----------------------------------------------
validationCohortList <- dropNotCensored(validationCohortList)
ICGCcohortList <- dropNotCensored(ICGCcohortList)

## ----split_train_test---------------------------------------------------------
# find common samples between our training cohorts in a cohort list
commonSamples <- findCommonSamples(ICGCcohortList)

# split into shared samples for training, the rest for testing
ICGCtrainCohorts <- subset(ICGCcohortList, select=commonSamples)
ICGCtestCohorts <- subset(ICGCcohortList, select=commonSamples, invert=TRUE)

# merge our training cohort test data into the rest of the validation data
validationCohortList <- c(ICGCtestCohorts, validationCohortList)

# drop ICGCSEQ from the validation data, because it only has 7 patients
validationCohortList <- 
    validationCohortList[names(validationCohortList) != 'ICGCSEQ']

## ----build_PCOSP_model, message=FALSE-----------------------------------------
set.seed(1987)
PCOSPmodel <- PCOSP(ICGCtrainCohorts, minDaysSurvived=365, randomSeed=1987)

# view the model parameters; these make your model run reproducible
metadata(PCOSPmodel)$modelParams

## ----messages=FALSE, warning=FALSE--------------------------------------------
trainedPCOSPmodel <- trainModel(PCOSPmodel, numModels=15, minAccuracy=0.6)

metadata(trainedPCOSPmodel)$modelParams

## ----PCOSP_predictions, message=FALSE, warning=FALSE--------------------------
PCOSPpredValCohorts <- predictClasses(validationCohortList,
    model=trainedPCOSPmodel)

## ----predicted_elementMetadata------------------------------------------------
mcols(PCOSPpredValCohorts)

## ----risk_column--------------------------------------------------------------
knitr::kable(head(colData(PCOSPpredValCohorts[[1]])))

## ----raw_predictions----------------------------------------------------------
knitr::kable(metadata(PCOSPpredValCohorts[[1]])$PCOSPpredictions[1:5, 1:5])

## ----validate_PCOSP_model, message=FALSE, warning=FALSE-----------------------
validatedPCOSPmodel <- validateModel(trainedPCOSPmodel,
    valData=PCOSPpredValCohorts)

## ----validationStats----------------------------------------------------------
knitr::kable(head(validationStats(validatedPCOSPmodel)))

## ----PCOSP_D_index_forestplot, fig.width=8, fig.height=8, fig.wide=TRUE-------
PCOSPdIndexForestPlot <- forestPlot(validatedPCOSPmodel, stat='log_D_index')
PCOSPdIndexForestPlot

## ----PCOSP_concordance_index_forestplot, fig.width=8, fig.height=8, fig.wide=TRUE----
PCOSPconcIndexForestPlot <- forestPlot(validatedPCOSPmodel, stat='concordance_index')
PCOSPconcIndexForestPlot

## ----PCOSP_ROC_curve, fig.height=8, fig.width=8, fig.wide=TRUE, message=FALSE----
cohortROCplots <- plotROC(validatedPCOSPmodel, alpha=0.05)
cohortROCplots

## ----RLSModeL_constructor-----------------------------------------------------
# Merge to a single SurvivalExperiment
ICGCtrainCohorts <- merge(ICGCtrainCohorts[[1]], ICGCtrainCohorts[[2]], 
    cohortNames=names(ICGCtrainCohorts))
RLSmodel <- RLSModel(ICGCtrainCohorts, minDaysSurvived=365, randomSeed=1987)

## ----RLSModel_training--------------------------------------------------------
trainedRLSmodel <- trainModel(RLSmodel, numModels=15)

## ----RLSModel_predictions-----------------------------------------------------
RLSpredCohortList <- predictClasses(validationCohortList, model=trainedRLSmodel)

## ----RLSModel_validation------------------------------------------------------
validatedRLSmodel <- validateModel(trainedRLSmodel, RLSpredCohortList)

## ----RLSModel_PCOSP_comparison_plot, fig.width=8, fig.height=8, fig.wide=TRUE----
RLSmodelComparisonPlot <- densityPlotModelComparison(validatedRLSmodel,
    validatedPCOSPmodel, title='Random Label Shuffling vs PCOSP',
    mDataTypeLabels=c(rna_seq='Sequencing-based', rna_micro='Array-based',
        combined='Overall'))
RLSmodelComparisonPlot

## ----RGAModeL_constructor-----------------------------------------------------
RGAmodel <- RGAModel(ICGCtrainCohorts, randomSeed=1987)

## ----RGAModel_training--------------------------------------------------------
trainedRGAmodel <- trainModel(RGAmodel, numModels=15)

## ----RGAModel_predictions-----------------------------------------------------
RGApredCohortList <- predictClasses(validationCohortList,
    model=trainedRGAmodel)

## ----RGAModel_validation------------------------------------------------------
validatedRGAmodel <- validateModel(trainedRGAmodel, RGApredCohortList)

## ----RGAModel_PCOSP_comparison_plot, fig.width=8, fig.height=8, fig.wide=TRUE----
RGAmodelComparisonPlot <-  densityPlotModelComparison(validatedRGAmodel,
    validatedPCOSPmodel, title='Random Gene Assignment vs PCOSP',
    mDataTypeLabels=c(rna_seq='Sequencing-based', rna_micro='Array-based',
        combined='Overall'))
RGAmodelComparisonPlot

## ----PCOSP_get_top_features---------------------------------------------------
topFeatures <- getTopFeatures(validatedPCOSPmodel)
topFeatures

## ----msigdbr_get_pathways, eval=FALSE-----------------------------------------
# allHumanGeneSets <- msigdbr()
# allGeneSets <- as.data.table(allHumanGeneSets)
# geneSets <- allGeneSets[grepl('^GO.*|.*CANONICAL.*|^HALLMARK.*', gs_name),
#     .(gene_symbol, gs_name)]

## ----PCOSP_runGSEA, eval=FALSE------------------------------------------------
# GSEAresultDT <- runGSEA(validatedPCOSPmodel, geneSets)

## ----training_data_patient_metadata-------------------------------------------
knitr::kable(head(colData(ICGCtrainCohorts)))

## ----ClinicalModel_constructor------------------------------------------------
clinicalModel <- ClinicalModel(ICGCtrainCohorts,
    formula='prognosis ~ sex + age + T + N + M + grade',
    randomSeed=1987)

## ----ClinicalModel_training---------------------------------------------------
trainedClinicalModel <- trainModel(clinicalModel)

## ----ClinicalModel_prediction-------------------------------------------------
hasModelParamsCohortList <-
    PCOSPpredValCohorts[c('ICGCMICRO', 'TCGA', 'PCSI', 'OUH')]

clinicalPredCohortList <- predictClasses(hasModelParamsCohortList,
    model=trainedClinicalModel)

## ----ClinicalModel_predictions------------------------------------------------
validatedClinicalModel <- validateModel(trainedClinicalModel,
    clinicalPredCohortList)

## ----ClinicalModel_vs_PCOSP_AUC_barplot, fig.wide=TRUE, fig.width=8, fig.height=8----
clinicalVsPCOSPbarPlot <- barPlotModelComparison(validatedClinicalModel,
    validatedPCOSPmodel, stat='AUC')
clinicalVsPCOSPbarPlot

## ----ModelComparison_object---------------------------------------------------
clinicalVsPCOSP <- compareModels(validatedClinicalModel, validatedPCOSPmodel)

## ----ClinicalModel_vs_PCOSP_dIndex, fig.wide=TRUE, fig.height=8, fig.width=8----
clinVsPCOSPdIndexForestPlot <- forestPlot(clinicalVsPCOSP, stat='log_D_index')
clinVsPCOSPdIndexForestPlot

## ----ClinicalModel_vs_PCOSP_concIndex, fig.wide=TRUE, fig.height=8, fig.width=8----
clinVsPCOSPconcIndexForestPlot <- forestPlot(clinicalVsPCOSP,
    stat='concordance_index')
clinVsPCOSPconcIndexForestPlot

## ----GeneFuModel_constructor--------------------------------------------------
chenGeneFuModel <- GeneFuModel(randomSeed=1987)
birnbaumGeneFuModel <- GeneFuModel(randomSeed=1987)
haiderGeneFuModel <- GeneFuModel(randomSeed=1987)

## ----GeneFuModel_assign_models------------------------------------------------
data(existingClassifierData)

models(chenGeneFuModel) <- SimpleList(list(chen=chen))
models(birnbaumGeneFuModel) <- SimpleList(list(birnbuam=birnbaum))
models(haiderGeneFuModel) <- SimpleList(list(haider=NA)) 

## ----GeneFuModel_predictions--------------------------------------------------
chenClassPredictions <- predictClasses(PCOSPpredValCohorts[names(haiderSigScores)],
    model=chenGeneFuModel)
birnClassPredictions <- predictClasses(PCOSPpredValCohorts[names(haiderSigScores)],
    model=birnbaumGeneFuModel)

## ----GeneFuModel_haider_fix---------------------------------------------------
haiderClassPredictions <- PCOSPpredValCohorts[names(haiderSigScores)]
# Manually assign the scores to the prediction cohorts
for (i in seq_along(haiderClassPredictions)) {
  colMData <- colData(haiderClassPredictions[[i]])
  colMData$genefu_score <- NA_real_
  colMData[rownames(colMData) %in% names(haiderSigScores[[i]]), ]$genefu_score <- 
      haiderSigScores[[i]][names(haiderSigScores[[i]]) %in% rownames(colMData)]
  colData(haiderClassPredictions[[i]]) <- colMData
}
# Setup the correct model metadata
mcols(haiderClassPredictions)$hasPredictions <- TRUE
metadata(haiderClassPredictions)$predictionModel <- haiderGeneFuModel

## -----------------------------------------------------------------------------
validatedChenModel <- validateModel(chenGeneFuModel, valData=chenClassPredictions)
validatedBirnbaumModel <- validateModel(birnbaumGeneFuModel, 
    valData=birnClassPredictions)
validatedHaiderModel <- validateModel(haiderGeneFuModel, valData=haiderClassPredictions)

## ----comparing_GeneFuModels---------------------------------------------------
genefuModelComparisons <- compareModels(validatedChenModel,
    validatedBirnbaumModel, modelNames=c('Chen', 'Birnbaum'))
genefuModelComparisons <- compareModels(genefuModelComparisons,
    validatedHaiderModel, model2Name='Haider')

## ----comparing_comparisons----------------------------------------------------
allModelComparisons <- compareModels(genefuModelComparisons, validatedPCOSPmodel, 
  model2Name='PCOSP')
# We are only interested in comparing the summaries, so we subset our model comparison
allModelComparisons <- subset(allModelComparisons, isSummary == TRUE)

## ----plotting Model_Comparisons_dindex, fig.width=8, fig.height=8, fig.wide=TRUE----
allDindexComparisonForestPlot <- forestPlot(allModelComparisons,
    stat='log_D_index', colourBy='model', groupBy='mDataType')
allDindexComparisonForestPlot

## ----plotting Model Comparisons_concindex, fig.width=8, fig.height=8, fig.wide=TRUE----
allConcIndexComparisonForestPlot <- forestPlot(allModelComparisons,
    stat='concordance_index', colourBy='model', groupBy='mDataType')
allConcIndexComparisonForestPlot

## ----adding_subtypes_to_CohortList--------------------------------------------
data(cohortSubtypeDFs)

# Add the subtypes to the prediction cohort
subtypedPCOSPValCohorts <- assignSubtypes(PCOSPpredValCohorts, cohortSubtypeDFs)

## ----validateModel_with_subtypes----------------------------------------------
subtypeValidatedPCOSPmodel <- validateModel(trainedPCOSPmodel, valData=subtypedPCOSPValCohorts)

## ----forestPlot_Dindex_subtyped_PCOSP_model, fig.width=8, fig.height=8, fig.wide=TRUE----
forestPlot(subtypeValidatedPCOSPmodel, stat='log_D_index', groupBy='cohort',
    colourBy='subtype')

## ----forestPlot_Cindex_subtyped_PCOSP_model, fig.width=8, fig.height=8, fig.wide=TRUE----
forestPlot(subtypeValidatedPCOSPmodel, stat='concordance_index', groupBy='cohort',
    colourBy='subtype')

