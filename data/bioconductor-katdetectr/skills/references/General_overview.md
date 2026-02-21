# Overview of katdetectr

Daan Hazelaar and Job van Riet

#### 30 October 2025

#### Package

katdetectr 1.12.0

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
  + [2.1 Importing genomic variants](#importing-genomic-variants)
  + [2.2 Detection of kataegis foci](#detection-of-kataegis-foci)
  + [2.3 Visualization of segmentation and kataegis foci](#visualization-of-segmentation-and-kataegis-foci)
  + [2.4 Custom function for IMD cutoff value](#custom-function-for-imd-cutoff-value)
* [3 Analyzing non standard sequences](#analyzing-non-standard-sequences)
* [4 Session Information](#session-information)

# 1 Installation

To install this package, start R (version “4.2”) and enter:

```
# Install via BioConductor
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("katdetectr")

# or the latest version
BiocManager::install("katdetectr", version = "devel")

# or from github
devtools::install_github("https://github.com/ErasmusMC-CCBC/katdetectr")
```

After installation, you can load the package with:

```
library(katdetectr)
```

# 2 Introduction

`katdetectr` is an *R* package for the detection, characterization and visualization of localized hypermutated regions, often referred to as *kataegis*.

The general workflow of `katdetectr` can be summarized as follows:

1. Import of genomic variants; VCF, MAF or VRanges objects.
2. Detection of kataegis foci.
3. Visualization of segmentation and kataegis foci.

Please see the [Application Note](https://www.biorxiv.org/content/10.1101/2022.07.11.499364v1) (under submission) for additional background and details of `katdetectr`. The application note also contains a section regarding the performance of `katdetectr` and other kataegis detection packages: [maftools](https://bioconductor.org/packages/release/bioc/html/maftools.html), [ClusteredMutations](https://cran.r-project.org/web/packages/ClusteredMutations/index.html), [SeqKat](https://cran.r-project.org/web/packages/SeqKat/index.html), [kataegis](https://github.com/flosalbizziae/kataegis), and [SigProfilerClusters](https://github.com/AlexandrovLab/SigProfilerClusters).

We have made `katdetectr` available on *BioConductor* as this insures reliability, and operability on common operating systems (Linux, Mac, and Windows). We designed `katdetectr` such that it fits well in the *BioConductor* ecosystem which allows `katdetectr` to be used easily in combination with other *BioConductor* packages and analysis pipelines.

Below, the `katdetectr` workflow is performed in a step-by-step manner on publicly-available datasets that are included within this package.

## 2.1 Importing genomic variants

Genomic variants from multiple common data-formats (VCF/MAF and VRanges objects) can be imported into `katdetectr`.

```
# Genomic variants stored within the VCF format.
pathToVCF <- system.file(package = "katdetectr", "extdata/CPTAC_Breast.vcf")

# Genomic variants stored within the MAF format.
pathToMAF <- system.file(package = "katdetectr", "extdata/APL_primary.maf")

# In addition, we can generate synthetic genomic variants including kataegis foci using generateSyntheticData().
# This functions returns a VRanges object.
syntheticData <- generateSyntheticData(nBackgroundVariants = 2500, nKataegisFoci = 1)
```

## 2.2 Detection of kataegis foci

Using `detectKataegis()`, we can employ changepoint detection to detect distinct clusters of varying intermutation distance (IMD), mutation rate and size.

Imported genomic variant data can contain either single or multiple samples, in the latter case records can be aggregated by setting `aggregateRecords = TRUE`. Overlapping genomic variants (e.g., an InDel and SNV) are reduced into a single record.

From the genomic variants data the IMD is calculated. Following, changepoint analysis is performed on the IMD of the genomic variants which results in segments. Lastly, a segment is labelled as *kataegis foci* if the segment fits the following parameters: `minSizeKataegis = 6` and `IMDcutoff = 1000`.

```
# Detect kataegis foci within the given VCF file.
kdVCF <- detectKataegis(genomicVariants = pathToVCF)

# # Detect kataegis foci within the given MAF file.
# As this file contains multiple samples, we set aggregateRecords = TRUE.
kdMAF <- detectKataegis(genomicVariants = pathToMAF, aggregateRecords = TRUE)

# Detect kataegis foci within the synthetic data.
kdSynthetic <- detectKataegis(genomicVariants = syntheticData)
```

All relevant input and subsequent results are stored within `KatDetect` objects. Using `summary()`, `show()` and/or `print()`, we can generate overviews of these `KatDetect` object(s).

```
summary(kdVCF)
```

```
## Sample name:                                 CPTAC
## Total number of genomic variants:            3684
## Total number of putative Kataegis foci:      9
## Total number of variants in a Kataegis foci: 133
```

```
print(kdVCF)
```

```
## Sample name:                                 CPTAC
## Total number of genomic variants:            3684
## Total number of putative Kataegis foci:      9
## Total number of variants in a Kataegis foci: 133
```

```
show(kdVCF)
```

```
## Class "KatDetect" : KatDetect Object
##                   : S4 class containing 4 slots with names:
##                     kataegisFoci genomicVariants segments info
##
## Created on:         Thu Oct 30 00:41:38 2025
## katdetectr version: 1.12.0
##
## summary:
## --------------------------------------------------------
## Sample name:                                 CPTAC
## Total number of genomic variants:            3684
## Total number of putative Kataegis foci:      9
## Total number of variants in a Kataegis foci: 133
## --------------------------------------------------------
```

```
# Or simply:
kdVCF
```

```
## Class "KatDetect" : KatDetect Object
##                   : S4 class containing 4 slots with names:
##                     kataegisFoci genomicVariants segments info
##
## Created on:         Thu Oct 30 00:41:38 2025
## katdetectr version: 1.12.0
##
## summary:
## --------------------------------------------------------
## Sample name:                                 CPTAC
## Total number of genomic variants:            3684
## Total number of putative Kataegis foci:      9
## Total number of variants in a Kataegis foci: 133
## --------------------------------------------------------
```

Underlying data can be retrieved from a `KatDetect` objects using the following `getter` functions:

1. `getGenomicVariants()` returns: VRanges object. Processed genomic variants used as input for changepoint detection. This VRanges contains the genomic location, IMD, and kataegis status of each genomic variant
2. `getSegments()` returns: GRanges object. Contains the segments as derived from changepoint detection. This Granges contains the genomic location, total number of variants, mean IMD and, mutation rate of each segment.
3. `getKataegisFoci()` returns: GRanges object. Contains all segments designated as putative kataegis foci according the the specified parameters (minSizeKataegis and IMDcutoff). This Granges contains the genomic location, total number of variants and mean IMD of each putative kataegis foci
4. `getInfo()` returns: List object. Contains supplementary information including used parameter settings.

```
getGenomicVariants(kdVCF)
```

```
## VRanges object with 3684 ranges and 5 metadata columns:
##          seqnames    ranges strand         ref              alt     totalDepth
##             <Rle> <IRanges>  <Rle> <character> <characterOrRle> <integerOrRle>
##      [1]     chr1    935222      *           C                A             50
##      [2]     chr1    949608      *           G                A             50
##      [3]     chr1    981131      *           A                G             50
##      [4]     chr1    982722      *           A                G             50
##      [5]     chr1   1164015      *           C                A             50
##      ...      ...       ...    ...         ...              ...            ...
##   [3680]     chrX 153594977      *           G                A             50
##   [3681]     chrX 153627839      *           C                T             50
##   [3682]     chrX 153629155      *           A                G             50
##   [3683]     chrX 153668757      *           G                A             50
##   [3684]     chrX 153764217      *           C                T             50
##                refDepth       altDepth   sampleNames softFilterMatrix | revmap
##          <integerOrRle> <integerOrRle> <factorOrRle>         <matrix> | <list>
##      [1]             20             30         CPTAC                  |      1
##      [2]             20             30         CPTAC                  |      2
##      [3]             20             30         CPTAC                  |      3
##      [4]             20             30         CPTAC                  |      4
##      [5]             20             30         CPTAC                  |      5
##      ...            ...            ...           ...              ... .    ...
##   [3680]             20             30         CPTAC                  |   3683
##   [3681]             20             30         CPTAC                  |   3684
##   [3682]             20             30         CPTAC                  |   3685
##   [3683]             20             30         CPTAC                  |   3686
##   [3684]             20             30         CPTAC                  |   3687
##          variantID       IMD segmentID putativeKataegis
##          <integer> <integer> <integer>        <logical>
##      [1]         1    935222         1            FALSE
##      [2]         2     14386         1            FALSE
##      [3]         3     31523         1            FALSE
##      [4]         4      1591         1            FALSE
##      [5]         5    181293         1            FALSE
##      ...       ...       ...       ...              ...
##   [3680]      3680       442         5            FALSE
##   [3681]      3681     32862         6            FALSE
##   [3682]      3682      1316         6            FALSE
##   [3683]      3683     39602         6            FALSE
##   [3684]      3684     95460         7            FALSE
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
##   hardFilters: NULL
```

```
getSegments(kdVCF)
```

```
## GRanges object with 452 ranges and 8 metadata columns:
##         seqnames              ranges strand | segmentID totalVariants
##            <Rle>           <IRanges>  <Rle> | <numeric>     <numeric>
##     [1]     chr1           1-3389727      * |         1            11
##     [2]     chr1     3389728-3428608      * |         2             4
##     [3]     chr1    3428609-19199400      * |         3            22
##     [4]     chr1   19199401-19203725      * |         4             4
##     [5]     chr1   19203726-19635011      * |         5             8
##     ...      ...                 ...    ... .       ...           ...
##   [448]     chrX 153577919-153594977      * |         5             6
##   [449]     chrX 153594978-153668757      * |         6             3
##   [450]     chrX 153668758-155270560      * |         7             1
##   [451]     chrY          1-59373566      * |         1             0
##   [452]     chrM             1-16571      * |         1             0
##         firstVariantID lastVariantID    meanIMD mutationRate sampleNames
##              <integer>     <integer>  <numeric>    <numeric> <character>
##     [1]              1            11  308157.00  3.24510e-06       CPTAC
##     [2]             12            15    9720.25  1.02878e-04       CPTAC
##     [3]             16            37  716854.18  1.39498e-06       CPTAC
##     [4]             38            41    1081.25  9.24855e-04       CPTAC
##     [5]             42            49   53910.75  1.85492e-05       CPTAC
##     ...            ...           ...        ...          ...         ...
##   [448]           3675          3680    2843.17  3.51720e-04       CPTAC
##   [449]           3681          3683   24593.33  4.06614e-05       CPTAC
##   [450]           3684          3684 1601802.00  6.24297e-07       CPTAC
##   [451]           <NA>          <NA>         NA  0.00000e+00       CPTAC
##   [452]           <NA>          <NA>         NA  0.00000e+00       CPTAC
##         IMDcutoffValues
##               <numeric>
##     [1]            1000
##     [2]            1000
##     [3]            1000
##     [4]            1000
##     [5]            1000
##     ...             ...
##   [448]            1000
##   [449]            1000
##   [450]            1000
##   [451]            1000
##   [452]            1000
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

```
getKataegisFoci(kdVCF)
```

```
## GRanges object with 9 ranges and 7 metadata columns:
##       seqnames              ranges strand |    fociID sampleNames totalVariants
##          <Rle>           <IRanges>  <Rle> | <integer> <character>     <numeric>
##   [1]     chr3   58108856-58111467      * |         1       CPTAC             7
##   [2]     chr6   32489708-32489949      * |         2       CPTAC            13
##   [3]     chr6   32632598-32632770      * |         3       CPTAC             8
##   [4]     chr6 151669875-151674326      * |         4       CPTAC             7
##   [5]     chr8 144991205-144999107      * |         5       CPTAC            25
##   [6]    chr11   62285208-62298597      * |         6       CPTAC            25
##   [7]    chr14 105405599-105419557      * |         7       CPTAC            23
##   [8]    chr15   86122654-86124712      * |         8       CPTAC             6
##   [9]    chr19     4510560-4513559      * |         9       CPTAC            19
##       firstVariantID lastVariantID   meanIMD IMDcutoff
##            <numeric>     <integer> <numeric> <numeric>
##   [1]            782           788  435.1667      1000
##   [2]           1251          1263   20.0833      1000
##   [3]           1273          1280   24.5714      1000
##   [4]           1358          1364  741.8333      1000
##   [5]           1659          1683  329.2500      1000
##   [6]           2112          2136  557.8750      1000
##   [7]           2591          2613  634.4545      1000
##   [8]           2687          2692  411.6000      1000
##   [9]           3139          3157  166.6111      1000
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

```
getInfo(kdVCF)
```

```
## $sampleName
## [1] "CPTAC"
##
## $totalGenomicVariants
## [1] 3684
##
## $totalKataegisFoci
## [1] 9
##
## $totalVariantsInKataegisFoci
## [1] 133
##
## $version
## [1] "1.12.0"
##
## $date
## [1] "Thu Oct 30 00:41:38 2025"
##
## $parameters
## $parameters$minSizeKataegis
## [1] 6
##
## $parameters$IMDcutoff
## [1] 1000
##
## $parameters$test.stat
## [1] "Exponential"
##
## $parameters$penalty
## [1] "BIC"
##
## $parameters$pen.value
## [1] 0
##
## $parameters$method
## [1] "PELT"
##
## $parameters$minseglen
## [1] 2
##
## $parameters$aggregateRecords
## [1] FALSE
```

## 2.3 Visualization of segmentation and kataegis foci

Per sample, we can visualize the IMD, detected segments and putative kataegis foci as a rainfall plot. In addition, this allows for a per-chromosome approach which can highlight the putative kataegis foci.

```
rainfallPlot(kdVCF)
```

![](data:image/png;base64...)

```
# With showSegmentation, the detected segments (changepoints) as visualized with their mean IMD.
rainfallPlot(kdMAF, showSegmentation = TRUE)
```

![](data:image/png;base64...)

```
# With showSequence, we can display specific chromosomes or all chromosomes in which a putative kataegis foci has been detected.
rainfallPlot(kdSynthetic, showKataegis = TRUE, showSegmentation = TRUE, showSequence = "Kataegis")
```

![](data:image/png;base64...)

## 2.4 Custom function for IMD cutoff value

As show previously, the IMD cutoff value can be set by the user in order to identify different types of mutation clusters. However, it is also possible to define a custom function that determines a IMD cutoff value for each detected segment. This flexibility allow you to define your own kataegis definition while still using the `katdetectr` framework. Below we show how to implement a custom function for the IMD cutoff value. The function below comes from the work of [Pan-Cancer Analysis of Whole Genomes Consortium](https://www.nature.com/articles/s41586-020-1969-6#citeas)

```
# function for modeling sample mutation rate
modelSampleRate <- function(IMDs) {
    lambda <- log(2) / median(IMDs)

    return(lambda)
}

# function for calculating the nth root of x
nthroot <- function(x, n) {
    y <- x^(1 / n)

    return(y)
}

# Function that defines the IMD cutoff specific for each segment
# Within this function you can use all variables available in the slots: genomicVariants and segments
IMDcutoffFun <- function(genomicVariants, segments) {
    IMDs <- genomicVariants$IMD
    totalVariants <- segments$totalVariants
    width <- segments |>
        dplyr::as_tibble() |>
        dplyr::pull(width)

    sampleRate <- modelSampleRate(IMDs)

    IMDcutoff <- -log(1 - nthroot(0.01 / width, ifelse(totalVariants != 0, totalVariants - 1, 1))) / sampleRate

    IMDcutoff <- replace(IMDcutoff, IMDcutoff > 1000, 1000)

    return(IMDcutoff)
}

kdCustom <- detectKataegis(syntheticData, IMDcutoff = IMDcutoffFun)
```

# 3 Analyzing non standard sequences

The human autosomes and sex chromosomes from the reference genome hg19 and hg38 come implemented in `katdetectr`. However, other (non standard) sequences can be analyzed if the correct arguments are provided. You have to provide a dataframe that contains the length of all the sequences you want to analyze.

```
# generate data that contains non standard sequences
syndata1 <- generateSyntheticData(seqnames = c("chr1_gl000191_random", "chr4_ctg9_hap1"))
syndata2 <- generateSyntheticData(seqnames = "chr1")
syndata <- suppressWarnings(c(syndata1, syndata2))

# construct a dataframe that contains the length of the sequences
# each column name (name of the sequence)
sequenceLength <- data.frame(
    chr1 = 249250621,
    chr1_gl000191_random = 106433,
    chr4_ctg9_hap1 = 590426
)

# provide the dataframe with the sequence lengths using the refSeq argument
kdNonStandard <- detectKataegis(genomicVariants = syndata, refSeq = sequenceLength)
```

# 4 Session Information

```
utils::sessionInfo()
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
## [1] katdetectr_1.12.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] Rdpack_2.6.4                      DBI_1.2.3
##   [3] bitops_1.0-9                      rlang_1.1.6
##   [5] magrittr_2.0.4                    matrixStats_1.5.0
##   [7] compiler_4.5.1                    RSQLite_2.4.3
##   [9] GenomicFeatures_1.62.0            png_0.1-8
##  [11] vctrs_0.6.5                       stringr_1.5.2
##  [13] pkgconfig_2.0.3                   crayon_1.5.3
##  [15] fastmap_1.2.0                     magick_2.9.0
##  [17] backports_1.5.0                   XVector_0.50.0
##  [19] labeling_0.4.3                    Rsamtools_2.26.0
##  [21] rmarkdown_2.30                    markdown_2.0
##  [23] UCSC.utils_1.6.0                  tinytex_0.57
##  [25] purrr_1.1.0                       bit_4.6.0
##  [27] xfun_0.53                         BSgenome.Hsapiens.UCSC.hg38_1.4.5
##  [29] cachem_1.1.0                      litedown_0.7
##  [31] cigarillo_1.0.0                   GenomeInfoDb_1.46.0
##  [33] jsonlite_2.0.0                    blob_1.2.4
##  [35] DelayedArray_0.36.0               BiocParallel_1.44.0
##  [37] parallel_4.5.1                    R6_2.6.1
##  [39] plyranges_1.30.0                  VariantAnnotation_1.56.0
##  [41] stringi_1.8.7                     bslib_0.9.0
##  [43] RColorBrewer_1.1-3                rtracklayer_1.70.0
##  [45] DNAcopy_1.84.0                    GenomicRanges_1.62.0
##  [47] jquerylib_0.1.4                   Rcpp_1.1.0
##  [49] Seqinfo_1.0.0                     bookdown_0.45
##  [51] SummarizedExperiment_1.40.0       knitr_1.50
##  [53] zoo_1.8-14                        IRanges_2.44.0
##  [55] Matrix_1.7-4                      splines_4.5.1
##  [57] tidyselect_1.2.1                  dichromat_2.0-0.1
##  [59] abind_1.4-8                       yaml_2.3.10
##  [61] ggtext_0.1.2                      codetools_0.2-20
##  [63] curl_7.0.0                        lattice_0.22-7
##  [65] tibble_3.3.0                      Biobase_2.70.0
##  [67] withr_3.0.2                       KEGGREST_1.50.0
##  [69] S7_0.2.0                          evaluate_1.0.5
##  [71] survival_3.8-3                    xml2_1.4.1
##  [73] Biostrings_2.78.0                 pillar_1.11.1
##  [75] BiocManager_1.30.26               MatrixGenerics_1.22.0
##  [77] checkmate_2.3.3                   stats4_4.5.1
##  [79] generics_0.1.4                    RCurl_1.98-1.17
##  [81] S4Vectors_0.48.0                  ggplot2_4.0.0
##  [83] commonmark_2.0.0                  scales_1.4.0
##  [85] glue_1.8.0                        changepoint_2.3
##  [87] tools_4.5.1                       BiocIO_1.20.0
##  [89] data.table_1.17.8                 BSgenome_1.78.0
##  [91] GenomicAlignments_1.46.0          maftools_2.26.0
##  [93] XML_3.99-0.19                     grid_4.5.1
##  [95] tidyr_1.3.1                       rbibutils_2.3
##  [97] AnnotationDbi_1.72.0              restfulr_0.0.16
##  [99] cli_3.6.5                         S4Arrays_1.10.0
## [101] dplyr_1.1.4                       gtable_0.3.6
## [103] BSgenome.Hsapiens.UCSC.hg19_1.4.3 sass_0.4.10
## [105] digest_0.6.37                     BiocGenerics_0.56.0
## [107] SparseArray_1.10.0                rjson_0.2.23
## [109] farver_2.1.2                      memoise_2.0.1
## [111] htmltools_0.5.8.1                 lifecycle_1.0.4
## [113] httr_1.4.7                        gridtext_0.1.5
## [115] bit64_4.6.0-1
```