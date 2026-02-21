# Code example from 'genPaperFigures' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----setup, include=FALSE--------------------------------------------------
library(knitr)
opts_chunk$set(fig.path="figPaper/")
Sys.setlocale("LC_COLLATE", "C")

## ----eval=TRUE, include=FALSE----------------------------------------------
library(furrowSeg)

## ----message=FALSE---------------------------------------------------------
data("opto")
library(dplyr)
library(ggplot2)

## ----identifyFurrowPosition, fig.show="hold", out.width="0.5\\linewidth", fig.align="center", fig.pos="H", fig.cap="Average cell areas are plotted as a function of position along the d-v axis of the embryo for a time point where the embryo was observed to be furrowing. The d-v position of minimum area, which we defined as the furrowing position, was identified from a smoothing line fitted to the data."----
tabWT <- filter(opto, condition == "WT")
myCex <- 1.4
tabWT[tabWT$sample == "Global Activation/1_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda", "tstar"] <- 150
tabWT[tabWT$sample == "Global Activation/2_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda", "tstar"] <- 200
tabWT[tabWT$sample == "Global Activation/3_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda", "tstar"] <- 220
tabWT[tabWT$sample == "Global Activation/4_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda", "tstar"] <- 220
tabWT[tabWT$sample == "Global Activation/5_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda", "tstar"] <- 110

plotSamples <- "Global Activation/4_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
fnPos <- function(x, nbinsExclude=150, myCex=1.4, plotSamples) {
    doPlot <- x$sample[1] %in% plotSamples
    pos <- identifyFurrowPosition(x, nbinsExclude=nbinsExclude, h=100,
        plot=doPlot, myCex=myCex, px=x$px[1])
    return(data.frame(furrowPos=pos))
}
dvFurrowPos <- tabWT %>%
    group_by(sample) %>%
    filter(t == tstar) %>%
    do(fnPos(., plotSamples=""))
for (i in seq_along(dvFurrowPos$sample))
    tabWT[tabWT$sample %in% dvFurrowPos$sample[i], "furrowPos"] <-
        dvFurrowPos$furrowPos[i]
print(dvFurrowPos)

## ----furrowingBox, fig.show="hold", out.width="0.5\\linewidth", fig.align="center", fig.pos="H"----
L <- function(x, px) round(microns2px(x, px))
fnBox <- function(x, w=512, Lx=30, Ly=10) {
    Lx <- L(Lx, px=x$px[1])
    Ly <- L(Ly, px=x$px[1])
    box <- constructBox(x$furrowPos[1], Lx=Lx, Ly=Ly, w=w)
    return(data.frame(t(box)))
}
boxes <- tabWT %>% group_by(sample) %>% do(fnBox(.))

fnIsolate <- function(x, boxes) {
    box <- unlist(filter(boxes, sample == x$sample[1])[2:5])
    x <- isolateBoxCells(x, box)
    return(x)
}
tabWTs <- tabWT %>% group_by(sample) %>% do(fnIsolate(., boxes=boxes))

## ----identifyTimeMinArea, fig.show="hold", out.width="0.5\\linewidth", fig.align="center"----
fnMinArea <- function(x, plot=FALSE) {
    px <- x$px[1]
    res <- identifyTimeMinArea(x=x, px=px, plot=plot)
    return(data.frame(t=res["tindex"]))
}
tMinArea <- tabWTs %>% group_by(sample) %>% do(fnMinArea(.))
for (i in seq_along(tMinArea$sample))
    tabWTs[tabWTs$sample == tMinArea$sample[i], "tstar"] <- tMinArea$t[i]
tabWTs <- filter(tabWTs, t <= tstar)

