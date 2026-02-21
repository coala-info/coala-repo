# Code example from 'sights' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
library(knitr)
opts_chunk$set(tidy = TRUE, results = 'hide', comment = ">>", cache = FALSE, fig.height = 4, fig.width = 4, collapse = TRUE, fig.align='center')

## ----help, eval=FALSE---------------------------------------------------------
# # Help page of SPAWN with its references
# help(normSPAWN)

## ----cite, results="show"-----------------------------------------------------
citation("sights")

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("sights")
# library("sights")

## ----dependencies, eval=FALSE-------------------------------------------------
# # Installing packages
# BiocManager::install(c("ggplot2", "reshape2", "lattice", "MASS", "qvalue"))
# 
# # Updating packages
# BiocManager::install("BiocUpgrade")
# BiocManager::install()

## ----data, eval=FALSE---------------------------------------------------------
# data("ex_dataMatrix")
# help("ex_dataMatrix")
# ## Required data arrangement (by-row first) is explained.
# data("inglese")

## ----input_csv, eval=FALSE----------------------------------------------------
# read.csv("~/yourfile.csv", header=TRUE, sep=",")
# ## '~' is the folder location of your file 'yourfile.csv'.
# 
# ## Use header=TRUE if you have column headers (recommended); otherwise, use header=FALSE.
# 
# ## N.B. Be sure to use a forward slash ('/') to separate folder names.

## ----input_excel, eval=FALSE--------------------------------------------------
# install.packages("xlsx")
# ## This installs the xlsx package which enables import/export of Excel files.
# library("xlsx")
# read.xlsx("~/yourfile.xlsx", sheetIndex = 1) # or
# read.xlsx("~/yourfile.xlsx", sheetName = "one")
# ## sheetIndex is the sheet number where your data is stored in 'yourfile.xlsx'; sheetName is the name of that sheet.

## ----output, eval=FALSE-------------------------------------------------------
# write.csv(object_name, "~/yourresults.csv")
# ## As a .csv file
# write.xlsx(object_name, "~/yourresults.xlsx")
# ## As a Microsoft Excel file (requires the "xlsx" package)

## ----information, eval=FALSE--------------------------------------------------
# View(inglese)
# ## View the entire dataset
# edit(inglese)
# ## Edit the dataset
# head(inglese)
# ## View the top few rows of the dataset
# str(inglese)
# ## Get information on the structure of the dataset
# summary(inglese)
# ## Get a summary of variables in the dataset
# names(inglese)
# ## Get the variable names of the dataset

## ----methods, eval=FALSE------------------------------------------------------
# ls("package:sights")
# ## Lists all the functions and datasets available in the package
# lsf.str("package:sights")
# ## Lists all the functions and their usage
# args(plotSights)
# ## View the usage of a specific function
# example(topic = plotSights, package = "sights")
# ## View examples of a specific function

## ----example, fig.show='hide', message=FALSE, warning=FALSE-------------------
library(sights)
data("inglese")
# Normalize
spawn_results <- normSPAWN(dataMatrix = inglese, plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE, biasMatrix = NULL, biasCols = 1:18)
## Or
spawn_results <- normSights(normMethod = "SPAWN", dataMatrix = inglese, plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE, biasMatrix = NULL, biasCols = 1:18)
## Access
summary(spawn_results)
# Apply statistical test
rvm_results <- statRVM(normMatrix = spawn_results, repIndex = rep(1:3, each = 3), normRows = NULL, normCols = 1:9, testSide = "two.sided")
## Or
rvm_results <- statSights(statMethod = "RVM", normMatrix = spawn_results, repIndex = c(1,1,1,2,2,2,3,3,3), normRows = NULL, normCols = 1:9, ctrlMethod = NULL, testSide = "two.sided")
## Access
head(rvm_results)
# Plot
autoco_results <- plotAutoco(plotMatrix = spawn_results, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:9, plotName = "SPAWN_Inglese", plotSep = TRUE)
## Or
autoco_results <- plotSights(plotMethod = "Autoco", plotMatrix = spawn_results, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = c(1,2,3,4,5,6,7,8,9), plotName = "SPAWN_Inglese", plotSep = TRUE)
## Access
autoco_results
autoco_results[[1]]

## ----inglese------------------------------------------------------------------
library("sights")
data("inglese")

## ----raw_bias0, fig.cap="Boxplots: There is overall plate bias, since the median values of the three replicate plates differ."----
sights::plotSights(plotMethod = "Box", plotMatrix = inglese, plotCols = 3:5, plotName = "Raw Exp1")

## ----raw_bias1, fig.show='hold'-----------------------------------------------
sights::plotSights(plotMethod = "Heatmap", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 3, plotName = "Raw Exp1")
sights::plotSights(plotMethod = "3d", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 3, plotName = "Raw Exp1")
sights::plotSights(plotMethod = "Autoco", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 3:5, plotSep = FALSE, plotName = "Raw Exp1")

