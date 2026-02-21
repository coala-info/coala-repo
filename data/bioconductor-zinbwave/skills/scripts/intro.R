# Code example from 'intro' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("zinbwave")

## ----options, include=FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(warning=FALSE, error=FALSE, message=FALSE)
set.seed(1133)

## ----load_packs---------------------------------------------------------------
library(zinbwave)
library(scRNAseq)
library(matrixStats)
library(magrittr)
library(ggplot2)
library(biomaRt)
library(sparseMatrixStats)

# Register BiocParallel Serial Execution
BiocParallel::register(BiocParallel::SerialParam())

## ----pollen-------------------------------------------------------------------
fluidigm <- ReprocessedFluidigmData(assays = "tophat_counts")
fluidigm

table(colData(fluidigm)$Coverage_Type)

## ----filter-------------------------------------------------------------------
filter <- rowSums(assay(fluidigm)>5)>5
table(filter)

fluidigm <- fluidigm[filter,]

## ----variance-----------------------------------------------------------------
assay(fluidigm) %>% log1p %>% rowVars -> vars
names(vars) <- rownames(fluidigm)
vars <- sort(vars, decreasing = TRUE)
head(vars)

fluidigm <- fluidigm[names(vars)[1:100],]

## ----rename-------------------------------------------------------------------
assayNames(fluidigm)[1] <- "counts"

## ----zinbwave-----------------------------------------------------------------
fluidigm_zinb <- zinbwave(fluidigm, K = 2, epsilon=1000)

## ----zinb_plot----------------------------------------------------------------
W <- reducedDim(fluidigm_zinb)

data.frame(W, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() + 
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()

## ----zinb_coverage------------------------------------------------------------
fluidigm_cov <- zinbwave(fluidigm, K=2, X="~Coverage_Type", epsilon=1000)

## ----zinb_plot2---------------------------------------------------------------
W <- reducedDim(fluidigm_cov)

data.frame(W, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() + 
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()

## ----gcc, eval=FALSE----------------------------------------------------------
# mart <- useMart("ensembl")
# mart <- useDataset("hsapiens_gene_ensembl", mart = mart)
# bm <- getBM(attributes=c('hgnc_symbol', 'start_position',
#                          'end_position', 'percentage_gene_gc_content'),
#             filters = 'hgnc_symbol',
#             values = rownames(fluidigm),
#             mart = mart)
# 
# bm$length <- bm$end_position - bm$start_position
# len <- tapply(bm$length, bm$hgnc_symbol, mean)
# len <- len[rownames(fluidigm)]
# gcc <- tapply(bm$percentage_gene_gc_content, bm$hgnc_symbol, mean)
# gcc <- gcc[rownames(fluidigm)]

## ----rowdata, eval=FALSE------------------------------------------------------
# rowData(fluidigm) <- data.frame(gccontent = gcc, length = len)

## ----zinb_gcc, eval=FALSE-----------------------------------------------------
# fluidigm_gcc <- zinbwave(fluidigm, K=2, V="~gccontent + log(length)", epsilon=1000)

## ----tsne---------------------------------------------------------------------
set.seed(93024)

library(Rtsne)
W <- reducedDim(fluidigm_cov)
tsne_data <- Rtsne(W, pca = FALSE, perplexity=10, max_iter=5000)

data.frame(Dim1=tsne_data$Y[,1], Dim2=tsne_data$Y[,2], 
           bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(Dim1, Dim2, colour=bio, shape=coverage)) + geom_point() + 
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()

## ----norm---------------------------------------------------------------------
fluidigm_norm <- zinbwave(fluidigm, K=2, epsilon=1000, normalizedValues=TRUE,
                    residuals = TRUE)

## ----assays-------------------------------------------------------------------
fluidigm_norm

## ----zinb---------------------------------------------------------------------
zinb <- zinbFit(fluidigm, K=2, epsilon=1000)

## ----zinbwave2----------------------------------------------------------------
fluidigm_zinb <- zinbwave(fluidigm, fitted_model = zinb, K = 2, epsilon=1000,
                          observationalWeights = TRUE)

## ----weights------------------------------------------------------------------
weights <- assay(fluidigm_zinb, "weights")

## ----edger--------------------------------------------------------------------
library(edgeR)

dge <- DGEList(assay(fluidigm_zinb))
dge <- calcNormFactors(dge)

design <- model.matrix(~Biological_Condition, data = colData(fluidigm))
dge$weights <- weights
dge <- estimateDisp(dge, design)
fit <- glmFit(dge, design)

lrt <- glmWeightedF(fit, coef = 3)
topTags(lrt)

## ----deseq2-------------------------------------------------------------------
library(DESeq2)

counts(fluidigm_zinb) <- as.matrix(counts(fluidigm_zinb))
dds <- DESeqDataSet(fluidigm_zinb, design = ~ Biological_Condition)

dds <- DESeq(dds, sfType="poscounts", useT=TRUE, minmu=1e-6)
res <- lfcShrink(dds, contrast=c("Biological_Condition", "NPC", "GW16"),
                 type = "normal")
head(res)

## ----seurat, eval=FALSE-------------------------------------------------------
# library(Seurat)
# 
# seu <- as.Seurat(x = fluidigm_zinb, counts = "counts", data = "counts")

## ----seurat3, eval=FALSE------------------------------------------------------
# seu <- FindNeighbors(seu, reduction = "zinbwave",
#                      dims = 1:2 #this should match K
#                      )
# seu <- FindClusters(object = seu)

## ----surf---------------------------------------------------------------------
fluidigm_surf <- zinbsurf(fluidigm, K = 2, epsilon = 1000,
                          prop_fit = 0.5)

W2 <- reducedDim(fluidigm_surf)

data.frame(W2, bio=colData(fluidigm)$Biological_Condition,
           coverage=colData(fluidigm)$Coverage_Type) %>%
    ggplot(aes(W1, W2, colour=bio, shape=coverage)) + geom_point() + 
    scale_color_brewer(type = "qual", palette = "Set1") + theme_classic()

## ----eval=FALSE---------------------------------------------------------------
# library(BiocParallel)
# zinb_res <- zinbwave(fluidigm, K=2, BPPARAM=MulticoreParam(2))

## -----------------------------------------------------------------------------
sessionInfo()

