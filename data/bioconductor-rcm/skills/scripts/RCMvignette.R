# Code example from 'RCMvignette' vignette. See references/ for full tutorial.

## ----load-packages, warning=FALSE, message=FALSE, echo=FALSE------------------
knitr::opts_chunk$set(cache = TRUE, autodep = TRUE,
                      warning = FALSE, message = FALSE, echo = TRUE, eval = TRUE, 
                      tidy = TRUE, fig.width = 9, fig.height = 6, purl = TRUE, 
                      fig.show = "hold", cache.lazy = FALSE)
palStore = palette()
#Load all fits, to avoid refitting every time rebuilding the vignette
load(system.file("fits", "zellerFits.RData", package = "RCM"))

## ----install, eval = FALSE----------------------------------------------------
# library(BiocManager)
# install("RCM", update = FALSE)

## ----loadRCMpackage-----------------------------------------------------------
suppressPackageStartupMessages(library(RCM))
cat("RCM package version", as.character(packageVersion("RCM")), "\n")

## ----loadZellerData-----------------------------------------------------------
data(Zeller)
library(phyloseq)

## ----fitUnconstrainedRCM, eval = FALSE----------------------------------------
# ZellerRCM2 = RCM(Zeller, k=2, round = TRUE)

## ----ThreeDimensions, eval = FALSE--------------------------------------------
# ZellerRCM3 = RCM(Zeller, k = 3, round = TRUE)

## ----condition, eval = FALSE--------------------------------------------------
# ZellerRCM2cond = RCM(Zeller, k = 2, round = TRUE, confounders = c("Country"))

## ----plotUnconstrainedRCMsam--------------------------------------------------
plot(ZellerRCM2, plotType = "samples")

## ----plotUnconstrainedRCMsamCol-----------------------------------------------
plot(ZellerRCM2, plotType = "samples", samColour = "Diagnosis")

## ----plotUnconstrainedRCMsamColShannon----------------------------------------
plot(ZellerRCM2, plotType = "samples", samColour = "Shannon")

## ----plotUnconstrainedRCMspec-------------------------------------------------
plot(ZellerRCM2, plotType = "species")

## ----plotUnconstrainedRCMspec2------------------------------------------------
plot(ZellerRCM2, plotType = "species", taxRegExp = "Fusobacter", 
     taxLabels = TRUE)

## ----plotUnconstrainedRCMspec3------------------------------------------------
plot(ZellerRCM2, plotType = "species", taxLabels = TRUE, taxCol = "Order")

## ----plotUnconstrainedRCMall--------------------------------------------------
plot(ZellerRCM2, taxNum = 10, samColour = "Diagnosis")

## ----plotUnconstrainedRCMhighlight--------------------------------------------
tmpPlot = plot(ZellerRCM2, taxNum = 10, samColour = "Diagnosis",
               returnCoords = TRUE)
addOrthProjection(tmpPlot, species = "Alloprevotella tannerae",
                  sample = c(-1.2,1.5))

## ----plotAddedDimension-------------------------------------------------------
plot(ZellerRCM3, Dim = c(1,3), samColour = "Diagnosis", taxNum = 6)

## ----plotUnconstrainedRCMsamColDev--------------------------------------------
plot(ZellerRCM2, plotType = "samples", samColour = "Deviance", samSize = 2.5)

## ----plotUnconstrainedRCMtaxDev-----------------------------------------------
plot(ZellerRCM3, plotType = "species", taxCol = "Deviance", samSize = 2.5,
     Dim = c(1,2), arrowSize = 0.5)

## ----permanova----------------------------------------------------------------
permanovaZeller = permanova(ZellerRCM2, "Diagnosis")
permanovaZeller

## ----permanovaGender----------------------------------------------------------
permanovaZellerGender = permanova(ZellerRCM2, "Gender", verbose = FALSE)

## ----constrLinAndNP, eval = FALSE---------------------------------------------
# #Linear
# ZellerRCM2constr = RCM(Zeller, k = 2, round = TRUE,
#                        covariates = c("Age", "Gender","BMI","Country",
#                                       "Diagnosis"), responseFun = "linear")
# #Nonparametric
# ZellerRCM2constrNonParam = RCM(Zeller, round = TRUE, k = 2,
#                                covariates = c("Age","Gender","BMI","Country",
#                                               "Diagnosis"),
#                                responseFun = "nonparametric")

## ----constrLinPlot------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("samples"))

## ----constrLinPlot2-----------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("samples"), samColour = "Diagnosis", 
     samShape = "Country")

