# Code example from 'anota2seq' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE, error = FALSE, tidy = FALSE, eval = TRUE) # turn off verbosity
if(packageVersion("BiocStyle") < '2.5.0'){
    BiocStyle::latex2()
} else if(packageVersion("BiocStyle") >= '2.5.0'){
    BiocStyle::latex()
}

## ----load_library_and_data, echo=TRUE, eval = TRUE-------------------------
library(anota2seq)
data(anota2seq_data)

## ----gettingStarted, echo = TRUE, message = FALSE, results = 'hide', eval = TRUE----
ads <- anota2seqDataSetFromMatrix(
    dataP = anota2seq_data_P[1:1000,],
    dataT = anota2seq_data_T[1:1000,],
    phenoVec = anota2seq_pheno_vec,
    dataType = "RNAseq",
    normalize = TRUE)
ads <- anota2seqRun(ads)

## ----echo = FALSE, message = FALSE, results = 'hide', eval = TRUE----------
unlink(c("ANOTA2SEQ_interaction_p_distribution.pdf", "ANOTA2SEQ_residual_distribution_summary.jpeg", "ANOTA2SEQ_residual_vs_fitted.jpeg", "ANOTA2SEQ_rvm_fit_for_all_contrasts_group.jpg", "ANOTA2SEQ_rvm_fit_for_interactions.jpg", "ANOTA2SEQ_rvm_fit_for_omnibus_group.jpg", "ANOTA2SEQ_simulated_vs_obt_dfbetas_without_interaction.pdf"))

## ----gettingStartedVisualizeResults, echo = TRUE, message = FALSE, fig.env="figure", eval = TRUE, fig.cap = "Visualization of gene expression modes."----
anota2seqPlotFC(ads, selContrast = 1, plotToFile = FALSE)

## ----gettingStarted_getListOfSignificantGenes_translation, echo = TRUE, eval = TRUE----
head(
    anota2seqGetOutput(
        ads, analysis = "translation", output = "selected", getRVM = TRUE, 
        selContrast = 1)[, c("apvEff", "apvRvmPAdj", "singleRegMode")])

## ----load_data, echo=TRUE, eval=TRUE---------------------------------------
data(anota2seq_data)
# Polysome-associated mRNA and total mRNA columns must follow the same order
head(anota2seq_data_P, n = 2)
head(anota2seq_data_T, n = 2)
# phenoVec must describe the sample class for corresponding columns 
# in dataT and dataP
anota2seq_pheno_vec

## ----initialize_object_from_matrix, echo = TRUE, message = FALSE, eval = TRUE----
ads <- anota2seqDataSetFromMatrix(
    dataP = anota2seq_data_P[1:1000,],    
    dataT = anota2seq_data_T[1:1000,],
    phenoVec = anota2seq_pheno_vec,
    dataType = "RNAseq",   
    filterZeroGenes = TRUE, 
    normalize = TRUE,       
    transformation = "TMM-log2",   
    varCutOff = NULL)                

## ----prepare_SE, echo = FALSE, results = 'hide'----------------------------
library(SummarizedExperiment)
countData <- as.matrix(cbind(anota2seq_data_P[1:1000,],anota2seq_data_T[1:1000,]))

# annotations
anot <- data.frame(
    row.names = colnames(countData),
    #information on mRNA types
    RNA = c(rep("P",8),rep("T",8)), 
    #samples classes
    treatment = rep(c(rep("ctrl",4),rep("treatment",4)),2), 
    #sample Pairs
    samplePairs = rep(c(paste("ctrl",c(1:4),sep="_"),paste("treatment",c(1:4),sep="_")),2),
    # batch information, in this case replicate number
    batches = rep(c(1,2,3,4),4)) 

# Create the SummarizedExperiment
mySummarizedExperiment <- SummarizedExperiment(
    assays = list(counts = countData),
    colData = anot)

## ----initialize_object_from_SE, echo = TRUE--------------------------------
adsFromSE <- anota2seqDataSetFromSE(
    se = mySummarizedExperiment,
    assayNum = 1, # Position of the count data in assays(mySummarizedExperiment)
    dataType = "RNAseq",
    normalize = TRUE,
    transformation = "TMM-log2")

