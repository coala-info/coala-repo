# AdductomicsR workflow

#### Josie Hayes

#### October 29, 2025

# Getting Started

```
#ensure you have mzR installed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mzR", version = "3.8")

# install the package directly from Github
library(devtools)
devtools::install_github("JosieLHayes/adductomicsR")

#install the data package containing the data
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ExperimentHub", version = "3.9")

#or download the packages and install from source
library(devtools)
devtools::install("path_to_dir/adductomicsR")
devtools::install("path_to_dir/adductData")
```

After installation of the adductomics package and all dependencies attach the adductomics package by typing (copying and pasting) this line of code into the R console and hitting enter:

```
# load the package
library(adductomicsR)
library(adductData)
library(ExperimentHub)
```

We have provided 2 mzXML files for use in this vignette in adductData.

# Preparation of the data

Mass drift correction: Usually mass drift is corrected using lock masses on the mass spectrometer. If this has not been done a python script is provided in the directory in which the package is saved on your computer at /inst/extdata/thermo\_MassDriftCalc.py and can be launched from within python using (replace the path to the python script in your system): `exec(open(“thermo_MassDriftCalc.py“).read())`

# Retention time correction

Each sample is corrected for retention time drift using the rtDevModeling function. To run this with the default parameters enter the path of the directory containing your mzXML files and the run order file (order in which samples were run). For further information on parameters see ??rtDevModelling. An example run order file is available in inst/extdata (within the directory where the package is saved on your computer) and 2 mzXML files are available in adductData/ExperimentHub.These files will be used in this vignette automatically.

Download the mzXML files from ExperimentHub for use in this vignette. They must have .mzXML to be recognized by the package so they are renamed as well.

```
eh  = suppressMessages(suppressWarnings(ExperimentHub::ExperimentHub()))
temp = suppressMessages(suppressWarnings(
AnnotationHub::query(eh, 'adductData')))
```

```
suppressMessages(suppressWarnings(temp[['EH1957']])) #first mzXML file
```

```
##                                                       EH1957
## "/home/biocbuild/.cache/R/ExperimentHub/3eb4ea393a48b2_1957"
```

```
file.rename(cache(temp["EH1957"]), file.path(hubCache(temp),
                                             'ORB35017.mzXML'))
```

```
## [1] TRUE
```

```
temp[['EH1958']] #second mzXML file
```

```
## see ?adductData and browseVignettes('adductData') for documentation
```

```
## downloading 1 resources
```

```
## retrieving 1 resource
```

```
## loading from cache
```

```
##                                                       EH1958
## "/home/biocbuild/.cache/R/ExperimentHub/3eb4ea62ef3f86_1958"
```

```
file.rename(cache(temp["EH1958"]), file.path(hubCache(temp), 'ORB35022.mzXML'))
```

```
## [1] TRUE
```

```
rtDevModelling(
  MS2Dir = hubCache(temp),
  nCores=4,
  runOrder =paste0(system.file("extdata",
                               package ="adductomicsR"),'/runOrder.csv')
  )
```

# Identify adducts

The specSimPepId function detects adducts present on the peptide. To run this with the default parameters (the largest triply charged peptide of human serum albumin) enter the path of your mzxml files and rtDevModels object. For further information on running this with different peptides see ??specSimPepId. This produces MS2 spectra plots, each in a separate directory for each sample. A plot of the model spectrum is also saved in the mzXML files directory for comparison. The spectra are grouped based on the mz and RT windows, and plots of these groups are also provided based on the raw RT and adjusted RT. These plots can be used to determine whether multiple groups pertain to the same peak.

```
specSimPepId(
  MS2Dir = hubCache(temp),
  nCores=4,
  rtDevModels =paste0(hubCache(temp),'/rtDevModels.RData')
  )
```

# Generate a target table for quantification

A list of the adducts for quantification and their monoisotopic mass (MIM), retention time (RT), peptide and charge is generated using the following command. Substitute the file path of the allResults file to the location of your allResults file from the previous step.

```
generateTargTable(
  allresultsFile=paste0(system.file("extdata",package =
  "adductomicsR"),'/allResults_ALVLIAFAQYLQQCPFEDHVK_example.csv'),
  csvDir=tempdir(check = FALSE)
  )
```

It is recommended that the allGroups plot ( m/z vs RT) is used to ensure that the adducts in the target table do not pertain to the same peak, as the quantification step can be computationally intensive.

# Quantify adducts

