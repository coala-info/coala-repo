# Code example from 'CONSTANd' vignette. See references/ for full tutorial.

## ----setup, include=TRUE------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,dev="CairoPNG")
library(knitr)
library(tidyr)
library(ggplot2)
library(gridExtra)
library(magick)
library(limma)

## ----CONSTANd-----------------------------------------------------------------
#install.packages("BiocManager")
#BiocManager::install("CONSTANd")
library(CONSTANd)

## ----echo=FALSE, fig.align='center',fig.wide=TRUE, out.width='50%', fig.scap="short",fig.cap='This MA plot violates all assumptions: there is more than one cloud, there are more upregulated entities, and the bias changes strongly in the region with small magnitudes (A-values).'----
par(mfrow=c(1,1))
include_graphics('bad_MA.png')

## -----------------------------------------------------------------------------
leish <- read.csv("../inst/extdata/GSE95353_SL_SEQ_LOGSTAT_counttable.txt" , sep='\t')

## -----------------------------------------------------------------------------
rownames(leish) <- leish$gene
leish <- leish[, c("SL.LOG1", "SL.LOG2", "SL.LOG3", "SL.LOG4", 
                   "SL.STAT1", "SL.STAT2", "SL.STAT3", "SL.STAT4")]
conditions <- c(rep("LOG", 4), rep("STAT", 4))

## -----------------------------------------------------------------------------
# first set NA to 0 for calculating the row medians
leish[is.na(leish)] <- 0
leish <- leish[apply(leish, 1, median, na.rm = FALSE) > 0,]
leish.norm <- CONSTANd(leish)$normalized_data

## ----fig.align='center',fig.wide=TRUE,fig.cap="LOG samples (blue) are separated more clearly by PC1 from the STAT samples (red) in the Leishmania data set after CONSTANd normalization."----
leish[is.na(leish)] <- 0
# scale raw data
leish.pc.raw <- prcomp(x=t(leish), scale. = TRUE)
leish.norm[is.na(leish.norm)] <- 0
# CONSTANd already scaled the data
leish.pc.norm <- prcomp(x=t(leish.norm))
par(mfrow=c(1,2))
colors = ifelse(conditions == 'LOG', 'blue', 'red')
plot(leish.pc.raw$x[,'PC1'], leish.pc.raw$x[,'PC2'], 
     xlab='PC1', ylab='PC2', main='raw counts', col=colors)
plot(leish.pc.norm$x[,'PC1'], leish.pc.norm$x[,'PC2'], 
     xlab='PC1', ylab='PC2', main='normalized counts', col=colors)

## ----echo=FALSE, fig.align='center',fig.wide=TRUE, out.width='50%', fig.scap="short",fig.cap='Organs data set experimental setup: 8 mouse organ samples spread across 4 TMT 8-plex tndem-MS runs, one for each mouse. Image source: Bailey, Derek J., et al. "Intelligent data acquisition blends targeted and discovery methods." Journal of proteome research 13.4 (2014): 2152-2161. https://doi.org/10.1021/pr401278j.'----
par(mfrow=c(1,1))
include_graphics('organ_experiment_design.png')

## -----------------------------------------------------------------------------
LOAD_ORIGINAL = FALSE
# load extra functions to clean the original data and study design files
source('../inst/script/functions.R')
if (LOAD_ORIGINAL) {  # load original from web
    BR1 <- read.csv('Organs_PSMs_1.txt', sep='\t')
    BR2 <- read.csv('Organs_PSMs_2.txt', sep='\t')
    BR3 <- read.csv('Organs_PSMs_3.txt', sep='\t')
    BR4 <- read.csv('Organs_PSMs_4.txt', sep='\t')
    organs <- list(BR1, BR2, BR3, BR4)
    organs <- clean_organs(organs)
} else {  # load cleaned file that comes with this package
    organs <- readRDS('../inst/extdata/organs_cleaned.RDS')
}
# construct the study design from the QCQuan DoE file and arrange it properly
study.design <- read.csv("../inst/extdata/Organs_DoE.tsv", sep='\t', header = FALSE)
study.design <- rearrange_organs_design(study.design)