## ----assess_model_assumptions, echo = TRUE, eval = FALSE-------------------
# ads <- anota2seqPerformQC(Anota2seqDataSet = ads,
#                           generateSingleGenePlots = TRUE)

## ----assess_model_assumptions_echoFALSE, echo = FALSE, results = 'hide'----
ads <- anota2seqPerformQC(Anota2seqDataSet = ads,
                          generateSingleGenePlots = TRUE, fileName = "figure/singleReg.pdf", 
                          fileStem = "figure/")

## ----assess_model_assumptions2, echo = TRUE, eval = FALSE------------------
# anota2seqResidOutlierTest(ads, residFitPlot = FALSE,
#                           generateSingleGenePlots = TRUE, nGraphs = 12)

## ----assess_model_assumptions2_echoFALSE, echo=FALSE, results = 'hide'-----
ads <- anota2seqResidOutlierTest(ads, residFitPlot = FALSE, generateSingleGenePlots = TRUE, nGraphs = 12)
file.rename(from = "ANOTA2SEQ_residual_distributions_single.pdf", to = "figure/ANOTA2SEQ_residual_distributions_single.pdf")
file.rename(from = "ANOTA2SEQ_residual_distribution_summary.jpeg", to = "figure/ANOTA2SEQ_residual_distribution_summary.jpeg")

## ----analysis_translation_and_buffering, echo=TRUE, results = 'hide', eval = FALSE----
# ads <- anota2seqAnalyze(Anota2seqDataSet = ads,
#                         analysis = c("translation", "buffering"))

## ----analysis_translation_and_buffering_echoFALSE, echo = FALSE, results = 'hide', eval = TRUE----
ads <- anota2seqAnalyze(Anota2seqDataSet = ads,
                        analysis = c("translation", "buffering"),
                        fileStem = "figure/")

## ----show_output_Analyze, echo=TRUE, eval = TRUE---------------------------
head(anota2seqGetOutput(
    ads, analysis = "translation",
    output = "full",
    selContrast = 1,
    getRVM = TRUE))

## ----pvalDensity, echo = TRUE, message = FALSE, eval = TRUE, fig.env="figure", fig.cap = "An output from the \\Rfunction{anota2seqPlotPvalues} function. The left graph shows a P-value distribution of changes in translational efficiency leading to altered protein levels (designated \"translation\") and buffering for all analyzed features. The right graph shows the corresponding adjusted P-value (FDR) distributions."----
par(mfrow = c(1, 2))
anota2seqPlotPvalues(ads, selContrast = 1, plotToFile = FALSE)

## ----selSigGenes_translation_buffering, echo = TRUE, eval = TRUE, results = 'hide'----
ads <- anota2seqSelSigGenes(Anota2seqDataSet = ads,
                            selContrast = 1,
                            minSlopeTranslation = -1,
                            maxSlopeTranslation = 2,
                            minSlopeBuffering = -2,
                            maxSlopeBuffering = 1,
                            maxPAdj = 0.05)

## ----singleGeneRegressions_translation, echo = TRUE, message = FALSE, eval = TRUE, fig.wide=TRUE, fig.asp=1, fig.keep = "first", fig.cap = "Visualization provided by the \\Rfunction{anota2seqPlotGenes} function for analysis of changes in translational efficiency leading to altered protein levels. The left graph shows the feature per feature regressions between translated mRNA (in this case polysome-associated mRNA) and total mRNA levels. Plotting symbols are taken from the \\Rcode{phenoVec} argument supplied to the \\Rfunction{anota2seqAnalyze} function and the lines are the regression lines per treatment using the common slope identified in APV (shown in the main title). The right and middle graphs show key statistics for the analyzed feature with and without RVM, respectively. These graphs (shown here for only 3 features) can be visualized for all features selected in \\Rfunction{anota2seqSelSigGenes}."----
anota2seqPlotGenes(ads, selContrast = 1, analysis = "translation", plotToFile = FALSE)

