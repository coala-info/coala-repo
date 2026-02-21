# Data Generation for topdownr

Pavel V. Shliaha1, Sebastian Gibb2 and Ole Nørregaard Jensen1

1Department of Biochemistry and Molecular Biology, University of Southern Denmark, Denmark.
2Department of Anesthesiology and Intensive Care, University Medicine Greifswald, Germany.

#### 30 October 2025

#### Abstract

This vignette describes the setup and the data preparation to create the input files needed for the analysis with the functionality the `topdownr` package.

#### Package

topdownr 1.32.0

# Foreword

*[topdownr](https://bioconductor.org/packages/3.22/topdownr)* is free and
open-source software. If you use it, please support the project by
citing it in publications:

P.V. Shliaha, S. Gibb, V. Gorshkov, M.S. Jespersen, G.R. Andersen, D. Bailey, J. Schwartz, S. Eliuk, V. Schwämmle, and O.N. Jensen. 2018. Maximizing Sequence Coverage in Top-Down Proteomics By Automated Multi-modal Gas-phase Protein Fragmentation. Analytical Chemistry. DOI: [10.1021/acs.analchem.8b02344](https://doi.org/10.1021/acs.analchem.8b02344)

# Questions and bugs

For bugs, typos, suggestions or other questions, please file an issue
in our tracking system (<https://github.com/sgibb/topdownr/issues>)
providing as much information as possible, a reproducible example and
the output of `sessionInfo()`.

If you don’t have a GitHub account or wish to reach a broader audience
for general questions about proteomics analysis using R, you may want
to use the Bioconductor support site: <https://support.bioconductor.org/>.

# 1 Introduction

## 1.1 The `topdownr` Data Generation Workflow

# 2 Installation of Additional Software

## 2.1 Setup the Thermo Software

To create methods the user will have to install and modify Orbitrap Fusion
LUMOS workstation first:

1. Request `TribridSeriesWorkstationSetup-v3.2.exe` from Thermo Scientific.
2. Install the workstation by running `TribridSeriesWorkstationSetup-v3.2.exe`.

## 2.2 Setup XMLMethodChanger

*XMLMethodChanger* is needed to convert the xml methods into `.meth` files. It
could be found at <https://github.com/thermofisherlsms/meth-modifications>
The user has to download and compile it himself (or request it from Thermo
Scientific as well). You would need at least the *3.2 beta* version.

## 2.3 Setup Operating System

In order to use *XMLMethodChanger* the operating system has to use the `.` (dot)
as decimal mark and the `,` (comma) as digit group separator (one thousand dot
two should be formated as `1,000.2`).

In *Windows 7* the settings are located at
`Windows Control Panel > Region and Language > Formats`.
Choose *English (USA)* here or use the *Additional settings* button to change it
manually.

## 2.4 Setup ScanHeadsman

After data aquisition `topdownr` would need the header information from the
`.raw` files.
Therefore the *ScanHeadsman* software is used. It could be
downloaded from <https://bitbucket.org/caetera/scanheadsman>

It requires Microsoft **.NET 4.5** or later (it is often preinstalled on a
typical modern Windows or could be found in Microsoft’s Download Center, e.g.
<https://www.microsoft.com/en-us/download/details.aspx?id=30653>).
Additionally you would need Thermo’s *MS File Reader* which could be downloaded
free of charge (but you have to register) from the Thermo FlexNet website:
<https://thermo.flexnetoperations.com/>

*ScanHeadsman* was created by Vladimir Gorshkov vgor@bmb.sdu.dk.

# 3 Creating Methods

Importantly, *XMLmethodChanger* does not create methods *de novo*, but modifies
pre-existing methods (supplied with *XMLMethodChanger*) using modifications
described in XML files. Thus the whole process of creating user specified
methods consists of 2 parts:

1. Construction of XML files with all possible combination of fragmentation
   parameters (see `topdownr::createExperimentsFragmentOptimisation`,
   and `topdownr::writeMethodXmls` below).
2. Submitting the constructed XML files together with a template
   `.meth` file to *XMLmethodChanger*.

We choose to use targeted MS2 scans (TMS2) as a way to store the
fragmentation parameters.
Each TMS2 is stored in a separate experiment. Experiments do not overlap.

![](data:image/png;base64...)

Method Editor

# 4 Data preparation with `topdownr`

Shown below is the process of creating XML files and using them to modify the
*TMS2IndependentTemplateForTD.meth* template file.

```
library("topdownr")

## Create MS1 settings
ms1 <- expandMs1Conditions(
    FirstMass=400,
    LastMass=1200,
    Microscans=as.integer(10)
)

## Set TargetMass
targetMz <- cbind(mz=c(560.6, 700.5, 933.7), z=rep(1, 3))

## Set common settings
common <- list(
    OrbitrapResolution="R120K",
    IsolationWindow=1,
    MaxITTimeInMS=200,
    Microscans=as.integer(40),
    AgcTarget=c(1e5, 5e5, 1e6)
)

## Create settings for different fragmentation conditions
cid <- expandTms2Conditions(
    MassList=targetMz,
    common,
    ActivationType="CID",
    CIDCollisionEnergy=seq(7, 35, 7)
)
hcd <- expandTms2Conditions(
    MassList=targetMz,
    common,
    ActivationType="HCD",
    HCDCollisionEnergy=seq(7, 35, 7)
)
etd <- expandTms2Conditions(
    MassList=targetMz,
    common,
    ActivationType="ETD",
    ETDReactionTime=as.double(1:2)
)
etcid <- expandTms2Conditions(
    MassList=targetMz,
    common,
    ActivationType="ETD",
    ETDReactionTime=as.double(1:2),
    ETDSupplementalActivation="ETciD",
    ETDSupplementalActivationEnergy=as.double(1:2)
)
uvpd <- expandTms2Conditions(
    MassList=targetMz,
    common,
    ActivationType="UVPD"
)

## Create experiments with all combinations of the above settings
## for fragment optimisation
exps <- createExperimentsFragmentOptimisation(
    ms1=ms1, cid, hcd, etd, etcid, uvpd,
    groupBy=c("AgcTarget", "replication"), nMs2perMs1=10, scanDuration=0.5,
    replications=2, randomise=TRUE
)

## Write experiments to xml files
writeMethodXmls(exps=exps)

## Run XMLMethodChanger
runXmlMethodChanger(
    modificationXml=list.files(pattern="^method.*\\.xml$"),
    templateMeth="TMS2IndependentTemplateForTD.meth",
    executable="path\\to\\XmlMethodChanger.exe"
)
```

# 5 Data Acquisition

After setting up direct infusion make sure that MS1 spectrum produces
expected protein mass after deconvolution by *Xtract*.
Shown below is a deconvoluted MS1 spectrum for myoglobin.
The dominant mass corresponds to myoglobin with Met removed.

![](data:image/png;base64...)

Xtract myoglobin

# 6 Data Preparation

Prior to `R` analysis of protein fragmentation data we have to convert the
`.raw` files.

## 6.1 Extracting Header Information

Some of the information
(SpectrumId, Ion Injection Time (ms), Orbitrap Resolution, targeted Mz,
ETD reaction time, CID activation and HCD activation) is stored in scan
headers, while other (ETD reagent target and AGC target) is only available
in method table.

You can run *ScanHeadsman* from the commandline
(`ScanHeadsman.exe --noMS --methods:CSV`) or use the function provided by
`topdownr`:

```
runScanHeadsman(
    path="path\\to\\raw-files",
    executable="path\\to\\ScanHeadsman.exe"
)
```

*ScanHeadsman* will generate a `.txt` (scan header table) and a `.csv` (method
table) file for each `.raw` file.

## 6.2 Convert .raw files into mzML

The spectra have to be charge state deconvoluted with *Xtract* node in
*Proteome Discoverer 2.1*. The software returns deconvoluted spectra in
mzML format.

![](data:image/png;base64...)

Proteome Discoverer

Once a `.csv`, `.txt`, and `.mzML` file for each `.raw` have been produced we
can start the analysis using `topdownr`.
Please see *analysis* vignette (`vignette("analysis", package="topdownr")`) for
an example.

# 7 Session Info

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
##  [1] ggplot2_4.0.0       ranger_0.17.0       topdownrdata_1.31.0
##  [4] topdownr_1.32.0     Biostrings_2.78.0   Seqinfo_1.0.0
##  [7] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
## [10] ProtGenerics_1.42.0 BiocGenerics_0.56.0 generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rlang_1.1.6                 magrittr_2.0.4
##  [3] clue_0.3-66                 matrixStats_1.5.0
##  [5] compiler_4.5.1              vctrs_0.6.5
##  [7] reshape2_1.4.4              stringr_1.5.2
##  [9] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
## [11] crayon_1.5.3                fastmap_1.2.0
## [13] magick_2.9.0                labeling_0.4.3
## [15] rmarkdown_2.30              preprocessCore_1.72.0
## [17] tinytex_0.57                purrr_1.1.0
## [19] xfun_0.53                   MultiAssayExperiment_1.36.0
## [21] cachem_1.1.0                jsonlite_2.0.0
## [23] DelayedArray_0.36.0         BiocParallel_1.44.0
## [25] parallel_4.5.1              cluster_2.1.8.1
## [27] R6_2.6.1                    bslib_0.9.0
## [29] stringi_1.8.7               RColorBrewer_1.1-3
## [31] limma_3.66.0                GenomicRanges_1.62.0
## [33] jquerylib_0.1.4             Rcpp_1.1.0
## [35] bookdown_0.45               SummarizedExperiment_1.40.0
## [37] iterators_1.0.14            knitr_1.50
## [39] BiocBaseUtils_1.12.0        Matrix_1.7-4
## [41] igraph_2.2.1                tidyselect_1.2.1
## [43] dichromat_2.0-0.1           abind_1.4-8
## [45] yaml_2.3.10                 doParallel_1.0.17
## [47] codetools_0.2-20            affy_1.88.0
## [49] lattice_0.22-7              tibble_3.3.0
## [51] plyr_1.8.9                  Biobase_2.70.0
## [53] withr_3.0.2                 S7_0.2.0
## [55] evaluate_1.0.5              Spectra_1.20.0
## [57] pillar_1.11.1               affyio_1.80.0
## [59] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [61] foreach_1.5.2               MSnbase_2.36.0
## [63] MALDIquant_1.22.3           ncdf4_1.24
## [65] scales_1.4.0                glue_1.8.0
## [67] lazyeval_0.2.2              tools_4.5.1
## [69] mzID_1.48.0                 QFeatures_1.20.0
## [71] vsn_3.78.0                  mzR_2.44.0
## [73] fs_1.6.6                    XML_3.99-0.19
## [75] grid_4.5.1                  impute_1.84.0
## [77] tidyr_1.3.1                 MsCoreUtils_1.22.0
## [79] PSMatch_1.14.0              cli_3.6.5
## [81] S4Arrays_1.10.0             dplyr_1.1.4
## [83] AnnotationFilter_1.34.0     pcaMethods_2.2.0
## [85] gtable_0.3.6                sass_0.4.10
## [87] digest_0.6.37               SparseArray_1.10.0
## [89] farver_2.1.2                htmltools_0.5.8.1
## [91] lifecycle_1.0.4             statmod_1.5.1
## [93] MASS_7.3-65
```

# 8 References