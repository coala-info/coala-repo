# Code example from 'swish' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE, dev="png",
                      message=FALSE, error=FALSE, warning=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # 'coldata.csv': sample information table
# coldata <- read.csv("coldata.csv")
# library(tximeta)
# y <- tximeta(coldata) # reads in counts and inf reps
# library(fishpond)
# y <- scaleInfReps(y) # scales counts
# y <- labelKeep(y) # labels features to keep
# set.seed(1)
# y <- swish(y, x="condition") # simplest Swish case

## ----eval=FALSE---------------------------------------------------------------
# table(mcols(y)$qvalue < .05)

## ----eval=FALSE---------------------------------------------------------------
# y <- y[mcols(y)$keep,]

## -----------------------------------------------------------------------------
library(macrophage)
dir <- system.file("extdata", package="macrophage")

## -----------------------------------------------------------------------------
coldata <- read.csv(file.path(dir, "coldata.csv"))
head(coldata)

## -----------------------------------------------------------------------------
coldata <- coldata[,c(1,2,3,5)]
names(coldata) <- c("names","id","line","condition")

## -----------------------------------------------------------------------------
coldata$files <- file.path(dir, "quants", coldata$names, "quant.sf.gz")
all(file.exists(coldata$files))

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))

## ----include=FALSE------------------------------------------------------------
# This hidden code chunk is only needed for Bioc build machines,
# so that 'fishpond' will build regardless of whether
# the machine can connect to ftp.ebi.ac.uk.
# Using linkedTxomes to point to a GTF that lives in the macrophage pkg.
# The chunk can be skipped if you have internet connection,
# as tximeta will automatically ID the transcriptome and DL the GTF.
library(tximeta)
makeLinkedTxome(
  indexDir=file.path(dir, "gencode.v29_salmon_0.12.0"),
  source="myGENCODE",
  organism="Homo sapiens",
  release="29",
  genome="GRCh38",
  fasta="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_29/gencode.v29.transcripts.fa.gz",
  gtf=file.path(dir, "gencode.v29.annotation.gtf.gz"), # local version
  write=FALSE
)
# 'myGENCODE' is used to avoid tximeta() attempting to
# pull down the TxDb from AnnotationHub, alterantively
# once can specify useHub=FALSE.

## -----------------------------------------------------------------------------
coldata <- coldata[coldata$condition %in% c("naive","IFNg"),]
coldata$condition <- factor(coldata$condition, 
                            levels=c("naive","IFNg"))

## -----------------------------------------------------------------------------
library(tximeta)
se <- tximeta(coldata)

## -----------------------------------------------------------------------------
assayNames(se)

## -----------------------------------------------------------------------------
head(rownames(se))

## ----include=FALSE------------------------------------------------------------
# hidden chunk to trick tximeta into knowing this is GENCODE,
# this is only needed because above we labelled the txome myGENCODE
metadata(se)$txomeInfo$source <- "GENCODE"

## -----------------------------------------------------------------------------
y <- se
y <- y[seqnames(y) == "chr4",]

## ----results="hide", message=FALSE--------------------------------------------
library(fishpond)
y <- scaleInfReps(y)
y <- labelKeep(y)
y <- y[mcols(y)$keep,]
set.seed(1)
y <- swish(y, x="condition", pair="line")

## -----------------------------------------------------------------------------
y_fast <- swish(y, x="condition", pair="line", fast=1)
table(original=mcols(y)$qvalue < .1,
      fast=mcols(y_fast)$qvalue < .1)

## -----------------------------------------------------------------------------
table(mcols(y)$qvalue < .05)

## -----------------------------------------------------------------------------
most.sig <- with(mcols(y),
                 order(qvalue, -abs(log2FC)))
mcols(y)[head(most.sig),c("log2FC","qvalue")]

## -----------------------------------------------------------------------------
hist(mcols(y)$pvalue, col="grey")

## -----------------------------------------------------------------------------
with(mcols(y),
     table(sig=qvalue < .05, sign.lfc=sign(log2FC))
     )
sig <- mcols(y)$qvalue < .05
lo <- order(mcols(y)$log2FC * sig)
hi <- order(-mcols(y)$log2FC * sig)

