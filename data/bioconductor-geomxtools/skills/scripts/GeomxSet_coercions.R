# Code example from 'GeomxSet_coercions' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  fig.width = 10
)

## ----Load Libraries-----------------------------------------------------------
library(GeomxTools)
library(Seurat)
library(SpatialDecon)
library(patchwork)

## ----Read in Data-------------------------------------------------------------
datadir <- system.file("extdata", "DSP_NGS_Example_Data",
                       package="GeomxTools")
DCCFiles <- dir(datadir, pattern=".dcc$", full.names=TRUE)
PKCFiles <- unzip(zipfile = file.path(datadir,  "/pkcs.zip"))
SampleAnnotationFile <- file.path(datadir, "annotations.xlsx")

demoData <-
  suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                          pkcFiles = PKCFiles,
                                          phenoDataFile = SampleAnnotationFile,
                                          phenoDataSheet = "CW005",
                                          phenoDataDccColName = "Sample_ID",
                                          protocolDataColNames = c("aoi",
                                                                   "cell_line",
                                                                   "roi_rep",
                                                                   "pool_rep",
                                                                   "slide_rep")))

## ----GeomxTools QC------------------------------------------------------------
demoData <- shiftCountsOne(demoData, useDALogic=TRUE)
demoData <- setSegmentQCFlags(demoData, qcCutoffs = list(percentSaturation = 45))
demoData <- setBioProbeQCFlags(demoData)

# low sequenced ROIs
lowSaturation <- which(protocolData(demoData)[["QCFlags"]]$LowSaturation)

# probes that are considered outliers 
lowQCprobes <- which(featureData(demoData)[["QCFlags"]]$LowProbeRatio | 
                       featureData(demoData)[["QCFlags"]]$GlobalGrubbsOutlier)

# remove low quality ROIs and probes
passedQC <- demoData[-lowQCprobes, -lowSaturation]

dim(demoData)
dim(passedQC)

## ----aggregation--------------------------------------------------------------
featureType(passedQC)
data.frame(assayData(passedQC)[["exprs"]][seq_len(3), seq_len(3)])

target_demoData <- aggregateCounts(passedQC)

featureType(target_demoData)
data.frame(assayData(target_demoData)[["exprs"]][seq_len(3), seq_len(3)])

## ----GeomxTools Normalization-------------------------------------------------
norm_target_demoData <- normalize(target_demoData, norm_method="quant",
                                  desiredQuantile = .75, toElt = "q_norm")

assayDataElementNames(norm_target_demoData)

data.frame(assayData(norm_target_demoData)[["q_norm"]][seq_len(3), seq_len(3)])

## ----coercion to Seurat mistakes, error=TRUE----------------------------------
try({
as.Seurat(demoData)

as.Seurat(target_demoData, normData = "exprs")

as.Seurat(norm_target_demoData, normData = "exprs_norm")
})

## ----coercion to Seurat-------------------------------------------------------
demoSeurat <- as.Seurat(x = norm_target_demoData, normData = "q_norm")

demoSeurat # overall data object

head(demoSeurat, 3) # most important ROI metadata
demoSeurat@misc[1:8] # experiment data

head(demoSeurat@misc$sequencingMetrics) # sequencing metrics
head(demoSeurat@misc$QCMetrics$QCFlags) # QC metrics
head(demoSeurat@assays$GeoMx@meta.data) # gene metadata

## ----simple VlnPlot-----------------------------------------------------------
VlnPlot(demoSeurat, features = "nCount_GeoMx", pt.size = 0.1)

demoSeurat <- as.Seurat(norm_target_demoData, normData = "q_norm", ident = "cell_line")
VlnPlot(demoSeurat, features = "nCount_GeoMx", pt.size = 0.1)

## ----typical seurat analysis, message=FALSE-----------------------------------
demoSeurat <- FindVariableFeatures(demoSeurat)
demoSeurat <- ScaleData(demoSeurat)
demoSeurat <- RunPCA(demoSeurat, assay = "GeoMx", verbose = FALSE)
demoSeurat <- FindNeighbors(demoSeurat, reduction = "pca", dims = seq_len(30))
demoSeurat <- FindClusters(demoSeurat, verbose = FALSE)
demoSeurat <- RunUMAP(demoSeurat, reduction = "pca", dims = seq_len(30))

