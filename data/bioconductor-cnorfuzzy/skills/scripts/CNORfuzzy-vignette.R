# Code example from 'CNORfuzzy-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CNORfuzzy-vignette.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
options(width=70, useFancyQuotes="UTF-8", prompt=" ", continue="  ")


###################################################
### code chunk number 2: installCNORfuzzy (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("CNORfuzzy")


###################################################
### code chunk number 3: installCNORfuzzy2
###################################################
library(CNORfuzzy)


###################################################
### code chunk number 4: quickstart
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")


###################################################
### code chunk number 5: CNORfuzzy-vignette.Rnw:153-157
###################################################
library(CNORfuzzy)
library(xtable)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")


###################################################
### code chunk number 6: reacIDtab
###################################################
xtable(matrix(ToyModel$reacID, ncol=4), caption="The ToyModel object contains a prior knowledge
network with 16 reactions stored in the field \\emph{ToyModel\\$reacID}.
There are other fields such as \\emph{namesSpecies} or \\emph{interMat} that are used during the
analysis.", label="tab:reacID")


###################################################
### code chunk number 7: quickstartPlotModel
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")
plotModel(ToyModel, CNOlistToy, compressed=c("p38", "TRAF6", "Ras"))


###################################################
### code chunk number 8: quickstartPlotModelCompressed
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")
plotModel(expandGates(compressModel(ToyModel, indexFinder(CNOlistToy, ToyModel))), CNOlistToy)


###################################################
### code chunk number 9: cnolist
###################################################
data(CNOlistToy, package="CellNOptR")
CNOlistToy = CNOlist(CNOlistToy)
print(CNOlistToy)


###################################################
### code chunk number 10: plotCNOlist
###################################################
# with the old CNOlist (output of makeCNOlist), type
data(CNOlistToy, package="CellNOptR")
plotCNOlist(CNOlistToy)

# with the new version, just type:
CNOlistToy = CNOlist(CNOlistToy)
plot(CNOlistToy)


###################################################
### code chunk number 11: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 12: CNORfuzzy-vignette.Rnw:246-250
###################################################
paramsList = defaultParametersFuzzy(CNOlistToy, ToyModel)
paramsList$popSize = 50
paramsList$maxGens = 50
paramsList$optimisation$maxtime = 30


###################################################
### code chunk number 13: optimisation
###################################################
N = 1
allRes = list()
paramsList$verbose=TRUE
for (i in 1:N){
    Res = CNORwrapFuzzy(CNOlistToy, ToyModel, paramsList=paramsList)
    allRes[[i]] = Res
}


###################################################
### code chunk number 14: compileMultiRes
###################################################
summary = compileMultiRes(allRes,show=FALSE)


###################################################
### code chunk number 15: plotMeanFuzzyFit
###################################################
plotMeanFuzzyFit(0.1, summary$allFinalMSEs, allRes,
    plotParams=list(cmap_scale=0.5, cex=.9, margin=0.3))


###################################################
### code chunk number 16: FullAnalysis_start
###################################################
library(CNORfuzzy)
data(DreamModel, package="CellNOptR")
data(CNOlistDREAM, package="CellNOptR")


###################################################
### code chunk number 17: quickstartPlotModel2
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")
compModel = compressModel(DreamModel,  indexFinder(CNOlistDREAM, DreamModel))
compSpecies = compModel$speciesCompressed
plotModel(DreamModel, CNOlistDREAM, compressed=compSpecies,
    graphvizParams=list(fontsize=40, nodeWidth=15, nodeHeight=8))


###################################################
### code chunk number 18: quickstartPlotModelCompressed2
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")
compModel = compressModel(DreamModel,  indexFinder(CNOlistDREAM, DreamModel))
plotModel(compModel, CNOlistDREAM, graphvizParams=list(fontsize=40))


###################################################
### code chunk number 19: param1
###################################################
# Default parameters
paramsList = defaultParametersFuzzy(CNOlistDREAM, DreamModel)
# Some Genetic Algorithm parameters
paramsList$popSize      = 50
paramsList$maxTime      = 5*60
paramsList$maxGens      = 200
paramsList$stallGenMax  = 50
paramsList$verbose      = FALSE


###################################################
### code chunk number 20: param_funs1
###################################################
# Default Fuzzy Logic Type1 parameters (Hill transfer functions)
nrow = 7
paramsList$type1Funs = matrix(data = NaN,nrow=nrow,ncol=3)
paramsList$type1Funs[,1] = 1
paramsList$type1Funs[,2] = c(3, 3, 3, 3, 3, 3, 1.01)
paramsList$type1Funs[,3] = c(0.2, 0.3, 0.4, 0.55, 0.72,1.03, 68.5098)


###################################################
### code chunk number 21: param_funs2
###################################################
# Default Fuzzy Logic Type2 parameters
nrow = 7
paramsList$type2Funs = matrix(data = NaN,nrow=nrow,ncol=3)
paramsList$type2Funs[,1] = seq(from=0.2, to=0.8, length=nrow)
#paramsList$type2Funs[,1] = c(0.2,0.3,0.4,0.5,0.6,0.7,0.8)
paramsList$type2Funs[,2] = 1
paramsList$type2Funs[,3] = 1


###################################################
### code chunk number 22: param_funs3
###################################################
paramsList$redThres = c(0, 0.0001, 0.0005, 0.001,  0.003, 0.005, 0.01)


###################################################
### code chunk number 23: param_optim
###################################################

paramsList$optimisation$algorithm = "NLOPT_LN_SBPLX"
paramsList$optimisation$xtol_abs = 0.001
paramsList$optimisation$maxeval =  10000
paramsList$optimisation$maxtime = 60*5


###################################################
### code chunk number 24: FullAnalysis (eval = FALSE)
###################################################
## N = 10
## allRes = list()
## for (i in 1:N){
##     Res = CNORwrapFuzzy(CNOlistDREAM, DreamModel, paramsList=paramsList, 
##         verbose=TRUE)
##     allRes[[i]] = Res
## }
## summary = compileMultiRes(allRes, show=TRUE)


###################################################
### code chunk number 25: FullAnalysis2 (eval = FALSE)
###################################################
## plotMeanFuzzyFit(0.01, summary$allFinalMSEs, allRes)


###################################################
### code chunk number 26: FullAnalysis3 (eval = FALSE)
###################################################
## plotMeanFuzzyFit(0.5, summary$allFinalMSEs, allRes)


###################################################
### code chunk number 27: writeFuzzyNetwork (eval = FALSE)
###################################################
## writeFuzzyNetwork(0.01, summary$allFinalMSEs, allRes, "output_dream")


###################################################
### code chunk number 28: FullAnalysisPlotModel
###################################################
library(CNORfuzzy)
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")
plotModel("output_dream_PKN.sif", CNOlistDREAM)


