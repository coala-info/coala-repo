Supplementary Methods - Automatic gener-
ation of paper figures

Joseph D. Barry, Erika Donà, Darren Gilmour, Wolfgang
Huber

Contents

1

2

Introduction .

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

Figure 1 and related supplemental figures .

2.1

2.2

2.3

2.4

2.5

2.6

2.7

Figure 1B .

Figure 1C .

Figure 1D .

Figure 1E .

Figure S2A .

Figure 1F.

.

Figure S2B .

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

3

Figure 2 and related supplemental figures .

3.1

3.2

3.3

3.4

3.5

3.6

Figure 2B .

Figure S1 .

Figure 2C .

Figure 2D .

Figure S3A .

Figure S3B .

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

4

Figure 3 and related supplemental figures .

4.1

4.2

4.3

4.4

4.5

4.6

Figure 3A .

Figure 3B .

Figure 3C .

Figure S4A .

Figure S4B .

Figure S4C .

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

2

2

2

3

3

4

5

6

7

8

8

8

10

11

12

12

13

13

14

15

16

17

18

Supplementary Methods - Automatic generation of paper figures

1

Introduction

In this vignette we automatically generate figure panels produced for the paper by Barry et
al.

library(TimerQuant)

library(ggplot2)

library(grid)

library(deSolve)

library(reshape2)

library(dplyr)

data("profileGradients")

data("maturationData")

data("FRETdata")
myTheme <- theme_bw()+theme(title=element_text(size=32),

text=element_text(size=24), axis.title.y=element_text(vjust=1.5),
panel.grid=element_blank())

2

Figure 1 and related supplemental figures

2.1

Figure 1B

t <- seq(0.001, 1200, by=0.1)

p0 <- 10

TA <- 30

TB <- 180

kA <- log(2)/TA

kB <- log(2)/TB

T1 <- 5

T2 <- 100

m1 <- log(2)/T1

m2 <- log(2)/T2

df <- data.frame(t=t, x1B=x1(p0, m1, kB, t), x2B=x1(p0, m2, kB, t),

x1A=x1(p0, m1, kA, t), x2A=x1(p0, m2, kA, t))

df <- melt(df, id="t")

df$FP <- df[, "halflife"] <- NA

df[df$variable %in% c("x1B", "x1A"), "FP"] <- "FP1"

df[df$variable %in% c("x2B", "x2A"), "FP"] <- "FP2"

df[df$variable %in% c("x1A", "x2A"), "halflife"] <- paste(TA, "minutes")

df[df$variable %in% c("x1B", "x2B"), "halflife"] <- paste(TB, "minutes")
ggplot(df, aes(x=t, y=value, color=FP, linetype=halflife))+geom_line(size=1)+

scale_color_manual(values=c("darkgreen", "red"))+
scale_linetype_manual(values=c("solid", "dashed"))+myTheme+
scale_x_continuous(breaks=seq(0, 1200, by=200))+
theme(legend.position="none")+

labs(list(linetype="half-life", color="fluorophore"))+

xlab("time (minutes)")+

ylab("fluorescence intensity (a.u.)")

2

Supplementary Methods - Automatic generation of paper figures

Figure 1: Figure 1B: Time-dependent model solutions for FP1 and FP2 fluorescence intensities.

2.2

Figure 1C

df <- data.frame(t=t[-1], RatioB=x1(p0, m2, kB, t[-1])/x1(p0, m1, kB, t[-1]),

RatioA=x1(p0, m2, kA, t[-1])/x1(p0, m1, kA, t[-1]))

df <- melt(df, id="t")

ggplot(df, aes(x=t, y=value, color=variable, linetype=variable))+

geom_line(size=1)+scale_color_manual(values=c("blue", "blue"))+
scale_linetype_manual(values=c("solid", "dashed"))+myTheme+
scale_x_continuous(breaks=seq(0, 1200, by=200))+
theme(legend.position="none")+xlab("time (minutes)")+

ylab("FP2/FP1 intensity ratio")

Figure 2: Figure 1C: Time-dependent model solution for the FP2/FP1 fluorescence intensity ratio.

2.3

Figure 1D

halfLifeSeq <- seq(1, 1000, by=0.1)

tRangeFP1 <- c(1, 50)

tRangeFP2 <- c(10, 500)

colRamp <-

colorRampPalette(colors=c('darkgreen','yellow', 'orange', 'red'))(100)

3

05001000150020002500020040060080010001200time (minutes)fluorescence intensity (a.u.)0.20.40.6020040060080010001200time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