## ----plotWTdynamics, fig.show="hold", out.width="0.5\\linewidth", fig.align="center", fig.cap="Fig 2J: Cell area and a-p anisotropy are plotted over time for cells within an area of 30 microns x 10 microns along the furrowing line for one control sample. Solid and dashed lines indicate the median over cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile range."----
plotSample <- "Global Activation/4_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
tabSample <- filter(tabWTs, sample == plotSample)
tabSample$t <- tabSample$t*tabSample$dt
plotFeatureEvolution(tabSample, dt=1/60, tMax=Inf, myTitle="wild-type",
    px=tabSample$px[1], cex=2, cex.axis=1.5, line=3.3,
    mar=c(5.1, 5.6, 4.1, 4.6))

## ----summarizeWT-----------------------------------------------------------
summaryWT <- tabWTs %>%
    group_by(sample) %>%
    filter(t == tstar) %>%
    summarize(APanisotropy=median(e.x, na.rm=TRUE),
        APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),
        APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE),
        area=median(x.0.s.area, na.rm=TRUE),
        area25=quantile(x.0.s.area, probs=0.25, na.rm=TRUE),
        area75=quantile(x.0.s.area, probs=0.75, na.rm=TRUE))

summaryWTapicalSlice <- tabWTs  %>%
    group_by(sample) %>%
    filter(t == tstar, z == 1) %>%
    summarize(APanisotropy=median(e.x, na.rm=TRUE),
        APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),
        APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE),
        area=median(x.0.s.area, na.rm=TRUE),
        area25=quantile(x.0.s.area, probs=0.25, na.rm=TRUE),
        area75=quantile(x.0.s.area, probs=0.75, na.rm=TRUE))

## ----globalActivationDynamics, fig.show="hold", out.width="0.5\\linewidth", fig.align="center", fig.cap="Fig 2K: Cell area and a-p anisotropy are plotted over time for all cells in a globally light-activated sample. Solid and dashed lines indicate the median over cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile range."----
tabGlobal <- filter(opto, condition == "Global")
tabGlobal$t <- tabGlobal$t*tabGlobal$dt
plotSample <- "Global Activation/Global Activation/Image31.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
tabSample <- filter(tabGlobal, sample == plotSample)
plotFeatureEvolution(tabSample, dt=1/60, tMax=30, myTitle="globally activated",
    px=tabSample$px[1], cex=2, cex.axis=1.5, line=3.3,
    mar=c(5.1, 5.6, 4.1, 4.6))

## ----globalComparisonFilteringCells----------------------------------------
sampleCenter <- tabGlobal %>% group_by(sample) %>% summarize(pos=mean(x.0.m.cy))
for (i in seq_len(nrow(sampleCenter)))
    tabGlobal[tabGlobal$sample == sampleCenter$sample[i], "furrowPos"] <-
        sampleCenter$pos[i]
subsetTimes <- function(x, tstar) {
    times <- unique(x$t)
    ind <- which.min(abs(tstar-times/60))
    xs <- filter(x, t == times[ind])
    return(xs)
}
compareTimes <- c(10, 20, 30)
tabGlobals <- lapply(compareTimes, function(tstar) {
    y <- tabGlobal %>% group_by(sample) %>% do(subsetTimes(., tstar=tstar))
    y$tstar <- tstar
    return(y)
})
tabGlobals <- bind_rows(tabGlobals)
tabGlobals$condition <- paste0("Global", tabGlobals$tstar)
compareGlobal <- tabGlobals %>% group_by(condition, sample) %>%
    summarize(APanisotropy=median(e.x, na.rm=TRUE),
        APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),
        APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE),
        area=median(x.0.s.area, na.rm=TRUE),
        area25=quantile(x.0.s.area, probs=0.25, na.rm=TRUE),
        area75=quantile(x.0.s.area, probs=0.75, na.rm=TRUE))
summaryWT$condition <- "control"
compareGlobal <- bind_rows(compareGlobal, summaryWT)

## ----GlobalComparisonTest--------------------------------------------------
wtArea <- compareGlobal %>% filter(condition == "control") %>%
    summarize(meanArea=mean(area))
