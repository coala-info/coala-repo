# Predicting m6A sites from miCLIP2 data with m6Aboost

You Zhou1 and Kathi Zarnack1

1Buchmann Institute for Molecular Life Sciences, Frankfurt am Main, Germany

#### October 30, 2025

#### Abstract

Precisely identify the m6A sites from miCLIP data is still a challenge in
the epigenomics field. Here we present a workflow to determine the m6A
sites from the miCLIP2 data set.

#### Package

m6Aboost 1.16.0

# 1 Introduction

N6-methyladenosine (m6A) is the most abundant internal modification in mRNA.
It impacts many different aspects of an mRNA’s life, e.g. nuclear export,
translation, stability, etc.

m6A individual-nucleotide resolution UV crosslinking and immunoprecipitation
(miCLIP) and the improved **miCLIP2** are m6A antibody-based methods that allow
the transcriptome-wide mapping of m6A sites at a single-nucleotide resolution
(Körtel et al. [2021](#ref-Koertel2020))(Linder et al. [2015](#ref-Linder2015)). In brief, UV crosslinking of the m6A antibody to
the modified RNA leads to truncation of reverse transcription or C-to-T
transitions in the case of readthrough. However, due to the limited specificity
and high cross-reactivity of the m6A antibodies, the miCLIP data comprise a
high background signal, which hampers the reliable identification of m6A sites
from the data.

For accurately detecting m6A sites, we implemented an AdaBoost-based machine
learning model (**m6Aboost**) for classifying the miCLIP2 peaks into m6A sites
and background signals (Körtel et al. [2021](#ref-Koertel2020)). The model was trained on high-confidence
m6A sites that were obtained by comparing wildtype and *Mettl3* knockout mouse
embryonic stem cells (mESC) lacking the major methyltransferase Mettl3. For
classification, the m6Aboost model uses a series of features, including the
experimental miCLIP2 signal (truncation events and C-to-T transitions) as well
as the transcript region (5’UTR, CDS, 3’UTR) and the nucleotide sequence in a
21-nt window around the miCLIP2 peak.

The package *[m6Aboost](https://bioconductor.org/packages/3.22/m6Aboost)* includes the trained model and the
functionalities to prepare the data, extract the required features and predict
the m6A sites.

# 2 Installation

The *[m6Aboost](https://bioconductor.org/packages/3.22/m6Aboost)* package is available at
<https://bioconductor.org> and can be
installed via `BiocManager::install`:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("m6Aboost")
```

A package only needs to be installed once. Load the package into an
R session with

```
library(m6Aboost)
```

# 3 Pre-requisite

The workflow described herein is based on our published paper (Körtel et al. [2021](#ref-Koertel2020)).
Thus we expect the user to preprocess the miCLIP2 data based on the
preprocessing pipeline in our article (Körtel et al. [2021](#ref-Koertel2020)). In brief, the
preprocessing steps include basic processing of the sequencing reads, such as
quality filtering, barcode handling, mapping, generation of the single
nucleotide crosslink and the C to T transition bigWig file. After the
preprocessing, we expect the user to do the peak calling with the tool
[PureCLIP](https://github.com/skrakau/PureCLIP) (Krakau, Richard, and Marsico [2017](#ref-Krakau2017)).

![](data:image/png;base64...)

**Overview of the m6Aboost preprocessing workflow**.

**Note:** If you use `m6Aboost` in published research, please cite:

> Körtel, Nadine#, Cornelia Rückle#, You Zhou#, Anke Busch, Peter Hoch-Kraft,
> FX Reymond Sutandy, Jacob Haase, et al. 2021. “Deep and accurate detection
> of m6A RNA modifications using miCLIP2 and m6Aboost machine learning.”
> bioRxiv. <https://doi.org/10.1101/2020.12.20.423675>.

# 4 The m6Aboost workflow

![](data:image/png;base64...)

**Overview of the m6Aboost workflow**.

# 5 Reproducibility filtering

In order to increase the reproducibility of the prediction result, we suggest
the user to keep the peaks which present in at least two replicates for the
following analysis.

# 6 Loading the test data set

The package includes a test data set which allows to test all the functions
in the m6Aboost package. The test data set comprises a subset of the
miCLIP2 peak calling result from wildtype mESC cells (Körtel et al. [2021](#ref-Koertel2020)),
including 1,200 peaks (PureCLIP) in three different genes
(ENSMUSG00000026478.14, ENSMUSG00000031960.14, ENSMUSG00000035569.17). These
are encoded in a `GRanges` object with the following metadata:

* The column `Reads_mean` contains the *mean value* of
  truncation events at a given peak in three replicate experiments.
* The column `CtoT` contains the *mean value* of C-to-T transitions that are
  associcated with a given peak. (Note that the C-to-T transitions at an m6A site
  do occur on the C flanking the modified A in the DRACH motif.)

In addition, the package includes the annotation file `test_gff3` which
is a subset of the full annotation in `gff3` format downloaded from
[GENCODE](https://www.gencodegenes.org/). The test truncation and C-to-T
transition bigWig files are a subset of the miCLIP2 signal from a wildtype
mESC cells (Körtel et al. [2021](#ref-Koertel2020)).

```
library(m6Aboost)
## Load the test data
testpath <- system.file("extdata", package = "m6Aboost")
test_gff3 <- file.path(testpath, "test_annotation.gff3")
test <- readRDS(file.path(testpath, "test.rds"))

test
```

```
## GRanges object with 1200 ranges and 2 metadata columns:
##          seqnames    ranges strand |  CtoTmean    WTmean
##             <Rle> <IRanges>  <Rle> | <numeric> <numeric>
##      [1]     chr1 153332740      - |         0   17.6667
##      [2]     chr1 153332699      - |         0   92.3333
##      [3]     chr1 153332489      - |         0   28.3333
##      [4]     chr1 153332481      - |         0   20.6667
##      [5]     chr1 153332480      - |         0   15.0000
##      ...      ...       ...    ... .       ...       ...
##   [1196]     chr8 111056683      + |   0.00000   9.66667
##   [1197]     chr8 111057030      + |   0.00000  61.00000
##   [1198]     chr8 111057335      + |   2.33333  10.33333
##   [1199]     chr8 111057424      + |   1.66667  11.00000
##   [1200]     chr8 111057515      + |   0.00000  23.66667
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

# 7 Read count assignment

After peak calling, the user needs to assign the number of truncation events
and C-to-T transitions that are associated with each peak. In
*[m6Aboost](https://bioconductor.org/packages/3.22/m6Aboost)*, we provide two functions, `truncationAssignment` and
`CtoTAssignment`, to assign these counts from the imported bigWig files. Note
that the values are first assigned separated for each replicate and then
averaged into a mean count for the subsequent feature extraction by
`preparingData`.

```
## truncationAssignment allows to assign the number of truncation events
## The input should be a GRanges object with the peaks and bigWig files
## with the truncation events (separated per strand)
truncationBw_p <- file.path(testpath, "truncation_positive.bw")
truncationBw_n <- file.path(testpath, "truncation_negative.bw")

test <- truncationAssignment(test,
    bw_positive=truncationBw_p,
    bw_negative=truncationBw_n,
    sampleName = "WT1")

## CtoTAssignment allows to assign the number of C-to-T transitions
ctotBw_p <- file.path(testpath, "C2T_positive.bw")
ctotBw_n <- file.path(testpath, "C2T_negative.bw")
test <- CtoTAssignment(test,
    bw_positive=ctotBw_p,
    bw_negative=ctotBw_n,
    sampleName = "CtoT_WT1")
```

Next, the user needs to calculate the *mean number* of truncation events and
C-to-T transition read counts across the replicates.

```
## E.g. for two replicates, this can be calculated as
peak$WTmean <- (peak$WT1 + peak$WT2)/2
```

# 8 Extract features for the m6Aboost model

For training the m6Aboost model, we used the surrounding nucleotide sequence,
the transcript region harbouring the peak, the number of C-to-T transitions and
the relative signal strength. The function `preparingData` allows to extract
these features. Please note the function `preparingData` requires
an annotation file that was downloaded from
[GENCODE](https://www.gencodegenes.org/).

```
## Extract the features for the m6Aboost prediction
test <- preparingData(test, test_gff3, colname_reads="WTmean",
    colname_C2T="CtoTmean")
test
```

```
## GRanges object with 1200 ranges and 10 metadata columns:
##          seqnames    ranges strand |  CtoTmean    WTmean       WT1  CtoT_WT1
##             <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
##      [1]     chr1 153332740      - |         0   17.6667        12         0
##      [2]     chr1 153332699      - |         0   92.3333        54         0
##      [3]     chr1 153332489      - |         0   28.3333        18         0
##      [4]     chr1 153332481      - |         0   20.6667        10         0
##      [5]     chr1 153332480      - |         0   15.0000         5         0
##      ...      ...       ...    ... .       ...       ...       ...       ...
##   [1196]     chr8 111056683      + |   0.00000   9.66667         6         0
##   [1197]     chr8 111057030      + |   0.00000  61.00000        39         0
##   [1198]     chr8 111057335      + |   2.33333  10.33333         8         0
##   [1199]     chr8 111057424      + |   1.66667  11.00000         8         0
##   [1200]     chr8 111057515      + |   0.00000  23.66667        10         0
##                        gene_id       RSS      CtoT        UTR3        UTR5
##                    <character> <numeric> <numeric> <character> <character>
##      [1] ENSMUSG00000026478.14  1.101785         0          NO         YES
##      [2] ENSMUSG00000026478.14  5.758384         0          NO         YES
##      [3] ENSMUSG00000026478.14  1.767013         0          NO          NO
##      [4] ENSMUSG00000026478.14  1.288880         0          NO          NO
##      [5] ENSMUSG00000026478.14  0.935478         0          NO          NO
##      ...                   ...       ...       ...         ...         ...
##   [1196] ENSMUSG00000031960.14  0.209647   0.00000         YES          NO
##   [1197] ENSMUSG00000031960.14  1.322945   0.00000         YES          NO
##   [1198] ENSMUSG00000031960.14  0.224105   2.33333         YES          NO
##   [1199] ENSMUSG00000031960.14  0.238564   1.66667         YES          NO
##   [1200] ENSMUSG00000031960.14  0.513274   0.00000         YES          NO
##                  CDS
##          <character>
##      [1]          NO
##      [2]          NO
##      [3]         YES
##      [4]         YES
##      [5]         YES
##      ...         ...
##   [1196]         YES
##   [1197]         YES
##   [1198]          NO
##   [1199]          NO
##   [1200]          NO
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

# 9 Prediction of m6A sites

The function `m6Aboost` performs the prediction, i.e. the classification of the
miCLIP2 peaks into m6A sites and background. As input, the function `m6Aboost`
uses the output object from the function `preparingData`. In addition, the user
needs to specify the name of the `BSgenome` package associated with the species
used for the experiment. Please note that the `BSgenome` package, which
contains the sequence information, should be downloaded from `Bioconductor` in
advance.

## 9.1 Normalization of numerical features

Application of the machine learning model to new data set requires that the
data were generated by the same protocol and thus show an independent and
identical distribution. The m6Aboost model includes two numerical features from
the miCLIP2 data, namely relative signal strength and C-to-T transitions, which
could systematically vary between experiments. Since in the training set, both
features approximated a *Poisson distribution*. We recommend the user to
normalized the values of each features in the input samples by the ratio of
the mean for this feature between the input dataset and the training set. For
doing this normalization, user just need to set the parameter
`normalization = TRUE`.

```
## Note that since the test data set contains only a tiny fraction of the real
## data, and a part of the test data belongs to the training set. Here for
## preventing the unnecessary value change, we set the normalization to FALSE.
out <- m6Aboost(test, "BSgenome.Mmusculus.UCSC.mm10", normalization = FALSE)
out
```

```
## GRanges object with 272 ranges and 12 metadata columns:
##         seqnames    ranges strand |  CtoTmean    WTmean       WT1  CtoT_WT1
##            <Rle> <IRanges>  <Rle> | <numeric> <numeric> <numeric> <numeric>
##     [1]     chr1 153332308      - |        15  61.33333        24         0
##     [2]     chr1 153262625      - |         0  35.00000        11         0
##     [3]     chr1 153255240      - |         0   6.00000         4         0
##     [4]     chr1 153255239      - |         0  15.00000         8         0
##     [5]     chr1 153255209      - |         0   9.66667         4         0
##     ...      ...       ...    ... .       ...       ...       ...       ...
##   [268]     chr8 111050361      + |   0.00000  14.66667        11         0
##   [269]     chr8 111054149      + |   0.00000  26.00000        28         0
##   [270]     chr8 111056349      + |   0.00000   4.66667         5         0
##   [271]     chr8 111057335      + |   2.33333  10.33333         8         0
##   [272]     chr8 111057424      + |   1.66667  11.00000         8         0
##                       gene_id       RSS      CtoT        UTR3        UTR5
##                   <character> <numeric> <numeric> <character> <character>
##     [1] ENSMUSG00000026478.14  3.825064        15          NO          NO
##     [2] ENSMUSG00000026478.14  2.182781         0          NO          NO
##     [3] ENSMUSG00000026478.14  0.374191         0          NO          NO
##     [4] ENSMUSG00000026478.14  0.935478         0          NO          NO
##     [5] ENSMUSG00000026478.14  0.602863         0          NO          NO
##     ...                   ...       ...       ...         ...         ...
##   [268] ENSMUSG00000031960.14  0.318085   0.00000          NO          NO
##   [269] ENSMUSG00000031960.14  0.563878   0.00000          NO          NO
##   [270] ENSMUSG00000031960.14  0.101209   0.00000         YES         YES
##   [271] ENSMUSG00000031960.14  0.224105   2.33333         YES          NO
##   [272] ENSMUSG00000031960.14  0.238564   1.66667         YES          NO
##                 CDS       class      prob
##         <character> <character> <numeric>
##     [1]         YES         YES 0.7286185
##     [2]         YES          NO 0.1393625
##     [3]         YES          NO 0.0343775
##     [4]         YES          NO 0.1547813
##     [5]         YES          NO 0.1594595
##     ...         ...         ...       ...
##   [268]         YES          NO  0.199353
##   [269]         YES          NO  0.177922
##   [270]          NO          NO  0.058019
##   [271]          NO         YES  0.652307
##   [272]          NO         YES  0.719683
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

The function `m6Aboost` returns a GRanges object with two additional metadata
columns:

* The column *class* provides the classification result, i.e. whether the
  m6Aboost model predicts this site to be an m6A site or not.
* The column *prob* includes the prediction score for a given site.

All sites with a prediction score > 0.5 are considered as m6A sites, although a
more stringent cutoff can be applied if needed.

## 9.2 Access the machine learning model m6Aboost

The raw model **m6Aboost** is stored in *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*. Users
can access the raw model with the following code:

```
## firstly user need to load the ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub()
## "EH6021" is the retrieve record of the m6Aboost
model <-  eh[["EH6021"]]
## here shows more information about the stored model
query(eh, "m6Aboost")
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH6021
## # package(): m6Aboost
## # $dataprovider: Zarnack's lab
## # $species: NA
## # $rdataclass: boosting
## # $rdatadateadded: 2021-05-18
## # $title: The m6Aboost machine learning model
## # $description: The machine learning model which use for identify the m6A si...
## # $taxonomyid: NA
## # $genome: NA
## # $sourcetype: RDS
## # $sourceurl: https://github.com/Codezy99/m6Aboost/blob/main/m6Aboost.rds
## # $sourcesize: NA
## # $tags: c("Epigenetics", "ExperimentHubSoftware", "Genetics",
## #   "Sequencing")
## # retrieve record with 'object[["EH6021"]]'
```

# 10 Session info

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ExperimentHub_3.0.0                AnnotationHub_4.0.0
##  [3] BiocFileCache_3.0.0                dbplyr_2.5.1
##  [5] BSgenome.Mmusculus.UCSC.mm10_1.4.3 BSgenome_1.78.0
##  [7] rtracklayer_1.70.0                 BiocIO_1.20.0
##  [9] Biostrings_2.78.0                  XVector_0.50.0
## [11] m6Aboost_1.16.0                    GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0                      IRanges_2.44.0
## [15] adabag_5.1                         doParallel_1.0.17
## [17] iterators_1.0.14                   foreach_1.5.2
## [19] caret_7.0-1                        lattice_0.22-7
## [21] ggplot2_4.0.0                      rpart_4.1.24
## [23] S4Vectors_0.48.0                   BiocGenerics_0.56.0
## [25] generics_0.1.4                     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              farver_2.1.2
##   [5] rmarkdown_2.30              vctrs_0.6.5
##   [7] memoise_2.0.1               Rsamtools_2.26.0
##   [9] RCurl_1.98-1.17             base64enc_0.1-3
##  [11] S4Arrays_1.10.0             htmltools_0.5.8.1
##  [13] curl_7.0.0                  SparseArray_1.10.0
##  [15] pROC_1.19.0.1               sass_0.4.10
##  [17] ConsRank_2.1.5              parallelly_1.45.1
##  [19] bslib_0.9.0                 htmlwidgets_1.6.4
##  [21] plyr_1.8.9                  httr2_1.2.1
##  [23] lubridate_1.9.4             cachem_1.1.0
##  [25] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [27] pkgconfig_2.0.3             Matrix_1.7-4
##  [29] R6_2.6.1                    fastmap_1.2.0
##  [31] MatrixGenerics_1.22.0       future_1.67.0
##  [33] digest_0.6.37               AnnotationDbi_1.72.0
##  [35] RSQLite_2.4.3               filelock_1.0.3
##  [37] timechange_0.3.0            abind_1.4-8
##  [39] httr_1.4.7                  compiler_4.5.1
##  [41] proxy_0.4-27                bit64_4.6.0-1
##  [43] withr_3.0.2                 S7_0.2.0
##  [45] BiocParallel_1.44.0         DBI_1.2.3
##  [47] Rttf2pt1_1.3.14             MASS_7.3-65
##  [49] lava_1.8.1                  DelayedArray_0.36.0
##  [51] rappdirs_0.3.3              rjson_0.2.23
##  [53] gtools_3.9.5                ModelMetrics_1.2.2.2
##  [55] tools_4.5.1                 extrafontdb_1.1
##  [57] future.apply_1.20.0         nnet_7.3-20
##  [59] glue_1.8.0                  restfulr_0.0.16
##  [61] nlme_3.1-168                grid_4.5.1
##  [63] reshape2_1.4.4              recipes_1.3.1
##  [65] gtable_0.3.6                class_7.3-23
##  [67] tidyr_1.3.1                 data.table_1.17.8
##  [69] BiocVersion_3.22.0          pillar_1.11.1
##  [71] stringr_1.5.2               splines_4.5.1
##  [73] dplyr_1.1.4                 survival_3.8-3
##  [75] bit_4.6.0                   tidyselect_1.2.1
##  [77] knitr_1.50                  bookdown_0.45
##  [79] SummarizedExperiment_1.40.0 xfun_0.53
##  [81] Biobase_2.70.0              hardhat_1.4.2
##  [83] timeDate_4051.111           matrixStats_1.5.0
##  [85] stringi_1.8.7               yaml_2.3.10
##  [87] cigarillo_1.0.0             evaluate_1.0.5
##  [89] codetools_0.2-20            extrafont_0.20
##  [91] tibble_3.3.0                BiocManager_1.30.26
##  [93] cli_3.6.5                   jquerylib_0.1.4
##  [95] dichromat_2.0-0.1           Rcpp_1.1.0
##  [97] globals_0.18.0              png_0.1-8
##  [99] XML_3.99-0.19               rgl_1.3.24
## [101] gower_1.0.2                 blob_1.2.4
## [103] bitops_1.0-9                listenv_0.9.1
## [105] ipred_0.9-15                rlist_0.4.6.2
## [107] scales_1.4.0                prodlim_2025.04.28
## [109] purrr_1.1.0                 crayon_1.5.3
## [111] rlang_1.1.6                 KEGGREST_1.50.0
```

# References

Körtel, Nadine#, Cornelia Rückle#, You Zhou#, Anke Busch, Peter Hoch-Kraft, FX Reymond Sutandy, Jacob Haase, et al. 2021. “Deep and accurate detection of m6A RNA modifications using miCLIP2 and m6Aboost machine learning.” *Nucleic Acids Research*. <https://doi.org/10.1093/nar/gkab485>.

Krakau, Sabrina, Hugues Richard, and Annalisa Marsico. 2017. “PureCLIP: capturing target-specific protein RNA interaction footprints from single-nucleotide CLIP-seq data.” *Genome Biology* 18 (1). <https://doi.org/10.1186/s13059-017-1364-2>.

Linder, Bastian, Anya V Grozhik, Anthony O Olarerin-George, Cem Meydan, Christopher E Mason, and Samie R Jaffrey. 2015. “Single-nucleotide-resolution mapping of m6A and m6Am throughout the transcriptome.” *Nat Methods*. <https://doi.org/10.1038/nmeth.3453>.