h <- genRatioHeatmap(tRangeFP=tRangeFP2, Tfixed=T1, TA=min(halfLifeSeq),

TB=max(halfLifeSeq), channel=2, n=150, ramp=colRamp)
h <- h+geom_hline(yintercept=TA, linetype="dashed", size=1)+

geom_hline(yintercept=TB, linetype="dashed", size=1)+myTheme+
annotation_logticks()+
theme(legend.position="top", legend.key.width=unit(2.5, "cm"))

print(h)

Figure 3: Figure 1D: Steady-state ratios as a function of FP2 maturation time and protein half-life.

2.4

Figure 1E

pSeq <- c(0.5, 2, 8)

nRealizations <- 500

sigmaAdd <- 1

T2 <- getSpacedSeq(c(10, 500), n=100)

res <- lapply(pSeq, function(p) lapply(T2, function(Time)

simulatedSignalN(T1, T2=Time, TA, TB, sigmaAdd, nRealizations, p=p, E=0)))

dfFP2 <- lapply(seq_along(res), function(i) {

df2 <- lapply(seq_along(res[[i]]), function(j)

return(data.frame(p=pSeq[i], Time=T2[j], D=res[[i]][[j]])))

df2 <- do.call("rbind", df2)

return(df2)

})

dfFP2 <- do.call("rbind", dfFP2)

dfFP2$FP <- "FP2"
dfFP2s <- dfFP2 %>% group_by(p, Time, FP) %>%

summarise(D.mean=mean(D, na.rm=TRUE), D.sd=sd(D, na.rm=TRUE))

dfFP2s$D0 <- simulatedSignal(T1, dfFP2s$Time, TA, TB, sigmaAdd=0, p=dfFP2s$p)

T1 <- getSpacedSeq(c(1, 30), n=100)

T2 <- 100

res <- lapply(pSeq, function(p) lapply(T1, function(Time)

simulatedSignalN(T1=Time, T2, TA, TB, sigmaAdd, nRealizations, p=p, E=0)))

dfFP1 <- lapply(seq_along(res), function(i) {

df2 <- lapply(seq_along(res[[i]]), function(j)

4

15105010050010001050100500FP2 maturation time (minutes)protein half−life T12 (minutes)R0.250.500.75Supplementary Methods - Automatic generation of paper figures

return(data.frame(p=pSeq[i], Time=T1[j], D=res[[i]][[j]])))

df2 <- do.call("rbind", df2)

return(df2)

})

dfFP1 <- do.call("rbind", dfFP1)

dfFP1$FP <- "FP1"
dfFP1s <- dfFP1 %>% group_by(p, Time, FP) %>%

summarise(D.mean=mean(D, na.rm=TRUE), D.sd=sd(D, na.rm=TRUE))

dfFP1s$D0 <- simulatedSignal(T1=dfFP1s$Time, T2, TA, TB, sigmaAdd=0, p=dfFP1s$p)
df <- bind_rows(dfFP1s, dfFP2s)
df$p <- paste("\np =", df$p, "molecules/minute\n")

df$FPline <- df$FP

df$FPline <- paste0(df$FP, "line")
ggplot(df, aes(Time, D.mean, colour=FP))+geom_point()+myTheme+

xlab("FP maturation time (minutes)")+ylab(expression("timer signal"~S))+
scale_color_manual(values=c("FP1"="darkgreen", "FP2"="red",

"FP1line"="black", "FP2line"="black"))+

scale_x_log10(breaks=getBreaks10(range(df$Time)))+
geom_errorbar(aes(ymin=D.mean-D.sd, ymax=D.mean+D.sd))+
geom_line(aes(Time, D0, colour=FPline), data=df)+
facet_wrap(~p)+
theme(legend.position="none", strip.text=element_text(size=32, lineheight=0.35))+
annotation_logticks(sides="b")

Figure 4: Figure 1E: Results of simulations with an additive error model to investigate the effect of noise
on timer signal for varying protein production rates.

T1 <- 5; T2 <- 100

2.5

Figure S2A

ESeq <- c(0, 0.25, 0.5, 0.75, 1)

p <- 2

nRealizations <- 500

sigmaAdd <- 1

T2 <- getSpacedSeq(c(10, 500), n=100)

res <- lapply(ESeq, function(E) lapply(T2, function(Time)

simulatedSignalN(T1, T2=Time, TA, TB, sigmaAdd, nRealizations, p=p, E=E)))