wtArea <- wtArea$meanArea
compareGlobal$normArea <- log2(compareGlobal$area/wtArea)
compareGlobal$normArea25 <- log2(compareGlobal$area25/wtArea)
compareGlobal$normArea75 <- log2(compareGlobal$area75/wtArea)
ttAPanisotropy <- pairwise.t.test(compareGlobal$APanisotropy,
    compareGlobal$condition, p.adjust.method="bonferroni")
print(ttAPanisotropy)
ttArea <- pairwise.t.test(compareGlobal$normArea, compareGlobal$condition,
    p.adjust.method="bonferroni")
print(ttArea)

## ----GlobalComparisonFigures, fig.show="hold", out.width="0.5\\linewidth", dpi=300, fig.pos="H", fig.cap="Fig 2L-M: The median cell area and a-p anisotropy features at the time point of tissue invagination in the control samples were compared to three different time points in the photo-activated samples. The statistical testing was performed using pairwise two-sample t-tests. As can be seen from the figure, standard deviations were comparable between groups. To attain a higher precision we therefore used a pooled standard deviation for all of the tests. p-values were corrected for multiple testing using the method of Bonferroni. We performed the area testing on the log-transformed values but included the absolute areas on the right-hand y-axis as a reference. For both cell area and a-p anisotropy, the control samples were significantly different from the photo-activated samples, while the the latter showed no significant changes over time. The crosses show group median (horizontal line) and interquartile range (vertical line)."----
mySignIf <- function(pv) symnum(pv, cutpoints=c(0, 0.001, 0.01, 0.05, 1),
    symbols=c("***", "**", "*", "n.s."))
myCol <- c("red", rep("blue", 3))
compareGlobal$condition <- factor(compareGlobal$condition,
    levels=c("control", "Global10", "Global20", "Global30"))
myNames <- levels(compareGlobal$condition)
myStarsAPanisotropy <- apply(ttAPanisotropy$p.value, c(1, 2), mySignIf)
info <- sessionInfo()
par(mar=c(7.1, 6.1, 3.1, 5.6))
stripchart(APanisotropy ~ condition, data=compareGlobal, vertical=TRUE, pch=20,
    xlab="", ylab="a-p anisotropy", cex.lab=2, ylim=c(0, 1.1), col=myCol,
    axes=FALSE, method="jitter", jitter=0.05, cex=2)
axis(side=1, at=1:4, labels=FALSE)
text(x=1, par("usr")[3]-0.17, labels="control", srt=45, xpd=TRUE, cex=2)
text(x=2:4, par("usr")[3]-0.12, labels=rep("light", 3), srt=45, xpd=TRUE, cex=2)
text(x=2:4+0.05, par("usr")[3]-0.2, labels=c("+10min", "+20min", "+30min"),
     srt=45, pos=NULL, xpd=TRUE, cex=2)
axis(side=2, cex.axis=1.5, lwd=1.5)
drawBar <- function(x0, x1, y, star, offset=0.1, cex=2) {
    segments(x0=x0, y0=y, x1=x1, y1=y)
    text(x=mean(c(x0, x1)), y=y+offset, labels=star, cex=cex)
}
drawBar(1, 2, y=0.85, star=myStarsAPanisotropy["control", "Global10"],
    offset=0.05)
drawBar(1, 3, y=0.95, star=myStarsAPanisotropy["control", "Global20"],
    offset=0.05)
drawBar(1, 4, y=1.05, star=myStarsAPanisotropy["control", "Global30"],
    offset=0.05)
drawBar(2, 3, y=0.23, star=myStarsAPanisotropy["Global20", "Global10"],
    offset=-0.05)
drawBar(2, 4, y=0.65, star=myStarsAPanisotropy["Global30", "Global10"],
    offset=0.05)
drawBar(3, 4, y=0.13, star=myStarsAPanisotropy["Global30", "Global20"],
    offset=-0.05)
conditionSummary <- compareGlobal %>% group_by(condition) %>%
    summarize(median=median(APanisotropy),
        q25=quantile(APanisotropy, probs=0.25),
        q75=quantile(APanisotropy, probs=0.75))
