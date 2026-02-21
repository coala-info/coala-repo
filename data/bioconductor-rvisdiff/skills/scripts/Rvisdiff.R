# Code example from 'Rvisdiff' vignette. See references/ for full tutorial.

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=FALSE----------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("Rvisdiff")

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library("Rvisdiff")

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(Rvisdiff)
library(airway)
data("airway")
se <- airway
se$dex <- relevel(se$dex, ref="untrt")
countdata <- assay(se)
coldata <- colData(se)

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(DESeq2)
dds <- DESeqDataSet(se, design = ~ cell + dex)
dds <- DESeq(dds)
dres <- results(dds, independentFiltering = FALSE)
DEreport(dres, countdata, coldata$dex)

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(edgeR)
design <- model.matrix(~ cell + dex, data = coldata)
dl <- DGEList(counts = countdata, group = coldata$dex)
dl <- calcNormFactors(dl)
dl <- estimateDisp(dl, design=design)
de <- exactTest(dl,pair=1:2)
tt <- topTags(de, n = Inf, adjust.method = "BH", sort.by = "none")
DEreport(tt, countdata, coldata$dex) 

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
library(limma)
design <- model.matrix(~ 0 + dex + cell, data = coldata)
contr <- makeContrasts(dextrt - dexuntrt,levels=colnames(design))
limmaexprs <- voom(countdata, design)
fit <- lmFit(limmaexprs, design)
fit <- contrasts.fit(fit, contrasts=contr)
fit <- eBayes(fit)
limmares <- topTable(fit, coef = 1, number = Inf, sort.by = "none",
    adjust.method = "BH")
DEreport(limmares, countdata, coldata$dex) 

## ----echo=TRUE, message=FALSE, warning=FALSE, eval=TRUE-----------------------
untrt <- countdata[,coldata$dex=="untrt"]
trt <- countdata[,coldata$dex=="trt"]

library(matrixTests)
wilcox <- col_wilcoxon_twosample(t(untrt), t(trt))
stat <- wilcox$statistic
p <- wilcox$pvalue
log2FoldChange <- log2(rowMeans(trt)+1) - log2(rowMeans(untrt)+1)
wilcox <- cbind(stat = stat, pvalue = round(p, 6),
    padj = p.adjust(wilcox[,2], method = "BH"),
    baseMean = rowMeans(countdata),
    log2FoldChange = log2FoldChange)
rownames(wilcox) <- rownames(countdata)

DEreport(wilcox, countdata, coldata$dex)

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figure1.png")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

