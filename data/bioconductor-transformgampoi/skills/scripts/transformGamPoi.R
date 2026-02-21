# Code example from 'transformGamPoi' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
set.seed(1)
par(cex = 1.5)

## ----setup--------------------------------------------------------------------
library(transformGamPoi)

## ----loadData-----------------------------------------------------------------
# Load the 'TENxPBMCData' as a SingleCellExperiment object
sce <- TENxPBMCData::TENxPBMCData("pbmc4k")
# Subset the data to 1,000 x 500 random genes and cells
sce <- sce[sample(nrow(sce), 1000), sample(ncol(sce), 500)]

## -----------------------------------------------------------------------------
assay(sce, "counts")[1:10, 1:5]

## -----------------------------------------------------------------------------
library(MatrixGenerics)
# Exclude genes where all counts are zero
sce <- sce[rowMeans2(counts(sce)) > 0, ]
gene_means <- rowMeans2(counts(sce))
gene_var <- rowVars(counts(sce))
plot(gene_means, gene_var, log = "xy", main = "Log-log scatter plot of mean vs variance")
abline(a = 0, b = 1)
sorted_means <- sort(gene_means)
lines(sorted_means, sorted_means + 0.2 * sorted_means^2, col = "purple")

## -----------------------------------------------------------------------------
assay(sce, "acosh") <- acosh_transform(assay(sce, "counts"))
# Equivalent to 'assay(sce, "acosh") <- acosh_transform(sce)'

## -----------------------------------------------------------------------------
acosh_var <- rowVars(assay(sce, "acosh"))
plot(gene_means, acosh_var, log = "x", main = "Log expression vs variance of acosh stabilized values")
abline(h = 1)

## -----------------------------------------------------------------------------
x <- seq(0, 30, length.out = 1000)
y_acosh <- acosh_transform(x, overdispersion = 0.1)
y_shiftLog <- shifted_log_transform(x, pseudo_count = 1/(4 * 0.1))
y_sqrt <- 2 * sqrt(x) # Identical to acosh_transform(x, overdispersion = 0)

## -----------------------------------------------------------------------------
plot(x, y_acosh, type = "l", col = "black", lwd = 3, ylab = "g(x)", ylim = c(0, 10))
lines(x, y_shiftLog, col = "red", lwd = 3)
lines(x, y_sqrt, col = "blue", lwd = 3)
legend("bottomright", legend = c(expression(2*sqrt(x)), 
                                 expression(1/sqrt(alpha)~acosh(2*alpha*x+1)),
                                 expression(1/sqrt(alpha)~log(x+1/(4*alpha))+b)),
       col = c("blue", "black", "red"), lty = 1, inset = 0.1, lwd = 3)

## -----------------------------------------------------------------------------
assay(sce, "pearson") <- residual_transform(sce, "pearson", clipping = TRUE, on_disk = FALSE)

## -----------------------------------------------------------------------------
pearson_var <- rowVars(assay(sce, "pearson"))
plot(gene_means, pearson_var, log = "x", main = "Log expression vs variance of Pearson residuals")
abline(h = 1)

## -----------------------------------------------------------------------------
assay(sce, "rand_quantile") <- residual_transform(sce, "randomized_quantile", on_disk = FALSE)

## -----------------------------------------------------------------------------
rand_quant_var <- rowVars(assay(sce, "rand_quantile"))
plot(gene_means, rand_quant_var, log = "x", main = "Log expression vs variance of Randomized Quantile residuals")
abline(h = 1)

## -----------------------------------------------------------------------------
sessionInfo()

