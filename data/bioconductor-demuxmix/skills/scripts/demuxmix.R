# Code example from 'demuxmix' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----installation.install, eval = FALSE---------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("demuxmix")

## ----installation.loadlib, eval = FALSE---------------------------------------
# library(demuxmix)

## ----quickstartSimulate-------------------------------------------------------
library(demuxmix)

set.seed(2642)
class <- rbind(
    c(rep(TRUE,  220), rep(FALSE, 200)),
    c(rep(FALSE, 200), rep(TRUE,  220))
)
simdata <- dmmSimulateHto(class)
hto <- simdata$hto
dim(hto)
rna <- simdata$rna
length(rna) == ncol(hto)

## ----quickstartDdemuxmix------------------------------------------------------
dmm <- demuxmix(hto, rna = rna)
summary(dmm)
classes <- dmmClassify(dmm)
table(classes$HTO)

## ----quickstartHistogram, fig.cap = "Density histograms overlayed with mixture probability mass function. The density histograms show the distribution of the HTO counts for the first HTO (upper figure) and the 2nd HTO (lower figure). The negative component of the mixture model representing non-tagged cells is shown in blue, and the positive component is in red."----
plotDmmHistogram(dmm)

## ----simulate, fig.height = 6, fig.cap = "Characteristics of the simulated dataset. A) The histogram of the HTO counts from the first HTO (HTO_1) shows a clear separation between positive and negative droplets. B) The histogram of the second HTO (HTO_2) looks similar, although the positive droplets have a smaller mean count and a larger dispersion. C) The histogram of the third HTO reveals a more extensive overlap between the distributions of the positive and negative droplets. D) The scatter plot shows a positive correlation between the number of detected genes and HTO counts in the simulated data."----
library(demuxmix)
library(ggplot2)
library(cowplot)

set.seed(5636)
class <- rbind(
    c(rep( TRUE, 200), rep(FALSE, 200), rep(FALSE, 200), rep( TRUE, 50)),
    c(rep(FALSE, 200), rep( TRUE, 200), rep(FALSE, 200), rep( TRUE, 50)),
    c(rep(FALSE, 200), rep(FALSE, 200), rep( TRUE, 200), rep(FALSE, 50))
)
simdata <- dmmSimulateHto(
    class = class,
    mu = c(600, 400, 200),
    theta = c(25, 15, 25),
    muAmbient = c(30, 30, 60),
    thetaAmbient = c(20, 10, 5),
    muRna = 3000,
    thetaRna = 30
)
hto <- simdata$hto
rna <- simdata$rna

htoDf <- data.frame(t(hto), HTO = colSums(hto), NumGenes = rna)
pa <- ggplot(htoDf, aes(x = HTO_1)) +
    geom_histogram(bins = 25)
pb <- ggplot(htoDf, aes(x = HTO_2)) +
    geom_histogram(bins = 25)
pc <- ggplot(htoDf, aes(x = HTO_3)) +
    geom_histogram(bins = 25)
pd <- ggplot(htoDf, aes(x = NumGenes, y = HTO)) +
    geom_point()
plot_grid(pa, pb, pc, pd, labels = c("A", "B", "C", "D"))

## ----stoeckius, eval = FALSE--------------------------------------------------
# library(demuxmix)
# library(ggplot2)
# library(cowplot)
# library(scRNAseq)
# library(DropletUtils)
# 
# set.seed(8514)
# htoExp <- StoeckiusHashingData(type = "mixed")
# eDrops <- emptyDrops(counts(htoExp))
# htoExp <- htoExp[, which(eDrops$FDR <= 0.001)]
# rna <- colSums(counts(htoExp) > 0)
# hto <- counts(altExp(htoExp))
# dim(hto)
# 
# htoDf <- data.frame(t(hto[c("HEK_A", "KG1_B", "KG1_C"), ]),
#     HTO = colSums(hto), NumGenes = rna
# )
# pa <- ggplot(htoDf, aes(x = HEK_A)) +
#     geom_histogram(binwidth = 10) +
#     coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
# pb <- ggplot(htoDf, aes(x = KG1_B)) +
#     geom_histogram(binwidth = 10) +
#     coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
# pc <- ggplot(htoDf, aes(x = KG1_C)) +
#     geom_histogram(binwidth = 10) +
#     coord_cartesian(xlim = c(0, 600), ylim = c(0, 500))
# pd <- ggplot(htoDf, aes(x = NumGenes, y = HTO)) +
#     geom_point(size = 0.1) +
#     coord_cartesian(ylim = c(0, 750))
# plot_grid(pa, pb, pc, pd, labels = c("A", "B", "C", "D"))

## ----demuxmix-----------------------------------------------------------------
dmm <- demuxmix(hto, rna = rna)
dmm
classLabels <- dmmClassify(dmm)
head(classLabels)

summary(dmm)

# Compare demultiplexing results to ground truth from simulation
table(classLabels$HTO, simdata$groundTruth)

## ----demuxmixNaive------------------------------------------------------------
dmmNaive <- demuxmix(hto, model = "naive")
dmmNaive
classLabelsNaive <- dmmClassify(dmmNaive)
summary(dmmNaive)