## -----------------------------------------------------------------------------
# the data has been summarized to peptide level
head(rownames(organs[[1]]))
# only the quantification columns were kept, which here happen to be all of them
quanCols <- colnames(organs[[1]])
quanCols
organs <- lapply(organs, function(x) x[,quanCols])
# make unique quantification column names
for (i in seq_along(organs)) { 
  colnames(organs[[i]]) <- paste0('BR', i, '_', colnames(organs[[i]])) }

## -----------------------------------------------------------------------------
organs.norm.obj <- lapply(organs, function(x) CONSTANd(x))
organs.norm <- lapply(organs.norm.obj, function(x) x$normalized_data)

## -----------------------------------------------------------------------------
merge_list_of_dataframes <- function(list.dfs) {
    return(Reduce(function(x, y) {
        tmp <- merge(x, y, by = 0, all = FALSE)
        rownames(tmp) <- tmp$Row.names
        tmp$Row.names <- NULL
        return(tmp)
    }, list.dfs))}
organs.df <- merge_list_of_dataframes(organs)
organs.norm.df <- merge_list_of_dataframes(organs.norm)

## -----------------------------------------------------------------------------
# PCA can't deal with NA values: impute as zero (this makes sense in a multiplex)
organs.df[is.na(organs.df)] <- 0
organs.norm.df[is.na(organs.norm.df)] <- 0
# scale raw data
organs.pc <- prcomp(x=t(organs.df), scale. = TRUE)
# CONSTANd already scaled the data
organs.norm.pc <- prcomp(x=t(organs.norm.df))

## -----------------------------------------------------------------------------
# prepare plot color mappings
organs.pcdf <- as.data.frame(organs.pc$x)
organs.pcdf <- merge(organs.pcdf, study.design, by=0)
rownames(organs.pcdf) <- organs.pcdf$Row.names
organs.norm.pcdf <- as.data.frame(organs.norm.pc$x)
organs.norm.pcdf <- merge(organs.norm.pcdf, study.design, by=0)
rownames(organs.norm.pcdf) <- organs.norm.pcdf$Row.names

## ----echo=FALSE,fig.wide=TRUE,fig.cap="Before normalization, the samples in the Organs data set are all scattered across the PCA plot. After normalization, they are correctly grouped according to biological condition, even though all 4 samples in each group have been measured in a different MS run. The big separation in PC1 suggests that the muscle tissue is very different from the tissues of other types of organs!"----
p1 <- ggplot(organs.pcdf, aes(x=PC1, y=PC2, color=condition)) + ggtitle("raw intensities") + geom_point() + theme_bw() + theme(legend.position = "none") + theme(plot.title = element_text(hjust=0.5))
p2 <- ggplot(organs.norm.pcdf, aes(x=PC1, y=PC2, color=condition)) + ggtitle("normalized intensities") + geom_point() + theme_bw() + theme(legend.position = "right") + theme(plot.title = element_text(hjust=0.5))
shared_legend <- extract_legend(p2)
grid.arrange(arrangeGrob(p1, p2 + theme(legend.position = "none"), ncol = 2), 
             shared_legend, widths=c(5,1))

## -----------------------------------------------------------------------------
MAplot <- function(x,y,use.order=FALSE, R=NULL, cex=1.6, showavg=TRUE) {
  # make an MA plot of y vs. x that shows the rolling average,
  M <- log2(y/x)
  xlab = 'A'
  if (!is.null(R)) {r <- R; xlab = "A (re-scaled)"} else r <- 1
  A <- (log2(y/r)+log2(x/r))/2
  if (use.order) {
    orig.order <- order(A)
    A <- orig.order
    M <- M[orig.order]
    xlab = "original rank of feature magnitude within IPS"
  }
  # select only finite values
  use <- is.finite(M)
  A <- A[use]
  M <- M[use]
  # plot
  print(var(M))
  plot(A, M, xlab=xlab, cex.lab=cex, cex.axis=cex)
  # rolling average
  if (showavg) { lines(lowess(M~A), col='red', lwd=5) }
}

