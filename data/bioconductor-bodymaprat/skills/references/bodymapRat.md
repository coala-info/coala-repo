# The bodymapRat data user’s guide

Stephanie C. Hicks1 and Kwame Okrah2

1Johns Hopkins Bloomberg School of Public Health
2Genentech

#### 30 October 2025

#### Abstract

This package contains a SummarizedExperiment
from the Yu et al. (2013) paper that performed the
rat BodyMap across 11 organs and 4 developmental stages.
Raw FASTQ files were downloaded and mapped using STAR.
Data is available on ExperimentHub as a data package.

#### Package

bodymapRat 1.26.0

## 0.1 Introduction

The `bodymapRat` package contains gene expression
data on 652 RNA-Seq samples from a comprehensive rat
transcriptomic BodyMap study. These samples include
the sequence identifier information provided in the
header of the FASTQ files which can be used as a
surrogate for batch. These samples have not been
normalized or pre-processed.

The data are provided in a `SummarizedExperiment`. The
phenotypic information can be extracted using the
`colData()` function and a description of the phenotypic
data is listed in the table below:

| Title | Description |
| --- | --- |
| sraExperiment | SRA Experiment ID |
| title | Title of sample provided by the authors |
| geoAccession | GEO Accession ID |
| BioSample | BioSample ID |
| avgLength | Average read length |
| instrument | Machine identifier (from FASTQ header) |
| runID | Run ID (from FASTQ header) |
| fcID | Flow cell ID (from FASTQ header) |
| fcLane | Flow cell lane (from FASTQ header) |
| tile | Tile (from FASTQ header) |
| xtile | xtile (from FASTQ header) |
| ytile | ytile (from FASTQ header) |
| organ | Body organ |
| sex | Gender |
| stage | Stage |
| techRep | Technical replicate number |
| colOrgan | Column of colors to help with plotting |
| rnaRIN | RIN number |
| barcode | barcode number |

The data can be accessed as follows:

```
library(SummarizedExperiment)
library(bodymapRat)
```

We use the `bodymapRat()` function to download the
relevant files from *Bioconductor*’s
[ExperimentHub](http://bioconductor.org/packages/ExperimentHub) web
resource. Running this function will download a
`SummarizedExperiment` object, which contains read counts, as
well as the metadata on the rows (genes) and columns (cells).

```
bm_rat <- bodymapRat()

# Get the expression data
counts = assay(bm_rat)
dim(counts)
```

```
## [1] 32637   652
```

```
counts[1:5, 1:5]
```

```
##                    SRR1169893 SRR1169894 SRR1169895 SRR1169896 SRR1169897
## ENSRNOG00000000001          1          0          0          1          4
## ENSRNOG00000000007          1          1          0          3          0
## ENSRNOG00000000008          7          4          2          3          7
## ENSRNOG00000000009          0          0          0          0          1
## ENSRNOG00000000010          0          1          0          0          0
```

```
# Get the meta data along columns
head(colData(bm_rat))
```

```
## DataFrame with 6 rows and 22 columns
##            sraExperiment      sraRun       title geoAccession sraSample
##              <character> <character> <character>     <factor>  <factor>
## SRR1169893     SRX471368  SRR1169893 Adr_F_002_1   GSM1328469 SRS558114
## SRR1169894     SRX471368  SRR1169894 Adr_F_002_1   GSM1328469 SRS558114
## SRR1169895     SRX471369  SRR1169895 Adr_F_002_2   GSM1328470 SRS558115
## SRR1169896     SRX471369  SRR1169896 Adr_F_002_2   GSM1328470 SRS558115
## SRR1169897     SRX471370  SRR1169897 Adr_F_002_3   GSM1328471 SRS558116
## SRR1169898     SRX471370  SRR1169898 Adr_F_002_3   GSM1328471 SRS558116
##               BioSample avgLength       organ         sex     stage   techRep
##                <factor> <integer> <character> <character> <numeric> <integer>
## SRR1169893 SAMN02642886        50     Adrenal           F         2         1
## SRR1169894 SAMN02642886        50     Adrenal           F         2         2
## SRR1169895 SAMN02642867        50     Adrenal           F         2         1
## SRR1169896 SAMN02642867        50     Adrenal           F         2         2
## SRR1169897 SAMN02642894        50     Adrenal           F         2         1
## SRR1169898 SAMN02642894        50     Adrenal           F         2         2
##               colOrgan         mix      rnaRIN     barcode  instrument
##            <character> <character> <character> <character> <character>
## SRR1169893       brown          M1         9.3          11   HWI-ST845
## SRR1169894       brown          M1         9.3          11   HWI-ST845
## SRR1169895       brown          M1         9.1           5   HWI-ST845
## SRR1169896       brown          M1         9.1           5   HWI-ST845
## SRR1169897       brown          M1         9.5           3  HWI-ST1131
## SRR1169898       brown          M1         9.5           3  HWI-ST1195
##                  runID        fcID      fcLane        tile       xtile
##            <character> <character> <character> <character> <character>
## SRR1169893      120326   D0VTJACXX           2        1101        1506
## SRR1169894      120525   D10G7ACXX           2        1101        1394
## SRR1169895      120326   D0VTJACXX           5        1101        1170
## SRR1169896      120525   D10G7ACXX           5        1101        1650
## SRR1169897      120424   C0P4UACXX           4        1101        1675
## SRR1169898      120525   C0TDUACXX           4        1101        1138
##                  ytile
##            <character>
## SRR1169893        2000
## SRR1169894        2133
## SRR1169895        2029
## SRR1169896        2126
## SRR1169897        2216
## SRR1169898        2067
```

The data in this package are used as an example
data set in the
[`qsmooth` Bioconductor package](http://bioconductor.org/packages/qsmooth).

# 1 References

# Appendix

1. Yu et al. (2013). A rat RNA-Seq transcriptomic
   BodyMap across 11 organs and 4 developmental stages.
   *Nature Communications* **5**:3230. PMID: 24510058.
   PMCID: PMC3926002.

# A SessionInfo

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
##  [1] bodymapRat_1.26.0           ExperimentHub_3.0.0
##  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [5] dbplyr_2.5.1                SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           knitr_1.50
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
## [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
## [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
## [16] compiler_4.5.1       Biostrings_2.78.0    htmltools_0.5.8.1
## [19] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [22] crayon_1.5.3         jquerylib_0.1.4      DelayedArray_0.36.0
## [25] cachem_1.1.0         abind_1.4-8          tidyselect_1.2.1
## [28] digest_0.6.37        dplyr_1.1.4          purrr_1.1.0
## [31] bookdown_0.45        BiocVersion_3.22.0   fastmap_1.2.0
## [34] grid_4.5.1           cli_3.6.5            SparseArray_1.10.0
## [37] magrittr_2.0.4       S4Arrays_1.10.0      withr_3.0.2
## [40] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [43] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [46] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [49] evaluate_1.0.5       rlang_1.1.6          glue_1.8.0
## [52] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [55] R6_2.6.1
```