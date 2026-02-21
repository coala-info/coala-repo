# Code example from 'BioconductorVignette' vignette. See references/ for full tutorial.

## ----Installation, eval = FALSE-----------------------------------------------
# if(!require("tidyverse")) install.packages("tidyverse")
# if(!require("ggpubr")) install.packages("ggpubr")
# BiocManager::install("CelliD")

## ----library load, message=FALSE----------------------------------------------
library(CelliD)
library(tidyverse) # general purpose library for data handling
library(ggpubr) #library for plotting

## ----download data------------------------------------------------------------
#read data
BaronMatrix   <- readRDS(url("https://storage.googleapis.com/cellid-cbl/BaronMatrix.rds"))
BaronMetaData <- readRDS(url("https://storage.googleapis.com/cellid-cbl/BaronMetaData.rds"))
SegerMatrix   <- readRDS(url("https://storage.googleapis.com/cellid-cbl/SegerstolpeMatrix.rds"))
SegerMetaData <- readRDS(url("https://storage.googleapis.com/cellid-cbl/SegerstolpeMetaData2.rds"))

## ----preprocessing1, message=FALSE--------------------------------------------
# Restricting to protein-coding genes
data("HgProteinCodingGenes")
BaronMatrixProt <- BaronMatrix[rownames(BaronMatrix) %in% HgProteinCodingGenes,]
SegerMatrixProt <- SegerMatrix[rownames(SegerMatrix) %in% HgProteinCodingGenes,]

## ----preprocessing2, message=FALSE--------------------------------------------
# Create Seurat object  and remove remove low detection genes
Baron <- CreateSeuratObject(counts = BaronMatrixProt, project = "Baron", min.cells = 5, meta.data = BaronMetaData)
Seger <- CreateSeuratObject(counts = SegerMatrixProt, project = "Segerstolpe", min.cells = 5, meta.data = SegerMetaData)

# Library-size normalization, log-transformation, and centering and scaling of gene expression values
Baron <- NormalizeData(Baron)
Baron <- ScaleData(Baron, features = rownames(Baron))

## ----MCA1---------------------------------------------------------------------
Baron <- RunMCA(Baron)

## ----MCA2---------------------------------------------------------------------
DimPlotMC(Baron, reduction = "mca", group.by = "cell.type", features = c("CTRL", "INS", "MYZAP", "CDH11"), as.text = TRUE) + ggtitle("MCA with some key gene markers")

## ----Std Seurat---------------------------------------------------------------

Baron <- RunPCA(Baron, features = rownames(Baron))
Baron <- RunUMAP(Baron, dims = 1:30)
Baron <- RunTSNE(Baron, dims = 1:30)
PCA  <- DimPlot(Baron, reduction = "pca", group.by = "cell.type")  + ggtitle("PCA") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
tSNE <- DimPlot(Baron, reduction = "tsne", group.by = "cell.type")+ ggtitle("tSNE") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
UMAP <- DimPlot(Baron, reduction = "umap", group.by = "cell.type") + ggtitle("UMAP") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
MCA <- DimPlot(Baron, reduction = "mca", group.by = "cell.type")  + ggtitle("MCA") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggarrange(PCA, MCA, common.legend = TRUE, legend = "top")
ggarrange(tSNE, UMAP, common.legend = TRUE, legend = "top")

## ----pancreas_gs--------------------------------------------------------------
# download all cell-type gene signatures from panglaoDB
panglao <- read_tsv("https://panglaodb.se/markers/PanglaoDB_markers_27_Mar_2020.tsv.gz")

# restricting the analysis to pancreas specific gene signatues
panglao_pancreas <- panglao %>% filter(organ == "Pancreas")

# restricting to human specific genes
panglao_pancreas <- panglao_pancreas %>%  filter(str_detect(species,"Hs"))

# converting dataframes into a list of vectors, which is the format needed as input for CelliD
panglao_pancreas <- panglao_pancreas %>%  
  group_by(`cell type`) %>%  
  summarise(geneset = list(`official gene symbol`))
pancreas_gs <- setNames(panglao_pancreas$geneset, panglao_pancreas$`cell type`)

## ----all gs-------------------------------------------------------------------
#filter to get human specific genes
panglao_all <- panglao %>%  filter(str_detect(species,"Hs"))

# convert dataframes to a list of named vectors which is the format for CelliD input
panglao_all <- panglao_all %>%  
  group_by(`cell type`) %>%  
  summarise(geneset = list(`official gene symbol`))
all_gs <- setNames(panglao_all$geneset, panglao_all$`cell type`)

#remove very short signatures
all_gs <- all_gs[sapply(all_gs, length) >= 10]

## ----predictions using pancreas preestablished geneset------------------------

# Performing per-cell hypergeometric tests against the gene signature collection
HGT_pancreas_gs <- RunCellHGT(Baron, pathways = pancreas_gs, dims = 1:50, n.features = 200)

