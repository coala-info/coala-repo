# Code example from 'genomicInstability' vignette. See references/ for full tutorial.

### R code from vignette source 'genomicInstability.Rnw'

###################################################
### code chunk number 1: genomicInstability.Rnw:45-53 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## install.packages("checkmate")
## BiocManager::install("mixtools")
## BiocManager::install("SingleCellExperiment")
## BiocManager::install("ExperimentHub")
## BiocManager::install("genomicInstability")
## install.packages("pROC")


###################################################
### code chunk number 2: genomicInstability.Rnw:64-65
###################################################
library(genomicInstability)


###################################################
### code chunk number 3: genomicInstability.Rnw:74-78
###################################################
library(SingleCellExperiment)
library(ExperimentHub)
eh <- ExperimentHub()
dset <- eh[["EH5419"]]


###################################################
### code chunk number 4: genomicInstability.Rnw:85-90
###################################################
tpm_matrix <- assays(dset)$TPM
set.seed(1)
pos <- sample(ncol(tpm_matrix), 500)
tpm_matrix <- tpm_matrix[, pos]
metadata <- colData(dset)


###################################################
### code chunk number 5: genomicInstability.Rnw:105-109
###################################################
cnv <- inferCNV(tpm_matrix)
class(cnv)
names(cnv)
dim(cnv$nes)


###################################################
### code chunk number 6: genomicInstability.Rnw:117-120
###################################################
cnv <- genomicInstabilityScore(cnv)
names(cnv)
length(cnv$gis)


###################################################
### code chunk number 7: density
###################################################
par(mai=c(.8, .8, .2, .2))
plot(density(cnv$gis), lwd=2, xlab="GIS", main="")


###################################################
### code chunk number 8: genomicInstability.Rnw:142-143
###################################################
cnv <- giLikelihood(cnv)


###################################################
### code chunk number 9: genomicInstability.Rnw:146-149
###################################################
names(cnv)
names(cnv$gi_fit)
length(cnv$gi_likelihood)


###################################################
### code chunk number 10: fit
###################################################
giDensityPlot(cnv)


###################################################
### code chunk number 11: genomicInstability.Rnw:168-169
###################################################
cnv <- giLikelihood(cnv, recompute=FALSE, normal=1, tumor=2:3)


###################################################
### code chunk number 12: likelihood
###################################################
# Plotting the density distribution for GIS and fitted models
par(mai=c(.8, .8, .2, .8))
giDensityPlot(cnv, ylim=c(0, .8))
# Adding the likelihood data and second-axis
pos <- order(cnv$gis)
lines(cnv$gis[pos], cnv$gi_likelihood[pos]*.8, lwd=2)
axis(4, seq(0, .8, length=6), seq(0, 1, .2))
axis(4, .4, "Relative likelihood", tick=FALSE, line=1.5)
pos5 <- which.min((.5-cnv$gi_likelihood)^2)
lines(c(rep(cnv$gis[pos5], 2), max(cnv$gis*1.05)), c(0,
  rep(cnv$gi_likelihood[pos5]*.8, 2)), lty=3)


###################################################
### code chunk number 13: genomicInstability.Rnw:200-203
###################################################
cnv_norm <- inferCNV(tpm_matrix, nullmat=tpm_matrix[, cnv$gi_likelihood<.25,
                                                    drop=FALSE])
names(cnv_norm)


###################################################
### code chunk number 14: genomicInstability.Rnw:208-209
###################################################
cnv_norm <- genomicInstabilityScore(cnv_norm, likelihood=TRUE)