## -----------------------------------------------------------------------------
top_up <- mcols(y)[head(hi),]
names(top_up)
cols <- c("log10mean","log2FC","pvalue","qvalue")
print(as.data.frame(top_up)[,cols], digits=3)

## -----------------------------------------------------------------------------
top_down <- mcols(y)[head(lo),]
print(as.data.frame(top_down)[,cols], digits=3)

## -----------------------------------------------------------------------------
plotInfReps(y, idx=hi[100], x="condition", cov="line")

## -----------------------------------------------------------------------------
plotMASwish(y, alpha=.05)

## -----------------------------------------------------------------------------
library(org.Hs.eg.db)
y <- addIds(y, "SYMBOL", gene=TRUE)

## -----------------------------------------------------------------------------
plotMASwish(y, alpha=.05, xlim=c(.5,5.5))
with(
  subset(mcols(y), qvalue < .05 & abs(log2FC) > 4),
     text(log10mean, log2FC, SYMBOL,
          col="blue", pos=4, cex=.7)
)

## -----------------------------------------------------------------------------
gse <- summarizeToGene(se)
gy <- gse
gy <- gy[seqnames(gy) == "chr4",]

## ----results="hide", message=FALSE--------------------------------------------
gy <- scaleInfReps(gy)
gy <- labelKeep(gy)
gy <- gy[mcols(gy)$keep,]
set.seed(1)
gy <- swish(gy, x="condition", pair="line")

## -----------------------------------------------------------------------------
table(mcols(gy)$qvalue < .05)

## -----------------------------------------------------------------------------
hist(mcols(y)$pvalue, col="grey")

## -----------------------------------------------------------------------------
with(mcols(gy),
     table(sig=qvalue < .05, sign.lfc=sign(log2FC))
     )     
sig <- mcols(gy)$qvalue < .05
glo <- order(mcols(gy)$log2FC * sig)
ghi <- order(-mcols(gy)$log2FC * sig)

## -----------------------------------------------------------------------------
gtop_up <- mcols(gy)[head(ghi),]
print(as.data.frame(gtop_up)[,cols], digits=3)
gtop_down <- mcols(gy)[head(glo),]
print(as.data.frame(gtop_down)[,cols], digits=3)

## -----------------------------------------------------------------------------
plotInfReps(gy, idx=ghi[100], x="condition", cov="line")

## -----------------------------------------------------------------------------
plotMASwish(gy, alpha=.05)

## -----------------------------------------------------------------------------
library(org.Hs.eg.db)
gy <- addIds(gy, "SYMBOL", gene=TRUE)

## -----------------------------------------------------------------------------
plotMASwish(gy, alpha=.05, xlim=c(.5,5.5))
with(
  subset(mcols(gy), qvalue < .05 & abs(log2FC) > 3),
     text(log10mean, log2FC, SYMBOL,
          col="blue", pos=4, cex=.7)
)

## -----------------------------------------------------------------------------
# run on the transcript-level dataset
iso <- isoformProportions(y)
iso <- swish(iso, x="condition", pair="line")

## -----------------------------------------------------------------------------
coldata <- read.csv(file.path(dir, "coldata.csv"))
coldata <- coldata[,c(1,2,3,5)]
names(coldata) <- c("names","id","line","condition")
coldata$files <- file.path(dir, "quants", coldata$names, "quant.sf.gz")
se <- tximeta(coldata)

## -----------------------------------------------------------------------------
se$ifng <- factor(ifelse(
  grepl("IFNg",se$condition),
  "treated","control"))
se$salmonella <- factor(ifelse(
  grepl("SL1344",se$condition),
  "infected","control"))
with(colData(se),
     table(ifng, salmonella))

## -----------------------------------------------------------------------------
y2 <- se
y2 <- y2[seqnames(y2) == "chr1",]

## -----------------------------------------------------------------------------
y2$pair <- factor(y2$line)
levels(y2$pair) <- LETTERS[1:6] # simplify names
y2$pair <- as.character(y2$pair)
y2$pair[y2$ifng == "control"]
y2$pair[y2$ifng == "treated"]
y2$pair[y2$ifng == "treated"] <- rep(LETTERS[7:12], each=2)
y2$pair <- factor(y2$pair)
head(table(y2$pair, y2$salmonella))