DimPlot(demoSeurat, reduction = "umap", label = TRUE, group.by = "cell_line")

## -----------------------------------------------------------------------------
data("nsclc", package = "SpatialDecon")

## ----rename columns, echo=FALSE-----------------------------------------------
#this data is from an old version, column names have been updated
#ensuring continuity with current version

nsclc@featureType <- "Target"

colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "NormFactorQ3"] <- "qFactors"
colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "NormFactorHK"] <- "hkFactors"

colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "RawReads"] <- "Raw"
colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "TrimmedReads"] <- "Trimmed"
colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "AlignedReads"] <- "Aligned"
colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "StitchedReads"] <- "Stitched"
colnames(protocolData(nsclc))[colnames(protocolData(nsclc)) == "SequencingSaturation"] <- "Saturated (%)"

protocolData(nsclc) <- protocolData(nsclc)[,-which(colnames(protocolData(nsclc)) %in% c("UID"))]

nsclc <- updateGeoMxSet(nsclc)

## ----GeoMx dataset with coordinates-------------------------------------------
nsclc

dim(nsclc)

data.frame(exprs(nsclc)[seq_len(5), seq_len(5)])

head(pData(nsclc))

## ----coercion to Seurat with coordinates--------------------------------------
nsclcSeurat <- as.Seurat(nsclc, normData = "exprs_norm", ident = "AOI.annotation", 
                         coordinates = c("x", "y"))

nsclcSeurat

VlnPlot(nsclcSeurat, features = "nCount_GeoMx", pt.size = 0.1)

## ----typical seurat analysis nsclc, message=FALSE-----------------------------
nsclcSeurat <- FindVariableFeatures(nsclcSeurat)
nsclcSeurat <- ScaleData(nsclcSeurat)
nsclcSeurat <- RunPCA(nsclcSeurat, assay = "GeoMx", verbose = FALSE)
nsclcSeurat <- FindNeighbors(nsclcSeurat, reduction = "pca", dims = seq_len(30))
nsclcSeurat <- FindClusters(nsclcSeurat, verbose = FALSE)
nsclcSeurat <- RunUMAP(nsclcSeurat, reduction = "pca", dims = seq_len(30))

DimPlot(nsclcSeurat, reduction = "umap", label = TRUE, group.by = "AOI.name")

## ----gene counts SpatialFeature-----------------------------------------------
tumor <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "Tumor"], 
                                             features = "nCount_GeoMx", pt.size.factor = 12) + 
  labs(title = "Tumor") + 
  theme(legend.position = "none") + 
  scale_fill_continuous(type = "viridis",
                        limits = c(min(nsclcSeurat$nCount_GeoMx), 
                                   max(nsclcSeurat$nCount_GeoMx))))

TME <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "TME"], 
                                           features = "nCount_GeoMx", pt.size.factor = 12) + 
  labs(title = "TME") + 
  theme(legend.position = "right") +
  scale_fill_continuous(type = "viridis", 
                        limits = c(min(nsclcSeurat$nCount_GeoMx),
                                   max(nsclcSeurat$nCount_GeoMx))))

wrap_plots(tumor, TME)

## ----A2M SpatialFeature-------------------------------------------------------
tumor <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "Tumor"], 
                                             features = "A2M", pt.size.factor = 12) + 
  labs(title = "Tumor") + 
  theme(legend.position = "none") + 
  scale_fill_continuous(type = "viridis",
                        limits = c(min(nsclcSeurat@assays$GeoMx$data["A2M",]), 
                                   max(nsclcSeurat@assays$GeoMx$data["A2M",]))))

TME <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "TME"], 
                                           features = "A2M", pt.size.factor = 12) + 
  labs(title = "TME") + 
  theme(legend.position = "right") +
  scale_fill_continuous(type = "viridis", 
                        limits = c(min(nsclcSeurat@assays$GeoMx$data["A2M",]),
                                   max(nsclcSeurat@assays$GeoMx$data["A2M",]))))

wrap_plots(tumor, TME)

