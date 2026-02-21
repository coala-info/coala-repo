# Code example from 'speckle' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE,
    message = FALSE,
    warning = FALSE
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("speckle")

## -----------------------------------------------------------------------------
library(speckle)
library(SingleCellExperiment)
library(CellBench)
library(limma)
library(ggplot2)
library(scater)
library(patchwork)
library(edgeR)
library(statmod)

## -----------------------------------------------------------------------------
sc_data <- load_sc_data()

## -----------------------------------------------------------------------------
commongenes1 <- rownames(sc_data$sc_dropseq)[rownames(sc_data$sc_dropseq) %in% 
                                                rownames(sc_data$sc_celseq)]
commongenes2 <-  commongenes1[commongenes1 %in% rownames(sc_data$sc_10x)]

sce_10x <- sc_data$sc_10x[commongenes2,]
sce_celseq <- sc_data$sc_celseq[commongenes2,] 
sce_dropseq <- sc_data$sc_dropseq[commongenes2,] 

dim(sce_10x)
dim(sce_celseq)
dim(sce_dropseq)

table(rownames(sce_10x) == rownames(sce_celseq))
table(rownames(sce_10x) == rownames(sce_dropseq))

## -----------------------------------------------------------------------------
i.10x <- seq_len(ncol(sce_10x))
i.celseq <- seq_len(ncol(sce_celseq))
i.dropseq <- seq_len(ncol(sce_dropseq))

set.seed(10)
boot.10x <- sample(i.10x, replace=TRUE)
boot.celseq <- sample(i.celseq, replace=TRUE)
boot.dropseq <- sample(i.dropseq, replace=TRUE)

sce_10x_rep2 <- sce_10x[,boot.10x]
sce_celseq_rep2 <- sce_celseq[,boot.celseq]
sce_dropseq_rep2 <- sce_dropseq[,boot.dropseq]

## -----------------------------------------------------------------------------
sample <- rep(c("S1","S2","S3","S4","S5","S6"), 
                c(ncol(sce_10x),ncol(sce_10x_rep2),ncol(sce_celseq),
                ncol(sce_celseq_rep2), 
                ncol(sce_dropseq),ncol(sce_dropseq_rep2)))
cluster <- c(sce_10x$cell_line,sce_10x_rep2$cell_line,sce_celseq$cell_line,
                sce_celseq_rep2$cell_line,sce_dropseq$cell_line,
                sce_dropseq_rep2$cell_line)
group <- rep(c("10x","celseq","dropseq"),
                c(2*ncol(sce_10x),2*ncol(sce_celseq),2*ncol(sce_dropseq)))

allcounts <- cbind(counts(sce_10x),counts(sce_10x_rep2), 
                    counts(sce_celseq), counts(sce_celseq_rep2),
                    counts(sce_dropseq), counts(sce_dropseq_rep2))

sce_all <- SingleCellExperiment(assays = list(counts = allcounts))
sce_all$sample <- sample
sce_all$group <- group
sce_all$cluster <- cluster

## -----------------------------------------------------------------------------
sce_all <- scater::logNormCounts(sce_all)
sce_all <- scater::runPCA(sce_all)
sce_all <- scater::runUMAP(sce_all)

## ----fig.width=12, fig.height=6-----------------------------------------------
pca1 <- scater::plotReducedDim(sce_all, dimred = "PCA", colour_by = "cluster") +
    ggtitle("Cell line")
pca2 <- scater::plotReducedDim(sce_all, dimred = "PCA", colour_by = "group") +
    ggtitle("Technology")
pca1 + pca2

## ----fig.width=12, fig.height=6-----------------------------------------------
umap1 <- scater::plotReducedDim(sce_all, dimred = "UMAP", 
                                colour_by = "cluster") + 
    ggtitle("Cell line")
umap2 <- scater::plotReducedDim(sce_all, dimred = "UMAP", colour_by = "group") +
    ggtitle("Technology")
umap1 + umap2

## -----------------------------------------------------------------------------
# Perform logit transformation
propeller(sce_all)

## -----------------------------------------------------------------------------
# Perform arcsin square root transformation
propeller(sce_all, transform="asin")

## -----------------------------------------------------------------------------
propeller(clusters=sce_all$cluster, sample=sce_all$sample, group=sce_all$group)

## ----fig.height=4,fig.width=7-------------------------------------------------
plotCellTypeProps(sce_all)

## ----fig.height=5,fig.width=7-------------------------------------------------
props <- getTransformedProps(sce_all$cluster, sce_all$sample, transform="logit")
barplot(props$Proportions, col = c("orange","purple","dark green"),legend=TRUE, 
        ylab="Proportions")

## ----fig.height=4,fig.width=10------------------------------------------------
par(mfrow=c(1,3))
for(i in seq(1,3,1)){
stripchart(props$Proportions[i,]~rep(c("10x","celseq","dropseq"),each=2),
            vertical=TRUE, pch=16, method="jitter",
            col = c("orange","purple","dark green"),cex=2, ylab="Proportions")
title(rownames(props$Proportions)[i])
}