## ----results="hide", message=FALSE--------------------------------------------
y2 <- scaleInfReps(y2)
y2 <- labelKeep(y2)
y2 <- y2[mcols(y2)$keep,]
set.seed(1)
y2 <- swish(y2, x="salmonella", cov="ifng", pair="pair", interaction=TRUE)

## -----------------------------------------------------------------------------
hist(mcols(y2)$pvalue, col="grey")

## -----------------------------------------------------------------------------
plotMASwish(y2, alpha=.05)

## -----------------------------------------------------------------------------
idx <- with(mcols(y2), which(qvalue < .05 & log2FC > 5))
plotInfReps(y2, idx[1], x="ifng", cov="salmonella")
plotInfReps(y2, idx[2], x="ifng", cov="salmonella")

## ----eval=FALSE---------------------------------------------------------------
# vignette(topic="allelic", package="fishpond")

## ----eval=FALSE---------------------------------------------------------------
# dir <- system.file("extdata", package="tximportData")
# files <- file.path(dir,"alevin/neurons_900_v014/alevin/quants_mat.gz")
# neurons <- tximeta(files, type="alevin",
#                    skipMeta=TRUE, # just for vignette
#                    dropInfReps=TRUE,
#                    alevinArgs=list(filterBarcodes=TRUE))

## ----eval=FALSE---------------------------------------------------------------
# library(SingleCellExperiment)
# sce <- as(neurons, "SingleCellExperiment")
# sce$cluster <- factor(paste0("cl",sample(1:6,ncol(sce),TRUE)))
# par(mfrow=c(2,1), mar=c(2,4,2,1))
# plotInfReps(sce, "ENSMUSG00000072235.6", x="cluster",
#             legend=TRUE)
# plotInfReps(sce, "ENSMUSG00000072235.6", x="cluster",
#             reorder=FALSE)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# par(mfrow=c(2,1), mar=c(2,4,2,1))
# plotInfReps(sce[,1:50], "ENSMUSG00000072235.6", x="cluster")
# plotInfReps(sce[,1:150], "ENSMUSG00000072235.6", x="cluster")

## ----eval=FALSE---------------------------------------------------------------
# y <- labelKeep(y, minCount=3, minN=10)
# y <- y[mcols(y)$keep,] # subset genes

## ----eval=FALSE---------------------------------------------------------------
# assays(y) <- lapply(assays(y), as.matrix) # make dense matrices
# y <- scaleInfReps(y, lengthCorrect=FALSE, sfFun=sfFun)
# y <- swish(y, x="condition")

## ----eval=FALSE---------------------------------------------------------------
# y <- makeInfReps(y, 20)

## ----eval=FALSE---------------------------------------------------------------
# library(SingleCellExperiment)
# y <- as(y, "SingleCellExperiment")
# # then, after filtering genes and cells...
# # compute and store sizeFactors calculated over all genes
# y <- scran::computeSumFactors(y)
# # split swish objects into 8 RDS files:
# splitSwish(y, nsplits=8, prefix="swish", snakefile="Snakefile")
# # now, run snakemake from command line
# # after finished, results back into R:
# y <- addStatsFromCSV(y, "summary.csv")

## -----------------------------------------------------------------------------
set.seed(1)
y <- makeSimSwishData()

## -----------------------------------------------------------------------------
y <- scaleInfReps(y, saveMeanScaled=TRUE)
tail(assayNames(y),4) # 'meanScaled' assay
y <- labelKeep(y)
y <- y[mcols(y)$keep,]

## -----------------------------------------------------------------------------
norm_cts_for_batch <- assay(y, "meanScaled")
# use batch factor estimation method of your choosing
# ...

