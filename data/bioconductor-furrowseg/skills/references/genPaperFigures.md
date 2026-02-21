Automatic generation of paper figures

Giorgia Guglielmi, Joseph D. Barry, Wolfgang Huber, Ste-
fano De Renzis

Contents

1

2

3

Introduction .

Load Data .

Analysis .

.

.

WT.

Global

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

1

1

4

8

9

10

12

2p titration .

Sktl, Zip, Dark .

Boxes Far vs Boxes Close .

Global 2p.

.

.

.

.

.

.

.

.

.

3.1

3.2

3.3

3.4

3.5

3.6

1

2

Introduction

In this vignette we automatically generate the data analysis figures produced for the paper
by Guglielmi et al.

Load Data

data("opto")

library(dplyr)

library(ggplot2)

3

Analysis

3.1 WT

To identify the furrowing line in the control (WT) samples, we first chose by inspection a time
point for each sample that showed a clear band of constriction. An average cell area profile
was computed along the dorsal-ventral (d-v) axis, to which a smoothing line was fitted. We
defined the position of minimum area as the furrowing position. Here we compute this for
all of the control samples but display the results for only one sample.

Automatic generation of paper figures

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

## Warning: ‘as.tbl()‘ was deprecated in dplyr 1.0.0.
## i Please use ‘tibble::as_tibble()‘ instead.
## i The deprecated feature was likely used in the furrowSeg package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning was
## generated.

for (i in seq_along(dvFurrowPos$sample))

tabWT[tabWT$sample %in% dvFurrowPos$sample[i], "furrowPos"] <-

dvFurrowPos$furrowPos[i]

print(dvFurrowPos)

## # A tibble: 5 x 2

## # Groups:

sample [5]

##

sample

<chr>

##
## 1 Global Activation/1_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOff~
## 2 Global Activation/2_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOff~
## 3 Global Activation/3_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOff~
## 4 Global Activation/4_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOff~
## 5 Global Activation/5_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOff~

furrowPos

<int>

301

258

280

207

266

We wished to focus only on cells along or near to the furrowing line. Therefore we subsetted
the control data to include only cells located in a box of dimensions 30 x 10 microns that
was centered on the furrowing line.

L <- function(x, px) round(microns2px(x, px))

fnBox <- function(x, w=512, Lx=30, Ly=10) {

Lx <- L(Lx, px=x$px[1])

Ly <- L(Ly, px=x$px[1])

box <- constructBox(x$furrowPos[1], Lx=Lx, Ly=Ly, w=w)

return(data.frame(t(box)))

2

Automatic generation of paper figures

}
boxes <- tabWT %>% group_by(sample) %>% do(fnBox(.))

fnIsolate <- function(x, boxes) {

box <- unlist(filter(boxes, sample == x$sample[1])[2:5])

x <- isolateBoxCells(x, box)

return(x)

}
tabWTs <- tabWT %>% group_by(sample) %>% do(fnIsolate(., boxes=boxes))

We then proceeded to also automatically identify the time point of tissue invagination. We
noticed that as the tissue furrowed, adjacent cells moved into the observation box from
both dorsal and ventral sides, and tended to be larger in area than the cells that initiated
the constriction. By fitting a smoothing line to the time profile of median cell area in the
observation box it was straightforward to identify the time at which a minimum area was
reached, which we chose to define as the time point of tissue invagination.

fnMinArea <- function(x, plot=FALSE) {

px <- x$px[1]

res <- identifyTimeMinArea(x=x, px=px, plot=plot)

return(data.frame(t=res["tindex"]))

}
tMinArea <- tabWTs %>% group_by(sample) %>% do(fnMinArea(.))
for (i in seq_along(tMinArea$sample))

tabWTs[tabWTs$sample == tMinArea$sample[i], "tstar"] <- tMinArea$t[i]

tabWTs <- filter(tabWTs, t <= tstar)

Next we inspected the dynamics of cell area and anisotropy.

plotSample <- "Global Activation/4_CTRL_VFF.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
tabSample <- filter(tabWTs, sample == plotSample)
tabSample$t <- tabSample$t*tabSample$dt
plotFeatureEvolution(tabSample, dt=1/60, tMax=Inf, myTitle="wild-type",

px=tabSample$px[1], cex=2, cex.axis=1.5, line=3.3,

mar=c(5.1, 5.6, 4.1, 4.6))