dfFP2 <- lapply(seq_along(res), function(i) {

df2 <- lapply(seq_along(res[[i]]), function(j)

return(data.frame(E=ESeq[i], Time=T2[j], D=res[[i]][[j]])))

df2 <- do.call("rbind", df2)

return(df2)

5

p = 0.5 molecules/minutep = 2 molecules/minutep = 8 molecules/minute1510501005001510501005001510501005000123FP maturation time (minutes)timer signal SSupplementary Methods - Automatic generation of paper figures

})

dfFP2 <- do.call("rbind", dfFP2)

dfFP2$FP <- "FP2"
dfFP2s <- dfFP2 %>% group_by(E, Time, FP) %>%

summarise(D.mean=mean(D, na.rm=TRUE), D.sd=sd(D, na.rm=TRUE))

dfFP2s$D0 <- simulatedSignal(T1, dfFP2s$Time, TA, TB, sigmaAdd=0, p=p,

E=dfFP2s$E)

T1 <- getSpacedSeq(c(1, 30), n=100)

T2 <- 100

res <- lapply(ESeq, function(E) lapply(T1, function(Time)

simulatedSignalN(T1=Time, T2, TA, TB, sigmaAdd, nRealizations, p=p, E=E)))

dfFP1 <- lapply(seq_along(res), function(i) {

df2 <- lapply(seq_along(res[[i]]), function(j)

return(data.frame(E=ESeq[i], Time=T1[j], D=res[[i]][[j]])))

df2 <- do.call("rbind", df2)

return(df2)

})

dfFP1 <- do.call("rbind", dfFP1)

dfFP1$FP <- "FP1"
dfFP1s <- dfFP1 %>% group_by(E, Time, FP) %>%

summarise(D.mean=mean(D, na.rm=TRUE), D.sd=sd(D, na.rm=TRUE))

dfFP1s$D0 <- simulatedSignal(T1=dfFP1s$Time, T2, TA, TB, sigmaAdd=0, E=dfFP1s$E,

p=p)

dfFRET <- bind_rows(dfFP1s, dfFP2s)
dfFRET$E <- paste("\nFRET efficiency E =", dfFRET$E, "\n")

dfFRET$FPline <- dfFRET$FP

dfFRET$FPline <- paste0(dfFRET$FP, "line")
ggplot(dfFRET, aes(Time, D.mean, colour=FP))+geom_point()+myTheme+

xlab("FP maturation time (minutes)")+ylab(expression("timer signal"~S))+
scale_color_manual(values=c("FP1"="darkgreen", "FP2"="red",

"FP1line"="black", "FP2line"="black"))+

scale_x_log10(breaks=getBreaks10(range(dfFRET$Time)))+
geom_errorbar(aes(ymin=D.mean-D.sd, ymax=D.mean+D.sd))+
geom_line(aes(Time, D0, colour=FPline), data=dfFRET)+
facet_wrap(~E, nrow=2)+
theme(legend.position="none", strip.text=element_text(size=32,

lineheight=0.35))+

annotation_logticks(sides="b")

T1 <- 5; T2 <- 100

2.6

Figure 1F

dfs <- filter(df, FP == "FP2")

dfs$CV <- dfs$D.sd/dfs$D.mean

dfFit <- dfs %>% group_by(p, FP) %>% do(fitCV(.))
ggplot(dfs, aes(Time, D.sd/D.mean, color=p))+geom_point()+myTheme+

scale_x_log10(breaks=getBreaks10(range(dfs$Time)))+
scale_y_log10(breaks=getBreaks10(range(dfs$CV)))+

6

Supplementary Methods - Automatic generation of paper figures

Figure 5: Figure S2A: Results of simulations with an additive error model to investigate the effect of noise
on timer signal for varying levels of FRET.

scale_colour_manual(values=c("#999999", "#009E73", "#CC79A7"))+
xlab("FP2 maturation time (minutes)")+

ylab(expression("coefficient of variation"~sigma[S]~"/"~mu[S]))+
geom_line(aes(Time, CV), size=1.5, data=dfFit)+
geom_vline(aes(xintercept=FP2optimumTime, color=p), data=dfFit,

linetype="dashed")+

theme(legend.position="none")+
annotation_logticks()

Figure 6: Figure 1F: Coefficient of variation as a function of FP2 maturation time for different protein
production rates.

2.7

Figure S2B

dfs <- filter(dfFRET, FP == "FP2")

dfs$CV <- dfs$D.sd/dfs$D.mean

myCol <- colorRampPalette(c("#999999", "#009E73", "#CC79A7"))(5)
dfFit <- dfs %>% group_by(E, FP) %>% do(fitCV(.))
ggplot(dfs, aes(Time, D.sd/D.mean, color=E))+geom_point()+myTheme+

