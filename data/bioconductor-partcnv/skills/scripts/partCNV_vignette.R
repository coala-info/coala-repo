# Code example from 'partCNV_vignette' vignette. See references/ for full tutorial.

## ----setup, eval=FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("partCNV")

## ----results=FALSE, warning=FALSE, message=FALSE, eval=FALSE------------------
# library(devtools)
# install_github("rx-li/partCNV")

## ----loadData, echo=TRUE------------------------------------------------------
library(partCNV)
data(SimData)
dim(SimData)
SimData[1:5,1:5]

## ----runseurat, echo=TRUE, eval=FALSE-----------------------------------------
# library(Seurat)
# Seurat_obj <- NormalizeData(Your_SeuratObj, normalization.method = "LogNormalize", scale.factor = 10000)
# Counts = Seurat_obj@assays$RNA@counts

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# Counts <- NormalizeCounts(Your_SingleCellExperimentObj, scale_factor=10000)

## ----s1, echo=TRUE, eval=TRUE-------------------------------------------------
res <- GetCytoLocation(cyto_feature = "chr20(q11.1-q13.1)")

## ----s2, echo=TRUE, eval=TRUE-------------------------------------------------
GEout <- GetExprCountCyto(cytoloc_output = res, Counts = as.matrix(SimData), normalization = TRUE, qt_cutoff = 0.99)

## ----s3, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, results='hide'----
pcout <- partCNV(int_counts = GEout$ProcessedCount,
                 cyto_type = "del",
                 cyto_p = 0.40)

## ----s4, echo=TRUE, eval=TRUE-------------------------------------------------
table(pcout)
sum(pcout==1)/length(pcout)
p1 <- sum(pcout==1)/length(pcout)

## ----s5, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, results='hide'----
library(Seurat)
sim_seurat <- CreateSeuratObject(counts = SimData)
sim_seurat <- NormalizeData(sim_seurat, normalization.method = "LogNormalize", scale.factor = 10000)
sim_seurat <- FindVariableFeatures(sim_seurat, selection.method = "vst", nfeatures = 2000)
all.genes <- rownames(sim_seurat)
sim_seurat <- ScaleData(sim_seurat, features = all.genes)
sim_seurat <- RunPCA(sim_seurat, features = VariableFeatures(object = sim_seurat))
sim_seurat <- RunUMAP(sim_seurat, dims = 1:10)
sim_seurat <- AddMetaData(
    object = sim_seurat,
    metadata = pcout,
    col.name = "partCNV_label"
)
sim_seurat$partCNV_label <- factor(sim_seurat$partCNV_label, levels = c(1,0), labels = c(
    "aneuploid", "diploid"
))

## ----s6, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE-------------------
library(ggplot2)
DimPlot(sim_seurat, reduction = "umap", group = "partCNV_label") + ggtitle(paste0("partCNV (", signif(p1,2)*100, "%)"))

## ----s11, echo=TRUE, eval=TRUE------------------------------------------------
res <- GetCytoLocation(cyto_feature = "chr20(q11.1-q13.1)")
GEout <- GetExprCountCyto(cytoloc_output = res, Counts = as.matrix(SimData), normalization = TRUE, qt_cutoff = 0.99)

## ----s13, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, results='hide'----
pcHout <- partCNVH(int_counts = GEout$ProcessedCount,
                 cyto_type = "del",
                 cyto_p = 0.40)

## ----s14, echo=TRUE, eval=TRUE------------------------------------------------
table(pcHout$EMHMMlabel)
sum(pcHout$EMHMMlabel==1)/length(pcHout$EMHMMlabel)
p2 <- sum(pcHout$EMHMMlabel==1)/length(pcHout$EMHMMlabel)

## ----s15, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE, results='hide'----
# I commented these steps because they are exactly the same as partCNV run. 
# library(Seurat)
# sim_seurat <- CreateSeuratObject(counts = SimData)
# sim_seurat <- NormalizeData(sim_seurat, normalization.method = "LogNormalize", scale.factor = 10000)
# sim_seurat <- FindVariableFeatures(sim_seurat, selection.method = "vst", nfeatures = 2000)
# all.genes <- rownames(sim_seurat)
# sim_seurat <- ScaleData(sim_seurat, features = all.genes)
# sim_seurat <- RunPCA(sim_seurat, features = VariableFeatures(object = sim_seurat))
# sim_seurat <- RunUMAP(sim_seurat, dims = 1:10)
sim_seurat <- AddMetaData(
    object = sim_seurat,
    metadata = pcHout$EMHMMlabel,
    col.name = "partCNVH_label"
)
sim_seurat$partCNVH_label <- factor(sim_seurat$partCNVH_label, levels = c(1,0), labels = c(
    "aneuploid", "diploid"
))

## ----s16, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE------------------
library(ggplot2)
DimPlot(sim_seurat, reduction = "umap", group = "partCNVH_label") + ggtitle(paste0("partCNVH (", signif(p2,2)*100, "%)"))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

