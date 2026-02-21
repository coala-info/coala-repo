# The OGRE user guide

#### Sven Berres

#### 10/30/2025

Abstract

OGRE calculates overlap between user defined annotated genomic region datasets. Any regions can be supplied such as public annotations (genes), genetic variation (SNPs, mutations), regulatory elements (TFBS, promoters, CpG islands) and basically all types of NGS output from sequencing experiments. After overlap calculation, key numbers help analyse the extend of overlaps which can also be visualized at a genomic level. To start OGRE’s GUI use function SHREC() in your R console. Find additional information and tutorials on [github](https://github.com/svenbioinf/OGRE/). OGRE package version: 1.14.0

* [Installation](#installation)
* [Quick start- load datasets from hard drive](#quick-start--load-datasets-from-hard-drive)
* [Quick start- load datasets from AnnotationHub](#quick-start--load-datasets-from-annotationhub)
* [Quick start- load user defined GenomicRanges (GRanges) datasets](#quick-start--load-user-defined-genomicranges-granges-datasets)
* [Frequently asked questions](#frequently-asked-questions)
  + [How to add additional datasets from AnnotationHub?](#how-to-add-additional-datasets-from-annotationhub)
  + [How to add custom GenomicRanges datasets?](#how-to-add-custom-genomicranges-datasets)
  + [How to add datasets stored as .gff files?](#how-to-add-datasets-stored-as-.gff-files)
  + [How to add datasets stored as tabular files?](#how-to-add-datasets-stored-as-tabular-files)
  + [What type of overlaps are reported?](#what-type-of-overlaps-are-reported)
  + [How to change dataset names?](#how-to-change-dataset-names)
* [Session info](#session-info)

![](data:image/png;base64...)

# Installation

Install OGRE using Bioconductor’s package installer.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("OGRE")
```

Load the OGRE package:

```
library(OGRE)
```

# Quick start- load datasets from hard drive

To start up OGRE you have to generate an `OGREDataSet` that is used to store your datasets and additional information about the analysis that you are conducting. Query and subjects files can be conveniently stored in their own folders as GenomicRanges objects in form of stored .rds / .RDS files. We point OGRE to the correct location by supplying a path for each folder with the character vectors `queryFolder` and `subjectFolder`. In this vignette we are using lightweight query and subject example data sets to show OGRE’s functionality.

```
myQueryFolder <- file.path(system.file('extdata', package = 'OGRE'),"query")
mySubjectFolder <- file.path(system.file('extdata', package = 'OGRE'),"subject")

myOGRE <- OGREDataSetFromDir(queryFolder=myQueryFolder,
                             subjectFolder=mySubjectFolder)
```

```
## Initializing OGREDataSet...
```

By monitoring OGRE’s metadata information you can make sure the input paths you supplied are stored correctly.

```
metadata(myOGRE)
```

```
## $queryFolder
## [1] "/tmp/Rtmpu6fWV4/Rinst1f32615ad03e99/OGRE/extdata/query"
##
## $subjectFolder
## [1] "/tmp/Rtmpu6fWV4/Rinst1f32615ad03e99/OGRE/extdata/subject"
##
## $outputFolder
## [1] "/tmp/Rtmpu6fWV4/Rinst1f32615ad03e99/OGRE/extdata/output"
##
## $gvizPlotsFolder
## [1] "/tmp/Rtmpu6fWV4/Rinst1f32615ad03e99/OGRE/extdata/gvizPlots"
##
## $summaryDT
## list()
##
## $itracks
## list()
```

Query and subject datasets are read by `loadAnnotations()` and stored in the `OGREDataSet` as `GRanges` objects. We are going to read in the following example datasets:

* query “genes” (242 Protein coding genes)
* subject “CGI” (365 CpG islands)
* subject “TFBS” (48761 Transcription factor binding sites)

```
myOGRE <- loadAnnotations(myOGRE)
```

```
## Reading query dataset...
```

```
## Reading subject datasets...
```

OGRE uses your dataset file names to label query and subjects internally, we can check these names by using the `names()` function since every `OGREDataSet` is a `GRangesList`.

```
names(myOGRE)
```

```
## [1] "genes" "CGI"   "TFBS"
```

Let’s have a look at the stored datasets:

```
myOGRE
```

```
## GRangesList object of length 3:
## $genes
## GRanges object with 242 ranges and 3 metadata columns:
##         seqnames            ranges strand |              ID        name
##            <Rle>         <IRanges>  <Rle> |     <character> <character>
##     [1]       21 10906201-11029719      - | ENSG00000166157        TPTE
##     [2]       21 14741931-14745386      - | ENSG00000256715  AL050302.1
##     [3]       21 14982498-15013906      + | ENSG00000166351       POTED
##     [4]       21 15051621-15053459      - | ENSG00000269011  AL050303.1
##     [5]       21 15481134-15583166      - | ENSG00000188992        LIPI
##     ...      ...               ...    ... .             ...         ...
##   [238]       21 47720095-47743789      - | ENSG00000160298    C21orf58
##   [239]       21 47744036-47865682      + | ENSG00000160299        PCNT
##   [240]       21 47878812-47989926      + | ENSG00000160305       DIP2A
##   [241]       21 48018875-48025121      - | ENSG00000160307       S100B
##   [242]       21 48055079-48085036      + | ENSG00000160310       PRMT2
##             score
##         <numeric>
##     [1]        NA
##     [2]        NA
##     [3]        NA
##     [4]        NA
##     [5]        NA
##     ...       ...
##   [238]        NA
##   [239]        NA
##   [240]        NA
##   [241]        NA
##   [242]        NA
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
##
## $CGI
## GRanges object with 365 ranges and 3 metadata columns:
##         seqnames            ranges strand |          ID        name     score
##            <Rle>         <IRanges>  <Rle> | <character> <character> <numeric>
##     [1]       21   9437273-9439473      * |       26635    CpG:_285        NA
##     [2]       21   9483486-9484663      * |       26636    CpG:_165        NA
##     [3]       21   9647867-9648116      * |       26637     CpG:_18        NA
##     [4]       21   9708936-9709231      * |       26638     CpG:_31        NA
##     [5]       21   9825443-9826296      * |       26639    CpG:_120        NA
##     ...      ...               ...    ... .         ...         ...       ...
##   [361]       21 48018543-48018791      * |       26995     CpG:_21        NA
##   [362]       21 48055200-48056060      * |       26996     CpG:_88        NA
##   [363]       21 48068518-48068808      * |       26997     CpG:_24        NA
##   [364]       21 48081242-48081849      * |       26998     CpG:_55        NA
##   [365]       21 48087201-48088106      * |       26999     CpG:_93        NA
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
##
## $TFBS
## GRanges object with 48761 ranges and 3 metadata columns:
##           seqnames            ranges strand |           ID        name
##              <Rle>         <IRanges>  <Rle> |  <character> <character>
##       [1]       21 29884415-29884427      + |  GATA1.85108    GATA1_04
##       [2]       21 46923766-46923780      + |    CDP.81529      CDP_02
##       [3]       21   9491627-9491638      - |   HFH1.46541     HFH1_01
##       [4]       21   9491706-9491725      - |  PPARA.24892    PPARA_01
##       [5]       21   9491792-9491815      + |   GFI1.35413     GFI1_01
##       ...      ...               ...    ... .          ...         ...
##   [48757]       21 48083381-48083404      + | STAT5A.43326   STAT5A_02
##   [48758]       21 48083400-48083419      + |   ARNT.19751     ARNT_02
##   [48759]       21 48084826-48084841      + |   BRN2.40426     BRN2_01
##   [48760]       21 48084830-48084847      + | FOXJ2.121681    FOXJ2_01
##   [48761]       21 48084834-48084845      + |  NKX3A.47953    NKX3A_01
##               score
##           <numeric>
##       [1]       891
##       [2]       831
##       [3]       865
##       [4]       757
##       [5]       817
##       ...       ...
##   [48757]       751
##   [48758]       792
##   [48759]       803
##   [48760]       889
##   [48761]       851
##   -------
##   seqinfo: 25 sequences (1 circular) from hg19 genome
```

To find overlaps between your query and subject datasets we call `fOverlaps()`. Internally OGRE makes use of the `GenomicRanges` package to calculate full and partial overlap as schematically shown.

![](data:image/png;base64...)
 Any existing subject - query hits are then listed in `detailDT` and stored as a `data.table`.

```
myOGRE <- fOverlaps(myOGRE)
head(metadata(myOGRE)$detailDT,n=2)
```

```
##            queryID queryType subjID subjType queryChr queryStart queryEnd
##             <char>    <char> <char>   <char>   <char>      <int>    <int>
## 1: ENSG00000166157     genes  26649      CGI       21   10906201 11029719
## 2: ENSG00000269011     genes  26654      CGI       21   15051621 15053459
##    queryStrand subjChr subjStart  subjEnd subjStrand overlapWidth overlapRatio
##         <char>  <char>     <int>    <int>     <char>        <int>        <num>
## 1:           -      21  10989914 10991413          *         1500   0.01214388
## 2:           -      21  15052411 15052644          *          234   0.12724307
```

The summary plot provides us with useful information about the number of overlaps between your datasets.

```
 myOGRE <- sumPlot(myOGRE)
 metadata(myOGRE)$barplot_summary
```

![](data:image/png;base64...) Using the `Gviz` visualization each query can be displayed with all overlapping subject elements. Choose labels for all region tracks by supplying a `trackRegionLabels` vector. Plots are stored in the same location as your dataset files.

```
 myOGRE <- gvizPlot(myOGRE,"ENSG00000142168",showPlot = TRUE,
                    trackRegionLabels = setNames(c("name","name"),c("genes","CGI")))
```

```
## Plotting query: ENSG00000142168
```

![](data:image/png;base64...)

The overlap distribution can be generated with `summarizeOverlap(myOGRE)` and outputs a table with informative statistics such as minimum, lower quantile, mean, median, upper quantile, and maximum number of overlaps per region and per dataset. Overlap distribution can also be displayed as histograms using `plotHist(myOGRE)` and accessed by `metadata(myOGRE)$hist` and `metadata(myOGRE)$summaryDT`. Two tables / plots are generated. The first one showing numbers for regions with and without overlap and the second one showing numbers only for regions with overlap by excluding all others. Next, we generate an histogram with the number of TFBS per gene (x-axis, log scale) and the TFBS frequency (y-axis). When focusing only on regions with overlap, we see that genes have on average (median) 54 TFBS overlaps (black dashed line).

```
 myOGRE <- summarizeOverlap(myOGRE)
 myOGRE <- plotHist(myOGRE)
 metadata(myOGRE)$summaryDT
```

```
## $includes0
##               CGI      TFBS
## Min.     0.000000    0.0000
## 1st Qu.  0.000000    8.0000
## Median   1.000000   36.0000
## Mean     1.210744  119.6116
## 3rd Qu.  1.750000  129.7500
## Max.    14.000000 3136.0000
##
## $excludes0
##              CGI      TFBS
## Min.     1.00000    1.0000
## 1st Qu.  1.00000   15.0000
## Median   1.00000   54.0000
## Mean     2.02069  139.8357
## 3rd Qu.  2.00000  159.5000
## Max.    14.00000 3136.0000
## NA's    97.00000   35.0000
```

```
 metadata(myOGRE)$hist$TFBS
```

```
## `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```

![](data:image/png;base64...)

It is possible to create an average coverage profile of all gene-TFBS overlaps, split in 100 bins, which represent gene bodies of all 242 genes. Both, forward and reverse coding genes are arranged on the x-Axis and peaks indicate an TFBS overlap enrichment. Overlap coverage is calculated as the sum of all gene TFBS overlaps in 5’-3’direction. Generated plots can be accessed by `metadata(myOGRE)$covPlot$TFBS` and the resulting profile shows an accumulation of TFBS around gene start and end positions.

```
 myOGRE <- covPlot(myOGRE)
```

```
## Generating coverage plot(s), this might take a while...
```

```
## Excluding regions with nucleotides<nbin
```

```
 metadata(myOGRE)$covPlot$TFBS$plot
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

![](data:image/png;base64...)

# Quick start- load datasets from AnnotationHub

AnnotationHub offers a wide range of annotated datasets which can be manually aquired but need some parsing to work with OGRE as detailed in vignette section [Frequently Asked Questions](#FAQ)(FAQ). For convenience `addDataSetFromHub()` adds one of the predefined human datasets of `listPredefinedDataSets()` to an OGREDataSet. Those are taken from AnnotationHub and are ready to use for OGRE. We start by creating an empty OGREDataSet and attaching one dataset after another, whereby one query and two subjects are added. The datasets are now ready for further analysis.

```
myOGRE <- OGREDataSet()
listPredefinedDataSets()
myOGRE <- addDataSetFromHub(myOGRE,"protCodingGenes","query")
myOGRE <- addDataSetFromHub(myOGRE,"CGI","subject")
myOGRE <- addDataSetFromHub(myOGRE,"TFBS","subject")
names(myOGRE)
```

As you can see, the three datasets proteinCodingGenes, CGI and TFBS are stored within OGRE. You can then continue with overlap analysis using `fOverlaps()`.

# Quick start- load user defined GenomicRanges (GRanges) datasets

To offer more flexibility `addGRanges()` enables the user to attach additional datasets to OGRE in form of GenomicRanges objects. Again we start by creating an empty OGREDataSet and generate an example GenomicRanges object which is then added to your OGREDataSet either as “query” or “subject”.

```
myOGRE <- OGREDataSet()
myGRanges <- makeExampleGRanges()
myOGRE <- addGRanges(myOGRE,myGRanges,"query")
```

# Frequently asked questions

## How to add additional datasets from AnnotationHub?

Use `AnnotationHub()` to connect to AnnotationHub. Each dataset is stored under a unique ID and can be accessed in a list like fashion i.e. `aH[["AH5086"]]`. Queries like `c("GRanges","Homo sapiens", "CpG")` enable browsing through datasets. In this case we are searching for human CpG islands ranges stored as GenomicRanges objects. For more information refer to `?AnnotationHub` To make those datasets compatible with OGRE additional parsing is needed as stated in [How to add custom GenomicRanges datasets?](#how-to-add-custom-genomicranges-datasets)

```
aH <- AnnotationHub()
aH[["AH5086"]]
q <- query(aH, c("GRanges","Homo sapiens", "CpG"))
```

## How to add custom GenomicRanges datasets?

Any GenomicRanges datasets can be added that fulfill basic compatibility requirements. GenomicRanges objects must:

* Originate from a common genome build i.e. “HG19”

Use `Seqinfo::genome()` on any GenomicRanges object to get/set genome information

* Contain the same set of chromosomes i.e. chr1 != 1 or chrM != MT

Use `Seqinfo::seqinfo()` on any GenomicRanges object to get/set chromosome information

* Contain a “name” and a (unique) “ID” column

Use `S4Vectors::mcols()` on any GenomicRanges object to get/set metadata information

## How to add datasets stored as .gff files?

Datasets from external sources are often stored as .gff (v2&v3) files. Once those files exist in the query or subject folder and their attribute columns contain “ID” and “name” information, OGRE tries to load them. Working example .gff files can be found on [OGRE’s github page](https://github.com/svenbioinf/OGRE) in folder: inst/extdata/gffTest.

```
myOGRE <- OGREDataSetFromDir(queryFolder = "pathToQueryFolder",
                             subjectFolder = "pathToSubjectFolder")
myOGRE <- loadAnnotations(myOGRE)
```

## How to add datasets stored as tabular files?

Datasets stored as tabular files like .csv or .bed may need some preprocessing for them work with OGRE. We recommend reading them in with `read.table()` or `data.table::fread()` to obtain a data frame object. After making sure the dataset complies with the requirements in section [How to add custom GenomicRanges datasets?](#how-to-add-custom-genomicranges-datasets), `GenomicRanges::makeGRangesFromDataFrame()` offers a convenient way to generate GenomicRanges object from data frames.

## What type of overlaps are reported?

Both, partial overlap, where only a part of two (or more) regions are overlapping and complete overlap, where one region is completely overlapped by another, are reported.

## How to change dataset names?

OGRE automatically infers dataset names based on your file names. You can either change your file names before you start OGRE or you can use `names(myOGRE) <- c("NewName1", "NewName2","...")` after you read in your datasets.

# Session info

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
## [1] OGRE_1.14.0         S4Vectors_0.48.0    BiocGenerics_0.56.0
## [4] generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              ragg_1.5.0
##   [9] fs_1.6.6                    BiocIO_1.20.0
##  [11] vctrs_0.6.5                 memoise_2.0.1
##  [13] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [15] base64enc_0.1-3             htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0             progress_1.2.3
##  [19] AnnotationHub_4.0.0         curl_7.0.0
##  [21] SparseArray_1.10.0          Formula_1.2-5
##  [23] shinyFiles_0.9.3            sass_0.4.10
##  [25] bslib_0.9.0                 htmlwidgets_1.6.4
##  [27] Gviz_1.54.0                 httr2_1.2.1
##  [29] cachem_1.1.0                GenomicAlignments_1.46.0
##  [31] mime_0.13                   lifecycle_1.0.4
##  [33] pkgconfig_2.0.3             Matrix_1.7-4
##  [35] R6_2.6.1                    fastmap_1.2.0
##  [37] MatrixGenerics_1.22.0       shiny_1.11.1
##  [39] digest_0.6.37               colorspace_2.1-2
##  [41] AnnotationDbi_1.72.0        textshaping_1.0.4
##  [43] Hmisc_5.2-4                 GenomicRanges_1.62.0
##  [45] RSQLite_2.4.3               labeling_0.4.3
##  [47] filelock_1.0.3              mgcv_1.9-3
##  [49] httr_1.4.7                  abind_1.4-8
##  [51] compiler_4.5.1              withr_3.0.2
##  [53] bit64_4.6.0-1               htmlTable_2.4.3
##  [55] S7_0.2.0                    backports_1.5.0
##  [57] BiocParallel_1.44.0         DBI_1.2.3
##  [59] biomaRt_2.66.0              rappdirs_0.3.3
##  [61] DelayedArray_0.36.0         rjson_0.2.23
##  [63] tools_4.5.1                 foreign_0.8-90
##  [65] otel_0.2.0                  httpuv_1.6.16
##  [67] nnet_7.3-20                 glue_1.8.0
##  [69] restfulr_0.0.16             nlme_3.1-168
##  [71] promises_1.4.0              grid_4.5.1
##  [73] checkmate_2.3.3             cluster_2.1.8.1
##  [75] gtable_0.3.6                BSgenome_1.78.0
##  [77] shinyBS_0.61.1              tidyr_1.3.1
##  [79] ensembldb_2.34.0            data.table_1.17.8
##  [81] hms_1.1.4                   XVector_0.50.0
##  [83] BiocVersion_3.22.0          pillar_1.11.1
##  [85] stringr_1.5.2               later_1.4.4
##  [87] splines_4.5.1               dplyr_1.1.4
##  [89] BiocFileCache_3.0.0         lattice_0.22-7
##  [91] rtracklayer_1.70.0          bit_4.6.0
##  [93] deldir_2.0-4                biovizBase_1.58.0
##  [95] tidyselect_1.2.1            Biostrings_2.78.0
##  [97] knitr_1.50                  gridExtra_2.3
##  [99] IRanges_2.44.0              Seqinfo_1.0.0
## [101] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
## [103] xfun_0.53                   shinydashboard_0.7.3
## [105] Biobase_2.70.0              matrixStats_1.5.0
## [107] DT_0.34.0                   stringi_1.8.7
## [109] UCSC.utils_1.6.0            lazyeval_0.2.2
## [111] yaml_2.3.10                 evaluate_1.0.5
## [113] codetools_0.2-20            cigarillo_1.0.0
## [115] interp_1.1-6                tibble_3.3.0
## [117] BiocManager_1.30.26         cli_3.6.5
## [119] rpart_4.1.24                systemfonts_1.3.1
## [121] xtable_1.8-4                jquerylib_0.1.4
## [123] dichromat_2.0-0.1           Rcpp_1.1.0
## [125] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [127] png_0.1-8                   XML_3.99-0.19
## [129] parallel_4.5.1              assertthat_0.2.1
## [131] ggplot2_4.0.0               blob_1.2.4
## [133] prettyunits_1.2.0           latticeExtra_0.6-31
## [135] jpeg_0.1-11                 AnnotationFilter_1.34.0
## [137] bitops_1.0-9                VariantAnnotation_1.56.0
## [139] scales_1.4.0                purrr_1.1.0
## [141] crayon_1.5.3                rlang_1.1.6
## [143] KEGGREST_1.50.0
```