scale_x_log10(breaks=getBreaks10(range(dfs$Time)))+
scale_y_log10(breaks=getBreaks10(range(dfs$CV)))+
scale_colour_manual(values=myCol)+

7

FRET efficiency E = 0.75 FRET efficiency E = 1 FRET efficiency E = 0 FRET efficiency E = 0.25 FRET efficiency E = 0.5 151050100500151050100500151050100500012012FP maturation time (minutes)timer signal S0.050.100.501.001050100500FP2 maturation time (minutes)coefficient of variation sS / mSSupplementary Methods - Automatic generation of paper figures

xlab("FP2 maturation time (minutes)")+

ylab(expression("coefficient of variation"~sigma[S]~"/"~mu[S]))+
geom_line(aes(Time, CV), size=1.5, data=dfFit)+
geom_vline(aes(xintercept=FP2optimumTime, color=E), data=dfFit,

linetype="dashed")+

theme(legend.position="none")+
annotation_logticks()

Figure 7: Figure S2B: Coefficient of variation as a function of FP2 maturation time for different FRET
efficencies.

3

Figure 2 and related supplemental figures

3.1

Figure 2B

myCol <- c(tdTom="orange", TagRFP="darkred", mKate2="purple")

A <- profileGradients

Ahat <- apply(A, c(1, 2), function(x) x/mean(x[1:6]))

Ahat <- aperm(Ahat, c(2, 3, 1))

Ahat <- log2(Ahat)

plotPrimordiumProfile(Ahat["mKate2", , ], ylim=c(-0.3, 1.3), xlim=c(-200, 0),

ylab="timer signal", col=myCol["mKate2"], lwd=3, lty=3,

cex.axis=1.5, cex.lab=2.5, alpha=0.1)

plotPrimordiumProfile(Ahat["TagRFP", , ], add=TRUE, lty=2, col=myCol["TagRFP"],

lwd=3, alpha=0.1)

plotPrimordiumProfile(Ahat["tdTom", , ], add=TRUE, lty=1, col=myCol["tdTom"],

lwd=3, alpha=0.1)

abline(v=0, lty=2)

abline(v=-25, lty=2)

nSamples <- c(tdTom=34, TagRFP=40, mKate2=52)

myLegend <- paste0(names(nSamples), "-sfGFP (n=", nSamples, ")")

legend(x=-100, y=1.2, legend=myLegend, lty=1:3, lwd=3, cex=1.5, col=myCol)

3.2

Figure S1

8

0.050.101050100500FP2 maturation time (minutes)coefficient of variation sS / mSSupplementary Methods - Automatic generation of paper figures

Figure 8: Figure 2B: Comparing the timer signal profiles of three different timers in the zebrafish posterior
lateral line primordium.

A <- maturationData

A[, "meanGFP", 4, 3, "mKate2"] <- NA # jump in signal in gfp

A[, "meanGFP", 2, 2, "TagRFP"] <- NA # jump in signal in gfp

A[, "meanGFP", 1, 4, "tdTom"] <- NA # jump in gfp

A[, "meanRFP", 1:2, 1:4, "TagRFP"] <- NA

A <- A[as.integer(dimnames(A)$t) <= 800, c("meanGFP", "meanRFP"), , , ]

A[as.integer(dimnames(A)$t) > 500, "meanGFP", , , ] <- NA

indT <- which(dimnames(A)$t == "500")

myNorm <- function(x, indT) {

x <- x-min(x, na.rm=TRUE)

x[x < 0] <- NA

x <- x/x[indT]

return(x)

}

Anorm <- apply(A, c(2, 3, 4, 5), myNorm, indT)

dimnames(Anorm) <- dimnames(A)

AnormSummarizeViews <- apply(Anorm, c(1, 2, 3, 5), mean, na.rm=TRUE)

AnormSummarizeSamples <- apply(AnormSummarizeViews, c(1, 2, 4), mean,

na.rm=TRUE)

Amelt <- melt(AnormSummarizeSamples, id="t")

Amelt$tFTs <- as.factor(paste0(Amelt$tFTs, "-sfGFP"))

o <- match(levels(Amelt$tFT), paste0(names(myCol), "-sfGFP"))

Amelt$tFTs <- factor(Amelt$tFTs, levels=levels(Amelt$tFTs)[o])
ggplot(na.omit(Amelt), aes(x=t, y=value, color=tFTs))+geom_line(size=2)+

facet_wrap(~data, scales="free_x")+
scale_color_manual(values=as.vector(myCol))+
geom_vline(xintercept=500, linetype="dashed")+
xlab("time (minutes)")+ylab("normalized fluorescence intensity")+myTheme

