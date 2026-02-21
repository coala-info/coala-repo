# Code example from 'eisaR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install_eisaR, eval=FALSE------------------------------------------------
# # BiocManager is needed to install Bioconductor packages
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # Install eisaR
# BiocManager::install("eisaR")

## ----availableOnline, eval=FALSE----------------------------------------------
# pkgs <- c(BiocManager::available("TxDb"),
#           BiocManager::available("EnsDb"))

## ----annotation, message=FALSE------------------------------------------------
# load package
library(eisaR)

# get TxDb object
txdbFile <- system.file("extdata", "hg19sub.sqlite", package = "eisaR")
txdb <- AnnotationDbi::loadDb(txdbFile)

## ----regions------------------------------------------------------------------
# extract filtered exonic and gene body regions
regS <- getRegionsFromTxDb(txdb = txdb, strandedData = TRUE)
regU <- getRegionsFromTxDb(txdb = txdb, strandedData = FALSE)

lengths(regS)
lengths(regU)

regS$exons

## ----exportregions------------------------------------------------------------
library(rtracklayer)
export(regS$exons, "hg19sub_exons_stranded.gtf")
export(regS$genebodies, "hg19sub_genebodies_stranded.gtf")

## ----extdata------------------------------------------------------------------
library(QuasR)
file.copy(system.file(package = "QuasR", "extdata"), ".", recursive = TRUE)

## ----align--------------------------------------------------------------------
sampleFile <- file.path("extdata", "samples_rna_single.txt")
## Display the structure of the sampleFile
read.delim(sampleFile)

## Perform the alignment
proj <- qAlign(sampleFile = sampleFile,
               genome = file.path("extdata", "hg19sub.fa"),
               aligner = "Rhisat2", splicedAlignment = TRUE)
alignmentStats(proj)

## ----count--------------------------------------------------------------------
cntEx <- qCount(proj, regU$exons, orientation = "any")
cntGb <- qCount(proj, regU$genebodies, orientation = "any")
cntIn <- cntGb - cntEx
cntEx
cntIn

## ----loadcounts---------------------------------------------------------------
cntEx <- readRDS(system.file("extdata",
                             "Fig3abc_GSE33252_rawcounts_exonic.rds",
                             package = "eisaR"))
cntIn <- readRDS(system.file("extdata",
                             "Fig3abc_GSE33252_rawcounts_intronic.rds",
                             package = "eisaR"))

## ----runEISA------------------------------------------------------------------
# remove "width" column
rEx <- cntEx[, colnames(cntEx) != "width"]
rIn <- cntIn[, colnames(cntIn) != "width"]

# create condition factor (contrast will be TN - ES)
cond <- factor(c("ES", "ES", "TN", "TN"))

# run EISA
res <- runEISA(rEx, rIn, cond)

## ----compare------------------------------------------------------------------
res1 <- runEISA(rEx, rIn, cond, method = "Gaidatzis2015")
res2 <- runEISA(rEx, rIn, cond)

# number of quantifiable genes
nrow(res1$DGEList)
nrow(res2$DGEList)

# number of genes with significant post-transcriptional regulation
sum(res1$tab.ExIn$FDR < 0.05)
sum(res2$tab.ExIn$FDR < 0.05)

# method="Gaidatzis2015" results contain most of default results
summary(rownames(res2$contrasts)[res2$tab.ExIn$FDR < 0.05] %in%
        rownames(res1$contrasts)[res1$tab.ExIn$FDR < 0.05])

# comparison of deltas
ids <- intersect(rownames(res1$DGEList), rownames(res2$DGEList))
cor(res1$contrasts[ids, "Dex"], res2$contrasts[ids, "Dex"])
cor(res1$contrasts[ids, "Din"], res2$contrasts[ids, "Din"])
cor(res1$contrasts[ids, "Dex.Din"], res2$contrasts[ids, "Dex.Din"])
plot(res1$contrasts[ids, "Dex.Din"], res2$contrasts[ids, "Dex.Din"], pch = "*",
     xlab = expression(paste(Delta, "exon", -Delta, "intron for method='Gaidatzis2015'")),
     ylab = expression(paste(Delta, "exon", -Delta, "intron for default parameters")))

## ----modelSamples-------------------------------------------------------------
res3 <- runEISA(rEx, rIn, cond, modelSamples = FALSE)
res4 <- runEISA(rEx, rIn, cond, modelSamples = TRUE)
ids <- intersect(rownames(res3$contrasts), rownames(res4$contrasts))

# number of genes with significant post-transcriptional regulation
sum(res3$tab.ExIn$FDR < 0.05)
sum(res4$tab.ExIn$FDR < 0.05)

# modelSamples=TRUE results are a super-set of
# modelSamples=FALSE results
summary(rownames(res3$contrasts)[res3$tab.ExIn$FDR < 0.05] %in%
        rownames(res4$contrasts)[res4$tab.ExIn$FDR < 0.05])

# comparison of contrasts
diag(cor(res3$contrasts[ids, ], res4$contrasts[ids, ]))
plot(res3$contrasts[ids, 3L], res4$contrasts[ids, 3L], pch = "*",
     xlab = "Interaction effects for modelSamples=FALSE",
     ylab = "Interaction effects for modelSamples=TRUE")

