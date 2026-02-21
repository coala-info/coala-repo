# Code example from 'pmp_vignette_sbc_spectral_quality_assessment' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.width=5,
    fig.height=5
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
feature_names <- c("70.03364", "133.07379", "146.16519", "163.04515", 
    "174.89483", "200.03196", "207.07818", "221.05062", "240.02445",
    "251.03658", "266.01793", "304.99115", "321.07923", "338.98131", 
    "376.03962", "393.35878", "409.05716", "430.24353", "451.01086",
    "465.14937")
summary(t(SummarizedExperiment::assay(MTBLS79[feature_names, ])))

## -----------------------------------------------------------------------------
#number of samples:
ncol(MTBLS79)

## -----------------------------------------------------------------------------
#Batches:
unique(MTBLS79$Batch)

## -----------------------------------------------------------------------------
#Sample classes:
unique(MTBLS79$Class)

## ----fig.height=5, fig.width=4, message=FALSE, warning=FALSE------------------
#  separate the LCMS data from the meta data
data(MTBLS79)
data <- SummarizedExperiment::assay(MTBLS79[feature_names, ])
class <- SummarizedExperiment::colData(MTBLS79)$Class
batch <- SummarizedExperiment::colData(MTBLS79)$Batch
order <- c(1:ncol(data))

# get index of QC samples
QChits <- which(class == "QC")

# small function to calculate RSD%
FUN <- function(x) sd(x, na.rm=TRUE) / mean(x, na.rm=TRUE) * 100

# RSD% of biological and QC samples within all 8 batches:
out <- matrix(ncol=2, nrow=nrow(data))
colnames(out) <- c("Sample","QC")
rownames(out) <- rownames(data)

# for each feature calculate RSD% for the samples and the QCs
for (i in 1:nrow(data)) {
    out[i, 1] <- FUN(data[i, -QChits]) # for samples
    out[i, 2] <- FUN(data[i, QChits]) # for QCs
}

# prepare data for plotting
plotdata <- melt(data.frame(out), variable.name="Class", value.name="RSD")
plotdata$feature <- rownames(data)

plotdata$RSD <- round(plotdata$RSD,0)
plotdata$feature <- factor(plotdata$feature, ordered=TRUE,
    levels=unique(plotdata$feature))

# plot
ggplot(data=plotdata, aes(x=Class, y=feature, fill=RSD)) + 
    geom_tile() + 
    geom_text(aes(label=RSD)) +
    scale_fill_gradient2(low="black", mid="white", high="red")

## -----------------------------------------------------------------------------
ggplot(data=plotdata, aes(x=Class, y=RSD, fill=Class)) +
    geom_violin(draw_quantiles=c(0.25,0.5,0.75)) +
    ylab("RSD%") + 
    guides(fill=FALSE) +
    theme(panel.background=element_blank())

## ----message=FALSE, warning=FALSE, fig.height=6-------------------------------
# prepare some matrices to store the results
RSDQC <- matrix(ncol=8, nrow=nrow(data))
RSDsample <- matrix(ncol=8, nrow=nrow(data))
colnames(RSDQC) <- unique(batch)
colnames(RSDsample) <- unique(batch)

rownames(RSDQC) <- rownames(data)
rownames(RSDsample) <- rownames(data)

# for each feature
for (i in 1:nrow(data)) {
    # for each batch
    for (nb in 1:8) {
        # RSD% of QCs in this batch
        RSDQC[i, nb] <- FUN(data[i, which(class == "QC" & batch == nb)])
        # RSD% of samples in this batch
        RSDsample[i, nb] <- FUN(data[i, which(!class == "QC" & batch == nb)])
    }
}

# prepare results for plotting
plotdataQC <- melt(as.data.frame(RSDQC), variable.name="batch",
    value.name="RSD")
plotdataQC$Class <- "QC"

plotdataBio <- melt(as.data.frame(RSDsample), variable.name="batch",
    value.name="RSD")
plotdataBio$Class <- "Sample"

plotdata <- rbind(plotdataQC, plotdataBio)

plotdata$Class <- as.factor(plotdata$Class)

