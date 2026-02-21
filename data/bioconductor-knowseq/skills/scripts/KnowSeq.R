# Code example from 'KnowSeq' vignette. See references/ for full tutorial.

## ----setup, cache = F, echo = FALSE-------------------------------------------
knitr::opts_chunk$set(error = TRUE,warning = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("KnowSeq")
# 
# library(KnowSeq)

## ----eval=FALSE---------------------------------------------------------------
# # Downloading one series from NCBI/GEO and one series from ArrayExpress
# downloadPublicSeries(c("GSE74251"))
# 
# # Using read.csv for NCBI/GEO files (read.csv2 for ArrayExpress files)
# GSE74251csv <- read.csv("ReferenceFiles/GSE74251.csv")
# 
# # Performing the alignment of the samples by using hisat2 aligner
# rawAlignment(GSE74251csv,downloadRef=TRUE,downloadSamples=TRUE,BAMfiles = TRUE,
# SAMfiles = TRUE,countFiles = TRUE,referenceGenome = 38, fromGDC = FALSE, customFA = "",
# customGTF = "", tokenPath = "", manifest = "")

## ----eval=FALSE---------------------------------------------------------------
# # GDC portal controlled data processing with automatic raw data download
# 
# rawAlignment(x, downloadRef=TRUE, downloadSamples=TRUE, fromGDC = TRUE,
# tokenPath = "~/pathToToken", manifestPath = "~/pathToManifest")

## ----Preparing_data-----------------------------------------------------------
suppressMessages(library(KnowSeq))

dir <- system.file("extdata", package="KnowSeq")

# Using read.csv for NCBI/GEO files and read.csv2 for ArrayExpress files

GSE74251 <- read.csv(paste(dir,"GSE74251.csv",sep = "/"))
GSE81593 <- read.csv(paste(dir,"GSE81593.csv",sep = "/"))

# Creating the csv file with the information about the counts files location and the labels
Run <- GSE74251$Run
Path <- paste(dir,"/countFiles/",GSE74251$Run,sep = "")
Class <- rep("Tumor", length(GSE74251$Run))
GSE74251CountsInfo <-  data.frame(Run = Run, Path = Path, Class = Class)

Run <- GSE81593$Run
Path <- paste(dir,"/countFiles/",GSE81593$Run,sep = "")
Class <- rep("Control", length(GSE81593$Run))
GSE81593CountsInfo <-  data.frame(Run = Run, Path = Path, Class = Class)

mergedCountsInfo <- rbind(GSE74251CountsInfo, GSE81593CountsInfo)

write.csv(mergedCountsInfo, file = "mergedCountsInfo.csv")



## ----eval=FALSE---------------------------------------------------------------
# dir <- system.file("script", package="KnowSeq")
# 
# # Code to execute the example script
# source(paste(dir,"/KnowSeqExample.R",sep=""))
# 
# 
# # Code to edit the example script
# file.edit(paste(dir,"/KnowSeqExample.R",sep=""))
# 

## ----Merging_files------------------------------------------------------------
# Merging in one matrix all the count files indicated inside the CSV file

countsInformation <- countsToMatrix("mergedCountsInfo.csv", extension = "count")

# Exporting to independent variables the counts matrix and the labels

countsMatrix <- countsInformation$countsMatrix

labels <- countsInformation$labels

## ----Downloading_annotation---------------------------------------------------
# Downloading human annotation
myAnnotation <- getGenesAnnotation(rownames(countsMatrix))

# Downloading mus musculus annotation
myAnnotationMusMusculus <- getGenesAnnotation(rownames(countsMatrix), 
notHSapiens = TRUE,notHumandataset = "mm129s1svimj_gene_ensembl")


## ----Calculating_gene_expression----------------------------------------------
# Calculating gene expression values matrix using the counts matrix

expressionMatrix <- calculateGeneExpressionValues(countsMatrix,myAnnotation,
genesNames = TRUE)

## ----Plotting_boxplot---------------------------------------------------------
# Plotting the boxplot of the expression of each samples for all the genes

dataPlot(expressionMatrix,labels,mode = "boxplot", toPNG = TRUE,
toPDF = TRUE)

## ----Removing_batch_effect_combat---------------------------------------------
# Removing batch effect by using combat and known batch groups 

batchGroups <- c(1,1,1,1,2,2,1,2,1,2)

expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels, 
batchGroups = batchGroups, method = "combat")


## ----Removing_batch_effect_sva------------------------------------------------
# Calculating the surrogate variable analysis to remove batch effect

expressionMatrixCorrected <- batchEffectRemoval(expressionMatrix, labels, method = "sva")

## ----DEGs without batch-------------------------------------------------------
# Extracting DEGs that pass the imposed restrictions

DEGsInformation <- DEGsExtraction(expressionMatrixCorrected, labels,
lfc = 1.0, pvalue = 0.01, number = 100, cov = 1)

topTable <- DEGsInformation$DEG_Results$DEGs_Table

DEGsMatrix <- DEGsInformation$DEG_Results$DEGs_Matrix

## ----Plotting_orderded_boxplot------------------------------------------------
# Plotting the expression of the first 12 DEGs for each of the samples in an ordered way

dataPlot(DEGsMatrix[1:12,],labels,mode = "orderedBoxplot",toPNG = FALSE,toPDF = FALSE)

## ----Plotting_genes_boxplot---------------------------------------------------
# Plotting the expression of the first 12 DEGs separatelly for all the samples