## ----plotLinVar---------------------------------------------------------------
plot(ZellerRCM2constr, plotType = "variables")

## ----plotnonParamVar----------------------------------------------------------
plot(ZellerRCM2constrNonParam, plotType = "variables")

## ----plotlin2cor--------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("species", "samples"))

## ----plotlin2corVis-----------------------------------------------------------
tmpPlot2 = plot(ZellerRCM2constr, plotType = c("species", "samples"), 
                returnCoords = TRUE)
addOrthProjection(tmpPlot2, species = "Pseudomonas fluorescens", 
                  sample = c(-12,7))

## ----plotlin3-----------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("species", "variables"))

## ----plotlin3Vis--------------------------------------------------------------
tmpPlot3 = plot(ZellerRCM2constr, plotType = c("species", "variables"), 
                returnCoords = TRUE)
addOrthProjection(tmpPlot3, species = "Pseudomonas fluorescens", 
                  variable = "DiagnosisSmall_adenoma")

## ----plotlin3Triplot----------------------------------------------------------
plot(ZellerRCM2constr)

## ----plotNPTriplot------------------------------------------------------------
plotRespFun(ZellerRCM2constrNonParam, taxa = NULL ,subdivisions = 50L,
            yLocVar = c(-30, -50,-75,-62.5,-30,-62.5,-70,-50,-30)*0.225, 
            Palette = "Set1", angle = 90, yLocSam = -20,  axisTitleSize = 16, 
            axisLabSize = 11, legendTitleSize = 18, legendLabSize = 12, 
            samShape = "Diagnosis", labSize = 5)

## ----plotnonParamRespFunFuso--------------------------------------------------
FusoSpecies = grep("Fusobacterium",value = TRUE,
                   taxa_names(ZellerRCM2constrNonParam$physeq))
plotRespFun(ZellerRCM2constrNonParam, Dim = 1, taxa = FusoSpecies, 
            samShape = "Diagnosis")

## ----plotDevResp--------------------------------------------------------------
residualPlot(ZellerRCM2constr, whichTaxa = "response", numTaxa = 6)

## ----plotPearResp-------------------------------------------------------------
residualPlot(ZellerRCM2constr, whichTaxa = "response",
             resid = "Pearson", numTaxa = 6)

## ----plotDevRuns--------------------------------------------------------------
residualPlot(ZellerRCM2constr, whichTaxa = "runs", resid = "Deviance", 
             numTaxa = 6)

## ----inflAge------------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "Age")

## ----inflAgeCol---------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("variables", "samples"), samColour = "Age")

## ----inflAgeFast2-------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "Age",
     Influence = TRUE, inflDim = 2)

## ----inflDiag-----------------------------------------------------------------
plot(ZellerRCM2constr, plotType = c("variables", "samples"), inflVar = "DiagnosisNormal", samShape ="Diagnosis" )

## ----inflPsi------------------------------------------------------------------
plot(ZellerRCM2, plotType = "samples", samSize = 2.5, inflVar = "psi")

## ----inflPsiConstr------------------------------------------------------------
plot(ZellerRCM2constr, plotType = "samples", samSize = 2.5, inflVar = "psi")

## ----plotUnconstrainedRCMpsis, fig.height = 8, fig.width = 9------------------
plot(ZellerRCM2cond, plotPsi = "psi")

## ----plotUnconstrainedRCMlogliks, fig.height = 8, fig.width = 9---------------
plot(ZellerRCM2cond, plotPsi = "loglik")

## ----plotUnconstrainedRCMinertia, fig.height = 8, fig.width = 9---------------
plot(ZellerRCM2cond, plotPsi = "inertia")

## ----extractCoord-------------------------------------------------------------
zellerCoords = extractCoord(ZellerRCM2)
str(zellerCoords)

## ----taxaStrongestSignal------------------------------------------------------
taxaSignals = rowSums(zellerCoords$species[, c("end1","end2")]^2)
sortedTaxa = taxa_names(ZellerRCM2$physeq)[order(taxaSignals, decreasing = TRUE)]
sortedTaxa[1:10]

## ----NonsquaredPlots----------------------------------------------------------
plot(ZellerRCM2, axesFixed = FALSE)

## ----linFewVars, eval = FALSE-------------------------------------------------
# #Linear with only 2 variables
# ZellerRCM3constr = RCM(Zeller, k = 2, round = TRUE,
#                        covariates = c("Gender","Diagnosis"), responseFun = "linear")

## ----plotFewVars--------------------------------------------------------------
plot(ZellerRCM3constr, plotType = "samples", samColour = "Diagnosis", 
     samShape = "Country")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