9

distance from leading edge (microns)timer signal20017515012510075502500.00.51.0tdTom−sfGFP (n=34)TagRFP−sfGFP (n=40)mKate2−sfGFP (n=52)Supplementary Methods - Automatic generation of paper figures

Figure 9: Figure S1: Comparing the maturation rates of three different RFPs.

3.3

Figure 2C

FRET <- FRETdata

myColReduced <- myCol[names(myCol) %in% FRET$tFT]

FRET$tFT <- paste0(FRET$tFT, "-sfGFP")

FRET$tFT <- as.factor(FRET$tFT)

o <- match(levels(FRET$tFT), paste0(names(myCol), "-sfGFP"))

FRET$tFT <- factor(FRET$tFT, levels=levels(FRET$tFT)[o])

ggplot(FRET, aes(tFT, FRET, fill="white"))+

geom_boxplot(outlier.size=0, fill="white")+
geom_point(aes(x=tFT, y=FRET, colour=tFT, size=4), position="jitter")+
scale_color_manual(values=as.vector(myColReduced))+xlab("")+myTheme+
ylab("FRET efficiency")+theme(legend.position="none")+
theme(axis.text.x=element_text(size=24))

Figure 10: Figure 2C: FRET efficiency measurements for tdTom-sfGFP and TagRFP-sfGFP.

FRETs <- tapply(FRET$FRET, FRET$tFT, median)

print(FRETs)

##

##

tdTom-sfGFP TagRFP-sfGFP

0.445049

0.137931

10

meanGFPmeanRFP1002003004005002004006008000246time (minutes)normalized fluorescence intensitytFTsmKate2−sfGFPtdTom−sfGFPTagRFP−sfGFP0.10.20.30.40.5tdTom−sfGFPTagRFP−sfGFPFRET efficiencySupplementary Methods - Automatic generation of paper figures

3.4

Figure 2D

FPestimate <- c(mKate2=15, tdTom=80, TagRFP=100)

tFTs <- names(FPestimate)

Rhat <- sapply(tFTs, function(ch) median(Ahat[ch, , "200"], na.rm=TRUE))
Tfront <- 60; Tback <- 5*Tfront
Tseq <- seq(Tfront, Tback, length=100)

T1 <- 6

df <- data.frame(

halfLife=Tseq,

tdTomNoFret=signal(T1=T1, T2=FPestimate["tdTom"], TA=Tfront, TB=Tseq, E=0),

tdTomFret=signal(T1=T1, T2=FPestimate["tdTom"], TA=Tfront, TB=Tseq,

E=FRETs["tdTom-sfGFP"]),

TagRFPNoFret=signal(T1=T1, T2=FPestimate["TagRFP"], TA=Tfront, TB=Tseq,

E=0),

TagRFPFret=signal(T1=T1, T2=FPestimate["TagRFP"], TA=Tfront, TB=Tseq,

E=FRETs["TagRFP-sfGFP"]))

df <- melt(df, id="halfLife")

df$FRET <- !grepl(x=as.character(df$variable), pattern="NoFret")

df$FRET <- factor(df$FRET, levels=c("TRUE", "FALSE"))

df$tFT[grepl(x=as.character(df$variable), pattern="mKate2")] <- "mKate2-sfGFP"

df$tFT[grepl(x=as.character(df$variable), pattern="tdTom")] <- "tdTom-sfGFP"

df$tFT[grepl(x=as.character(df$variable), pattern="TagRFP")] <- "TagRFP-sfGFP"

df$tFT <- factor(df$tFT, levels=paste0(names(myCol), "-sfGFP"))

ggplot(df, aes(x=halfLife, y=value, color=tFT, linetype=FRET))+

geom_line(size=1)+
scale_color_manual(values=as.vector(myColReduced),

guide=guide_legend(title="timer"))+

scale_linetype_manual(values=c("solid", "dashed"))+
xlab("simulated protein half-life (minutes)")+

ylab(expression("simulated timer signal"))+
geom_vline(xintercept=Tfront, linetype="dotted")+
scale_x_reverse()+myTheme+
theme(legend.position=c(0.77, 0.85), legend.key.width=unit(2, "cm"),

legend.box.just="left")

Figure 11: Figure 2D: Model shows that the addition of FRET can cause a reordering of profile slopes.

11

0.00.30.60.950100150200250300simulated protein half−life (minutes)simulated timer signaltimertdTom−sfGFPTagRFP−sfGFPFRETTRUEFALSESupplementary Methods - Automatic generation of paper figures