## ----singleGeneRegressions_buffering, echo = TRUE, message = FALSE, eval = TRUE, fig.wide=TRUE, fig.asp=1, fig.keep = "first", fig.cap = "Visualization provided by the \\Rfunction{anota2seqPlotGenes} function for analysis of changes in translational efficiency leading to buffering. The left graph shows the feature per feature regressions between total mRNA and translated mRNA (in this case polysome-associated mRNA) levels. Plotting symbols are taken from the \\Rfunction{phenoVec} argument supplied to the \\Rfunction{anota2seqAnalyze} function and the lines are the regression lines per treatment using the common slope identified in APV (shown in the main title). The right and middle graphs show key statistics for the analyzed gene with and without RVM respectively. These graphs (shown here for only 3 features) can be visualized for all features selected in \\Rfunction{anota2seqSelSigGenes}."----
anota2seqPlotGenes(ads, selContrast = 1, analysis = "buffering", plotToFile = FALSE)

## ----analyze_and_selSigGenes_total_translated, echo=FALSE, results = 'hide', eval = TRUE----
ads <- anota2seqAnalyze(Anota2seqDataSet = ads,
                        analysis = c("total mRNA", "translated mRNA"),
                        fileStem = "figure/")
ads <- anota2seqSelSigGenes(Anota2seqDataSet = ads,
                            analysis = c("total mRNA", "translated mRNA"),      
                            selContrast = 1,
                            minSlopeTranslation = -1,
                            maxSlopeTranslation = 2,
                            minSlopeBuffering = -2,
                            maxSlopeBuffering = 1,
                            maxPAdj = 0.05)

## ----analyze_and_selSigGenes_total_translated_echoFALSE, echo=TRUE, results = 'hide', eval = FALSE----
# ads <- anota2seqAnalyze(Anota2seqDataSet = ads,
#                         analysis = c("total mRNA", "translated mRNA"))
# ads <- anota2seqSelSigGenes(Anota2seqDataSet = ads,
#                             analysis = c("total mRNA", "translated mRNA"),
#                             selContrast = 1,
#                             minSlopeTranslation = -1,
#                             maxSlopeTranslation = 2,
#                             minSlopeBuffering = -2,
#                             maxSlopeBuffering = 1,
#                             maxPAdj = 0.05)

## ----regModes, echo=TRUE, results = 'hide', eval = TRUE--------------------
ads <- anota2seqRegModes(ads)

## ----regModesOutput, echo=TRUE, eval = TRUE--------------------------------
head(anota2seqGetOutput(object = ads, output="regModes", 
                          selContrast = 1, analysis="buffering",
                          getRVM = TRUE))[, c("apvSlope", "apvEff", "apvRvmP", 
                                              "apvRvmPAdj", "singleRegMode")]

## ----fcPlot, echo = TRUE, message = FALSE, eval = TRUE, fig.env="figure", fig.asp = 1, fig.cap = "An output from the \\Rfunction{anota2seqPlotFC} function. Shown is a scatter-plot (for all included features) of fold-changes (treatment vs. control) for translated mRNA (in this case polysome-associated mRNA) and total mRNA. Features passing filtering using the \\Rfunction{anota2seqSelSigGenes} function have been categorized as either showing changes in abundance or changes in translational efficiency leading to altered protein levels (indicated as \"translation\" in the graph) or buffering; these are indicated by colors."----
anota2seqPlotFC(ads, selContrast = 1, plotToFile = FALSE)

## ----singelDataFrameOutput, echo=TRUE, eval = FALSE------------------------
# anota2seqGetOutput(ads,output="singleDf",selContrast=1)

## ----wrapperFunction, echo=TRUE, eval = FALSE------------------------------
# ads <- anota2seqRun(
#     Anota2seqDataSet = ads,
#     thresholds = list(
#         maxPAdj = 0.05,
#         minEff = 1.5),
#     performQC = TRUE,
#     performROT = TRUE,
#     useRVM = TRUE)