## -----------------------------------------------------------------------------
par(mfrow=c(1,1))
plotCellTypeMeanVar(props$Counts)
plotCellTypePropsMeanVar(props$Counts)

## -----------------------------------------------------------------------------
names(props)

props$TransformedProps

## -----------------------------------------------------------------------------
group <- rep(c("10x","celseq","dropseq"),each=2)
pair <- rep(c(1,2),3)
data.frame(group,pair)

## -----------------------------------------------------------------------------
design <- model.matrix(~ 0 + group + pair)
design

## -----------------------------------------------------------------------------
propeller.anova(prop.list=props, design=design, coef = c(1,2,3), 
                robust=TRUE, trend=FALSE, sort=TRUE)

## -----------------------------------------------------------------------------
design
mycontr <- makeContrasts(group10x-groupdropseq, levels=design)
propeller.ttest(props, design, contrasts = mycontr, robust=TRUE, trend=FALSE, 
                sort=TRUE)

## -----------------------------------------------------------------------------
group
dose <- rep(c(1,2,3), each=2) 

des.dose <- model.matrix(~dose)
des.dose

fit <- lmFit(props$TransformedProps,des.dose)
fit <- eBayes(fit, robust=TRUE)
topTable(fit)

## -----------------------------------------------------------------------------
fit.prop <- lmFit(props$Proportions,des.dose)
fit.prop <- eBayes(fit.prop, robust=TRUE)
topTable(fit.prop)

## ----fig.height=4,fig.width=10------------------------------------------------
fit.prop$coefficients

par(mfrow=c(1,3))
for(i in seq(1,3,1)){
    plot(dose, props$Proportions[i,], main = rownames(props$Proportions)[i], 
        pch=16, cex=2, ylab="Proportions", cex.lab=1.5, cex.axis=1.5,
        cex.main=2)
    abline(a=fit.prop$coefficients[i,1], b=fit.prop$coefficients[i,2], col=4, 
            lwd=2)
}

## -----------------------------------------------------------------------------
des.tech <- model.matrix(~group)

dupcor <- duplicateCorrelation(props$TransformedProps, design=des.tech,
                                block=pair)
dupcor

## -----------------------------------------------------------------------------
# Fitting the linear model accounting for pair as a random effect
fit1 <- lmFit(props$TransformedProps, design=des.tech, block=pair, 
                correlation=dupcor$consensus)
fit1 <- eBayes(fit1)
summary(decideTests(fit1))

# Differences between celseq vs 10x
topTable(fit1,coef=2)

# Differences between dropseq vs 10x
topTable(fit1, coef=3)

## -----------------------------------------------------------------------------
topTable(fit1, coef=2:3)

## -----------------------------------------------------------------------------
data("pbmc_props")
pbmc.props <- pbmc_props$proportions
pbmc.sample.info <- pbmc_props$sample_info
tot.cells <- pbmc_props$total_cells

## ----fig.width=10, fig.height=6-----------------------------------------------
par(mfrow=c(1,1))
barplot(as.matrix(pbmc.props),col=ggplotColors(nrow(pbmc.props)),
        ylab="Cell type proportions", xlab="Samples")

## -----------------------------------------------------------------------------
prop.list <- convertDataToList(pbmc.props,data.type="proportions", 
                               transform="logit", scale.fac=tot.cells/20)

## -----------------------------------------------------------------------------
designAS <- model.matrix(~0+pbmc.sample.info$age + pbmc.sample.info$sex)
colnames(designAS) <- c("old","young","MvsF")

# Young vs old
mycontr <- makeContrasts(young-old, levels=designAS)
propeller.ttest(prop.list = prop.list,design = designAS, contrasts = mycontr,
                robust=TRUE,trend=FALSE,sort=TRUE)

## -----------------------------------------------------------------------------
group.immune <- paste(pbmc.sample.info$sex, pbmc.sample.info$age, sep=".")
par(mfrow=c(1,2))
stripchart(as.numeric(pbmc.props["CD8.Naive",])~group.immune,
           vertical=TRUE, pch=c(8,16), method="jitter",
           col = c(ggplotColors(20)[20],"hotpink",4, "darkblue"),cex=2,
           ylab="Proportions", cex.axis=1.25, cex.lab=1.5,
           group.names=c("F.Old","F.Young","M.Old","M.Young"))
title("CD8.Naive: Young Vs Old", cex.main=1.5, adj=0)

stripchart(as.numeric(pbmc.props["CD16",])~group.immune,
           vertical=TRUE, pch=c(8,16), method="jitter",
           col = c(ggplotColors(20)[20],"hotpink",4, "darkblue"),cex=2,
           ylab="Proportions", cex.axis=1.25, cex.lab=1.5,
           group.names=c("F.Old","F.Young","M.Old","M.Young"))
title("CD16: Young Vs Old", cex.main=1.5, adj=0)

## -----------------------------------------------------------------------------
sessionInfo()