3.5

Figure S3A

t <- seq(0.001, 1000, by=0.1)

x1ss0 <- x1ss(p0, m2, kB, f=1)

tss0 <- tss(m2, kB)

df <- data.frame(t=t, x1=x1(p0, m2, kB, t))
ggplot(df, aes(t, x1))+geom_line(col="red", size=1)+xlab("time (minutes)")+

ylab("FP2 fluorescence intensity (a.u.)")+
geom_hline(yintercept=x1ss0)+
geom_abline(intercept=TimerQuant:::inflectionOffset(p0, m2, kB, 0),

slope=TimerQuant:::inflectionSlope(p0, m2, kB, 0))+
geom_vline(xintercept=tss0, linetype="dotted", size=2)+
geom_point(data=NULL, aes(x=tss0, y=x1ss0), color="blue", size=4)+myTheme

Figure 12: Figure S4A: Quantification of the time to reach steady-state.

3.6

Figure S3B

tRange <- c(10, 100)

colRamp <- rainbow(120)[1:100]

h <- genTimeSteadyStateHeatmap(tRange, tRange, n=150, ramp=colRamp)+myTheme+

annotation_logticks()

print(h)

Figure 13: Figure S4B: Time to reach steady-state.

12

05001000150002505007501000time (minutes)FP2 fluorescence intensity (a.u.)10501001050100FP2 maturation time (minutes)protein half−life (minutes)Tss100200300Supplementary Methods - Automatic generation of paper figures

4

Figure 3 and related supplemental figures

t <- seq(0, 600, length=1000)

t0 <- min(t); tf <- max(t)

p0 <- 10; k0 <- log(2)/60

k1 <- log(2)/30

m1 <- log(2)/T1; m2 <- log(2)/T2

x01 <- c(X1=x0ss(p0, m1, k0), X2=x1ss(p0, m1, k0))

x02 <- c(X1=x0ss(p0, m2, k0), X2=x1ss(p0, m2, k0))

4.1

Figure 3A

myBreaks <- seq(0, 600, by=120)

dfp <- data.frame(t=t,

linearIncrease=rFun("linearIncrease", r0=p0, tf=tf)(t),

linearDecrease=rFun("linearDecrease", r0=p0, tf=tf)(t))

types <- colnames(dfp)[-1]

dfp <- melt(dfp, id="t")
gp <- ggplot(dfp, aes(t, value))+geom_line(size=1)+

facet_wrap(~variable, ncol=1)+
xlab("time (minutes)")+ylab("production rate (molecules per minute)")+
scale_x_continuous(breaks=myBreaks)+myTheme

dfk <- data.frame(t=t,

linearIncrease=rFun("linearIncrease", r0=k0, tf=tf)(t),

linearDecrease=rFun("linearDecrease", r0=k0, tf=tf)(t))

dfk <- melt(dfk, id="t")
gk <- ggplot(dfk, aes(t, value))+geom_line(size=1)+

facet_wrap(~variable, ncol=1)+xlab("time (minutes)")+
ylab(expression(paste("degradation rate (minutes"^{-1}, ")")))+
scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd=n, typeDeg=n, p0=p0, k0=k0))

for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

reorderFactors <- function(x, channel="uid", ordering) {

x[, channel] <- as.factor(x[, channel])

o <- match(ordering, levels(x[, channel]))

x[, channel] <- factor(x[, channel], levels(x[, channel])[o])

return(x)

}

df <- reorderFactors(df, "type", types)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))
g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+
facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+

13

Supplementary Methods - Automatic generation of paper figures

ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
ylab("FP2/FP1 intensity ratio")+
scale_x_continuous(breaks=myBreaks)+
myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 4)))

print(gp, vp=viewport(layout.pos.row=1, layout.pos.col=1))

print(gk, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=3))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=4))

Figure 14: Figure 3A: Timer readouts for simulations where production and degradation are changing over
time, but adding or removing proteins from the system at comparable rates.

4.2

Figure 3B

dfp <- data.frame(t=t,

burst=rFun("burst", r0=p0, tf=tf)(t),

stepUp=rFun("stepUp", r0=p0, tf=tf)(t))

types <- colnames(dfp)[-1]

dfp <- melt(dfp, id="t")
gp <- ggplot(dfp, aes(t, value))+geom_line(size=1)+

facet_wrap(~variable, ncol=1)+xlab("time (minutes)")+
ylab("production rate (molecules per minute)")+
scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd=n, typeDeg="constant", p0=p0, k0=k0))
for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))
g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+
facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+
ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+