# Compare results of the naive model to ground truth from simulation
table(classLabelsNaive$HTO, simdata$groundTruth)

## ----reclassify---------------------------------------------------------------
pAcpt(dmm)
pAcpt(dmm) <- 0.95
summary(dmm)

pAcpt(dmm) <- 0
summary(dmm)

## ----qualityHistogram, fig.height = 8, fig.cap = "Density histograms overlayed with mixture probability mass functions. The density histogram is shown for each HTO in the simulated dataset. The negative component of the respective mixture model representing non-tagged cells (blue) and the positive component (red) are plotted on top of the histogram. The black curve is the mixture pmf."----
plotDmmHistogram(dmm)
dmmOverlap(dmm)

## ----qualityZoomHistogram, eval = FALSE---------------------------------------
# pa <- plotDmmHistogram(dmm, hto=1)
# pb <- plotDmmHistogram(dmm, hto=1) +
#     coord_cartesian(xlim = c(0, 200), ylim = c(0, 0.01))
# plot_grid(pa, pb, labels = c("A", "B"))

## ----qualityPosteriorP, fig.height = 8, fig.cap = "Histograms of posterior probabilities. Each histogram shows the distribution of the posterior probabilities that a droplet contains a tagged cell. Posterior probabilities were obtained from the mixture model fitted to the respective HTO data."----
plotDmmPosteriorP(dmm)

## ----qualityScatterplot, fig.height = 8, fig.cap = "Decision boundary. The scatter plots show the relation between the number of detected genes and HTO counts for each of the three HTOs. The color indicates the posterior probability. The black dashed line depicts the decision boundary where the posterior probability is 0.5."----
plotDmmScatter(dmm)

## ----hashedDrops, fig.height = 6, fig.cap = "Comparison between demuxmix and hashedDrops. The heatmap depicts the classification results for the simulated dataset obtained from demuxmix on the x-axis and hashedDrops on the y-axis."----
suppressPackageStartupMessages(library(DropletUtils))
suppressPackageStartupMessages(library(reshape2))
hd <- hashedDrops(hto)
hdrops <- rownames(hto)[hd$Best]
hdrops[!hd$Confident] <- "uncertain"
hdrops[hd$Doublet] <- "multiplet"

dmux <- classLabels$HTO
dmux[classLabels$Type == "multiplet"] <- "multiplet"

comp <- melt(as.matrix(table(dmux, hdrops)))
colnames(comp) <- c("demuxmix", "hashedDrops", "Count")
comp$color <- ifelse(comp$Count > 100, "black", "white")
ggplot(comp, aes(x = demuxmix, y = hashedDrops, fill = Count)) +
    geom_tile() +
    scale_fill_viridis_c() +
    geom_text(aes(label = Count), col = comp$color, size = 5)

## ----csfLoad------------------------------------------------------------------
data(csf)
head(csf)

csf <- csf[csf$NumGenes >= 200, ]
nrow(csf)
hto <- t(matrix(csf$HTO, dimnames = list(rownames(csf), "HTO")))

## ----csfDemuxmix--------------------------------------------------------------
dmm <- demuxmix(hto, rna = csf$NumGenes)
dmm

summary(dmm)

dmmOverlap(dmm)

## ----csfPlots, fig.height = 7, fig.cap = "Demultiplexing a pool of labeled PBMCs and non-labeled CSF cells. A) The density histogram overlaid with the mixture pmf shows a good separation between the positive red component (PMBCs) and the negative blue component (CSF cells). B) The scatter plot shows the number of HTO reads (x-axis) versus the number of detected genes (y-axis) on the logarithmic scale. The color indicates the posterior probability of the droplet containing a tagged cell."----
histo <- plotDmmHistogram(dmm)
scatter <- plotDmmScatter(dmm) + coord_cartesian(xlim = c(2, 4))
plot_grid(histo, scatter, labels = c("A", "B"), nrow = 2)

## ----csfBenchmark-------------------------------------------------------------
class <- dmmClassify(dmm)
highConf <- csf$freemuxlet %in% c("0,0", "1,1") &
    exp(csf$freemuxlet.prob) >= 0.99
table(class$HTO[highConf], csf$freemuxlet[highConf])

# Sensitivity "P(class=PBMC | PBMC)"
sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] == "HTO") /
    sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] != "uncertain")

# Specificity "P(class=CSF | CSF)"
sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] == "negative") /
    sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] != "uncertain")

## ----csfBenchmarkNaive--------------------------------------------------------
dmmNaive <- demuxmix(hto, model = "naive")
class <- dmmClassify(dmmNaive)
table(class$HTO[highConf], csf$freemuxlet[highConf])

# Sensitivity "P(class=PBMC | PBMC)"
sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] == "HTO") /
    sum(csf$freemuxlet[highConf] == "0,0" & class$HTO[highConf] != "uncertain")

# Specificity "P(class=CSF | CSF)"
sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] == "negative") /
    sum(csf$freemuxlet[highConf] == "1,1" & class$HTO[highConf] != "uncertain")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