Figure 1: Fig 2J: Cell area and a-p anisotropy are plotted over time for cells within an area of 30 microns x
10 microns along the furrowing line for one control sample. Solid and dashed lines indicate the median over
cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile range.

A summary of WT cell features at the time point of furrowing was then taken.

3

time [min]area [mm2]0510151520253035400.20.40.60.8a−p anisotropyareaa−p anisotropywild−typeAutomatic generation of paper figures

summaryWT <- tabWTs %>%
group_by(sample) %>%
filter(t == tstar) %>%

summarize(APanisotropy=median(e.x, na.rm=TRUE),

APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),

APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE),

area=median(x.0.s.area, na.rm=TRUE),

area25=quantile(x.0.s.area, probs=0.25, na.rm=TRUE),

area75=quantile(x.0.s.area, probs=0.75, na.rm=TRUE))

summaryWTapicalSlice <- tabWTs %>%

group_by(sample) %>%
filter(t == tstar, z == 1) %>%

summarize(APanisotropy=median(e.x, na.rm=TRUE),

APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),

APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE),

area=median(x.0.s.area, na.rm=TRUE),

area25=quantile(x.0.s.area, probs=0.25, na.rm=TRUE),

area75=quantile(x.0.s.area, probs=0.75, na.rm=TRUE))

3.2

Global

We first inspected the dynamics of samples that were globally activated.

tabGlobal <- filter(opto, condition == "Global")
tabGlobal$t <- tabGlobal$t*tabGlobal$dt
plotSample <- "Global Activation/Global Activation/Image31.lsm - C=0/furrowSeg1.0.47_threshOffset5e-04_closingSize5.rda"
tabSample <- filter(tabGlobal, sample == plotSample)

plotFeatureEvolution(tabSample, dt=1/60, tMax=30, myTitle="globally activated",

px=tabSample$px[1], cex=2, cex.axis=1.5, line=3.3,

mar=c(5.1, 5.6, 4.1, 4.6))

Figure 2: Fig 2K: Cell area and a-p anisotropy are plotted over time for all cells in a globally light-activated
sample. Solid and dashed lines indicate the median over cells for area and a-p anisotropy, respectively, while
shaded regions show the interquartile range.

We then asked if the cell behaviour of the control and photo-activated samples were quantita-
tively different. Since there was no clear way to choose equivalent time points in the control
and photo-activated samples, we decided to compare control cells at the time of invagination
to photo-activated cells at 10, 20 and 30 minutes post-activation.

4

time [min]area [mm2]051015202530305070900.20.30.40.50.6a−p anisotropyareaa−p anisotropyglobally activatedAutomatic generation of paper figures

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

## ‘summarise()‘ has grouped output by ’condition’.

You can override using the

## ‘.groups‘ argument.

summaryWT$condition <- "control"
compareGlobal <- bind_rows(compareGlobal, summaryWT)

To assess differences we then performed two-sample t-tests on the median cell area and a-p
anisotropy for each sample. Since we compared between multiple groups, multiple testing
correction was performed using the method of Bonferroni.

wtArea <- compareGlobal %>% filter(condition == "control") %>%

summarize(meanArea=mean(area))

wtArea <- wtArea$meanArea

compareGlobal$normArea <- log2(compareGlobal$area/wtArea)

compareGlobal$normArea25 <- log2(compareGlobal$area25/wtArea)

compareGlobal$normArea75 <- log2(compareGlobal$area75/wtArea)

ttAPanisotropy <- pairwise.t.test(compareGlobal$APanisotropy,

compareGlobal$condition, p.adjust.method="bonferroni")

print(ttAPanisotropy)

##

##

##

Pairwise comparisons using t tests with pooled SD

## data: compareGlobal$APanisotropy and compareGlobal$condition

##

##

Global10 Global20 Global30

## Global20 1.00000 -

-

5

Automatic generation of paper figures

## Global30 1.00000 1.00000 -

## control 0.00016 0.00075 0.00166

##

## P value adjustment method: bonferroni

ttArea <- pairwise.t.test(compareGlobal$normArea, compareGlobal$condition,

p.adjust.method="bonferroni")

print(ttArea)

##

##

##

Pairwise comparisons using t tests with pooled SD

## data: compareGlobal$normArea and compareGlobal$condition

##

##

Global10 Global20 Global30

## Global20 1

## Global30 1

-

1

-

-

## control 9.3e-07 8.8e-07 1.2e-07

##

## P value adjustment method: bonferroni