14

linearDecreaselinearIncrease01202403604806005101551015time (minutes)production rate (molecules per minute)linearDecreaselinearIncrease01202403604806000.0050.0100.0150.0200.0050.0100.0150.020time (minutes)degradation rate (minutes-1)linearDecreaselinearIncrease0120240360480600200400600800200400600800time (minutes)FP1, FP2 fluorescence intensity (a.u.)linearDecreaselinearIncrease01202403604806000.30.40.50.60.70.30.40.50.60.7time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

ylab("FP2/FP1 intensity ratio")+
scale_x_continuous(breaks=myBreaks)+
myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 3)))

print(gp, vp=viewport(layout.pos.row=1, layout.pos.col=1))

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=3))

Figure 15: Figure 3B: The effect of rapidly changing production dynamics on timer readouts.

4.3

Figure 3C

dfk <- data.frame(t=t,

stepDown=rFun("stepDown", r0=k0, tf=tf)(t),

stepUp=rFun("stepUp", r0=k0, tf=tf)(t))

types <- colnames(dfk)[-1]

dfk <- melt(dfk, id="t")
gk <- ggplot(dfk, aes(t, value))+geom_line(size=1)+xlab("time (minutes)")+

ylab(expression(paste("degradation rate (minutes"^{-1}, ")")))+
facet_wrap(~variable, ncol=1)+scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd="constant", typeDeg=n, p0=p0, k0=k0))
for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))
g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+

xlab("time (minutes)")+
facet_wrap(~typeDeg, ncol=1, scales="fixed")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+
ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

facet_wrap(~typeDeg, ncol=1, scale="fixed")+xlab("time (minutes)")+
ylab("FP2/FP1 intensity ratio")+scale_x_continuous(breaks=myBreaks)+myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 3)))

print(gk, vp=viewport(layout.pos.row=1, layout.pos.col=1))

15

stepUpburst012024036048060010152025301015202530time (minutes)production rate (molecules per minute)stepUpburst012024036048060050075010005007501000time (minutes)FP1, FP2 fluorescence intensity (a.u.)stepUpburst01202403604806000.320.360.400.440.320.360.400.44time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=3))

Figure 16: Figure 3C: The effect of rapidly changing degradation dynamics on timer readouts.

4.4

Figure S4A

E <- 0.5

myBreaks <- seq(0, 600, by=120)

dfp <- data.frame(t=t,

linearIncrease=rFun("linearIncrease", r0=p0, tf=tf)(t),

linearDecrease=rFun("linearDecrease", r0=p0, tf=tf)(t))

types <- colnames(dfp)[-1]

dfp <- melt(dfp, id="t")
gp <- ggplot(dfp, aes(t, value))+geom_line(size=1)+facet_wrap(~variable, ncol=1)+

xlab("time (minutes)")+ylab("production rate (molecules per minute)")+
scale_x_continuous(breaks=myBreaks)+myTheme

dfk <- data.frame(t=t,

linearIncrease=rFun("linearIncrease", r0=k0, tf=tf)(t),

linearDecrease=rFun("linearDecrease", r0=k0, tf=tf)(t))

dfk <- melt(dfk, id="t")
gk <- ggplot(dfk, aes(t, value))+geom_line(size=1)+

facet_wrap(~variable, ncol=1)+xlab("time (minutes)")+
ylab(expression(paste("degradation rate (minutes"^{-1}, ")")))+
scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd=n, typeDeg=n, p0=p0, k0=k0, E=E))
for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

reorderFactors <- function(x, channel="uid", ordering) {

x[, channel] <- as.factor(x[, channel])

o <- match(ordering, levels(x[, channel]))

x[, channel] <- factor(x[, channel], levels(x[, channel])[o])

return(x)

}

df <- reorderFactors(df, "type", types)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))

16

stepUpstepDown01202403604806000.00750.01000.01250.01500.01750.00750.01000.01250.01500.0175time (minutes)degradation rate (minutes-1)stepUpstepDown01202403604806004008001200160040080012001600time (minutes)FP1, FP2 fluorescence intensity (a.u.)stepUpstepDown01202403604806000.40.50.40.5time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+
facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+
ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
ylab("FP2/FP1 intensity ratio")+
scale_x_continuous(breaks=myBreaks)+
myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 4)))

print(gp, vp=viewport(layout.pos.row=1, layout.pos.col=1))

print(gk, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=3))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=4))

Figure 17: Figure S4A: Timer readouts for simulations with FRET where production and degradation are
changing over time, but adding or removing proteins from the system at comparable rates.

4.5

