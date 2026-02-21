# Code example from 'allelic' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE, dev="png",
                      message=FALSE, error=FALSE, warning=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # first build tx2gene to gene- or TSS-level
# # (for isoform level skip `tx2gene`)
# library(ensembldb)
# library(plyranges)
# # gene level:
# tx2gene <- transcripts(edb) %>%
#   select(tx_id, group_id=gene_id)
# # TSS level:
# tx2gene <- makeTx2Tss(edb, maxgap=50) %>%
#   select(tx_id, gene_id, group_id, tss)
# # import counts:
# y <- importAllelicCounts(
#   coldata, a1="alt", a2="ref",
#   format="wide", tx2gene=tx2gene
# )
# # testing with Swish:
# y <- labelKeep(y)
# y <- y[mcols(y)$keep,]
# # see below for other tests and details
# y <- swish(y, x="allele", pair="sample", fast=1)
# mcols(y)$qvalue # <-- gives FDR-bounded sets

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("images/SEESAW.png")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(ensembldb))
library(EnsDb.Hsapiens.v86)
library(fishpond)
edb <- EnsDb.Hsapiens.v86
t2g <- makeTx2Tss(edb) # GRanges object
mcols(t2g)[,c("tx_id","group_id")]

## ----eval=FALSE---------------------------------------------------------------
# n <- ncol(y)/2
# rep1a1 <- assay(y, "infRep1")[,y$allele == "a1"]
# rep1a2 <- assay(y, "infRep1")[,y$allele == "a2"]
# mcols(y)$someInfo <- rowSums(abs(rep1a1 - rep1a2) < 1) < n
# y <- y[ mcols(y)$someInfo, ]

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))

## -----------------------------------------------------------------------------
set.seed(1)
y <- makeSimSwishData(allelic=TRUE)
colData(y)
levels(y$allele) # a1/a2 allelic fold changes

## ----echo=FALSE---------------------------------------------------------------
# hidden chunk to add ranges to the `se`
tss <- t2g[!duplicated(t2g$group_id)]
tss$symbol <- mapIds(edb, tss$gene_id, "SYMBOL", "GENEID")
names(tss) <- paste0(tss$symbol, "-", tss$tss)
mcols(tss) <- mcols(tss)[,c("tx_id","gene_id","tss","group_id","symbol")]
# slow...
#tx_id <- CharacterList(split(t2g$tx_id,t2g$group_id))
#tss$tx_id <- tx_id[names(tss)]
tab <- table(tss$gene_id)
tss$ntss <- as.numeric(tab[tss$gene_id])
tss <- tss[tss$ntss > 1 & tss$ntss < 5 & seqnames(tss) == "1"]
tss <- tss[order(tss$gene_id),]
tss <- tss[43:1042]
# swap 2nd and 3rd isoform of first gene
tss[2:3] <- tss[3:2] 
rowRanges(y) <- tss

## ----fig.dim=c(7,3.5)---------------------------------------------------------
y <- computeInfRV(y) # for posterior mean, variance
gene <- rowRanges(y)$gene_id[1]
idx <- mcols(y)$gene_id == gene
plotAllelicHeatmap(y, idx=idx)

## -----------------------------------------------------------------------------
y <- labelKeep(y)
y <- swish(y, x="allele", pair="sample", fast=1)

## ----fig.dim=c(8,4)-----------------------------------------------------------
dat <- data.frame(minusLogQ=-log10(mcols(y)$qvalue[idx]),
                  row.names=rownames(y)[idx])
plotAllelicHeatmap(y, idx=idx, annotation_row=dat)

## ----fig.dim=c(5,5)-----------------------------------------------------------
par(mfrow=c(2,1), mar=c(1,4.1,2,2))
plotInfReps(y, idx=1, x="allele", cov="sample", xaxis=FALSE, xlab="")
plotInfReps(y, idx=2, x="allele", cov="sample", xaxis=FALSE, xlab="")

