# Code example from 'UCell_Seurat' vignette. See references/ for full tutorial.

## ----message=F, warning=F, results=F------------------------------------------
library(scRNAseq)

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

## -----------------------------------------------------------------------------
signatures <- list(
    Tcell = c("CD3D","CD3E","CD3G","CD2","TRAC"),
    Myeloid = c("CD14","LYZ","CSF1R","FCER1G","SPI1","LCK-"),
    NK = c("KLRD1","NCR1","NKG7","CD3D-","CD3E-"),
    Plasma_cell = c("MZB1","DERL3","CD19-")
)

## ----message=F, warning=F-----------------------------------------------------
library(UCell)
seurat.object <- AddModuleScore_UCell(seurat.object, 
                                      features=signatures, name=NULL)
head(seurat.object[[]])

## ----message=F, warning=F-----------------------------------------------------
seurat.object <- NormalizeData(seurat.object)
seurat.object <- FindVariableFeatures(seurat.object, 
                     selection.method = "vst", nfeatures = 500)
  
seurat.object <- ScaleData(seurat.object)
seurat.object <- RunPCA(seurat.object, npcs = 20, 
                        features=VariableFeatures(seurat.object)) 
seurat.object <- RunUMAP(seurat.object, reduction = "pca", 
                         dims = 1:20, seed.use=123)

## ----message=F, warning=F, fig.wide=TRUE, dpi=60------------------------------
library(ggplot2)
library(patchwork)

FeaturePlot(seurat.object, reduction = "umap", features = names(signatures)[1:2]) &
  theme(aspect.ratio = 1,
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

## -----------------------------------------------------------------------------
seurat.object <- SmoothKNN(seurat.object,
                           signature.names = names(signatures),
                           reduction="pca")

## ----fig.wide=TRUE, dpi=60----------------------------------------------------
FeaturePlot(seurat.object, reduction = "umap", features = c("NK","NK_kNN")) &
    theme(aspect.ratio = 1,
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank())

## ----warning=FALSE, fig.wide=TRUE, dpi=60-------------------------------------
genes <- c("CD2","CSF1R")
seurat.object <- SmoothKNN(seurat.object, signature.names=genes,
                 assay="RNA", reduction="pca", k=20, suffix = "_smooth")

DefaultAssay(seurat.object) <- "RNA"
FeaturePlot(seurat.object, reduction = "umap", features = genes) &
  theme(aspect.ratio = 1)
  
DefaultAssay(seurat.object) <- "RNA_smooth"
FeaturePlot(seurat.object, reduction = "umap", features = genes) &
  theme(aspect.ratio = 1)

## -----------------------------------------------------------------------------
sessionInfo()

