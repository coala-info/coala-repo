# Coercion of GeoMxSet to Seurat and SpatialExperiment Objects

#### Compiled: 2025-10-30

# Overview

This tutorial demonstrates how to coerce GeoMxSet objects into Seurat or SpatialExperiment objects and the subsequent analyses. For more examples of what analyses are available in these objects, look at these [Seurat](https://satijalab.org/seurat/articles/spatial_vignette.html) or [SpatialExperiment](https://bioconductor.org/packages/release/bioc/vignettes/SpatialExperiment/inst/doc/SpatialExperiment.html) vignettes.

# Data Processing

Data Processing should occur in GeomxTools. Due to the unique nature of the regions of interest (ROIs), it is recommended to use the preproccesing steps available in GeomxTools rather than the single-cell made preprocessing available in Seurat.

```
library(GeomxTools)
library(Seurat)
library(SpatialDecon)
library(patchwork)
```

```
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
```

After reading in the object, we will do a couple of QC steps.

1. Shift all 0 counts by 1
2. Flag low quality ROIs
3. Flag low quality probes
4. Remove low quality ROIs and probes

```
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
```

```
## Features  Samples
##     8707       88
```

```
dim(passedQC)
```

```
## Features  Samples
##     8698       83
```

Objects must be aggregated to Target level data before coercing. This changes the row (gene) information to be the gene name rather than the probe ID.

```
featureType(passedQC)
```

```
## [1] "Probe"
```

```
data.frame(assayData(passedQC)[["exprs"]][seq_len(3), seq_len(3)])
```

|  | DSP.1001250002642.A02.dcc | DSP.1001250002642.A03.dcc | DSP.1001250002642.A04.dcc |
| --- | --- | --- | --- |
| RTS0039454 | 294 | 239 | 6 |
| RTS0039455 | 270 | 281 | 6 |
| RTS0039456 | 255 | 238 | 3 |

```
target_demoData <- aggregateCounts(passedQC)

featureType(target_demoData)
```

```
## [1] "Target"
```

```
data.frame(assayData(target_demoData)[["exprs"]][seq_len(3), seq_len(3)])
```

|  | DSP.1001250002642.A02.dcc | DSP.1001250002642.A03.dcc | DSP.1001250002642.A04.dcc |
| --- | --- | --- | --- |
| ACTA2 | 328.286182 | 323.490808 | 6.081111 |
| FOXA2 | 4.919019 | 4.919019 | 6.942503 |
| NANOG | 2.954177 | 4.128918 | 8.359554 |

It is recommended to normalize using a GeoMx specific model before coercing. The normalized data is now in the assayData slot called “q\_norm”.

```
norm_target_demoData <- normalize(target_demoData, norm_method="quant",
                                  desiredQuantile = .75, toElt = "q_norm")

assayDataElementNames(norm_target_demoData)
```

```
## [1] "exprs"  "q_norm"
```

```
data.frame(assayData(norm_target_demoData)[["q_norm"]][seq_len(3), seq_len(3)])
```

|  | DSP.1001250002642.A02.dcc | DSP.1001250002642.A03.dcc | DSP.1001250002642.A04.dcc |
| --- | --- | --- | --- |
| ACTA2 | 349.571598 | 344.257297 | 3.968122 |
| FOXA2 | 5.237958 | 5.234795 | 4.530208 |
| NANOG | 3.145720 | 4.393974 | 5.454880 |

# Seurat

## Seurat Coercion

The three errors that can occur when trying to coerce to Seurat are:

1. object must be on the **target** level
2. object should be normalized, if you want raw data you can set *forceRaw* to TRUE
3. normalized count matrix name must be valid

```
as.Seurat(demoData)
```

```
## Error in as.Seurat.NanoStringGeoMxSet(demoData): Data must be on Target level before converting to a Seurat Object
```

```
as.Seurat(target_demoData, normData = "exprs")
```

```
## Error in as.Seurat.NanoStringGeoMxSet(target_demoData, normData = "exprs"): It is NOT recommended to use Seurat's normalization for GeoMx data.
##              Normalize using GeomxTools::normalize() or set forceRaw to TRUE if you want to continue with Raw data
```

```
as.Seurat(norm_target_demoData, normData = "exprs_norm")
```

```
## Error in as.Seurat.NanoStringGeoMxSet(norm_target_demoData, normData = "exprs_norm"): The normData name "exprs_norm" is not a valid assay name. Valid names are: exprs, q_norm
```

After coercing to a Seurat object all of the metadata is still accessible.

```
demoSeurat <- as.Seurat(x = norm_target_demoData, normData = "q_norm")

demoSeurat # overall data object
```

```
## An object of class Seurat
## 1821 features across 83 samples within 1 assay
## Active assay: GeoMx (1821 features, 0 variable features)
##  2 layers present: counts, data
```

```
head(demoSeurat, 3) # most important ROI metadata
```

|  | orig.ident | nCount\_GeoMx | nFeature\_GeoMx | slide name | scan name | panel | roi | segment | area | NegGeoMean\_Six-gene\_test\_v1\_v1.1 | NegGeoMean\_VnV\_GeoMx\_Hs\_CTA\_v1.2 | NegGeoSD\_Six-gene\_test\_v1\_v1.1 | NegGeoSD\_VnV\_GeoMx\_Hs\_CTA\_v1.2 | q\_norm\_qFactors | SampleID | aoi | cell\_line | roi\_rep | pool\_rep | slide\_rep |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | GeoMx | 63524.55 | 1821 | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 1 | Geometric Segment | 31318.73 | 1.487738 | 3.722752 | 1.560397 | 1.796952 | 0.9391100 | DSP-1001250002642-A02 | Geometric Segment-aoi-001 | HS578T | 1 | 1 | 1 |
| DSP-1001250002642-A03.dcc | GeoMx | 62357.01 | 1821 | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 2 | Geometric Segment | 31318.73 | 2.518775 | 3.068217 | 1.820611 | 1.806070 | 0.9396774 | DSP-1001250002642-A03 | Geometric Segment-aoi-001 | HS578T | 2 | 1 | 1 |
| DSP-1001250002642-A04.dcc | GeoMx | 82370.45 | 1821 | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 3 | Geometric Segment | 31318.73 | 2.847315 | 3.556275 | 1.654831 | 1.762066 | 1.5324910 | DSP-1001250002642-A04 | Geometric Segment-aoi-001 | HEL | 1 | 1 | 1 |

```
demoSeurat@misc[1:8] # experiment data
```

```
## $PKCFileName
##            VnV_GeoMx_Hs_CTA_v1.2            Six-gene_test_v1_v1.1
## "VnV Cancer Transcriptome Atlas"           "Six gene test custom"
##
## $PKCModule
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##    "VnV_GeoMx_Hs_CTA"    "Six-gene_test_v1"
##
## $PKCFileVersion
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                   1.2                   1.1
##
## $PKCFileDate
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##              "200518"              "200707"
##
## $AnalyteType
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                 "RNA"                 "RNA"
##
## $MinArea
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                 16000                 16000
##
## $MinNuclei
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                   200                   200
##
## $shiftedByOne
## [1] TRUE
```

```
head(demoSeurat@misc$sequencingMetrics) # sequencing metrics
```

|  | FileVersion | SoftwareVersion | Date | Plate\_ID | Well | SeqSetId | Raw | Trimmed | Stitched | Aligned | umiQ30 | rtsQ30 | DeduplicatedReads | NTC\_ID | NTC | Trimmed (%) | Stitched (%) | Aligned (%) | Saturated (%) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A02 | VH00121:3:AAAG2YWM5 | 646250 | 646250 | 616150 | 610390 | 0.9785 | 0.9804 | 312060 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.34236 | 94.45106 | 48.87531 |
| DSP-1001250002642-A03.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A03 | VH00121:3:AAAG2YWM5 | 629241 | 629241 | 603243 | 597280 | 0.9784 | 0.9811 | 305528 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.86836 | 94.92071 | 48.84677 |
| DSP-1001250002642-A04.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A04 | VH00121:3:AAAG2YWM5 | 831083 | 831083 | 798188 | 791804 | 0.9785 | 0.9801 | 394981 | DSP-1001250002642-A01.dcc | 7 | 100 | 96.04191 | 95.27376 | 50.11632 |
| DSP-1001250002642-A05.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A05 | VH00121:3:AAAG2YWM5 | 884485 | 884485 | 849060 | 842133 | 0.9796 | 0.9814 | 424162 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.99484 | 95.21168 | 49.63242 |
| DSP-1001250002642-A06.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A06 | VH00121:3:AAAG2YWM5 | 781936 | 781936 | 751930 | 744669 | 0.9779 | 0.9803 | 355121 | DSP-1001250002642-A01.dcc | 7 | 100 | 96.16260 | 95.23401 | 52.31156 |
| DSP-1001250002642-A07.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A07 | VH00121:3:AAAG2YWM5 | 703034 | 703034 | 674815 | 668726 | 0.9776 | 0.9797 | 341008 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.98611 | 95.12001 | 49.00632 |

```
head(demoSeurat@misc$QCMetrics$QCFlags) # QC metrics
```

|  | LowReads | LowTrimmed | LowStitched | LowAligned | LowSaturation | LowNegatives | HighNTC | LowArea |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A03.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A04.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A05.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A06.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A07.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |

```
head(demoSeurat@assays$GeoMx@meta.data) # gene metadata
```

| TargetName | Module | CodeClass | GeneID | SystematicName | TargetGroup | Negative |
| --- | --- | --- | --- | --- | --- | --- |
| ACTA2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 59 | ACTA2 | All Probes;Notch Signaling | FALSE |
| FOXA2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 3170 | FOXA2 | All Probes;Differentiation | FALSE |
| NANOG | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 79923, 388112 | NANOG, NANOGP8 | All Probes;EMT;Differentiation;Other Interleukin Signaling;Immortality & Stemness | FALSE |
| TRAC | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRAC | All Probes;Lymphocyte Regulation;TCR Signaling | FALSE |
| TRBC1/2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRBC1 | All Probes;Lymphocyte Regulation;TCR Signaling | FALSE |
| TRDC | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRDC | All Probes;TCR Signaling | FALSE |

All Seurat functionality is available after coercing. Outputs might differ if the *ident* value is set or not.

```
VlnPlot(demoSeurat, features = "nCount_GeoMx", pt.size = 0.1)
```

![](data:image/png;base64...)

```
demoSeurat <- as.Seurat(norm_target_demoData, normData = "q_norm", ident = "cell_line")
VlnPlot(demoSeurat, features = "nCount_GeoMx", pt.size = 0.1)
```

![](data:image/png;base64...)

## Simple GeoMx data workflow

Here is an example of a typical dimensional reduction workflow.

```
demoSeurat <- FindVariableFeatures(demoSeurat)
demoSeurat <- ScaleData(demoSeurat)
demoSeurat <- RunPCA(demoSeurat, assay = "GeoMx", verbose = FALSE)
demoSeurat <- FindNeighbors(demoSeurat, reduction = "pca", dims = seq_len(30))
demoSeurat <- FindClusters(demoSeurat, verbose = FALSE)
demoSeurat <- RunUMAP(demoSeurat, reduction = "pca", dims = seq_len(30))

DimPlot(demoSeurat, reduction = "umap", label = TRUE, group.by = "cell_line")
```

![](data:image/png;base64...)

## In-depth GeoMx data workflow

Here is a work through of a more indepth DSP dataset. This is a non-small cell lung cancer (nsclc) tissue sample that has an ROI strategy to simulate a visium dataset (55 um circles evenly spaced apart). It was segmented on tumor and non-tumor.

```
data("nsclc", package = "SpatialDecon")
```

```
nsclc
```

```
## NanoStringGeoMxSet (storageMode: lockedEnvironment)
## assayData: 1700 features, 199 samples
##   element names: exprs, exprs_norm
## protocolData
##   sampleNames: ROI01Tumor ROI01TME ... ROI100TME (199 total)
##   varLabels: Mask.type Raw ... hkFactors (17 total)
##   varMetadata: labelDescription
## phenoData
##   sampleNames: ROI01Tumor ROI01TME ... ROI100TME (199 total)
##   varLabels: Sample_ID Tissue ... istumor (10 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: ABCF1 ABL1 ... LAG3 (1700 total)
##   fvarLabels: TargetName HUGOSymbol ... Negative (9 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: kiloplex with cell type spike-in [legacy panel]
## signature: none
## feature: Target
## analyte: RNA
```

```
dim(nsclc)
```

```
## Features  Samples
##     1700      199
```

```
data.frame(exprs(nsclc)[seq_len(5), seq_len(5)])
```

|  | ROI01Tumor | ROI01TME | ROI02Tumor | ROI02TME | ROI03Tumor |
| --- | --- | --- | --- | --- | --- |
| ABCF1 | 55 | 26 | 47 | 30 | 102 |
| ABL1 | 21 | 22 | 27 | 18 | 47 |
| ACVR1B | 89 | 30 | 57 | 29 | 122 |
| ACVR1C | 9 | 7 | 4 | 8 | 14 |
| ACVR2A | 14 | 15 | 9 | 12 | 22 |

```
head(pData(nsclc))
```

|  | Sample\_ID | Tissue | Slide.name | ROI | AOI.name | AOI.annotation | x | y | nuclei | istumor |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ROI01Tumor | ICP20th-L11-ICPKilo-ROI01-Tumor-A02 | L11 | ICPKilo | ROI01 | Tumor | PanCK | 0 | 8000 | 572 | TRUE |
| ROI01TME | ICP20th-L11-ICPKilo-ROI01-TME-A03 | L11 | ICPKilo | ROI01 | TME | TME | 0 | 8000 | 733 | FALSE |
| ROI02Tumor | ICP20th-L11-ICPKilo-ROI02-Tumor-A04 | L11 | ICPKilo | ROI02 | Tumor | PanCK | 600 | 8000 | 307 | TRUE |
| ROI02TME | ICP20th-L11-ICPKilo-ROI02-TME-A05 | L11 | ICPKilo | ROI02 | TME | TME | 600 | 8000 | 697 | FALSE |
| ROI03Tumor | ICP20th-L11-ICPKilo-ROI03-Tumor-A06 | L11 | ICPKilo | ROI03 | Tumor | PanCK | 1200 | 8000 | 583 | TRUE |
| ROI03TME | ICP20th-L11-ICPKilo-ROI03-TME-A07 | L11 | ICPKilo | ROI03 | TME | TME | 1200 | 8000 | 484 | FALSE |

When coercing, we can add the coordinate columns allowing for spatial graphing using Seurat.

```
nsclcSeurat <- as.Seurat(nsclc, normData = "exprs_norm", ident = "AOI.annotation",
                         coordinates = c("x", "y"))

nsclcSeurat
```

```
## An object of class Seurat
## 1700 features across 199 samples within 1 assay
## Active assay: GeoMx (1700 features, 0 variable features)
##  2 layers present: counts, data
##  1 image present: image
```

```
VlnPlot(nsclcSeurat, features = "nCount_GeoMx", pt.size = 0.1)
```

![](data:image/png;base64...)

```
nsclcSeurat <- FindVariableFeatures(nsclcSeurat)
nsclcSeurat <- ScaleData(nsclcSeurat)
nsclcSeurat <- RunPCA(nsclcSeurat, assay = "GeoMx", verbose = FALSE)
nsclcSeurat <- FindNeighbors(nsclcSeurat, reduction = "pca", dims = seq_len(30))
nsclcSeurat <- FindClusters(nsclcSeurat, verbose = FALSE)
nsclcSeurat <- RunUMAP(nsclcSeurat, reduction = "pca", dims = seq_len(30))

DimPlot(nsclcSeurat, reduction = "umap", label = TRUE, group.by = "AOI.name")
```

![](data:image/png;base64...)

### Spatial Graphing

Because this dataset is segmented, we need to separate the tumor and TME sections before using the spatial graphing. These Seurat functions were created for Visium data, so they can only plot the same sized circles.

Here we are showing the gene counts in each ROI separated by segment.

```
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
```

![](data:image/png;base64...)

Here we show the count for *A2M*

```
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
```

![](data:image/png;base64...) Using the FindMarkers built in function from Seurat, we can determine the most differentially expressed genes in *Tumor* and *TME*

```
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
```

```
##                p_val avg_log2FC pct.1 pct.2    p_val_adj
## CEACAM6 1.756187e-31    754.903     1     1 2.985517e-28
```

```
##            p_val avg_log2FC pct.1 pct.2    p_val_adj
## LYZ 9.276639e-32  -615.2034     1     1 1.577029e-28
```

```
print(gps)
```

```
## $CEACAM6
```

![](data:image/png;base64...)

```
##
## $LYZ
```

![](data:image/png;base64...)

# SpatialExperiment

SpatialExperiment is an S4 class inheriting from SingleCellExperiment. It is meant as a data storage object rather than an analysis suite like Seurat. Because of this, this section won’t have the fancy analysis outputs like the Seurat section had but will show where in the object all the pieces are stored.

```
library(SpatialExperiment)
```

## SpatialExperiment Coercion

The three errors that can occur when trying to coerce to SpatialExperiment are:

1. object must be on the **target** level
2. object should be normalized, if you want raw data you can set *forceRaw* to TRUE
3. normalized count matrix name must be valid

```
as.SpatialExperiment(demoData)
```

```
## Error in as.SpatialExperiment.NanoStringGeoMxSet(demoData): Data must be on Target level before converting to a SpatialExperiment Object
```

```
as.SpatialExperiment(target_demoData, normData = "exprs")
```

```
## Error in as.SpatialExperiment.NanoStringGeoMxSet(target_demoData, normData = "exprs"): It is NOT recommended to use SpatialExperiment's normalization for GeoMx data.
##              Normalize using GeomxTools::normalize() or set forceRaw to TRUE if you want to continue with Raw data
```

```
as.SpatialExperiment(norm_target_demoData, normData = "exprs_norm")
```

```
## Error in as.SpatialExperiment.NanoStringGeoMxSet(norm_target_demoData, : The normData name "exprs_norm" is not a valid assay name. Valid names are: exprs, q_norm
```

After coercing to a SpatialExperiment object all of the metadata is still accessible.

```
demoSPE <- as.SpatialExperiment(norm_target_demoData, normData = "q_norm")

demoSPE # overall data object
```

```
## class: SpatialExperiment
## dim: 1821 83
## metadata(11): PKCFileName PKCModule ... sequencingMetrics QCMetrics
## assays(1): GeoMx
## rownames(1821): ACTA2 FOXA2 ... C1orf43 SNRPD3
## rowData names(7): TargetName Module ... TargetGroup Negative
## colnames(83): DSP-1001250002642-A02.dcc DSP-1001250002642-A03.dcc ...
##   DSP-1001250002642-H04.dcc DSP-1001250002642-H05.dcc
## colData names(18): slide name scan name ... slide_rep sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(0) :
## imgData names(0):
```

```
data.frame(head(colData(demoSPE))) # most important ROI metadata
```

|  | slide.name | scan.name | panel | roi | segment | area | NegGeoMean\_Six.gene\_test\_v1\_v1.1 | NegGeoMean\_VnV\_GeoMx\_Hs\_CTA\_v1.2 | NegGeoSD\_Six.gene\_test\_v1\_v1.1 | NegGeoSD\_VnV\_GeoMx\_Hs\_CTA\_v1.2 | q\_norm\_qFactors | SampleID | aoi | cell\_line | roi\_rep | pool\_rep | slide\_rep | sample\_id |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 1 | Geometric Segment | 31318.73 | 1.487738 | 3.722752 | 1.560397 | 1.796952 | 0.9391100 | DSP-1001250002642-A02 | Geometric Segment-aoi-001 | HS578T | 1 | 1 | 1 | sample01 |
| DSP-1001250002642-A03.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 2 | Geometric Segment | 31318.73 | 2.518775 | 3.068217 | 1.820611 | 1.806070 | 0.9396774 | DSP-1001250002642-A03 | Geometric Segment-aoi-001 | HS578T | 2 | 1 | 1 | sample01 |
| DSP-1001250002642-A04.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 3 | Geometric Segment | 31318.73 | 2.847315 | 3.556275 | 1.654831 | 1.762066 | 1.5324910 | DSP-1001250002642-A04 | Geometric Segment-aoi-001 | HEL | 1 | 1 | 1 | sample01 |
| DSP-1001250002642-A05.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 4 | Geometric Segment | 31318.73 | 2.632148 | 3.785600 | 2.042222 | 1.793823 | 1.6725916 | DSP-1001250002642-A05 | Geometric Segment-aoi-001 | HEL | 2 | 1 | 1 | sample01 |
| DSP-1001250002642-A06.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 5 | Geometric Segment | 31318.73 | 2.275970 | 4.064107 | 1.812577 | 1.839165 | 1.2351225 | DSP-1001250002642-A06 | Geometric Segment-aoi-001 | U118MG | 1 | 1 | 1 | sample01 |
| DSP-1001250002642-A07.dcc | 6panel-old-slide1 (PTL-10891) | cw005 (PTL-10891) Slide1 | (v1.2) VnV Cancer Transcriptome Atlas, (v1.0) Six gene test custom | 6 | Geometric Segment | 31318.73 | 2.059767 | 4.153701 | 1.952628 | 1.626391 | 1.2229991 | DSP-1001250002642-A07 | Geometric Segment-aoi-001 | U118MG | 2 | 1 | 1 | sample01 |

```
demoSPE@metadata[1:8] # experiment data
```

```
## $PKCFileName
##            VnV_GeoMx_Hs_CTA_v1.2            Six-gene_test_v1_v1.1
## "VnV Cancer Transcriptome Atlas"           "Six gene test custom"
##
## $PKCModule
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##    "VnV_GeoMx_Hs_CTA"    "Six-gene_test_v1"
##
## $PKCFileVersion
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                   1.2                   1.1
##
## $PKCFileDate
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##              "200518"              "200707"
##
## $AnalyteType
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                 "RNA"                 "RNA"
##
## $MinArea
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                 16000                 16000
##
## $MinNuclei
## VnV_GeoMx_Hs_CTA_v1.2 Six-gene_test_v1_v1.1
##                   200                   200
##
## $shiftedByOne
## [1] TRUE
```

```
head(demoSPE@metadata$sequencingMetrics) # sequencing metrics
```

|  | FileVersion | SoftwareVersion | Date | Plate\_ID | Well | SeqSetId | Raw | Trimmed | Stitched | Aligned | umiQ30 | rtsQ30 | DeduplicatedReads | NTC\_ID | NTC | Trimmed (%) | Stitched (%) | Aligned (%) | Saturated (%) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A02 | VH00121:3:AAAG2YWM5 | 646250 | 646250 | 616150 | 610390 | 0.9785 | 0.9804 | 312060 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.34236 | 94.45106 | 48.87531 |
| DSP-1001250002642-A03.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A03 | VH00121:3:AAAG2YWM5 | 629241 | 629241 | 603243 | 597280 | 0.9784 | 0.9811 | 305528 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.86836 | 94.92071 | 48.84677 |
| DSP-1001250002642-A04.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A04 | VH00121:3:AAAG2YWM5 | 831083 | 831083 | 798188 | 791804 | 0.9785 | 0.9801 | 394981 | DSP-1001250002642-A01.dcc | 7 | 100 | 96.04191 | 95.27376 | 50.11632 |
| DSP-1001250002642-A05.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A05 | VH00121:3:AAAG2YWM5 | 884485 | 884485 | 849060 | 842133 | 0.9796 | 0.9814 | 424162 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.99484 | 95.21168 | 49.63242 |
| DSP-1001250002642-A06.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A06 | VH00121:3:AAAG2YWM5 | 781936 | 781936 | 751930 | 744669 | 0.9779 | 0.9803 | 355121 | DSP-1001250002642-A01.dcc | 7 | 100 | 96.16260 | 95.23401 | 52.31156 |
| DSP-1001250002642-A07.dcc | 0.1 | 1.0.0 | 2020-07-14 | 1001250002642 | A07 | VH00121:3:AAAG2YWM5 | 703034 | 703034 | 674815 | 668726 | 0.9776 | 0.9797 | 341008 | DSP-1001250002642-A01.dcc | 7 | 100 | 95.98611 | 95.12001 | 49.00632 |

```
head(demoSPE@metadata$QCMetrics$QCFlags) # QC metrics
```

|  | LowReads | LowTrimmed | LowStitched | LowAligned | LowSaturation | LowNegatives | HighNTC | LowArea |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DSP-1001250002642-A02.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A03.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A04.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A05.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A06.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |
| DSP-1001250002642-A07.dcc | FALSE | FALSE | FALSE | FALSE | FALSE | TRUE | FALSE | FALSE |

```
data.frame(head(rowData(demoSPE))) # gene metadata
```

|  | TargetName | Module | CodeClass | GeneID | SystematicName | TargetGroup | Negative |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ACTA2 | ACTA2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 59 | ACTA2 | All Probes;Notch Signaling | FALSE |
| FOXA2 | FOXA2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 3170 | FOXA2 | All Probes;Differentiation | FALSE |
| NANOG | NANOG | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | 79923, 388112 | NANOG, NANOGP8 | All Probes;EMT;Differentiation;Other Interleukin Signaling;Immortality & Stemness | FALSE |
| TRAC | TRAC | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRAC | All Probes;Lymphocyte Regulation;TCR Signaling | FALSE |
| TRBC1/2 | TRBC1/2 | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRBC1 | All Probes;Lymphocyte Regulation;TCR Signaling | FALSE |
| TRDC | TRDC | VnV\_GeoMx\_Hs\_CTA\_v1.2 | Endogenous | NA | TRDC | All Probes;TCR Signaling | FALSE |

When coercing, we can add the coordinate columns and they will be appended to the correct location in SpatialExperiment

```
nsclcSPE <- as.SpatialExperiment(nsclc, normData = "exprs_norm",
                                 coordinates = c("x", "y"))

nsclcSPE
```

```
## class: SpatialExperiment
## dim: 1700 199
## metadata(1): sequencingMetrics
## assays(1): GeoMx
## rownames(1700): ABCF1 ABL1 ... TNFSF4 LAG3
## rowData names(9): TargetName HUGOSymbol ... GlobalOutliers Negative
## colnames(199): ROI01Tumor ROI01TME ... ROI100Tumor ROI100TME
## colData names(20): Sample_ID Tissue ... hkFactors sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

```
data.frame(head(spatialCoords(nsclcSPE)))
```

|  | x | y |
| --- | --- | --- |
| ROI01Tumor | 0 | 8000 |
| ROI01TME | 0 | 8000 |
| ROI02Tumor | 600 | 8000 |
| ROI02TME | 600 | 8000 |
| ROI03Tumor | 1200 | 8000 |
| ROI03TME | 1200 | 8000 |

With the coordinates and the metadata, we can create spatial graphing figures similar to Seurat’s. To get the same orientation as Seurat we must swap the axes and flip the y.

```
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
```

![](data:image/png;base64...)

# Image Overlays

The free-handed nature of Region of Interest (ROI) selection in a GeoMx experiment makes visualization on top of the image difficult in packages designed for different data. We created [SpatialOmicsOverlay](https://github.com/Nanostring-Biostats/SpatialOmicsOverlay) specifically to visualize and analyze these types of ROIs in a GeoMx experiment and the immunofluorescent-guided segmentation process.

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] future_1.67.0               patchwork_1.3.2
## [11] SpatialDecon_1.20.0         Seurat_5.3.1
## [13] SeuratObject_5.2.0          sp_2.2-0
## [15] ggiraph_0.9.2               EnvStats_3.1.0
## [17] GeomxTools_3.14.0           NanoStringNCTools_1.18.0
## [19] ggplot2_4.0.0               S4Vectors_0.48.0
## [21] Biobase_2.70.0              BiocGenerics_0.56.0
## [23] generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22        splines_4.5.1           later_1.4.4
##   [4] R.oo_1.27.1             tibble_3.3.0            cellranger_1.1.0
##   [7] polyclip_1.10-7         fastDummies_1.7.5       lifecycle_1.0.4
##  [10] Rdpack_2.6.4            globals_0.18.0          lattice_0.22-7
##  [13] MASS_7.3-65             magrittr_2.0.4          limma_3.66.0
##  [16] plotly_4.11.0           sass_0.4.10             rmarkdown_2.30
##  [19] jquerylib_0.1.4         yaml_2.3.10             httpuv_1.6.16
##  [22] otel_0.2.0              sctransform_0.4.2       spam_2.11-1
##  [25] spatstat.sparse_3.1-0   reticulate_1.44.0       cowplot_1.2.0
##  [28] pbapply_1.7-4           minqa_1.2.8             RColorBrewer_1.1-3
##  [31] abind_1.4-8             R.cache_0.17.0          Rtsne_0.17
##  [34] R.utils_2.13.0          purrr_1.1.0             gdtools_0.4.4
##  [37] ggrepel_0.9.6           irlba_2.3.5.1           listenv_0.9.1
##  [40] spatstat.utils_3.2-0    pheatmap_1.0.13         goftest_1.2-3
##  [43] RSpectra_0.16-2         spatstat.random_3.4-2   fitdistrplus_1.2-4
##  [46] parallelly_1.45.1       DelayedArray_0.36.0     codetools_0.2-20
##  [49] tidyselect_1.2.1        farver_2.1.2            lme4_1.1-37
##  [52] spatstat.explore_3.5-3  jsonlite_2.0.0          progressr_0.17.0
##  [55] ggridges_0.5.7          survival_3.8-3          systemfonts_1.3.1
##  [58] tools_4.5.1             ica_1.0-3               Rcpp_1.1.0
##  [61] glue_1.8.0              SparseArray_1.10.0      gridExtra_2.3
##  [64] xfun_0.53               ggthemes_5.1.0          dplyr_1.1.4
##  [67] withr_3.0.2             numDeriv_2016.8-1.1     fastmap_1.2.0
##  [70] GGally_2.4.0            repmis_0.5.1            boot_1.3-32
##  [73] digest_0.6.37           R6_2.6.1                mime_0.13
##  [76] scattermore_1.2         tensor_1.5.1            dichromat_2.0-0.1
##  [79] spatstat.data_3.1-9     R.methodsS3_1.8.2       tidyr_1.3.1
##  [82] fontLiberation_0.1.0    data.table_1.17.8       S4Arrays_1.10.0
##  [85] httr_1.4.7              htmlwidgets_1.6.4       ggstats_0.11.0
##  [88] uwot_0.2.3              pkgconfig_2.0.3         gtable_0.3.6
##  [91] lmtest_0.9-40           S7_0.2.0                XVector_0.50.0
##  [94] htmltools_0.5.8.1       fontBitstreamVera_0.1.1 dotCall64_1.2
##  [97] scales_1.4.0            png_0.1-8               logNormReg_0.5-0
## [100] spatstat.univar_3.1-4   reformulas_0.4.2        knitr_1.50
## [103] reshape2_1.4.4          rjson_0.2.23            nlme_3.1-168
## [106] nloptr_2.2.1            cachem_1.1.0            zoo_1.8-14
## [109] stringr_1.5.2           KernSmooth_2.23-26      parallel_4.5.1
## [112] miniUI_0.1.2            vipor_0.4.7             ggrastr_1.0.2
## [115] pillar_1.11.1           grid_4.5.1              vctrs_0.6.5
## [118] RANN_2.6.2              promises_1.4.0          xtable_1.8-4
## [121] cluster_2.1.8.1         beeswarm_0.4.0          evaluate_1.0.5
## [124] magick_2.9.0            cli_3.6.5               compiler_4.5.1
## [127] rlang_1.1.6             crayon_1.5.3            future.apply_1.20.0
## [130] labeling_0.4.3          plyr_1.8.9              ggbeeswarm_0.7.2
## [133] stringi_1.8.7           viridisLite_0.4.2       deldir_2.0-4
## [136] lmerTest_3.1-3          Biostrings_2.78.0       lazyeval_0.2.2
## [139] spatstat.geom_3.6-0     fontquiver_0.2.1        Matrix_1.7-4
## [142] RcppHNSW_0.6.0          statmod_1.5.1           shiny_1.11.1
## [145] rbibutils_2.3           ROCR_1.0-11             igraph_2.2.1
## [148] bslib_0.9.0             readxl_1.4.5
```