## ----fig.dim=c(8,7)-----------------------------------------------------------
gene <- rowRanges(y)$gene_id[1]
plotAllelicGene(y, gene, edb)

## ----fig.dim=c(8,7)-----------------------------------------------------------
plotAllelicGene(y, symbol="ADSS", db=edb)

## ----fig.dim=c(8,7)-----------------------------------------------------------
plotAllelicGene(y, gene, edb,
                transcriptAnnotation="transcript",
                labels=list(a2="maternal",a1="paternal"))

## ----fig.dim=c(5,4)-----------------------------------------------------------
y$allele_new <- y$allele
# note a2 is non-effect, a1 is effect:
levels(y$allele)
# replace a2 then a1:
levels(y$allele_new) <- c("maternal","paternal")
plotInfReps(y, idx=1, x="allele_new", 
            legend=TRUE, legendPos="bottom")

## -----------------------------------------------------------------------------
set.seed(1)
y <- makeSimSwishData(diffAI=TRUE, n=12)
colData(y)
table(y$condition, y$allele)

## -----------------------------------------------------------------------------
y <- labelKeep(y)
y <- swish(y, x="allele", pair="sample",
           cov="condition", interaction=TRUE)

## -----------------------------------------------------------------------------
mcols(y)[1:2,c("stat","qvalue")]

## -----------------------------------------------------------------------------
hist(mcols(y)[-c(1:6),"pvalue"])

## -----------------------------------------------------------------------------
plotInfReps(y, idx=1, x="allele", cov="condition",
            xaxis=FALSE, legend=TRUE, legendPos="bottomright")

## ----fig.dim=c(8,4)-----------------------------------------------------------
idx <- c(1:6)
row_dat <- data.frame(minusLogQ=-log10(mcols(y)$qvalue[idx]),
                      row.names=rownames(y)[idx])
col_dat <- data.frame(condition=y$condition[1:12],
                      row.names=paste0("s",1:12))
plotAllelicHeatmap(y, idx=idx,
                   annotation_row=row_dat,
                   annotation_col=col_dat,
                   cluster_rows=FALSE)

## -----------------------------------------------------------------------------
set.seed(1)
y <- makeSimSwishData(dynamicAI=TRUE)
colData(y)

## ----echo=FALSE---------------------------------------------------------------
rowRanges(y) <- tss

## -----------------------------------------------------------------------------
y <- labelKeep(y)
y <- swish(y, x="allele", pair="sample", cov="time", cor="pearson")

## -----------------------------------------------------------------------------
mcols(y)[1:2,c("stat","qvalue")]

## -----------------------------------------------------------------------------
y <- computeInfRV(y)

## ----fig.dim=c(7,7)-----------------------------------------------------------
par(mfrow=c(2,1), mar=c(2.5,4,2,2))
plotInfReps(y, idx=1, x="time", cov="allele", shiftX=.01, xaxis=FALSE, xlab="", main="")
par(mar=c(4.5,4,0,2))
plotInfReps(y, idx=2, x="time", cov="allele", shiftX=.01, main="")

## ----fig.dim=c(7,5)-----------------------------------------------------------
plotInfReps(y, idx=1, x="time", cov="allele", shiftX=.01)
dat <- data.frame(
  time = y$time[1:10],
  a2 = assay(y, "mean")[1,y$allele=="a2"],
  a1 = assay(y, "mean")[1,y$allele=="a1"])
lines(lowess(dat[,c(1,2)]), col="dodgerblue")
lines(lowess(dat[,c(1,3)]), col="goldenrod4")

## ----fig.dim=c(8,4)-----------------------------------------------------------
idx <- c(1:4)
row_dat <- data.frame(minusLogQ=-log10(mcols(y)$qvalue[idx]),
                      row.names=rownames(y)[idx])
col_dat <- data.frame(time=y$time[1:10],
                      row.names=paste0("s",1:10))
plotAllelicHeatmap(y, idx=idx,
                   annotation_row=row_dat,
                   annotation_col=col_dat)

