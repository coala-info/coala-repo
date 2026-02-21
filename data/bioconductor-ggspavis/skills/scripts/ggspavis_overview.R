# Code example from 'ggspavis_overview' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ggspavis)
library(STexampleData)
library(patchwork)
library(scater)
library(scran)
library(OSTA.data)
library(VisiumIO)
library(SpatialExperiment)

## ----loadslide, message=FALSE, warning=FALSE----------------------------------
spe_slide <- STexampleData::SlideSeqV2_mouseHPC()
spe_slide$loglibsize <- log1p(colSums(counts(spe_slide)))

## ----pltcoordsslide, fig.width=10, fig.height=3, warning=FALSE, message=FALSE----
(plotCoords(spe_slide, annotate = "celltype", 
            in_tissue = NULL, point_size = 0.1) + 
  guides(color=guide_legend(override.aes = list(size = 3), ncol = 2)) |
  plotCoords(spe_slide, annotate = "loglibsize", 
             in_tissue = NULL, point_size = 0.1) + 
  scale_color_gradient(name = "Log library size") + ggtitle("")) +
  plot_annotation(title = 'Slide-seq V2 Mouse Brain')

## ----loadvismb, message=FALSE-------------------------------------------------
# load data in SpatialExperiment format
spe_vm <- Visium_mouseCoronal()
rownames(spe_vm) <- rowData(spe_vm)$gene_name
colData(spe_vm)$sum <- colSums(counts(spe_vm))

## ----vismbvislibsize, message=FALSE, warning=FALSE, fig.width=8, fig.height=3.5----
p1 <- plotVisium(spe_vm, annotate = "sum", highlight = "in_tissue", 
                 legend_position = "none")
p2 <- plotVisium(spe_vm, annotate = "sum", highlight = "in_tissue", 
                 pal = "darkred") + 
  guides(fill = guide_colorbar(title = "Libsize"))

# display panels using patchwork
p1 | p2

## ----vismbgevisge, warning=FALSE, fig.width=8, fig.height=3.5-----------------
p1 <- plotVisium(spe_vm, annotate = "Gapdh", highlight = "in_tissue")
p2 <- plotVisium(spe_vm, annotate = "Mbp", highlight = "in_tissue")

# display panels using patchwork
p1 | p2

## ----vismbonlyspots, warning=FALSE, fig.width=8, fig.height=3.5---------------
p1 <- plotVisium(spe_vm, annotate = "Mbp", 
                 highlight = "in_tissue", image = FALSE)
p2 <- plotVisium(spe_vm, annotate = "Mbp", 
                 highlight = "in_tissue", spots = FALSE)

# display panels using patchwork
p1 | p2

## ----vismbcoordsge, fig.width=6, fig.height=3---------------------------------
p1 <- plotCoords(spe_vm, annotate = "Gapdh")
p2 <- plotCoords(spe_vm, annotate = "Mbp", pal = "viridis")

# display panels using patchwork
p1 | p2

## ----loaddlpfc, message=FALSE-------------------------------------------------
# load data in SpatialExperiment format
spe <- Visium_humanDLPFC()
rownames(spe) <- rowData(spe)$gene_name
colData(spe)$libsize <- colSums(counts(spe))

## ----dlpfcgroundtruth, message=FALSE, out.width="60%"-------------------------
plotVisium(spe, annotate = "ground_truth", highlight = "in_tissue", 
           pal = "libd_layer_colors")

## ----testpalettes, fig.width=6, fig.height=3----------------------------------
p1 <- plotCoords(spe, annotate = "ground_truth", pal = "Okabe-Ito") +
  ggtitle("Reference")
p2 <- plotCoords(spe, annotate = "libsize", pal = "rainbow") + 
  ggtitle("Library size")

# display panels using patchwork
p1 | p2

## ----qcmetrics, message=FALSE-------------------------------------------------
# calculate QC metrics using scater
spe <- addPerCellQCMetrics(spe, 
  subsets = list(mito = grepl("(^MT-)|(^mt-)", rowData(spe)$gene_name)))

# apply QC thresholds
colData(spe)$low_libsize <- colData(spe)$sum < 400 | colData(spe)$detected < 400
colData(spe)$high_mito <- colData(spe)$subsets_mito_percent > 30

## ----obsqclowlibsize, fig.width=8, fig.height=2.5-----------------------------
p1 <- plotObsQC(spe, plot_type = "histogram", 
                x_metric = "sum", annotate = "low_libsize")
p2 <- plotObsQC(spe, plot_type = "violin", 
                x_metric = "sum", annotate = "low_libsize", point_size = 0.1)
p3 <- plotObsQC(spe, plot_type = "spot", in_tissue = "in_tissue", 
                annotate = "low_libsize", point_size = 0.2)

# display panels using patchwork
p1 | p2 | p3

