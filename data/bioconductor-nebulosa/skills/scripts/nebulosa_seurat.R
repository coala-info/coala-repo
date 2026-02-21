# Code example from 'nebulosa_seurat' vignette. See references/ for full tutorial.

## ----import_libraries---------------------------------------------------------
library("Nebulosa")
library("Seurat")
library("BiocFileCache")

## ----download_and_untar_file--------------------------------------------------
bfc <- BiocFileCache(ask = FALSE)
data_file <- bfcrpath(bfc, file.path(
  "https://s3-us-west-2.amazonaws.com/10x.files/samples/cell",
  "pbmc3k",
  "pbmc3k_filtered_gene_bc_matrices.tar.gz"
))

untar(data_file, exdir = tempdir())

## ----read_data----------------------------------------------------------------
data <- Read10X(data.dir = file.path(tempdir(),
  "filtered_gene_bc_matrices",
  "hg19"
))

## ----create_seurat_object-----------------------------------------------------
pbmc <- CreateSeuratObject(
  counts = data,
  project = "pbmc3k",
  min.cells = 3,
  min.features = 200
)

## ----qc-----------------------------------------------------------------------
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")
pbmc <- subset(pbmc, subset = nFeature_RNA < 2500 & percent.mt < 5)

## ----norm, message=FALSE, warning=FALSE---------------------------------------
pbmc <- SCTransform(pbmc, verbose = FALSE)

## ----dim_red, message=FALSE, warning=FALSE------------------------------------
pbmc <- RunPCA(pbmc)
pbmc <- RunUMAP(pbmc, dims = 1:30)

## ----clustering, message=FALSE, warning=FALSE---------------------------------
pbmc <- FindNeighbors(pbmc, dims = 1:30)
pbmc <- FindClusters(pbmc)

## ----plot_cd4-----------------------------------------------------------------
plot_density(pbmc, "CD4")

## ----cd4_comparison-----------------------------------------------------------
FeaturePlot(pbmc, "CD4")
FeaturePlot(pbmc, "CD4", order = TRUE)

## ----cd4_and_clustering-------------------------------------------------------
DimPlot(pbmc, label = TRUE, repel = TRUE)

## ----plot_cd3d----------------------------------------------------------------
plot_density(pbmc, "CD3D")

## ----fig.height=10------------------------------------------------------------
p3 <- plot_density(pbmc, c("CD8A", "CCR7"))
p3 + plot_layout(ncol = 1)

## ----fig.height=14------------------------------------------------------------
p4 <- plot_density(pbmc, c("CD8A", "CCR7"), joint = TRUE)
p4 + plot_layout(ncol = 1)

## -----------------------------------------------------------------------------
p_list <- plot_density(pbmc, c("CD8A", "CCR7"), joint = TRUE, combine = FALSE)
p_list[[length(p_list)]]

## ----fig.height=14------------------------------------------------------------
p4 <- plot_density(pbmc, c("CD4", "CCR7"), joint = TRUE)
p4 + plot_layout(ncol = 1)

## ----fig.height=10------------------------------------------------------------
p4[[3]] / DimPlot(pbmc, label = TRUE, repel = TRUE)

