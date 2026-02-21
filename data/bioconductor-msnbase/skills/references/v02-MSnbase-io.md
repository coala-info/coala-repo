# MSnbase IO capabilities

Laurent Gatto1

1de Duve Institute, UCLouvain, Belgium

#### 30 October 2025

#### Abstract

This vignette describes *MSnbase*’s input and output capabilities.

#### Package

MSnbase 2.36.0

# Foreword

This software is free and open-source software. If you use it, please
support the project by citing it in publications:

> Gatto L, Lilley KS. MSnbase-an R/Bioconductor package for isobaric
> tagged mass spectrometry data visualization, processing and
> quantitation. Bioinformatics. 2012 Jan 15;28(2):288-9. doi:
> [10.1093/bioinformatics/btr645](https://doi.org/10.1093/bioinformatics/btr645).
> PMID: [22113085](https://www.ncbi.nlm.nih.gov/pubmed/22113085).

> *`MSnbase`, efficient and elegant R-based processing and
> visualisation of raw mass spectrometry data*. Laurent Gatto,
> Sebastian Gibb, Johannes Rainer. bioRxiv 2020.04.29.067868; doi:
> <https://doi.org/10.1101/2020.04.29.067868>

# Questions and bugs

For bugs, typos, suggestions or other questions, please file an issue
in our tracking system (<https://github.com/lgatto/MSnbase/issues>)
providing as much information as possible, a reproducible example and
the output of `sessionInfo()`.

If you don’t have a GitHub account or wish to reach a broader audience
for general questions about proteomics analysis using R, you may want
to use the Bioconductor support site: <https://support.bioconductor.org/>.

# 1 Overview

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)*’s aims are to facilitate the reproducible
analysis of mass spectrometry data within the R environment, from raw
data import and processing, feature quantification, quantification and
statistical analysis of the results (Gatto and Lilley [2012](#ref-Gatto2012)). Data import
functions for several formats are provided and intermediate or final
results can also be saved or exported. These capabilities are
presented below.

# 2 Data input

#### Raw data

Data stored in one of the published `XML`-based formats. i.e. `mzXML`
(Pedrioli et al. [2004](#ref-Pedrioli2004)), `mzData` (Orchard et al. [2007](#ref-Orchard2007)) or `mzML` (Martens et al. [2010](#ref-Martens2010)), can
be imported with the `readMSData` method, which makes use of the
*[mzR](https://bioconductor.org/packages/3.22/mzR)* package to create `MSnExp` objects. The files can be
in profile or centroided mode. See `?readMSData` for details.

Data from `mzML` files containing chromatographic data (e.g. generated in
SRM/MRM experiments) can be imported with the `readSRMData` function that
returns the chromatographic data as a `MChromatograms` object. See `?readSRMData`
for more details.

#### Peak lists

Peak lists in the `mgf`
format111 <http://www.matrixscience.com/help/data_file_help.html>
can be imported using the `readMgfData`. In this case, the peak data
has generally been pre-processed by other software. See
`?readMgfData` for details.

#### Quantitation data

Third party software can be used to generate quantitative data and
exported as a spreadsheet (generally comma or tab separated format).
This data as well as any additional meta-data can be imported with the
`readMSnSet` function. See `?readMSnSet` for details.

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* also supports the `mzTab`
format222 <https://github.com/HUPO-PSI/mzTab>, a light-weight,
tab-delimited file format for proteomics data developed within the
Proteomics Standards Initiative (PSI). `mzTab` files can be read into
R with `readMzTabData` to create and `MSnSet` instance.

![](data:image/png;base64...)

*MSnbase* input capabilities. The white and red boxes represent R functions/methods and objects respectively. The blue boxes represent different disk storage formats.

# 3 Data output

#### RData files

R objects can most easily be stored on disk with the `save` function.
It creates compressed binary images of the data representation that
can later be read back from the file with the `load` function.

#### mzML/mzXML files

`MSnExp` and `OnDiskMSnExp` files can be written to MS data files in `mzML` or
`mzXML` files with the `writeMSData` method. See `?writeMSData` for details.

#### Peak lists

`MSnExp` instances as well as individual spectra can be written as
`mgf` files with the `writeMgfData` method. Note that the meta-data in
the original R object can not be included in the file. See
`?writeMgfData` for details.

#### Quantitation data

Quantitation data can be exported to spreadsheet files with the
`write.exprs` method. Feature meta-data can be appended to the feature
intensity values. See `?writeMgfData` for details.

**Deprecated** `MSnSet` instances can also be exported to `mzTab`
files using the `writeMzTabData` function.

![](data:image/png;base64...)

*MSnbase* output capabilities. The white and red boxes represent R functions/methods and objects respectively. The blue boxes represent different disk storage formats.

# 4 Creating `MSnSet` from text spread sheets

This section describes the generation of `MSnSet` objects using data
available in a text-based spreadsheet. This entry point into R and
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* allows to import data processed by any of the
third party mass-spectrometry processing software available and
proceed with data exploration, normalisation and statistical analysis
using functions available in and the numerous Bioconductor
packages.

## 4.1 A complete work flow

The following section describes a work flow that uses three input
files to create the `MSnSet`. These files respectively describe the
quantitative expression data, the sample meta-data and the feature
meta-data. It is taken from the *[pRoloc](https://bioconductor.org/packages/3.22/pRoloc)* tutorial and
uses example files from the *[pRolocdat](https://bioconductor.org/packages/3.22/pRolocdat)* package.

We start by describing the `csv` to be used as input using the
`read.csv` function.

```
## The original data for replicate 1, available
## from the pRolocdata package
f0 <- dir(system.file("extdata", package = "pRolocdata"),
          full.names = TRUE,
          pattern = "pr800866n_si_004-rep1.csv")
csv <- read.csv(f0)
```

The three first lines of the original spreadsheet, containing the data
for replicate one, are illustrated below (using the function
`head`). It contains 888 rows (proteins) and 16
columns, including protein identifiers, database accession numbers,
gene symbols, reporter ion quantitation values, information related to
protein identification, …

```
head(csv, n=3)
```

```
##   Protein.ID        FBgn Flybase.Symbol No..peptide.IDs Mascot.score
## 1    CG10060 FBgn0001104    G-ialpha65A               3       179.86
## 2    CG10067 FBgn0000044         Act57B               5       222.40
## 3    CG10077 FBgn0035720        CG10077               5       219.65
##   No..peptides.quantified area.114 area.115 area.116 area.117
## 1                       1 0.379000 0.281000 0.225000 0.114000
## 2                       9 0.420000 0.209667 0.206111 0.163889
## 3                       3 0.187333 0.167333 0.169667 0.476000
##   PLS.DA.classification Peptide.sequence Precursor.ion.mass
## 1                    PM
## 2                    PM
## 3
##   Precursor.ion.charge pd.2013 pd.markers
## 1                           PM    unknown
## 2                           PM    unknown
## 3                      unknown    unknown
```

Below read in turn the spread sheets that contain the quantitation
data (`exprsFile.csv`), feature meta-data (`fdataFile.csv`) and sample
meta-data (`pdataFile.csv`).

```
## The quantitation data, from the original data
f1 <- dir(system.file("extdata", package = "pRolocdata"),
          full.names = TRUE, pattern = "exprsFile.csv")
exprsCsv <- read.csv(f1)
## Feature meta-data, from the original data
f2 <- dir(system.file("extdata", package = "pRolocdata"),
          full.names = TRUE, pattern = "fdataFile.csv")
fdataCsv <- read.csv(f2)
## Sample meta-data, a new file
f3 <- dir(system.file("extdata", package = "pRolocdata"),
          full.names = TRUE, pattern = "pdataFile.csv")
pdataCsv <- read.csv(f3)
```

`exprsFile.csv` contains the quantitation (expression) data for the
888 proteins and 4 reporter tags.

```
head(exprsCsv, n = 3)
```

```
##          FBgn     X114     X115     X116     X117
## 1 FBgn0001104 0.379000 0.281000 0.225000 0.114000
## 2 FBgn0000044 0.420000 0.209667 0.206111 0.163889
## 3 FBgn0035720 0.187333 0.167333 0.169667 0.476000
```

`fdataFile.csv` contains meta-data for the 888
features (here proteins).

```
head(fdataCsv, n = 3)
```

```
##          FBgn ProteinID FlybaseSymbol NoPeptideIDs MascotScore
## 1 FBgn0001104   CG10060   G-ialpha65A            3      179.86
## 2 FBgn0000044   CG10067        Act57B            5      222.40
## 3 FBgn0035720   CG10077       CG10077            5      219.65
##   NoPeptidesQuantified PLSDA
## 1                    1    PM
## 2                    9    PM
## 3                    3
```

`pdataFile.csv` contains samples (here fractions) meta-data. This
simple file has been created manually.

```
pdataCsv
```

```
##   sampleNames Fractions
## 1        X114       4/5
## 2        X115     12/13
## 3        X116        19
## 4        X117        21
```

The self-contained `MSnSet` can now easily be generated using the
`readMSnSet` constructor, providing the respective `csv` file names
shown above and specifying that the data is comma-separated (with `sep = ","`). Below, we call that object `res` and display its content.

```
library("MSnbase")
res <- readMSnSet(exprsFile = f1,
                  featureDataFile = f2,
                  phenoDataFile = f3,
                  sep = ",")
res
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: X114 X115 X116 X117
##   varLabels: Fractions
##   varMetadata: labelDescription
## featureData
##   featureNames: FBgn0001104 FBgn0000044 ... FBgn0001215 (888 total)
##   fvarLabels: ProteinID FlybaseSymbol ... PLSDA (6 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
## Quantitation data loaded: Thu Oct 30 01:19:18 2025  using readMSnSet.
##  MSnbase version: 2.36.0
```

### 4.1.1 The `MSnSet` class

Although there are additional specific sub-containers for additional
meta-data (for instance to make the object MIAPE compliant), the
feature (the sub-container, or slot `featureData`) and sample (the
`phenoData` slot) are the most important ones. They need to meet the
following validity requirements (see figure below):

* the number of row in the expression/quantitation data and feature
  data must be equal and the row names must match exactly, and
* the number of columns in the expression/quantitation data and number
  of row in the sample meta-data must be equal and the column/row
  names must match exactly.

A detailed description of the `MSnSet` class is available by typing
`?MSnSet` in the R console.

![](data:image/png;base64...)

Dimension requirements for the respective expression, feature and sample meta-data slots.

The individual parts of this data object can be accessed with their respective accessor methods:

* the quantitation data can be retrieved with `exprs(res)`,
* the feature meta-data with `fData(res)` and
* the sample meta-data with `pData(res)`.

## 4.2 A shorter work flow

The `readMSnSet2` function provides a simplified import workforce. It
takes a single spreadsheet as input (default is `csv`) and extract the
columns identified by `ecol` to create the expression data, while the
others are used as feature meta-data. `ecol` can be a `character` with
the respective column labels or a numeric with their indices. In the
former case, it is important to make sure that the names match
exactly. Special characters like `'-'` or `'('` will be transformed by
R into `'.'` when the `csv` file is read in. Optionally, one can also
specify a column to be used as feature names. Note that these must be
unique to guarantee the final object validity.

```
ecol <- paste("area", 114:117, sep = ".")
fname <- "Protein.ID"
eset <- readMSnSet2(f0, ecol, fname)
eset
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: CG10060 CG10067 ... CG9983 (888 total)
##   fvarLabels: Protein.ID FBgn ... pd.markers (12 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 2.36.0
```

The `ecol` columns can also be queried interactively from R using the
`getEcols` and `grepEcols` function. The former return a character
with all column names, given a splitting character, i.e. the
separation value of the spreadsheet (typically `","` for `csv`, `"\t"`
for `tsv`, …). The latter can be used to grep a pattern of interest
to obtain the relevant column indices.

```
getEcols(f0, ",")
```

```
##  [1] "\"Protein ID\""              "\"FBgn\""
##  [3] "\"Flybase Symbol\""          "\"No. peptide IDs\""
##  [5] "\"Mascot score\""            "\"No. peptides quantified\""
##  [7] "\"area 114\""                "\"area 115\""
##  [9] "\"area 116\""                "\"area 117\""
## [11] "\"PLS-DA classification\""   "\"Peptide sequence\""
## [13] "\"Precursor ion mass\""      "\"Precursor ion charge\""
## [15] "\"pd.2013\""                 "\"pd.markers\""
```

```
grepEcols(f0, "area", ",")
```

```
## [1]  7  8  9 10
```

```
e <- grepEcols(f0, "area", ",")
readMSnSet2(f0, e)
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 888 features, 4 samples
##   element names: exprs
## protocolData: none
## phenoData: none
## featureData
##   featureNames: 1 2 ... 888 (888 total)
##   fvarLabels: Protein.ID FBgn ... pd.markers (12 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 2.36.0
```

The `phenoData` slot can now be updated accordingly using the
replacement functions `phenoData<-` or `pData<-` (see `?MSnSet` for
details).

# 5 Session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] gplots_3.2.0         msdata_0.49.0        pRoloc_1.50.0
##  [4] BiocParallel_1.44.0  MLInterfaces_1.90.0  cluster_2.1.8.1
##  [7] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
## [10] IRanges_2.44.0       pRolocdata_1.47.0    Rdisop_1.70.0
## [13] zoo_1.8-14           MSnbase_2.36.0       ProtGenerics_1.42.0
## [16] S4Vectors_0.48.0     mzR_2.44.0           Rcpp_1.1.0
## [19] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [22] ggplot2_4.0.0        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1               bitops_1.0-9
##   [3] filelock_1.0.3              tibble_3.3.0
##   [5] hardhat_1.4.2               preprocessCore_1.72.0
##   [7] pROC_1.19.0.1               rpart_4.1.24
##   [9] lifecycle_1.0.4             httr2_1.2.1
##  [11] doParallel_1.0.17           globals_0.18.0
##  [13] lattice_0.22-7              MASS_7.3-65
##  [15] MultiAssayExperiment_1.36.0 dendextend_1.19.1
##  [17] magrittr_2.0.4              limma_3.66.0
##  [19] plotly_4.11.0               sass_0.4.10
##  [21] rmarkdown_2.30              jquerylib_0.1.4
##  [23] yaml_2.3.10                 MsCoreUtils_1.22.0
##  [25] DBI_1.2.3                   RColorBrewer_1.1-3
##  [27] lubridate_1.9.4             abind_1.4-8
##  [29] GenomicRanges_1.62.0        purrr_1.1.0
##  [31] mixtools_2.0.0.1            AnnotationFilter_1.34.0
##  [33] nnet_7.3-20                 rappdirs_0.3.3
##  [35] ipred_0.9-15                lava_1.8.1
##  [37] listenv_0.9.1               parallelly_1.45.1
##  [39] ncdf4_1.24                  codetools_0.2-20
##  [41] DelayedArray_0.36.0         tidyselect_1.2.1
##  [43] Spectra_1.20.0              farver_2.1.2
##  [45] viridis_0.6.5               matrixStats_1.5.0
##  [47] BiocFileCache_3.0.0         Seqinfo_1.0.0
##  [49] jsonlite_2.0.0              caret_7.0-1
##  [51] e1071_1.7-16                survival_3.8-3
##  [53] iterators_1.0.14            foreach_1.5.2
##  [55] segmented_2.1-4             tools_4.5.1
##  [57] progress_1.2.3              glue_1.8.0
##  [59] prodlim_2025.04.28          gridExtra_2.3
##  [61] SparseArray_1.10.0          BiocBaseUtils_1.12.0
##  [63] mgcv_1.9-3                  xfun_0.53
##  [65] MatrixGenerics_1.22.0       dplyr_1.1.4
##  [67] withr_3.0.2                 BiocManager_1.30.26
##  [69] fastmap_1.2.0               caTools_1.18.3
##  [71] digest_0.6.37               timechange_0.3.0
##  [73] R6_2.6.1                    colorspace_2.1-2
##  [75] gtools_3.9.5                lpSolve_5.6.23
##  [77] dichromat_2.0-0.1           biomaRt_2.66.0
##  [79] RSQLite_2.4.3               tidyr_1.3.1
##  [81] hexbin_1.28.5               data.table_1.17.8
##  [83] recipes_1.3.1               FNN_1.1.4.1
##  [85] class_7.3-23                prettyunits_1.2.0
##  [87] PSMatch_1.14.0              httr_1.4.7
##  [89] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [91] ModelMetrics_1.2.2.2        pkgconfig_2.0.3
##  [93] gtable_0.3.6                timeDate_4051.111
##  [95] blob_1.2.4                  S7_0.2.0
##  [97] impute_1.84.0               XVector_0.50.0
##  [99] htmltools_0.5.8.1           bookdown_0.45
## [101] MALDIquant_1.22.3           clue_0.3-66
## [103] scales_1.4.0                png_0.1-8
## [105] gower_1.0.2                 knitr_1.50
## [107] MetaboCoreUtils_1.18.0      reshape2_1.4.4
## [109] coda_0.19-4.1               nlme_3.1-168
## [111] curl_7.0.0                  proxy_0.4-27
## [113] cachem_1.1.0                stringr_1.5.2
## [115] KernSmooth_2.23-26          parallel_4.5.1
## [117] mzID_1.48.0                 vsn_3.78.0
## [119] pillar_1.11.1               vctrs_0.6.5
## [121] pcaMethods_2.2.0            randomForest_4.7-1.2
## [123] dbplyr_2.5.1                xtable_1.8-4
## [125] evaluate_1.0.5              magick_2.9.0
## [127] tinytex_0.57                mvtnorm_1.3-3
## [129] cli_3.6.5                   compiler_4.5.1
## [131] rlang_1.1.6                 crayon_1.5.3
## [133] future.apply_1.20.0         labeling_0.4.3
## [135] LaplacesDemon_16.1.6        mclust_6.1.1
## [137] QFeatures_1.20.0            affy_1.88.0
## [139] plyr_1.8.9                  fs_1.6.6
## [141] stringi_1.8.7               viridisLite_0.4.2
## [143] Biostrings_2.78.0           lazyeval_0.2.2
## [145] Matrix_1.7-4                hms_1.1.4
## [147] bit64_4.6.0-1               future_1.67.0
## [149] KEGGREST_1.50.0             statmod_1.5.1
## [151] SummarizedExperiment_1.40.0 kernlab_0.9-33
## [153] igraph_2.2.1                memoise_2.0.1
## [155] affyio_1.80.0               bslib_0.9.0
## [157] sampling_2.11               bit_4.6.0
```

# References

Gatto, Laurent, and Kathryn S Lilley. 2012. “MSnbase – an R/Bioconductor Package for Isobaric Tagged Mass Spectrometry Data Visualization, Processing and Quantitation.” *Bioinformatics* 28 (2): 288–9. <https://doi.org/10.1093/bioinformatics/btr645>.

Martens, Lennart, Matthew Chambers, Marc Sturm, Darren Kes sner, Fredrik Levander, Jim Shofstahl, Wilfred H Tang, et al. 2010. “MzML - a Community Standard for Mass Spectrometry Data.” *Molecular & Cellular Proteomics : MCP*. <https://doi.org/10.1074/mcp.R110.000133>.

Orchard, Sandra, Luisa Montechi-Palazzi, Eric W Deutsch, Pierre-Alain Binz, Andrew R Jones, Norman Paton, Angel Pizarro, David M Creasy, Jérôme Wojcik, and Henning Hermjakob. 2007. “Five Years of Progress in the Standardization of Proteomics Data 4th Annual Spring Workshop of the Hupo-Proteomics Standards Initiative April 23-25, 2007 Ecole Nationale Supérieure (Ens), Lyon, France.” *Proteomics* 7 (19): 3436–40. <https://doi.org/10.1002/pmic.200700658>.

Pedrioli, Patrick G A, Jimmy K Eng, Robert Hubley, Mathijs Vogelzang, Eric W Deutsch, Brian Raught, Brian Pratt, et al. 2004. “A Common Open Representation of Mass Spectrometry Data and Its Application to Proteomics Research.” *Nat. Biotechnol.* 22 (11): 1459–66. <https://doi.org/10.1038/nbt1031>.