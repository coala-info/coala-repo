# Code example from 'qsmooth' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----fig.cap="Figure 1", out.width = '100%'-----------------------------------
knitr::include_graphics("qsmooth_algo.jpg")

## ----load-lib, message=FALSE--------------------------------------------------
library(qsmooth)

## ----data-1, message=FALSE, warning=FALSE-------------------------------------
library(SummarizedExperiment)
library(bodymapRat)
bm_dat <- bodymapRat()

# select brain and liver samples, stage 21 weeks, and only bio reps
keepColumns = (colData(bm_dat)$organ %in% c("Brain", "Liver")) &
         (colData(bm_dat)$stage == 21) & (colData(bm_dat)$techRep == 1)
keepRows = rowMeans(assay(bm_dat)) > 10 # Filter out low counts
bm_dat_e1 <- bm_dat[keepRows,keepColumns]
bm_dat_e1

## ----calculate-qsmooth1, fig.height=10, fig.width=10--------------------------
library(quantro)

par(mfrow=c(2,2))
pd1 <- colData(bm_dat_e1)
counts1 <- assay(bm_dat_e1)[!grepl("^ERCC", 
                      rownames( assay(bm_dat_e1))), ]
pd1$group <- paste(pd1$organ, pd1$sex, sep="_")

matboxplot(log2(counts1+1), groupFactor = factor(pd1$organ),
           main = "Raw data", xaxt="n", 
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(as.character(pd1$organ))),
     labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2, 
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(counts1+1), groupFactor = pd1$organ, 
           main = "Raw data", ylab= "density",
           xlab = "Expression (log2 scale)")
legend('topright', levels(factor(pd1$organ)), 
       col = 1:2, lty = 1)

qs_norm_e1 <- qsmooth(object = counts1, group_factor = pd1$organ)
qs_norm_e1 

matboxplot(log2(qsmoothData(qs_norm_e1)+1), 
           groupFactor = pd1$organ, xaxt="n",
           main = "qsmooth normalized data", 
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(pd1$organ)), labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2, 
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(qsmoothData(qs_norm_e1)+1), groupFactor = pd1$organ,
           main = "qsmooth normalized data",
           xlab = "Expression (log2 scale)", ylab = "density")
legend('topright', levels(factor(pd1$organ)), col = 1:2, lty = 1)

## ----plot-qsmooth1-weights----------------------------------------------------
qsmoothPlotWeights(qs_norm_e1)

## -----------------------------------------------------------------------------
par(mfrow=c(2,2))
pd1 <- colData(bm_dat_e1)
counts1 <- assay(bm_dat_e1)[!grepl("^ERCC", 
                      rownames( assay(bm_dat_e1))), ]
pd1$group <- paste(pd1$organ, pd1$sex, sep="_")

matboxplot(log2(counts1+1), groupFactor = factor(pd1$organ),
           main = "Raw data", xaxt="n", 
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(as.character(pd1$organ))),
     labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2, 
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(counts1+1), groupFactor = pd1$organ, 
           main = "Raw data", ylab= "density",
           xlab = "Expression (log2 scale)")
legend('topright', levels(factor(pd1$organ)), 
       col = 1:2, lty = 1)

# retrieved GC-content using EDASeq:
# gc <- EDASeq::getGeneLengthAndGCContent(id = rownames(bm_dat_e1), 
#                                   org = "rno")
data(gc, package="qsmooth")

gcContent <- gc[rownames(counts1),2]
keep <- names(gcContent)[!is.na(gcContent)]
qs_norm_gc <- qsmoothGC(object = counts1[keep,], gc=gcContent[keep], 
                        group_factor = pd1$organ)
qs_norm_gc 

matboxplot(log2(qsmoothData(qs_norm_gc)+1), 
           groupFactor = pd1$organ, xaxt="n",
           main = "qsmoothGC normalized data", 
           ylab = "Expression (log2 scale)")
axis(1, at=seq_len(length(pd1$organ)), labels=FALSE)
text(seq_len(length(pd1$organ)), par("usr")[3] -2, 
     labels = pd1$organ, srt = 90, pos = 1, xpd = TRUE)

matdensity(log2(qsmoothData(qs_norm_gc)+1), groupFactor = pd1$organ,
           main = "qsmoothGC normalized data",
           xlab = "Expression (log2 scale)", ylab = "density")
legend('topright', levels(factor(pd1$organ)), col = 1:2, lty = 1)

## ----session-info-------------------------------------------------------------
sessionInfo()

