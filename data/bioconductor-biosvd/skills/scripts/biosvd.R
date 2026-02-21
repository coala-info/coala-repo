# Code example from 'biosvd' vignette. See references/ for full tutorial.

### R code from vignette source 'biosvd.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: yeast_data_import
###################################################
library(biosvd)
data(YeastData_alpha)
colnames(pData(YeastData))[match("Cell.cycle.stage", colnames(pData(YeastData)))] <-
"Cellcycle.sample"
colnames(fData(YeastData))[match("Cell.cycle.stage", colnames(fData(YeastData)))] <-
"Cellcycle.gene"
YeastData


###################################################
### code chunk number 2: yeast_compute_eigensystem_data
###################################################
eigensystem <- compute(YeastData)


###################################################
### code chunk number 3: EigensystemPlotParam
###################################################
params <- new("EigensystemPlotParam")
params


###################################################
### code chunk number 4: yeast_plot_eigensystem_data_fraction
###################################################
fractions(eigensystem)[[1]]
plots(params) <- "fraction"
figure(params) <- TRUE
prefix(params) <- "YeastData"
plot(eigensystem, params)


###################################################
### code chunk number 5: yeast_plot_eigensystem_data_lines
###################################################
plots(params) <- "allLines"
plot(eigensystem, params)


###################################################
### code chunk number 6: yeast_plot_eigensystem_data_heatmap
###################################################
plots(params) <- "eigenfeatureHeatmap"
plot(eigensystem, params)


###################################################
### code chunk number 7: yeast_remove_eigenfeature_data
###################################################
eigensystem <- exclude(eigensystem,excludeEigenfeatures=c(1,2,8,10:18))


###################################################
### code chunk number 8: yeast_compute_eigensystem_variance
###################################################
eigensystem <- compute(eigensystem, apply='variance')
entropy(eigensystem)
fractions(eigensystem)[[1]]
plots(params) <- "lines"
plot(eigensystem, params)
eigensystem <- exclude(eigensystem, excludeEigenfeatures=1)


###################################################
### code chunk number 9: yeast_polarplot_assays
###################################################
assayColorMap(params) <- list(Cellcycle.sample=NA)
plots(params) <- "eigenassayPolar"
plot(eigensystem, params)


###################################################
### code chunk number 10: yeast_polarplot_features
###################################################
featureColorMap(params) <- list(Cellcycle.gene=NA)
plots(params) <- "eigenfeaturePolar"
plot(eigensystem, params)


###################################################
### code chunk number 11: yeast_generate_report
###################################################
fractions(eigensystem)[c(1,2)]
report(eigensystem, params)


###################################################
### code chunk number 12: yeast_sorted_heatmap
###################################################
plots(params) <- "sortedHeatmap"
plot(eigensystem, params)


###################################################
### code chunk number 13: hela_compute_eigensystem_data
###################################################
data(HeLaData_exp_DoubleThym_2)
colnames(pData(HeLaData))[match("Cell.cycle.stage", colnames(pData(HeLaData)))] <-
"Cellcycle.sample"
colnames(fData(HeLaData))[match("Cell.cycle.stage", colnames(fData(HeLaData)))] <-
"Cellcycle.gene"
HeLaData
eigensystem <- compute(HeLaData)
fractions(eigensystem)[[1]]
entropy(eigensystem)
params <- new("EigensystemPlotParam")
plots(params) <- "allLines"
figure(params) <- TRUE
plot(eigensystem, params)
eigensystem <- exclude(eigensystem,excludeEigenfeature=c(1,7,10:12))


###################################################
### code chunk number 14: hela_compute_eigensystem_variance
###################################################
eigensystem <- compute(eigensystem, apply='variance')
entropy(eigensystem)
fractions(eigensystem)[[1]]
plots(params) <- c("eigenfeatureHeatmap", "fraction", "lines")
figure(params) <- FALSE
prefix(params) <- "HeLaData"
plot(eigensystem, params)
eigensystem <- exclude(eigensystem, excludeEigenfeatures=1)


###################################################
### code chunk number 15: hela_generate_report
###################################################
report(eigensystem, params)


###################################################
### code chunk number 16: hela_eigenassay_polar
###################################################
cellcycle.col.map <- c("orange2", "darkgreen", "blue2", "red2")
names(cellcycle.col.map) <- c("S", "G2", "M", "G1")
assayColorMap(params) <- list(Cellcycle.sample=cellcycle.col.map)
plots(params) <- "eigenassayPolar"
figure(params) <- TRUE
plot(eigensystem, params)


###################################################
### code chunk number 17: hela_eigenfeature_polar
###################################################
cellcycle.col.map <- c("orange2", "darkgreen", "blue3", "magenta3", "red3")
names(cellcycle.col.map) <- c("S", "G2", "G2/M", "M/G1", "G1/S")
featureColorMap(params) <- list(Cellcycle.gene=cellcycle.col.map)
plots(params) <- "eigenfeaturePolar"
plot(eigensystem, params)


###################################################
### code chunk number 18: hela_sorted_heatmap
###################################################
plots(params) <- "sortedHeatmap"
plot(eigensystem, params)


###################################################
### code chunk number 19: starvation_compute_eigensystem_data
###################################################
data(StarvationData)
StarvationData
eigensystem <- compute(StarvationData)
fractions(eigensystem)[c(1,2)]
params <- new("EigensystemPlotParam")
plots(params) <- c("fraction")
figure(params) <- TRUE
prefix(params) <- "StarvationData"
plot(eigensystem, params)


###################################################
### code chunk number 20: starvation_plot_eigensystem_1
###################################################
plots(params) <- "lines"
plot(eigensystem, params)


###################################################
### code chunk number 21: starvation_plot_eigensystem_2
###################################################
plots(params) <- "allLines"
plot(eigensystem, params)
eigensystem <- exclude(eigensystem,excludeEigenfeature=c(1,11,12,14:24))


###################################################
### code chunk number 22: starvation_compute_eigensystem_variance
###################################################
eigensystem <- compute(eigensystem, apply='variance')
plots(params) <- "lines"
plot(eigensystem, params)
eigensystem <- exclude(eigensystem, excludeEigenfeatures=0)


###################################################
### code chunk number 23: starvation_generate_report
###################################################
report(eigensystem, params)
plots(params) <- "sortedHeatmap"
assayColorMap(params) <- list(Species=NA)
plot(eigensystem, params)
whichPolarAxes(params) <- c(4,3)
prefix(params) <- "StarvationData34"
report(eigensystem, params)


###################################################
### code chunk number 24: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


