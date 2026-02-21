# Code example from 'Trout' vignette. See references/ for full tutorial.

## ----setup,include=FALSE------------------------------------------------------
# Install package if necessary (to be used before running the vignette)
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("limpca")

library(ggplot2)
library(limpca)
if (!requireNamespace("gridExtra", quietly = TRUE)) {
    stop("Install 'pander' to knit this vignette")
}
library(gridExtra)

if (!requireNamespace("pander", quietly = TRUE)) {
    stop("Install 'pander' to knit this vignette")
}
library(pander)
if (!requireNamespace("car", quietly = TRUE)) {
    stop("Install 'pander' to knit this vignette")
}
library(car)


knitr::opts_chunk$set(
    message = FALSE, warning = TRUE,
    comment = NA, crop = NULL,
    width = 60, dpi = 50,
    fig.width = 5,
    fig.height = 3.5, dev = "png"
)

## ----eval=FALSE---------------------------------------------------------------
# library(car)
# library(pander)
# library(gridExtra)
# library(ggplot2)

## ----Install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("limpca")

## ----Load, eval=FALSE---------------------------------------------------------
# library("limpca")

## ----Data Importation---------------------------------------------------------
data("trout")
# print number of and response names
cat("\n Nb of Responses :  ", ncol(trout$outcomes), "\n ")
cat("\nResponses :\n", colnames(trout$outcomes), "\n ")
# Order responses by alphabetic order
trout$outcomes <- trout$outcomes[, order(dimnames(trout$outcomes)[[2]])]
cat("\n Ordered responses :\n  ", colnames(trout$outcomes), "\n ")
# print factor names
cat("\nDesign factors :  ", colnames(trout$design), "\n ")
# plot the design with plotDesign function
limpca::plotDesign(
    design = trout$design, x = "Treatment",
    y = "Day", cols = "Exposure",
    title = "Initial design of the trout dataset"
)

## ----Exploratory PCA----------------------------------------------------------
resPCA <- limpca::pcaBySvd(trout$outcomes)
limpca::pcaScreePlot(resPCA, nPC = 8)
limpca::pcaScorePlot(
    resPcaBySvd = resPCA, axes = c(1, 2),
    title = "Score plot of original data ",
    design = trout$design, color = "Aquarium",
    points_labs_rn = TRUE
)

## ----Transformation-----------------------------------------------------------
# Log Transformation
trout_log <- trout
trout_log$outcomes <- as.matrix(log10(trout$outcomes))

# new PCA
resPCA1 <- limpca::pcaBySvd(trout_log$outcomes)
limpca::pcaScreePlot(resPCA1, nPC = 8)
limpca::pcaScorePlot(
    resPcaBySvd = resPCA1, axes = c(1, 2),
    title = "Score plot of Log10 data ",
    design = trout_log$design, color = "Aquarium",
    drawShapes = "polygon", points_labs_rn = TRUE
)

## ----Remove Outliers----------------------------------------------------------
# Remove outliers and create new dataset
trout_clean <- trout_log
outliers <- match(
    c("D72EPA2.1", "D28EPA2.2"),
    rownames(trout_log$outcomes)
)
trout_clean$outcomes <- trout_log$outcomes[-outliers, ]
trout_clean$design <- trout_log$design[-outliers, ]

## ----new PCA------------------------------------------------------------------
# PCA
resPCA2 <- limpca::pcaBySvd(trout_clean$outcomes)
limpca::pcaScreePlot(resPCA2, nPC = 8)
# Score plot Components 1 and 2
limpca::pcaScorePlot(
    resPcaBySvd = resPCA2, axes = c(1, 2),
    title = "Score plot of Log10 data without outliers (PC 1&2)",
    design = trout_clean$design, color = "Aquarium",
    drawShapes = "polygon",
    points_labs_rn = FALSE
)
# Score plot Components 3 and 4
limpca::pcaScorePlot(
    resPcaBySvd = resPCA2, axes = c(3, 4),
    title = "Score plot of Log10 data without outliers (PC 3&4)",
    design = trout_clean$design, color = "Aquarium",
    drawShapes = "polygon", points_labs_rn = FALSE
)

## ----Mean aggregation---------------------------------------------------------
# Mean aggregation
mean_outcomes <- matrix(0, nrow = 24, ncol = 15)
mean_design <- matrix(0, nrow = 24, ncol = 3)
y <- list(
    trout_clean$design[["Day"]],
    trout_clean$design[["Treatment"]],
    trout_clean$design[["Exposure"]]
)
for (i in 1:15) {
    mean_outcomes[, i] <- aggregate(trout_clean$outcomes[, i], by = y, mean)[, 4]
}
mean_design <- aggregate(trout_clean$outcomes[, 1], by = y, mean)[, c(1:3)]

# Set row and col names
colnames(mean_outcomes) <- colnames(trout_clean$outcomes)
colnames(mean_design) <- colnames(trout_clean$design)[1:3]
trout_mean_names <- apply(mean_design, 1, paste, collapse = "")
rownames(mean_outcomes) <- trout_mean_names
rownames(mean_design) <- trout_mean_names

