# Code example from 'missRows' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----setup, echo=FALSE-----------------------------------------------------
knitr::opts_chunk$set(message=FALSE, fig.align="center", comment="")

## ----echo=FALSE------------------------------------------------------------
x <- citation("missRows")

## ----eval=FALSE------------------------------------------------------------
# help("MIMFA")

## ----eval=FALSE------------------------------------------------------------
# ?MIMFA

## ----quickStart, eval=FALSE------------------------------------------------
# ## Data preparation
# midt <- MIDTList(table1, table2, colData=df)
# 
# ## Performing MI
# midt <- MIMFA(midt, ncomp=2, M=30)
# 
# ## Analysis of the results - Visualization
# plotInd(midt)
# plotVar(midt)

## ----eval=FALSE------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install()

## ----install, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("missRows")

## ----loadLibrary, message=FALSE, warning=FALSE-----------------------------
library(missRows)

## ----searchHelp, eval=FALSE------------------------------------------------
# help.search("missRows")

## ----loadData--------------------------------------------------------------
data(NCI60)

## --------------------------------------------------------------------------
names(NCI60)

## --------------------------------------------------------------------------
table(NCI60$dataTables$cell.line$type)

## --------------------------------------------------------------------------
NCI60$mae

## --------------------------------------------------------------------------
data(NCI60)

## ----dirMIDTList-----------------------------------------------------------
tableList <- NCI60$dataTables[1:2]
cell.line <- NCI60$dataTables$cell.line

midt <- MIDTList(tableList, colData=cell.line, 
                    assayNames=c("trans", "prote"))

## ----sepMIDTList-----------------------------------------------------------
table1 <- NCI60$dataTables$trans
table2 <- NCI60$dataTables$prote
cell.line <- NCI60$dataTables$cell.line

midt <- MIDTList(table1, table2, colData=cell.line,
                    assayNames=c("trans", "prote"))

## ----sepMIDTList2----------------------------------------------------------
midt <- MIDTList("trans" = table1, "prote" = table2,
                colData=cell.line)

## ----maeMIDTList-----------------------------------------------------------
midt <- MIDTList(NCI60$mae)

## --------------------------------------------------------------------------
midt

## ----MIMFA, echo=2---------------------------------------------------------
set.seed(123)
midt <- MIMFA(midt, ncomp=50, M=30, estimeNC=TRUE)

## --------------------------------------------------------------------------
midt

## --------------------------------------------------------------------------
names(midt)

## --------------------------------------------------------------------------
cell.line <- colData(midt)

## ----MthConf---------------------------------------------------------------
conf <- configurations(midt, M=5)
dim(conf)

## ----missingPattern, fig.width=6, fig.height=5, out.width="0.6\\textwidth"----
patt <- missPattern(midt, colMissing="grey70")

## ----missingPatternMat-----------------------------------------------------
patt

## ----plotInd, fig.width=6, fig.height=5, out.width="0.55\\textwidth"-------
plotInd(midt, colMissing="white")

## ----plotInd-ellipses, fig.width=6, fig.height=5, out.width="0.55\\textwidth"----
plotInd(midt, confAreas="ellipse", confLevel=0.95)

## ----plotInd-convexhull, fig.width=6, fig.height=5, out.width="0.55\\textwidth"----
plotInd(midt, confAreas="convex.hull")

## ----plotVar, fig.width=6, fig.height=5, out.width="0.55\\textwidth"-------
plotVar(midt, radIn=0.5)

## ----plotVar-cutoff, fig.width=6, fig.height=5, out.width="0.55\\textwidth"----
plotVar(midt, radIn=0.55, varNames=TRUE, cutoff=0.55)

## ----tuneM, echo=FALSE-----------------------------------------------------
set.seed(1)
tune <- tuneM(midt, ncomp=2, Mmax=100, inc=10, N=20, showPlot=FALSE)

## ----eval=FALSE------------------------------------------------------------
# tune <- tuneM(midt, ncomp=2, Mmax=100, inc=10, N=20)
# tune

## --------------------------------------------------------------------------
tune$stats

## ----echo=FALSE, fig.width=6.5, fig.height=5, out.width="0.5\\textwidth"----
tune$ggp

## ----session-info, echo=FALSE----------------------------------------------
sessionInfo()

