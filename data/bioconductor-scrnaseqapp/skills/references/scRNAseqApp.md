# scRNAseqApp Guide

Jianhong Ou

#### 30 October 2025

# 1 Introduction

Single-cell RNA sequencing (scRNA-seq) is a powerful technique to study gene
expression, cellular heterogeneity, and cell states within samples in
single-cell level. The development of scRNA-seq shed light to address the
knowledge gap about the cell types, cell interactions, and key genes involved
in biological process and their dynamics.

To increase the re-usability and reproducibility of scientific findings,
more and more publishers require raw data and detailed descriptions of how the
data were analyzed. However, difficulties arise due to the highly concise
descriptions of analysis and the differences of the computing environments.
Furthermore, to precisely meet the publishing requirement, the communication of
the bioinformatician with researchers is a time-consuming step.
Multiple interactive visualization tools were developed to provide the
researchers access to the details of the data. Those tools include,
but not limited to,
alona[1](#section-ref-franzen2020alona),
ASAP[2](#section-ref-gardeux2017asap),
Asc-Seurat[3](#section-ref-pereira2021asc),
BingleSeq[4](#section-ref-dimitrov2020bingleseq),
CellView[5](#section-ref-bolisetty2017cellview),
cellxgene VIP[6](#section-ref-li2022cellxgene),
Cerebro[7](#section-ref-hillje2020cerebro),
CHARTS[8](#section-ref-bernstein2021charts),
ChromSCape[9](#section-ref-prompsy2020interactive),
Cirrocumulus[10](#section-ref-li2020cumulus),
CReSCENT[11](#section-ref-mohanraj2020crescent),
Cytosplore Viewer[12](#section-ref-tasic2018shared),
Granatum[13](#section-ref-zhu2017granatum),
InterCellar[14](#section-ref-interlandi2022intercellar),
iS-CellR[15](#section-ref-patel2018cellr),
iSEE[16](#section-ref-rue2018isee),
loom-viewer,
Loupe Cell Browser,
PIVOT[17](#section-ref-zhu2018pivot),
SC1[18](#section-ref-moussa2021sc1),
SCANNER[19](#section-ref-cai2022scanner),
scClustViz[20](#section-ref-innes2018scclustviz),
SCope[21](#section-ref-davie2018single),
scSVA[22](#section-ref-tabaka2019scsva),
scVI[23](#section-ref-lopez2018deep),
SeuratV3Wizard[24](#section-ref-yousif2020nasqar)/NASQAR,
ShinyArchRUiO[25](#section-ref-sharma2022shinyarchr),
ShinyCell[26](#section-ref-ouyang2021shinycell),
singleCellTK[27](#section-ref-hong2022comprehensive),
Single Cell Explorer (scExplorer)[28](#section-ref-feng2019single),
Single Cell Interactive Application (SCiAp)[29](#section-ref-moreno2021user) and
UCSC Cell Browser[30](#section-ref-speir2021ucsc),
SPRING[31](#section-ref-weinreb2018spring),
WASP[32](#section-ref-hoek2021wasp), and
Vitessce[33](#section-ref-keller2021vitessce).

The basic information of the tools are list in the following tables
(the table was created at 12/06/2022):

| Tool | platform | plot type |
| --- | --- | --- |
| alona | web-based | scatters, bar |
| ASAP | web-based | scatters |
| Asc-Seurat | shiny package | scatters, heatmap, violin, dot, trajectory |
| BingleSeq | shiny package | scatters, heatmap, violin, ridge |
| CellView | shiny package | scatters |
| cellxgene VIP | web-based | scatters, bar, and visualization plugin |
| Cerebro/cerebroApp | shiny package | scatters, 3D scatters |
| CHARTS | web-based | scatters, bar |
| ChromSCape | shiny package | scatters, heatmap |
| Cirrocumulus | python package |  |
| CReSCENT | web-based | scatters, violin |
| Cytosplore Viewer | Cytosplore | scatters, phylogeny |
| Granatum | shiny package | scatters, bar, trajectory, ppi |
| InterCellar | shiny package | dot, ppi, circos, radar, pie |
| iS-CellR | shiny package | scatters, heatmap, violin, bar, dot |
| iSEE | shiny package | scatters, heatmap, violin, bar |
| loom-viewer | python package |  |
| Loupe Cell Browser | Desktop | scatters |
| PIVOT | shiny package | scatters, heatmap, violin, bar, pie |
| SC1 | web-based | scatters, heatmap, violin, bar |
| SCANNER | web-based | scatters |
| scClustViz | shiny package | scatters, heatmap, violin, bar, dot |
| scExplorer | web-based | scatters, heatmap |
| SCope | web-based | scatters |
| scSVA | shiny package | scatters, 3D scatters |
| scVI | python package | scatters, heatmap, violin, bar |
| seuratv3wizard | web-based | scatters |
| ShinyArchRUiO | shiny package | scatters, heatmap, track |
| ShinyCell | shiny package | scatters, heatmap, violin, bar |
| SCiAp111 short name for Single Cell Interactive Application | galaxy |  |
| singleCellTK | shiny package | scatters, heatmap, violin, dot, trajectory |
| SPRING | python package | scatters |
| UCSC Cell Browser | web-based | scatters |
| Vitessce | python package | scatters, heatmap |
| WASP | shiny package | scatters, heatmap |

| Tool | languages | license | starts | watching | forks | citation |
| --- | --- | --- | --- | --- | --- | --- |
| alona | python | GPL-3 | 12 | 3 | 5 | 24 |
| ASAP | Java,R,Python | GPL-3 | 18 | 6 | 8 | 88 |
| Asc-Seurat | R | GPL-3 | 12 | 2 | 6 | 10 |
| BingleSeq | R | MIT | 18 | 2 | 6 | 4 |
| CellView | R | MIT | 16 | 9 | 8 | 8 |
| cellxgene VIP | python,R,JavaScript | MIT | 81 | 6 | 24 | 10 |
| Cerebro/cerebroApp | R,JavaScript,C | MIT | 79 | 7 | 18 | 41 |
| CHARTS | python | MIT | 2 | 6 | 0 | 7 |
| ChromSCape | R | GPL-3 | 11 | 2 | 4 | 13 |
| Cirrocumulus | JavaScript,Python | BSD-3 | 38 | 7 | 9 | 78 |
| CReSCENT | R,Perl | GPL-3 | 8 | 1 | 4 | 11 |
| Cytosplore Viewer | java,javascript |  |  |  |  |  |
| Granatum | R | Apache2 | 18 | 4 | 11 | 65 |
| InterCellar | R | MIT | 7 | 1 | 3 | 4 |
| iS-CellR | R | GPL-3 | 21 | 6 | 6 | 15 |
| iSEE | R | MIT | 201 | 14 | 39 | 41 |
| loom-viewer | python,JavaScript | BSD-2 | 32 | 9 | 6 |  |
| Loupe Cell Browser |  |  |  |  |  |  |
| PIVOT | R |  | 27 | 6 | 15 | 27 |
| SC1 | R |  |  |  |  | 5 |
| SCANNER | R |  | 0 | 2 | 1 | 1 |
| scClustViz | R | MIT | 41 | 12 | 10 | 36 |
| scExplorer | JavaScript,Python | GPL-3 | 7 | 3 | 6 | 16 |
| SCope | python,JavaScript | GPL-3 | 60 | 8 | 14 | 438222 the package contribute partial to the citation |
| scSVA | R | GPL-3 | 20 | 6 | 7 | 8 |
| scVI | python | BSD-3 | 840 | 27 | 263 | 787 |
| seuratv3wizard | R | GPL-3 | 29 | 8 | 13 | 28333 citation is from NASQAR |
| ShinyArchRUiO | R | GPL-3 | 11 | 2 | 4 | 3 |
| ShinyCell | R | GPL-3 | 70 | 9 | 23 | 28 |
| SCiAp |  |  |  |  |  | 16 |
| singleCellTK | R | MIT | 105 | 12 | 61 | 6 |
| SPRING | python,matlab,JavaScript |  | 59 | 10 | 29 | 250 |
| UCSC Cell Browser | JavaScript,Python,R | GPL-3 | 3 | 1 | 39 | 46 |
| Vitessce | JavaScript,Python,R | MIT | 92 | 6 | 23 | 2 |
| WASP | R,python |  | 2 | 1 | 0 | 3 |

| Tool | source code |
| --- | --- |
| alona | <https://github.com/oscar-franzen/adobo/> |
| ASAP | <https://github.com/DeplanckeLab/ASAP> |
| Asc-Seurat | <https://github.com/KirstLab/asc_seurat/> |
| BingleSeq | <https://github.com/dbdimitrov/BingleSeq/> |
| CellView | <https://github.com/mohanbolisetty/CellView> |
| cellxgene VIP | <https://github.com/interactivereport/cellxgene_VIP> |
| Cerebro/cerebroApp | <https://github.com/romanhaa/Cerebro> |
| CHARTS | <https://github.com/stewart-lab/CHARTS> |
| ChromSCape | <https://github.com/vallotlab/ChromSCape> |
| Cirrocumulus | <https://github.com/lilab-bcb/cirrocumulus> |
| CReSCENT | <https://github.com/pughlab/crescent> |
| Cytosplore Viewer |  |
| Granatum | <https://github.com/lanagarmire/Granatum> |
| InterCellar | <https://github.com/martaint/InterCellar> |
| iS-CellR | <https://github.com/immcore/iS-CellR> |
| iSEE | <https://github.com/iSEE/iSEE> |
| loom-viewer | <https://github.com/linnarsson-lab/loom-viewer> |
| Loupe Cell Browser |  |
| PIVOT | <https://github.com/kimpenn/PIVOT> |
| SC1 |  |
| SCANNER | <https://github.com/GuoshuaiCai/scanner> |
| scClustViz | <https://github.com/BaderLab/scClustViz> |
| scExplorer | <https://github.com/d-feng/scExplorer> |
| SCope | <https://github.com/aertslab/Scope> |
| scSVA | <https://github.com/klarman-cell-observatory/scSVA> |
| scVI | <https://github.com/scverse/scvi-tools> |
| seuratv3wizard | <https://github.com/nasqar/seuratv3wizard> |
| ShinyArchRUiO | <https://github.com/EskelandLab/ShinyArchRUiO> |
| ShinyCell | <https://github.com/SGDDNB/ShinyCell> |
| SCiAp |  |
| singleCellTK | <https://github.com/compbiomed/singleCellTK> |
| SPRING | <https://github.com/AllonKleinLab/SPRING_dev> |
| UCSC Cell Browser | <https://github.com/ucscGenomeBrowser/cellBrowser> |
| Vitessce | <https://github.com/vitessce/vitessce> |
| WASP | <https://github.com/andreashoek/wasp> |

| Tool | demo |
| --- | --- |
| alona | <https://alona.panglaodb.se/> |
| ASAP | <https://asap.epfl.ch/> |
| Asc-Seurat |  |
| BingleSeq |  |
| CellView | <https://mbolisetty.shinyapps.io/CellView/> |
| cellxgene VIP | <https://cellxgenevip-ms.bxgenomics.com/> |
| Cerebro/cerebroApp |  |
| CHARTS | <https://charts.morgridge.org/> |
| ChromSCape | <https://vallotlab.shinyapps.io/ChromSCape/> |
| Cirrocumulus |  |
| CReSCENT | <https://crescent.cloud/> |
| Cytosplore Viewer |  |
| Granatum | <http://granatum.dcmb.med.umich.edu:8103/> |
| InterCellar |  |
| iS-CellR |  |
| iSEE | <https://marionilab.cruk.cam.ac.uk/iSEE_allen/> |
| loom-viewer |  |
| Loupe Cell Browser |  |
| PIVOT |  |
| SC1 | <https://sc1.engr.uconn.edu/> |
| SCANNER | <https://www.thecailab.com/scanner/> |
| scClustViz | <https://innesbt.shinyapps.io/scclustvizdemoapp/> |
| scExplorer | <http://singlecellexplorer.org> |
| SCope | <https://scope.aertslab.org/> |
| scSVA |  |
| scVI |  |
| seuratv3wizard | <https://nasqar.abudhabi.nyu.edu/SeuratV3Wizard/> |
| ShinyArchRUiO | <https://cancell.medisin.uio.no/ShinyArchR.UiO/> |
| ShinyCell | <http://shinycell1.ddnetbio.com/> |
| SCiAp | <https://humancellatlas.usegalaxy.eu/> |
| singleCellTK | <https://sctk.bu.edu/> |
| SPRING. | <https://kleintools.hms.harvard.edu/tools/> |
|  | springViewer\_1\_6\_dev.html?datasets/mouse\_HPCs/ |
|  | basal\_bone\_marrow/full444 URL shown in multiple lines |
| UCSC Cell Browser | <https://cells.ucsc.edu/> |
| Vitessce | <http://vitessce.io/> |
| WASP |  |

| Tool | visualization tutorial |
| --- | --- |
| alona | <https://alona.panglaodb.se/faq.html> |
| ASAP | <https://asap.epfl.ch/home/tutorial?t=fca> |
| Asc-Seurat | <https://asc-seurat.readthedocs.io/en/latest/index.html> |
| BingleSeq | <https://github.com/dbdimitrov/BingleSeq/blob/master/README.md> |
| CellView |  |
| cellxgene VIP | <https://interactivereport.github.io/cellxgene_VIP/tutorial/docs> |
| Cerebro/cerebroApp | <https://romanhaa.github.io/cerebroApp/> |
| CHARTS | <https://github.com/stewart-lab/CHARTS/blob/master/README.md> |
| ChromSCape | <https://vallotlab.github.io/ChromSCape/articles/vignette.html> |
| Cirrocumulus | <https://cirrocumulus.readthedocs.io/en/latest/> |
| CReSCENT | <https://pughlab.github.io/crescent-frontend/> |
| Cytosplore Viewer | <https://viewer.cytosplore.org/> |
| Granatum | <https://github.com/lanagarmire/Granatum/blob/master/doc/> |
|  | Granatum\_manual\_0.92.pdf555 URL shown in multiple lines |
| InterCellar |  |
| iS-CellR |  |
| iSEE |  |
| loom-viewer | <https://github.com/linnarsson-lab/loom-viewer> |
| Loupe Cell Browser |  |
| PIVOT | <https://rawgit.com/qinzhu/PIVOT/master/inst/app/www/manual_file.html> |
| SC1 |  |
| SCANNER |  |
| scClustViz |  |
| scExplorer | <http://singlecellexplorer.org/tutorial.html> |
| SCope | <https://github.com/aertslab/SCope/blob/master/README.md> |
| scSVA | <https://github.com/klarman-cell-observatory/scSVA/blob/> |
|  | master/docs/index.md666 URL shown in multiple lines |
| scVI | <https://docs.scvi-tools.org/en/stable/user_guide/index.html> |
| seuratv3wizard | <https://github.com/nasqar/seuratv3wizard/blob/master/README.md> |
| ShinyArchRUiO |  |
| ShinyCell | <https://github.com/SGDDNB/ShinyCell/blob/master/README.md> |
| SCiAp |  |
| singleCellTK |  |
| SPRING | <https://kleintools.hms.harvard.edu/tools/spring.html> |
| UCSC Cell Browser | <https://cellbrowser.readthedocs.io/en/master/interface.html> |
| Vitessce | <http://vitessce.io/docs/> |
| WASP | <https://github.com/andreashoek/wasp/blob/main/README.md> |

# 2 Motivation

Based on [*ShinyCell*](https://github.com/SGDDNB/ShinyCell),
The *scRNAseqApp* package is developed with multiple highly interactive
visualizations of how cells and subsets of cells cluster behavior.
The end users can discover the expression of genes in multiple interactive
manners with highly customized filter conditions by selecting metadata
supplied with the publications and download the ready-to-use results for
republishing.

# 3 Quick start

Here is an example using *scRNAseqApp* with a subset of scRNA-seq data.

## 3.1 Installation

First, install *scRNAseqApp* and other packages required to run
the examples.
Please note that the example dataset used here is from a small subset of
PBMC[34](#section-ref-satija2015spatial).
Additional package are also required for enhancement functions such
trajectory analysis or cell communication analysis.

```
library(BiocManager)
BiocManager::install("scRNAseqApp")
```

## 3.2 Load library

```
library(scRNAseqApp)
```

## 3.3 Initial the database

```
publish_folder=tempdir()
scInit(app_path=publish_folder)
```

## 3.4 Start shiny app

```
scRNAseqApp(app_path = publish_folder)
```

# 4 Create a new data

There are two ways to create a new data.

* from the administrator mode
* use R session

## 4.1 by administrator

Log in to admin by `Switch User` tab and click `administrator button` in the
right-bottom corner of screen. Click `UploadData` and upload a Seurat object.

## 4.2 via R session

There are two steps to create a new data via R session.
First, create the config file with description of the data and
second create the data from a Seurat object.

```
library(Seurat)
appconf <- createAppConfig(
            title="pbmc_small_test",
            destinationFolder = "pbmc_small_test",
            species = "Homo sapiens",
            doi="10.1038/nbt.3192",
            datatype = "scRNAseq",
            abstract = 'Put the description of the data here.')
createDataSet(
    appconf,
    pbmc_small,
    datafolder=file.path(publish_folder, "data"))
```

```
## An object of class Seurat
## 230 features across 80 samples within 1 assay
## Active assay: RNA (230 features, 20 variable features)
##  3 layers present: counts, data, scale.data
##  2 dimensional reductions calculated: pca, tsne
```

```
dir(file.path(publish_folder, 'data'))
```

```
## [1] "pbmc_small"      "pbmc_small_test"
```

# 5 Add downloadable file

If you have files intended for user download, kindly save them in the
`www/download` folder.
The application will then generate a list, differentiating between files and
user folder names, for convenient access to download options.
The file named as `readme` in text format in each folder will be used as
descriptions for the files.

# 6 Distribute to a shiny server

There are two steps to distribute to a shiny server. First, install the package
in the server as root user. Second, in a R session run `scInit()` after load
the `scRNAseqApp` library. If you initialed the app offline, copy the app folder
to the shiny server.

Note: the following files need to be writable for shiny: `www/database.sqlite`,
`www/counter.tsv` and the app `www` folder should also be writable because the
user manager is depend on SQLite, and the SQLite needs to be able to
create a journal file in the same directory as the DB,
before any modifications can take place.
The journal is used to support transaction rollback.

# 7 SessionInfo

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Seurat_5.3.1       SeuratObject_5.2.0 sp_2.2-0           scRNAseqApp_1.10.0
## [5] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] fs_1.6.6                    matrixStats_1.5.0
##   [3] spatstat.sparse_3.1-0       bitops_1.0-9
##   [5] lubridate_1.9.4             httr_1.4.7
##   [7] RColorBrewer_1.1-3          doParallel_1.0.17
##   [9] tools_4.5.1                 sctransform_0.4.2
##  [11] backports_1.5.0             R6_2.6.1
##  [13] DT_0.34.0                   lazyeval_0.2.2
##  [15] uwot_0.2.3                  rhdf5filters_1.22.0
##  [17] GetoptLong_1.0.5            withr_3.0.2
##  [19] gridExtra_2.3               progressr_0.17.0
##  [21] cli_3.6.5                   Biobase_2.70.0
##  [23] spatstat.explore_3.5-3      fastDummies_1.7.5
##  [25] sass_0.4.10                 S7_0.2.0
##  [27] spatstat.data_3.1-9         ggridges_0.5.7
##  [29] pbapply_1.7-4               askpass_1.2.1
##  [31] slingshot_2.18.0            Rsamtools_2.26.0
##  [33] R.utils_2.13.0              shinyhelper_0.3.2
##  [35] dichromat_2.0-0.1           parallelly_1.45.1
##  [37] limma_3.66.0                RSQLite_2.4.3
##  [39] generics_0.1.4              shape_1.4.6.1
##  [41] BiocIO_1.20.0               ica_1.0-3
##  [43] spatstat.random_3.4-2       dplyr_1.1.4
##  [45] Matrix_1.7-4                S4Vectors_0.48.0
##  [47] RefManageR_1.4.0            abind_1.4-8
##  [49] R.methodsS3_1.8.2           lifecycle_1.0.4
##  [51] yaml_2.3.10                 SummarizedExperiment_1.40.0
##  [53] rhdf5_2.54.0                SparseArray_1.10.0
##  [55] Rtsne_0.17                  grid_4.5.1
##  [57] blob_1.2.4                  promises_1.4.0
##  [59] crayon_1.5.3                miniUI_0.1.2
##  [61] lattice_0.22-7              billboarder_0.5.0
##  [63] cowplot_1.2.0               cigarillo_1.0.0
##  [65] pillar_1.11.1               knitr_1.50
##  [67] ComplexHeatmap_2.26.0       GenomicRanges_1.62.0
##  [69] rjson_0.2.23                future.apply_1.20.0
##  [71] codetools_0.2-20            glue_1.8.0
##  [73] spatstat.univar_3.1-4       data.table_1.17.8
##  [75] vctrs_0.6.5                 png_0.1-8
##  [77] spam_2.11-1                 gtable_0.3.6
##  [79] assertthat_0.2.1            cachem_1.1.0
##  [81] xfun_0.53                   princurve_2.1.6
##  [83] S4Arrays_1.10.0             mime_0.13
##  [85] Seqinfo_1.0.0               survival_3.8-3
##  [87] SingleCellExperiment_1.32.0 iterators_1.0.14
##  [89] statmod_1.5.1               fitdistrplus_1.2-4
##  [91] ROCR_1.0-11                 nlme_3.1-168
##  [93] bit64_4.6.0-1               RcppAnnoy_0.0.22
##  [95] rprojroot_2.1.1             GenomeInfoDb_1.46.0
##  [97] bslib_0.9.0                 irlba_2.3.5.1
##  [99] KernSmooth_2.23-26          otel_0.2.0
## [101] colorspace_2.1-2            BiocGenerics_0.56.0
## [103] DBI_1.2.3                   tidyselect_1.2.1
## [105] bit_4.6.0                   compiler_4.5.1
## [107] curl_7.0.0                  xml2_1.4.1
## [109] ggdendro_0.2.0              DelayedArray_0.36.0
## [111] plotly_4.11.0               scrypt_0.1.6
## [113] colourpicker_1.3.0          bookdown_0.45
## [115] rtracklayer_1.70.0          scales_1.4.0
## [117] lmtest_0.9-40               stringr_1.5.2
## [119] digest_0.6.37               goftest_1.2-3
## [121] spatstat.utils_3.2-0        rmarkdown_2.30
## [123] XVector_0.50.0              htmltools_0.5.8.1
## [125] pkgconfig_2.0.3             bibtex_0.5.1
## [127] MatrixGenerics_1.22.0       learnr_0.11.5
## [129] fastmap_1.2.0               rlang_1.1.6
## [131] GlobalOptions_0.1.2         htmlwidgets_1.6.4
## [133] UCSC.utils_1.6.0            shiny_1.11.1
## [135] farver_2.1.2                jquerylib_0.1.4
## [137] shinymanager_1.0.410        zoo_1.8-14
## [139] jsonlite_2.0.0              BiocParallel_1.44.0
## [141] R.oo_1.27.1                 RCurl_1.98-1.17
## [143] magrittr_2.0.4              dotCall64_1.2
## [145] patchwork_1.3.2             Rhdf5lib_1.32.0
## [147] Rcpp_1.1.0                  TrajectoryUtils_1.18.0
## [149] reticulate_1.44.0           stringi_1.8.7
## [151] MASS_7.3-65                 plyr_1.8.9
## [153] parallel_4.5.1              listenv_0.9.1
## [155] ggrepel_0.9.6               deldir_2.0-4
## [157] Biostrings_2.78.0           splines_4.5.1
## [159] tensor_1.5.1                circlize_0.4.16
## [161] igraph_2.2.1                spatstat.geom_3.6-0
## [163] RcppHNSW_0.6.0              reshape2_1.4.4
## [165] stats4_4.5.1                XML_3.99-0.19
## [167] evaluate_1.0.5              BiocManager_1.30.26
## [169] foreach_1.5.2               tweenr_2.0.3
## [171] httpuv_1.6.16               RANN_2.6.2
## [173] tidyr_1.3.1                 openssl_2.3.4
## [175] purrr_1.1.0                 polyclip_1.10-7
## [177] future_1.67.0               clue_0.3-66
## [179] scattermore_1.2             ggplot2_4.0.0
## [181] ggforce_0.5.0               xtable_1.8-4
## [183] restfulr_0.0.16             RSpectra_0.16-2
## [185] later_1.4.4                 viridisLite_0.4.2
## [187] tibble_3.3.0                memoise_2.0.1
## [189] GenomicAlignments_1.46.0    IRanges_2.44.0
## [191] cluster_2.1.8.1             sortable_0.5.0
## [193] timechange_0.3.0            globals_0.18.0
```

# References

1. Franzén, O. & Björkegren, J. L. Alona: A web server for single-cell rna-seq analysis. *Bioinformatics* **36,** 3910–3912 (2020).

2. Gardeux, V., David, F. P., Shajkofci, A., Schwalie, P. C. & Deplancke, B. ASAP: A web-based platform for the analysis and interactive visualization of single-cell rna-seq data. *Bioinformatics* **33,** 3123–3125 (2017).

3. Pereira, W. J. *et al.* Asc-seurat: Analytical single-cell seurat-based web application. *BMC bioinformatics* **22,** 1–14 (2021).

4. Dimitrov, D. & Gu, Q. BingleSeq: A user-friendly r package for bulk and single-cell rna-seq data analysis. *PeerJ* **8,** e10469 (2020).

5. Bolisetty, M. T., Stitzel, M. L. & Robson, P. CellView: Interactive exploration of high dimensional single cell rna-seq data. *bioRxiv* 123810 (2017).

6. Li, K. *et al.* Cellxgene vip unleashes full power of interactive visualization and integrative analysis of scRNA-seq, spatial transcriptomics, and multiome data. *bioRxiv* 2020–08 (2022).

7. Hillje, R., Pelicci, P. G. & Luzi, L. Cerebro: Interactive visualization of scRNA-seq data. *Bioinformatics* **36,** 2311–2313 (2020).

8. Bernstein, M. N. *et al.* CHARTS: A web application for characterizing and comparing tumor subpopulations in publicly available single-cell rna-seq data sets. *BMC bioinformatics* **22,** 1–9 (2021).

9. Prompsy, P. *et al.* Interactive analysis of single-cell epigenomic landscapes with chromscape. *Nature communications* **11,** 1–9 (2020).

10. Li, B. *et al.* Cumulus provides cloud-based data analysis for large-scale single-cell and single-nucleus rna-seq. *Nature methods* **17,** 793–798 (2020).

11. Mohanraj, S. *et al.* Crescent: Cancer single cell expression toolkit. *Nucleic Acids Research* **48,** W372–W379 (2020).

12. Tasic, B. *et al.* Shared and distinct transcriptomic cell types across neocortical areas. *Nature* **563,** 72–78 (2018).

13. Zhu, X. *et al.* Granatum: A graphical single-cell rna-seq analysis pipeline for genomics scientists. *Genome medicine* **9,** 1–12 (2017).

14. Interlandi, M., Kerl, K. & Dugas, M. InterCellar enables interactive analysis and exploration of cell- cell communication in single-cell transcriptomic data. *Communications biology* **5,** 1–13 (2022).

15. Patel, M. V. IS-cellr: A user-friendly tool for analyzing and visualizing single-cell rna sequencing data. *Bioinformatics* **34,** 4305–4306 (2018).

16. Rue-Albrecht, K., Marini, F., Soneson, C. & Lun, A. T. ISEE: Interactive summarizedexperiment explorer. *F1000Research* **7,** (2018).

17. Zhu, Q. *et al.* PIVOT: Platform for interactive analysis and visualization of transcriptomics data. *BMC bioinformatics* **19,** 1–8 (2018).

18. Moussa, M. & Măndoiu, I. I. SC1: A tool for interactive web-based single-cell rna-seq data analysis. *Journal of Computational Biology* **28,** 820–841 (2021).

19. Cai, G., Yu, X., Youn, C., Zhou, J. & Xiao, F. SCANNER: A web platform for annotation, visualization and sharing of single cell rna-seq data. *Database* **2022,** (2022).

20. Innes, B. T. & Bader, G. D. ScClustViz–single-cell rnaseq cluster assessment and visualization. *F1000Research* **7,** (2018).

21. Davie, K. *et al.* A single-cell transcriptome atlas of the aging drosophila brain. *Cell* **174,** 982–998 (2018).

22. Tabaka, M., Gould, J. & Regev, A. ScSVA: An interactive tool for big data visualization and exploration in single-cell omics. *BioRxiv* 512582 (2019).

23. Lopez, R., Regier, J., Cole, M. B., Jordan, M. I. & Yosef, N. Deep generative modeling for single-cell transcriptomics. *Nature methods* **15,** 1053–1058 (2018).

24. Yousif, A., Drou, N., Rowe, J., Khalfan, M. & Gunsalus, K. C. NASQAR: A web-based platform for high-throughput sequencing data analysis and visualization. *Bmc Bioinformatics* **21,** 1–14 (2020).

25. Sharma, A., Akshay, A., Rogne, M. & Eskeland, R. ShinyArchR. UiO: User-friendly, integrative and open-source tool for visualization of single-cell atac-seq data using archr. *Bioinformatics* **38,** 834–836 (2022).

26. Ouyang, J. F., Kamaraj, U. S., Cao, E. Y. & Rackham, O. J. ShinyCell: Simple and sharable visualization of single-cell gene expression data. *Bioinformatics* **37,** 3374–3376 (2021).

27. Hong, R. *et al.* Comprehensive generation, visualization, and reporting of quality control metrics for single-cell rna sequencing data. *Nature communications* **13,** 1–9 (2022).

28. Feng, D., Whitehurst, C. E., Shan, D., Hill, J. D. & Yue, Y. G. Single cell explorer, collaboration-driven tools to leverage large-scale single cell rna-seq data. *BMC genomics* **20,** 1–8 (2019).

29. Moreno, P. *et al.* User-friendly, scalable tools and workflows for single-cell rna-seq analysis. *Nature methods* **18,** 327–328 (2021).

30. Speir, M. L. *et al.* UCSC cell browser: Visualize your single-cell data. *Bioinformatics* **37,** 4578–4580 (2021).

31. Weinreb, C., Wolock, S. & Klein, A. M. SPRING: A kinetic interface for visualizing high dimensional single-cell expression data. *Bioinformatics* **34,** 1246–1248 (2018).

32. Hoek, A. *et al.* WASP: A versatile, web-accessible single cell rna-seq processing platform. *BMC genomics* **22,** 1–11 (2021).

33. Keller, M. S. *et al.* Vitessce: A framework for integrative visualization of multi-modal and spatially-resolved single-cell data. (2021).

34. Satija, R., Farrell, J. A., Gennert, D., Schier, A. F. & Regev, A. Spatial reconstruction of single-cell gene expression data. *Nature biotechnology* **33,** 495–502 (2015).