For visualization purposes, p-values were converted to stars indicating significance levels. For
the comparison of median cell areas, the testing was performed on log2 transformed values
to ensure a more constant variance between the conditions. To ensure that we were log
transforming a dimensionless quantity, we first divided each measurement by the mean of
the areas in the control group. We also decided to show the corresponding absolute area
measurements on the right-hand axis.

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

6

Automatic generation of paper figures

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

7

Automatic generation of paper figures

segments(x0=i-0.2, x1=i+0.2, y0=conditionSummary[i, "median"], lwd=2, lty=1)

segments(x0=i, y0=conditionSummary[i, "q25"], y1=conditionSummary[i, "q75"],

lwd=2, lty=1)

}

Figure 3: Fig 2L-M: The median cell area and a-p anisotropy features at the time point of tissue invagi-
nation in the control samples were compared to three different time points in the photo-activated samples.
The statistical testing was performed using pairwise two-sample t-tests. As can be seen from the figure,
standard deviations were comparable between groups. To attain a higher precision we therefore used a
pooled standard deviation for all of the tests. p-values were corrected for multiple testing using the method
of Bonferroni. We performed the area testing on the log-transformed values but included the absolute ar-
eas on the right-hand y-axis as a reference. For both cell area and a-p anisotropy, the control samples were
significantly different from the photo-activated samples, while the the latter showed no significant changes
over time. The crosses show group median (horizontal line) and interquartile range (vertical line).

3.3

2p titration

To assess the effect of increasing laser power on cell behaviour we extracted cell features
from the following samples.

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

8

a−p anisotropycontrollightlightlight+10min+20min+30min0.00.40.8********n.s.n.s.n.s.log2(area / <area>ctrl)controllightlightlight+10min+20min+30min−0.50.51.5*********n.s.n.s.n.s.14.829.559area [mm2]Automatic generation of paper figures

Figure 4: Fig 5M-O: Cell area and a-p anisotropy are plotted over time for locally light-activated cells in
individual samples. Different two-photon laser powers were used to monitor changes in cell behaviour re-
sulting from varying levels of activation. Solid and dashed lines indicate the median over cells for area and
a-p anisotropy, respectively, while shaded regions show the interquartile range.

3.4

Sktl, Zip, Dark

Next we tested if a-p anisotropy from various control samples was different from wild-type
samples at the time point of furrowing. The most apical z-stack that gave an accurate cell
segmentation was kept for the following analysis. A box isolating a group of constricting cells
was chosen manually by the biologist.

tab <- filter(opto, condition %in% c("Dark", "Sktl", "Zip"))
summaryConds <- tab %>% group_by(condition, sample) %>%
summarize(APanisotropy=median(e.x, na.rm=TRUE),

APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),

APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE))

## ‘summarise()‘ has grouped output by ’condition’.

You can override using the

## ‘.groups‘ argument.

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

9

time [min]area [mm2]05101520253035400.10.20.30.40.50.6a−p anisotropyareaa−p anisotropy700 uWtime [min]area [mm2]051015202530203040500.20.40.6a−p anisotropyareaa−p anisotropy1.5 mWtime [min]area [mm2]05101520405060700.10.30.50.7a−p anisotropyareaa−p anisotropy3 mWAutomatic generation of paper figures

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

##

Dark

Sktl

## Sktl "n.s." "?"

Zip

"?"

## Zip "n.s." "n.s." "?"

## WT

"n.s." "n.s." "n.s."

drawBar(1, 2, y=0.40, star=myStarsConds["Sktl", "Dark"], offset=-0.05)

drawBar(2, 3, y=0.30, star=myStarsConds["Zip", "Sktl"], offset=-0.05)

drawBar(1, 3, y=0.20, star=myStarsConds["Zip", "Dark"], offset=-0.05)

drawBar(1, 4, y=0.10, star=myStarsConds["WT", "Dark"], offset=-0.05)

drawBar(2, 4, y=0.90, star=myStarsConds["WT", "Sktl"], offset=0.05)

drawBar(3, 4, y=0.80, star=myStarsConds["WT", "Zip"], offset=0.05)

Figure 5: Fig 3A: The median a-p anisotropy of constricting cells in different condition are compared to the
a-p anisotropy of control cells at the time point of furrowing. The statistical testing was performed using
pairwise two-sample t-tests. As can be seen from the figure, standard deviations were comparable between
groups. To attain a higher precision we therefore used a pooled standard deviation for all of the tests. p-
values were corrected for multiple testing using the method of Bonferroni. No significant differences were
detected between the groups. The crosses show group median (horizontal line) and interquartile range (ver-
tical line).

