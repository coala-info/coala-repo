# Control experiment to assess robustness of protein detection via flycodes

Pascal Egloff1, Christian Panse2\* and Markus Seeger,1

1Institute of Medical Microbiology, University of Zurich
2Functional Genomics Center Zurich, UZH|ETHZ

\*cp@fgcz.ethz.ch

#### 2018-09-18, 2018-09-22, 2018-09-27, 2018-09-28, 2018-10-02, 2018-10-03

#### Abstract

The following content was used to compile the *Supplementary Note 1* in Egloff et al. ([2018](#ref-NestLink)) (under review NMETH-A35040) to demonstrate the robustness of protein detection via flycodes.

# Contents

* [1 Getting started](#getting-started)
* [2 Load data](#load-data)
  + [2.1 Clean](#clean)
  + [2.2 Sanity check](#sanity-check)
  + [2.3 Camera ready summary table](#camera-ready-summary-table)
  + [2.4 Define `FCfill2max`](#define-fcfill2max)
  + [2.5 Plot compute CVs for each row](#plot-compute-cvs-for-each-row)
* [3 Absolute Quantification](#absolute-quantification)
  + [3.1 Define function `FlycodeAbsoluteStatistics` using `coli1` column](#define-function-flycodeabsolutestatistics-using-coli1-column)
  + [3.2 Camera ready absolute table](#camera-ready-absolute-table)
  + [3.3 Define `FCrandom`](#define-fcrandom)
  + [3.4 Conduct the random experiment](#conduct-the-random-experiment)
  + [3.5 Camera ready plot of absolute flycode simulation](#camera-ready-plot-of-absolute-flycode-simulation)
* [4 Relative Quantification](#relative-quantification)
  + [4.1 Normalization](#normalization)
  + [4.2 Define ratios](#define-ratios)
  + [4.3 Determine outliers (removal)](#determine-outliers-removal)
  + [4.4 Define function `FlycodeRelativeStatistics`](#define-function-flycoderelativestatistics)
  + [4.5 Conduct the random experiment](#conduct-the-random-experiment-1)
  + [4.6 Camera ready plot of relative flycode simulation](#camera-ready-plot-of-relative-flycode-simulation)
  + [4.7 Camera ready relative table](#camera-ready-relative-table)
* [5 Session info](#session-info)
* [References](#references)

# 1 Getting started

```
library(lattice)
library(knitr)
library(parallel)
library(NestLink)

cv <- 1 - 1:7 / 10
t <- trellis.par.get("strip.background")
t$col <- (rgb(cv,cv,cv))
trellis.par.set("strip.background", t)
n.simulation <- 10
```

# 2 Load data

```
# filename <- system.file("extdata/PGexport2_normalizedAgainstSBstandards_Peptides.csv",
#                        package = "NestLink")
# library(ExperimentHub)
# eh <- ExperimentHub()
# filename <- query(eh, c("NestLink", "PGexport2_normalizedAgainstSBstandards_Peptides.csv"))[[1]]

filename <- getExperimentHubFilename("PGexport2_normalizedAgainstSBstandards_Peptides.csv")
P <- read.csv(filename,
              header = TRUE, sep=';')
dim(P)
```

```
## [1] 721  27
```

## 2.1 Clean

remove modifications

```
P <- P[P$Modifications == '', ]
dim(P)
```

```
## [1] 697  27
```

select rows

```
P <- P[,c('Accession', 'Sequence', "X20170919_05_62465_nl5idx1.3_6titratecoli",
          "X20170919_16_62465_nl5idx1.3_6titratecoli",
          "X20170919_09_62466_nl5idx1.3_7titratesmeg",
          "X20170919_14_62466_nl5idx1.3_7titratesmeg")]
dim(P)
```

```
## [1] 697   6
```

rename column names

```
names(P)<-c('Accession','Sequence','coli1', 'coli2', 'smeg1', 'smeg2')
dim(P)
```

```
## [1] 697   6
```

remove all rows with invalid identidfier

```
P<- P[grep("^P[0-9][A-Z][0-9]", P$Accession), ]

P<-droplevels(P)
```

add flycode set annotation

```
P$ConcGr <- NA

P$ConcGr[P$Accession %in% c('P1A4', 'P1B4', 'P1C4', 'P1D4', 'P1E4', 'P1F4')] <- 92

P$ConcGr[P$Accession %in% c('P1A5', 'P1B5', 'P1C5', 'P1D5', 'P1G4', 'P1H4')] <- 295

P$ConcGr[P$Accession %in% c('P1A6', 'P1B6', 'P1E5', 'P1F5', 'P1G5', 'P1H5')] <- 943

P$ConcGr[P$Accession %in% c('P1C6', 'P1D6', 'P1E6', 'P1F6', 'P1G6', 'P1H6')] <- 3017
```

## 2.2 Sanity check

```
table(P$ConcGr)
```

```
##
##   92  295  943 3017
##   82  122  135  165
```

```
Pabs <- P
```

```
table(P$Accession)
```

```
##
## P1A4 P1A5 P1A6 P1B4 P1B5 P1B6 P1C4 P1C5 P1C6 P1D4 P1D5 P1D6 P1E4 P1E5 P1E6 P1F4
##   11   22   24   15   22   23   16   19   26   15   16   29   13   23   30   12
## P1F5 P1F6 P1G4 P1G5 P1G6 P1H4 P1H5 P1H6
##   19   28   22   24   24   21   22   28
```

## 2.3 Camera ready summary table

```
P.summary <- aggregate(. ~ ConcGr * Accession, data=P[,c('Accession', 'coli1',
    'coli2', 'smeg1', 'smeg2', 'ConcGr')], FUN=sum)
P.summary$nDetectedFlycodes <- aggregate(Sequence ~ ConcGr * Accession,
    data=na.omit(P), FUN=length)[,3]
P.summary$nTotalFlycodes <- 30
P.summary$coverage <- round(100 * P.summary$nDetectedFlycodes  / P.summary$nTotalFlycodes)
kable(P.summary[order(P.summary$ConcGr),], row.names = FALSE)
```

| ConcGr | Accession | coli1 | coli2 | smeg1 | smeg2 | nDetectedFlycodes | nTotalFlycodes | coverage |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 92 | P1A4 | 3473996 | 3670152 | 3524234 | 3629077 | 11 | 30 | 37 |
| 92 | P1B4 | 3972002 | 3951215 | 3685668 | 3632472 | 15 | 30 | 50 |
| 92 | P1C4 | 5582053 | 5716917 | 5700899 | 5623891 | 16 | 30 | 53 |
| 92 | P1D4 | 5188468 | 5642192 | 5245252 | 5281381 | 15 | 30 | 50 |
| 92 | P1E4 | 4697745 | 4824760 | 5051017 | 5146804 | 13 | 30 | 43 |
| 92 | P1F4 | 3968239 | 4026336 | 4246879 | 4251951 | 12 | 30 | 40 |
| 295 | P1A5 | 23970332 | 24546550 | 26479936 | 25950084 | 22 | 30 | 73 |
| 295 | P1B5 | 16033017 | 16352277 | 17209165 | 17490691 | 22 | 30 | 73 |
| 295 | P1C5 | 24016078 | 24734329 | 22810916 | 22589773 | 19 | 30 | 63 |
| 295 | P1D5 | 17658145 | 17864382 | 17760463 | 17773297 | 16 | 30 | 53 |
| 295 | P1G4 | 16016015 | 16618336 | 18270569 | 19036154 | 22 | 30 | 73 |
| 295 | P1H4 | 19519544 | 20301903 | 20111340 | 20174474 | 21 | 30 | 70 |
| 943 | P1A6 | 65538576 | 67507722 | 66123186 | 66400185 | 24 | 30 | 80 |
| 943 | P1B6 | 55078431 | 58048226 | 50652047 | 50278919 | 23 | 30 | 77 |
| 943 | P1E5 | 60305499 | 62836186 | 62173846 | 61952054 | 23 | 30 | 77 |
| 943 | P1F5 | 46800670 | 49088967 | 47748401 | 47930977 | 19 | 30 | 63 |
| 943 | P1G5 | 54312219 | 55033298 | 51968903 | 51106582 | 24 | 30 | 80 |
| 943 | P1H5 | 59931716 | 61370897 | 55971370 | 56588298 | 22 | 30 | 73 |
| 3017 | P1C6 | 168463728 | 180586807 | 158342929 | 158748952 | 26 | 30 | 87 |
| 3017 | P1D6 | 159828074 | 163103139 | 140519542 | 138765621 | 29 | 30 | 97 |
| 3017 | P1E6 | 166626467 | 176697478 | 159850632 | 161744675 | 30 | 30 | 100 |
| 3017 | P1F6 | 191955804 | 203793127 | 181359940 | 182939796 | 28 | 30 | 93 |
| 3017 | P1G6 | 183248427 | 189386707 | 177588746 | 178178834 | 24 | 30 | 80 |
| 3017 | P1H6 | 181057205 | 185326019 | 161715001 | 152753819 | 28 | 30 | 93 |

```
# write.csv(P.summary, file='Figs/FigureS6b.csv')
```

The following function defines the computation and rendering of the by the
`paris` function called panels.

```
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits = digits)[1]
    txt <- paste0(prefix, txt)
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor * r)
}
```

```
rv <-lapply(unique(P$ConcGr), function(q){
pairs((P[P$ConcGr == q ,c('coli1', 'coli2', 'smeg1', 'smeg2')]),
      pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.3),
      lower.panel = panel.cor,
      asp=1,
      main=q)
})
```

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

## 2.4 Define `FCfill2max`

to conduct a fair random experiment we add *dummy flycodes*
to the input `data.frame`.

```
FCfill2max <- function(P, n = max(table(P$Accession))){
   for (i in unique(P$Accession)){
     idx <- which(P$Accession == i)
     # determine the number of missing rows for Accession i
     ndiff <- n - length(idx)

     if(length(idx) < n){
       cand <- P[idx[1], ]
       cand[,2 ] <- "xxx"
       cand[,3:6 ] <- NA

       for (j in 1:ndiff){
         P <- rbind(P, cand)
       }
     }
   }
  P
}
```

## 2.5 Plot compute CVs for each row

```
P.mean <- apply(P[, c('coli1', 'coli2', 'smeg1', 'smeg2')],1, FUN=mean)
P.sd <- apply(P[, c('coli1', 'coli2', 'smeg1', 'smeg2')],1, FUN=sd)

boxplot(100*P.sd/P.mean ~ P$ConcGr,log='y', ylab='CV%')
```

![](data:image/png;base64...)

```
P <- FCfill2max(P)
```

# 3 Absolute Quantification

## 3.1 Define function `FlycodeAbsoluteStatistics` using `coli1` column

```
FlycodeAbsoluteStatistics <- function(P){

  PP <- aggregate(P$coli1 ~ P$Accession + P$ConcGr, FUN=sum)

  names(PP) <- c('Accession', 'ConcGr', 'coli1_sum')
  PPP <- aggregate(PP$coli1_sum ~ PP$ConcGr, FUN=mean)

  P.mean <- aggregate(PP$coli1_sum ~ PP$ConcGr, FUN=mean)
  P.sd <- aggregate(PP$coli1_sum ~ PP$ConcGr, FUN=sd)
  P.cv <- aggregate(PP$coli1_sum ~ PP$ConcGr,
      FUN = function(x){ 100 * sd(x) / mean(x) })
  P.length <- max(aggregate(P$coli1 ~ P$Accession, FUN=length)[,2])

 rv <- data.frame(ConcGr=P.sd[,1],
                  mean=P.mean[,2],
                  sd=P.sd[,2],
                  cv=round(P.cv[,2],2))
 rv$nFCAccession <-  P.length
 rv
}
```

## 3.2 Camera ready absolute table

```
kable(FlycodeAbsoluteStatistics(P))
```

| ConcGr | mean | sd | cv | nFCAccession |
| --- | --- | --- | --- | --- |
| 92 | 4480417 | 811894.8 | 18.12 | 30 |
| 295 | 19535522 | 3685706.9 | 18.87 | 30 |
| 943 | 56994519 | 6440051.4 | 11.30 | 30 |
| 3017 | 175196618 | 12124519.7 | 6.92 | 30 |

## 3.3 Define `FCrandom`

```
# TODO(cp); make it work for n = 0
FCrandom <- function(P, n = 1){
  if(n == 0){
    return (P)
  }
  for (i in unique(P$Accession)){
    idx <- which(P$Accession == i)
    stopifnot(length(idx) >= n)
    smp <- sample(length(idx), n)
    P <- P[-idx[smp],]
  }
  P$n <- n
  P
}
```

## 3.4 Conduct the random experiment

```
set.seed(8)
S <- do.call('rbind', lapply(1:29, function(i){
  FlycodeAbsoluteStatistics(FCrandom(P, i))
  }))
```

```
xyplot(cv ~ nFCAccession | ConcGr,
       data = S,
       layout = c(4, 1),
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE)
       )
```

![](data:image/png;base64...)

```
set.seed(1)

S.rep <- do.call('rbind',
    lapply(1:n.simulation, function(s){
       S <- do.call('rbind',
           lapply(1:29, function(i){
                FlycodeAbsoluteStatistics(FCrandom(P, i))
             }))
       }))
```

## 3.5 Camera ready plot of absolute flycode simulation

```
NestLink_absolute_flycode_simulation <- xyplot(cv ~ nFCAccession |  ConcGr,
       data = S.rep,
       panel = function(x,y,...){
         panel.abline(h=c(10, 50), col='red')
         panel.xyplot(x, y, ...)
         xy.median <- (aggregate(y, by=list(x), FUN=median, na.rm = TRUE))
         xy.quantile <- aggregate(y, by=list(x), FUN=function(d){quantile(d, c(0.05, 0.5, 0.95), na.rm = TRUE)})
         panel.points( xy.median[,1], xy.median[,2], pch=16, cex=0.5)
         # print((xy.quantile[,2])[,3])
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,1], pch='-')
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,3], pch='-')
       },
       xlab= 'Number of flycodes',
       ylab ='CV [%]',
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       scales=list(x=list(at=c(1,5,10,15,20,25,30)),
                   y=list(at=c(0,10,50,100,150,200))),
       ylim=c(0,175),

       pch=16,
       col=rgb(0.5, 0.5, 0.5, alpha = 0.01),
       layout = c(4,1))

print(NestLink_absolute_flycode_simulation)
```

![](data:image/png;base64...)

```
# png("NestLink_absolute_flycode_simulation.png", 1200,800)
# print(NestLink_absolute_flycode_simulation)
# dev.off()
```

# 4 Relative Quantification

## 4.1 Normalization

```
P <- na.omit(P)
P <- P[P$coli1 >0,]

P$coli1 <- P$coli1 / sum(P$coli1)
P$coli2 <- P$coli2 / sum(P$coli2)
P$smeg1 <- P$smeg1 / sum(P$smeg1)
P$smeg2 <- P$smeg2 / sum(P$smeg2)
```

sanity check

```
sum(P$coli1)
```

```
## [1] 1
```

```
sum(P$coli2)
```

```
## [1] 1
```

```
sum(P$smeg1)
```

```
## [1] 1
```

```
sum(P$smeg2)
```

```
## [1] 1
```

## 4.2 Define ratios

```
P$ratios <- (0.5* (P$coli1 + P$coli2)) / (0.5 * (P$smeg1 + P$smeg2))
```

```
b <- boxplot(P$coli1 / P$coli2, P$coli1 / P$smeg1, P$coli1 / P$smeg2,P$coli2 / P$smeg1, P$coli2 / P$smeg2 , P$smeg1 / P$smeg2, P$ratios,
        ylab='ratios', ylim = c(0,2 ))
axis(1, 1:6, c('coli[12]', 'coli1-smeg1', 'coli1-smeg2', 'coli2-smeg1', 'coli2- smeg2','smeg[12]'))
```

![](data:image/png;base64...)

```
op <- par(mfrow = c(1, 4))
boxplot(P$coli1 ~ P$ConcGr)
boxplot(P$coli2 ~ P$ConcGr)
boxplot(P$smeg1 ~ P$ConcGr)
boxplot(P$smeg2 ~ P$ConcGr)
```

![](data:image/png;base64...)

## 4.3 Determine outliers (removal)

```
op <- par(mfrow=c(1,1), mar=c(5,5,5,2) )

b <- boxplot(df<-cbind(P$coli1/P$coli2, P$coli1/P$smeg1, P$coli1/P$smeg2, P$coli2/P$smeg1, P$coli2/P$smeg2, P$smeg1/P$smeg2, P$ratios),
             log='y',
        ylab='normalized ratios',
        #ylim = c(0, 2),
        axes=FALSE,
        main=paste("ConcGr = all"))
axis(1, 1:7, c('coli[12]', 'coli1-smeg1', 'coli1-smeg2', 'coli2-smeg1', 'coli2- smeg2','smeg[12]', 'ratio'))
abline(h=1, col='red')
box()
axis(2)
#axis(3, 1:7, b$n)
outliers.idx <- sapply(1:length(b$group),
    function(i){
      q <- df[, b$group[i]] == b$out[i];
      text(b$group[i], b$out[i], P[q, 2], pos=4, cex=0.4);
      text(b$group[i], b$out[i], P[q, 1], pos=2, cex=0.4);
      which(q)})
```

![](data:image/png;base64...)

```
b <- boxplot(df<-cbind(P$coli1/P$coli2, P$coli1/P$smeg1, P$coli1/P$smeg2, P$coli2/P$smeg1, P$coli2/P$smeg2, P$smeg1/P$smeg2, P$ratio),
             log='',
        ylab='normalized ratios',
        ylim = c(0, 2),
        axes=FALSE,
        main=paste("ConcGr = all"))
axis(1, 1:7, c('coli[12]', 'coli1-smeg1', 'coli1-smeg2', 'coli2-smeg1', 'coli2- smeg2','smeg[12]', 'ratio'))
abline(h=1, col='red')
box()
axis(2)
axis(3, 1:length(b$n), b$n)
outliers.idx <- sapply(1:length(b$group),
    function(i){
      q <- df[, b$group[i]] == b$out[i];
      text(b$group[i], b$out[i], P[q, 2], pos=4, cex=0.4);
      text(b$group[i], b$out[i], P[q, 1], pos=2, cex=0.4);
      which(q)})
```

![](data:image/png;base64...)

```
kable(P[unique(outliers.idx),])
```

|  | Accession | Sequence | coli1 | coli2 | smeg1 | smeg2 | ConcGr | ratios |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 38 | P1H6 | GSSEDDAEGWLR | 0.0000121 | 0.0000003 | 0.0000001 | 0.0000003 | 3017 | 31.1061717 |
| 61 | P1F6 | GSPAADDVSWQSR | 0.0000135 | 0.0000090 | 0.0000103 | 0.0000099 | 3017 | 1.1148184 |
| 69 | P1F6 | GSGTAEESYWQEGGR | 0.0000287 | 0.0000086 | 0.0000209 | 0.0000089 | 3017 | 1.2538971 |
| 105 | P1C6 | GSNDPEVDGWLTVR | 0.0000133 | 0.0000093 | 0.0000168 | 0.0000153 | 3017 | 0.7040914 |
| 115 | P1D6 | GSELAPSVGWQEGGR | 0.0000604 | 0.0000103 | 0.0000095 | 0.0000101 | 3017 | 3.6002928 |
| 117 | P1D6 | GSAAVAPNVWR | 0.0000051 | 0.0000007 | 0.0000020 | 0.0000013 | 3017 | 1.7807121 |
| 119 | P1D6 | GSDTTSVDTWQEGGR | 0.0000311 | 0.0000110 | 0.0000386 | 0.0000396 | 3017 | 0.5385343 |
| 126 | P1D6 | GSVSTYDPVWR | 0.0062807 | 0.0049329 | 0.0053530 | 0.0057151 | 3017 | 1.0131416 |
| 169 | P1G6 | GSEPVADADWQSR | 0.0000282 | 0.0000066 | 0.0000275 | 0.0000121 | 3017 | 0.8813330 |
| 216 | P1A6 | GSANTVEPGWQSR | 0.0000027 | 0.0000019 | 0.0000096 | 0.0000103 | 943 | 0.2370577 |
| 270 | P1G5 | GSPPDVFSTWQEGGR | 0.0000212 | 0.0000015 | 0.0000046 | 0.0000041 | 943 | 2.6019477 |
| 303 | P1H4 | GSDGAVADSWLTVR | 0.0003608 | 0.0002935 | 0.0003736 | 0.0003876 | 295 | 0.8596582 |
| 307 | P1H4 | GSEAVVTVDWLR | 0.0000450 | 0.0000649 | 0.0000700 | 0.0000755 | 295 | 0.7553914 |
| 347 | P1G4 | GSETTYYVDWQSR | 0.0002854 | 0.0002333 | 0.0002281 | 0.0002364 | 295 | 1.1168094 |
| 348 | P1G4 | GSAVWEPDYWLR | 0.0000360 | 0.0000473 | 0.0002191 | 0.0002166 | 295 | 0.1911726 |
| 349 | P1G4 | GSPDLADDVWLTVR | 0.0002689 | 0.0001850 | 0.0002258 | 0.0001999 | 295 | 1.0662495 |
| 352 | P1G4 | GSQENGGADWQSR | 0.0000062 | 0.0000156 | 0.0000256 | 0.0000313 | 295 | 0.3831785 |
| 355 | P1H5 | GSSVGQAVEWQEGGR | 0.0000634 | 0.0000139 | 0.0000543 | 0.0000162 | 943 | 1.0965878 |
| 452 | P1D5 | GSDEPAYAVWLR | 0.0000139 | 0.0000110 | 0.0000139 | 0.0000136 | 295 | 0.9059102 |
| 468 | P1C4 | GSADVTVGLWR | 0.0000098 | 0.0000079 | 0.0000099 | 0.0000097 | 92 | 0.9012831 |
| 508 | P1B4 | GSVVTVGETWQSR | 0.0001717 | 0.0001229 | 0.0001143 | 0.0001188 | 92 | 1.2636110 |
| 511 | P1B4 | GSVAAVVPDWR | 0.0000332 | 0.0000252 | 0.0000361 | 0.0000342 | 92 | 0.8299291 |
| 527 | P1E4 | GSDTEADPEWLTVR | 0.0001087 | 0.0000872 | 0.0001407 | 0.0001372 | 92 | 0.7051292 |
| 551 | P1F4 | GSVEGDVETWLTVR | 0.0000389 | 0.0000587 | 0.0000522 | 0.0000428 | 92 | 1.0273511 |
| 23 | P1E6 | GSEVVPDTVWR | 0.0011784 | 0.0010995 | 0.0005598 | 0.0005781 | 3017 | 2.0017582 |
| 28 | P1E6 | GSTEVAEVAWLR | 0.0002027 | 0.0001978 | 0.0001375 | 0.0001396 | 3017 | 1.4453411 |
| 29 | P1E6 | GSTDEAAFAWQSR | 0.0000664 | 0.0000622 | 0.0000367 | 0.0000401 | 3017 | 1.6748641 |
| 30 | P1E6 | GSWYEVDGTWLTVR | 0.0000208 | 0.0000258 | 0.0001270 | 0.0001108 | 3017 | 0.1960714 |
| 56 | P1H6 | GSVEYTTAAWR | 0.0000943 | 0.0000880 | 0.0000622 | 0.0000537 | 3017 | 1.5729054 |
| 83 | P1F6 | GSPWEGEAAWQSR | 0.0002075 | 0.0001782 | 0.0001289 | 0.0001387 | 3017 | 1.4418672 |
| 111 | P1C6 | GSGEPSAYSWR | 0.0001660 | 0.0001797 | 0.0000974 | 0.0000950 | 3017 | 1.7973706 |
| 112 | P1C6 | GSEVTEEVVWQSR | 0.0004082 | 0.0003699 | 0.0002116 | 0.0001778 | 3017 | 1.9980931 |
| 163 | P1E5 | GSVWDGSVDWLR | 0.0003851 | 0.0003446 | 0.0008695 | 0.0007912 | 943 | 0.4394173 |
| 166 | P1E5 | GSTAATEAAWLR | 0.0000796 | 0.0000764 | 0.0000434 | 0.0000487 | 943 | 1.6937723 |
| 236 | P1A6 | GSDPPAVVGWR | 0.0000216 | 0.0000268 | 0.0000141 | 0.0000164 | 943 | 1.5894671 |
| 255 | P1B6 | GSTDDTVTVWR | 0.0001116 | 0.0001050 | 0.0000642 | 0.0000718 | 943 | 1.5927951 |
| 256 | P1B6 | GSTTPPLLVWQEGGR | 0.0002999 | 0.0002926 | 0.0001905 | 0.0001922 | 943 | 1.5481110 |
| 259 | P1B6 | GSVAATEELWLTVR | 0.0000609 | 0.0000537 | 0.0000328 | 0.0000276 | 943 | 1.8979393 |
| 285 | P1G5 | GSFFSYQGDWLR | 0.0000119 | 0.0000127 | 0.0000717 | 0.0000768 | 943 | 0.1652766 |
| 371 | P1H5 | GSYTDALEVWLR | 0.0000306 | 0.0000357 | 0.0002221 | 0.0002426 | 943 | 0.1427107 |
| 374 | P1H5 | GSFVGGGGWWR | 0.0000264 | 0.0000315 | 0.0000589 | 0.0000574 | 943 | 0.4976272 |
| 397 | P1B5 | GSEDDGDVGWQEGGR | 0.0000121 | 0.0000131 | 0.0000343 | 0.0000351 | 295 | 0.3621272 |
| 451 | P1D5 | GSVTETASTWQEGGR | 0.0000333 | 0.0000292 | 0.0000219 | 0.0000234 | 295 | 1.3821678 |
| 530 | P1E4 | GSWLATPDVWLR | 0.0000068 | 0.0000085 | 0.0000325 | 0.0000314 | 92 | 0.2390561 |
| 571 | P1A4 | GSPGTVWYDWR | 0.0000187 | 0.0000163 | 0.0000423 | 0.0000412 | 92 | 0.4179539 |
| 21 | P1E6 | GSSPVEDTSWLR | 0.0008161 | 0.0007886 | 0.0006707 | 0.0005384 | 3017 | 1.3272331 |
| 54 | P1H6 | GSAAPVSAVWQSR | 0.0002341 | 0.0002321 | 0.0001699 | 0.0001553 | 3017 | 1.4331093 |
| 95 | P1C6 | GSVDVGSAVWQSR | 0.0040710 | 0.0038983 | 0.0029346 | 0.0027473 | 3017 | 1.4025928 |
| 104 | P1C6 | GSVVASVEAWQSR | 0.0010448 | 0.0009853 | 0.0008741 | 0.0006633 | 3017 | 1.3204326 |
| 184 | P1G6 | GSSAEDYAVWQEGGR | 0.0024441 | 0.0023660 | 0.0018494 | 0.0016301 | 3017 | 1.3823930 |
| 467 | P1C4 | GSQSVDTTVWR | 0.0000086 | 0.0000094 | 0.0000082 | 0.0000058 | 92 | 1.2894310 |
| 572 | P1A4 | GSSTGTVTPWQSR | 0.0001916 | 0.0002032 | 0.0001307 | 0.0001230 | 92 | 1.5565379 |
| 213 | P1F5 | GSVETETAYWQEGGR | 0.0000315 | 0.0000338 | 0.0000247 | 0.0000222 | 943 | 1.3915324 |
| 8 | P1E6 | GSVSEGEDTWQEGGR | 0.0000133 | 0.0000128 | 0.0000119 | 0.0000152 | 3017 | 0.9595206 |
| 31 | P1H6 | GSVATDVPDWQEGGR | 0.0233676 | 0.0221316 | 0.0198411 | 0.0166058 | 3017 | 1.2483702 |
| 35 | P1H6 | GSPDTVEYDWQSR | 0.0129522 | 0.0136876 | 0.0123987 | 0.0101462 | 3017 | 1.1816328 |
| 39 | P1H6 | GSGTYVSDDWR | 0.0046986 | 0.0040630 | 0.0038690 | 0.0047031 | 3017 | 1.0221084 |
| 62 | P1F6 | GSPTGTDPVWLR | 0.0084956 | 0.0081820 | 0.0081703 | 0.0067783 | 3017 | 1.1156570 |
| 64 | P1F6 | GSVDAEPTVWQSR | 0.0070020 | 0.0071016 | 0.0060481 | 0.0052024 | 3017 | 1.2535815 |
| 113 | P1D6 | GSTAATELEWQEGGR | 0.0178374 | 0.0173241 | 0.0158409 | 0.0133260 | 3017 | 1.2055235 |
| 121 | P1D6 | GSYATGAEPWR | 0.0031632 | 0.0030784 | 0.0028792 | 0.0035680 | 3017 | 0.9681174 |
| 122 | P1D6 | GSPQLAPDGWR | 0.0000541 | 0.0000579 | 0.0000554 | 0.0000462 | 3017 | 1.1025485 |
| 208 | P1F5 | GSEVATTAVWQEGGR | 0.0005998 | 0.0005649 | 0.0005134 | 0.0004285 | 943 | 1.2364966 |
| 250 | P1B6 | GSAADDGYSWLR | 0.0007042 | 0.0006728 | 0.0006125 | 0.0004923 | 943 | 1.2463635 |
| 268 | P1G5 | GSASENDEDWLTVR | 0.0032788 | 0.0030958 | 0.0028999 | 0.0024500 | 943 | 1.1915266 |
| 292 | P1H4 | GSVVDGNVTWR | 0.0003710 | 0.0003775 | 0.0003789 | 0.0003051 | 295 | 1.0943579 |
| 329 | P1A5 | GSVATAYESWQSR | 0.0000360 | 0.0000295 | 0.0000406 | 0.0000304 | 295 | 0.9217020 |
| 342 | P1G4 | GSPDVVGTAWQEGGR | 0.0003646 | 0.0003627 | 0.0004204 | 0.0003465 | 295 | 0.9483575 |
| 382 | P1B5 | GSVEPEADVWR | 0.0004167 | 0.0004184 | 0.0004865 | 0.0004043 | 295 | 0.9374374 |
| 406 | P1C5 | GSAAVPGGVWQEGGR | 0.0012621 | 0.0012378 | 0.0012112 | 0.0010131 | 295 | 1.1239207 |
| 442 | P1D5 | GSETSGYDVWQSR | 0.0007695 | 0.0007892 | 0.0007024 | 0.0006113 | 295 | 1.1864482 |
| 453 | P1C4 | GSAVVPDADWQSR | 0.0005392 | 0.0005215 | 0.0004984 | 0.0003983 | 92 | 1.1829564 |

```
rv <-lapply(unique(P$ConcGr), function(q){
pairs((P[P$ConcGr == q ,c('coli1', 'coli2', 'smeg1', 'smeg2')]),
      pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.3),
      lower.panel = panel.cor,
      asp=1,
      main=q)
})
```

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
```

![](data:image/png;base64...)

```
bwplot(ratios ~ Accession | ConcGr,
       data = P,
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       panel = function(...){

         panel.abline(h=1, col='red')
         panel.bwplot(...)
       },
        ylim=c(-0,2),
       scales = list(x = list(relation = "free", rot=45)),
       layout = c(4,1))
```

![](data:image/png;base64...)

```
bwplot(ratios ~ ConcGr,
       data = P,
       horizontal = FALSE,
       panel = function(...){

         panel.abline(h=1, col='red')
         panel.bwplot(...)
       },
       ylim=c(0,2),
       scales = list(x = list(relation = "free", rot=45)),
       layout = c(1,1))
```

![](data:image/png;base64...)

```
boxplot(ratios ~ ConcGr,data=P,ylim=c(0,2))
abline(h=1, col=rgb(1,0,0,alpha=0.4))
```

![](data:image/png;base64...)

```
P<-na.omit(P)
xyplot(ratios ~ Accession |  ConcGr,
       data = P,
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       panel =function(x,y, ...){
         panel.abline(h=mean(y), col='red')
          panel.xyplot(x,y, pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.5))
          xy.mean <- (aggregate(y, by=list(x), FUN=mean, na.rm = TRUE))
           xy.sd <- (aggregate(y, by=list(x), FUN=sd, na.rm = TRUE))
          panel.points( xy.mean[,1], xy.mean[,2])
          panel.points( xy.mean[,1], xy.mean[,2] + xy.sd[,2] , pch='-', col='red', cex=4)
           panel.points( xy.mean[,1], xy.mean[,2] - xy.sd[,2] , pch='-', col='red', cex=4)},
        ylim=c(0,2),
       scales = list(x = list(relation = "free", rot=45)),
       layout = c(4,1))
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

![](data:image/png;base64...)

```
P <- na.omit(P)
xyplot(ratios ~ Accession |  ConcGr,
       data = P,
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       panel = function(x,y, ...){
         panel.abline(h=mean(y), col='red')
          panel.xyplot(x,y, pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.5))
          xy.mean <- (aggregate(y, by=list(x), FUN=mean, na.rm = TRUE))
           xy.sd <- (aggregate(y, by=list(x), FUN=sd, na.rm = TRUE))
          panel.points( xy.mean[,1], xy.mean[,2])
          panel.points( xy.mean[,1], xy.mean[,2] + xy.sd[,2] , pch='-', col='red', cex=4)
           panel.points( xy.mean[,1], xy.mean[,2] - xy.sd[,2] , pch='-', col='red', cex=4)
           ltext(xy.mean[,1], (xy.mean[,2] + xy.sd[,2]) , round(xy.sd[,2],2), pos=3, cex=0.5)
           },

       layout = c(4,1),
       scales = list(y=list(log=TRUE),
                     x = list(relation = "free", rot=45)),
       )
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in order(as.numeric(x)): NAs introduced by coercion
```

```
## Warning in diff(as.numeric(x[ord])): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

```
## Warning in panel.xyplot(x, y, pch = 16, col = rgb(0.5, 0.5, 0.5, alpha = 0.5)):
## NAs introduced by coercion
```

```
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
## Warning in xy.coords(x, y, recycle = TRUE): NAs introduced by coercion
```

![](data:image/png;base64...)
## Detect outlier

```
# P.cv <- aggregate(P$ratios ~ P$Accession, FUN=function(x){100*sd(x)/mean(x)})
```

```
P<-na.omit(P)
trellis.par.set("strip.background",t)

xyplot(ratios ~ ConcGr | ConcGr,
       data = P,
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       panel = function(x,y){
         panel.abline(h=1, col='red')
          panel.xyplot(x,y, pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.5))
          panel.points(x, mean(y))
         #   panel.points(x, median(y),col='green')
          panel.points(x, mean(y) + sd(y), pch='-', col='red',cex=5)
          ltext(x, mean(y) + sd(y), round(sd(y),3), pos=4)

           panel.points(x, mean(y) - sd(y), pch='-', col='red',cex=5)
         },
        #ylim=c(-1,3),
       scales = list(x = list(relation = "free", rot=45)),
       layout = c(4,1))
```

![measured ratios were plotted; red represents the sd and blue points the mean.](data:image/png;base64...)

Figure 1: measured ratios were plotted; red represents the sd and blue points the mean

```
outlier.idx <- which(P$ratios > 2)
P[outlier.idx, ]
```

```
##     Accession        Sequence        coli1        coli2        smeg1
## 23       P1E6     GSEVVPDTVWR 1.178365e-03 1.099467e-03 5.598233e-04
## 38       P1H6    GSSEDDAEGWLR 1.210304e-05 3.215364e-07 1.065422e-07
## 115      P1D6 GSELAPSVGWQEGGR 6.038516e-05 1.025768e-05 9.528549e-06
## 270      P1G5 GSPPDVFSTWQEGGR 2.117599e-05 1.510987e-06 4.601046e-06
##            smeg2 ConcGr    ratios
## 23  5.780923e-04   3017  2.001758
## 38  2.928825e-07   3017 31.106172
## 115 1.009287e-05   3017  3.600293
## 270 4.118184e-06    943  2.601948
```

```
# We do not remove outliers.
# P <- P[-outlier.idx,]
```

```
P<-na.omit(P)
trellis.par.set("strip.background",t)

xyplot(ratios ~ ConcGr | ConcGr,
       data = P,
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       panel = function(x,y){
         panel.abline(h=1, col='red')
          panel.xyplot(x,y, pch=16, col=rgb(0.5,0.5,0.5,alpha = 0.5))
          panel.points(x, mean(y))
         #   panel.points(x, median(y),col='green')
          panel.points(x, mean(y) + sd(y), pch='-', col='red',cex=5)
          ltext(x, mean(y) + sd(y), round(sd(y),3), pos=4)

           panel.points(x, mean(y) - sd(y), pch='-', col='red',cex=5)
         },
        #ylim=c(-1,3),
       scales = list(x = list(relation = "free", rot=45)),
       layout = c(4,1))
```

![measured ratios were plotted; red represents the sd and blue points the mean.](data:image/png;base64...)

Figure 2: measured ratios were plotted; red represents the sd and blue points the mean

## 4.4 Define function `FlycodeRelativeStatistics`

to make the random experiment fair!

```
P <- FCfill2max(P)
```

```
FlycodeRelativeStatistics <- function(X, mode='bio'){
   nFlycodesConcGr <- aggregate(X$Sequence ~ X$ConcGr, FUN=length)
  names(nFlycodesConcGr) <- c('ConcGr', 'nFlycodesConcGr')
  nFlycodesAccession.max <- max(aggregate(X$Sequence ~ X$Accession, FUN=length)[,2])

  P.sum.coli1 <- aggregate(X$coli1 ~ X$Accession + X$ConcGr, FUN=sum)
  P.sum.coli2 <- aggregate(X$coli2 ~ X$Accession + X$ConcGr, FUN=sum)[,3]
  P.sum.smeg1 <- aggregate(X$smeg1 ~ X$Accession + X$ConcGr, FUN=sum)[,3]
  P.sum.smeg2 <- aggregate(X$smeg2 ~ X$Accession + X$ConcGr, FUN=sum)[,3]

  X <- P.sum.coli1
  names(X) <- c('Accession', 'ConcGr', 'coli1')

  X$coli2 <- P.sum.coli2
  X$smeg1 <- P.sum.smeg1
  X$smeg2 <- P.sum.smeg2

  if(!"ratios" %in% names(X)){
    if (mode == 'tech_smeg'){
      X$ratios <- X$smeg1 / X$smeg2
    }
    else if(mode == 'tech_coli'){
      X$ratios <- X$coli1 / X$coli2
    }else{
      # bio
      X$ratios <- ((0.5 * (X$coli1 + X$coli2)) / (0.5 * (X$smeg1 + X$smeg2)))
    }
    #warning("define ratios.")
  }

  #nFlycodesConcGr <- aggregate(X$Sequence ~ X$ConcGr, FUN=length)
  #names(nFlycodesConcGr) <- c('ConcGr', 'nFlycodesConcGr')
  X <- na.omit(X)

  P.mean <- aggregate(X$ratios ~ X$ConcGr, FUN=mean)
  names(P.mean) <- c('ConcGr', 'mean')

  P.median <- aggregate(X$ratios ~ X$ConcGr, FUN=median)
  names(P.median) <- c('ConcGr', 'median')

  P.sd <- aggregate(X$ratios ~ X$ConcGr, FUN=sd)
  names(P.sd) <- c('ConcGr', 'sd')

 rv <- data.frame(ConcGr=P.mean$ConcGr,
                  median=P.median$median,
                  mean=P.mean$mean,
                  sd=P.sd$sd)
         #         nFlycodesConcGr=nFlycodesConcGr[,2])

 rv$cv <- 100 * rv$sd / rv$mean
 rv$length <- nFlycodesAccession.max
 rv
}
```

## 4.5 Conduct the random experiment

```
message(paste("Number of simulations =", n.simulation))
```

```
## Number of simulations = 10
```

```
set.seed(1)

P.replicate <- do.call('rbind',
  lapply(1:n.simulation,
    function(run){
      do.call('rbind', lapply(1:29,
        function(i) {
          rv <- FlycodeRelativeStatistics(FCrandom(P, i))
                                                   rv$run = run
                                                   rv
                                                 }))
                       }))
```

```
set.seed(1)

P.replicate.smeg <- do.call('rbind',
                       lapply(1:n.simulation/2, function(run){
                         do.call('rbind', lapply(1:29,
                                                 function(i) {
                                                   rv <- FlycodeRelativeStatistics(FCrandom(P, i), mode='tech_smeg')
                                                   rv$run = run
                                                   rv
                                                 }))
                       }))
```

```
set.seed(1)

P.replicate.coli <- do.call('rbind',
                       lapply(1:n.simulation/2, function(run){
                         do.call('rbind', lapply(1:29,
                                                 function(i) {
                                                   rv <- FlycodeRelativeStatistics(FCrandom(P, i), mode='tech_coli')
                                                   rv$run = run
                                                   rv
                                                 }))
                       }))
```

```
xyplot(mean ~  length | ConcGr,
       data=P.replicate,
       panel = function(...){
         panel.abline(h=1, col='red')
         panel.xyplot(...)
       },
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       ylim=c(0,2),
       pch=16, col=rgb(0.5, 0.5, 0.5, alpha = 0.1),
       layout = c(4,1),
       xlab= 'number of FlyCodes',
       )
```

![the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes.](data:image/png;base64...)

Figure 3: the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes

```
xyplot(sd ~  length | ConcGr,
       data=P.replicate,
       panel = function(...){
         panel.xyplot(...)
       },
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       pch=16, col=rgb(0.5, 0.5, 0.5, alpha = 0.1),
       layout = c(4,1),
       xlab= 'number of FlyCodes',
       )
```

![the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes.](data:image/png;base64...)

Figure 4: the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes

```
xyplot(cv ~  length | ConcGr,
       data=P.replicate,
       panel = function(...){
         panel.xyplot(...)
       },
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       pch=16, col=rgb(0.5, 0.5, 0.5, alpha = 0.01),
       layout = c(4,1),
       xlab= 'number of FlyCodes',
       ylab ='cv [in %]'
       )
```

![the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes.](data:image/png;base64...)

Figure 5: the grey point cloud represents the means, sd, and cv of `n.simulation` conducted random experiments (removals) with a different number of FlyCodes

## 4.6 Camera ready plot of relative flycode simulation

```
SIM <- P.replicate
SIM$Type <- "Biological replicates"
P.replicate.coli$Type <- "Technical replicates"
P.replicate.smeg$Type <- "Technical replicates"

NestLink_relative_flycode_simulation <- xyplot(cv ~ length | ConcGr,
       index.cond=list(c(1,2,3,4)),
       data=do.call('rbind', list(SIM, P.replicate.coli, P.replicate.smeg)),
       subset = Type == "Biological replicates",
       panel = function(x,y,...){
         panel.abline(h=10, col='red')
         panel.xyplot(x, y, ...)
         xy.median <- (aggregate(y, by=list(x), FUN=median, na.rm = TRUE))
         xy.quantile <- aggregate(y, by=list(x), FUN=function(d){quantile(d, c(0.05, 0.5, 0.95), na.rm = TRUE)})
         panel.points( xy.median[,1], xy.median[,2], pch=16, cex=0.5)
         # print((xy.quantile[,2])[,3])
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,1], pch='-')
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,3], pch='-')
       },
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       scales=list(x=list(at=c(1,5,10,15,20,25,30)),
                   y=list(at=c(0, 10,20,30,40,50))),
       pch=16,
       col=rgb(0.5, 0.5, 0.5, alpha = 0.01),
       layout = c(4, 1),
       ylim = c(0, 50),
       xlab= 'Number of flycodes',
       ylab ='CV [%]'
       )

print(NestLink_relative_flycode_simulation)
```

![](data:image/png;base64...)

```
NestLink_relative_flycode_simulation <- xyplot(cv ~ length | ConcGr,
       index.cond=list(c(1,2,3,4)),
       data=do.call('rbind', list(SIM, P.replicate.coli, P.replicate.smeg)),
       subset = Type == "Technical replicates",
       panel = function(x,y,...){
         panel.abline(h=10, col='red')
         panel.xyplot(x, y, ...)
         xy.median <- (aggregate(y, by=list(x), FUN=median, na.rm = TRUE))
         xy.quantile <- aggregate(y, by=list(x), FUN=function(d){quantile(d, c(0.05, 0.5, 0.95), na.rm = TRUE)})
         panel.points( xy.median[,1], xy.median[,2], pch=16, cex=0.5)
         # print((xy.quantile[,2])[,3])
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,1], pch='-')
         panel.points( xy.quantile[,1],(xy.quantile[,2])[,3], pch='-')
       },
       strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
       scales=list(x=list(at=c(1,5,10,15,20,25,30)),
                   y=list(at=c(0, 10,20,30,40,50))),
       pch=16,
       col=rgb(0.5, 0.5, 0.5, alpha = 0.01),
       layout = c(4, 1),
       ylim = c(0, 50),
       xlab= 'Number of flycodes',
       ylab ='CV [%]'
       )

print(NestLink_relative_flycode_simulation)
```

![](data:image/png;base64...)

## 4.7 Camera ready relative table

`length` corresponds to the number accessions. `i` indicates the number of removed Flycodes in each accession group and can be ignored.

```
kable(FlycodeRelativeStatistics(P, mode = 'bio'))
```

| ConcGr | median | mean | sd | cv | length |
| --- | --- | --- | --- | --- | --- |
| 92 | 0.9294538 | 0.9284512 | 0.0519245 | 5.592595 | 30 |
| 295 | 0.8947774 | 0.8994735 | 0.0649453 | 7.220370 | 30 |
| 943 | 0.9614609 | 0.9711361 | 0.0481363 | 4.956702 | 30 |
| 3017 | 1.0179646 | 1.0278351 | 0.0444473 | 4.324363 | 30 |

```
kable(FlycodeRelativeStatistics(P, mode = 'tech_coli'))
```

| ConcGr | median | mean | sd | cv | length |
| --- | --- | --- | --- | --- | --- |
| 92 | 1.015500 | 1.0080013 | 0.0316037 | 3.135279 | 30 |
| 295 | 1.014147 | 1.0140046 | 0.0106994 | 1.055162 | 30 |
| 943 | 1.005331 | 1.0061221 | 0.0151953 | 1.510284 | 30 |
| 3017 | 0.994935 | 0.9967548 | 0.0210467 | 2.111524 | 30 |

```
kable(FlycodeRelativeStatistics(P, mode = 'tech_smeg'))
```

| ConcGr | median | mean | sd | cv | length |
| --- | --- | --- | --- | --- | --- |
| 92 | 0.9918049 | 0.9912911 | 0.0172931 | 1.7445066 | 30 |
| 295 | 0.9938872 | 0.9908330 | 0.0211242 | 2.1319627 | 30 |
| 943 | 0.9956908 | 0.9972972 | 0.0098568 | 0.9883481 | 30 |
| 3017 | 0.9928825 | 1.0032881 | 0.0263150 | 2.6228775 | 30 |

# 5 Session info

Here is the output of the `sessionInfo()` command.

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] lattice_0.22-7              specL_1.44.0
##  [3] seqinr_4.2-36               RSQLite_2.4.3
##  [5] DBI_1.2.3                   knitr_1.50
##  [7] scales_1.4.0                ggplot2_4.0.0
##  [9] NestLink_1.26.0             ShortRead_1.68.0
## [11] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           Rsamtools_2.26.0
## [17] GenomicRanges_1.62.0        BiocParallel_1.44.0
## [19] protViz_0.7.9               gplots_3.2.0
## [21] Biostrings_2.78.0           Seqinfo_1.0.0
## [23] XVector_0.50.0              IRanges_2.44.0
## [25] S4Vectors_0.48.0            ExperimentHub_3.0.0
## [27] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [29] dbplyr_2.5.1                BiocGenerics_0.56.0
## [31] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-9         deldir_2.0-4         httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       ade4_1.7-23
##  [7] compiler_4.5.1       mgcv_1.9-3           png_0.1-8
## [10] vctrs_0.6.5          pwalign_1.6.0        pkgconfig_2.0.3
## [13] crayon_1.5.3         fastmap_1.2.0        magick_2.9.0
## [16] labeling_0.4.3       caTools_1.18.3       rmarkdown_2.30
## [19] tinytex_0.57         purrr_1.1.0          bit_4.6.0
## [22] xfun_0.54            cachem_1.1.0         cigarillo_1.0.0
## [25] jsonlite_2.0.0       blob_1.2.4           DelayedArray_0.36.0
## [28] jpeg_0.1-11          R6_2.6.1             bslib_0.9.0
## [31] RColorBrewer_1.1-3   jquerylib_0.1.4      Rcpp_1.1.0
## [34] bookdown_0.45        splines_4.5.1        Matrix_1.7-4
## [37] tidyselect_1.2.1     dichromat_2.0-0.1    abind_1.4-8
## [40] yaml_2.3.10          codetools_0.2-20     hwriter_1.3.2.1
## [43] curl_7.0.0           tibble_3.3.0         withr_3.0.2
## [46] KEGGREST_1.50.0      S7_0.2.0             evaluate_1.0.5
## [49] pillar_1.11.1        BiocManager_1.30.26  filelock_1.0.3
## [52] KernSmooth_2.23-26   BiocVersion_3.22.0   gtools_3.9.5
## [55] glue_1.8.0           tools_4.5.1          interp_1.1-6
## [58] grid_4.5.1           latticeExtra_0.6-31  AnnotationDbi_1.72.0
## [61] nlme_3.1-168         cli_3.6.5            rappdirs_0.3.3
## [64] S4Arrays_1.10.0      dplyr_1.1.4          gtable_0.3.6
## [67] sass_0.4.10          digest_0.6.37        SparseArray_1.10.1
## [70] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [73] lifecycle_1.0.4      httr_1.4.7           MASS_7.3-65
## [76] bit64_4.6.0-1
```

# References

Egloff, Pascal, Iwan Zimmermann, Fabian M. Arnold, Cedric A. J. Hutter, Damien Damien Morger, Lennart Opitz, Lucy Poveda, et al. 2018. “Engineered Peptide Barcodes for In-Depth Analyses of Binding Protein Ensembles.” *bioRxiv*. <https://doi.org/10.1101/287813>.