conditionSummary <- as.data.frame(conditionSummary)
conditionSummary <- conditionSummary[order(conditionSummary$condition), ]
for (i in seq_len(nrow(conditionSummary))) {
    segments(x0=i-0.2, x1=i+0.2, y0=conditionSummary[i, "median"], lwd=2, lty=1)
    segments(x0=i, y0=conditionSummary[i, "q25"], y1=conditionSummary[i, "q75"],
        lwd=2, lty=1)
}
myStarsArea <- apply(ttArea$p.value, c(1, 2), mySignIf)
par(mar=c(7.1, 6.1, 3.1, 5.6))
stripchart(normArea ~ condition, data=compareGlobal, vertical=TRUE, pch=20,
    xlab="", ylab=expression(paste("log"[2], "(area / <area>"[ctrl], ")")),
    cex.lab=2, group.names=myNames, ylim=c(-0.5, 2.0), col=myCol,
    axes=FALSE, method="jitter", jitter=0.05, cex=2)
axis(side=1, at=1:4, labels=FALSE)
text(x=1, par("usr")[3]-0.47, labels="control", srt=45, xpd=TRUE, cex=2)
text(x=2:4, par("usr")[3]-0.32, labels=rep("light", 3), srt=45, xpd=TRUE, cex=2)
text(x=2:4+0.05, par("usr")[3]-0.53, labels=c("+10min", "+20min", "+30min"),
     srt=45, pos=NULL, xpd=TRUE, cex=2)
axis(side=2, cex.axis=1.5, lwd=1.5)
drawBar(1, 2, y=1.3, star=myStarsArea["control", "Global10"], offset=0.12)
drawBar(1, 3, y=1.6, star=myStarsArea["control", "Global20"], offset=0.12)
drawBar(1, 4, y=1.9, star=myStarsArea["control", "Global30"], offset=0.12)
drawBar(2, 3, y=0.40, star=myStarsArea["Global20", "Global10"], offset=-0.12)
drawBar(2, 4, y=0.20, star=myStarsArea["Global30", "Global10"], offset=-0.12)
drawBar(3, 4, y=0.60, star=myStarsArea["Global30", "Global20"], offset=-0.12)
mapMicronsSq <- function(x) px2area(wtArea*2**x, px=0.293)
rangeNormAreaSeq <- seq(-0.5, 2.0, by=0.5)
newAxisLabels <- round(mapMicronsSq(rangeNormAreaSeq), digits=1)
axis(4, at=rangeNormAreaSeq, labels=newAxisLabels, cex.axis=1.5, lwd=1.5)
abline(h=0, lty=2, col="blue")
mtext(expression(paste("area [", mu, m^2, "]")), side=4, cex=2, line=4)
conditionSummary <- compareGlobal %>% group_by(condition) %>%
    summarize(median=median(normArea), q25=quantile(normArea, probs=0.25),
        q75=quantile(normArea, probs=0.75))
conditionSummary <- as.data.frame(conditionSummary)
conditionSummary <- conditionSummary[order(conditionSummary$condition), ]
for (i in seq_len(nrow(conditionSummary))) {
    segments(x0=i-0.2, x1=i+0.2, y0=conditionSummary[i, "median"], lwd=2, lty=1)
    segments(x0=i, y0=conditionSummary[i, "q25"], y1=conditionSummary[i, "q75"],
        lwd=2, lty=1)
}