## -----------------------------------------------------------------------------
w1 <- runif(ncol(y)) # here simulated w1, use real instead
w2 <- runif(ncol(y)) # here simulated w2, use real instead
W <- data.frame(w1, w2)
infRepIdx <- grep("infRep",assayNames(y),value=TRUE)
nreps <- length(infRepIdx)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(limma))
mm <- model.matrix(~condition, colData(y))
pc <- .1
for (k in seq_len(nreps)) {
  logInfRep <- log(assay(y, infRepIdx[k]) + pc)
  logInfRep <- limma::removeBatchEffect(
                        logInfRep,
                        covariates=W,
                        design=mm)
  assay(y, infRepIdx[k]) <- exp(logInfRep)
}

## -----------------------------------------------------------------------------
y <- swish(y, x="condition")

## -----------------------------------------------------------------------------
gres <- mcols(gy)[mcols(gy)$keep,]
min(gres$qvalue, na.rm=TRUE) # min nominal FDR is not 0
with(gres, plot(stat, -log10(qvalue)))
with(gres, plot(log2FC, -log10(qvalue)))
abline(v=0, col="red")
with(gres, plot(log2FC, -log10(qvalue),
                xlim=c(-1.5,1.5), ylim=c(0,1.5)))
abline(v=0, col="red")

## -----------------------------------------------------------------------------
y3 <- se
y3 <- y3[seqnames(y3) == "chr4",]
y3 <- y3[,y3$condition %in% c("naive","IFNg")]
y3 <- labelKeep(y3)
y3 <- y3[mcols(y3)$keep,]
y3 <- computeInfRV(y3)
mcols(y3)$meanCts <- rowMeans(assays(y3)[["counts"]])
with(mcols(y3), plot(meanCts, meanInfRV, log="xy"))
hist(log10(mcols(y3)$meanInfRV),
     col="grey50", border="white", breaks=20,
     xlab="mean InfRV", main="Txp-level inferential uncertainty")

## ----echo=FALSE---------------------------------------------------------------
n <- 8
condition <- rep(1:2,length=2*n)
group <- rep(1:2,each=n)
pair <- rep(c(1:n),each=2)
cols <- c("dodgerblue","goldenrod4")
plot(1:(2*n), rep(0,2*n), ylim=c(-.5,3.5),
     type="n", xaxt="n", yaxt="n",
     xlab="samples", ylab="permutation")
abline(v=8.5, lty=2)
axis(2, 0:3, c("orig",1:3), las=2)
text(1:(2*n), rep(0,2*n), pair, col=cols[condition], cex=2)
set.seed(1)
for (i in 1:3) {
  perms <- rep(2*sample(n,n),each=2) - rep(1:0,length=2*n)
  text(1:(2*n), rep(i,2*n), pair[perms], col=cols[condition[perms]], cex=2)
}

## ----echo=FALSE---------------------------------------------------------------
n <- 8
condition <- rep(c(1:2,1:2),each=n/2)
group <- rep(1:2,each=n)
id <- LETTERS[1:(2*n)]
cols <- c("dodgerblue","goldenrod4")
plot(1:(2*n), rep(0,2*n), ylim=c(-.5,3.5),
     type="n", xaxt="n", yaxt="n",
     xlab="samples", ylab="permutation")
abline(v=8.5, lty=2)
axis(2, 0:3, c("orig",1:3), las=2)
text(1:(2*n), rep(0,2*n), id, col=cols[condition], cex=2)
set.seed(3)
for (i in 1:3) {
  id.perms <- character(2*n)
  grp1 <- id[group==1]
  grp2 <- id[group==2]
  id.perms[c(1:4,9:12)] <- sample(id[condition==1],n)
  idx1 <- id.perms[c(1:4,9:12)] %in% grp1
  id.perms[c(5:8,13:16)][idx1] <- sample(id[condition==2 & group==1],sum(idx1))
  idx2 <- id.perms[c(1:4,9:12)] %in% grp2
  id.perms[c(5:8,13:16)][idx2] <- sample(id[condition==2 & group==2],sum(idx2))
  text(1:(2*n), rep(i,2*n), id.perms, col=cols[condition], cex=2)
}
arrows(3,1.5,1.3,1.15,length=.1)
arrows(3,1.5,4.7,1.15,length=.1)

## -----------------------------------------------------------------------------
sessionInfo()

