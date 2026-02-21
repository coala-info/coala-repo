# Retrieve and Use Mass Spectrometry Data from MetaboLights

#### 4 November 2025

**Package**: *[MsBackendMetaboLights](https://bioconductor.org/packages/3.22/MsBackendMetaboLights)*
**Authors**: Johannes Rainer [aut, cre] (ORCID:
<https://orcid.org/0000-0002-6977-7147>),
Philippine Louail [aut] (ORCID:
<https://orcid.org/0009-0007-5429-6846>)
**Last modified:** 2025-11-04 13:56:22.742939
**Compiled**: Tue Nov 4 18:52:51 2025

# 1 Introduction

The *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* package provides a central infrastructure for the
handling of Mass Spectrometry (MS) data in Bioconductor. The package supports
interchangeable use of different *backends* to import and represent MS data from
a variety of sources and data formats. The *MsBackendMetaboLights* package
allows to retrieve MS data files directly from the
[MetaboLights](https://www.ebi.ac.uk/metabolights/) repository. MetaboLights is
one of the main public repositories for deposition of metabolomics experiments
including (raw) MS and/or NMR data files and the related experimental and
analytical results. The *MsBackendMetaboLights* package downloads and locally
caches MS data files for a MetaboLights data set and enables further analyses of
this data directly in R.

# 2 Installation

The package can be installed from within R with the commands below:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RforMassSpectrometry/MsBackendMetaboLights")
```

# 3 Importing MS Data from MetaboLights

[MetaboLights](https://www.ebi.ac.uk/metabolights/) is one of the main public
repositories for deposition of metabolomics experiments including (raw) mass
spectrometry (MS) and NMR data files and experimental/analysis results. The
experimental metadata and results are stored as plain text files in ISA-tab
format. Each MetaboLights experiment must provide a file describing the samples
analyzed and at least one *assay* file that links between the experimental
samples and the (raw and processed) data files with quantification of
metabolites/features in these samples.

In this vignette we explore and load MS data files from a small MetaboLights
experiment. MetaboLights provides information on a data set/experiment as a set
of plain text files in *ISA-tab* format. These can be accessed and read from the
data set’s ftp folder. The set of files consist generally of a file with
information on the experiment/investigation (in a file with the file name
starting with *i\_*) the samples of the data set (file name starting with *s\_*),
the *assay* (measurements/analysis) of the experiment and a file with quantified
metabolite abundances (file name starting with *m\_*). Note that a data set can
have more than one assay file.

Below we list all files from the MetaboLights data set with the ID *MTBLS39*.

```
library(MsBackendMetaboLights)

#' List files of a MetaboLights data set
all_files <- mtbls_list_files("MTBLS39")
```

All these files are directly accessible in the ftp folder associated with the
MetaboLights data set. Below we use the `mtbls_ftp_path()` function to return
the ftp path for our test data set.

```
mtbls_ftp_path("MTBLS39")
```

```
## [1] "ftp://ftp.ebi.ac.uk/pub/databases/metabolights/studies/public/MTBLS39/"
```

We could inspect the content of this folder also using a browser supporting the
ftp file transfer protocol and download individual files manually. We can
however access the files also directly from within R. Below we read the *assay*
data file directly using the base R `read.table()` function. Note that
connections to the MetaboLights FTP server are rate-limited and might thus
fail. We use below the `retry()` function to retry reading from the FTP server
if the connection fails or gets closed before the data is fully read.

```
#' Get the assay files of the data set
grep("^a_", all_files, value = TRUE)
```

```
## [1] "a_MTBLS39_the_plasticity_of_the_grapevine_berry_transcriptome_metabolite_profiling_mass_spectrometry.txt"
```

```
#' Read the assay file
a <- retry(read.table(paste0(mtbls_ftp_path("MTBLS39"),
                             grep("^a_", all_files, value = TRUE)),
                      sep = "\t", header = TRUE, check.names = FALSE),
           ntimes = 5, sleep_mult = 7)
```

Each row in this assay table refers to one measurement (data file) of the data
set, with columns providing information on that measurement. The number and
content of columns can vary between data sets and depends on the information the
original researcher (manually) provided. Below we list the columns available in
the assay file of our test data set.

```
colnames(a)
```

```
##  [1] "Sample Name"
##  [2] "Protocol REF"
##  [3] "Parameter Value[Post Extraction]"
##  [4] "Parameter Value[Derivatization]"
##  [5] "Extract Name"
##  [6] "Protocol REF"
##  [7] "Parameter Value[Chromatography Instrument]"
##  [8] "Term Source REF"
##  [9] "Term Accession Number"
## [10] "Parameter Value[Autosampler model]"
## [11] "Term Source REF"
## [12] "Term Accession Number"
## [13] "Parameter Value[Column model]"
## [14] "Parameter Value[Column type]"
## [15] "Parameter Value[Guard column]"
## [16] "Term Source REF"
## [17] "Term Accession Number"
## [18] "Labeled Extract Name"
## [19] "Label"
## [20] "Term Source REF"
## [21] "Term Accession Number"
## [22] "Protocol REF"
## [23] "Parameter Value[Scan polarity]"
## [24] "Parameter Value[Scan m/z range]"
## [25] "Parameter Value[Instrument]"
## [26] "Term Source REF"
## [27] "Term Accession Number"
## [28] "Parameter Value[Ion source]"
## [29] "Term Source REF"
## [30] "Term Accession Number"
## [31] "Parameter Value[Mass analyzer]"
## [32] "Term Source REF"
## [33] "Term Accession Number"
## [34] "MS Assay Name"
## [35] "Raw Spectral Data File"
## [36] "Protocol REF"
## [37] "Normalization Name"
## [38] "Derived Spectral Data File"
## [39] "Protocol REF"
## [40] "Data Transformation Name"
## [41] "Metabolite Assignment File"
```

MS data files are generally provided in a column named `"Derived Spectral Data File"` but sometimes they are also listed in a column named `"Raw Spectral Data File"`. Note that providing MS data files is not absolutely mandatory, thus, for
some data sets no MS data files might be available. Below we list the content of
these data columns.

```
a[, c("Raw Spectral Data File", "Derived Spectral Data File")]
```

```
##    Raw Spectral Data File Derived Spectral Data File
## 1        FILES/MN063A.cdf                         NA
## 2        FILES/MN063B.cdf                         NA
## 3        FILES/MN063C.cdf                         NA
## 4        FILES/CS063A.cdf                         NA
## 5        FILES/CS063B.cdf                         NA
## 6        FILES/CS063C.cdf                         NA
## 7        FILES/AM063A.cdf                         NA
## 8        FILES/AM063B.cdf                         NA
## 9        FILES/AM063C.cdf                         NA
## 10       FILES/MN073A.cdf                         NA
## 11       FILES/MN073B.cdf                         NA
## 12       FILES/MN073C.cdf                         NA
## 13       FILES/CS073A.cdf                         NA
## 14       FILES/CS073B.cdf                         NA
## 15       FILES/CS073C.cdf                         NA
## 16       FILES/AM073A.cdf                         NA
## 17       FILES/AM073B.cdf                         NA
## 18       FILES/AM073C.cdf                         NA
## 19       FILES/MN083A.cdf                         NA
## 20       FILES/MN083B.cdf                         NA
## 21       FILES/MN083C.cdf                         NA
## 22       FILES/CS083A.cdf                         NA
## 23       FILES/CS083B.cdf                         NA
## 24       FILES/CS083C.cdf                         NA
## 25       FILES/AM083A.cdf                         NA
## 26       FILES/AM083B.cdf                         NA
## 27       FILES/AM083C.cdf                         NA
```

For this particular data set the MS data files are provided in the `"Raw Spectral Data File"` column. These files are in CDF format and can hence be
loaded using the `MsBackendMetaboLights` backend into R as a `Spectra` object
(`MsBackendMetaboLights` directly extends *Spectra*’s `MsBackendMzR` backend and
therefore supports import of MS data files in *mzML*, *CDF* or *mzXML*
formats). By default, all MS data files of all assays would be retrieved, but in
our example below we restrict to few data files to reduce the amount of data
that needs to be downloaded. To this end we define a pattern matching the file
name of only some data files using the `filePattern` parameter. Alternatively,
for data sets with more than one assay, it would also be possible to select MS
data files from one particular assay only using the `assayName` parameter. In
our case we load all MS data files that end with *63A.cdf*.

```
library(Spectra)

#' Load MS data files of one data set
s <- Spectra("MTBLS39", filePattern = "63A.cdf",
             source = MsBackendMetaboLights())
```

```
## Used data files from the assay's column "Raw Spectral Data File" since none were available in column "Derived Spectral Data File".
```

```
s
```

```
## MSn data (Spectra) with 1664 spectra in a MsBackendMetaboLights backend:
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            1  0.296384         1
## 2            1  6.206912         2
## 3            1 12.093056         3
## 4            1 17.942912         4
## 5            1 23.835072         5
## ...        ...       ...       ...
## 1660         1   2678.27       549
## 1661         1   2683.01       550
## 1662         1   2687.81       551
## 1663         1   2692.62       552
## 1664         1   2697.40       553
##  ... 37 more variables/columns.
##
## file(s):
## MN063A.cdf
## CS063A.cdf
## AM063A.cdf
```

This call now downloaded the files to the local cache and loaded these files as
a `Spectra` object. The downloading and caching of the data is handled by
Bioconductor’s *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)*. The local cache can thus be managed
directly using functionality from that package. Any subsequent loading of the
same data files will load the locally cached versions avoiding thus repetitive
download of the same data.

The message that is shown by the call above indicates that the MS data files
were not provided in the expected column (`"Derived Spectral Data File"`) but in
the column for raw data files.

The `Spectra` object with the MS data files of the MetaboLights data set enables
now any subsequent analysis of the data in R. On top of the spectra variables
and mass peak data values that are provided by the MS data files also additional
information related to the MetaboLights data set are available as specific
*spectra variables*. We list all available spectra variables of the data set
below.

```
spectraVariables(s)
```

```
##  [1] "msLevel"                    "rtime"
##  [3] "acquisitionNum"             "scanIndex"
##  [5] "dataStorage"                "dataOrigin"
##  [7] "centroided"                 "smoothed"
##  [9] "polarity"                   "precScanNum"
## [11] "precursorMz"                "precursorIntensity"
## [13] "precursorCharge"            "collisionEnergy"
## [15] "isolationWindowLowerMz"     "isolationWindowTargetMz"
## [17] "isolationWindowUpperMz"     "peaksCount"
## [19] "totIonCurrent"              "basePeakMZ"
## [21] "basePeakIntensity"          "electronBeamEnergy"
## [23] "ionisationEnergy"           "lowMZ"
## [25] "highMZ"                     "mergedScan"
## [27] "mergedResultScanNum"        "mergedResultStartScanNum"
## [29] "mergedResultEndScanNum"     "injectionTime"
## [31] "filterString"               "spectrumId"
## [33] "ionMobilityDriftTime"       "scanWindowLowerLimit"
## [35] "scanWindowUpperLimit"       "mtbls_id"
## [37] "mtbls_assay_name"           "derived_spectral_data_file"
```

The MetaboLights-specific variables are `"mtbls_id"`, `"mtbls_assay_name"` and
`"derived_spectral_data_file"` providing the MetaboLights ID of the data set,
the assay/method with which the data files were generated and the original file
path/name of the data files on the MetaboLights ftp server.

```
spectraData(s, c("mtbls_id", "mtbls_assay_name",
                 "derived_spectral_data_file"))
```

```
## DataFrame with 1664 rows and 3 columns
##         mtbls_id       mtbls_assay_name derived_spectral_data_file
##      <character>            <character>                <character>
## 1        MTBLS39 a_MTBLS39_the_plasti..           FILES/MN063A.cdf
## 2        MTBLS39 a_MTBLS39_the_plasti..           FILES/MN063A.cdf
## 3        MTBLS39 a_MTBLS39_the_plasti..           FILES/MN063A.cdf
## 4        MTBLS39 a_MTBLS39_the_plasti..           FILES/MN063A.cdf
## 5        MTBLS39 a_MTBLS39_the_plasti..           FILES/MN063A.cdf
## ...          ...                    ...                        ...
## 1660     MTBLS39 a_MTBLS39_the_plasti..           FILES/AM063A.cdf
## 1661     MTBLS39 a_MTBLS39_the_plasti..           FILES/AM063A.cdf
## 1662     MTBLS39 a_MTBLS39_the_plasti..           FILES/AM063A.cdf
## 1663     MTBLS39 a_MTBLS39_the_plasti..           FILES/AM063A.cdf
## 1664     MTBLS39 a_MTBLS39_the_plasti..           FILES/AM063A.cdf
```

These variables can be used to link the individual spectra back to the original
sample (e.g. through the *assay* and *sample* tables of the MetaboLights data
set.

The `mtbls_sync()` function can be used to *synchronize* the local content of a
`MsBackendMetaboLights`. This function checks if all data files of the backend
are available locally and eventually downloads and caches missing files.

```
mtbls_sync(s@backend)
```

```
## Used data files from the assay's column "Raw Spectral Data File" since none were available in column "Derived Spectral Data File".
```

```
## MsBackendMetaboLights with 1664 spectra
##        msLevel     rtime scanIndex
##      <integer> <numeric> <integer>
## 1            1  0.296384         1
## 2            1  6.206912         2
## 3            1 12.093056         3
## 4            1 17.942912         4
## 5            1 23.835072         5
## ...        ...       ...       ...
## 1660         1   2678.27       549
## 1661         1   2683.01       550
## 1662         1   2687.81       551
## 1663         1   2692.62       552
## 1664         1   2697.40       553
##  ... 37 more variables/columns.
##
## file(s):
## MN063A.cdf
## CS063A.cdf
## AM063A.cdf
```

Also, it is possible to *manually* cache and download data files from
MetaboLights using the `mtbls_sync_data_files()` function. This function
evaluates if the respective data files are already cached and, if so, does not
download them again. Below we use this retrieve the local storage information on
one of the data files of the MetaboLights data set *MTBLS39*:

```
res <- mtbls_sync_data_files("MTBLS39", fileName = "AM063A.cdf")
```

```
## Used data files from the assay's column "Raw Spectral Data File" since none were available in column "Derived Spectral Data File".
```

```
res
```

```
##      rid mtbls_id
## 1 BFC756  MTBLS39
##                                                                                           mtbls_assay_name
## 1 a_MTBLS39_the_plasticity_of_the_grapevine_berry_transcriptome_metabolite_profiling_mass_spectrometry.txt
##   derived_spectral_data_file                                             rpath
## 1           FILES/AM063A.cdf /home/biocbuild/.cache/R/BiocFileCache/AM063A.cdf
```

The `mtbls_cached_data_files()` function can be used to inspect and list locally
cached MetaboLights data files. This function does not require an active
internet connection since only local content is queried. With the default
settings, a `data.frame` with all available data files is returned.

```
mtbls_cached_data_files()
```

```
##        rid mtbls_id
## 354 BFC756  MTBLS39
##                                                                                             mtbls_assay_name
## 354 a_MTBLS39_the_plasticity_of_the_grapevine_berry_transcriptome_metabolite_profiling_mass_spectrometry.txt
##     derived_spectral_data_file
## 354           FILES/AM063A.cdf
##                                                 rpath
## 354 /home/biocbuild/.cache/R/BiocFileCache/AM063A.cdf
```

Locally cached files for a MetaboLights data set can be removed using the
`mtbls_delete_cache()` function providing the ID of the MetaboLights data set
for which local data files should be removed.

# 4 Session information

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
## [1] MsBackendMetaboLights_1.4.2 Spectra_1.20.0
## [3] BiocParallel_1.44.0         S4Vectors_0.48.0
## [5] BiocGenerics_0.56.0         generics_0.1.4
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3         sass_0.4.10            MsCoreUtils_1.22.0
##  [4] RSQLite_2.4.3          hms_1.1.4              digest_0.6.37
##  [7] magrittr_2.0.4         evaluate_1.0.5         bookdown_0.45
## [10] fastmap_1.2.0          blob_1.2.4             jsonlite_2.0.0
## [13] progress_1.2.3         ProtGenerics_1.42.0    mzR_2.44.0
## [16] DBI_1.2.3              BiocManager_1.30.26    purrr_1.2.0
## [19] codetools_0.2-20       httr2_1.2.1            jquerylib_0.1.4
## [22] cli_3.6.5              crayon_1.5.3           rlang_1.1.6
## [25] dbplyr_2.5.1           Biobase_2.70.0         bit64_4.6.0-1
## [28] withr_3.0.2            cachem_1.1.0           yaml_2.3.10
## [31] tools_4.5.1            parallel_4.5.1         memoise_2.0.1
## [34] dplyr_1.1.4            ncdf4_1.24             filelock_1.0.3
## [37] curl_7.0.0             vctrs_0.6.5            R6_2.6.1
## [40] BiocFileCache_3.0.0    lifecycle_1.0.4        fs_1.6.6
## [43] IRanges_2.44.0         bit_4.6.0              clue_0.3-66
## [46] MASS_7.3-65            cluster_2.1.8.1        pkgconfig_2.0.3
## [49] bslib_0.9.0            pillar_1.11.1          Rcpp_1.1.0
## [52] glue_1.8.0             xfun_0.54              tibble_3.3.0
## [55] tidyselect_1.2.1       knitr_1.50             htmltools_0.5.8.1
## [58] rmarkdown_2.30         compiler_4.5.1         prettyunits_1.2.0
## [61] MetaboCoreUtils_1.18.0
```