## ----2pTitration, fig.show="hold", out.width="0.35\\linewidth", fig.pos="H", fig.cap="Fig 5M-O: Cell area and a-p anisotropy are plotted over time for locally light-activated cells in individual samples. Different two-photon laser powers were used to monitor changes in cell behaviour resulting from varying levels of activation. Solid and dashed lines indicate the median over cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile range."----
titrationCond <- paste0("2pTitration", c("2.5", "5", "8"), "percent")
tab2pTitration <- filter(opto, condition %in% titrationCond)
tab2pTitration <- filter(tab2pTitration, !(sample == "New data/2p titration/2.5%/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda" & t > 35))
tab2pTitration <- filter(tab2pTitration, !(sample == "New data/2p titration/2.5%/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda" & t > 30))
tab2pTitration <- filter(tab2pTitration, !(sample == "New data/2p titration/2.5%/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda" & t > 30))
tab2pTitration$t <- tab2pTitration$t*tab2pTitration$dt
plotSamples <- c(
    "700 uW"="New data/2p titration/2.5%/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda",
    "1.5 mW"="New data/2p titration/5%/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda",
    "3 mW"="New data/2p titration/8%/4_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
)
for (i in seq_along(plotSamples)) {
    s <- plotSamples[i]
    tab2pTitrations <- filter(tab2pTitration, sample == s)
    px <- tab2pTitrations$px[1]
    plotFeatureEvolution(tab2pTitrations, dt=1/60, tMax=Inf, myTitle=names(s),
        px=px, cex=2, cex.axis=1.5, line=3.3, mar=c(5.1, 5.6, 4.1, 4.6))
}

## ----SktlZipDark_vs_WT, fig.show="hold", out.width="0.5\\linewidth", fig.pos="H", fig.align="center", fig.cap="Fig 3A: The median a-p anisotropy of constricting cells in different condition are compared to the a-p anisotropy of control cells at the time point of furrowing. The statistical testing was performed using pairwise two-sample t-tests. As can be seen from the figure, standard deviations were comparable between groups. To attain a higher precision we therefore used a pooled standard deviation for all of the tests. p-values were corrected for multiple testing using the method of Bonferroni. No significant differences were detected between the groups. The crosses show group median (horizontal line) and interquartile range (vertical line)."----
tab <- filter(opto, condition %in% c("Dark", "Sktl", "Zip"))
summaryConds <- tab %>% group_by(condition, sample) %>%
    summarize(APanisotropy=median(e.x, na.rm=TRUE),
        APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),
        APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE))
summaryWTapicalSlice$condition <- "WT"
summaryConds <- bind_rows(summaryConds, summaryWTapicalSlice)
myCol <- c(rep("blue", 3), "red")
summaryConds$condition <- factor(summaryConds$condition,
    levels=c("Dark", "Sktl", "Zip", "WT"))
summaryConds$sample <- factor(summaryConds$sample)
sampleOrdering <- levels(summaryConds$sample)[c(6:15, 1:5)]
summaryConds$sample <- factor(summaryConds$sample, levels=sampleOrdering)
anisotropyLab <- "a-p anisotropy"
par(mar=c(6.1, 6.1, 3.1, 2.1))
stripchart(APanisotropy ~ condition, data=summaryConds, vertical=TRUE, pch=20,
    xlab="", ylab=anisotropyLab, cex.lab=2, axes=FALSE, col=myCol,
    ylim=c(0, 1.1), method="jitter", jitter=0.05, cex=2)
axis(side=1, at=1:4, labels=FALSE, cex.axis=1.5, lwd=1.5)
axis(side=2, cex.axis=1.5, lwd=1.5)
text(x=1:4, par("usr")[3]-0.12, labels=levels(summaryConds$condition), srt=45,
    xpd=TRUE, cex=2)
conditionSummary <- summaryConds %>% group_by(condition) %>%
    summarize(median=median(APanisotropy),
        q25=quantile(APanisotropy, probs=0.25),
        q75=quantile(APanisotropy, probs=0.75))
conditionSummary <- as.data.frame(conditionSummary)
for (i in seq_len(nrow(conditionSummary))) {
    segments(x0=i-0.2, x1=i+0.2, y0=conditionSummary[i, "median"], lwd=2, lty=1)
    segments(x0=i, y0=conditionSummary[i, "q25"], y1=conditionSummary[i, "q75"],
        lwd=2, lty=1)
}
ttConds <- pairwise.t.test(summaryConds$APanisotropy, summaryConds$condition,
    p.adjust.method="bonferroni")
