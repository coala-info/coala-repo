# Moonlight: an approach to identify multiple role of biomarkers as oncogene or tumorsuppressor in different tumor types and stages.

### + These authors contributed equally to the paper as first authors.

Antonio Colaprico^+^ , Catharina Olsen^+^, Claudia Cava, Thilde Terkelsen, Laura Cantini, Gloria Bertoli, Andre Olsen, Andrei Zinovyev, Emmanuel Barillot, Isabella Castiglioni, Elena Papaleo, Gianluca Bontempi

#### 2025-10-30

# Contents

* [Abstract](#abstract)
* [Introduction](#introduction)
* [Moonlight’s pipeline](#moonlights-pipeline)
* [Moonlight’s proposed workflow](#moonlights-proposed-workflow)
* [Installation](#installation)
  + [Citation](#citation)
* [`Download`: Get TCGA data](#download-get-tcga-data)
  + [`getDataTCGA`: Search by cancer type and data type [Gene Expression]](#getdatatcga-search-by-cancer-type-and-data-type-gene-expression)
  + [`getDataTCGA`: Search by cancer type and data type [Methylation]](#getdatatcga-search-by-cancer-type-and-data-type-methylation)
* [`Download`: Get GEO data](#download-get-geo-data)
  + [`getDataGEO`: Search by cancer type and data type [Gene Expression]](#getdatageo-search-by-cancer-type-and-data-type-gene-expression)
* [`Analysis`: To analyze TCGA data](#analysis-to-analyze-tcga-data)
  + [`DPA`: Differential Phenotype Analysis](#dpa-differential-phenotype-analysis)
  + [`FEA`: Functional Enrichment Analysis](#fea-functional-enrichment-analysis)
  + [`FEAplot`: Functional Enrichment Analysis Plot](#feaplot-functional-enrichment-analysis-plot)
  + [`GRN`: Gene Regulatory Network](#grn-gene-regulatory-network)
  + [`URA`: Upstream Regulator Analysis](#ura-upstream-regulator-analysis)
  + [`PRA`: Pattern Regognition Analysis](#pra-pattern-regognition-analysis)
  + [`plotNetworkHive`: GRN hive visualization taking into account Cosmic cancer genes](#plotnetworkhive-grn-hive-visualization-taking-into-account-cosmic-cancer-genes)
* [TCGA Downstream Analysis: Case Studies](#tcga-downstream-analysis-case-studies)
  + [Case study n. 1: Downstream analysis LUAD](#case-study-n.-1-downstream-analysis-luad)
  + [`plotURA`: Upstream regulatory analysis plot](#plotura-upstream-regulatory-analysis-plot)
  + [Case study n. 2: Expression pipeline Pan Cancer 5 cancer types](#case-study-n.-2-expression-pipeline-pan-cancer-5-cancer-types)
  + [`plotCircos`: Moonlight Circos Plot](#plotcircos-moonlight-circos-plot)
  + [Case study n. 3: Downstream analysis BRCA with stages](#case-study-n.-3-downstream-analysis-brca-with-stages)
* [References](#references)

# Abstract

In order to make light of cancer development, it is crucial to understand which genes play a role in the mechanisms linked to this disease and moreover which role that is. Commonly biological processes such as proliferation and apoptosis have been linked to cancer progression.
Based on expression data we perform functional enrichment analysis, infer gene regulatory networks and upstream regulator analysis to score the importance of well-known biological processes with respect to the studied cancer.
We then use these scores to predict two specific roles: genes that act as tumor suppressor genes (TSGs) and genes that act as oncogenes (OCGs). This methodology not only allows us to identify genes with dual role (TSG in one cancer type and OCG in another) but also to elucidate the underlying biological processes.

# Introduction

Cancer development is influenced by mutations in two distinctly different categories of genes, known as tumor suppressor genes (TSG) and oncogenes (OCG). The occurrence of mutations in genes of the first category leads to faster cell proliferation while mutations in genes of second category increases or changes their function.
We propose `MoonlightR` a new approach to define TSGs and OCGs based on functional enrichment analysis, infer gene regulatory networks and upstream regulator analysis to score the importance of well-known biological processes with respect to the studied cancer.

# Moonlight’s pipeline

Moonlight’s pipeline is shown below:
![](data:image/png;base64...)

# Moonlight’s proposed workflow

The proposed pipeline consists of following eight steps:

1. **getDataTCGA** & **getDataGEO** for Data collection: expression levels of genes in all samples obtained with IlluminaHiSeq RNASeqV2 in 18 normal tissues (NT) and 18 cancer tissues (CT) according to TCGA criteria, and GEO data set matched to one of the 18 given TCGA cancer types as described in following Table TCGA / GEO.
2. **DPA** Differential Phenotype Analysis (DEA) to identify genes or probes that are different significantly with two phenotypes such as normal and tumor, or normal and stageI, normal and molecular subtype.
3. **FEA** Functional Enrichment Analysis (EA), using Fisher’s test, to identify gene sets (with biological functions linked to cancer1) significantly enriched by RG.
4. **GRN** Gene regulatory network inferred between each single DEG (sDEG) and all genes by means of mutual information, obtaining for each DEG a list of regulated genes (RG).
5. **URA** Upstream Regulator Analysis for DEGs in each enriched gene set, we applied z-score being the ratio between the sum of all predicted effects for all the gene involved in the specific function and the square-root of the number of all genes.
6. **PRA** Pattern recognition analysis identifies candidate TCGs (down) and OCGs (up). We either use user defined biological processes or random forests.
7. We applied the above procedure to multiple cancer types to obtain cancer-specific lists of TCGs and OCGs. We compared the lists for each cancer: if a sDEG was TSG in a cancer and OCG in another we defined it as dual-role TSG-OCG. Otherwise if we found a sDEG defined as OCG or TSG only in one tissue we defined it tissue specific biomarker.
8. We use the COSMIC database to define a list of gold standard TSG and OCGs to assess the accuracy of the proposed method.

1 For the devel version of MoonlightR we use a short extract of ten biological functions from QIAGEN’S Ingenuity Pathway Analysis (IPA). We are still working to integrate the package.

# Installation

To install use the code below.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MoonlightR")
```

## Citation

Please cite TCGAbiolinks package:

* “TCGAbiolinks: an R/Bioconductor package for integrative analysis of TCGA data.” Nucleic acids research (2015): [gkv1507](http://dx.doi.org/doi%3A10.1093/nar/gkv1507). (Colaprico, Antonio and Silva, Tiago C. and Olsen, Catharina and Garofano, Luciano and Cava, Claudia and Garolini, Davide and Sabedot, Thais S. and Malta, Tathiane M. and Pagnotta, Stefano M. and Castiglioni, Isabella and Ceccarelli, Michele and Bontempi, Gianluca and Noushmehr, Houtan [2016](#ref-ref25))

Related publications to this package:

* “TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages”. F1000Research [10.12688/f1000research.8923.1](http://dx.doi.org/doi%3A10.12688/f1000research.8923.1) (Silva, TC and Colaprico, A and Olsen, C and D’Angelo, F and Bontempi, G and Ceccarelli, M and Noushmehr, H [2016](#ref-ref24))

# `Download`: Get TCGA data

You can search TCGA data using the `getDataTCGA` function.

## `getDataTCGA`: Search by cancer type and data type [Gene Expression]

The user can query and download the cancer types supported by TCGA, using the function `getDataTCGA`:
In this example we used LUAD gene expression data with only 4 samples to reduce time downloading.

```
dataFilt <- getDataTCGA(cancerType = "LUAD",
                          dataType = "Gene expression",
                          directory = "data",
                          nSample = 4)
```

## `getDataTCGA`: Search by cancer type and data type [Methylation]

The user can also query and download methylation data using the function `getDataTCGA`:

```
dataFilt <- getDataTCGA(cancerType = "BRCA",
                          dataType = "Methylation",
                          directory = "data",nSample = 4)
```

# `Download`: Get GEO data

You can search GEO data using the `getDataGEO` function.

GEO\_TCGAtab: a 18x12 matrix that provides the GEO data set we matched to one of the 18 given TCGA cancer types

```
knitr::kable(GEO_TCGAtab, digits = 2,
             caption = "Table with GEO data set matched to one
             of the 18 given TCGA cancer types ",
             row.names = TRUE)
```

Table 1: Table with GEO data set matched to one
of the 18 given TCGA cancer types

|  | Cancer | TP | NT | DEG. | Dataset | TP.1 | NT.1 | Platform | DEG.. | Common | GEO\_Normal | GEO\_Tumor |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | BLCA | 408 | 19 | 2937 | GSE13507 | 165 | 10 | GPL65000 | 2099 | 896 | control | cancer |
| 2 | BRCA | 1097 | 114 | 3390 | GSE39004 | 61 | 47 | GPL6244 | 2449 | 1248 | normal | Tumor |
| 3 | CHOL | 36 | 9 | 5015 | GSE26566 | 104 | 59 | GPL6104 | 3983 | 2587 | Surrounding | Tumor |
| 4 | COAD | 286 | 41 | 3788 | GSE41657 | 25 | 12 | GPL6480 | 3523 | 1367 | N | A |
| 5 | ESCA | 184 | 11 | 2525 | GSE20347 | 17 | 17 | GPL571 | 1316 | 406 | normal | carcinoma |
| 6 | GBM | 156 | 5 | 4828 | GSE50161 | 34 | 13 | GPL570 | 4504 | 2660 | normal | GBM |
| 7 | HNSC | 520 | 44 | 2973 | GSE6631 | 22 | 22 | GPL8300 | 142 | 129 | normal | cancer |
| 8 | KICH | 66 | 25 | 4355 | GSE15641 | 6 | 23 | GPL96 | 1789 | 680 | normal | chromophobe |
| 9 | KIRC | 533 | 72 | 3618 | GSE15641 | 32 | 23 | GPL96 | 2911 | 939 | normal | clear cell RCC |
| 10 | KIRP | 290 | 32 | 3748 | GSE15641 | 11 | 23 | GPL96 | 2020 | 756 | normal | papillary RCC |
| 11 | LIHC | 371 | 50 | 3043 | GSE45267 | 46 | 41 | GPL570 | 1583 | 860 | normal liver | HCC sample |
| 12 | LUAD | 515 | 59 | 3498 | GSE10072 | 58 | 49 | GPL96 | 666 | 555 | normal | tumor |
| 13 | LUSC | 503 | 51 | 4984 | GSE33479 | 14 | 27 | GPL6480 | 3729 | 1706 | normal | squamous cell carcinoma |
| 14 | PRAD | 497 | 52 | 1860 | GSE6919 | 81 | 90 | GPL8300 | 246 | 149 | normal prostate | tumor samples |
| 15 | READ | 94 | 10 | 3628 | GSE20842 | 65 | 65 | GPL4133 | 2172 | 1261 | M | T |
| 16 | STAD | 415 | 35 | 2622 | GSE2685 | 10 | 10 | GPL80 | 487 | 164 | N | T |
| 17 | THCA | 505 | 59 | 1994 | GSE33630 | 60 | 45 | GPL570 | 1451 | 781 | N | T |
| 18 | UCEC | 176 | 24 | 4183 | GSE17025 |  |  | GPL570 |  |  | tp | lcm |

## `getDataGEO`: Search by cancer type and data type [Gene Expression]

The user can query and download the cancer types supported by GEO, using the function `getDataGEO`:

```
dataFilt <- getDataGEO(GEOobject = "GSE20347",platform = "GPL571")
```

```
dataFilt <- getDataGEO(TCGAtumor = "ESCA")
```

# `Analysis`: To analyze TCGA data

## `DPA`: Differential Phenotype Analysis

Differential phenotype analysis is able to identify genes or probes that are significantly different between two phenotypes such as normal vs. tumor, or normal vs. stageI, normal vs. molecular subtype.

For gene expression data, DPA is running a differential expression analysis (DEA) to identify differentially expressed genes (DEGs) using the `TCGAanalyze_DEA` function from .

For methylation data, DPA is running a differentially methylated regions analysis (DMR) to identify
differentially methylated CpG sites using the `TCGAanalyze_DMR` the `TCGAanalyze_DMR` function from .

```
dataDEGs <- DPA(dataFilt = dataFilt,
                dataType = "Gene expression")
```

For gene expression data, DPA dealing with GEO data is running a differential expression analysis (DEA) to identify differentially expressed genes (DEGs) using to the `eBayes` and `topTable` functions from .

```
data(GEO_TCGAtab)
DataAnalysisGEO<- "../GEO_dataset/"
i<-5

cancer <- GEO_TCGAtab$Cancer[i]
cancerGEO <- GEO_TCGAtab$Dataset[i]
cancerPLT <-GEO_TCGAtab$Platform[i]
fileCancerGEO <- paste0(cancer,"_GEO_",cancerGEO,"_",cancerPLT, ".RData")

dataFilt <- getDataGEO(TCGAtumor = cancer)
xContrast <- c("G1-G0")
GEOdegs <- DPA(dataConsortium = "GEO",
               gset = dataFilt ,
               colDescription = "title",
               samplesType  = c(GEO_TCGAtab$GEO_Normal[i],
                                GEO_TCGAtab$GEO_Tumor[i]),
               fdr.cut = 0.01,
               logFC.cut = 1,
               gsetFile = paste0(DataAnalysisGEO,fileCancerGEO))
```

We can visualize those differentially expressed genes (DEGs) with a volcano plot using the `TCGAVisualize_volcano` function from .

```
library(TCGAbiolinks)
TCGAVisualize_volcano(DEGsmatrix$logFC, DEGsmatrix$FDR,
                      filename = "DEGs_volcano.png",
                      x.cut = 1,
                      y.cut = 0.05,
                      names = rownames(DEGsmatrix),
                      color = c("black","red","dodgerblue3"),
                      names.size = 2,
                      show.names = "highlighted",
                      highlight = c("gene1","gene2"),
                      xlab = " Gene expression fold change (Log2)",
                      legend = "State",
                      title = "Volcano plot (Normal NT vs Tumor TP)",
                      width = 10)
```

```
## Saving file as: DEGs_volcano.png
```

The figure generated by the code above is shown below:
![](data:image/png;base64...)

## `FEA`: Functional Enrichment Analysis

The user can perform a functional enrichment analysis using the function `FEAcomplete`. For each DEG in the gene set a z-score is calculated. This score indicates how the genes act in the gene set.

```
data(DEGsmatrix)
dataFEA <- FEA(DEGsmatrix = DEGsmatrix)
```

The output can be visualized with a FEA plot.

## `FEAplot`: Functional Enrichment Analysis Plot

The user can plot the result of a functional enrichment analysis using the function `plotFEA`. A negative z-score indicates that the process’ activity is decreased. A positive z-score indicates that the process’ activity is increased.

```
plotFEA(dataFEA = dataFEA, additionalFilename = "_exampleVignette", height = 20, width = 10)
```

The figure generated by the above code is shown below:
![](data:image/png;base64...)

## `GRN`: Gene Regulatory Network

The user can perform a gene regulatory network analysis using the function `GRN` which infers the network using the parmigene package.

```
dataGRN <- GRN(TFs = rownames(DEGsmatrix)[1:100], normCounts = dataFilt,
                   nGenesPerm = 10,kNearest = 3,nBoot = 10)
```

## `URA`: Upstream Regulator Analysis

The user can perform upstream regulator analysis using the function `URA`. This function is applied to each DEG in the enriched gene set and its neighbors in the GRN.

```
data(dataGRN)
data(DEGsmatrix)

dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

BPselected <- dataFEA$Diseases.or.Functions.Annotation[1:5]
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = BPselected,
               nCores=1)
```

## `PRA`: Pattern Regognition Analysis

The user can retrieve TSG/OCG candidates using either selected biological processes or a random forest classifier trained on known COSMIC OCGs/TSGs.

```
data(dataURA)
dataDual <- PRA(dataURA = dataURA,
                          BPname = c("apoptosis","proliferation of cells"),
                          thres.role = 0)
```

## `plotNetworkHive`: GRN hive visualization taking into account Cosmic cancer genes

In the following plot the nodes are separated into three groups: known tumor suppressor genes (yellow), known oncogenes (green) and the rest (gray).

```
data(knownDriverGenes)
data(dataGRN)
plotNetworkHive(dataGRN, knownDriverGenes, 0.55)
```

![](data:image/png;base64...)

# TCGA Downstream Analysis: Case Studies

### Introduction

This vignette shows a complete workflow of the ‘MoonlightR’ package except for the data download.
The code is divided into three case study:

* 1. Downstream analysis LUAD using RNA expression data
* 2. Expression pipeline Pan Cancer with five cancer types
* 3. Expression pipeline with stages I II III IV (BRCA)

## Case study n. 1: Downstream analysis LUAD

```
dataDEGs <- DPA(dataFilt = dataFilt,
                dataType = "Gene expression")

dataFEA <- FEA(DEGsmatrix = dataDEGs)

dataGRN <- GRN(TFs = rownames(dataDEGs)[1:100],
               DEGsmatrix = dataDEGs,
               DiffGenes = TRUE,
               normCounts = dataFilt)

dataURA <- URA(dataGRN = dataGRN,
              DEGsmatrix = dataDEGs,
              BPname = c("apoptosis",
                         "proliferation of cells"))

dataDual <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

CancerGenes <- list("TSG"=names(dataDual$TSG), "OCG"=names(dataDual$OCG))
```

## `plotURA`: Upstream regulatory analysis plot

The user can plot the result of the upstream regulatory analysis using the function `plotURA`.

```
 plotURA(dataURA = dataURA[c(names(dataDual$TSG), names(dataDual$OCG)),, drop = FALSE], additionalFilename = "_exampleVignette")
```

The figure resulted from the code above is shown below:
![](data:image/png;base64...)

## Case study n. 2: Expression pipeline Pan Cancer 5 cancer types

```
cancerList <- c("BLCA","COAD","ESCA","HNSC","STAD")

listMoonlight <- moonlight(cancerType = cancerList,
                      dataType = "Gene expression",
                      directory = "data",
                      nSample = 10,
                      nTF = 100,
                      DiffGenes = TRUE,
                      BPname = c("apoptosis","proliferation of cells"))
save(listMoonlight, file = paste0("listMoonlight_ncancer4.Rdata"))
```

## `plotCircos`: Moonlight Circos Plot

The results of the moonlight pipeline can be visualized with a circos plot.
Outer ring: color by cancer type, Inner ring: OCGs and TSGs,
Inner connections: green: common OCGs yellow: common TSGs red: possible dual role

```
plotCircos(listMoonlight = listMoonlight, additionalFilename = "_ncancer5")
```

The figure generated by the code above is shown below:
![](data:image/png;base64...)

## Case study n. 3: Downstream analysis BRCA with stages

```
listMoonlight <- NULL
for (i in 1:4){
    dataDual <- moonlight(cancerType = "BRCA",
                      dataType = "Gene expression",
                      directory = "data",
                      nSample = 10,
                      nTF = 5,
                      DiffGenes = TRUE,
                      BPname = c("apoptosis","proliferation of cells"),
                      stage = i)
    listMoonlight <- c(listMoonlight, list(dataDual))
    save(dataDual, file = paste0("dataDual_stage",as.roman(i), ".Rdata"))
}
names(listMoonlight) <- c("stage1", "stage2", "stage3", "stage4")

# Prepare mutation data for stages

mutation <- GDCquery_Maf(tumor = "BRCA")

res.mutation <- NULL
for(stage in 1:4){

  curStage <- paste0("Stage ", as.roman(stage))
                dataClin$tumor_stage <- toupper(dataClin$tumor_stage)
                dataClin$tumor_stage <- gsub("[ABCDEFGH]","",dataClin$tumor_stage)
                dataClin$tumor_stage <- gsub("ST","Stage",dataClin$tumor_stage)

                dataStg <- dataClin[dataClin$tumor_stage %in% curStage,]
                message(paste(curStage, "with", nrow(dataStg), "samples"))
dataSmTP <- mutation$Tumor_Sample_Barcode

                dataStgC <- dataSmTP[substr(dataSmTP,1,12) %in% dataStg$bcr_patient_barcode]
                dataSmTP <- dataStgC

                info.mutation <- mutation[mutation$Tumor_Sample_Barcode %in% dataSmTP,]

     ind <- which(info.mutation[,"Consequence"]=="inframe_deletion")
     ind2 <- which(info.mutation[,"Consequence"]=="inframe_insertion")
     ind3 <- which(info.mutation[,"Consequence"]=="missense_variant")
    res.mutation <- c(res.mutation, list(info.mutation[c(ind, ind2, ind3),c(1,51)]))
    }
names(res.mutation) <- c("stage1", "stage2", "stage3", "stage4")

tmp <- NULL
tmp <- c(tmp, list(listMoonlight[[1]][[1]]))
tmp <- c(tmp, list(listMoonlight[[2]][[1]]))
tmp <- c(tmp, list(listMoonlight[[3]][[1]]))
tmp <- c(tmp, list(listMoonlight[[4]][[1]]))
names(tmp) <- names(listMoonlight)

 mutation <- GDCquery_Maf(tumor = "BRCA")

 plotCircos(listMoonlight=listMoonlight,listMutation=res.mutation, additionalFilename="proc2_wmutation", intensityColDual=0.2,fontSize = 2)
```

The results of the moonlight pipeline can be visualized with a circos plot.
Outer ring: color by cancer type, Inner ring: OCGs and TSGs,
Inner connections: green: common OCGs yellow: common TSGs red: possible dual role

The figure generated by the code above is shown below:
![](data:image/png;base64...)

---

Session Information
\*\*\*\*\*\*

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
## [1] grid      parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
## [1] TCGAbiolinks_2.38.0 png_0.1-8           MoonlightR_1.36.0
## [4] doParallel_1.0.17   iterators_1.0.14    foreach_1.5.2
## [7] dbplyr_2.5.1        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RISmed_2.3.0                later_1.4.4
##   [3] splines_4.5.1               filelock_1.0.3
##   [5] bitops_1.0-9                ggplotify_0.1.3
##   [7] tibble_3.3.0                R.oo_1.27.1
##   [9] XML_3.99-0.19               httr2_1.2.1
##  [11] lifecycle_1.0.4             tcltk_4.5.1
##  [13] rprojroot_2.1.1             processx_3.8.6
##  [15] lattice_0.22-7              magrittr_2.0.4
##  [17] limma_3.66.0                sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.10                 remotes_2.5.0
##  [23] otel_0.2.0                  ggtangle_0.0.7
##  [25] sessioninfo_1.2.3           pkgbuild_1.4.8
##  [27] chromote_0.5.1              cowplot_1.2.0
##  [29] DBI_1.2.3                   RColorBrewer_1.1-3
##  [31] abind_1.4-8                 pkgload_1.4.1
##  [33] rvest_1.0.5                 GenomicRanges_1.62.0
##  [35] purrr_1.1.0                 R.utils_2.13.0
##  [37] BiocGenerics_0.56.0         rgl_1.3.24
##  [39] yulab.utils_0.2.1           rappdirs_0.3.3
##  [41] gdtools_0.4.4               circlize_0.4.16
##  [43] IRanges_2.44.0              S4Vectors_0.48.0
##  [45] enrichplot_1.30.0           ggrepel_0.9.6
##  [47] parmigene_1.1.1             rentrez_1.2.4
##  [49] tidytree_0.4.6              codetools_0.2-20
##  [51] DelayedArray_0.36.0         xml2_1.4.1
##  [53] DOSE_4.4.0                  tidyselect_1.2.1
##  [55] shape_1.4.6.1               aplot_0.2.9
##  [57] farver_2.1.2                TCGAbiolinksGUI.data_1.29.0
##  [59] BiocFileCache_3.0.0         matrixStats_1.5.0
##  [61] stats4_4.5.1                base64enc_0.1-3
##  [63] Seqinfo_1.0.0               jsonlite_2.0.0
##  [65] ellipsis_0.3.2              systemfonts_1.3.1
##  [67] progress_1.2.3              tools_4.5.1
##  [69] ragg_1.5.0                  treeio_1.34.0
##  [71] Rcpp_1.1.0                  glue_1.8.0
##  [73] Rttf2pt1_1.3.14             SparseArray_1.10.0
##  [75] xfun_0.53                   qvalue_2.42.0
##  [77] MatrixGenerics_1.22.0       usethis_3.2.1
##  [79] websocket_1.4.4             dplyr_1.1.4
##  [81] withr_3.0.2                 BiocManager_1.30.26
##  [83] fastmap_1.2.0               caTools_1.18.3
##  [85] digest_0.6.37               R6_2.6.1
##  [87] gridGraphics_0.5-1          textshaping_1.0.4
##  [89] colorspace_2.1-2            GO.db_3.22.0
##  [91] gtools_3.9.5                HiveR_0.4.0
##  [93] biomaRt_2.66.0              jpeg_0.1-11
##  [95] dichromat_2.0-0.1           RSQLite_2.4.3
##  [97] R.methodsS3_1.8.2           tidyr_1.3.1
##  [99] generics_0.1.4              fontLiberation_0.1.0
## [101] data.table_1.17.8           prettyunits_1.2.0
## [103] httr_1.4.7                  htmlwidgets_1.6.4
## [105] S4Arrays_1.10.0             pkgconfig_2.0.3
## [107] gtable_0.3.6                blob_1.2.4
## [109] S7_0.2.0                    XVector_0.50.0
## [111] clusterProfiler_4.18.0      htmltools_0.5.8.1
## [113] fontBitstreamVera_0.1.1     bookdown_0.45
## [115] fgsea_1.36.0                scales_1.4.0
## [117] Biobase_2.70.0              ggfun_0.2.0
## [119] knitr_1.50                  rstudioapi_0.17.1
## [121] tzdb_0.5.0                  reshape2_1.4.4
## [123] curl_7.0.0                  nlme_3.1-168
## [125] cachem_1.1.0                GlobalOptions_0.1.2
## [127] stringr_1.5.2               KernSmooth_2.23-26
## [129] extrafont_0.20              AnnotationDbi_1.72.0
## [131] desc_1.4.3                  GEOquery_2.78.0
## [133] pillar_1.11.1               vctrs_0.6.5
## [135] gplots_3.2.0                promises_1.4.0
## [137] randomForest_4.7-1.2        extrafontdb_1.1
## [139] evaluate_1.0.5              magick_2.9.0
## [141] tinytex_0.57                readr_2.1.5
## [143] cli_3.6.5                   compiler_4.5.1
## [145] rlang_1.1.6                 crayon_1.5.3
## [147] labeling_0.4.3              ps_1.9.1
## [149] plyr_1.8.9                  fs_1.6.6
## [151] ggiraph_0.9.2               stringi_1.8.7
## [153] BiocParallel_1.44.0         Biostrings_2.78.0
## [155] lazyeval_0.2.2              devtools_2.4.6
## [157] GOSemSim_2.36.0             fontquiver_0.2.1
## [159] Matrix_1.7-4                hms_1.1.4
## [161] patchwork_1.3.2             bit64_4.6.0-1
## [163] ggplot2_4.0.0               KEGGREST_1.50.0
## [165] statmod_1.5.1               SummarizedExperiment_1.40.0
## [167] igraph_2.2.1                memoise_2.0.1
## [169] bslib_0.9.0                 ggtree_4.0.0
## [171] fastmatch_1.1-6             bit_4.6.0
## [173] downloader_0.4.1            ape_5.8-1
## [175] gson_0.1.0
```

# References

Colaprico, Antonio and Silva, Tiago C. and Olsen, Catharina and Garofano, Luciano and Cava, Claudia and Garolini, Davide and Sabedot, Thais S. and Malta, Tathiane M. and Pagnotta, Stefano M. and Castiglioni, Isabella and Ceccarelli, Michele and Bontempi, Gianluca and Noushmehr, Houtan. 2016. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of TCGA Data.” <https://doi.org/10.1093/nar/gkv1507>.

Silva, TC and Colaprico, A and Olsen, C and D’Angelo, F and Bontempi, G and Ceccarelli, M and Noushmehr, H. 2016. “TCGA Workflow: Analyze Cancer Genomics and Epigenomics Data Using Bioconductor Packages.” <https://doi.org/10.12688/f1000research.8923.1>.