###################################################
### code chunk number 15: fitNull
###################################################
# Plotting the density distribution for GIS and fitted models
par(mai=c(.8, .8, .2, .8))
giDensityPlot(cnv_norm, ylim=c(0, 1.1))
# Adding the likelihood data and second-axis
pos <- order(cnv_norm$gis)
lines(cnv_norm$gis[pos], cnv_norm$gi_likelihood[pos], lwd=2, col="blue")
axis(4, seq(0, 1, length=6), seq(0, 1, .2), col="blue", col.axis="blue")
axis(4, .5, "Relative likelihood", tick=FALSE, line=1.5, col.axis="blue")
pos5 <- which.min((.5-cnv_norm$gi_likelihood)^2)
lines(c(rep(cnv_norm$gis[pos5], 2), max(cnv_norm$gis*1.05)),
      c(0, rep(cnv_norm$gi_likelihood[pos5], 2)), lty=3, col="blue")


###################################################
### code chunk number 16: fitClass
###################################################
metadata_tumor <- as.vector(metadata$classified..as.cancer.cell)[match(colnames(tpm_matrix),
    rownames(metadata))]
metadata_tumor <- as.logical(as.numeric(metadata_tumor))
# Plotting the density distribution for GIS and fitted models
par(mai=c(.8, .8, .2, .8))
giDensityPlot(cnv_norm, ylim=c(0, 1.1))
# Estimating GIS density distributions for normal and tumor cells
gis_normal <- cnv_norm$gis[!metadata_tumor]
gis_tumor <- cnv_norm$gis[metadata_tumor]
den_normal <- density(gis_normal, from=min(gis_normal), to=max(gis_normal))
den_tumor <- density(gis_tumor, from=min(gis_tumor), to=max(gis_tumor))
# Scaling the densities based on the inferred proportions for each group
den_normal$y <- den_normal$y * cnv_norm$gi_fit$lambda[1]
den_tumor$y <- den_tumor$y * sum(cnv_norm$gi_fit$lambda[2])
# Function to add the density plot
addDensity <- function(x, col="grey") {
  polygon(c(x$x[1], x$x, x$x[length(x$x)], x$x[1]), c(0, x$y, 0, 0), col=col)
}
# Adding the density plots
addDensity(den_normal, col=hsv(.6, .8, .8, .4))
addDensity(den_tumor, col=hsv(.05, .8, .8, .4))
# Adding the likelihood data and second-axis
pos <- order(cnv_norm$gis)
lines(cnv_norm$gis[pos], cnv_norm$gi_likelihood[pos], lwd=2, col="darkgreen")
axis(4, seq(0, 1, length=6), seq(0, 1, .2), col="darkgreen", col.axis="darkgreen")
axis(4, .5, "Relative likelihood", tick=FALSE, line=1.5, col.axis="darkgreen")
pos5 <- which.min((.5-cnv_norm$gi_likelihood)^2)
lines(c(rep(cnv_norm$gis[pos5], 2), max(cnv_norm$gis*1.05)),
      c(0, rep(cnv_norm$gi_likelihood[pos5], 2)), lty=3, col="blue")
# Adding the legend
legend(c(.9, 1), c("Normal", "Tumor"), fill=hsv(c(.6, .05), .8, .8, .4), bty="n")


###################################################
### code chunk number 17: genomicInstability.Rnw:281-282
###################################################
fisher.test(metadata_tumor, cnv_norm$gi_likelihood>.5, alternative="greater")


###################################################
### code chunk number 18: roc
###################################################
# Loading the pROC package
library(pROC)
roc_res <- roc(response=as.numeric(metadata_tumor), predictor=cnv_norm$gi_likelihood, auc=TRUE, ci=TRUE)
par(mai=c(.8, .8, .2, .8))
plot(roc_res)
legend("bottomright", c(paste0("AUC: ", round(roc_res$auc, 3)), paste0("CI 95%: ",
  round(roc_res$ci[1], 3), "-", round(roc_res$ci[3], 3))), bty="n")


###################################################
### code chunk number 19: heatmap
###################################################
plot(cnv_norm, output="heatmap.png", resolution=120, gamma=2)


###################################################
### code chunk number 20: genomicInstability.Rnw:324-325
###################################################
sessionInfo()