# For each cell, assess the signature with the lowest corrected p-value (max -log10 corrected p-value)
pancreas_gs_prediction <- rownames(HGT_pancreas_gs)[apply(HGT_pancreas_gs, 2, which.max)]

# For each cell, evaluate if the lowest p-value is significant
pancreas_gs_prediction_signif <- ifelse(apply(HGT_pancreas_gs, 2, max)>2, yes = pancreas_gs_prediction, "unassigned")

# Save cell type predictions as metadata within the Seurat object
Baron$pancreas_gs_prediction <- pancreas_gs_prediction_signif

## ----plottting cell type predictions based on pancreas-specific gene signatures----
# Comparing the original labels with CelliD cell-type predictions based on pancreas-specific gene signatures
color <- c("#F8766D", "#E18A00", "#BE9C00", "#8CAB00", "#24B700", "#00BE70", "#00C1AB", "#00BBDA", "#00ACFC", "#8B93FF", "#D575FE", "#F962DD", "#FF65AC", "grey")
ggcolor <- setNames(color,c(sort(unique(Baron$cell.type)), "unassigned"))
OriginalPlot <- DimPlot(Baron, reduction = "tsne", group.by = "cell.type") + 
  scale_color_manual(values = ggcolor) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
Predplot1 <- DimPlot(Baron, reduction = "tsne", group.by = "pancreas_gs_prediction") + 
  scale_color_manual(values = ggcolor) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggarrange(OriginalPlot, Predplot1, legend = "top",common.legend = TRUE)

## ----predictions using all preestablished geneset-----------------------------
HGT_all_gs <- RunCellHGT(Baron, pathways = all_gs, dims = 1:50)
all_gs_prediction <- rownames(HGT_all_gs)[apply(HGT_all_gs, 2, which.max)]
all_gs_prediction_signif <- ifelse(apply(HGT_all_gs, 2, max)>2, yes = all_gs_prediction, "unassigned")

# For the sake of visualization, we group under the label "other" diverse cell types for which significant enrichments were found:
Baron$all_gs_prediction <- ifelse(all_gs_prediction_signif %in% c(names(pancreas_gs), "Schwann cells", "Endothelial cells", "Macrophages", "Mast cells", "T cells","Fibroblasts", "unassigned"), all_gs_prediction_signif,"other")

color <- c("#F8766D", "#E18A00", "#BE9C00", "#8CAB00", "#24B700", "#00BE70", "#00C1AB", "#00BBDA", "#00ACFC", "#8B93FF", "#D575FE", "#F962DD", "#FF65AC", "#D575FE", "#F962DD", "grey", "black")
ggcolor <- setNames(color,c(sort(unique(Baron$cell.type)), "Fibroblasts", "Schwann cells", "unassigned", "other"))
Baron$pancreas_gs_prediction <- factor(Baron$pancreas_gs_prediction,c(sort(unique(Baron$cell.type)), "Fibroblasts", "Schwann cells", "unassigned", "other"))
PredPlot2 <- DimPlot(Baron, group.by = "all_gs_prediction", reduction = "tsne") + 
  scale_color_manual(values = ggcolor, drop = FALSE) + 
  theme(legend.text = element_text(size = 10), aspect.ratio = 1)
ggarrange(OriginalPlot, PredPlot2, legend = "top", common.legend = TRUE)

## ----geneset extraction-------------------------------------------------------
# Extracting per-cell gene signatures from the Baron dataset with CelliD(c)
Baron_cell_gs <- GetCellGeneSet(Baron, dims = 1:50, n.features = 200)

# Extracting per-group gene signatures from the Baron dataset with CelliD(g)
Baron_group_gs <- GetGroupGeneSet(Baron, dims = 1:50, n.features = 200, group.by = "cell.type")

## ----segerstolpe preprocessing, message = FALSE-------------------------------
# Normalization, basic preprocessing and MCA dimensionality reduction assessment
Seger <- NormalizeData(Seger)
Seger <- FindVariableFeatures(Seger)
Seger <- ScaleData(Seger)
Seger <- RunMCA(Seger, nmcs = 50)
Seger <- RunPCA(Seger)
Seger <- RunUMAP(Seger, dims = 1:30)
Seger <- RunTSNE(Seger, dims = 1:30)
tSNE <- DimPlot(Seger, reduction = "tsne", group.by = "cell.type", pt.size = 0.1) + ggtitle("tSNE") + theme(aspect.ratio = 1)
UMAP <- DimPlot(Seger, reduction = "umap", group.by = "cell.type", pt.size = 0.1) + ggtitle("UMAP") + theme(aspect.ratio = 1)
ggarrange(tSNE, UMAP, common.legend = TRUE, legend = "top")