# plot
ggplot(data=plotdata, aes(x=Class, y=RSD, fill=Class)) + geom_boxplot() +
    facet_wrap(~ batch, ncol=3) +
    ylab("RSD%") +
    xlab("") +
    scale_x_discrete(labels=NULL) +
    theme(panel.background=element_blank(), axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

## -----------------------------------------------------------------------------
summary(RSDQC)

## -----------------------------------------------------------------------------
summary(RSDsample)

## ----message=FALSE, warning=FALSE---------------------------------------------

# prepare a list of colours for plotting
manual_color = c("#386cb0", "#ef3b2c", "#7fc97f", "#fdb462", "#984ea3", 
    "#a6cee3", "#778899", "#fb9a99", "#ffff33")

# Function to calculate median absolute deviation
DRatfun <- function(samples, qcs) mad(qcs) / mad(samples)

# prepare matrix for dratio output
dratio <- matrix(ncol=8, nrow=nrow(data))
colnames(dratio) <- unique(batch)
rownames(dratio) <- rownames(data)

# calculate dratio for each feature, per batch
for (i in 1:nrow(dratio)){
    for (nb in 1:8) {
        dratio[i, nb] <- DRatfun(samples=data[i, which(!class == "QC" &
        batch == nb)], qcs=data[i, which(class == "QC" & batch == nb)])
    }
}

# prepare data for plotting
dratio <- as.data.frame(round(dratio, 2))

plotdata2 <- melt(dratio, variable.name="batch")
plotdata2$index <- rownames(data)
plotdata2$index <- factor(plotdata2$index, ordered=TRUE,
    levels=unique(plotdata2$index))

ggplot(data=plotdata2, aes(x=index, y=value, color=batch)) +
    geom_point(size=2) +
    xlab("index") + ylab("D-ratio") +
    geom_hline(yintercept=1) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    theme(axis.text.x=element_text(angle=90))

## ----fig.width=6.5, fig.height=5----------------------------------------------
pca_data <- MTBLS79[feature_names, ]

pca_data <- pqn_normalisation(pca_data, classes=class, qc_label="QC")
pca_data <- mv_imputation(pca_data, method="KNN", k=5, rowmax=0.5,
    colmax=0.5, maxp=NULL, check_df=FALSE)
pca_data <- glog_transformation(pca_data, classes=class, qc_label="QC")

pca_data <- prcomp(t(SummarizedExperiment::assay(pca_data)), center=TRUE, 
    scale=FALSE)
exp_var_pca <- round(((pca_data$sdev^2)/sum(pca_data$sdev^2)*100)[1:2], 2)

plots <- list()

plotdata <- data.frame(PC1=pca_data$x[, 1], PC2=pca_data$x[, 2],
    batch=as.factor(batch), class=class)

plots[[1]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=batch)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

plots[[2]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=class)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores plot, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

grid.arrange(ncol=2, plots[[1]], plots[[2]])

## ----message=FALSE, warning=FALSE, fig.height=10------------------------------

# autoscale the QC data
QCdata <- data[ ,QChits]
QCdata2 <- as.data.frame(scale(t(QCdata), scale=TRUE, center=TRUE))

# prepare the data for plotting
plotdata <- melt(QCdata2, value.name="intensity")
plotdata$index <- rep(1:nrow(QCdata2), ncol(QCdata2))

plotdata$batch <- as.factor(batch[QChits])

# plot
ggplot(data=plotdata, aes(x=index, y=intensity, col=batch)) +
    geom_point(size=2) +
    facet_wrap(~ variable, ncol=4) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color)

## ----warning=FALSE, fig.height=10---------------------------------------------
ggplot(data=plotdata, aes(x=index, y=intensity, col=batch)) + 
    geom_point(size=2) +
    facet_wrap(~ variable, ncol=4) +
    geom_smooth(method="lm", se=TRUE, colour="black") +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color)

## ----message=FALSE, warning=FALSE, fig.height=7.5-----------------------------
sampleorder <- c(1:ncol(QCdata))

correlations <- matrix(ncol=2, nrow=nrow(data))
rownames(correlations) <- rownames(data)
colnames(correlations) <- c("tau","p.value")
correlations <- as.data.frame(correlations)

for (coln in 1:nrow(data)) {
    stat <- cor.test(sampleorder, QCdata[coln, ], method="kendall")
    correlations$tau[coln] <- stat$estimate
    correlations$p.value[coln] <- stat$p.value
}

correlations


## ----warning=FALSE, message=FALSE---------------------------------------------