Figure S4B

dfp <- data.frame(t=t,

burst=rFun("burst", r0=p0, tf=tf)(t),

stepUp=rFun("stepUp", r0=p0, tf=tf)(t))

types <- colnames(dfp)[-1]

dfp <- melt(dfp, id="t")
gp <- ggplot(dfp, aes(t, value))+geom_line(size=1)+

facet_wrap(~variable, ncol=1)+
xlab("time (minutes)")+ylab("production rate (molecules per minute)")+
scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd=n, typeDeg="constant", p0=p0, k0=k0, E=E))

for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))
g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+
facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+

17

linearDecreaselinearIncrease01202403604806005101551015time (minutes)production rate (molecules per minute)linearDecreaselinearIncrease01202403604806000.0050.0100.0150.0200.0050.0100.0150.020time (minutes)degradation rate (minutes-1)linearDecreaselinearIncrease0120240360480600200300400500600200300400500600time (minutes)FP1, FP2 fluorescence intensity (a.u.)linearDecreaselinearIncrease01202403604806000.500.751.000.500.751.00time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

facet_wrap(~type, ncol=1, scales="fixed")+xlab("time (minutes)")+
ylab("FP2/FP1 intensity ratio")+
scale_x_continuous(breaks=myBreaks)+
myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 3)))

print(gp, vp=viewport(layout.pos.row=1, layout.pos.col=1))

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=3))

Figure 18: Figure S4B: The effect of rapidly changing production dynamics on timer readouts when FRET
is present.

4.6

Figure S4C

dfk <- data.frame(t=t,

stepDown=rFun("stepDown", r0=k0, tf=tf)(t),

stepUp=rFun("stepUp", r0=k0, tf=tf)(t))

types <- colnames(dfk)[-1]

dfk <- melt(dfk, id="t")
gk <- ggplot(dfk, aes(t, value))+geom_line(size=1)+xlab("time (minutes)")+

ylab(expression(paste("degradation rate (minutes"^{-1}, ")")))+
facet_wrap(~variable, ncol=1)+scale_x_continuous(breaks=myBreaks)+myTheme

df <- lapply(types, function(n) solveModel(x01, x02, t, m1=m1, m2=m2,

typeProd="constant", typeDeg=n, p0=p0, k0=k0, E=E))

for (i in seq_along(df)) df[[i]]$type <- types[i]
df <- do.call("rbind", df)

df <- na.omit(df)

df2 <- melt(df, id=c("time", "typeProd", "typeDeg", "type"))

df2 <- filter(df2, variable %in% c("FP1", "FP2"))
g2 <- ggplot(df2, aes(time, value, color=variable))+geom_line(size=1)+

xlab("time (minutes)")+
facet_wrap(~typeDeg, ncol=1, scales="fixed")+
scale_x_continuous(breaks=myBreaks)+
scale_color_manual(values=c("darkgreen", "red"))+
ylab("FP1, FP2 fluorescence intensity (a.u.)")+myTheme+

theme(legend.position="none")

g3 <- ggplot(df, aes_string("time", "Ratio"))+geom_line(color="blue", size=1)+

18

stepUpburst012024036048060010152025301015202530time (minutes)production rate (molecules per minute)stepUpburst0120240360480600300500700900300500700900time (minutes)FP1, FP2 fluorescence intensity (a.u.)stepUpburst01202403604806000.400.450.500.550.400.450.500.55time (minutes)FP2/FP1 intensity ratioSupplementary Methods - Automatic generation of paper figures

facet_wrap(~typeDeg, ncol=1, scale="fixed")+xlab("time (minutes)")+
ylab("FP2/FP1 intensity ratio")+scale_x_continuous(breaks=myBreaks)+myTheme

grid.newpage()

pushViewport(viewport(layout=grid.layout(1, 3)))

print(gk, vp=viewport(layout.pos.row=1, layout.pos.col=1))

print(g2, vp=viewport(layout.pos.row=1, layout.pos.col=2))

print(g3, vp=viewport(layout.pos.row=1, layout.pos.col=3))

Figure 19: Figure S4C: The effect of rapidly changing degradation dynamics on timer readouts when FRET
is present.

19

stepUpstepDown01202403604806000.00750.01000.01250.01500.01750.00750.01000.01250.01500.0175time (minutes)degradation rate (minutes-1)stepUpstepDown012024036048060030060090012003006009001200time (minutes)FP1, FP2 fluorescence intensity (a.u.)stepUpstepDown01202403604806000.40.50.60.70.40.50.60.7time (minutes)FP2/FP1 intensity ratio