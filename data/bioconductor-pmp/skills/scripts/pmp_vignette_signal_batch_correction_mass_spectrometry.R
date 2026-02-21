# Code example from 'pmp_vignette_signal_batch_correction_mass_spectrometry' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=FALSE----------------------
# install.packages("gridExtra")
# 
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("pmp")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(S4Vectors)
library(SummarizedExperiment)
library(pmp)
library(ggplot2)
library(reshape2)
library(gridExtra)

## ----eval=FALSE---------------------------------------------------------------
# help ("MTBLS79")

## -----------------------------------------------------------------------------
data("MTBLS79")

class <- MTBLS79$Class
batch <- MTBLS79$Batch
sample_order <- c(1:ncol(MTBLS79))

# Input data structure
MTBLS79

class[1:10]
batch[1:10]
sample_order[1:10]

## -----------------------------------------------------------------------------
data <- filter_peaks_by_fraction(df=MTBLS79, classes=class, method="QC",
    qc_label="QC", min_frac=0.8)

## -----------------------------------------------------------------------------
corrected_data <- QCRSC(df=data, order=sample_order, batch=batch, 
    classes=class, spar=0, minQC=4)

## ----message=FALSE, warning=FALSE, fig.height=5, fig.width=5------------------
plots <- sbc_plot (df=MTBLS79, corrected_df=corrected_data, classes=class, 
    batch=batch, output=NULL, indexes=c(1, 5, 30))
plots

## ----fig.width=6, fig.height=8------------------------------------------------

manual_color = c("#386cb0", "#ef3b2c", "#7fc97f", "#fdb462", "#984ea3", 
    "#a6cee3", "#778899", "#fb9a99", "#ffff33")

pca_data <- pqn_normalisation(MTBLS79, classes=class, qc_label="QC")
pca_data <- mv_imputation(pca_data, method="KNN", k=5, rowmax=0.5,
    colmax=0.5, maxp=NULL, check_df=FALSE)
pca_data <- glog_transformation(pca_data, classes=class, qc_label="QC")

pca_corrected_data <- pmp::pqn_normalisation(corrected_data, classes=class,
    qc_label="QC")
pca_corrected_data <- pmp::mv_imputation(pca_corrected_data, method="KNN", k=5,
    rowmax=0.5, colmax=0.5, maxp=NULL, check_df=FALSE)
pca_corrected_data <- pmp::glog_transformation(pca_corrected_data, 
    classes=class, qc_label="QC")

pca_data <- prcomp(t(assay(pca_data)), center=TRUE, scale=FALSE)
pca_corrected_data <- prcomp(t(assay(pca_corrected_data)),
    center=TRUE, scale=FALSE)

# Calculate percentage of explained variance of the first two PC's
exp_var_pca <- round(((pca_data$sdev^2)/sum(pca_data$sdev^2)*100)[1:2],2)
exp_var_pca_corrected <- round(((pca_corrected_data$sdev^2) /
    sum(pca_corrected_data$sdev^2)*100)[1:2],2)

plots <- list()

plotdata <- data.frame(PC1=pca_data$x[, 1], PC2=pca_data$x[, 2], 
    batch=as.factor(batch), class=class)

plots[[1]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=batch)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

plots[[2]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

plotdata_corr <- data.frame(PC1=pca_corrected_data$x[, 1], 
    PC2=pca_corrected_data$x[, 2], batch=as.factor(batch), class=class)

plots[[3]] <- ggplot(data=plotdata_corr, aes(x=PC1, y=PC2, col=batch)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, after correction") +
    xlab(paste0("PC1 (", exp_var_pca_corrected[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca_corrected[2] ," %)"))

plots[[4]] <- ggplot(data=plotdata_corr, aes(x=PC1, y=PC2, col=class)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, after correction") +
    xlab(paste0("PC1 (", exp_var_pca_corrected[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca_corrected[2] ," %)"))

grid.arrange(ncol=2, plots[[1]], plots[[2]], plots[[3]], plots[[4]])

## -----------------------------------------------------------------------------
sessionInfo()

