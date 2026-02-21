# Code example from 'UCell_parameters' vignette. See references/ for full tutorial.

## ----message=F, warning=F, results=F------------------------------------------
library(scRNAseq)
library(ggplot2)

lung <- ZilionisLungData()
immune <- lung$Used & lung$used_in_NSCLC_immune
lung <- lung[,immune]
lung <- lung[,1:5000]

exp.mat <- Matrix::Matrix(counts(lung),sparse = TRUE)
colnames(exp.mat) <- paste0(colnames(exp.mat), seq(1,ncol(exp.mat)))

## ----message=F, warning=F, results=F------------------------------------------
library(Seurat)

seurat.object <- CreateSeuratObject(counts = exp.mat, 
                                    project = "Zilionis_immune")
seurat.object <- NormalizeData(seurat.object)

## -----------------------------------------------------------------------------
signatures <- list(
    CD8T = c("CD8A+","CD8B+","CD4-"),
    CD4 = c("TRAC+","CD4+","CD40LG+","CD8A-","CD8B-"),
    NK = c("KLRD1+","NCR1+","NKG7+","CD3D-","CD3E-")
)

## -----------------------------------------------------------------------------
library(UCell)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures, 
                                      w_neg = 1.0, name = NULL)

scores <- seurat.object[[names(signatures)]]
head(scores,15)

## ----message=F, warning=F, results=F------------------------------------------
VlnPlot(seurat.object, features="nFeature_RNA", pt.size = 0, log = TRUE)

## -----------------------------------------------------------------------------
seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      maxRank=1000)

## -----------------------------------------------------------------------------
signatures <- list(
    Myeloid = c("LYZ","CSF1R","not_a_gene")
)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      missing_genes="impute")
scores1 <- seurat.object$Myeloid_UCell

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      missing_genes="skip")
scores2 <- seurat.object$Myeloid_UCell

scores <- cbind(scores1, scores2)
head(scores)

## -----------------------------------------------------------------------------
seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      chunk.size=500)

## -----------------------------------------------------------------------------
BPPARAM <- BiocParallel::MulticoreParam(workers=1)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      BPPARAM=BPPARAM)

## ----message=F, warning=F-----------------------------------------------------
seurat.object <- NormalizeData(seurat.object)
seurat.object <- FindVariableFeatures(seurat.object, 
                     selection.method = "vst", nfeatures = 500)
  
seurat.object <- ScaleData(seurat.object)
seurat.object <- RunPCA(seurat.object, npcs = 20, 
                        features=VariableFeatures(seurat.object)) 
seurat.object <- RunUMAP(seurat.object, reduction = "pca", 
                         dims = 1:20, seed.use=123)

## -----------------------------------------------------------------------------
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)

seurat.object <- AddModuleScore_UCell(seurat.object, features=signatures,
                                      name=NULL)

## -----------------------------------------------------------------------------
seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=3, suffix = "_kNN3")

seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, suffix = "_kNN100")

## ----fig.wide=TRUE, dpi=60----------------------------------------------------
FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell","Tcell_kNN3")) &
  theme(aspect.ratio = 1)

FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell","Tcell_kNN100")) &
  theme(aspect.ratio = 1)

## -----------------------------------------------------------------------------
seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, decay=0.001, suffix = "_decay0.001")

seurat.object <- SmoothKNN(seurat.object, reduction="pca",
                           signature.names = names(signatures),
                           k=100, decay=0.5, suffix = "_decay0.5")

## ----fig.wide=TRUE, dpi=60----------------------------------------------------
FeaturePlot(seurat.object, reduction = "umap",
            features = c("Tcell_decay0.5","Tcell_decay0.001")) &
  theme(aspect.ratio = 1)

## -----------------------------------------------------------------------------
sessionInfo()