## -----------------------------------------------------------------------------
# Example for cerebrum and kidney conditions in run (IPS) 1 in the Organs data set.
cerebrum1.colnames <- rownames(study.design %>% dplyr::filter(run=='BR1', condition=='cerebrum'))
kidney1.colnames <- rownames(study.design %>% dplyr::filter(run=='BR1', condition=='kidney'))
cerebrum1.raw <- organs.df[,cerebrum1.colnames]
kidney1.raw <- organs.df[,kidney1.colnames]
# rowMeans in case of multiple columns
if (!is.null(dim(cerebrum1.raw))) cerebrum1.raw <- rowMeans(cerebrum1.raw)  
if (!is.null(dim(kidney1.raw))) kidney1.raw <- rowMeans(kidney1.raw)
MAplot(cerebrum1.raw, kidney1.raw)

## -----------------------------------------------------------------------------
cerebrum1.norm <- organs.norm.df[,cerebrum1.colnames]
kidney1.norm <- organs.norm.df[,kidney1.colnames]
# rowMeans in case of multiple columns
if (!is.null(dim(cerebrum1.norm))) cerebrum1.norm <- rowMeans(cerebrum1.norm)  
if (!is.null(dim(kidney1.norm))) kidney1.norm <- rowMeans(kidney1.norm)
BR1.R <- organs.norm.obj[[1]]$R[rownames(organs.norm.df)]
MAplot(cerebrum1.norm, kidney1.norm, R=BR1.R)

## -----------------------------------------------------------------------------
get_design_matrix <- function(referenceCondition, study.design) {
    # ANOVA-like design matrix for use in moderated_ttest, indicating group 
    # (condition) membership of each entry in all_samples.
    otherConditions = setdiff(unique(study.design$condition), referenceCondition)
    all_samples = rownames(study.design)
    N_samples = length(all_samples) 
    N_conditions = 1+length(otherConditions)
    design = matrix(rep(0,N_samples*N_conditions), c(N_samples, N_conditions))
    design[, 1] <- 1  # reference gets 1 everywhere
    rownames(design) <- all_samples
    colnames(design) <- c(referenceCondition, otherConditions)
    for (i in 1:N_samples) {  # for each channel in each condition, put a "1" in the design matrix.
        design[as.character(rownames(study.design)[i]), as.character(study.design$condition[i])] <- 1 }
    return(design)
}
moderated_ttest <- function(dat, design_matrix, scale) {
  # inspired by http://www.biostat.jhsph.edu/~kkammers/software/eupa/R_guide.html
  design_matrix <- design_matrix[match(colnames(dat), rownames(design_matrix)),]  # fix column order
  reference_condition <- colnames(design_matrix)[colSums(design_matrix) == nrow(design_matrix)]
  nfeatures <- dim(dat)[1]
  
  fit <- limma::eBayes(lmFit(dat, design_matrix))
  
  reference_averages <- fit$coefficients[,reference_condition]
  logFC <- fit$coefficients
  logFC <- log2((logFC+reference_averages)/reference_averages)
  # correct the reference
  logFC[,reference_condition] <- logFC[,reference_condition] - 1
  # moderated q-value corresponding to the moderated t-statistic
  if(nfeatures>1) { 
    q.mod <- apply(X = fit$p.value, MARGIN = 2, FUN = p.adjust, method='BH') 
  } else q.mod <- fit$p.value
  return(list(logFC=logFC, qval=q.mod))
}

design_matrix <- get_design_matrix('cerebrum', study.design)
result <- moderated_ttest(organs.norm.df, design_matrix)

## -----------------------------------------------------------------------------
sessionInfo()