myStarsConds <- apply(ttConds$p.value, c(1, 2), mySignIf)
print(myStarsConds)
drawBar(1, 2, y=0.40, star=myStarsConds["Sktl", "Dark"], offset=-0.05)
drawBar(2, 3, y=0.30, star=myStarsConds["Zip", "Sktl"], offset=-0.05)
drawBar(1, 3, y=0.20, star=myStarsConds["Zip", "Dark"], offset=-0.05)
drawBar(1, 4, y=0.10, star=myStarsConds["WT", "Dark"], offset=-0.05)
drawBar(2, 4, y=0.90, star=myStarsConds["WT", "Sktl"], offset=0.05)
drawBar(3, 4, y=0.80, star=myStarsConds["WT", "Zip"], offset=0.05)

## ----BoxesFar_vs_BoxesClose, fig.show="hold", out.width="0.5\\linewidth", fig.pos="H", fig.align="center", fig.cap="Fig 7G: The median a-p anisotropy of groups of constricting cells were compared between samples where the distance between two boxes of light activation was varied. A two-sample t-test revealed that cells were more elongated along the embryo a-p axis in the experiment where the boxes were placed farther apart. As can be seen from the plot, the two groups showed unequal variances. We therefore used Welch's t-test. The crosses show group median (horizontal line) and interquartile range (vertical line). The magnitude of difference in a-p anisotropy between the two groups was found to be 0.23."----
tabBoxes <- filter(opto, condition %in% c("BoxesFar", "NewBoxesFar",
    "BoxesClose"))
summaryBoxes <- tabBoxes %>% group_by(condition, sample) %>%
    summarize(APanisotropy=median(e.x, na.rm=TRUE),
        APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),
        APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE))
summaryBoxes$condition[summaryBoxes$condition == "NewBoxesFar"] <- "BoxesFar"
summaryBoxes$condition <- droplevels(summaryBoxes$condition)

ttDouble <- t.test(APanisotropy ~ condition, summaryBoxes)
print(ttDouble)
diff(ttDouble$estimate)
par(mar=c(6.1, 6.1, 3.1, 2.1))
stripchart(APanisotropy ~ condition, summaryBoxes, vertical=TRUE, cex.lab=2,
    xlab="", ylab="a-p anisotropy", xlim=c(0.5, 2.5), ylim=c(0, 1), pch=19,
    col=c("blue", "red"), method="jitter", jitter=0.1, axes=FALSE, cex=2)
axis(side=1, at=1:2, labels=FALSE, lwd=1.5)
text(x=1:2, par("usr")[3]-0.06, labels=rep("Boxes", 2), srt=45, pos=1, xpd=TRUE,
    cex=2)
text(x=1:2+0.05, par("usr")[3]-0.13, labels=c("Close", "Far"), srt=45, pos=1,
    xpd=TRUE, cex=2)
axis(2, cex.axis=1.5, lwd=1.5)
drawBar(1, 2, y=0.9, star=mySignIf(ttDouble$p.value), offset=0.1, cex=2)
conditionSummary <- summaryBoxes %>% group_by(condition) %>%
    summarize(median=median(APanisotropy),
        q25=quantile(APanisotropy, probs=0.25),
        q75=quantile(APanisotropy, probs=0.75))
conditionSummary <- as.data.frame(conditionSummary)
for (i in seq_len(nrow(conditionSummary))) {
    segments(x0=i-0.1, x1=i+0.1, y0=conditionSummary[i, "median"], lwd=2, lty=1)
    segments(x0=i, y0=conditionSummary[i, "q25"], y1=conditionSummary[i, "q75"],
        lwd=2, lty=1)
}