## ----Centering and Scaling----------------------------------------------------
# Outcomes centering and Scaling
mean_outcomes <- scale(mean_outcomes, center = TRUE, scale = TRUE)
# New data object creation
trout_mean <- list(
    "outcomes" = mean_outcomes,
    "design" = mean_design,
    "formula" = trout$formula
)
# Clean objects
rm(
    resPCA, resPCA1, resPCA2, y, mean_design, mean_outcomes,
    trout_mean_names
)

## ----Design-------------------------------------------------------------------
pander(head(trout_mean$design))
limpca::plotDesign(
    design = trout_mean$design,
    title = "Design of mean aggregated trout dataset"
)

## ----Lineplot-----------------------------------------------------------------
limpca::plotLine(trout_mean$outcomes,
    rows = c(1, 24),
    xaxis_type = "character", type = "s"
) +
    ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----PCA----------------------------------------------------------------------
resPCA_mean <- limpca::pcaBySvd(trout_mean$outcomes)
pcaScreePlot(resPCA_mean, nPC = 6)

## -----------------------------------------------------------------------------
limpca::pcaScorePlot(
    resPcaBySvd = resPCA_mean, axes = c(1, 2),
    title = "PCA score plot by Exposure and Day",
    design = trout_mean$design,
    shape = "Exposure", color = "Day",
    points_labs_rn = FALSE
)

limpca::pcaScorePlot(
    resPcaBySvd = resPCA_mean, axes = c(1, 2),
    title = "PCA scores plot by Treatment and Day",
    design = trout_mean$design,
    shape = "Day", color = "Treatment",
    points_labs_rn = FALSE
)

limpca::pcaScorePlot(
    resPcaBySvd = resPCA_mean, axes = c(1, 2),
    title = "PCA scores plot by Exposure and Treatment",
    design = trout_mean$design,
    shape = "Treatment", color = "Exposure",
    points_labs_rn = FALSE
)

## -----------------------------------------------------------------------------
limpca::pcaLoading1dPlot(
    resPcaBySvd = resPCA_mean, axes = c(1, 2),
    title = "PCA loadings plot trout", xlab = " ",
    ylab = "Expression", xaxis_type = "character", type = "s"
) +
    ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1))

## -----------------------------------------------------------------------------
limpca::pcaLoading2dPlot(
    resPcaBySvd = resPCA_mean, axes = c(1, 2),
    title = "PCA loadings plot trout", addRownames = TRUE
)

## ----Scatterplot Matrix,fig.width=10,fig.height=10----------------------------
limpca::plotScatterM(
    Y = trout_mean$outcomes, cols = c(1:15),
    design = trout_mean$design,
    varname.colorup = "Day",
    vec.colorup = c("CadetBlue4", "pink", "orange"),
    varname.colordown = "Day",
    vec.colordown = c("CadetBlue4", "pink", "orange"),
    varname.pchup = "Treatment",
    varname.pchdown = "Exposure"
)

## ----ModelMatrix--------------------------------------------------------------
resLmpModelMatrix <- limpca::lmpModelMatrix(trout_mean)
pander::pander(head(resLmpModelMatrix$modelMatrix))

## ----EffectMatrices-----------------------------------------------------------
resLmpEffectMatrices <- lmpEffectMatrices(resLmpModelMatrix)
resLmpEffectMatrices$varPercentagesPlot

## ----Bootstrap----------------------------------------------------------------
resLmpBootstrapTests <- lmpBootstrapTests(
    resLmpEffectMatrices = resLmpEffectMatrices,
    nboot = 1000
)

# Print p-values
pander::pander(t(resLmpBootstrapTests$resultsTable))

## ----ASCA PCA-----------------------------------------------------------------
resASCA <- lmpPcaEffects(
    resLmpEffectMatrices = resLmpEffectMatrices,
    method = "ASCA",
    combineEffects = list(c(
        "Day", "Treatment",
        "Day:Treatment"
    ))
)

## ----ASCA Contrib-------------------------------------------------------------
resLmpContributions <- lmpContributions(resASCA)

## ----ASCA ContribP------------------------------------------------------------
pander::pander(resLmpContributions$totalContribTable)
pander::pander(resLmpContributions$effectTable)
pander::pander(resLmpContributions$contribTable)
pander::pander(resLmpContributions$combinedEffectTable)

## Visualize the more important contributions
resLmpContributions$plotContrib

## ----ASCA Day-----------------------------------------------------------------
A <- lmpScorePlot(resASCA,
    effectNames = "Day",
    color = "Day", shape = "Day"
)
B <- lmpLoading2dPlot(resASCA,
    effectNames = "Day",
    points_labs = colnames(trout$outcomes)
)
grid.arrange(A, B, ncol = 2)

## ----ASCA Treatment-----------------------------------------------------------
A <- lmpScorePlot(resASCA,
    effectNames = "Treatment",
    color = "Treatment", shape = "Treatment"
)
B <- lmpLoading2dPlot(resASCA,
    effectNames = "Treatment",
    points_labs = colnames(trout$outcomes)
)
grid.arrange(A, B, ncol = 2)