## ----predictions using extracted geneset cell---------------------------------
HGT_baron_cell_gs <- RunCellHGT(Seger, pathways = Baron_cell_gs, dims = 1:50)
baron_cell_gs_match <- rownames(HGT_baron_cell_gs)[apply(HGT_baron_cell_gs, 2, which.max)]
baron_cell_gs_prediction <- Baron$cell.type[baron_cell_gs_match]
baron_cell_gs_prediction_signif <- ifelse(apply(HGT_baron_cell_gs, 2, max)>2, yes = baron_cell_gs_prediction, "unassigned")
Seger$baron_cell_gs_prediction <- baron_cell_gs_prediction_signif

color <- c("#F8766D", "#E18A00", "#BE9C00", "#8CAB00", "#24B700", "#00BE70", "#00C1AB", "#00BBDA", "#00ACFC", "#8B93FF", "#D575FE", "#F962DD", "#FF65AC", "grey")
ggcolor <- setNames(color,c(sort(unique(Baron$cell.type)), "unassigned"))

ggPredictionsCellMatch <- DimPlot(Seger, group.by = "baron_cell_gs_prediction", pt.size = 0.2, reduction = "tsne") + ggtitle("Predicitons") + scale_color_manual(values = ggcolor, drop =FALSE) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggOriginal <- DimPlot(Seger, group.by = "cell.type", pt.size = 0.2, reduction = "tsne") + ggtitle("Original") + scale_color_manual(values = ggcolor) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggarrange(ggOriginal, ggPredictionsCellMatch, legend = "top", common.legend = TRUE)

## ----predictions using extracted geneset group--------------------------------
HGT_baron_group_gs <- RunCellHGT(Seger, pathways = Baron_group_gs, dims = 1:50)
baron_group_gs_prediction <- rownames(HGT_baron_group_gs)[apply(HGT_baron_group_gs, 2, which.max)]
baron_group_gs_prediction_signif <- ifelse(apply(HGT_baron_group_gs, 2, max)>2, yes = baron_group_gs_prediction, "unassigned")
Seger$baron_group_gs_prediction <- baron_group_gs_prediction_signif

color <- c("#F8766D", "#E18A00", "#BE9C00", "#8CAB00", "#24B700", "#00BE70", "#00C1AB", "#00BBDA", "#00ACFC", "#8B93FF", "#D575FE", "#F962DD", "#FF65AC", "grey")
ggcolor <- setNames(color,c(sort(unique(Baron$cell.type)), "unassigned"))

ggPredictions <- DimPlot(Seger, group.by = "baron_group_gs_prediction", pt.size = 0.2, reduction = "tsne") + ggtitle("Predicitons") + scale_color_manual(values = ggcolor, drop =FALSE) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggOriginal <- DimPlot(Seger, group.by = "cell.type", pt.size = 0.2, reduction = "tsne") + ggtitle("Original") + scale_color_manual(values = ggcolor) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggarrange(ggOriginal, ggPredictions, legend = "top", common.legend = TRUE)

## ----Functionnal Enrichment---------------------------------------------------
# Downloading functional gene sets:
# For computational reasons, we just developed here the assessment on Hallmark MSigDB gene sets that is provided in the package
# Other functionnal pathways can be obtained using the msigdbr package

# library(msigdbr)
# msigdf <- msigdbr::msigdbr(species = "Homo sapiens")
# msigdf_filtered <- msigdf %>% select(gs_cat, gs_subcat, gs_name, gene_symbol, gs_description) %>%
#   filter(gs_subcat == "CP:KEGG") %>%
#   mutate(gs_subcat = ifelse(gs_subcat == "", "Hallmark", gs_subcat))
# KEGGgenesetDF <- msigdf_filtered %>%  mutate(gs_name = str_replace(sub("^.*?_{1}", "", gs_name), "_", "\\-")) %>%
#   group_by(gs_subcat, gs_name) %>%
#   summarise(geneset = list(gene_symbol)) %>%
#   group_by(gs_subcat) %>%
#   summarise(all_geneset = list(setNames(geneset, gs_name))) 
# KEGGgeneset <- setNames(KEGGgenesetDF$all_geneset, KEGGgenesetDF$gs_subcat)

# Assessing per-cell functional enrichment analyses
HGT_Hallmark <- RunCellHGT(Seger, pathways = Hallmark, dims = 1:50)

#Integrating functional annotations as an "assay" slot in the Seurat objects

Seger[["Hallmark"]] <- CreateAssayObject(HGT_Hallmark)

# Visualizing per-cell functional enrichment annotations in a dimensionality-reduction representation of choice (e.g. MCA, PCA, tSNE, UMAP)
ggG2Mcell <- FeaturePlot(Seger, "G2M-CHECKPOINT", order = TRUE, reduction = "tsne", min.cutoff = 2) + 
  theme(legend.text = element_text(size =10), aspect.ratio = 1)

ggG2Mcell

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

