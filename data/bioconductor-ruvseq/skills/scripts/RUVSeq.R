# Code example from 'RUVSeq' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----data, warning=FALSE, message=FALSE---------------------------------------
library(RUVSeq)
library(zebrafishRNASeq)
data(zfGenes)
head(zfGenes)
tail(zfGenes)

## ----filter-------------------------------------------------------------------
filter <- apply(zfGenes, 1, function(x) length(x[x>5])>=2)
filtered <- zfGenes[filter,]
genes <- rownames(filtered)[grep("^ENS", rownames(filtered))]
spikes <- rownames(filtered)[grep("^ERCC", rownames(filtered))]

## ----store_data---------------------------------------------------------------
x <- as.factor(rep(c("Ctl", "Trt"), each=3))
set <- newSeqExpressionSet(as.matrix(filtered),
                           phenoData = data.frame(x, row.names=colnames(filtered)))
set

## ----rle----------------------------------------------------------------------
library(RColorBrewer)
colors <- brewer.pal(3, "Set2")
plotRLE(set, outline=FALSE, ylim=c(-4, 4), col=colors[x])
plotPCA(set, col=colors[x], cex=1.2)

## ----uq-----------------------------------------------------------------------
set <- betweenLaneNormalization(set, which="upper")
plotRLE(set, outline=FALSE, ylim=c(-4, 4), col=colors[x])
plotPCA(set, col=colors[x], cex=1.2)

## ----ruv_spikes---------------------------------------------------------------
set1 <- RUVg(set, spikes, k=1)
pData(set1)
plotRLE(set1, outline=FALSE, ylim=c(-4, 4), col=colors[x])
plotPCA(set1, col=colors[x], cex=1.2)

## ----edger--------------------------------------------------------------------
design <- model.matrix(~x + W_1, data=pData(set1))
y <- DGEList(counts=counts(set1), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)

fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)
topTags(lrt)

## ----empirical----------------------------------------------------------------
design <- model.matrix(~x, data=pData(set))
y <- DGEList(counts=counts(set), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)

fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)

top <- topTags(lrt, n=nrow(set))$table
empirical <- rownames(set)[which(!(rownames(set) %in% rownames(top)[1:5000]))]

## ----emp_ruvg-----------------------------------------------------------------
set2 <- RUVg(set, empirical, k=1)
pData(set2)
plotRLE(set2, outline=FALSE, ylim=c(-4, 4), col=colors[x])
plotPCA(set2, col=colors[x], cex=1.2)

## ----deseq2-------------------------------------------------------------------
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts(set1),
                              colData = pData(set1),
                              design = ~ W_1 + x)
dds <- DESeq(dds)
res <- results(dds)
res

## ----deseq2lrt, eval=FALSE----------------------------------------------------
# dds <- DESeq(dds, test="LRT", reduced=as.formula("~ W_1"))
# res <- results(dds)

## ----diff---------------------------------------------------------------------
differences <- makeGroups(x)
differences

## ----ruvs---------------------------------------------------------------------
set3 <- RUVs(set, genes, k=1, differences)
pData(set3)

## ----res, eval=FALSE----------------------------------------------------------
# design <- model.matrix(~x, data=pData(set))
# y <- DGEList(counts=counts(set), group=x)
# y <- calcNormFactors(y, method="upperquartile")
# y <- estimateGLMCommonDisp(y, design)
# y <- estimateGLMTagwiseDisp(y, design)
# 
# fit <- glmFit(y, design)
# res <- residuals(fit, type="deviance")

## ----ruvr, eval=FALSE---------------------------------------------------------
# set4 <- RUVr(set, genes, k=1, res)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

