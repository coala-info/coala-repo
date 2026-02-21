# Code example from 'UCell_vignette_basic' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(UCell)

data(sample.matrix)
gene.sets <- list(Tcell_signature = c("CD2","CD3E","CD3D"),
                  Myeloid_signature = c("SPI1","FCER1G","CSF1R"))

scores <- ScoreSignatures_UCell(sample.matrix, features=gene.sets)
head(scores)

## ----message=F, warning=F, results=F------------------------------------------
library(scRNAseq)

lung <- ZilionisLungData()
immune <- lung$Used & lung$used_in_NSCLC_immune
lung <- lung[,immune]
lung <- lung[,1:5000]

exp.mat <- Matrix::Matrix(counts(lung),sparse = TRUE)
colnames(exp.mat) <- paste0(colnames(exp.mat), seq(1,ncol(exp.mat)))

## -----------------------------------------------------------------------------
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)

## -----------------------------------------------------------------------------
u.scores <- ScoreSignatures_UCell(exp.mat,features=signatures)
head(u.scores)

## ----fig.small=TRUE, dpi=60---------------------------------------------------
library(reshape2)
library(ggplot2)
melted <- reshape2::melt(u.scores)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) + 
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size=0) +
    theme_bw() + theme(axis.text.x=element_blank())
p

## -----------------------------------------------------------------------------
set.seed(123)
ranks <- StoreRankings_UCell(exp.mat)
ranks[1:5,1:5]

## ----fig.small=TRUE, dpi=60---------------------------------------------------
set.seed(123)
u.scores.2 <- ScoreSignatures_UCell(features=signatures,
                                    precalc.ranks = ranks)

melted <- reshape2::melt(u.scores.2)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) + 
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size = 0) + 
    theme_bw() + theme(axis.text.x=element_blank())
p

## ----fig.small=TRUE, dpi=60---------------------------------------------------
new.signatures <- list(Mast.cell = c("TPSAB1","TPSB2","CPA3","MS4A2"),
                       Lymphoid = c("LCK"))

u.scores.3 <- ScoreSignatures_UCell(features=new.signatures,
                                    precalc.ranks = ranks)
melted <- reshape2::melt(u.scores.3)
colnames(melted) <- c("Cell","Signature","UCell_score")
p <- ggplot(melted, aes(x=Signature, y=UCell_score)) + 
    geom_violin(aes(fill=Signature), scale = "width") +
    geom_boxplot(width=0.1, outlier.size=0) + 
    theme_bw() + theme(axis.text.x=element_blank())
p

## -----------------------------------------------------------------------------
BPPARAM <- BiocParallel::MulticoreParam(workers=1)
u.scores <- ScoreSignatures_UCell(exp.mat,features=signatures,
                                  BPPARAM=BPPARAM)

## -----------------------------------------------------------------------------
sessionInfo()