# comparison of interaction significance
plot(-log10(res3$tab.ExIn[ids, "FDR"]), -log10(res4$tab.ExIn[ids, "FDR"]), pch = "*",
     xlab = "-log10(FDR) for modelSamples=FALSE",
     ylab = "-log10(FDR) for modelSamples=TRUE")
abline(a = 0.0, b = 1.0, col = "gray")
legend("bottomright", "y = x", bty = "n", lty = 1L, col = "gray")

## ----plotEISA-----------------------------------------------------------------
plotEISA(res)

## ----normalization------------------------------------------------------------
# remove column "width"
rEx <- cntEx[, colnames(cntEx) != "width"]
rIn <- cntIn[, colnames(cntIn) != "width"]
rAll <- rEx + rIn
fracIn <- colSums(rIn) / colSums(rAll)
summary(fracIn)

# scale counts to the mean library size,
# separately for exons and introns
normEx <- t(t(rEx) / colSums(rEx) * mean(colSums(rEx)))
normIn <- t(t(rIn) / colSums(rIn) * mean(colSums(rIn)))

# log transform (add a pseudocount of 8)
lognormEx <- log2(normEx + 8L)
lognormIn <- log2(normIn + 8L)

## ----quantgenes---------------------------------------------------------------
quantGenes <- rownames(rEx)[rowMeans(lognormEx) > 5.0 & rowMeans(lognormIn) > 5.0]
length(quantGenes)

## ----dIdE---------------------------------------------------------------------
Dex <- lognormEx[, c("MmTN_RNA_total_a", "MmTN_RNA_total_b")] -
    lognormEx[, c("MmES_RNA_total_a", "MmES_RNA_total_b")]
Din <- lognormIn[, c("MmTN_RNA_total_a", "MmTN_RNA_total_b")] -
    lognormIn[, c("MmES_RNA_total_a", "MmES_RNA_total_b")]
Dex.Din <- Dex - Din

cor(Dex[quantGenes, 1L], Dex[quantGenes, 2L])
cor(Din[quantGenes, 1L], Din[quantGenes, 2L])
cor(Dex.Din[quantGenes, 1L], Dex.Din[quantGenes, 2L])

## ----sig----------------------------------------------------------------------
# create DGEList object with exonic and intronic counts
library(edgeR)
cnt <- data.frame(Ex = rEx, In = rIn)
y <- DGEList(counts = cnt, genes = data.frame(ENTREZID = rownames(cnt)))

# select quantifiable genes and normalize
y <- y[quantGenes, ]
y <- calcNormFactors(y)

# design matrix with interaction term
region <- factor(c("ex", "ex", "ex", "ex", "in", "in", "in", "in"),
                 levels = c("in", "ex"))
cond <- rep(factor(c("ES", "ES", "TN", "TN")), 2L)
design <- model.matrix(~ region * cond)
rownames(design) <- colnames(cnt)
design

# estimate model parameters
y <- estimateDisp(y, design)
fit <- glmFit(y, design)

# calculate likelihood-ratio between full and reduced models
lrt <- glmLRT(fit)

# create results table
tt <- topTags(lrt, n = nrow(y), sort.by = "none")
head(tt$table[order(tt$table$FDR, decreasing = FALSE), ])

## ----plot---------------------------------------------------------------------
sig <- tt$table$FDR < 0.05
sum(sig)
sigDir <- sign(tt$table$logFC[sig])
cols <- ifelse(sig,
               ifelse(tt$table$logFC > 0.0, "#E41A1CFF", "#497AB3FF"),
               "#22222244")

# volcano plot
plot(tt$table$logFC, -log10(tt$table$FDR), col = cols, pch = 20L,
     xlab = expression(paste("RNA change (log2 ", Delta, "exon/", Delta, "intron)")),
     ylab = "Significance (-log10 FDR)")
abline(h = -log10(0.05), lty = 2L)
abline(v = 0.0, lty = 2L)
ppar <- par("usr")
text(x = ppar[1L] + 3.0 * par("cxy")[1L],
     y = ppar[4L], adj = c(0.0, 1.0),
     labels = sprintf("n=%d", sum(sigDir == -1L)), col = "#497AB3FF")
text(x = ppar[2L] - 3.0 * par("cxy")[1L],
     y = ppar[4L], adj = c(1.0, 1.0),
     labels = sprintf("n=%d", sum(sigDir ==  1L)), col = "#E41A1CFF")

# Delta I vs. Delta E
plot(rowMeans(Din)[quantGenes], rowMeans(Dex)[quantGenes], pch = 20L, col = cols,
     xlab = expression(paste(Delta, "intron (log2 TN/ES)")),
     ylab = expression(paste(Delta, "exon (log2 TN/ES)")))
legend(x = "bottomright", bty = "n", pch = 20L, col = c("#E41A1CFF", "#497AB3FF"),
       legend = sprintf("%s (%d)", c("Up", "Down"), c(sum(sigDir == 1L), sum(sigDir == -1L))))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