## ----raw_bias2, fig.cap="Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates. When screens have few true hits, replicate plates should be uncorrelated except within the hit range. Depending on the screen, hits could be represented by high or low scores or, as in this screen, by both. The blue line is the loess robust fit; the dashed line is the identity line."----
sights::plotSights(plotMethod = "Scatter", plotMatrix = inglese, repIndex = c(1,1), plotRows = NULL, plotCols = 3:4, plotName = "Raw Exp1", alpha=0.2)

## ----z_bias0, fig.cap="Boxplots: Z-score normalization has corrected overall plate bias, as the medians of the three replicate plates are approximately equal."----
Z.norm.inglese.01 <- sights::normSights(normMethod = "Z", dataMatrix = inglese, dataRows = NULL, dataCols = 3:5)
sights::plotSights(plotMethod = "Box", plotMatrix = Z.norm.inglese.01, plotCols = 1:3, plotName = "Z Exp1")

## ----z_bias1, fig.show='hold'-------------------------------------------------
sights::plotSights(plotMethod = "Heatmap", plotMatrix = Z.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "Z Exp1")
sights::plotSights(plotMethod = "3d", plotMatrix = Z.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "Z Exp1")
sights::plotSights(plotMethod = "Autoco", plotMatrix = Z.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "Z Exp1")

## ----z_bias2, fig.cap="Scatter plot: Similarly, the correlational pattern between replicates (across-plate bias) remains.  Note, though, that the blue loess line now substantially overlaps the identity line because Z-score normalization corrects for overall plate bias."----
sights::plotSights(plotMethod = "Scatter", plotMatrix = Z.norm.inglese.01, repIndex = c(1,1), plotRows = NULL, plotCols = 1:2, plotName = "Z Exp1", alpha=0.2)

## ----spawn_bias0, fig.cap="Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal."----
SPAWN.norm.inglese.01 <- sights::normSights(normMethod = "SPAWN", dataMatrix = inglese, plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE, biasCols = 1:18)
sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.01, plotCols = 1:3, plotName = "SPAWN Exp1")

## ----spawn_bias1, fig.show='hold'---------------------------------------------
sights::plotSights(plotMethod = "Heatmap", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp1")
sights::plotSights(plotMethod = "3d", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp1")
sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.01, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "SPAWN Exp1")

## ----spawn_bias2, fig.cap="Scatter plot: SPAWN has removed across-plate bias, as indicated by the near zero correlations between replicate plates."----
sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.01, repIndex = c(1,1), plotRows = NULL, plotCols = 1:2, plotName = "SPAWN Exp1", alpha=0.2)

## ----raw_bias9, fig.cap="Boxplots: There is overall plate bias, since the median values of the three replicate plates differ."----
sights::plotSights(plotMethod = "Box", plotMatrix = inglese, plotCols = 27:29, plotName = "Raw Exp9")

## ----raw_bias10, fig.show='hold'----------------------------------------------
sights::plotSights(plotMethod = "Heatmap", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 27, plotName = "Raw Exp9")
sights::plotSights(plotMethod = "3d", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 27, plotName = "Raw Exp9")
sights::plotSights(plotMethod = "Autoco", plotMatrix = inglese, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 27:29, plotSep = FALSE, plotName = "Raw Exp9")

## ----raw_bias11, fig.cap="Scatter plot: Across-plate bias is present, as indicated by the positive correlation between replicates."----
sights::plotSights(plotMethod = "Scatter", plotMatrix = inglese, repIndex = c(1,1), plotRows = NULL, plotCols = 27:28, plotName = "Raw Exp9", alpha=0.2)

## ----spawn_bias9, fig.cap="Boxplots: SPAWN has removed plate bias, as the medians of the three replicate plates are approximately equal."----
SPAWN.norm.inglese.09 <- sights::normSights(normMethod = "SPAWN", dataMatrix = inglese, plateRows = 32, plateCols = 40, dataRows = NULL, dataCols = 3:44, trimFactor = 0.2, wellCorrection = TRUE, biasCols = 1:18)[,25:27]
sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.09, plotCols = 1:3, plotName = "SPAWN Exp9")

## ----spawn_bias10, fig.show='hold'--------------------------------------------
sights::plotSights(plotMethod = "Heatmap", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp9")
sights::plotSights(plotMethod = "3d", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1, plotName = "SPAWN Exp9")
sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE, plotName = "SPAWN Exp9")

## ----spawn_bias11, fig.cap="Scatter plot: The circular pattern for the majority of data points near zero indicates that across-plate bias has been greatly reduced. This is also shown by the approximately horizontal blue loess line within that range. Data points outside of that range are potential hits."----
sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1), plotRows = NULL, plotCols = 1:2, plotName = "SPAWN Exp9", alpha=0.2)

## ----t, fig.cap="P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives.", results='show'----
SPAWN.norm.inglese.09.t <- sights::statSights(statMethod = "T", normMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1,1), normRows = NULL, ctrlMethod = NULL, testSide = "two.sided")
summary(SPAWN.norm.inglese.09.t)
## The 5th column in the result matrix has the p-values, and thus, it will be selected for histogram below.
sights::plotSights(plotMethod = "Hist", plotMatrix = SPAWN.norm.inglese.09.t, plotRows = NULL, plotCols = 5, plotAll = FALSE, plotSep = TRUE, colNames = "Exp9", plotName = "t-test")