## ----obsqchighmt, fig.width=8, fig.height=2.5---------------------------------
p1 <- plotObsQC(spe, plot_type = "histogram", 
                x_metric = "subsets_mito_percent", annotate = "high_mito")
p2 <- plotObsQC(spe, plot_type = "violin", 
                x_metric = "subsets_mito_percent", annotate = "high_mito", 
                point_size = 0.1)
p3 <- plotObsQC(spe, plot_type = "spot", in_tissue = "in_tissue", 
                annotate = "high_mito", point_size = 0.2)

# display panels using patchwork
p1 | p2 | p3

## ----obsqcscatter, out.width="60%", warning=FALSE, message=FALSE--------------
plotObsQC(spe, plot_type = "scatter", 
          x_metric = "subsets_mito_percent", y_metric = "sum", 
          x_threshold = 30, y_threshold = 400)

## ----featqc, warning=FALSE, message=FALSE, fig.width=8, fig.height=3----------
rowData(spe)$feature_sum <- rowSums(counts(spe))
rowData(spe)$low_abundance <- rowSums(counts(spe) > 0) < 20

p1 <- plotFeatureQC(spe, plot_type = "histogram", 
                    x_metric = "feature_sum", annotate = "low_abundance")
p2 <- plotFeatureQC(spe, plot_type = "violin", 
                    x_metric = "feature_sum", annotate = "low_abundance")

# display panels using patchwork
p1 | p2

## ----loadvhd8sub, message=FALSE-----------------------------------------------
# retrieve dataset from OSF repo
id <- "VisiumHD_HumanColon_Oliveira"
pa <- OSTA.data_load(id)
dir.create(td <- tempfile())
unzip(pa, exdir=td)

# read 8um bins into 'SpatialExperiment'
vhd8 <- TENxVisiumHD(spacerangerOut=td, processing="filtered", format="h5", 
                     images="lowres", bin_size="008") |> import()
# subset
vhd8 <- vhd8[, spatialCoords(vhd8)[, 1] * scaleFactors(vhd8) > 430 & 
               spatialCoords(vhd8)[, 1] * scaleFactors(vhd8) < 435 &
               spatialCoords(vhd8)[, 2] * scaleFactors(vhd8) > 127 & 
               spatialCoords(vhd8)[, 2] * scaleFactors(vhd8) < 132]
rownames(vhd8) <- rowData(vhd8)$Symbol
vhd8

## ----vhd8coord, warning=FALSE, fig.width=5, fig.height=2.5--------------------
plotCoords(vhd8, point_shape=15, point_size = 1.7, annotate="PIGR") | 
  plotVisium(vhd8, point_shape=22, point_size = 2, annotate="PIGR", 
           zoom = TRUE)

## ----imgdataload, message=FALSE, warning=FALSE--------------------------------
spe_xen <- STexampleData::Janesick_breastCancer_Xenium_rep1()
spe_cos <- STexampleData::CosMx_lungCancer()
spe_mer <- STexampleData::MERSCOPE_ovarianCancer()
spe_sta <- STexampleData::STARmapPLUS_mouseBrain()

## ----imgspatial, message=FALSE, fig.width=12, fig.height=3--------------------
plotCoords(spe_xen, annotate = "cell_area", in_tissue = NULL, pal = "magma",
           point_size = 0.15) + ggtitle("Xenium Breast Cancer") |
  plotCoords(spe_cos, annotate = "Area", in_tissue = NULL, pal = "plasma", 
             point_size = 0.1) + ggtitle("CosMx Breast Cancer") |
  plotCoords(spe_mer, annotate = "volume", in_tissue = NULL, 
             pal = c("navyblue", "yellow"),
             point_size = 0.05) + ggtitle("MERSCOPE Ovarian Cancer")

## ----spatialtextby, message=FALSE, fig.width=6, fig.height=3.5----------------
plotCoords(spe_sta, annotate = "Main_molecular_tissue_region", in_tissue = NULL,
           point_size = 0.1, text_by = "Main_molecular_tissue_region",
           text_by_size = 4, text_by_color = "#2d2d2d")

## ----getumap------------------------------------------------------------------
spe_sta <- logNormCounts(spe_sta)
dec <- modelGeneVar(spe_sta)
hvg <- getTopHVGs(dec, n=3e3)
spe_sta <- runPCA(spe_sta, subset_row=hvg)
spe_sta <- runUMAP(spe_sta, dimred="PCA")

## ----pltdimred, message=FALSE, fig.width=6, fig.height=3.5--------------------
plotDimRed(spe_sta, plot_type = "UMAP",
           annotate = "Main_molecular_tissue_region", 
           text_by = "Main_molecular_tissue_region",
           text_by_size = 3, text_by_color = "#2d2d2d")

## -----------------------------------------------------------------------------
sessionInfo()