## ----DE SpatialFeature--------------------------------------------------------
Idents(nsclcSeurat) <- nsclcSeurat$AOI.name
de_genes <- FindMarkers(nsclcSeurat, ident.1 = "Tumor", ident.2 = "TME")

de_genes <- de_genes[order(abs(de_genes$avg_log2FC), decreasing = TRUE),]
de_genes <- de_genes[is.finite(de_genes$avg_log2FC) & de_genes$p_val < 1e-25,]

gps <- list()

for(i in rownames(de_genes)[1:2]){
  print(data.frame(de_genes[i,]))
  
  tumor <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "Tumor"], 
                                               features = i, pt.size.factor = 12) + 
  labs(title = "Tumor") + 
  theme(legend.position = "none") + 
  scale_fill_continuous(type = "viridis",
                        limits = c(min(nsclcSeurat@assays$GeoMx$data[i,]), 
                                   max(nsclcSeurat@assays$GeoMx$data[i,]))))

  TME <- suppressMessages(SpatialFeaturePlot(nsclcSeurat[,nsclcSeurat$AOI.name == "TME"], 
                                             features = i, pt.size.factor = 12) + 
    labs(title = "TME") + 
    theme(legend.position = "right") +
    scale_fill_continuous(type = "viridis", 
                          limits = c(min(nsclcSeurat@assays$GeoMx$data[i,]),
                                     max(nsclcSeurat@assays$GeoMx$data[i,]))))
  
  gps[[i]] <- wrap_plots(tumor, TME)
}

print(gps)


## ----load spe-----------------------------------------------------------------
library(SpatialExperiment)

## ----coercion to SpatialExperiment mistakes, error=TRUE-----------------------
try({
as.SpatialExperiment(demoData)

as.SpatialExperiment(target_demoData, normData = "exprs")

as.SpatialExperiment(norm_target_demoData, normData = "exprs_norm")
})

## ----coercion to SpatialExperiment--------------------------------------------
demoSPE <- as.SpatialExperiment(norm_target_demoData, normData = "q_norm")

demoSPE # overall data object

data.frame(head(colData(demoSPE))) # most important ROI metadata

demoSPE@metadata[1:8] # experiment data

head(demoSPE@metadata$sequencingMetrics) # sequencing metrics
head(demoSPE@metadata$QCMetrics$QCFlags) # QC metrics
data.frame(head(rowData(demoSPE))) # gene metadata

## ----SpatialExperiment coercion-----------------------------------------------

nsclcSPE <- as.SpatialExperiment(nsclc, normData = "exprs_norm", 
                                 coordinates = c("x", "y"))

nsclcSPE

data.frame(head(spatialCoords(nsclcSPE)))

## ----graphing with SPE--------------------------------------------------------
figureData <- as.data.frame(cbind(colData(nsclcSPE), spatialCoords(nsclcSPE)))

figureData <- cbind(figureData, A2M=as.numeric(nsclcSPE@assays@data$GeoMx["A2M",]))

tumor <- ggplot(figureData[figureData$AOI.name == "Tumor",], aes(x=y, y=-x, color = A2M))+
  geom_point(size = 6)+
  scale_color_continuous(type = "viridis",
                        limits = c(min(figureData$A2M), 
                                   max(figureData$A2M)))+
  theme(legend.position = "none", panel.grid = element_blank(),
        panel.background = element_rect(fill = "white"),
        axis.title = element_blank(), axis.text = element_blank(), 
        axis.ticks = element_blank(), axis.line = element_blank())+
  labs(title = "Tumor")


TME <- ggplot(figureData[figureData$AOI.name == "TME",], aes(x=y, y=-x, color = A2M))+
  geom_point(size = 6)+
  scale_color_continuous(type = "viridis",
                        limits = c(min(figureData$A2M), 
                                   max(figureData$A2M))) +
  theme(panel.grid = element_blank(), 
        panel.background = element_rect(fill = "white"), axis.title = element_blank(), 
        axis.text = element_blank(), axis.ticks = element_blank(), axis.line = element_blank())+
  labs(title = "TME")

wrap_plots(tumor, TME)

## -----------------------------------------------------------------------------
sessionInfo()