correlations <- matrix(ncol=8, nrow=nrow(data))
rownames(correlations) <- rownames(data)
colnames(correlations) <- unique(batch)

QCbatch <- batch[QChits]

for (coln in 1:nrow(data)) {
    for (bch in 1:8) {
        sampleorder <- scale(c(1:length(which(QCbatch==bch))),
        center=TRUE, scale=TRUE)

        if ((length(sampleorder) - 
        length(which(is.na(QCdata[coln, which(QCbatch==bch)])))) >= 3){
            correlations[coln, bch] <- cor.test(sampleorder,
            QCdata[coln, which(QCbatch==bch)], method="kendall")$estimate
        }
    }
}

round(correlations, 2)

## ----fig.wide=TRUE------------------------------------------------------------
plotdata <- as.data.frame(correlations)
plotdata$feature <- rownames(plotdata)

plotdata <- melt(plotdata, variable.name="batch")
plotdata$feature <- factor(plotdata$feature, ordered=TRUE,
    levels = unique(plotdata$feature))

ggplot(data=plotdata, aes(x=batch, y=feature, fill=value)) + 
    geom_tile() + scale_fill_gradient2()


## -----------------------------------------------------------------------------
sampleorder <- c(1:ncol(QCdata))

regressionout <- matrix(ncol=3, nrow=nrow(data))
rownames(regressionout) <- rownames(data)
colnames(regressionout) <- c("R2.adj","coefficient","p.value")
regressionout <- as.data.frame(regressionout)

for (coln in 1:nrow(data)) {
    tempdat <- data.frame(x=sampleorder, y=QCdata[coln, ])
    stat <- lm(x ~ y, data=tempdat)
    stat <- summary(stat)

    regressionout$R2.adj[coln] <- stat$adj.r.squared  
    regressionout$coefficient[coln] <- stat$coefficients[2,1]
    regressionout$p.value[coln] <- stat$coefficients[2,4]
}

regressionout

## -----------------------------------------------------------------------------
regPerBatch <- matrix(ncol=8, nrow=nrow(data))
rownames(regPerBatch) <- rownames(data)
colnames(regPerBatch) <- unique(batch)

QCbatch <- MTBLS79$Batch[QChits]

for (coln in 1:nrow(data)) {
    for (bch in 1:8) {
        sampleorder <- c(1:length(which(QCbatch == bch)))
        tempdat <- data.frame(x=sampleorder, y=QCdata[coln, 
            which(QCbatch==bch)])
        stat <- lm(x ~ y, data=tempdat)
        stat <- summary(stat)
        regPerBatch[coln,bch] <- stat$adj.r.squared
    }
}

round(regPerBatch,2)

## ----fig.wide=TRUE------------------------------------------------------------
plotdata <- as.data.frame(regPerBatch)
plotdata$feature <- rownames(plotdata)

plotdata <- melt(plotdata, variable.name="batch")
plotdata$feature <- factor(plotdata$feature, ordered=TRUE, 
    levels=unique(plotdata$feature))

ggplot(data=plotdata, aes(x=batch, y=feature, fill=value)) + 
    geom_tile() + scale_fill_gradient2()

## ----warning=FALSE, message=FALSE---------------------------------------------
data <- data.frame(data=
    as.vector(SummarizedExperiment::assay(MTBLS79["451.01086", ])), batch=batch,
    class=factor(class, ordered=TRUE))
data$order <- c(1:nrow(data))
data$batch <- as.factor(data$batch)