## ----t_fdr, results='show'----------------------------------------------------
SPAWN.norm.inglese.09.t.fdr <- sights::statFDR(SPAWN.norm.inglese.09.t, ctrlMethod = "smoother")
summary(SPAWN.norm.inglese.09.t.fdr)

## ----rvm, fig.cap="Inverse Gamma fit plot: The fit of the variance distribution is reasonably close to theoretical expectation and so the RVM test is appropriate for these data.", results='show'----
SPAWN.norm.inglese.09.rvm <- sights::statSights(statMethod = "RVM", normMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1,1), normRows = NULL, ctrlMethod = NULL, testSide = "two.sided")
summary(SPAWN.norm.inglese.09.rvm)
sights::plotSights(plotMethod = "IGFit", plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1,1))

## ----rvm_hist, fig.cap="P-value histogram: Uncorrected for multiple testing, these nominal p-values would generate many false positives."----
sights::plotSights(plotMethod = "Hist", plotMatrix = SPAWN.norm.inglese.09.rvm, plotRows = NULL, plotCols = 5, colNames = "Exp9", plotName = "RVM test")

## ----rvm_fdr, results='show'--------------------------------------------------
SPAWN.norm.inglese.09.rvm.fdr <- sights::statFDR(SPAWN.norm.inglese.09.rvm, ctrlMethod = "smoother")
summary(SPAWN.norm.inglese.09.rvm.fdr)

## ----ellipsis, fig.cap="Ellipsis: Add parameters to ggplot geom [@wickham2009ggplot2]."----
sights::plotHist(plotMatrix = SPAWN.norm.inglese.09.rvm, plotCols = 5, plotAll = TRUE, binwidth = 0.02, fill = 'pink', color = 'black', plotName = "RVM test Exp9")

## ----extra, eval=FALSE--------------------------------------------------------
# install.packages("ggthemes")
# ## This installs the ggthemes package, which has various themes that can be used with ggplot objects.
# library("ggthemes")
# install.packages("gridExtra")
# ## This installs the gridExtra package, which enables arrangement of plot objects.
# library("gridExtra")

## ----exlib, echo=FALSE--------------------------------------------------------
library("ggthemes")
library("gridExtra")

## ----gg, fig.cap="Layers: Add layers like ggplot2 [@wickham2009ggplot2]."-----
b <- sights::plotBox(plotMatrix = inglese, plotCols = 33:35)
b + ggplot2::geom_boxplot(fill = c('rosybrown', 'pink', 'thistle')) + ggthemes::theme_igray() + ggplot2::labs(x = "Sample_11 Replicates", y = "Raw Values")

## ----lim, fig.cap=c("Original plot: All points in the original data are plotted, without setting any data limits.", "Constrained limits: Data are constrained before plotting, so that points outside of the limits are not considered when drawing aspects of the plot that are estimated from the data such as the loess regression line. Note that the line differs from the original plot above.", "Zoomed-in limits: Original data are used but plot only shows the data within the specified limits. Note, however, that the line is the same within the restricted range as in the original plot above.")----
s <- sights::plotScatter(plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1,1))
s[[2]] + ggplot2::labs(title = "Original Scatter Plot")
s[[2]] + ggplot2::lims(x = c(-5,5), y = c(-5,5)) + ggplot2::labs(title = "Constrained Scatter Plot")
s[[2]] + ggplot2::coord_cartesian(xlim = c(-5,5), ylim = c(-5,5)) + ggplot2::labs(title = "Zoomed-in Scatter Plot")

## ----silent, fig.show='hide'--------------------------------------------------
box <- sights::plotSights(plotMethod = "Box", plotMatrix = SPAWN.norm.inglese.09, plotCols = 1:3) + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
autoco <- sights::plotSights(plotMethod = "Autoco", plotMatrix = SPAWN.norm.inglese.09, plateRows = 32, plateCols = 40, plotRows = NULL, plotCols = 1:3, plotSep = FALSE) + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
scatter <- sights::plotSights(plotMethod = "Scatter", plotMatrix = SPAWN.norm.inglese.09, repIndex = c(1,1,1), plotRows = NULL, plotCols = 1:3)
sc1 <- scatter[[1]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc2 <- scatter[[2]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc3 <- scatter[[3]] + ggplot2::theme(plot.title = ggplot2::element_text(size = 12))
sc <- gridExtra::grid.arrange(sc1, sc2, sc3, ncol = 3)
ab <- gridExtra::grid.arrange(box, autoco, ncol = 2)

## ----biases, fig.cap="Arrangement: Multiple plots can be custom-arranged in one window by using gridExtra package [@auguie2015package].", fig.height = 7, fig.width = 7----
gridExtra::grid.arrange(ab, sc, nrow = 2, top = "SPAWN Normalized Exp9")

