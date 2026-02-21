# Code example from 'erccdashboard' vignette. See references/ for full tutorial.

## ----echo=FALSE, message=FALSE------------------------------------------------
#options(SweaveHooks=list(fig=function()
#                par(mar=c(5.1,4.1,1.1,2.1))))
library( "erccdashboard" )
knitr::opts_chunk$set(echo = TRUE, warning=FALSE,message=FALSE, error = FALSE)


## -----------------------------------------------------------------------------
citation("erccdashboard")

## ----loadExampleData----------------------------------------------------------
data(SEQC.Example)

## ----defineInputData----------------------------------------------------------
datType = "count" # "count" for RNA-Seq data, "array" for microarray data
isNorm = FALSE # flag to indicate if input expression measures are already
               # normalized, default is FALSE 
exTable = MET.CTL.countDat # the expression measure table
filenameRoot = "RatTox" # user defined filename prefix for results files
sample1Name = "MET" # name for sample 1 in the experiment
sample2Name = "CTL" # name for sample 2 in the experiment
erccmix = "RatioPair" # name of ERCC mixture design, "RatioPair" is default
erccdilution = 1/100 # dilution factor used for Ambion spike-in mixtures
spikeVol = 1 # volume (in microliters) of diluted spike-in mixture added to 
             #   total RNA mass
totalRNAmass = 0.500 # mass (in micrograms) of total RNA 
choseFDR = 0.05 # user defined false discovery rate (FDR), default is 0.05

## ----inspectRatCount----------------------------------------------------------
head(MET.CTL.countDat)

## ----runDashboardRatcount,results='hold'--------------------------------------
exDat <- runDashboard(datType="count", isNorm = FALSE,
                       exTable=MET.CTL.countDat,
                       filenameRoot="RatTox", sample1Name="MET",
                       sample2Name="CTL", erccmix="RatioPair",
                       erccdilution=1/100, spikeVol=1,
                       totalRNAmass=0.500, choseFDR=0.1)

## ----initializeData-----------------------------------------------------------
summary(exDat)

## ----ratPlotA-----------------------------------------------------------------
exDat$Figures$dynRangePlot

## ----ratPlotB-----------------------------------------------------------------
grid.arrange(exDat$Figures$rocPlot)

## ----ratPlotC-----------------------------------------------------------------
grid.arrange(exDat$Figures$lodrERCCPlot)

## ----ratPlotD-----------------------------------------------------------------
grid.arrange(exDat$Figures$maPlot)

## ----viewDashboardOrder-------------------------------------------------------
runDashboard

## ----sessionData--------------------------------------------------------------
sessionInfo()

