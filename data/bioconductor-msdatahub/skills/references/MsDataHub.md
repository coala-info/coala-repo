# Mass Spectrometry Data on ExperimentHub

Laurent Gatto

#### 30 October 2025

#### Package

MsDataHub 1.10.0

# 1 Introduction

The `MsDataHub` package provides example mass spectrometry data,
peptide spectrum matches or quantitative data from proteomics and
metabolomics experiments. The data are served through the
`ExperimentHub` infrastructure, which allows download them only ones
and cache them for further use. Currently available data are summarised
in the table below and details in the next section.

```
library("MsDataHub")
DT::datatable(MsDataHub())
```

# 2 Installation

To install the package:

```
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("MsDataHub")
```

# 3 Available data

## 3.1 TripleTOF

* Type: Raw MS data
* Files: `PestMix1_DDA.mzML` and `PestMix1_SWATH.mzML`
* More details: `?TripleTOF`

Load with

```
f <- PestMix1_DDA.mzML()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
library(Spectra)
Spectra(f)
```

```
## MSn data (Spectra) with 7602 spectra in a MsBackendMzR backend:
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            1     0.231         1
## 2            1     0.351         2
## 3            1     0.471         3
## 4            1     0.591         4
## 5            1     0.711         5
## ...        ...       ...       ...
## 7598         1   899.491      7598
## 7599         1   899.613      7599
## 7600         1   899.747      7600
## 7601         1   899.872      7601
## 7602         1   899.993      7602
##  ... 34 more variables/columns.
##
## file(s):
## 1087ce54a20b3f_7861
```

```
f <- PestMix1_SWATH.mzML()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
Spectra(f)
```

```
## MSn data (Spectra) with 8999 spectra in a MsBackendMzR backend:
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            2     0.203         1
## 2            2     0.300         2
## 3            2     0.397         3
## 4            2     0.494         4
## 5            2     0.591         5
## ...        ...       ...       ...
## 8995         2   899.527      8995
## 8996         2   899.624      8996
## 8997         2   899.721      8997
## 8998         2   899.818      8998
## 8999         2   899.915      8999
##  ... 34 more variables/columns.
##
## file(s):
## 1087ce3e6e9396_7862
```

## 3.2 sciex

* Type: Raw MS data
* Files: `20171016_POOL_POS_1_105-134.mzML` and `20171016_POOL_POS_3_105-134.mzML`
* More details: `?sciex`

Load with

```
f <- X20171016_POOL_POS_1_105.134.mzML()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
Spectra(f)
```

```
## MSn data (Spectra) with 931 spectra in a MsBackendMzR backend:
##       msLevel     rtime scanIndex
##     <integer> <numeric> <integer>
## 1           1     0.280         1
## 2           1     0.559         2
## 3           1     0.838         3
## 4           1     1.117         4
## 5           1     1.396         5
## ...       ...       ...       ...
## 927         1   258.641       927
## 928         1   258.920       928
## 929         1   259.199       929
## 930         1   259.478       930
## 931         1   259.757       931
##  ... 34 more variables/columns.
##
## file(s):
## 1087ce7ed6e2f9_7859
```

```
f <- X20171016_POOL_POS_3_105.134.mzML()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
Spectra(f)
```

```
## MSn data (Spectra) with 931 spectra in a MsBackendMzR backend:
##       msLevel     rtime scanIndex
##     <integer> <numeric> <integer>
## 1           1     0.275         1
## 2           1     0.554         2
## 3           1     0.833         3
## 4           1     1.112         4
## 5           1     1.391         5
## ...       ...       ...       ...
## 927         1   258.636       927
## 928         1   258.915       928
## 929         1   259.194       929
## 930         1   259.473       930
## 931         1   259.752       931
##  ... 34 more variables/columns.
##
## file(s):
## 1087ce46b86044_7860
```

## 3.3 PXD000001

* Type: Raw MS data and peptide spectrum matches
* Files:
  `TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML.gz`
  and
  `TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid`
* More details: `?PDX000001`

Load with

```
f <- TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.20141210.mzML.gz()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
Spectra(f)
```

```
## MSn data (Spectra) with 7534 spectra in a MsBackendMzR backend:
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            1    0.4584         1
## 2            1    0.9725         2
## 3            1    1.8524         3
## 4            1    2.7424         4
## 5            1    3.6124         5
## ...        ...       ...       ...
## 7530         2   3600.47      7530
## 7531         2   3600.83      7531
## 7532         2   3601.18      7532
## 7533         2   3601.57      7533
## 7534         2   3601.98      7534
##  ... 34 more variables/columns.
##
## file(s):
## 1087cef3f46ba_7858
```

```
f <- TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.20141210.mzid()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
library(PSMatch)
PSM(f)
```