## ----700uW, fig.show="hold", out.width="0.35\\linewidth", fig.pos="H", fig.align="center"----
tabPower700uW <- filter(opto, condition == "700uW")
tabPower700uW[tabPower700uW$sample == "New data/700uW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 48
tabPower700uW[tabPower700uW$sample == "New data/700uW/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 23
tabPower700uW[tabPower700uW$sample == "New data/700uW/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 29
plotSamples700uW <- "New data/700uW/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda"
dvFurrowPos <- tabPower700uW %>% group_by(sample) %>% filter(t == tstar) %>%
    do(fnPos(., plotSamples="", nbinsExclude=0))
for (i in seq_along(dvFurrowPos$sample))
    tabPower700uW[tabPower700uW$sample %in% dvFurrowPos$sample[i], "furrowPos"] <- dvFurrowPos$furrowPos[i]
boxes <- tabPower700uW %>% group_by(sample) %>% do(fnBox(., w=724))
tabPower700uWs <- tabPower700uW %>% group_by(sample) %>%
    do(fnIsolate(., boxes=boxes))
tMinArea <- tabPower700uWs %>% group_by(sample) %>% do(fnMinArea(., plot=FALSE))
for (i in seq_along(tMinArea$sample))
    tabPower700uWs[tabPower700uWs$sample == tMinArea$sample[i], "tstar"] <- tMinArea$t[i]
tabPower700uWs <- filter(tabPower700uWs, t <= tstar)

## ----1.5mW, fig.show="hold", out.width="0.25\\linewidth", fig.pos="H"------
plotSamples1.5mW <- "New data/Global_2p/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda"
tabPower1.5mW <- filter(opto, condition == "Global2p")
tabPower1.5mW$condition <- "1.5mW"
tabPower1.5mW[tabPower1.5mW$sample == "New data/Global_2p/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 61
tabPower1.5mW[tabPower1.5mW$sample == "New data/Global_2p/4_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 36
tabPower1.5mW[tabPower1.5mW$sample == "New data/Global_2p/8_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "tstar"] <- 25
dvFurrowPos <- tabPower1.5mW %>% group_by(sample) %>% filter(t == tstar) %>%
    do(fnPos(., plotSamples="", nbinsExclude=0))
for (i in seq_along(dvFurrowPos$sample))
    tabPower1.5mW[tabPower1.5mW$sample %in% dvFurrowPos$sample[i], "furrowPos"] <- dvFurrowPos$furrowPos[i]
boxes <- tabPower1.5mW %>% group_by(sample) %>% do(fnBox(., w=724))
tabPower1.5mWs <- tabPower1.5mW %>% group_by(sample) %>%
    do(fnIsolate(., boxes=boxes))

## ----3mW-------------------------------------------------------------------
plotSamples3mW <- "New data/3mW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda"
tabPower3mW <- filter(opto, condition == "3mW")
tabPower3mW[tabPower3mW$sample == "New data/3mW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 388
tabPower3mW[tabPower3mW$sample == "New data/3mW/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 402
tabPower3mW[tabPower3mW$sample == "New data/3mW/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 360
boxes <- tabPower3mW %>% group_by(sample) %>% do(fnBox(., w=724))
tabPower3mWs <- tabPower3mW %>% group_by(sample) %>% fnIsolate(., boxes=boxes)

## ----700uW_vs_1.5mW_vs_3mW, fig.show="hold", out.width="0.35\\linewidth", fig.align="center", fig.pos="H", fig.cap="Fig S4N-P: Cell area and a-p anisotropy are plotted over time for all cells in a globally light-activated sample that was activated with different two-photon laser powers. Solid and dashed lines indicate the median over cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile range."----
tabPower <- bind_rows(tabPower700uWs, tabPower1.5mWs, tabPower3mWs)
tabPower$t <- tabPower$t*tabPower$dt
plotSamples <- c(
    "700 uW"="New data/700uW/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda",
    "1.5 mW"="New data/Global_2p/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda",
    "3 mW"="New data/3mW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda")
for (i in seq_along(plotSamples)) {
    s <- plotSamples[i]
    tabPowers <- filter(tabPower, sample == s)
    px <- tabPowers$px[1]
    plotFeatureEvolution(tabPowers, dt=1/60, tMax=Inf, myTitle=names(s),
        px=px, cex=2, cex.axis=1.5, line=3.3, mar=c(5.1, 5.6, 4.1, 4.6))
}