## -----------------------------------------------------------------------------
y$time_bins <- cut(y$time,breaks=c(0,.25,.75,1),
                   include.lowest=TRUE, labels=FALSE)
y$time_bins <- paste0("time-",y$time_bins)
table(y$time_bins[ y$allele == "a2" ])

## ----fig.dim=c(8,7)-----------------------------------------------------------
gene <- rowRanges(y)$gene_id[1]
plotAllelicGene(y, gene, edb, cov="time_bins",
                qvalue=FALSE, log2FC=FALSE)

## ----fig.dim=c(8,7)-----------------------------------------------------------
plotAllelicGene(y, gene, edb, cov="time_bins",
                covFacetIsoform=TRUE,
                qvalue=FALSE, log2FC=FALSE)

## -----------------------------------------------------------------------------
set.seed(1)
y1 <- makeSimSwishData(dynamicAI=TRUE)
y2 <- makeSimSwishData(dynamicAI=TRUE)
y2$sample <- factor(rep(paste0("sample",11:20),2))
y <- cbind(y1, y2)
y$group <- factor(rep(c("A","B"),each=20))
table(y$time, y$group) # 2 allelic counts per cell

## -----------------------------------------------------------------------------
reps <- grep("infRep", assayNames(y), value=TRUE)
for (k in reps) {
  assay(y,k)[1,21:40] <- assay(y,k)[1,c(31:40,21:30)]
}

## ----fig.dim=c(8,7)-----------------------------------------------------------
y <- computeInfRV(y)
par(mfrow=c(2,2),mar=c(3,3,3,1))
for (i in 1:2) {
  plotInfReps(y[,y$group=="A"], idx=i, x="time", cov="allele", shiftX=.01)
  plotInfReps(y[,y$group=="B"], idx=i, x="time", cov="allele", shiftX=.01)
}

## -----------------------------------------------------------------------------
pc <- 5 # a pseudocount
idx1 <- which(y$allele == "a1")
idx2 <- which(y$allele == "a2")
# the sample must be aligned
all.equal(y$sample[idx1], y$sample[idx2])
cov <- y$time[idx1]
group <- y$group[idx1]
# interaction of group and covariate (time)
design <- model.matrix(~group + cov + group:cov)

## -----------------------------------------------------------------------------
reps <- grep("infRep", assayNames(y), value=TRUE)
nreps <- length(reps)
infReps <- assays(y)[reps]
infRepsArray <- abind::abind(as.list(infReps), along=3)
lfcArray <- log2(infRepsArray[,idx1,] + pc) -
            log2(infRepsArray[,idx2,] + pc)

## -----------------------------------------------------------------------------
computeStat <- function(k, design, name) {
  fit <- limma::lmFit(lfcArray[,,k], design)
  tstats <- fit$coef/fit$stdev.unscaled/fit$sigma
  tstats[,name]
}

## -----------------------------------------------------------------------------
stat <- rowMeans(sapply(1:nreps, \(k) computeStat(k, design, "groupB:cov")))

## -----------------------------------------------------------------------------
n <- nrow(design)
nperms <- 100
nulls <- matrix(nrow=nrow(y), ncol=nperms)
set.seed(1)
for (p in seq_len(nperms)) {
  # permute group labels
  pgroup <- group[sample(n)]
  pdesign <- model.matrix(~pgroup + cov + pgroup:cov)
  nulls[,p] <- rowMeans(sapply(1:nreps, \(k) computeStat(k, pdesign, "pgroupB:cov")))
}

## -----------------------------------------------------------------------------
pvalue <- qvalue::empPvals(abs(stat), abs(nulls))
q_res <- qvalue::qvalue(pvalue)
locfdr <- q_res$lfdr
qvalue <- q_res$qvalues
res <- data.frame(stat, pvalue, locfdr, qvalue)

## -----------------------------------------------------------------------------
head(res)
hist(res$pvalue[-1])

## -----------------------------------------------------------------------------
sessionInfo()

