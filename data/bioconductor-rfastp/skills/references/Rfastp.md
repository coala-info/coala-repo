# An Ultra-Fast All-in-One FASTQ preprocessor

Wei Wang

#### 02/12/2026

#### Package

Rfastp 1.20.3

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 FastQ Quality Control with rfastp](#fastq-quality-control-with-rfastp)
  + [3.1 a normal QC run for single-end fastq file.](#a-normal-qc-run-for-single-end-fastq-file.)
  + [3.2 a normal QC run for paired-end fastq files.](#a-normal-qc-run-for-paired-end-fastq-files.)
  + [3.3 merge paired-end fastq files after QC.](#merge-paired-end-fastq-files-after-qc.)
  + [3.4 UMI processing](#umi-processing)
    - [3.4.1 a normal UMI processing for 10X Single-Cell library.](#a-normal-umi-processing-for-10x-single-cell-library.)
    - [3.4.2 Set a customized UMI prefix and location in sequence name.](#set-a-customized-umi-prefix-and-location-in-sequence-name.)
  + [3.5 A QC example with customized cutoffs and adapter sequence.](#a-qc-example-with-customized-cutoffs-and-adapter-sequence.)
  + [3.6 multiple input files for read1/2 in a vector.](#multiple-input-files-for-read12-in-a-vector.)
* [4 concatenate multiple fastq files.](#concatenate-multiple-fastq-files.)
  + [4.1 catfastq concatenate all the input files into a new file.](#catfastq-concatenate-all-the-input-files-into-a-new-file.)
* [5 Generate report tables/plots](#generate-report-tablesplots)
  + [5.1 A data frame for the summary.](#a-data-frame-for-the-summary.)
  + [5.2 a ggplot2 object of base quality plot.](#a-ggplot2-object-of-base-quality-plot.)
  + [5.3 a ggplot2 object of GC Content plot.](#a-ggplot2-object-of-gc-content-plot.)
  + [5.4 a data frame for the trimming summary.](#a-data-frame-for-the-trimming-summary.)
* [6 Miscellaneous helper functions](#miscellaneous-helper-functions)
* [7 Acknowledgments](#acknowledgments)
* [References](#references)

# 1 Introduction

The Rfastp package provides an interface to the all-in-one preprocessing for FastQ files toolkit [fastp](https://github.com/OpenGene/fastp)(Chen et al. [2018](#ref-10.1093/bioinformatics/bty560)).

# 2 Installation

Use the `BiocManager` package to download and install the package from
Bioconductor as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rfastp")
```

If required, the latest development version of the package can also be installed
from GitHub.

```
BiocManager::install("remotes")
BiocManager::install("RockefellerUniversity/Rfastp")
```

Once the package is installed, load it into your R session:

```
library(Rfastp)
```

# 3 FastQ Quality Control with rfastp

The package contains three example fastq files, corresponding to a single-end
fastq file, a pair of paired-end fastq files.

```
se_read1 <- system.file("extdata","Fox3_Std_small.fq.gz",package="Rfastp")
pe_read1 <- system.file("extdata","reads1.fastq.gz",package="Rfastp")
pe_read2 <- system.file("extdata","reads2.fastq.gz",package="Rfastp")
outputPrefix <- tempfile(tmpdir = tempdir())
```

## 3.1 a normal QC run for single-end fastq file.

Rfastp support multiple threads, set threads number by parameter `thread`.

```
se_json_report <- rfastp(read1 = se_read1,
    outputFastq = paste0(outputPrefix, "_se"), thread = 4)
```

## 3.2 a normal QC run for paired-end fastq files.

```
pe_json_report <- rfastp(read1 = pe_read1, read2 = pe_read2,
    outputFastq = paste0(outputPrefix, "_pe"))
```

## 3.3 merge paired-end fastq files after QC.

```
pe_merge_json_report <- rfastp(read1 = pe_read1, read2 = pe_read2, merge = TRUE,
    outputFastq = paste0(outputPrefix, '_unpaired'),
    mergeOut = paste0(outputPrefix, "_merged.fastq.gz"))
```

## 3.4 UMI processing

### 3.4.1 a normal UMI processing for 10X Single-Cell library.

```
umi_json_report <- rfastp(read1 = pe_read1, read2 = pe_read2,
    outputFastq = paste0(outputPrefix, '_umi1'), umi = TRUE, umiLoc = "read1",
    umiLength = 16)
```

### 3.4.2 Set a customized UMI prefix and location in sequence name.

the following example will add prefix string before the UMI sequence in the sequence name. An "\_" will be added between the prefix string and UMI sequence. The UMI sequences will be inserted into the sequence name before the first space.

```
umi_json_report <- rfastp(read1 = pe_read1, read2 = pe_read2,
    outputFastq = paste0(outputPrefix, '_umi2'), umi = TRUE, umiLoc = "read1",
    umiLength = 16, umiPrefix = "#", umiNoConnection = TRUE,
    umiIgnoreSeqNameSpace = TRUE)
```

## 3.5 A QC example with customized cutoffs and adapter sequence.

Trim poor quality bases at 3’ end base by base with quality higher than 5; trim poor quality bases at 5’ end by a 29bp window with mean quality higher than 20; disable the polyG trimming, specify the adapter sequence for read1.

```
clipr_json_report <- rfastp(read1 = se_read1,
    outputFastq = paste0(outputPrefix, '_clipr'),
    disableTrimPolyG = TRUE,
    cutLowQualFront = TRUE,
    cutFrontWindowSize = 29,
    cutFrontMeanQual = 20,
    cutLowQualTail = TRUE,
    cutTailWindowSize = 1,
    cutTailMeanQual = 5,
    minReadLength = 29,
    adapterSequenceRead1 = 'GTGTCAGTCACTTCCAGCGG'
)
```

## 3.6 multiple input files for read1/2 in a vector.

rfastq can accept multiple input files, and it will concatenate the input files into one and the run fastp.

```
pe001_read1 <- system.file("extdata","splited_001_R1.fastq.gz",
    package="Rfastp")
pe002_read1 <- system.file("extdata","splited_002_R1.fastq.gz",
    package="Rfastp")
pe003_read1 <- system.file("extdata","splited_003_R1.fastq.gz",
    package="Rfastp")
pe004_read1 <- system.file("extdata","splited_004_R1.fastq.gz",
    package="Rfastp")
inputfiles <- c(pe001_read1, pe002_read1, pe003_read1, pe004_read1)
cat_rjson_report <- rfastp(read1 = inputfiles,
    outputFastq = paste0(outputPrefix, "_merged1"))
```

# 4 concatenate multiple fastq files.

## 4.1 catfastq concatenate all the input files into a new file.

```
pe001_read2 <- system.file("extdata","splited_001_R2.fastq.gz",
    package="Rfastp")
pe002_read2 <- system.file("extdata","splited_002_R2.fastq.gz",
    package="Rfastp")
pe003_read2 <- system.file("extdata","splited_003_R2.fastq.gz",
    package="Rfastp")
pe004_read2 <- system.file("extdata","splited_004_R2.fastq.gz",
    package="Rfastp")
inputR2files <- c(pe001_read2, pe002_read2, pe003_read2, pe004_read2)
catfastq(output = paste0(outputPrefix,"_merged2_R2.fastq.gz"),
    inputFiles = inputR2files)
```

# 5 Generate report tables/plots

## 5.1 A data frame for the summary.

```
dfsummary <- qcSummary(pe_json_report)
```

## 5.2 a ggplot2 object of base quality plot.

```
p1 <- curvePlot(se_json_report)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the Rfastp package.
##   Please report the issue to the authors.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

```
p1
```

![](data:image/png;base64...)

## 5.3 a ggplot2 object of GC Content plot.

```
p2 <- curvePlot(se_json_report, curve="content_curves")
p2
```

![](data:image/png;base64...)

## 5.4 a data frame for the trimming summary.

```
dfTrim <- trimSummary(pe_json_report)
```

# 6 Miscellaneous helper functions

usage of rfastp:

```
?rfastp
```

usage of catfastq:

```
?catfastq
```

usage of qcSummary:

```
?qcSummary
```

usage of trimSummary:

```
?trimSummary
```

usage of curvePlot:

```
?curvePlot
```

# 7 Acknowledgments

Thank you to Ji-Dung Luo for testing/vignette review/critical feedback, Doug Barrows for critical feedback/vignette review and Ziwei Liang for their support.
# Session info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Rfastp_1.20.3    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      rjson_0.2.23        dplyr_1.2.0
##  [5] compiler_4.5.2      BiocManager_1.30.27 tinytex_0.58        tidyselect_1.2.1
##  [9] Rcpp_1.1.1          stringr_1.6.0       magick_2.9.0        dichromat_2.0-0.1
## [13] jquerylib_0.1.4     scales_1.4.0        yaml_2.3.12         fastmap_1.2.0
## [17] plyr_1.8.9          ggplot2_4.0.2       R6_2.6.1            labeling_0.4.3
## [21] generics_0.1.4      knitr_1.51          tibble_3.3.1        bookdown_0.46
## [25] bslib_0.10.0        pillar_1.11.1       RColorBrewer_1.1-3  rlang_1.1.7
## [29] cachem_1.1.0        stringi_1.8.7       xfun_0.56           sass_0.4.10
## [33] S7_0.2.1            otel_0.2.0          cli_3.6.5           withr_3.0.2
## [37] magrittr_2.0.4      digest_0.6.39       grid_4.5.2          lifecycle_1.0.5
## [41] vctrs_0.7.1         evaluate_1.0.5      glue_1.8.0          farver_2.1.2
## [45] reshape2_1.4.5      rmarkdown_2.30      tools_4.5.2         pkgconfig_2.0.3
## [49] htmltools_0.5.9
```

# References

Chen, Shifu, Yanqing Zhou, Yaru Chen, and Jia Gu. 2018. “fastp: an ultra-fast all-in-one FASTQ preprocessor.” *Bioinformatics* 34 (17): i884–i890. <https://doi.org/10.1093/bioinformatics/bty560>.