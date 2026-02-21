# Code example from 'compcodeR' vignette. See references/ for full tutorial.

## ----include = FALSE---------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(width = 55)

## ----setup-------------------------------------------
library(compcodeR)

## ----eval=FALSE--------------------------------------
# B_625_625 <- generateSyntheticData(dataset = "B_625_625", n.vars = 12500,
#                                    samples.per.cond = 5, n.diffexp = 1250,
#                                    repl.id = 1, seqdepth = 1e7,
#                                    fraction.upregulated = 0.5,
#                                    between.group.diffdisp = FALSE,
#                                    filter.threshold.total = 1,
#                                    filter.threshold.mediancpm = 0,
#                                    fraction.non.overdispersed = 0,
#                                    output.file = "B_625_625_5spc_repl1.rds")

## ----reportsimulated, eval = FALSE-------------------
# summarizeSyntheticDataSet(data.set = "B_625_625_5spc_repl1.rds",
#                           output.filename = "B_625_625_5spc_repl1_datacheck.html")

## ----echo = FALSE, fig.cap = "Example figures from the summarization report generated for a simulated data set. The top panel shows an MA plot, with the genes colored by the true differential expression status. The bottom panel shows the relationship between the true log-fold changes between the two sample groups underlying the simulation, and the estimated log-fold changes based on the simulated counts. Also here, the genes are colored by the true differential expression status.", fig.show='hold',fig.align='center'----
knitr::include_graphics(c("compcodeR_check_figure/maplot-trueDEstatus.png", "compcodeR_check_figure/logfoldchanges.png"))

## ----rundiffexp1, eval = FALSE-----------------------
# runDiffExp(data.file = "B_625_625_5spc_repl1.rds",
#            result.extent = "voom.limma", Rmdfunction = "voom.limma.createRmd",
#            output.directory = ".", norm.method = "TMM")
# runDiffExp(data.file = "B_625_625_5spc_repl1.rds",
#            result.extent = "edgeR.exact", Rmdfunction = "edgeR.exact.createRmd",
#            output.directory = ".", norm.method = "TMM",
#            trend.method = "movingave", disp.type = "tagwise")
# runDiffExp(data.file = "B_625_625_5spc_repl1.rds", result.extent = "ttest",
#            Rmdfunction = "ttest.createRmd",
#            output.directory = ".", norm.method = "TMM")

## ----listcreatermd-----------------------------------
listcreateRmd()

## ----runcomparison, eval = FALSE---------------------
# runComparisonGUI(input.directories = ".",
#                  output.directory = ".", recursive = FALSE)

## ----echo = FALSE, fig.cap = "Screenshot of the graphical user interface used to select data set (left) and set parameters (right) for the comparison of differential expression methods. The available choices for the Data set, DE methods, Number of samples and Replicates are automatically generated from the compData objects available in the designated input directories. Only one data set can be used for the comparison. In the lower part of the window we can set (adjusted) p-value thresholds for each comparison method separately. For example, we can evaluate the true FDR at one adjusted p-value threshold, and estimate the TPR for another adjusted p-value threshold. We can also set the maximal number of top-ranked variables that will be considered for the false discovery curves.", fig.show='hold',fig.align='center'----
knitr::include_graphics(c("screenshot-gui-1.png", "screenshot-gui-2.png"))

## ----generatecode, eval = FALSE----------------------
# generateCodeHTMLs("B_625_625_5spc_repl1_ttest.rds", ".")

## ----nogui-comparison, eval = FALSE------------------
# file.table <- data.frame(input.files = c("B_625_625_5spc_repl1_voom.limma.rds",
#                                          "B_625_625_5spc_repl1_ttest.rds",
#                                          "B_625_625_5spc_repl1_edgeR.exact.rds"),
#                          stringsAsFactors = FALSE)
# parameters <- list(incl.nbr.samples = NULL, incl.replicates = NULL,
#                    incl.dataset = "B_625_625", incl.de.methods = NULL,
#                    fdr.threshold = 0.05, tpr.threshold = 0.05,
#                    typeI.threshold = 0.05, ma.threshold = 0.05,
#                    fdc.maxvar = 1500, overlap.threshold = 0.05,
#                    fracsign.threshold = 0.05,
#                    comparisons = c("auc", "fdr", "tpr", "ma", "correlation"))
# runComparison(file.table = file.table, parameters = parameters, output.directory = ".")

## ----create-compData, eval=TRUE----------------------
count.matrix <- matrix(round(1000*runif(4000)), 1000, 4)
sample.annot <- data.frame(condition = c(1, 1, 2, 2))
info.parameters <- list(dataset = "mytestdata", uID = "123456")
cpd <- compData(count.matrix = count.matrix, 
                sample.annotations = sample.annot, 
                info.parameters = info.parameters)
check_compData(cpd)

## ----savedata, eval = FALSE--------------------------
# saveRDS(cpd, "saveddata.rds")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/rocone-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/auc.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/typeIerror.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/fdr.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/fdrvsexpr-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/tpr.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/fdcone-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/fracsign.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/sorensen-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/maplot-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics(c("compcodeR_figure/correlation-11.png",
                          "compcodeR_figure/correlation-12.png"))

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/scorevsoutlier-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/scorevsexpr-1.png")

## ----echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("compcodeR_figure/scorevssignal-1.png")

## ----session-info------------------------------------
sessionInfo()