## ----ASCA DayTreatment--------------------------------------------------------
A <- lmpScorePlot(resASCA,
    effectNames = "Day:Treatment",
    color = "Treatment", shape = "Day"
)
B <- lmpLoading2dPlot(resASCA,
    effectNames = "Day:Treatment",
    points_labs = colnames(trout$outcomes)
)
grid.arrange(A, B, ncol = 2)

## ----ASCA Combined effect-----------------------------------------------------
A <- lmpScorePlot(resASCA,
    effectNames = "Day+Treatment+Day:Treatment",
    color = "Treatment", shape = "Day"
)
B <- lmpLoading2dPlot(resASCA,
    effectNames = "Day+Treatment+Day:Treatment",
    points_labs = colnames(trout$outcomes)
)
grid.arrange(A, B, ncol = 2)

## ----ASCA Residuals-----------------------------------------------------------
A <- lmpScorePlot(resASCA,
    effectNames = "Residuals",
    color = "Treatment", shape = "Day"
)
B <- lmpLoading2dPlot(resASCA,
    effectNames = "Residuals",
    points_labs = colnames(trout$outcomes)
)
grid.arrange(A, B, ncol = 2)

## ----ASCA Effects-------------------------------------------------------------
A <- lmpEffectPlot(resASCA,
    effectName = "Day:Treatment",
    x = "Day", z = "Treatment", axes = c(1, 2)
)
A$PC1 <- A$PC1 + ggtitle("PC1: Day:Treatment effect alone")
A$PC2 <- A$PC2 + ggtitle("PC2: Day:Treatment effect alone")
grid.arrange(A$PC1, A$PC2, ncol = 2)

A <- lmpEffectPlot(resASCA,
    effectName = "Day+Treatment+Day:Treatment",
    x = "Day", z = "Treatment", axes = c(1, 2)
)
A$PC1 <- A$PC1 + ggtitle("PC1: Combined D+T+D:T effects")
A$PC2 <- A$PC2 + ggtitle("PC2: Combined D+T+D:T effects")
grid.arrange(A$PC1, A$PC2, ncol = 2)

## ----APCA PCA-----------------------------------------------------------------
resAPCA <- lmpPcaEffects(
    resLmpEffectMatrices =
        resLmpEffectMatrices, method = "APCA"
)

## ----APCA Scores--------------------------------------------------------------
# Day Effect
lmpScorePlot(resAPCA,
    effectNames = "Day",
    color = "Day", shape = "Day", drawShapes = "ellipse"
)

# Treatment Effect
lmpScorePlot(resAPCA,
    effectNames = "Treatment",
    color = "Treatment", shape = "Treatment", drawShapes = "ellipse"
)


# Exposure Effect
lmpScorePlot(resAPCA,
    effectNames = "Exposure",
    color = "Exposure", shape = "Exposure", drawShapes = "ellipse"
)

# Day:Treatment Effect
lmpScorePlot(resAPCA,
    effectNames = "Day:Treatment",
    color = "Treatment", shape = "Day", drawShapes = "polygon"
)

## ----Anova--------------------------------------------------------------------
# Creation of a matrix to store the p-values
m <- ncol(trout_mean$outcomes)
mat_pval <- matrix(nrow = m, ncol = 6)
dimnames(mat_pval) <- list(
    dimnames(trout_mean$outcomes)[[2]],
    c(
        "Day", "Treatment", "Exposure", "Day:Treatment",
        "Day:Exposure", "Treatment:Exposure"
    )
)

# Parallel ANOVA modeling
for (i in 1:m) {
    data <- cbind(y = trout_mean$outcomes[, i], trout_mean$design)
    Modl <- lm(y ~ Day + Treatment + Exposure + Day:Treatment + Day:Exposure + Treatment:Exposure,
        contrasts = list(Day = contr.sum, Treatment = contr.sum, Exposure = contr.sum),
        data = data
    )
    tabanova <- Anova(Modl, type = 3)
    mat_pval[i, ] <- tabanova[2:7, 4]
}

# FDR p-values correction
for (i in 1:6) mat_pval[, i] <- p.adjust(mat_pval[, i], method = "BH")

## -----------------------------------------------------------------------------
pander(mat_pval)
heatmap(-log10(mat_pval),
    Rowv = NA, Colv = "Rowv",
    cexCol = 0.8, scale = "none", main = "Heatmap of -log10(q-values)"
)

## ----eval=TRUE----------------------------------------------------------------
Effects <- c("Day", "Treatment", "Day:Treatment")

for (i in 1:3) {
    Pval_log <- -log10(mat_pval[, Effects[i]])
    resA <- resASCA[[Effects[i]]]
    PC12Load <- as.vector(sqrt(resA$loadings[, 1:2]^2 %*% resA$singvar[1:2]^2))
    matres <- cbind(PC12Load, Pval_log)
    A[[i]] <- plotScatter(
        Y = matres, xy = c(1, 2),
        points_labs = rownames(matres),
        xlab = "PC1&2 ASCA loadings", ylab = "-log10(p-values)",
        title = paste(Effects[i], "effect")
    )
}

A[[1]]
A[[2]]
A[[3]]

## -----------------------------------------------------------------------------
sessionInfo()