See ??adductQuant for an explanation on the parameters for this function. To use your target table produced in the previous step, alter the value in the ‘targTable’ option to the path of your target table. Similarly replaced the path to the directory of your own mzXML files in filePaths (set as “Users/Documents/mzXMLfiles” here.

```
adductQuant(
  nCores=2,
  targTable=paste0(system.file("extdata",
                               package="adductomicsR"),
                               '/exampletargTable2.csv'),
  intStdRtDrift=30,
  rtDevModels= paste0(hubCache(temp),'/rtDevModels.RData'),
  filePaths=list.files(hubCache(temp),pattern=".mzXML",
                       all.files=FALSE,full.names=TRUE),
  quantObject=NULL,
  indivAdduct=NULL,
  maxPpm=5,
  minSimScore=0.8,
  spikeScans=1,
  minPeakHeight=100,
  maxRtDrift=20,
  maxRtWindow=240,
  isoWindow=80,
  hkPeptide='LVNEVTEFAK',
  gaussAlpha=16
  )
```

# Extract the results from the AdductQuantif Object

It is recommended that spectra for each of the adducts found are checked manually using LC-MS software, either at this step or before quantification.

To load your adductquantif object set the path to the file on your system. In the example it assumes the file is present in your working directory.

```
#load the adductquantif object
load(paste0(hubCache(temp),"/adductQuantResults.Rda"))

#produce a peakTable from the Adductquantif object and save to a temporary
#directory
suppressMessages(suppressWarnings(outputPeakTable(object=
    object, outputDir=tempdir(check = FALSE))))
```

# Filter the results from the peak area table

Mass spectrometry data is inherently noisy, and the filterAdductTable() function will filter out samples and adducts based on set thresholds. It is recommended to use this filter function to remove adducts that have many missing values and samples where the housekeeping peptide is weak, suggestive of misintegration. Substitute the name of the peaklist file with the path and the name of your peaklist file produced in the previous step.

```
filterAdductTable(
  paste0(tempdir(check = FALSE),"/adductQuantif_peakList_", Sys.Date(), ".csv")
  )
```

```
#session info
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
## [1] adductomicsR_1.26.0 ExperimentHub_3.0.0 AnnotationHub_4.0.0
## [4] BiocFileCache_3.0.0 dbplyr_2.5.1        BiocGenerics_0.56.0
## [7] generics_0.1.4      adductData_1.25.0
##
## loaded via a namespace (and not attached):
##  [1] ade4_1.7-23          tidyselect_1.2.1     dplyr_1.1.4
##  [4] blob_1.2.4           filelock_1.0.3       Biostrings_2.78.0
##  [7] fastmap_1.2.0        promises_1.4.0       digest_0.6.37
## [10] lifecycle_1.0.4      cluster_2.1.8.1      processx_3.8.6
## [13] KEGGREST_1.50.0      RSQLite_2.4.3        magrittr_2.0.4
## [16] kernlab_0.9-33       compiler_4.5.1       rlang_1.1.6
## [19] sass_0.4.10          tools_4.5.1          yaml_2.3.10
## [22] knitr_1.50           htmlwidgets_1.6.4    bit_4.6.0
## [25] mclust_6.1.1         curl_7.0.0           xml2_1.4.1
## [28] plyr_1.8.9           websocket_1.4.4      withr_3.0.2
## [31] purrr_1.1.0          nnet_7.3-20          grid_4.5.1
## [34] stats4_4.5.1         iterators_1.0.14     fpc_2.2-13
## [37] MASS_7.3-65          prabclus_2.3-4       pastecs_1.4.2
## [40] cli_3.6.5            rmarkdown_2.30       crayon_1.5.3
## [43] otel_0.2.0           robustbase_0.99-6    reshape2_1.4.4
## [46] httr_1.4.7           chromote_0.5.1       DBI_1.2.3
## [49] cachem_1.1.0         stringr_1.5.2        modeltools_0.2-24
## [52] rvest_1.0.5          parallel_4.5.1       AnnotationDbi_1.72.0
## [55] BiocManager_1.30.26  XVector_0.50.0       vctrs_0.6.5
## [58] boot_1.3-32          jsonlite_2.0.0       IRanges_2.44.0
## [61] S4Vectors_0.48.0     bit64_4.6.0-1        foreach_1.5.2
## [64] diptest_0.77-2       jquerylib_0.1.4      glue_1.8.0
## [67] DEoptimR_1.1-4       ps_1.9.1             codetools_0.2-20
## [70] DT_0.34.0            stringi_1.8.7        later_1.4.4
## [73] BiocVersion_3.22.0   tibble_3.3.0         pillar_1.11.1
## [76] rappdirs_0.3.3       htmltools_0.5.8.1    Seqinfo_1.0.0
## [79] R6_2.6.1             httr2_1.2.1          evaluate_1.0.5
## [82] Biobase_2.70.0       lattice_0.22-7       png_0.1-8
## [85] memoise_2.0.1        bslib_0.9.0          class_7.3-23
## [88] Rcpp_1.1.0           flexmix_2.3-20       xfun_0.53
## [91] pkgconfig_2.0.3
```