3.5

Boxes Far vs Boxes Close

We wished to compare samples from the double activation experiments where two boxes
of activation were placed at different distances from one another. Specifically, we wished
to quantify the a-p anisotropy of cells in the central area that was not activated. As the
mCherry signal in this region was predominantly cytoplasmic, it was not possible to obtain an
accurate segmentation of cell shape. We therefore instead imaged a single time point at the
end of each experiment in the GFP channel, with which cell shapes could be resolved. For
this section the most apical z-stack that gave an accurate cell segmentation was kept for the
analysis. A box isolating a group of constricting cells was chosen manually by the biologist.

10

a−p anisotropy0.00.40.8DarkSktlZipWTn.s.n.s.n.s.n.s.n.s.n.s.Automatic generation of paper figures

tabBoxes <- filter(opto, condition %in% c("BoxesFar", "NewBoxesFar",

"BoxesClose"))

summaryBoxes <- tabBoxes %>% group_by(condition, sample) %>%

summarize(APanisotropy=median(e.x, na.rm=TRUE),

APanisotropy25=quantile(e.x, probs=0.25, na.rm=TRUE),

APanisotropy75=quantile(e.x, probs=0.75, na.rm=TRUE))

## ‘summarise()‘ has grouped output by ’condition’.

You can override using the

## ‘.groups‘ argument.

summaryBoxes$condition[summaryBoxes$condition == "NewBoxesFar"] <- "BoxesFar"

summaryBoxes$condition <- droplevels(summaryBoxes$condition)

ttDouble <- t.test(APanisotropy ~ condition, summaryBoxes)

print(ttDouble)

##

##

##

Welch Two Sample t-test

## data: APanisotropy by condition

## t = -3.7062, df = 8.3088, p-value = 0.005603

## alternative hypothesis: true difference in means between group BoxesClose and group BoxesFar is not equal to 0

## 95 percent confidence interval:

##

-0.35250238 -0.08317076

## sample estimates:

## mean in group BoxesClose

mean in group BoxesFar

##

0.4211512

0.6389877

diff(ttDouble$estimate)

## mean in group BoxesFar

##

0.2178366

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

11

Automatic generation of paper figures

Figure 6: Fig 7G: The median a-p anisotropy of groups of constricting cells were compared between sam-
ples where the distance between two boxes of light activation was varied. A two-sample t-test revealed that
cells were more elongated along the embryo a-p axis in the experiment where the boxes were placed farther
apart. As can be seen from the plot, the two groups showed unequal variances. We therefore used Welch’s
t-test. The crosses show group median (horizontal line) and interquartile range (vertical line). The magni-
tude of difference in a-p anisotropy between the two groups was found to be 0.23.

3.6

Global 2p

We assessed the a-p anisotropy of samples that were globally activated with the 2-photon
microscope at different powers.

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

12

a−p anisotropyBoxesBoxesCloseFar0.00.20.40.60.81.0**Automatic generation of paper figures

do(fnIsolate(., boxes=boxes))

plotSamples3mW <- "New data/3mW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda"
tabPower3mW <- filter(opto, condition == "3mW")
tabPower3mW[tabPower3mW$sample == "New data/3mW/1_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 388
tabPower3mW[tabPower3mW$sample == "New data/3mW/2_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 402
tabPower3mW[tabPower3mW$sample == "New data/3mW/3_CIBNOCRL__R001_GR1_B1_SUM/furrowSeg1.0.47_threshOffset5e-04_closingSize3.rda", "furrowPos"] <- 360
boxes <- tabPower3mW %>% group_by(sample) %>% do(fnBox(., w=724))
tabPower3mWs <- tabPower3mW %>% group_by(sample) %>% fnIsolate(., boxes=boxes)

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

Figure 7: Fig S4N-P: Cell area and a-p anisotropy are plotted over time for all cells in a globally light-
activated sample that was activated with different two-photon laser powers. Solid and dashed lines indicate
the median over cells for area and a-p anisotropy, respectively, while shaded regions show the interquartile
range.

13

time [min]area [mm2]2468101220253035400.450.550.650.75a−p anisotropyareaa−p anisotropy700 uWtime [min]area [mm2]01020304020304050600.700.750.800.85a−p anisotropyareaa−p anisotropy1.5 mWtime [min]area [mm2]051015204050600.10.30.50.7a−p anisotropyareaa−p anisotropy3 mW