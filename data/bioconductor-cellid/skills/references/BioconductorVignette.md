# CelliD Vignette

Akira Cortal1 and Antonio Rausell1\*

1Paris University, Imagine Institute, 75015 Paris, France, EU

\*akira.cortal@institutimagine.org

#### 29 October 2025

#### Abstract

CelliD is a clustering-free multivariate statistical method for the robust extraction of per-cell gene signatures from single-cell RNA-seq. CelliD allows unbiased cell identity recognition across different donors, tissues-of-origin, model organisms and single-cell omics protocols. We present here the main functionalities of the CelliD R package through several use cases. This vignette illustrates the use of the CelliD R package.

#### Package

CelliD 1.18.0

# Contents

* [1 Contact](#contact)
* [2 Installation](#installation)
  + [2.1 Common installation issues](#common-installation-issues)
* [3 Data and libraries](#data-and-libraries)
  + [3.1 Load libraries](#load-libraries)
  + [3.2 Load Data](#load-data)
* [4 Data input and preprocessing steps](#data-input-and-preprocessing-steps)
  + [4.1 Restricting the analysis to protein-coding genes](#restricting-the-analysis-to-protein-coding-genes)
  + [4.2 Data input formats](#data-input-formats)
  + [4.3 Creating a Seurat object, and processing and normalization of the gene expression matrix](#creating-a-seurat-object-and-processing-and-normalization-of-the-gene-expression-matrix)
* [5 CelliD dimensionality reduction through MCA](#cellid-dimensionality-reduction-through-mca)
  + [5.1 Alternative state-of-the-art dimensionality reduction techniques](#alternative-state-of-the-art-dimensionality-reduction-techniques)
* [6 CelliD automatic cell type prediction using pre-established marker lists](#cellid-automatic-cell-type-prediction-using-pre-established-marker-lists)
  + [6.1 Obtaining pancreatic cell-type gene signatures](#obtaining-pancreatic-cell-type-gene-signatures)
  + [6.2 Obtaining gene signatures for all cell types in the Panglao database](#obtaining-gene-signatures-for-all-cell-types-in-the-panglao-database)
  + [6.3 Assessing per-cell gene signature enrichments against pre-established marker lists](#assessing-per-cell-gene-signature-enrichments-against-pre-established-marker-lists)
* [7 CelliD cell-to-cell matching and label transferring across datasets](#cellid-cell-to-cell-matching-and-label-transferring-across-datasets)
  + [7.1 CelliD(c) and CelliD(g): per-cell and per-group gene signature extraction from a reference dataset](#cellidc-and-cellidg-per-cell-and-per-group-gene-signature-extraction-from-a-reference-dataset)
  + [7.2 Preprocessing and MCA assessment of the Segerstolpe dataset used as the query set](#preprocessing-and-mca-assessment-of-the-segerstolpe-dataset-used-as-the-query-set)
  + [7.3 CelliD(c): cell-to-cell matching and label transferring across datasets](#cellidc-cell-to-cell-matching-and-label-transferring-across-datasets)
  + [7.4 CelliD(g): group-to-cell matching and label transferring across datasets](#cellidg-group-to-cell-matching-and-label-transferring-across-datasets)
* [8 CelliD per-cell functionnal annotation against functional ontologies and pathway databases](#cellid-per-cell-functionnal-annotation-against-functional-ontologies-and-pathway-databases)
* [Session info](#session-info)

# 1 Contact

akira.cortal@institutimagine.org
antonio.rausell@institutimagine.org

# 2 Installation

CelliD is based on R version >= 4.1. It contains dependencies with several CRAN and Biocondutor packages as described in the [Description file](https://github.com/cbl-imagine/CelliD/blob/master/DESCRIPTION)

To install CelliD, set the repositories option to enable downloading Bioconductor dependencies:

```
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("ggpubr")) install.packages("ggpubr")
BiocManager::install("CelliD")
```

## 2.1 Common installation issues

macOS users might experience installation issues related to Gfortran library. To solve this, download and install the appropriate gfortran dmg file from <https://github.com/fxcoudert/gfortran-for-macOS>

# 3 Data and libraries

## 3.1 Load libraries

```
library(CelliD)
```

```
## Warning: replacing previous import 'data.table::shift' by 'tictoc::shift' when
## loading 'CelliD'
```

```
library(tidyverse) # general purpose library for data handling
library(ggpubr) #library for plotting
```

## 3.2 Load Data

To illustrate CelliD usage we will use throughout this vignette two publicly available pancreas single-cell RNA-seq data sets provided in [Baron et al. 2016](https://doi.org/10.1016/j.cels.2016.08.011) and [Segerstolpe et al. 2016](https://doi.org/10.1016/j.cmet.2016.08.020).
We provide here for convenience the R objects with the raw counts gene expression matrices and associated metadata

```
#read data
BaronMatrix   <- readRDS(url("https://storage.googleapis.com/cellid-cbl/BaronMatrix.rds"))
BaronMetaData <- readRDS(url("https://storage.googleapis.com/cellid-cbl/BaronMetaData.rds"))
SegerMatrix   <- readRDS(url("https://storage.googleapis.com/cellid-cbl/SegerstolpeMatrix.rds"))
SegerMetaData <- readRDS(url("https://storage.googleapis.com/cellid-cbl/SegerstolpeMetaData2.rds"))
```

# 4 Data input and preprocessing steps

## 4.1 Restricting the analysis to protein-coding genes

While CelliD can handle all types of genes, we recommend restricting the analysis to protein-coding genes. CelliD package provides two gene lists (HgProteinCodingGenes and MgProteinCodingGenes) containing a background set of 19308 and 21914 protein-coding genes from human and mouse, respectively, obtained from BioMart Ensembl release 100, version April 2020 (GrCH38.p13 for human, and GRCm38.p6 for mouse). Gene identifiers here correspond to official gene symbols.

```
# Restricting to protein-coding genes
data("HgProteinCodingGenes")
BaronMatrixProt <- BaronMatrix[rownames(BaronMatrix) %in% HgProteinCodingGenes,]
SegerMatrixProt <- SegerMatrix[rownames(SegerMatrix) %in% HgProteinCodingGenes,]
```

## 4.2 Data input formats

CelliD use as input single cell data in the form of specific S4objects. Currently supported files are SingleCellExperiment from Bioconductor and Seurat Version 3 from CRAN. For downstream analyses, gene identifiers corresponding to official gene symbols are used.

## 4.3 Creating a Seurat object, and processing and normalization of the gene expression matrix

Library size normalization is carried out by rescaling counts to a common library size of 10000. Log transformation is performed after adding a pseudo-count of 1. Genes expressing at least one count in less than 5 cells are removed. These steps mimic the standard Seurat workflow described [here](https://satijalab.org/seurat/v3.1/pbmc3k_tutorial.html).

```
# Create Seurat object  and remove remove low detection genes
Baron <- CreateSeuratObject(counts = BaronMatrixProt, project = "Baron", min.cells = 5, meta.data = BaronMetaData)
Seger <- CreateSeuratObject(counts = SegerMatrixProt, project = "Segerstolpe", min.cells = 5, meta.data = SegerMetaData)

# Library-size normalization, log-transformation, and centering and scaling of gene expression values
Baron <- NormalizeData(Baron)
Baron <- ScaleData(Baron, features = rownames(Baron))
```

While this vignette only illustrates the use of CelliD on single-cell RNA-seq data, we note that the package can handle other types of gene matrices, e.g sci-ATAC gene activity score matrices.

# 5 CelliD dimensionality reduction through MCA

CelliD is based on Multiple Correspondence Analysis (MCA), a multivariate method that allows the simultaneous representation of both cells and genes in the same low dimensional vector space. In such space, euclidean distances between genes and cells are computed, and per-cell gene rankings are obtained. The top ‘n’ closest genes to a given cell will be defined as its gene signature. Per-cell gene signatures will be obtained in a later section of this vignette.

To perform MCA dimensionality reduction, the command `RunMCA` is used:

```
Baron <- RunMCA(Baron)
```

```
## Warning: The `slot` argument of `GetAssayData()` is deprecated as of SeuratObject 5.0.0.
## ℹ Please use the `layer` argument instead.
## ℹ The deprecated feature was likely used in the CelliD package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Computing Fuzzy Matrix
```

```
## 6.689 sec elapsed
```

```
## Computing SVD
```

```
## 116.513 sec elapsed
```

```
## Computing Coordinates
```

```
## 14.273 sec elapsed
```

The `DimPlotMC` command allows to visualize both cells and selected gene lists in MCA low dimensional space.

```
DimPlotMC(Baron, reduction = "mca", group.by = "cell.type", features = c("CTRL", "INS", "MYZAP", "CDH11"), as.text = TRUE) + ggtitle("MCA with some key gene markers")
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the CelliD package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning in geom_point(data = featureData, mapping = aes_string(x = DIM1, :
## Ignoring unknown aesthetics: text
```

```
## Warning in ggrepel::geom_text_repel(data = featureData, mapping = aes_string(x
## = DIM1, : Ignoring unknown aesthetics: text
```

![](data:image/png;base64...)
In the previous plot we colored cells according to the pre-established cell type annotations available as metadata (“cell.type”) and as provided in Baron et al. 2016. No clustering step was performed here. In the common scenario where such annotations were not available, the `DimPlotMC` function would represent cells as red colored dots, and genes as black crosses. To represent all genes in the previous plot, just remove the “features” parameter from the previous command, so that the `DimPlotMC` function takes the default value.

## 5.1 Alternative state-of-the-art dimensionality reduction techniques

For the sake of comparisson, state-of-the-art dimensionality reduction techniques such as PCA, UMAP and tSNE can be obtained as follows:

```
Baron <- RunPCA(Baron, features = rownames(Baron))
```

```
## PC_ 1
## Positive:  IFITM3, ZFP36L1, CDC42EP1, TMSB10, PMEPA1, YBX3, SOX4, IL32, TMSB4X, RHOC
##     S100A11, TACSTD2, TM4SF1, KRT7, IFITM2, CD44, FLNA, MSN, S100A16, MYH9
##     SDC4, LGALS3, SERPING1, PRSS8, SERPINA3, ITGA2, COL18A1, GSTP1, SAT1, DDIT4
## Negative:  PCSK1N, CPE, SCG5, PTPRN, CHGA, CHGB, GNAS, SCGN, SCG2, CD99
##     PAM, PEMT, VGF, PPP1R1A, BEX1, PCSK2, KIAA1324, TTR, PAX6, IDS
##     NLRP1, SLC30A8, EEF1A2, UCHL1, GAD2, APLP1, SYT7, NEUROD1, ERO1B, TMOD1
## PC_ 2
## Positive:  CELA3A, PRSS1, CELA3B, CTRC, CTRB1, PRSS2, CLPS, CPA1, PNLIPRP1, PLA2G1B
##     CPA2, CELA2A, CTRB2, CPB1, KLK1, SYCN, REG1A, PNLIP, REG1B, GP2
##     CUZD1, SPINK1, PRSS3, CTRL, CELA2B, FOXD2, REG3G, MGST1, PDIA2, AMY2A
## Negative:  PSAP, IGFBP7, COL18A1, APP, CALR, ITGB1, PKM, LGALS3BP, CD81, ITM2B
##     GNAI2, GRN, APLP2, CTSD, CDK2AP1, LAMP1, PXDN, SPARC, ATP1A1, MMP14
##     ITGA5, PLXNB2, TIMP1, FSTL1, COL4A1, CALD1, CTSB, NBL1, HSPG2, FLNA
## PC_ 3
## Positive:  SPARC, COL4A1, ENG, IGFBP4, COL6A2, PDGFRB, BGN, PXDN, COL15A1, COL3A1
##     COL1A2, CYGB, AEBP1, ADAMTS4, COL6A3, HTRA3, EMILIN1, LRRC32, CRISPLD2, COL1A1
##     COL5A3, C11orf96, LAMA4, MMP2, COL6A1, COL5A1, ITGA1, TIMP3, HIC1, COL5A2
## Negative:  KRT19, TACSTD2, KRT7, SPINT2, ELF3, KRT8, ANXA4, PRSS8, SERINC2, SPINT1
##     CDH1, LCN2, CLDN7, CLDN4, CFB, CD24, SERPINA5, CFTR, KRT18, CLDN1
##     MMP7, LGALS4, ST14, C3, SDC4, LAD1, S100A14, SLC4A4, PTPRF, ABCC3
## PC_ 4
## Positive:  INS, HADH, IAPP, PCSK1, ADCYAP1, TIMP2, IGF2, DLK1, GSN, NPTX2
##     TSPAN13, PDX1, VAT1L, RPS25, WLS, RPL7, RPL24, MAFA, SLC6A6, SYT13
##     ELMO1, DNAJB9, UCHL1, RPL3, RGS16, RPS6, RBP4, PKIB, TGFBR3, RPL17
## Negative:  GCG, GC, TM4SF4, CLU, TMEM176B, IRX2, TTR, TMEM176A, FEV, F10
##     FXYD5, CRYBA2, SMIM24, SERPINA1, FXYD3, PCSK2, ARX, ALDH1A1, LOXL4, B2M
##     PAPPA2, CD82, GPX3, FXYD6, GLS, MUC13, VSTM2L, EGFL7, RGS4, COTL1
## PC_ 5
## Positive:  COL6A3, COL1A2, PDGFRB, COL1A1, BGN, COL3A1, CRLF1, COL5A1, SFRP2, CYGB
##     THBS2, EMILIN1, COL6A1, FMOD, VCAN, COL6A2, PRRX1, COL5A2, COL5A3, ADAMTS12
##     CRISPLD2, LAMC3, AEBP1, NOTCH3, MXRA8, LUM, VSTM4, TPM2, INHBA, FN1
## Negative:  PLVAP, PECAM1, CD93, FLT1, KDR, SOX18, PODXL, ACVRL1, RGCC, VWF
##     ROBO4, TIE1, ESM1, ADGRL4, ESAM, ECSCR, S1PR1, SEMA3F, CXCR4, CLDN5
##     PASK, NOTCH4, ERG, DYSF, CDH5, CYP1A1, ANGPT2, BCL6B, IFI27, PTPRB
```

```
Baron <- RunUMAP(Baron, dims = 1:30)
```

```
## Warning: The default method for RunUMAP has changed from calling Python UMAP via reticulate to the R-native UWOT using the cosine metric
## To use Python UMAP via reticulate, set umap.method to 'umap-learn' and metric to 'correlation'
## This message will be shown once per session
```

```
## 23:05:17 UMAP embedding parameters a = 0.9922 b = 1.112
```

```
## 23:05:17 Read 8569 rows and found 30 numeric columns
```

```
## 23:05:17 Using Annoy for neighbor search, n_neighbors = 30
```

```
## 23:05:17 Building Annoy index with metric = cosine, n_trees = 50
```

```
## 0%   10   20   30   40   50   60   70   80   90   100%
```

```
## [----|----|----|----|----|----|----|----|----|----|
```

```
## **************************************************|
## 23:05:18 Writing NN index file to temp file /tmp/RtmpJP2l5w/file37f20358d3024d
## 23:05:18 Searching Annoy index using 1 thread, search_k = 3000
## 23:05:21 Annoy recall = 100%
## 23:05:23 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 30
## 23:05:24 Initializing from normalized Laplacian + noise (using RSpectra)
## 23:05:25 Commencing optimization for 500 epochs, with 351608 positive edges
## 23:05:25 Using rng type: pcg
## 23:05:37 Optimization finished
```

```
Baron <- RunTSNE(Baron, dims = 1:30)
PCA  <- DimPlot(Baron, reduction = "pca", group.by = "cell.type")  + ggtitle("PCA") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
tSNE <- DimPlot(Baron, reduction = "tsne", group.by = "cell.type")+ ggtitle("tSNE") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
UMAP <- DimPlot(Baron, reduction = "umap", group.by = "cell.type") + ggtitle("UMAP") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
MCA <- DimPlot(Baron, reduction = "mca", group.by = "cell.type")  + ggtitle("MCA") + theme(legend.text = element_text(size =10), aspect.ratio = 1)
ggarrange(PCA, MCA, common.legend = TRUE, legend = "top")
```

![](data:image/png;base64...)

```
ggarrange(tSNE, UMAP, common.legend = TRUE, legend = "top")
```

![](data:image/png;base64...)

# 6 CelliD automatic cell type prediction using pre-established marker lists

At this stage, CelliD can perform an automatic cell type prediction for each cell in the dataset. For that purpose, prototypical marker lists associated with well-characterized cell types are used as input, as obtained from third-party sources. Here we will use the Panglao [database](https://panglaodb.se/) of curated gene signatures to predict the cell type of each individual cell in the Baron data.

We will illustrate the procedure with two collections of cell-type gene signatures: first restricting the assessment to known pancreatic cell types, and second, a more challenging and unbiased scenario where all cell types in the database will be evaluated. Alternative gene signature databases and/or custom made marker lists can be used by adapting their input format as described below. The quality of the predictions is obviously highly dependent on the quality of the cell type signatures.

## 6.1 Obtaining pancreatic cell-type gene signatures

```
# download all cell-type gene signatures from panglaoDB
panglao <- read_tsv("https://panglaodb.se/markers/PanglaoDB_markers_27_Mar_2020.tsv.gz")
```

```
## Rows: 8286 Columns: 14
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: "\t"
## chr (8): species, official gene symbol, cell type, nicknames, product descri...
## dbl (6): ubiquitousness index, canonical marker, sensitivity_human, sensitiv...
##
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```
# restricting the analysis to pancreas specific gene signatues
panglao_pancreas <- panglao %>% filter(organ == "Pancreas")

# restricting to human specific genes
panglao_pancreas <- panglao_pancreas %>%  filter(str_detect(species,"Hs"))

# converting dataframes into a list of vectors, which is the format needed as input for CelliD
panglao_pancreas <- panglao_pancreas %>%
  group_by(`cell type`) %>%
  summarise(geneset = list(`official gene symbol`))
pancreas_gs <- setNames(panglao_pancreas$geneset, panglao_pancreas$`cell type`)
```

## 6.2 Obtaining gene signatures for all cell types in the Panglao database

```
#filter to get human specific genes
panglao_all <- panglao %>%  filter(str_detect(species,"Hs"))

# convert dataframes to a list of named vectors which is the format for CelliD input
panglao_all <- panglao_all %>%
  group_by(`cell type`) %>%
  summarise(geneset = list(`official gene symbol`))
all_gs <- setNames(panglao_all$geneset, panglao_all$`cell type`)

#remove very short signatures
all_gs <- all_gs[sapply(all_gs, length) >= 10]
```

## 6.3 Assessing per-cell gene signature enrichments against pre-established marker lists

A per-cell assessment is performed, where the enrichment of each cell’s gene signature against each cell-type marker lists is evaluated through hypergeometric tests. No intermediate clustering steps are used here. By default, the size n of the cell’s gene signature is set to n.features = 200

By default, only reference gene sets of size ≥10 are considered. In addition, hypergeometric test p-values are corrected by multiple testing for the number of gene sets evaluated. A cell is considered as enriched in those gene sets for which the hypergeometric test p-value is <1e-02 (-log10 corrected p-value >2), after Benjamini Hochberg multiple testing correction. Default settings can be modified within the `RunCellHGT` function.

The `RunCellHGT` function will provide the -log10 corrected p-value for each cell and each signature evaluated, so a multi-class evaluation is enabled. When a disjointed classification is required, a cell will be assigned to the gene set with the lowest significant corrected p-value. If no significant hits are found, a cell will remain unassigned.

```
# Performing per-cell hypergeometric tests against the gene signature collection
HGT_pancreas_gs <- RunCellHGT(Baron, pathways = pancreas_gs, dims = 1:50, n.features = 200)
```

```
##
## calculating distance
```

```
## ranking genes
```

```
## 10 pathways kept for hypergeometric test out of 10, 0 filtered as less than 10 features was present in the data
```

```
##
## calculating features overlap
```

```
## performing hypergeometric test
```

```
# For each cell, assess the signature with the lowest corrected p-value (max -log10 corrected p-value)
pancreas_gs_prediction <- rownames(HGT_pancreas_gs)[apply(HGT_pancreas_gs, 2, which.max)]

# For each cell, evaluate if the lowest p-value is significant
pancreas_gs_prediction_signif <- ifelse(apply(HGT_pancreas_gs, 2, max)>2, yes = pancreas_gs_prediction, "unassigned")

# Save cell type predictions as metadata within the Seurat object
Baron$pancreas_gs_prediction <- pancreas_gs_prediction_signif
```

The previous cell type predictions can be visualized on any low-dimensionality representation of choice, as illustrated here using tSNE plots

```
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
```

![](data:image/png;base64...)

From an unbiased perspective, CelliD cell type prediction can be performed using as input a comprehensive set of cell types that are not necessarily restricted to the organ or tissue under study. To illustrate this scenario all cell types in the Panglao database can be evaluated at once.

```
HGT_all_gs <- RunCellHGT(Baron, pathways = all_gs, dims = 1:50)
```

```
##
## calculating distance
```

```
## ranking genes
```

```
## 141 pathways kept for hypergeometric test out of 151, 10 filtered as less than 10 features was present in the data
```

```
##
## calculating features overlap
```

```
## performing hypergeometric test
```

```
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
```

![](data:image/png;base64...)

# 7 CelliD cell-to-cell matching and label transferring across datasets

CelliD performs cell-to-cell matching across independent single-cell datasets. Datasets can originate from the same or from a different tissue / organ. Cell matching can be performed either within (e.g. human-to-human) or across species (e.g. mouse-to-human). CelliD cell matching across datasets is performed by a per-cell assessment in the query dataset evaluating the replication of gene signatures extracted from the reference dataset. Gene signatures from the reference dataset can be automatically derived either from individual cells (CelliD(c)), or from previously-established groups of cells (CelliD(g)).

## 7.1 CelliD(c) and CelliD(g): per-cell and per-group gene signature extraction from a reference dataset

In CelliD(c), the gene signatures extracted for each cell n in a dataset D can be assessed through their enrichment against the gene signatures extracted for each cell n’ in a reference dataset D’. Alternatively, CelliD(g) takes advantage of a grouping of cells in D, where per-group gene signatures are extracted and evaluated against the gene signatures for each cell n in the query dataset D. We note that the groupings used in CelliD(g) should be provided as input and tipically originate from a manual annotation process.

Analogous to the previous section, CelliD(c) and CelliD(g) evaluate such enrichments through hypergeometric tests, and p-values are corrected by multiple testing for the number of cells or the number of groups against which they are evaluated. Best hits can be used for cell-to-cell matching (CelliD(c)) or group-to-cell matching (CelliD(g) and subsequent label transferring across datasets. If no significant hits are found, a cell will remain unassigned.

Here we illustrate CelliD(c) and CelliD(g) using the Baron dataset as a reference set from which both cell and group signatures are extracted. The Segerstolpe dataset is used as the query set on which the cell-type labels previously annotated in the Baron dataset are transferred.

```
# Extracting per-cell gene signatures from the Baron dataset with CelliD(c)
Baron_cell_gs <- GetCellGeneSet(Baron, dims = 1:50, n.features = 200)
```

```
##
## calculating distance
```

```
##
## creating ranking
```

```
##
## creating geneset
```

```
# Extracting per-group gene signatures from the Baron dataset with CelliD(g)
Baron_group_gs <- GetGroupGeneSet(Baron, dims = 1:50, n.features = 200, group.by = "cell.type")
```

```
##
## creating ranking
```

## 7.2 Preprocessing and MCA assessment of the Segerstolpe dataset used as the query set

```
# Normalization, basic preprocessing and MCA dimensionality reduction assessment
Seger <- NormalizeData(Seger)
Seger <- FindVariableFeatures(Seger)
Seger <- ScaleData(Seger)
Seger <- RunMCA(Seger, nmcs = 50)
```

```
## 0.962 sec elapsed
```

```
## 25.395 sec elapsed
```

```
## 3.685 sec elapsed
```

```
Seger <- RunPCA(Seger)
Seger <- RunUMAP(Seger, dims = 1:30)
Seger <- RunTSNE(Seger, dims = 1:30)
tSNE <- DimPlot(Seger, reduction = "tsne", group.by = "cell.type", pt.size = 0.1) + ggtitle("tSNE") + theme(aspect.ratio = 1)
UMAP <- DimPlot(Seger, reduction = "umap", group.by = "cell.type", pt.size = 0.1) + ggtitle("UMAP") + theme(aspect.ratio = 1)
ggarrange(tSNE, UMAP, common.legend = TRUE, legend = "top")
```

![](data:image/png;base64...)

## 7.3 CelliD(c): cell-to-cell matching and label transferring across datasets

```
HGT_baron_cell_gs <- RunCellHGT(Seger, pathways = Baron_cell_gs, dims = 1:50)
```

```
##
## calculating distance
```

```
## ranking genes
```

```
## 8569 pathways kept for hypergeometric test out of 8569, 0 filtered as less than 10 features was present in the data
```

```
##
## calculating features overlap
```

```
## performing hypergeometric test
```

```
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
```

![](data:image/png;base64...)

## 7.4 CelliD(g): group-to-cell matching and label transferring across datasets

```
HGT_baron_group_gs <- RunCellHGT(Seger, pathways = Baron_group_gs, dims = 1:50)
```

```
##
## calculating distance
```

```
## ranking genes
```

```
## 13 pathways kept for hypergeometric test out of 13, 0 filtered as less than 10 features was present in the data
```

```
##
## calculating features overlap
```

```
## performing hypergeometric test
```

```
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
```

![](data:image/png;base64...)

# 8 CelliD per-cell functionnal annotation against functional ontologies and pathway databases

Once MCA is performed, per-cell signatures can be evaluated against any custom collection of gene signatures which can, e.g. represent functional terms or biological pathways. This allows CelliD to perfome a per-cell functional enrichment analysis enabling biological interpretation of cell’s state. We illustrate here how to mine for that purpose a collection 7 sources of functional annotations: KEGG, Hallmark MSigDB, Reactome, WikiPathways, GO biological process, GO molecular function and GO cellular component. Gene sets associated to functional pathways and ontology terms can be obtained from [enrichr](http://amp.pharm.mssm.edu/Enrichr/#stats)

Here we illustrate the use of Hallmark in HyperGeometric test and integrate the results into the Seurat object to visualize the -log10 p-value of the enrichment into an UMAP.

```
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
```

```
##
## calculating distance
```

```
## ranking genes
```

```
## 50 pathways kept for hypergeometric test out of 50, 0 filtered as less than 10 features was present in the data
```

```
##
## calculating features overlap
```

```
## performing hypergeometric test
```

```
#Integrating functional annotations as an "assay" slot in the Seurat objects

Seger[["Hallmark"]] <- CreateAssayObject(HGT_Hallmark)
```

```
## Warning: Feature names cannot have underscores ('_'), replacing with dashes
## ('-')
## Warning: Feature names cannot have underscores ('_'), replacing with dashes
## ('-')
```

```
# Visualizing per-cell functional enrichment annotations in a dimensionality-reduction representation of choice (e.g. MCA, PCA, tSNE, UMAP)
ggG2Mcell <- FeaturePlot(Seger, "G2M-CHECKPOINT", order = TRUE, reduction = "tsne", min.cutoff = 2) +
  theme(legend.text = element_text(size =10), aspect.ratio = 1)
```

```
## Warning: Could not find G2M-CHECKPOINT in the default search locations, found
## in 'Hallmark' assay instead
```

```
ggG2Mcell
```

![](data:image/png;base64...)

# Session info

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
##  [1] ggpubr_0.6.2                lubridate_1.9.4
##  [3] forcats_1.0.1               stringr_1.5.2
##  [5] dplyr_1.1.4                 purrr_1.1.0
##  [7] readr_2.1.5                 tidyr_1.3.1
##  [9] tibble_3.3.0                ggplot2_4.0.0
## [11] tidyverse_2.0.0             CelliD_1.18.0
## [13] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [15] Biobase_2.70.0              GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0               IRanges_2.44.0
## [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [21] generics_0.1.4              MatrixGenerics_1.22.0
## [23] matrixStats_1.5.0           Seurat_5.3.1
## [25] SeuratObject_5.2.0          sp_2.2-0
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22       splines_4.5.1          later_1.4.4
##   [4] polyclip_1.10-7        fastDummies_1.7.5      lifecycle_1.0.4
##   [7] rstatix_0.7.3          vroom_1.6.6            globals_0.18.0
##  [10] lattice_0.22-7         MASS_7.3-65            backports_1.5.0
##  [13] magrittr_2.0.4         plotly_4.11.0          sass_0.4.10
##  [16] rmarkdown_2.30         jquerylib_0.1.4        yaml_2.3.10
##  [19] httpuv_1.6.16          otel_0.2.0             sctransform_0.4.2
##  [22] spam_2.11-1            askpass_1.2.1          spatstat.sparse_3.1-0
##  [25] reticulate_1.44.0      cowplot_1.2.0          pbapply_1.7-4
##  [28] RColorBrewer_1.1-3     abind_1.4-8            Rtsne_0.17
##  [31] ggrepel_0.9.6          irlba_2.3.5.1          listenv_0.9.1
##  [34] spatstat.utils_3.2-0   umap_0.2.10.0          goftest_1.2-3
##  [37] RSpectra_0.16-2        spatstat.random_3.4-2  fitdistrplus_1.2-4
##  [40] parallelly_1.45.1      codetools_0.2-20       DelayedArray_0.36.0
##  [43] scuttle_1.20.0         tidyselect_1.2.1       farver_2.1.2
##  [46] ScaledMatrix_1.18.0    viridis_0.6.5          spatstat.explore_3.5-3
##  [49] jsonlite_2.0.0         BiocNeighbors_2.4.0    Formula_1.2-5
##  [52] progressr_0.17.0       ggridges_0.5.7         survival_3.8-3
##  [55] scater_1.38.0          tictoc_1.2.1           tools_4.5.1
##  [58] ica_1.0-3              Rcpp_1.1.0             glue_1.8.0
##  [61] gridExtra_2.3          SparseArray_1.10.0     xfun_0.53
##  [64] withr_3.0.2            BiocManager_1.30.26    fastmap_1.2.0
##  [67] openssl_2.3.4          digest_0.6.37          rsvd_1.0.5
##  [70] timechange_0.3.0       R6_2.6.1               mime_0.13
##  [73] scattermore_1.2        tensor_1.5.1           dichromat_2.0-0.1
##  [76] spatstat.data_3.1-9    data.table_1.17.8      httr_1.4.7
##  [79] htmlwidgets_1.6.4      S4Arrays_1.10.0        uwot_0.2.3
##  [82] pkgconfig_2.0.3        gtable_0.3.6           lmtest_0.9-40
##  [85] S7_0.2.0               XVector_0.50.0         htmltools_0.5.8.1
##  [88] carData_3.0-5          dotCall64_1.2          bookdown_0.45
##  [91] fgsea_1.36.0           scales_1.4.0           png_0.1-8
##  [94] spatstat.univar_3.1-4  knitr_1.50             tzdb_0.5.0
##  [97] reshape2_1.4.4         curl_7.0.0             nlme_3.1-168
## [100] cachem_1.1.0           zoo_1.8-14             KernSmooth_2.23-26
## [103] parallel_4.5.1         miniUI_0.1.2           vipor_0.4.7
## [106] pillar_1.11.1          grid_4.5.1             vctrs_0.6.5
## [109] RANN_2.6.2             promises_1.4.0         car_3.1-3
## [112] BiocSingular_1.26.0    beachmat_2.26.0        xtable_1.8-4
## [115] cluster_2.1.8.1        beeswarm_0.4.0         evaluate_1.0.5
## [118] magick_2.9.0           tinytex_0.57           cli_3.6.5
## [121] compiler_4.5.1         crayon_1.5.3           rlang_1.1.6
## [124] ggsignif_0.6.4         future.apply_1.20.0    labeling_0.4.3
## [127] RcppArmadillo_15.0.2-2 plyr_1.8.9             ggbeeswarm_0.7.2
## [130] stringi_1.8.7          viridisLite_0.4.2      deldir_2.0-4
## [133] BiocParallel_1.44.0    lazyeval_0.2.2         spatstat.geom_3.6-0
## [136] Matrix_1.7-4           RcppHNSW_0.6.0         hms_1.1.4
## [139] patchwork_1.3.2        bit64_4.6.0-1          future_1.67.0
## [142] shiny_1.11.1           ROCR_1.0-11            broom_1.0.10
## [145] igraph_2.2.1           bslib_0.9.0            fastmatch_1.1-6
## [148] bit_4.6.0
```