```
## PSM with 5802 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

## 3.4 CPTAC

* Type: tab-delimited quantitative proteomics data tables (as produced
  by MaxQuant)
* Files: `cptac_a_b_c_peptides.txt`, `cptac_a_b_peptides.txt` and
  `cptac_peptides.txt`
* More details: `?cptac`

Load with

```
library(QFeatures)
f <- cptac_peptides.txt()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
ecols <- grep("Intensity\\.", names(read.delim(f)))
readSummarizedExperiment(f, ecols, sep = "\t")
```

```
## class: SummarizedExperiment
## dim: 11466 45
## metadata(0):
## assays(1): ''
## rownames(11466): 1 2 ... 11465 11466
## rowData names(143): Sequence N.term.cleavage.window ...
##   Oxidation..M..site.IDs MS.MS.Count
## colnames(45): Intensity.6A_1 Intensity.6A_2 ... Intensity.6E_8
##   Intensity.6E_9
## colData names(0):
```

```
cptac_a_b_c_peptides.txt()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
##                                                      EH7804
## "/home/biocbuild/.cache/R/ExperimentHub/1087ce3c48fae_7854"
```

```
cptac_a_b_peptides.txt()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
## loading from cache
```

```
##                                                       EH7805
## "/home/biocbuild/.cache/R/ExperimentHub/1087ce574123ac_7855"
```

## 3.5 FAAH KO

* Type: Raw MS data, in netCDF format.
* File: `ko15.CDF`
* More details: `?cdf`

Load with

```
f <- ko15.CDF()
```

```
## see ?MsDataHub and browseVignettes('MsDataHub') for documentation
```

```
## loading from cache
```

```
Spectra(f)
```

```
## MSn data (Spectra) with 1278 spectra in a MsBackendMzR backend:
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            1   2501.38         1
## 2            1   2502.94         2
## 3            1   2504.51         3
## 4            1   2506.07         4
## 5            1   2507.64         5
## ...        ...       ...       ...
## 1274         1   4493.56      1274
## 1275         1   4495.13      1275
## 1276         1   4496.69      1276
## 1277         1   4498.26      1277
## 1278         1   4499.82      1278
##  ... 34 more variables/columns.
##
## file(s):
## 1087ce731daa1d_7853
```

## 3.6 DIA-NN software outputs

* Type: tab-delimited DIA quantitative proteomics data tables produced
  by [DIA-NN](https://github.com/vdemichev/DiaNN).
* Files:
  + Label-free DIA: `benchmarkingDIA.tsv`
  + mTRAQ plexDIA: `Report.Derks2022.plexDIA.tsv`
* More details: `?benchmarkingDIA.tsv` and
  `?Report.Derks2022.plexDIA.tsv`

Load with

```
library(QFeatures)
lfdia <- read.delim(MsDataHub::benchmarkingDIA.tsv())
readQFeaturesFromDIANN(lfdia)
```

```
## An instance of class QFeatures (type: bulk) with 24 sets:
##
##  [1] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_0_1fmol_inj1.mzML: SummarizedExperiment with 28980 rows and 1 columns
##  [2] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_0_1fmol_inj2.mzML: SummarizedExperiment with 29495 rows and 1 columns
##  [3] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_0_1fmol_inj3.mzML: SummarizedExperiment with 29210 rows and 1 columns
##  ...
##  [22] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_5fmol_inj1.mzML: SummarizedExperiment with 30941 rows and 1 columns
##  [23] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_5fmol_inj2.mzML: SummarizedExperiment with 30321 rows and 1 columns
##  [24] U:\712006-Proteomics\Issues\Issue 253\DIANN\raw-data\RD139_Overlap_UPS1_5fmol_inj3.mzML: SummarizedExperiment with 24168 rows and 1 columns
```

```
plexdia <- read.delim(MsDataHub::Report.Derks2022.plexDIA.tsv())
readQFeaturesFromDIANN(plexdia, multiplexing = "mTRAQ")
```

```
## An instance of class QFeatures (type: bulk) with 54 sets:
##
##  [1] F:\JD\plexDIA\nPOP\wJD1146.raw: SummarizedExperiment with 2635 rows and 3 columns
##  [2] F:\JD\plexDIA\nPOP\wJD1147.raw: SummarizedExperiment with 3000 rows and 3 columns
##  [3] F:\JD\plexDIA\nPOP\wJD1148.raw: SummarizedExperiment with 2676 rows and 3 columns
##  ...
##  [52] F:\JD\plexDIA\nPOP\wJD1203.raw: SummarizedExperiment with 4441 rows and 3 columns
##  [53] F:\JD\plexDIA\nPOP\wJD1204.raw: SummarizedExperiment with 4416 rows and 3 columns
##  [54] F:\JD\plexDIA\nPOP\wJD1205.raw: SummarizedExperiment with 4492 rows and 3 columns
```

## 3.7 DIA-NN single-cell proteomics reports

* Type: tab-delimited DIA quantitative proteomics data tables produced
  by [DIA-NN](https://github.com/vdemichev/DiaNN).
* Files:
  + Single-cell abel-free: `Ai2025_aCMs_report.tsv`
  + Single-cell label-free: `Ai2025_iCMs_report.tsv`
* More details: `?Ai2025`.

## 3.8 Proteomics contaminant databases

* Type: fasta files, as documented in `camprotR`’s [cRAP
  databases](https://cambridgecentreforproteomics.github.io/camprotR/articles/crap.html)
  vignette.
* Files:
  + `crap_gpm.fasta`: the common Repository of Adventitious Proteins
    (cRAP) from the Global Proteome Machine (GPM) organisation.
  + `crap_ccp.fasta`: Cambridge Centre for Proteomics’ own cRAP fasta
    database.
  + `crap_maxquant.fasta.gz`: MaxQuant’s contaminant database.
* More details: `?cRAP`.

# 4 Adding data to `MsDataHub`

1. If you would like additional dataset to `MsDataHub`, start by
   opening an
   [issue](https://github.com/rformassspectrometry/MsDataHub/issues)
   in the package’s GitHub repository and describe the new data. In
   particular, provide information about it’s provenance, its use, its
   format(s) and acknowledge that the data may be shared freely with
   the community without any restrictions. You may provide an open
   licence specifying the terms it can be re-used, typically a
   CC-BY-SA license.
2. By contribution to the package, you acknowledge that you will
   comply to the R for Mass Spectrometry project [code of
   conduct](https://rformassspectrometry.github.io/RforMassSpectrometry/articles/RforMassSpectrometry.html#code-of-conduct).
3. A maintainer of the package will reply to your issue, confirming
   that the data can be added.
4. At this point, if you are familiar with the development of
   `ExperimentHub` packages and GitHub *pull requests*, you may
   directly send one that adds your data to the package. Make sure (1)
   add appropriate references in the manual page and (2) to add
   yourself as a contributor of the package in the DESCRIPTION file.
5. Alternatively, a maintainer will add the dataset to the package and
   may require your input to make sure the documentation file is
   complete.

# Session information

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
##  [1] MsDataHub_1.10.0            QFeatures_1.20.0
##  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] PSMatch_1.14.0              Spectra_1.20.0
## [13] BiocParallel_1.44.0         S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1        dplyr_1.1.4             blob_1.2.4
##  [4] Biostrings_2.78.0       filelock_1.0.3          fastmap_1.2.0
##  [7] lazyeval_0.2.2          BiocFileCache_3.0.0     digest_0.6.37
## [10] lifecycle_1.0.4         cluster_2.1.8.1         ProtGenerics_1.42.0
## [13] KEGGREST_1.50.0         RSQLite_2.4.3           magrittr_2.0.4
## [16] compiler_4.5.1          rlang_1.1.6             sass_0.4.10
## [19] tools_4.5.1             igraph_2.2.1            yaml_2.3.10
## [22] knitr_1.50              htmlwidgets_1.6.4       S4Arrays_1.10.0
## [25] bit_4.6.0               curl_7.0.0              DelayedArray_0.36.0
## [28] plyr_1.8.9              abind_1.4-8             withr_3.0.2
## [31] purrr_1.1.0             grid_4.5.1              ExperimentHub_3.0.0
## [34] MASS_7.3-65             cli_3.6.5               mzR_2.44.0
## [37] crayon_1.5.3            rmarkdown_2.30          httr_1.4.7
## [40] reshape2_1.4.4          BiocBaseUtils_1.12.0    ncdf4_1.24
## [43] DBI_1.2.3               cachem_1.1.0            stringr_1.5.2
## [46] parallel_4.5.1          AnnotationDbi_1.72.0    AnnotationFilter_1.34.0
## [49] BiocManager_1.30.26     XVector_0.50.0          vctrs_0.6.5
## [52] Matrix_1.7-4            jsonlite_2.0.0          bookdown_0.45
## [55] bit64_4.6.0-1           clue_0.3-66             crosstalk_1.2.2
## [58] tidyr_1.3.1             jquerylib_0.1.4         glue_1.8.0
## [61] codetools_0.2-20        DT_0.34.0               stringi_1.8.7
## [64] BiocVersion_3.22.0      tibble_3.3.0            pillar_1.11.1
## [67] rappdirs_0.3.3          htmltools_0.5.8.1       R6_2.6.1
## [70] dbplyr_2.5.1            httr2_1.2.1             evaluate_1.0.5
## [73] lattice_0.22-7          AnnotationHub_4.0.0     png_0.1-8
## [76] memoise_2.0.1           bslib_0.9.0             MetaboCoreUtils_1.18.0
## [79] Rcpp_1.1.0              SparseArray_1.10.0      xfun_0.53
## [82] MsCoreUtils_1.22.0      fs_1.6.6                pkgconfig_2.0.3
```