dataPlot(DEGsMatrix[1:12,],labels,mode = "genesBoxplot",toPNG = FALSE,toPDF = FALSE)

## ----Plotting_heatmap---------------------------------------------------------
# Plotting the heatmap of the first 12 DEGs separatelly for all the samples

dataPlot(DEGsMatrix[1:12,],labels,mode = "heatmap",toPNG = FALSE,toPDF = FALSE)

## ----Assessing_machine_learning_step------------------------------------------
DEGsMatrixML <- t(DEGsMatrix)

# Feature selection process with mRMR and RF 
mrmrRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "mrmr")
rfRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "rf")
daRanking <- featureSelection(DEGsMatrixML,labels,colnames(DEGsMatrixML), mode = "da", disease = "breast")

# CV functions with k-NN, SVM and RF
results_cv_knn <- knn_trn(DEGsMatrixML,labels,names(mrmrRanking)[1:10],5)

results_cv_svm <- svm_trn(DEGsMatrixML,labels,rfRanking[1:10],5)

results_cv_rf <- rf_trn(DEGsMatrixML,labels,names(daRanking)[1:10],5)


## ----Plotting_ML_acc----------------------------------------------------------
# Plotting the accuracy of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$accuracy$meanAccuracy,results_cv_knn$accuracy$standardDeviation),mode = "classResults", legend = c("Mean Acc","Standard Deviation"),
main = "Mean Accuracy with k-NN", xlab = "Genes", ylab = "Accuracy")

## ----Plotting_ML_sens---------------------------------------------------------
# Plotting the sensitivity of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$sensitivity$meanSensitivity,results_cv_knn$sensitivity$standardDeviation),mode = "classResults", legend = c("Mean Sens","Standard Deviation"),
main = "Mean Sensitivity with k-NN", xlab = "Genes", ylab = "Sensitivity")

## ----Plotting_ML_spec---------------------------------------------------------
# Plotting the specificity of all the folds evaluated in the CV process

dataPlot(rbind(results_cv_knn$specificity$meanSpecificity,results_cv_knn$specificity$standardDeviation),mode = "classResults", legend = c("Mean Spec","Standard Deviation"),
main = "Mean Specificity with k-NN", xlab = "Genes", ylab = "Specificity")

## ----Plotting_ML_Heatmap------------------------------------------------------
# Plotting all the metrics depending on the number of used DEGs in the CV process

dataPlot(results_cv_knn,labels,mode = "heatmapResults")

## ----Plotting_ML_confs--------------------------------------------------------
# Plotting the confusion matrix with the sum of the confusion matrices 
# of each folds evaluated in the CV process

allCfMats <- results_cv_knn$cfMats[[1]]$table + results_cv_knn$cfMats[[2]]$table + 
results_cv_knn$cfMats[[3]]$table + results_cv_knn$cfMats[[4]]$table + 
results_cv_knn$cfMats[[5]]$table

dataPlot(allCfMats,labels,mode = "confusionMatrix")


## ----Assessing_ML_test--------------------------------------------------------
# Test functions with k-NN, SVM and RF
trainingMatrix <- DEGsMatrixML[c(1:4,6:9),]
trainingLabels <- labels[c(1:4,6:9)]
testMatrix <- DEGsMatrixML[c(5,10),]
testLabels <- labels[c(5,10)]

results_test_knn <- knn_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, names(mrmrRanking)[1:10], bestK = results_cv_knn$bestK)

results_test_svm <- svm_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, rfRanking[1:10], bestParameters = results_cv_svm$bestParameters)

results_test_rf <- rf_test(trainingMatrix, trainingLabels, testMatrix,
testLabels, colnames(DEGsMatrixML)[1:10], results_cv_rf$bestParameters)

## ----Plotting_ML_acc_test-----------------------------------------------------
# Plotting the accuracy achieved in the test process

dataPlot(results_test_knn$accVector,mode = "classResults",
main = "Accuracy with k-NN", xlab = "Genes", ylab = "Accuracy")

dataPlot(results_test_svm$accVector,mode = "classResults",
main = "Accuracy with SVM", xlab = "Genes", ylab = "Accuracy")

dataPlot(results_test_rf$accVector,mode = "classResults",
main = "Accuracy with RF", xlab = "Genes", ylab = "Accuracy")

## ----Retrieving_GOs, message=FALSE--------------------------------------------
# Retrieving the GO information from the three different ontologies

GOsList <- geneOntologyEnrichment(names(mrmrRanking)[1:10], geneType='GENE_SYMBOL', pvalCutOff=0.1)

## ----Downloading_pathways eval------------------------------------------------
# Retrieving the pathways related to the DEGs
paths <- DEGsToPathways(names(mrmrRanking)[1:10])
print(paths)


## ----Downloading_diseases-----------------------------------------------------
# Downloading the information about the DEGs related diseases

diseasesTargetValidation <- DEGsToDiseases(rownames(DEGsMatrix)[1:5], getEvidences = FALSE)

diseasesTargetValidation


## ----eval=FALSE---------------------------------------------------------------
# # Performing the automatic and intelligent KnowSeq report
# knowseqReport(expressionMatrix,labels,'knowSeq-report',clasifAlgs=c('knn'),disease='breast-cancer', lfc = 2, pvalue = 0.001, geneOntology = T, getPathways = T)

## ----Session_info-------------------------------------------------------------
sessionInfo()