ggplot(data=data, aes(x=order, y=log(data,10), col=batch, shape=class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color)

## -----------------------------------------------------------------------------

QCdata <- data[data$class == "QC",]

ggplot(data=QCdata, aes(x=order, y=log(data,10), col=batch, shape=class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color, drop=FALSE) +
    scale_shape_manual(values=c(16, 17, 15), drop=FALSE)

## -----------------------------------------------------------------------------
FUN <- function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE) * 100

# RSD% of biological and QC samples within all 6 batches:
out <- c(NA,NA)
names(out) <- c("Biological","QC")
out[1] <-FUN(data$data[-QChits])
out[2] <-FUN(data$data[QChits])
out

## -----------------------------------------------------------------------------
# RSD% per batch:
out <- matrix(ncol=8,nrow=2)
colnames(out) <- unique(batch)
rownames(out) <- c("Biological","QC")
for (i in 1:8) {
    out[1, i] <- FUN(data$data[which(!class=="QC" & batch==i)])
    out[2, i] <- FUN(data$data[which(class=="QC" & batch==i)])
}

out

## -----------------------------------------------------------------------------
qcData <- data$data[class == "QC"]
qc_batch <- batch[class == "QC"]
qc_order <- order[class == "QC"]

qcData


## -----------------------------------------------------------------------------
nbatch <- unique(qc_batch)

nb <- 6

# Sample injection order
x <- qc_order[qc_batch==nbatch[nb]]

# Measured peak intensity or area
y <- qcData[qc_batch==nbatch[nb]]
y

## -----------------------------------------------------------------------------
NAhits <- which(is.na(y))
if (length(NAhits)>0) {
    x <- x[-c(NAhits)]
    y <- y[-c(NAhits)]
    rbind(x,y)
}

## -----------------------------------------------------------------------------
y <- log((y + sqrt(y^2)) / 2)
y

## -----------------------------------------------------------------------------
sp.obj <- smooth.spline(x, y, cv=TRUE) 
sp.obj

out <- rbind(y,sp.obj$y)
row.names(out) <- c("measured","fitted")
out

## -----------------------------------------------------------------------------
valuePredict=predict(sp.obj, order[batch==nb])

plotchr <- as.numeric(data$class)

# reverse the log transformation to convert the predictions back to the
# original scale
valuePredict$y <- exp(valuePredict$y)

plotdata <- data.frame(measured=data$data[batch==nb], fitted=valuePredict$y,
    Class=class[batch==nb], order=order[batch==nb])
plotdata2 <- melt(plotdata, id.vars=c("Class","order"), value.name="intensity",
    variable.name="data")

ggplot(data=plotdata2, aes(x=order, y=log(intensity,10), color=data,
    shape=Class)) + geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    scale_shape_manual(values=c(16, 17, 15), drop=FALSE)

## ----warning=FALSE------------------------------------------------------------
fitmedian <- median(plotdata$measured, na.rm=TRUE)
plotdata$corrected_subt <- (plotdata$measured - plotdata$fitted) + fitmedian

plotdata2 <- melt(plotdata, id.vars=c("Class","order"), 
    value.name="intensity", variable.name="data")

plotdata_class <- as.character(plotdata2$Class)
plotdata_class[plotdata_class == "S"] <- "Sample"
plotdata_class[plotdata_class == "C"] <- "Sample"
plotdata2$Class <- factor(plotdata_class)

ggplot(data=plotdata2, aes(x=order, y=intensity, color=data, shape=Class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) + 
    scale_color_manual(values=manual_color) +
    facet_grid(Class ~ .) +
    scale_shape_manual(values=c(17, 16), drop=FALSE)

## ----warning=FALSE------------------------------------------------------------
plotdata$corrected_div <- plotdata$measured/(plotdata$fitted/fitmedian)

plotdata3 <- plotdata[,c("Class", "order", "corrected_subt", "corrected_div")]

plotdata3 <- melt(plotdata3, id.vars=c("Class","order"), 
    value.name="intensity", variable.name="data")

plotdata_class <- as.character(plotdata3$Class)
plotdata_class[plotdata_class=="S"] <- "Sample"
plotdata_class[plotdata_class=="C"] <- "Sample"
plotdata3$Class <- factor(plotdata_class)

ggplot(data=plotdata3, aes(x=order, y=intensity, color=data, shape=Class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    geom_smooth(se=FALSE) + facet_grid(Class ~ .)


## ----warning=FALSE------------------------------------------------------------

outl <- rep(NA, nrow(data))

for (nb in 1:length(nbatch)){
    # assigning sample injection order for a batch to 'x', and corresponding 
    # intensities to 'y'
    x <- qc_order[qc_batch == nbatch[nb]]
    y <- qcData[qc_batch == nbatch[nb]]

    # remove measurements with missing values
    NAhits <- which(is.na(y))
    if (length(NAhits) > 0) {
        x <- x[-c(NAhits)]
        y <- y[-c(NAhits)]
    }

    # require at least 4 data points for QC fit
    if (length(y) >= 4) {
        range <- c(batch == nbatch[nb])
        # Order is a vector of sample indices for the current batch
        outl[range] <- pmp:::splineSmoother(x=x, y=y, newX=order[range], 
        log=TRUE, a=1, spar=0)

        # If less than 5 data points are present, return empty values   
    } else {
        range <- c(batch == nbatch[nb])
        outl[range] <- rep(NA, nrow(data))[range]
    }
}

plotdata <- data.frame(measured=data$data, fitted=outl, Class=class, 
    batch=batch, order=c(1:nrow(data)))
plotdata2 <- melt(plotdata, id.vars=c("batch","Class","order"),
    value.name="intensity", variable.name="data")

ggplot(data=plotdata2, aes(x=order, y=log(intensity,10), 
    color=data, shape=Class)) + geom_point(alpha=0.5, size=2) +
    theme(panel.background=element_blank()) + 
    scale_color_manual(values=manual_color)


## ----warning=FALSE------------------------------------------------------------

# median intensity value is used to adjust batch effect

mpa <- rep(NA, nrow(data))

for (bch in 1:8) {
    mpa[batch==bch] <- median(data$data[batch==bch], na.rm=TRUE)
}


QC_fit <- outl/mpa

# and correct actual data
res <- data$data/QC_fit

# correct data using subtratcion
res2 <- (data$data -outl) +mpa

plotdata <- data.frame(measured=data$data, corrected_subt=res2, 
    corrected_div=res, Class=class, batch=batch, order=c(1:nrow(data)))
plotdata2 <- melt(plotdata, id.vars=c("batch","Class","order"), 
    value.name="intensity", variable.name="data")

ggplot(data=plotdata2, aes(x=order, y=log(intensity,10), 
    color=data, shape=Class)) + geom_point(alpha=0.2, size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    geom_smooth(se=FALSE) +
    facet_grid(Class ~ .)

## ----warning=FALSE------------------------------------------------------------
mpa <- rep(NA, nrow(data))

for (bch in 1:8) {
    mpa[batch == bch] <- median(res2[batch == bch], na.rm=TRUE)
}

grandMedian <- median(res2, na.rm=TRUE)

mpa <- mpa - grandMedian

plotdata$corrected_subt <- plotdata$corrected_subt - mpa

mpa <- rep(NA, nrow(data))

for (bch in 1:8) {
    mpa[batch == bch] <- median(res[batch == bch], na.rm=TRUE)
}

grandMedian <- median(res, na.rm=TRUE)

mpa <- mpa - grandMedian

plotdata$corrected_div <- plotdata$corrected_div - mpa

plotdata2 <- melt(plotdata, id.vars=c("batch","Class","order"),
    value.name="intensity", variable.name="data")

ggplot(data=plotdata2, aes(x=order, y=log(intensity,10),
    color=data, shape=Class)) + geom_point(alpha=0.2, size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    geom_smooth(se=FALSE) +
    facet_grid(Class ~ .)

## ----warning=FALSE------------------------------------------------------------
FUN <- function(x) sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE) * 100

# RSD% of biological and QC samples within all 6 batches:
out <- matrix(nrow=2, ncol=2)
colnames(out) <- c("Biological","QC")
rownames(out) <- c("measured", "corrected")
out[1,1] <-FUN(data$data[-QChits])
out[1,2] <-FUN(data$data[QChits])
out[2,1] <-FUN(res[-QChits])
out[2,2] <-FUN(res[QChits])

round(out, 2)

# RSD% per batch:
out <- matrix(ncol=8,nrow=4)
colnames(out) <- unique(batch)
rownames(out) <- c("Biological","QC","Corrected biological","Corrected QC")
for(i in 1:8) {
    out[1, i] <- FUN(data$data[which(!class=="QC" & batch==i)])
    out[2, i] <- FUN(data$data[which(class=="QC" & batch==i)])
    out[3, i] <- FUN(res[which(!class=="QC" & batch==i)])
    out[4, i] <- FUN(res[which(class=="QC" & batch==i)])
}

round(out, 2)

## ----message=FALSE, warning=FALSE, include=TRUE-------------------------------
data <- MTBLS79[feature_names,]

class <- MTBLS79$Class
batch <- MTBLS79$Batch
sample_order <- c(1:ncol(data))

corrected_data <- QCRSC(df=data, order=sample_order, batch=batch,
    classes=class, spar=0, minQC=4)

## ----warning=FALSE------------------------------------------------------------
data <- SummarizedExperiment::assay(data)
corrected_data <- SummarizedExperiment::assay(corrected_data)
RSDQC <- matrix(ncol=8, nrow=nrow(data))
RSDsample <- matrix(ncol=8, nrow=nrow(data))
colnames(RSDQC) <- unique(batch)
colnames(RSDsample) <- unique(batch)

RSDQC_corrected <- matrix(ncol=8, nrow=nrow(data))
RSDsample_corrected <- matrix(ncol=8, nrow=nrow(data))
colnames(RSDQC_corrected) <- unique(batch)
colnames(RSDsample_corrected) <- unique(batch)

rownames(RSDQC) <- rownames(data)
rownames(RSDsample) <- rownames(data)
rownames(RSDQC_corrected) <- rownames(data)
rownames(RSDsample_corrected) <- rownames(data)

# for each feature
for (i in 1:nrow(data)) {
    # for each batch
    for (nb in 1:8) {
        # RSD% of QCs in this batch
        RSDQC[i, nb] <- FUN(data[i, which(class == "QC" & batch == nb)])
        # RSD% of samples in this batch
        RSDsample[i, nb] <- FUN(data[i, which(!class == "QC" & batch == nb)])
        # RSD% of QCs in this batch after correction
        RSDQC_corrected[i, nb] <- FUN(corrected_data[i, which(class == "QC"
            & batch == nb)])
        # RSD% of samples in this batch after correction
        RSDsample_corrected[i, nb] <- FUN(corrected_data[i, which(!class == "QC"
            & batch == nb)]) 
    }
}

# prepare results for plotting
plotdataQC <- melt(as.data.frame(RSDQC), variable.name="batch",
    value.name="RSD")
plotdataQC$Class <- "QC"

plotdataBio <- melt(as.data.frame(RSDsample), variable.name="batch",
    value.name="RSD")
plotdataBio$Class <- "Sample"

plotdataQC_corrected <- melt(as.data.frame(RSDQC_corrected),
    variable.name="batch", value.name="RSD")
plotdataQC_corrected$Class <- "QC_corr"

plotdataBio_corrected <- melt(as.data.frame(RSDsample_corrected),
    variable.name="batch", value.name="RSD")
plotdataBio_corrected$Class <- "Sample_corr"

plotdata <- rbind(plotdataQC, plotdataQC_corrected)

plotdata$Class <- as.factor(plotdata$Class)

# plot
ggplot(data=plotdata, aes(x=Class, y=RSD, fill=Class)) + geom_boxplot() +
    facet_wrap(~ batch, ncol=3) +
    ylab("RSD%") +
    xlab("") +
    scale_x_discrete(labels=NULL) +
    theme(panel.background=element_blank(), axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
    scale_y_continuous(limits=c(0, 50))

plotdata <- rbind(plotdataBio, plotdataBio_corrected)

plotdata$Class <- as.factor(plotdata$Class)

# plot
ggplot(data=plotdata, aes(x=Class, y=RSD, fill=Class)) + geom_boxplot() +
    facet_wrap(~ batch, ncol=3) +
    ylab("RSD%") +
    xlab("") +
    theme(panel.background=element_blank(), axis.text.x=element_blank(),
        axis.ticks.x=element_blank())


## ----fig.width=6, fig.height=8------------------------------------------------
# PQN used to normalise data
# KNN for missing value imputation
# glog scaling method 
# A more detailed overview is detailed in
# Di Guida et al, Metabolomics, 12:93, 2016
# https://dx.doi.org/10.1007/s11306-016-1030-9

pca_data <- pqn_normalisation(data, classes=class, qc_label="QC")
pca_data <- mv_imputation(pca_data, method="KNN", k=5, rowmax=0.5,
    colmax=0.5, maxp=NULL, check_df=FALSE)
pca_data <- glog_transformation(pca_data, classes=class, qc_label="QC")

pca_corrected_data <- pqn_normalisation(corrected_data, classes=class,
    qc_label="QC")
pca_corrected_data <- mv_imputation(pca_corrected_data, method="KNN", k=5,
    rowmax=0.5, colmax=0.5, maxp=NULL, check_df=FALSE)
pca_corrected_data <- glog_transformation(pca_corrected_data, 
    classes=class, qc_label="QC")

pca_data <- prcomp(t(pca_data), center=TRUE, scale=FALSE)
pca_corrected_data <- prcomp(t(pca_corrected_data), center=TRUE, scale=FALSE)

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

