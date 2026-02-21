# Code example from 'Anaquin' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library('Anaquin')
data("RnaQuinIsoformMixture")
head(RnaQuinIsoformMixture)

## -----------------------------------------------------------------------------
set.seed(1234)
sim1 <- 1.0 + 1.2*log2(RnaQuinIsoformMixture$MixA) + rnorm(nrow(RnaQuinIsoformMixture),0,1)
sim2 <- c(1.0 + rnorm(100,1,3), 1.0 +
          1.2*log2(tail(RnaQuinIsoformMixture,64)$MixA) +
          rnorm(64,0,1))

## ----message=FALSE, results='hide', fig.align='center'------------------------
names <- row.names(RnaQuinIsoformMixture)
input <- log2(RnaQuinIsoformMixture$MixA)

title <- 'Isoform expression (Good)'
xlab  <- 'Input concentration (log2)'
ylab  <- 'Measured FPKM (log2)'

plotLinear(names, input, sim1, title=title, xlab=xlab, ylab=ylab)

## ----message=FALSE, results='hide', fig.align='center'------------------------
names <- row.names(RnaQuinIsoformMixture)
input <- log2(RnaQuinIsoformMixture$MixA)

title <- 'Isoform expression (Bad)'
xlab  <- 'Input concentration (log2)'
ylab  <- 'Measured FPKM (log2)'

plotLinear(names, input, sim2, title=title, xlab=xlab, ylab=ylab)

## -----------------------------------------------------------------------------
data(UserGuideData_5.4.5.1)
head(UserGuideData_5.4.5.1)

## ----message=FALSE, results='hide', fig.align='center'------------------------
title <- 'Assembly Plot'
xlab  <- 'Input Concentration (log2)'
ylab  <- 'Sensitivity'

# Sequin names
names <- row.names(UserGuideData_5.4.5.1)

# Input concentration
x <- log2(UserGuideData_5.4.5.1$Input)

# Measured sensitivity
y <- UserGuideData_5.4.5.1$Sn

plotLogistic(names, x, y, title=title, xlab=xlab, ylab=ylab, showLOA=TRUE)

## -----------------------------------------------------------------------------
data(UserGuideData_5.4.6.3)
head(UserGuideData_5.4.6.3)

## ----message=FALSE, results='hide', fig.align='center'------------------------
title <- 'Gene Expression'
xlab  <- 'Input Concentration (log2)'
ylab  <- 'FPKM (log2)'

# Sequin names
names <- row.names(UserGuideData_5.4.6.3)

# Input concentration
x <- log2(UserGuideData_5.4.6.3$Input)

# Measured FPKM
y <- log2(UserGuideData_5.4.6.3$Observed1)

plotLinear(names, x, y, title=title, xlab=xlab, ylab=ylab, showLOQ=TRUE)

## ----message=FALSE, results='hide', fig.align='center'------------------------
title <- 'Gene Expression'
xlab  <- 'Input Concentration (log2)'
ylab  <- 'FPKM (log2)'

# Sequin names
names <- row.names(UserGuideData_5.4.6.3)

# Input concentration
x <- log2(UserGuideData_5.4.6.3$Input)

# Measured FPKM
y <- log2(UserGuideData_5.4.6.3[,2:4])

plotLinear(names, x, y, title=title, xlab=xlab, ylab=ylab, showLOQ=TRUE)

## -----------------------------------------------------------------------------
data(UserGuideData_5.6.3)
head(UserGuideData_5.6.3)

## ----results='hide', results='hide', fig.align='center'-----------------------
title <- 'Gene Fold Change'
xlab  <- 'Expected fold change (log2)'
ylab  <- 'Measured fold change (log2)'

# Sequin names
names <- row.names(UserGuideData_5.6.3)

# Expected log-fold
x <- UserGuideData_5.6.3$ExpLFC

# Measured log-fold
y <- UserGuideData_5.6.3$ObsLFC

plotLinear(names, x, y, title=title, xlab=xlab, ylab=ylab, showAxis=TRUE,
           showLOQ=FALSE)

## ----results='hide', fig.align='center'---------------------------------------
title <- 'ROC Plot'

# Sequin names
seqs <- row.names(UserGuideData_5.6.3)

# Expected ratio
ratio <- UserGuideData_5.6.3$ExpLFC

# How the ROC points are ranked (scoring function)
score <- 1-UserGuideData_5.6.3$Pval

# Classified labels (TP/FP)
label <- UserGuideData_5.6.3$Label

plotROC(seqs, score, ratio, label, title=title, refGroup=0)

## ----fig.align='center', results='hide', warning=FALSE------------------------
xlab  <- 'Average Counts'
ylab  <- 'P-value'
title <- 'LOD Curves'

# Measured mean
mean <- UserGuideData_5.6.3$Mean

# Expected log-fold
ratio <- UserGuideData_5.6.3$ExpLFC

# P-value
pval <- UserGuideData_5.6.3$Pval

qval <- UserGuideData_5.6.3$Qval

plotLOD(mean, pval, abs(ratio), qval=qval, xlab=xlab, ylab=ylab, title=title, FDR=0.05)

