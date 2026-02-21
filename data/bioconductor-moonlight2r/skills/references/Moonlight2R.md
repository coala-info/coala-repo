# A workflow to study mechanistic indicators for driver gene prediction with Moonlight

### + These authors contributed equally to the paper as first authors.

Mona Nourbakhsh^+^ , Astrid Saksager^+^, Nikola Tom, Xi Steven Chen, Antonio Colaprico, Catharina Olsen, Matteo Tiberti, Elena Papaleo

#### 2025-12-15

# Contents

* [Abstract](#abstract)
* [Introduction](#introduction)
* [Moonlight’s pipeline](#moonlights-pipeline)
* [Moonlight’s proposed workflow](#moonlights-proposed-workflow)
* [Installation](#installation)
  + [Installation from BioConductor](#installation-from-bioconductor)
  + [Installation from GitHub](#installation-from-github)
  + [Installation from GitHub with accompanying vignette](#installation-from-github-with-accompanying-vignette)
* [Load libraries](#load-libraries)
* [`Obtain Input`](#obtain-input)
* [`Download`: Get GEO data](#download-get-geo-data)
  + [`getDataGEO`: Search by cancer type and data type [Gene Expression]](#getdatageo-search-by-cancer-type-and-data-type-gene-expression)
  + [`FEA`: Functional Enrichment Analysis](#fea-functional-enrichment-analysis)
  + [`FEAplot`: Functional Enrichment Analysis Plot](#feaplot-functional-enrichment-analysis-plot)
  + [`GRN`: Gene Regulatory Network](#grn-gene-regulatory-network)
  + [`URA`: Upstream Regulator Analysis](#ura-upstream-regulator-analysis)
  + [`PRA`: Pattern Regognition Analysis](#pra-pattern-regognition-analysis)
  + [`DMA`: Driver Mutation Analysis](#dma-driver-mutation-analysis)
  + [`GMA`: Gene Methylation Analysis](#gma-gene-methylation-analysis)
  + [`GLS`: Gene Literature Search](#gls-gene-literature-search)
  + [Transcription factor-based layer of secondary evidence](#transcription-factor-based-layer-of-secondary-evidence)
  + [`loadMAVISp`: Helper function for loading the MAVISp database](#loadmavisp-helper-function-for-loading-the-mavisp-database)
  + [`TFinfluence`: Effect of mutations on transcription factors](#tfinfluence-effect-of-mutations-on-transcription-factors)
  + [`Level of consequence`: Effect of mutations on three different levels](#level-of-consequence-effect-of-mutations-on-three-different-levels)
  + [`plotNetworkHive`: GRN hive visualization taking into account COSMIC cancer genes](#plotnetworkhive-grn-hive-visualization-taking-into-account-cosmic-cancer-genes)
  + [`plotDMA`: Heatmap of the driver/passenger status of mutations in TSGs/OCGs](#plotdma-heatmap-of-the-driverpassenger-status-of-mutations-in-tsgsocgs)
  + [`plotMoonlight`: Heatmap of Moonlight Gene Z-scores for mutation-driven TSGs/OCGs](#plotmoonlight-heatmap-of-moonlight-gene-z-scores-for-mutation-driven-tsgsocgs)
  + [`plotGMA`: Heatmap of hypo/hyper/dual methylated CpG sites in TSGs/OCGs](#plotgma-heatmap-of-hypohyperdual-methylated-cpg-sites-in-tsgsocgs)
  + [`plotMoonlightMet`: Heatmap of Moonlight Gene Z-scores for methylation-driven TSGs/OCGs](#plotmoonlightmet-heatmap-of-moonlight-gene-z-scores-for-methylation-driven-tsgsocgs)
  + [`plotMetExp`: Visualize results from EpiMix of expression and methylation in genes](#plotmetexp-visualize-results-from-epimix-of-expression-and-methylation-in-genes)
* [Moonlight Analysis: Case Studies](#moonlight-analysis-case-studies)
  + [Case study n. 1: Predicting oncogenic mediators using Moonlight’s primary layer](#case-study-n.-1-predicting-oncogenic-mediators-using-moonlights-primary-layer)
  + [`plotURA`: Upstream regulatory analysis plot](#plotura-upstream-regulatory-analysis-plot)
  + [Case study n. 2: Moonlight pipeline in one function](#case-study-n.-2-moonlight-pipeline-in-one-function)
  + [`plotCircos`: Moonlight Circos Plot](#plotcircos-moonlight-circos-plot)
  + [Case study n. 3: Moonlight with driver mutation analysis](#case-study-n.-3-moonlight-with-driver-mutation-analysis)
  + [Case study n. 4: Moonlight with gene methylation analysis](#case-study-n.-4-moonlight-with-gene-methylation-analysis)
  + [Citation](#citation)
* [References](#references)

# Abstract

In order to make light of cancer development, it is crucial to understand which genes play
a role in the mechanisms linked to this disease and moreover which role that is. Commonly
biological processes such as proliferation and apoptosis have been linked to cancer progression.
We have developed the Moonlight framework that allows for prediction of cancer driver genes
through multi-omics data integration. Based on expression data we perform functional enrichment
analysis, infer gene regulatory networks and upstream regulator analysis to score the importance
of well-known biological processes with respect to the studied cancer. We then use these scores
to predict oncogenic mediators with two specific roles: genes that potentially act as tumor
suppressor genes (TSGs) and genes that potentially act as oncogenes (OCGs). This constitutes
Moonlight’s primary layer. As gene expression data alone does not explain the cancer phenotypes,
a second layer of evidence is needed. We have integrated three secondary layers, one based on mutations,
one based on abnormal DNA methylation patterns, for prediction of the driver genes,
and one baed on the effect of mutations on transcription factors.
The mutational layer predicts driver mutations in the oncogenic mediators and thereby allows
for the prediction of cancer driver genes using the driver mutation prediction tool CScape-somatic.
The methylation layer investigates abnormal DNA methylation patterns and differentially methylated
CpG sites in the oncogenic mediators using the tool EpiMix and uses patterns of hypo- and
hypermethylation for prediction of the driver genes. The transcription factor layer
checks which transcription factors are important for determining the transcription
of possible driver genes, and identifies mutations on such transcription factors
from a cancer mutation dataset that are able to destabilize them and therefore likely affect transcription.
Overall, this methodology not only allows us to identify genes with dual role (TSG in one
cancer type and OCG in another) but also to elucidate the underlying biological processes.

# Introduction

Cancer development is influenced by (epi)genetic alterations in two distinctly different categories of genes,
known as tumor suppressor genes (TSG) and oncogenes (OCG). The occurrence of these alterations in genes
of the first category leads to faster cell proliferation while alterations in genes of second
category increases or changes their function.
In 2020, we developed the Moonlight framework that allows for prediction of cancer driver genes
(Colaprico, Antonio and Olsen, Catharina and Bailey, Matthew H. and Odom, Gabriel J. and Terkelsen, Thilde and Silva, Tiago C. and Olsen, André V. and Cantini, Laura and Zinovyev, Andrei and Barillot, Emmanuel and Noushmehr, Houtan and Bertoli, Gloria and Castiglioni, Isabella and Cava, Claudia and Bontempi, Gianluca and Chen, Xi Steven and Papaleo, Elena [2020](#ref-ref26)). Here, gene expression data are integrated together with
biological processes and gene regulatory networks to score the importance of well-known biological
processes with respect to the studied cancer. These scores are used to predict oncogenic mediators:
putative TSGs and putative OCGs. As gene expression data alone is not enough to explain the
deregulation of the genes, a second layer of evidence is needed. For this reason, we integrated a
secondary mutational layer which predicts driver mutations and passenger mutations
in the oncogenic mediators. The prediction of the driver mutations are carried out using the
CScape-somatic (Rogers, Mark F and Gaunt, Tom R and Campbell, Colin [2020](#ref-ref29)) driver mutation prediction tool. Those oncogenic mediators with at least one
driver mutation are retained as the final set of driver genes (Nourbakhsh, Mona and Saksager, Astrid and Tom, Nikola and Chen, Xi Steven and Colaprico, Antonio and Olsen, Catharina and Tiberti, Matteo and Papaleo, Elena [2023](#ref-ref27)). Moreover, we have integrated
a secondary methylation layer that investigates abnormal DNA methylation patterns in the oncogenic
mediators using the tool EpiMix (Zheng, Yuanning and Jun, John and Brennan, Kevin and Gevaert, Olivier [2023](#ref-ref28)). Those oncogenic mediators demonstrating hypo- and hypermethylation
patterns are predicted as OCGs and TSGs, respectively. These new functionalities are released in the
updated version of Moonlight to produce Moonlight2R.
A third transcription factor layer checks which transcription factors are important
for determining the transcription of possible driver genes, and if any mutation
available in a cancer mutation dataset is able to destabilize them and therefore
likely affect transcription. The mutations can be provided as MAF-formatted files,
while predictions on whether any mutation on a transcription factor can be destabilizing
are available as the [MAVISp database](https://osf.io/ufpzm/). MAVISp is our computational
framework for the effect of predictions of mutations using structural methods; you
can read more about it on our [preprint](https://www.biorxiv.org/content/10.1101/2022.10.22.513328v5).

# Moonlight’s pipeline

Moonlight’s pipeline is shown below:
![](data:image/png;base64...)

# Moonlight’s proposed workflow

The proposed pipeline consists of following eight steps:

1. The input to Moonlight is a set of differentially expressed genes between two biological conditions
   such as cancer and healthy samples or two cancer subtyoes. Besides differentially expressed genes,
   gene expression data is also needed. Mutation data and/or methylation data are also needed.
2. **FEA** Functional Enrichment Analysis, using Fisher’s test, to identify gene sets (with biological
   functions linked to cancer) significantly enriched by regulated genes (RG).
3. **GRN** Gene Regulatory Network inferred between each single DEG (sDEG) and all genes by means of
   mutual information, obtaining for each DEG a list of RG.
4. **URA** Upstream Regulator Analysis for DEGs in each enriched gene set, we applied z-score being
   the ratio between the sum of all predicted effects for all the gene involved in the specific function
   and the square-root of the number of all genes.
5. **PRA** Pattern Recognition Analysis identifies putative TSGs (down) and OCGs (up). We either use
   user defined biological processes or random forests.
6. **DMA** Driver Mutation Analysis identifies driver mutations in the putative TSGs and OCGs through
   the driver mutation prediction tool, CScape-somatic.
7. **GMA** Gene Methylation Analysis identifies abnormal DNA methylation patterns in the putative
   TSGs and OCGs through the tool, EpiMix.
8. We apply the above procedure to multiple cancer types to obtain cancer-specific lists of TSGs
   and OCGs. We compare the lists for each cancer: if a sDEG is TSG in a cancer and OCG in another we
   define it as dual-role TSG-OCG. Otherwise if we find a sDEG defined as OCG or TSG only in one tissue
   we define it as tissue specific biomarker.
9. We use the COSMIC database to define a list of gold standard TSG and OCGs to assess the accuracy
   of the proposed method.

# Installation

To install Moonlight2R use the code below.

## Installation from BioConductor

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("Moonlight2R")
```

## Installation from GitHub

First, install `devtools` or if you already have it installed, load it.

```
install.packages("devtools")
library(devtools)
```

Install Moonlight2R from GitHub:

```
devtools::install_github(repo = "ELELAB/Moonlight2R")
```

## Installation from GitHub with accompanying vignette

First, install the BiocStyle Bioconductor package.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocStyle")
```

Then install Moonlight2R with its accompanying vignette.

```
devtools::install_github(repo = "ELELAB/Moonlight2R", build_vignettes = TRUE)
```

You can view the vignette in the following way.

```
vignette( "Moonlight2R", package="Moonlight2R")
```

# Load libraries

```
library(Moonlight2R)
```

```
## Loading required package: doParallel
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: parallel
```

```
##
```

```
##
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

```
library(magrittr)
library(dplyr)
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

# `Obtain Input`

The input to Moonlight is a set of differentially expressed genes and gene
expression data. Mutation and/or methylation data are also needed. These data
should be available for the same sample sets. Gene expression data, mutation
data, methylation data and differentially expressed genes can for example be obtained from TCGA
using the R package TCGAbiolinks. Help documents on how to use TCGAbiolinks
are available [here](https://bioconductor.org/packages/release/bioc/vignettes/TCGAbiolinks/inst/doc/index.html).
To find other examples of usage of TCGAbiolinks on TCGA cancer types see our
[GitHub repository](https://github.com/ELELAB/LUAD_LUSC_TCGA_comparison).
Example data of the input (differentially expressed genes, gene expression data,
mutation data, and methylation data) are stored in the Moonlight2R package:

```
data(DEGsmatrix)
data(dataFilt)
data(dataMAF)
data(GEO_TCGAtab)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(Oncogenic_mediators_mutation_summary)
data(DEG_Mutations_Annotations)
data(dataMethyl)
data(DEG_Methylation_Annotations)
data(Oncogenic_mediators_methylation_summary)
data(MetEvidenceDriver)
data(LUAD_sample_anno)
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
dataFilt_GEO <- getDataGEO(GEOobject = "GSE20347", platform = "GPL571")
```

```
dataFilt_GEO <- getDataGEO(TCGAtumor = "ESCA")
```

## `FEA`: Functional Enrichment Analysis

The user can perform a functional enrichment analysis using the function `FEA`.
For each DEG in the gene set a z-score is calculated. This score indicates how the genes act in the gene set.

```
data(DEGsmatrix)
data(DiseaseList)
data(EAGenes)
dataFEA <- FEA(DEGsmatrix = DEGsmatrix)
```

The output can be visualized with a FEA plot.

## `FEAplot`: Functional Enrichment Analysis Plot

The user can plot the result of a functional enrichment analysis using the function `plotFEA`.
A negative z-score indicates that the process’ activity is decreased. A positive z-score
indicates that the process’ activity is increased.

```
plotFEA(dataFEA = dataFEA, additionalFilename = "_exampleVignette", height = 10, width = 20)
```

The figure generated by the above code is shown below:
![](data:image/gif;base64...)

## `GRN`: Gene Regulatory Network

The user can perform a gene regulatory network analysis using the function
`GRN` which infers the network using the parmigene package. For illustrative
purposes and to decrease runtime, we have set `nGenesPerm = 5` and `nBoot = 5`
in the example below, however, we recommend setting these parameters to
`nGenesPerm = 2000` and `nBoot = 400` to achieve optimal results, as they are
set by default in the function arguments.

```
data(DEGsmatrix)
data(dataFilt)
dataGRN <- GRN(DEGsmatrix = DEGsmatrix, TFs = sample(rownames(DEGsmatrix), 100), normCounts = dataFilt,
                   nGenesPerm = 5, kNearest = 3, nBoot = 5, DiffGenes = TRUE)
```

## `URA`: Upstream Regulator Analysis

The user can perform upstream regulator analysis using the function `URA`. This function is
applied to each DEG in the enriched gene set and its neighbors in the GRN.

```
data(dataGRN)
data(DEGsmatrix)
data(DiseaseList)
data(EAGenes)

dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

BPselected <- dataFEA$Diseases.or.Functions.Annotation[1:5]
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = BPselected,
               nCores=1)
```

```
## Warning: executing %dopar% sequentially: no parallel backend registered
```

## `PRA`: Pattern Regognition Analysis

The user can retrieve putative TSG/OCG using either selected biological processes in
the expert-based approach or a random forest classifier trained on known COSMIC OCGs/TSGs
in the machine learning approach. The user must enter the chosen biological processes
in the `BPname` argument to use the expert-based approach or set `BPname = NULL` to
use the machine learning approach.

```
data(dataURA)
data(tabGrowBlock)
data(knownDriverGenes)
dataPRA <- PRA(dataURA = dataURA,
               BPname = c("apoptosis","proliferation of cells"),
               thres.role = 0)
```

## `DMA`: Driver Mutation Analysis

The user can identify driver mutations with `DMA` in the oncogenic mediators established by `PRA`.
The passenger or driver status is estimated with CScape-somatic (Rogers, Mark F and Gaunt, Tom R and Campbell, Colin [2020](#ref-ref29)).
This function will further generate three files: DEG\_Mutations\_Annotations.rda,
Oncogenic\_mediators\_mutation\_summary.rda and cscape\_somatic\_output.rda. These will be placed
in the specified results-folder.
The user needs to download two CScape-somatic files in order to run DMA named css\_coding.vcf.gz
and css\_noncoding.vcf.gz, respectively. These two files can be downloaded at
<http://cscape-somatic.biocompute.org.uk/#download>. The corresponding .tbi files (css\_coding.vcf.gz.tbi
and css\_noncoding.vcf.gz.tbi) must also be downloaded and be placed in the same folder.

```
data(dataPRA)
data(dataMAF)
data(DEGsmatrix)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(NCG)
data(EncodePromoters)
dataDMA <- DMA(dataMAF = dataMAF,
               dataDEGs = DEGsmatrix,
               dataPRA = dataPRA,
               results_folder = "DMAresults",
               coding_file = "css_coding.vcf.gz",
               noncoding_file = "css_noncoding.vcf.gz")
```

## `GMA`: Gene Methylation Analysis

The user can predict driver genes with `GMA` following prediction of the
oncogenic mediators established by `PRA`. `GMA` predicts driver genes by
investigating abnormal DNA methylation patterns in the oncogenic mediators
using the tool EpiMix (Zheng, Yuanning and Jun, John and Brennan, Kevin and Gevaert, Olivier [2023](#ref-ref28)). Oncogenic mediators with hypo- and hypermethylation
patterns are predicted as OCGs and TSGs, respectively. This function will
generate these files: DEG\_Methylation\_Annotations.rda,
Oncogenic\_mediators\_methylation\_summary.rda, EpiMix\_Results\_Enhancer.rds,
EpiMix\_Results\_Regular.rds, FunctionalPairs\_Enhancer.csv, FunctionalPairs\_Regular.csv,
and FunctionalProbes\_Regular.rds. These will be placed in the specified results-folder.

```
data("dataMethyl")
data("dataFilt")
data("dataPRA")
data("DEGsmatrix")
data("LUAD_sample_anno")
data("NCG")
data("EncodePromoters")
data("MetEvidenceDriver")

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

dataGMA <- GMA(dataMET = dataMethyl, dataEXP = dataFilt,
               dataPRA = dataPRA, dataDEGs = DEGsmatrix,
               sample_info = LUAD_sample_anno, met_platform = "HM450",
               prevalence_filter = NULL,
               output_dir = "./GMAresults", cores = 1, roadmap.epigenome.ids = "E096",
               roadmap.epigenome.groups = NULL)
```

```
## Running Regular mode...
## Fetching probe annotation...
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## loading from cache
```

```
## require("GenomicRanges")
```

```
## Found 13 samples with both methylation and gene expression data.
## Modeling gene expression...
##
  |
  |                                                                      |   0%
  |
  |=                                                                     |   1%
  |
  |==                                                                    |   3%
  |
  |===                                                                   |   4%
  |
  |====                                                                  |   5%
  |
  |=====                                                                 |   7%
  |
  |======                                                                |   8%
  |
  |=======                                                               |  10%
  |
  |========                                                              |  11%
  |
  |=========                                                             |  12%
  |
  |==========                                                            |  14%
  |
  |===========                                                           |  15%
  |
  |============                                                          |  16%
  |
  |============                                                          |  18%
  |
  |=============                                                         |  19%
  |
  |==============                                                        |  21%
  |
  |===============                                                       |  22%
  |
  |================                                                      |  23%
  |
  |=================                                                     |  25%
  |
  |==================                                                    |  26%
  |
  |===================                                                   |  27%
  |
  |====================                                                  |  29%
  |
  |=====================                                                 |  30%
  |
  |======================                                                |  32%
  |
  |=======================                                               |  33%
  |
  |========================                                              |  34%
  |
  |=========================                                             |  36%
  |
  |==========================                                            |  37%
  |
  |===========================                                           |  38%
  |
  |============================                                          |  40%
  |
  |=============================                                         |  41%
  |
  |==============================                                        |  42%
  |
  |===============================                                       |  44%
  |
  |================================                                      |  45%
  |
  |=================================                                     |  47%
  |
  |==================================                                    |  48%
  |
  |===================================                                   |  49%
  |
  |===================================                                   |  51%
  |
  |====================================                                  |  52%
  |
  |=====================================                                 |  53%
  |
  |======================================                                |  55%
  |
  |=======================================                               |  56%
  |
  |========================================                              |  58%
  |
  |=========================================                             |  59%
  |
  |==========================================                            |  60%
  |
  |===========================================                           |  62%
  |
  |============================================                          |  63%
  |
  |=============================================                         |  64%
  |
  |==============================================                        |  66%
  |
  |===============================================                       |  67%
  |
  |================================================                      |  68%
  |
  |=================================================                     |  70%
  |
  |==================================================                    |  71%
  |
  |===================================================                   |  73%
  |
  |====================================================                  |  74%
  |
  |=====================================================                 |  75%
  |
  |======================================================                |  77%
  |
  |=======================================================               |  78%
  |
  |========================================================              |  79%
  |
  |=========================================================             |  81%
  |
  |==========================================================            |  82%
  |
  |==========================================================            |  84%
  |
  |===========================================================           |  85%
  |
  |============================================================          |  86%
  |
  |=============================================================         |  88%
  |
  |==============================================================        |  89%
  |
  |===============================================================       |  90%
  |
  |================================================================      |  92%
  |
  |=================================================================     |  93%
  |
  |==================================================================    |  95%
  |
  |===================================================================   |  96%
  |
  |====================================================================  |  97%
  |
  |===================================================================== |  99%
  |
  |======================================================================| 100%
## Found 73 transcriptionally predictive probes.
## Found 17 samples in group.1 and 6 samples in group.2
##
## Starting Beta mixture modeling.
## Running Beta mixture model on 73 probes and on 17 samples.
##
  |
  |                                                                      |   0%
## Found 73 differentially methylated CpGs
## Identifying functional CpG-gene pairs...
##
  |
  |                                                                      |   0%
  |
  |==                                                                    |   3%
  |
  |====                                                                  |   6%
  |
  |======                                                                |   9%
  |
  |========                                                              |  12%
  |
  |===========                                                           |  15%
  |
  |=============                                                         |  18%
  |
  |===============                                                       |  21%
  |
  |=================                                                     |  24%
  |
  |===================                                                   |  27%
  |
  |=====================                                                 |  30%
  |
  |=======================                                               |  33%
  |
  |=========================                                             |  36%
  |
  |============================                                          |  39%
  |
  |==============================                                        |  42%
  |
  |================================                                      |  45%
  |
  |==================================                                    |  48%
  |
  |====================================                                  |  52%
  |
  |======================================                                |  55%
  |
  |========================================                              |  58%
  |
  |==========================================                            |  61%
  |
  |=============================================                         |  64%
  |
  |===============================================                       |  67%
  |
  |=================================================                     |  70%
  |
  |===================================================                   |  73%
  |
  |=====================================================                 |  76%
  |
  |=======================================================               |  79%
  |
  |=========================================================             |  82%
  |
  |===========================================================           |  85%
  |
  |==============================================================        |  88%
  |
  |================================================================      |  91%
  |
  |==================================================================    |  94%
  |
  |====================================================================  |  97%
  |
  |======================================================================| 100%
## Found 84 functional probe-gene pairs.
## Saving the EpiMix results to the output directory...
## Running Enhancer mode...
## Fetching probe annotation...
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## loading from cache
```

```
## Found 17 samples in group.1 and 6 samples in group.2
## Fetching enhancer CpGs from Roadmap Epigenomics...
## Downloading chromatin states from the Roadmap Epigenomics...
##  Identifed 65057 enhancer CpGs from the epigenome E096
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
## loading from cache
```

```
## Returning distal probes: 160862
```

```
## Found 7 CpGs associated with distal enhancers in the methylation dataset
##
## Starting Beta mixture modeling.
## Running Beta mixture model on 7 probes and on 17 samples.
##
  |
  |                                                                      |   0%
## Found 7 differentially methylated CpGs
## Modeling the gene expression for enhancers...
```

```
## Searching for the 20 near genes
```

```
## Identifying gene position for each probe
```

```
## Looking for differentially methylated enhancers associated with gene expression
##
  |
  |                                                                      |   0%
  |
  |==========                                                            |  14%
  |
  |====================                                                  |  29%
  |
  |==============================                                        |  43%
  |
  |========================================                              |  57%
  |
  |==================================================                    |  71%
  |
  |============================================================          |  86%
  |
  |======================================================================| 100%
## Found 2 functional probe-gene pairs.
## Saving the EpiMix results to the output directory...
```

```
## see ?sesameData and browseVignettes('sesameData') for documentation
```

```
## loading from cache
```

```
## [1] "3 oncogenic mediator(s) out of 3 were found in the None evidence category"
```

## `GLS`: Gene Literature Search

The user can perform a literature search on driver genes
using the `GLS` function. This function takes as input driver genes,
a query and maximum number of records to retrieve from PubMed.
Standard PubMed syntax can be used in the query. For example, Boolean
operators AND, OR, NOT can be applied and tags such as [AU],
[TITLE/ABSTRACT], [Affiliation] can be used. `GLS` fetches data of
PubMed records matching the specified query and outputs PubMed IDs
matching the query along with doi, title, abstract, year of publication,
mesh terms, and total number of PubMed publications. This is done for each
of the genes supplied in the input.

```
genes_query <- "BRCA1"
dataGLS <- GLS(genes = genes_query,
           query_string = "AND cancer AND driver")
```

```
##
```

```
## Retrieving records .
## Parsing record information
## |----+----+----+----| 100%
## |...................|
```

```
head(dataGLS)
```

```
## # A tibble: 6 × 8
##   pmid     gene  doi                title abstract  year mesh_terms pubmed_count
##   <chr>    <chr> <chr>              <chr> <chr>    <dbl> <chr>             <dbl>
## 1 41318657 BRCA1 10.1038/s41419-02… RAD5… Triple-…  2025 <NA>                344
## 2 41194282 BRCA1 10.1186/s13148-02… Cons… Constit…  2025 Humans; C…          344
## 3 41162355 BRCA1 10.1038/s41467-02… BRCA… BRCA2 p…  2025 Genomic I…          344
## 4 41143909 BRCA1 10.1007/s00428-02… Clin… STK11 m…  2025 <NA>                344
## 5 41114336 BRCA1 10.3389/fonc.2025… The … Gallbla…  2025 <NA>                344
## 6 41051921 BRCA1 10.1158/2767-9764… Deve… Despite…  2025 Animals; …          344
```

## Transcription factor-based layer of secondary evidence

We now introduce the third layer of secondary evidence. It is based on the assumption
that stability changes due to mutations on transcription factors can influence
transcription. Here, we use data on change of stability upon mutation available in the
MAVISp database, as well as data from the [TRRUST database](https://www.grnpedia.org/trrust/)
and MAF files from TCGA to i) identify transcription factors that have an effect
on the transcription of genes of interest ii) identify potentially damaging mutations on them from
MAF files and iii) use MAVISp data to assess the affect of such mutations, whether they
might destabilizing or not. We release the TRRUST-derived data within the Moonlight2R
package with a Creative Commons Attribution-ShareAlike 4.0 International license.

## `loadMAVISp`: Helper function for loading the MAVISp database

The first step to perform this is loading the data form the MAVISp database.

Notice that we have included a very small portion of the MAVISp database with Moonlight2R
for testing purposes; we recommend using the full database available at
the [MAVISp OSF repository](https://osf.io/ufpzm/). Also see the
[MAVISp preprint](https://www.biorxiv.org/content/10.1101/2022.10.22.513328v5) for specifics
on what datasets are available in MAVISp.

The `loadMAVISp` function is used to load the files available from the
MAVISp database. The user will need to decide on whether they want to import the simple or ensemble mode and
in the case of ensemble mode, choose the ensemble they want to import. Furthermore,
the user can specify specific proteins to load. The output is a list of tibbles,
each one correponding to a file in the MAVISp database. The output is used directly
in the `TFinfluence` function.

```
mavisp_db_location <- system.file('extdata', 'mavisp_db', package='Moonlight2R')

specific_protein <- loadMAVISp(mavispDB = mavisp_db_location,
                               mode = 'simple',
                               proteins_of_interest = c('RUNX1'))

all_proteins <- loadMAVISp(mavispDB = mavisp_db_location,
                           mode = 'simple')

ensemble <- loadMAVISp(mavispDB = mavisp_db_location,
                       mode = 'ensemble',
                       ensemble = 'cabsflex')
```

## `TFinfluence`: Effect of mutations on transcription factors

As previosuly introduceed, the `TFinfluence` function can be used as after the PRA
function, to identify if there are mutations in the transcription factors of the DEGs. The function
uses data from TRRUST to couple the DEGs with their transcription factor (TF).
The mutations in the TFs come from a MAF file, and the effect of the mutation
is obtained from the MAVISp database, available at an [OSF repository](https://osf.io/ufpzm/).

```
data(dataPRA)
data(DEGsmatrix)
data(dataTRRUST)
data(dataMAF)
data(dataMAVISp)

TFresults <- TFinfluence(dataTRRUST = dataTRRUST,
            dataMAF = dataMAF,
            dataDEGs = DEGsmatrix,
            dataPRA = dataPRA,
            dataMAVISp = dataMAVISp,
            stabClassMAVISp = 'rasp')
```

## `Level of consequence`: Effect of mutations on three different levels

The user can investigate the predicted effect of different mutation types on the transcriptional
level through the table LOC\_transcription:

```
knitr::kable(LOC_transcription)
```

| Variant\_Classification | SNP | INS | DEL | DNP | TNP | ONP |
| --- | --- | --- | --- | --- | --- | --- |
| 5’Flank | 1 | 1 | 1 | 1 | 1 | 1 |
| 5’UTR | 1 | 1 | 1 | 1 | 1 | 1 |
| Translation\_Start\_Site | 0 | 0 | 0 | 0 | 0 | 0 |
| Missense\_Mutation | 0 | NA | NA | 0 | 0 | 0 |
| Nonsense\_Mutation | 1 | 1 | 1 | 1 | 1 | 1 |
| Nonstop\_Mutation | 0 | 0 | 0 | 0 | 0 | 0 |
| Splice\_Site | 1 | 1 | 1 | 1 | 1 | 1 |
| Splice\_Region | 1 | 1 | 1 | 1 | 1 | 1 |
| Silent | 0 | NA | NA | 0 | 0 | 0 |
| In\_Frame\_Del | NA | 0 | 0 | NA | NA | NA |
| In\_Frame\_Ins | NA | 0 | 0 | NA | NA | NA |
| Frame\_Shift\_Del | NA | 0 | 0 | NA | NA | NA |
| Frame\_Shift\_Ins | NA | 0 | 0 | NA | NA | NA |
| Intron | 1 | 1 | 1 | 1 | 1 | 1 |
| 3’UTR | 1 | 1 | 1 | 1 | 1 | 1 |
| 3’Flank | 1 | 1 | 1 | 1 | 1 | 1 |
| RNA | 1 | 1 | 1 | 1 | 1 | 1 |
| IGR | 1 | 1 | 1 | 1 | 1 | 1 |

The user can investigate the predicted effect of different mutation types on the translational
level through the table LOC\_translation:

```
knitr::kable(LOC_translation)
```

| Variant\_Classification | SNP | INS | DEL | DNP | TNP | ONP |
| --- | --- | --- | --- | --- | --- | --- |
| 5’Flank | 1 | 1 | 1 | 1 | 1 | 1 |
| 5’UTR | 1 | 1 | 1 | 1 | 1 | 1 |
| Translation\_Start\_Site | 1 | 1 | 1 | 1 | 1 | 1 |
| Missense\_Mutation | 0 | NA | NA | 0 | 0 | 0 |
| Nonsense\_Mutation | 1 | 1 | 1 | 1 | 1 | 1 |
| Nonstop\_Mutation | 1 | 1 | 1 | 1 | 1 | 1 |
| Splice\_Site | 1 | 1 | 1 | 1 | 1 | 1 |
| Splice\_Region | 1 | 1 | 1 | 1 | 1 | 1 |
| Silent | 1 | NA | NA | 1 | 1 | 1 |
| In\_Frame\_Del | NA | 0 | 0 | NA | NA | NA |
| In\_Frame\_Ins | NA | 0 | 0 | NA | NA | NA |
| Frame\_Shift\_Del | NA | 0 | 0 | NA | NA | NA |
| Frame\_shift\_Ins | NA | 0 | 0 | NA | NA | NA |
| Intron | 1 | 1 | 1 | 1 | 1 | 1 |
| 3’UTR | 1 | 1 | 1 | 1 | 1 | 1 |
| 3’Flank | 1 | 1 | 1 | 1 | 1 | 1 |
| IGR | 1 | 1 | 1 | 1 | 1 | 1 |
| RNA | 1 | 1 | 1 | 1 | 1 | 1 |

The user can investigate the predicted effect of different mutation types on the protein level
through the table LOC\_protein:

```
knitr::kable(LOC_protein)
```

| Variant\_Classification | SNP | INS | DEL | DNP | TNP | ONP |
| --- | --- | --- | --- | --- | --- | --- |
| 5’Flank | 0 | 0 | 0 | 0 | 0 | 0 |
| 5’UTR | 0 | 0 | 0 | 0 | 0 | 0 |
| Translation\_Start\_Site | 1 | 1 | 1 | 1 | 1 | 1 |
| Missense\_Mutation | 1 | NA | NA | 1 | 1 | 1 |
| Nonsense\_Mutation | 1 | 1 | 1 | 1 | 1 | 1 |
| Nonstop\_Mutation | 1 | 1 | 1 | 1 | 1 | 1 |
| Splice\_Site | 1 | 1 | 1 | 1 | 1 | 1 |
| Splice\_Region | 1 | 1 | 1 | 1 | 1 | 1 |
| Silent | 0 | NA | NA | 0 | 0 | 0 |
| In\_Frame\_Del | NA | 1 | 1 | NA | NA | NA |
| In\_Frame\_Ins | NA | 1 | 1 | NA | NA | NA |
| Frame\_Shift\_Del | NA | 1 | 1 | NA | NA | NA |
| Frame\_Shift\_Ins | NA | 1 | 1 | NA | NA | NA |
| Intron | 1 | 1 | 1 | 1 | 1 | 1 |
| 3’UTR | 0 | 0 | 0 | 0 | 0 | 0 |
| 3’Flank | 0 | 0 | 0 | 0 | 0 | 0 |
| RNA | 0 | 0 | 0 | 0 | 0 | 0 |
| IGR | 0 | 0 | 0 | 0 | 0 | 0 |

## `plotNetworkHive`: GRN hive visualization taking into account COSMIC cancer genes

In the following plot the nodes are separated into three groups: known tumor suppressor genes (yellow),
known oncogenes (green) and the rest (gray).

```
data(knownDriverGenes)
data(dataGRN)
plotNetworkHive(dataGRN, knownDriverGenes, 0.55)
```

![](data:image/png;base64...)

## `plotDMA`: Heatmap of the driver/passenger status of mutations in TSGs/OCGs

In the following plot the driver genes with driver mutations are shown.

```
data(dataDMA)
data(DEG_Mutations_Annotations)
data(Oncogenic_mediators_mutation_summary)
plotDMA(DEG_Mutations_Annotations,
        Oncogenic_mediators_mutation_summary,
        type = 'complete', additionalFilename = "")
```

![](data:image/gif;base64...)

## `plotMoonlight`: Heatmap of Moonlight Gene Z-scores for mutation-driven TSGs/OCGs

In the following plot the top 50 genes with the most driver mutations are visualised.
The values are the moonlight gene z-score for the two biological processes

```
data(DEG_Mutations_Annotations)
data(Oncogenic_mediators_mutation_summary)
data(dataURA_plot)
plotMoonlight(DEG_Mutations_Annotations,
        Oncogenic_mediators_mutation_summary,
        dataURA_plot, gene_type = "drivers", n = 50)
```

![](data:image/gif;base64...)

## `plotGMA`: Heatmap of hypo/hyper/dual methylated CpG sites in TSGs/OCGs

This function plots results of the `GMA`. It visualizes the
number of hypo/hyper/dual methylated CpG sites in oncogenic
mediators or in a user-supplied gene list. The results are
visualized either in a single heatmap or split into different
ones which is specified in the function’s three modes:
split, complete and genelist.

```
data("DEG_Methylation_Annotations")
data("Oncogenic_mediators_methylation_summary")
genes <- c("ACAN", "ACE2", "ADAM19", "AFAP1L1")
plotGMA(DEG_Methylation_Annotations = DEG_Methylation_Annotations,
        Oncogenic_mediators_methylation_summary = Oncogenic_mediators_methylation_summary,
        type = "genelist", genelist = genes,
        additionalFilename = "./GMAresults/")
```

![](data:image/gif;base64...)

## `plotMoonlightMet`: Heatmap of Moonlight Gene Z-scores for methylation-driven TSGs/OCGs

This function visualizes the effect of genes on biological processes
and total number of hypo/hyper/dual methylated CpG sites in genes.

```
data("DEG_Methylation_Annotations")
data("Oncogenic_mediators_methylation_summary")
data("dataURA_plot")
genes <- c("ACAN", "ACE2", "ADAM19", "AFAP1L1")
plotMoonlightMet(DEG_Methylation_Annotations = DEG_Methylation_Annotations,
                 Oncogenic_mediators_methylation_summary = Oncogenic_mediators_methylation_summary,
                 dataURA = dataURA_plot,
                 genes = genes,
                 additionalFilename = "./GMAresults/")
```

![](data:image/gif;base64...)

## `plotMetExp`: Visualize results from EpiMix of expression and methylation in genes

This function visualizes results of EpiMix (Zheng, Yuanning and Jun, John and Brennan, Kevin and Gevaert, Olivier [2023](#ref-ref28)) in three plots: one that
visualizes the distribution of DNA methylation data (MixtureModelPlot), one
that visualizes gene expression levels (ViolinPlot) and one that visualizes
relationship between DNA methylation and gene expression (CorrelationPlot).

```
data("EpiMix_Results_Regular")
data("dataMethyl")
data("dataFilt")

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

plotMetExp(EpiMix_results = EpiMix_Results_Regular,
           probe_name = "cg03035704",
           dataMET = dataMethyl,
           dataEXP = dataFilt,
           gene_of_interest = "ACVRL1",
           additionalFilename = "./GMAresults/")
```

```
## p value = 0.009484347 R-squared =  0.641
```

![](data:image/png;base64...)

# Moonlight Analysis: Case Studies

### Introduction

This vignette shows a complete workflow of the ‘Moonlight2R’ package.
The code is divided into the following case studies:

* 1. Predicting oncogenic mediators using Moonlight’s primary layer
* 2. Moonlight pipeline in one function
* 3. Moonlight with driver mutation analysis
* 4. Moonlight with gene methylation analysis

## Case study n. 1: Predicting oncogenic mediators using Moonlight’s primary layer

For illustrative purposes and to decrease runtime, we have set `nGenesPerm = 5`
and `nBoot = 5` in the call of `GRN` in the following code block, however, we
recommend setting these parameters to `nGenesPerm = 2000` and `nBoot = 400` to
achieve optimal results, as they are set by default in the function arguments.

```
data(DEGsmatrix)
data(dataFilt)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)

dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

dataGRN <- GRN(TFs = sample(rownames(DEGsmatrix), 100),
               DEGsmatrix = DEGsmatrix,
               DiffGenes = TRUE,
               normCounts = dataFilt,
               nGenesPerm = 5,
               nBoot = 5,
           kNearest = 3)

dataURA <- URA(dataGRN = dataGRN,
              DEGsmatrix = DEGsmatrix,
              BPname = c("apoptosis",
                         "proliferation of cells"))

dataDual <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

oncogenic_mediators <- list("TSG"=names(dataDual$TSG), "OCG"=names(dataDual$OCG))
```

## `plotURA`: Upstream regulatory analysis plot

The user can plot the result of the upstream regulatory analysis using the function `plotURA`.

```
data(dataURA)
plotURA(dataURA = dataURA, additionalFilename = "_exampleVignette")
```

The figure resulted from the code above is shown below:
![](data:image/gif;base64...)

## Case study n. 2: Moonlight pipeline in one function

For illustrative purposes and to decrease runtime, we have set `nGenesPerm = 5` and `nBoot = 5`
in the following code block, however, we recommend setting these parameters to
`nGenesPerm = 2000` and `nBoot = 400` to achieve optimal results, as they are
set by default in the function arguments.

```
data(dataFilt)
data(DEGsmatrix)
data(dataMAF)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(NCG)
data(EncodePromoters)

listMoonlight <- moonlight(dataDEGs = DEGsmatrix,
                           dataFilt = dataFilt,
                           nTF = 100,
                           DiffGenes = TRUE,
               nGenesPerm = 5,
                           nBoot = 5,
                           BPname = c("apoptosis","proliferation of cells"),
                           dataMAF = dataMAF,
                           path_cscape_coding = "css_coding.vcf.gz",
                           path_cscape_noncoding = "css_noncoding.vcf.gz")
save(listMoonlight, file = paste0("listMoonlight_ncancer4.Rdata"))
```

## `plotCircos`: Moonlight Circos Plot

An example of running Moonlight on five cancer types is visualized below in a circos plot.
Outer ring: color by cancer type, Inner ring: OCGs and TSGs,
Inner connections: green: common OCGs yellow: common TSGs red: possible dual role

```
data(listMoonlight)
plotCircos(listMoonlight = listMoonlight, additionalFilename = "_ncancer5")
```

The figure generated by the code above is shown below:
![](data:image/gif;base64...)

## Case study n. 3: Moonlight with driver mutation analysis

For illustrative purposes and to decrease runtime, we have set `nGenesPerm = 5` and `nBoot = 5`
in the call of `GRN` in the following code block, however, we recommend setting these parameters to
`nGenesPerm = 2000` and `nBoot = 400` to achieve optimal results, as they are
set by default in the function arguments.

```
data(DEGsmatrix)
data(dataFilt)
data(dataMAF)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(NCG)
data(EncodePromoters)

# Perform gene regulatory network analysis
dataGRN <- GRN(TFs = rownames(DEGsmatrix),
           DEGsmatrix = DEGsmatrix,
           DiffGenes = TRUE,
               normCounts = dataFilt,
               nGenesPerm = 5,
               kNearest = 3,
               nBoot = 5)

# Perform upstream regulatory analysis
# As example, we use apoptosis and proliferation of cells as the biological processes
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               nCores = 1)

# Perform pattern recognition analysis
dataPRA <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

# Perform driver mutation analysis
dataDMA <- DMA(dataMAF = dataMAF,
               dataDEGs = DEGsmatrix,
               dataPRA = dataPRA,
               results_folder = "DMAresults",
               coding_file = "css_coding.vcf.gz",
               noncoding_file = "css_noncoding.vcf.gz")
```

Next, we analyze the predicted driver genes and their mutations.

```
data(Oncogenic_mediators_mutation_summary)
data(DEG_Mutations_Annotations)

# Extract oncogenic mediators that contain at least one driver mutation
# These are the driver genes
knitr::kable(Oncogenic_mediators_mutation_summary %>%
  filter(!is.na(CScape_Driver)))
```

| Hugo\_Symbol | Moonlight\_Oncogenic\_Mediator | CScape\_Passenger | CScape\_Driver | CScape\_Unclassified | Transcription\_mut\_sum | Translation\_mut\_sum | Protein\_mut\_sum | Total\_Mutations | NCG\_driver | NCG\_cgc\_annotation | NCG\_vogelstein\_annotation | NCG\_saito\_annotation | NCG\_pubmed\_id | NCG\_cancer\_type |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ABCG2 | OCG | NA | 1 | NA | 0 | 0 | 1 | 1 | Candidate | NA | NA | NA | 30718927 | esophageal\_adenocarcinoma |

```
# Extract mutation annotations of the predicted driver genes
driver_mut <- DEG_Mutations_Annotations %>%
  filter(!is.na(Moonlight_Oncogenic_Mediator),
         CScape_Mut_Class == "Driver")

# Extract driver genes with a predicted effect on the transcriptional level
transcription_mut <- Oncogenic_mediators_mutation_summary %>%
  filter(!is.na(CScape_Driver)) %>%
  filter(Transcription_mut_sum > 0)

# Extract mutation annotations of predicted driver genes that have a driver mutation
# in its promoter region with a potential effect on the transcriptional level
promoters <- DEG_Mutations_Annotations %>%
  filter(!is.na(Moonlight_Oncogenic_Mediator),
         CScape_Mut_Class == "Driver",
         Potential_Effect_on_Transcription == 1,
         Annotation == 'Promoter')
```

## Case study n. 4: Moonlight with gene methylation analysis

For illustrative purposes and to decrease runtime, we have set `nGenesPerm = 5` and `nBoot = 5`
in the call of `GRN` in the following code block, however, we recommend setting these parameters to
`nGenesPerm = 2000` and `nBoot = 400` to achieve optimal results, as they are
set by default in the function arguments.

```
data(DEGsmatrix)
data(dataFilt)
data(dataMAF)
data(DiseaseList)
data(EAGenes)
data(tabGrowBlock)
data(knownDriverGenes)
data(LOC_transcription)
data(LOC_translation)
data(LOC_protein)
data(NCG)
data(EncodePromoters)
data(dataMethyl)
data(LUAD_sample_anno)
data(MetEvidenceDriver)

# Perform gene regulatory network analysis
dataGRN <- GRN(TFs = rownames(DEGsmatrix),
               DEGsmatrix = DEGsmatrix,
               DiffGenes = TRUE,
               normCounts = dataFilt,
               nGenesPerm = 5,
               kNearest = 3,
               nBoot = 5)

# Perform upstream regulatory analysis
# As example, we use apoptosis and proliferation of cells as the biological processes
dataURA <- URA(dataGRN = dataGRN,
               DEGsmatrix = DEGsmatrix,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               nCores = 1)

# Perform pattern recognition analysis
dataPRA <- PRA(dataURA = dataURA,
               BPname = c("apoptosis",
                          "proliferation of cells"),
               thres.role = 0)

# Subset column names (sample names) in expression data to patient level
pattern <- "^(.{4}-.{2}-.{4}-.{2}).*"
colnames(dataFilt) <- sub(pattern, "\\1", colnames(dataFilt))

# Perform gene methylation analysis
dataGMA <- GMA(dataMET = dataMethyl, dataEXP = dataFilt,
               dataPRA = dataPRA, dataDEGs = DEGsmatrix,
               sample_info = LUAD_sample_anno, met_platform = "HM450",
               prevalence_filter = NULL,
               output_dir = "./GMAresults", cores = 1,
               roadmap.epigenome.ids = "E096",
               roadmap.epigenome.groups = NULL)
```

## Citation

Please cite the MoonlightR and Moonlight2R packages:

* “Interpreting pathways to discover cancer driver genes with Moonlight.” Nature Communications (2020): [10.1038/s41467-019-13803-0](https://doi.org/10.1038/s41467-019-13803-0). (Colaprico, Antonio and Olsen, Catharina and Bailey, Matthew H. and Odom, Gabriel J. and Terkelsen, Thilde and Silva, Tiago C. and Olsen, André V. and Cantini, Laura and Zinovyev, Andrei and Barillot, Emmanuel and Noushmehr, Houtan and Bertoli, Gloria and Castiglioni, Isabella and Cava, Claudia and Bontempi, Gianluca and Chen, Xi Steven and Papaleo, Elena [2020](#ref-ref26))
* “A workflow to study mechanistic indicators for driver gene prediction with Moonlight.” Briefings in Bioinformatics (2023): [10.1093/bib/bbad274](https://doi.org/10.1093/bib/bbad274). (Nourbakhsh, Mona and Saksager, Astrid and Tom, Nikola and Chen, Xi Steven and Colaprico, Antonio and Olsen, Catharina and Tiberti, Matteo and Papaleo, Elena [2023](#ref-ref27))

Related publications to this vignette:

* “TCGAbiolinks: an R/Bioconductor package for integrative analysis of TCGA data.” Nucleic acids research (2015): [gkv1507](http://dx.doi.org/doi%3A10.1093/nar/gkv1507). (Colaprico, Antonio and Silva, Tiago C. and Olsen, Catharina and Garofano, Luciano and Cava, Claudia and Garolini, Davide and Sabedot, Thais S. and Malta, Tathiane M. and Pagnotta, Stefano M. and Castiglioni, Isabella and Ceccarelli, Michele and Bontempi, Gianluca and Noushmehr, Houtan [2016](#ref-ref25))
* “TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages”. F1000Research [10.12688/f1000research.8923.1](http://dx.doi.org/doi%3A10.12688/f1000research.8923.1) (Silva, TC and Colaprico, A and Olsen, C and D’Angelo, F and Bontempi, G and Ceccarelli, M and Noushmehr, H [2016](#ref-ref24))

---

Session Information
\*\*\*\*\*\*

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] GenomicRanges_1.62.1 Seqinfo_1.0.0        IRanges_2.44.0
##  [4] S4Vectors_0.48.0     sesameData_1.28.0    ExperimentHub_3.0.0
##  [7] AnnotationHub_4.0.0  BiocFileCache_3.0.0  dbplyr_2.5.1
## [10] BiocGenerics_0.56.0  generics_0.1.4       dplyr_1.1.4
## [13] magrittr_2.0.4       Moonlight2R_1.8.1    doParallel_1.0.17
## [16] iterators_1.0.14     foreach_1.5.2        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                    matrixStats_1.5.0
##   [3] bitops_1.0-9                HiveR_0.4.0
##   [5] enrichplot_1.30.4           httr_1.4.7
##   [7] RColorBrewer_1.1-3          tools_4.5.2
##   [9] utf8_1.2.6                  R6_2.6.1
##  [11] mgcv_1.9-4                  lazyeval_0.2.2
##  [13] GetoptLong_1.1.0            withr_3.0.2
##  [15] prettyunits_1.2.0           gridExtra_2.3
##  [17] RISmed_2.3.0                textshaping_1.0.4
##  [19] archive_1.1.12              cli_3.6.5
##  [21] Biobase_2.70.0              Cairo_1.7-0
##  [23] scatterpie_0.2.6            labeling_0.4.3
##  [25] sass_0.4.10                 S7_0.2.1
##  [27] randomForest_4.7-1.2        readr_2.1.6
##  [29] askpass_1.2.1               EpiMix_1.12.0
##  [31] Rsamtools_2.26.0            systemfonts_1.3.1
##  [33] yulab.utils_0.2.3           gson_0.1.0
##  [35] DOSE_4.4.0                  R.utils_2.13.0
##  [37] rentrez_1.2.4               dichromat_2.0-0.1
##  [39] limma_3.66.0                RSQLite_2.4.5
##  [41] gridGraphics_0.5-1          shape_1.4.6.1
##  [43] BiocIO_1.20.0               vroom_1.6.7
##  [45] gtools_3.9.5                dendextend_1.19.1
##  [47] GO.db_3.22.0                Matrix_1.7-4
##  [49] abind_1.4-8                 R.methodsS3_1.8.2
##  [51] lifecycle_1.0.4             yaml_2.3.12
##  [53] SummarizedExperiment_1.40.0 gplots_3.3.0
##  [55] qvalue_2.42.0               SparseArray_1.10.7
##  [57] grid_4.5.2                  blob_1.2.4
##  [59] crayon_1.5.3                ggtangle_0.0.9
##  [61] lattice_0.22-7              cowplot_1.2.0
##  [63] GenomicFeatures_1.62.0      cigarillo_1.0.0
##  [65] KEGGREST_1.50.0             magick_2.9.0
##  [67] pillar_1.11.1               knitr_1.50
##  [69] ComplexHeatmap_2.26.0       fgsea_1.36.0
##  [71] tcltk_4.5.2                 rjson_0.2.23
##  [73] codetools_0.2-20            fastmatch_1.1-6
##  [75] glue_1.8.0                  ggiraph_0.9.2
##  [77] qpdf_1.4.1                  downloader_0.4.1
##  [79] ggfun_0.2.0                 fontLiberation_0.1.0
##  [81] data.table_1.17.8           parmigene_1.1.1
##  [83] vctrs_0.6.5                 png_0.1-8
##  [85] treeio_1.34.0               gtable_0.3.6
##  [87] cachem_1.1.0                EpiMix.data_1.12.0
##  [89] xfun_0.54                   S4Arrays_1.10.1
##  [91] tinytex_0.58                statmod_1.5.1
##  [93] rgl_1.3.31                  nlme_3.1-168
##  [95] ggtree_4.0.1                bit64_4.6.0-1
##  [97] fontquiver_0.2.1            progress_1.2.3
##  [99] filelock_1.0.3              bslib_0.9.0
## [101] KernSmooth_2.23-26          otel_0.2.0
## [103] colorspace_2.1-2            DBI_1.2.3
## [105] tidyselect_1.2.1            bit_4.6.0
## [107] compiler_4.5.2              curl_7.0.0
## [109] tidyHeatmap_1.13.1          httr2_1.2.2
## [111] xml2_1.5.1                  fontBitstreamVera_0.1.1
## [113] RPMM_1.25                   DelayedArray_0.36.0
## [115] bookdown_0.46               rtracklayer_1.70.0
## [117] scales_1.4.0                caTools_1.18.3
## [119] fuzzyjoin_0.1.6.1           rappdirs_0.3.3
## [121] stringr_1.6.0               digest_0.6.39
## [123] rmarkdown_2.30              GEOquery_2.78.0
## [125] XVector_0.50.0              htmltools_0.5.9
## [127] pkgconfig_2.0.3             jpeg_0.1-11
## [129] base64enc_0.1-3             MatrixGenerics_1.22.0
## [131] fastmap_1.2.0               rlang_1.1.6
## [133] GlobalOptions_0.1.3         htmlwidgets_1.6.4
## [135] farver_2.1.2                jquerylib_0.1.4
## [137] jsonlite_2.0.0              BiocParallel_1.44.0
## [139] GOSemSim_2.36.0             R.oo_1.27.1
## [141] RCurl_1.98-1.17             ggplotify_0.1.3
## [143] patchwork_1.3.2             Rcpp_1.1.0
## [145] ape_5.8-1                   ggnewscale_0.5.2
## [147] viridis_0.6.5               gdtools_0.4.4
## [149] stringi_1.8.7               MASS_7.3-65
## [151] plyr_1.8.9                  org.Hs.eg.db_3.22.0
## [153] ggrepel_0.9.6               doSNOW_1.0.20
## [155] Biostrings_2.78.0           splines_4.5.2
## [157] hms_1.1.4                   circlize_0.4.17
## [159] seqminer_9.7                igraph_2.2.1
## [161] reshape2_1.4.5              biomaRt_2.66.0
## [163] BiocVersion_3.22.0          XML_3.99-0.20
## [165] evaluate_1.0.5              BiocManager_1.30.27
## [167] ELMER.data_2.34.0           tzdb_0.5.0
## [169] tweenr_2.0.3                tidyr_1.3.1
## [171] purrr_1.2.0                 polyclip_1.10-7
## [173] clue_0.3-66                 ggplot2_4.0.1
## [175] ggforce_0.5.0               restfulr_0.0.16
## [177] easyPubMed_3.1.6            tidytree_0.4.6
## [179] tidydr_0.0.6                ragg_1.5.0
## [181] viridisLite_0.4.2           snow_0.4-4
## [183] tibble_3.3.0                clusterProfiler_4.18.4
## [185] aplot_0.2.9                 memoise_2.0.1
## [187] AnnotationDbi_1.72.0        GenomicAlignments_1.46.0
## [189] cluster_2.1.8.1
```

# References

Colaprico, Antonio and Olsen, Catharina and Bailey, Matthew H. and Odom, Gabriel J. and Terkelsen, Thilde and Silva, Tiago C. and Olsen, André V. and Cantini, Laura and Zinovyev, Andrei and Barillot, Emmanuel and Noushmehr, Houtan and Bertoli, Gloria and Castiglioni, Isabella and Cava, Claudia and Bontempi, Gianluca and Chen, Xi Steven and Papaleo, Elena. 2020. “Interpreting Pathways to Discover Cancer Driver Genes with Moonlight.” <https://doi.org/10.1038/s41467-019-13803-0>.

Colaprico, Antonio and Silva, Tiago C. and Olsen, Catharina and Garofano, Luciano and Cava, Claudia and Garolini, Davide and Sabedot, Thais S. and Malta, Tathiane M. and Pagnotta, Stefano M. and Castiglioni, Isabella and Ceccarelli, Michele and Bontempi, Gianluca and Noushmehr, Houtan. 2016. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of TCGA Data.” <https://doi.org/10.1093/nar/gkv1507>.

Nourbakhsh, Mona and Saksager, Astrid and Tom, Nikola and Chen, Xi Steven and Colaprico, Antonio and Olsen, Catharina and Tiberti, Matteo and Papaleo, Elena. 2023. “A Workflow to Study Mechanistic Indicators for Driver Gene Prediction with Moonlight.” <https://doi.org/10.1093/bib/bbad274>.

Rogers, Mark F and Gaunt, Tom R and Campbell, Colin. 2020. “CScape-Somatic: Distinguishing Driver and Passenger Point Mutations in the Cancer Genome.” <https://doi.org/10.1093/bioinformatics/btaa242>.

Silva, TC and Colaprico, A and Olsen, C and D’Angelo, F and Bontempi, G and Ceccarelli, M and Noushmehr, H. 2016. “TCGA Workflow: Analyze Cancer Genomics and Epigenomics Data Using Bioconductor Packages.” <https://doi.org/10.12688/f1000research.8923.1>.

Zheng, Yuanning and Jun, John and Brennan, Kevin and Gevaert, Olivier. 2023. “EpiMix Is an Integrative Tool for Epigenomic Subtyping Using DNA Methylation.” <https://doi.org/10.1016/j.crmeth.2023.100515>.