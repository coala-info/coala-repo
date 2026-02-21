# Using R for proteomics data analysis

Laurent Gatto, Lisa Breckels, Vlad Petyuk, Thomas Lin Pedersen and Sebastian Gibb

#### 4 November 2025

#### Abstract

This is the companion vignette to the ‘Visualisation of proteomics data using R and Bioconductor’ manuscript that presents an overview of R and Bioconductor software for mass spectrometry and proteomics data. It provides the code to reproduce the figures in the paper.

#### Package

RforProteomics 1.48.0

# 1 Note

For a more **up-to-date overview** of what is available for mass
spectrometry-based proteomics in R, please see the [*R for Mass
Spectrometry* initiative](https://www.rformassspectrometry.org/) in
general, and the [book](https://rformassspectrometry.github.io/book/)
in particular.

# 2 Introduction

This document illustrates some existing R infrastructure for the
analysis of proteomics data. It presents the code for the use cases
taken from (Gatto and Christoforou [2013](#ref-R4Prot2013), Gatto:2015). A pre-print of (Gatto and Christoforou [2013](#ref-R4Prot2013))
available on [arXiv](http://arxiv.org/abs/1305.6559) and (Gatto et al. [2015](#ref-Gatto:2015))
is [open access](http://onlinelibrary.wiley.com/doi/10.1002/pmic.201400392/full).

There are however numerous additional R resources distributed by
the [Bioconductor](http://www.bioconductor.org)
and [CRAN](http://cran.r-project.org/web/packages/) repositories, as
well as packages hosted on personal websites. Section
[9](#sec:packages) tries to provide a wider picture of available
packages, without going into details.

> **NB**: I you are interested in R packages for mass
> spectrometry-based proteomics and metabolomics, see also the [R for
> Mass Spectrometry initiative](https://www.rformassspectrometry.org/)
> packages and the [tutorial
> book](https://rformassspectrometry.github.io/docs/). It provides
> more up-to-date packages and solutions for several of the tasks
> described below.

## 2.1 General R resources

The reader is expected to have basic R knowledge to find the document
helpful. There are numerous R introductions freely available, some of
which are listed below.

From the R project web-page:

* *An Introduction to R* is based on the former *Notes on R*, gives an
  introduction to the language and how to use R for doing statistical
  analysis and graphics
  ([html](http://cran.r-project.org/doc/manuals/R-intro.html) and
  [pdf](http://cran.r-project.org/doc/manuals/R-intro.pdf).
* Several introductory tutorials in the
  [contributed documentation](http://cran.r-project.org/other-docs.html) section.
* The [TeachingMaterial repository](https://github.com/lgatto/TeachingMaterial)
  contains several sets of slides and vignettes about R programming.

Relevant background on the R software and its application to
computational biology in general and proteomics in particular can also
be found in (Gatto and Christoforou [2013](#ref-R4Prot2013)). For details about the Bioconductor
project, the reader is referred to (Gentleman et al. [2004](#ref-Gentleman2004)).

## 2.2 Bioconductor resources

The Bioconductor offers many educational resources on
its [help page](http://bioconductor.org/help/), in addition the
package’s vignettes (vignettes are a requirement for Bioconductor
packages). We want to draw the attention to the Bioconductor work
flows that offer a cross-package overview about a specific topic. In
particular, there is now
a
[*Mass spectrometry and proteomics data analysis*](http://bioconductor.org/help/workflows/proteomics/) work
flow.

## 2.3 Getting help

All R packages come with ample documentation. Every command
(function, class or method) a user is susceptible to use is
documented. The documentation can be accessed by preceding the command
by a `?` in the R console. For example, to obtain help about
the `library` function, that will be used in the next
section, one would type `?library`. In addition, all
Bioconductor packages come with at least one vignette (this document
is the vignette that comes with the *[RforProteomics](https://bioconductor.org/packages/3.22/RforProteomics)*
package), a document that combines text and R code that is executed
before the pdf is assembled. To look up all vignettes that come with a
package, say *[RforProteomics](https://bioconductor.org/packages/3.22/RforProteomics)* and then open the vignette of
interest, one uses the `vignette` function as illustrated
below. More details can be found in `?vignette`.

```
## list all the vignettes in the RforProteomics package
vignette(package = "RforProteomics")
## Open the vignette called RforProteomics
vignette("RforProteomics", package = "RforProteomics")
## or just
vignette("RforProteomics")
```

R has several [mailing lists](http://www.r-project.org/mail.html). The
most relevant here being the main `R-help` list, *for discussion about
problem and solutions using R*, ideal for general R content and is not
suitable for bioinformatics or proteomics questions. Bioconductor also
offers several resources dedicated to bioinformatics matters and
Bioconductor packages, in particular the
main [Bioconductor support forum](https://support.bioconductor.org/)
for Bioconductor-related queries.

It is advised to read and comply to
the [posting guides](http://www.r-project.org/posting-guide.html)
(and [here](http://bioconductor.org/help/mailing-list/posting-guide/)
to maximise the chances to obtain good responses. It is important to
specify the software versions using the `sessionInfo()` functions (see
an example output at the end of this document. It the question
involves some code, make sure to isolate the relevant portion and
report it with your question, trying to make
your
[code/example reproducible](https://github.com/hadley/devtools/wiki/Reproducibility%3E).

## 2.4 Installation

The package should be installed using as described below:

```
## only first time you install Bioconductor packages
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
## else
library("BiocManager")
BiocManager::install("RforProteomics")
```

To install all dependencies and reproduce the code in the vignette,
replace the last line in the code chunk above with:)

```
BiocManager::install("RforProteomics", dependencies = TRUE)
```

Finally, the package can be loaded with

```
library("RforProteomics")
```

See also the *[RforProteomics](https://bioconductor.org/packages/3.22/RforProteomics)*
[web page](http://lgatto.github.io/RforProteomics/) for more
information on installation.

## 2.5 External dependencies

Some packages used in the document depend on external libraries that
need to be installed prior to the R packages:

* *[mzR](https://bioconductor.org/packages/3.22/mzR)* depends on
  the [Common Data Format](http://cdf.gsfc.nasa.gov/) (CDF) to
  CDF-based raw mass-spectrometry data. On Linux, the `libcdf` library
  is required. On Debian-based systems, for instance, one needs to
  install the `libnetcdf-dev` package.
* several packages depend on the *[XML](https://CRAN.R-project.org/package%3DXML)* package which
  requires the `libxml2` infrastructure on Linux. On Debian-based
  systems, one needs to install `libxml2-dev`.
* *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* performs on-line requests using
  the [`curl`](http://curl.haxx.se/) infrastructure. On Debian-based
  systems, you one needs to install `libcurl-dev` or
  `libcurl4-openssl-dev`.
* *[MSGFplus](https://bioconductor.org/packages/3.22/MSGFplus)* is based on the `MS-GF+` java program and
  thus requires [Java 1.7](https://java.com) in order to work.

## 2.6 Obtaining the code

The code in this document describes all the examples presented in
(Gatto and Christoforou [2013](#ref-R4Prot2013)) and can be copy, pasted and executed. It is however more
convenient to have it in a separate text file for better interaction
with R to easily modify and explore it. This can be achieved with the
`Stangle` function. One needs the Sweave source of this document (a
document combining the narration and the R code) and the `Stangle`
then specifically extracts the code chunks and produces a clean R
source file. If the package is installed, the following code chunk
will direct you to the `RforProteomics.R` file containing all the
annotated source code contained in this document.

```
## gets the vignette source
rfile <- system.file("doc/RforProteomics.R",
                     package = "RforProteomics")
rfile
```

```
## [1] ""
```

## 2.7 Prepare the working environment

The packages that we will depend on to execute the examples will be
loaded in the respective sections. Here, we pre-load packages that
provide general functionality used throughout the document.

```
library("RColorBrewer") ## Color palettes
library("ggplot2")  ## Convenient and nice plotting
library("reshape2") ## Flexibly reshape data
```

# 3 Data standards and input/output

## 3.1 The mzR package

### 3.1.1 Raw MS data

The *[mzR](https://bioconductor.org/packages/3.22/mzR)* package (Chambers et al. [2012](#ref-Chambers2012)) provides a unified
interface to various mass spectrometry open formats. This code chunk,
taken from the `openMSfile` documentation, illustrated how
to open a connection to an raw data file. The example `mzML`
data is taken from the *[msdata](https://bioconductor.org/packages/3.22/msdata)* data package. The code
below would also be applicable to an `mzXML`, `mzData`
or `netCDF` file.

```
## load the required packages
library("mzR") ## the software package
library("msdata") ## the data package
## below, we extract the releavant example file
## from the local 'msdata' installation
filepath <- system.file("microtofq", package = "msdata")
file <- list.files(filepath, pattern="MM14.mzML",
                   full.names=TRUE, recursive = TRUE)
## creates a commection to the mzML file
mz <- openMSfile(file)
## demonstraction of data access
basename(fileName(mz))
```

```
## [1] "MM14.mzML"
```

```
runInfo(mz)
```

```
## $scanCount
## [1] 112
##
## $lowMz
## [1] 0
##
## $highMz
## [1] 0
##
## $dStartTime
## [1] 270.334
##
## $dEndTime
## [1] 307.678
##
## $msLevels
## [1] 1
##
## $startTimeStamp
## [1] NA
```

```
instrumentInfo(mz)
```

```
## $manufacturer
## [1] "Unknown"
##
## $model
## [1] "instrument model"
##
## $ionisation
## [1] "electrospray ionization"
##
## $analyzer
## [1] "mass analyzer type"
##
## $detector
## [1] "detector type"
##
## $software
## [1] "so_in_0 "
##
## $sample
## [1] "MM14_20uMsa_0"
##
## $source
## [1] ""
```

```
## once finished, it is good to explicitely
## close the connection
close(mz)
```

*[mzR](https://bioconductor.org/packages/3.22/mzR)* is used by other packages, like *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)*
(Gatto and Lilley [2012](#ref-Gatto2012)), *[TargetSearch](https://bioconductor.org/packages/3.22/TargetSearch)* (Cuadros-Inostroza et al. [2009](#ref-TargetSearch2009)) and
*[xcms](https://bioconductor.org/packages/3.22/xcms)* (Smith et al. [2006](#ref-Smith2006), Benton2008, Tautenhahn2008), that
provide a higher level abstraction to the data.

### 3.1.2 Identification data

The *[mzR](https://bioconductor.org/packages/3.22/mzR)* package also provides very fast access to
`mzIdentML` data by leveraging proteowizard’s `C++`
parser.

```
file <- system.file("mzid", "Tandem.mzid.gz", package="msdata")
mzid <- openIDfile(file)
mzid
```

```
## Identification file handle.
## Filename:  Tandem.mzid.gz
## Number of psms:  171
```

Once and `mzRident` identification file handle has been
established, various data and metadata can be extracted, as
illustrated below.

```
softwareInfo(mzid)
```

```
## [1] "xtandem x! tandem CYCLONE (2010.06.01.5) "
## [2] "ProteoWizard MzIdentML 3.0.21263 ProteoWizard"
```

```
enzymes(mzid)
```

```
##      name nTermGain cTermGain minDistance missedCleavages
## 1 Trypsin         H        OH           0               1
```

```
names(psms(mzid))
```

```
##  [1] "spectrumID"               "chargeState"
##  [3] "rank"                     "passThreshold"
##  [5] "experimentalMassToCharge" "calculatedMassToCharge"
##  [7] "sequence"                 "peptideRef"
##  [9] "modNum"                   "isDecoy"
## [11] "post"                     "pre"
## [13] "start"                    "end"
## [15] "DatabaseAccess"           "DBseqLength"
## [17] "DatabaseSeq"              "DatabaseDescription"
## [19] "spectrum.title"           "acquisitionNum"
```

```
head(psms(mzid))[, 1:13]
```

```
##   spectrumID chargeState rank passThreshold experimentalMassToCharge
## 1   index=12           3    1         FALSE                 903.7209
## 2  index=285           3    1         FALSE                 792.3792
## 3   index=83           3    1         FALSE                 792.5295
## 4   index=21           3    1         FALSE                 850.0782
## 5  index=198           3    1         FALSE                 527.2592
## 6   index=13           2    1         FALSE                 724.8816
##   calculatedMassToCharge                 sequence
## 1               903.4032  LCYIALDFDEEMKAAEDSSDIEK
## 2               792.3899   KDLYGNVVLSGGTTMYEGIGER
## 3               792.3899   KDLYGNVVLSGGTTMYEGIGER
## 4               849.7635 VIDENFGLVEGLMTTVHAATGTQK
## 5               527.2849          GVGGAIVLVLYDEMK
## 6               724.3771            HAVGGRYSSLLCK
##                                            peptideRef modNum isDecoy post pre
## 1 LCYIALDFDEEMKAAEDSSDIEK_15.9949@M$12;_57.0215@C$2;_      2   FALSE    S   K
## 2              KDLYGNVVLSGGTTMYEGIGER_15.9949@M$15;__      1   FALSE    L   R
## 3              KDLYGNVVLSGGTTMYEGIGER_15.9949@M$15;__      1   FALSE    L   R
## 4            VIDENFGLVEGLMTTVHAATGTQK_15.9949@M$13;__      1   FALSE    V   K
## 5                     GVGGAIVLVLYDEMK_15.9949@M$14;__      1   FALSE    R   R
## 6                       HAVGGRYSSLLCK__57.0215@C$12;_      1    TRUE    D   K
##   start
## 1   217
## 2   292
## 3   292
## 4   842
## 5   297
## 6   392
```

## 3.2 Handling MS2 identification data with *[mzID](https://bioconductor.org/packages/3.22/mzID)*

The *[mzID](https://bioconductor.org/packages/3.22/mzID)* package allows to load and manipulate MS2 data
in the `mzIdentML` format. The main `mzID` function
reads such a file and constructs an instance of class `mzID`.

```
library("mzID")
mzids <- list.files(system.file('extdata', package = 'mzID'),
                    pattern = '*.mzid', full.names = TRUE)
mzids
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/55merge_omssa.mzid"
## [2] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/55merge_tandem.mzid"
## [3] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/MPC_example_Multiple_search_engines.mzid"
## [4] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/Mascot_MSMS_example.mzid"
## [5] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/Mascot_MSMS_example1.0.mzid"
## [6] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/Mascot_NA_example.mzid"
## [7] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/Mascot_top_down_example.mzid"
## [8] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/Sequest_example_ver1.1.mzid"
## [9] "/home/biocbuild/bbs-3.22-bioc/R/site-library/mzID/extdata/mascot_pmf_example.mzid"
```

```
id <- mzID(mzids[1])
```

```
## reading 55merge_omssa.mzid... DONE!
```

```
id
```

```
## An mzID object
##
## Software used:   OMSSA (version: NA)
##
## Rawfile:         D:/TestSpace/NeoTestMarch2011/55merge.mgf
##
## Database:        D:/Software/Databases/Neospora_3rndTryp/Neo_rndTryp_3times.fasta
##
## Number of scans: 39
## Number of PSM's: 99
```

Multiple files can be parsed in one go, possibly in parallel if the
environment supports it. When this is done an mzIDCollection object
is returned:

```
ids <- mzID(mzids[1:2])
ids
```

```
## An mzIDCollection object containing 2 samples
```

Peptides, scans, parameters, … can be extracted with the
respective `peptides`, `scans`,
`parameters`, … functions. The `mzID` object
can also be converted into a `data.frame` using the
`flatten` function.

```
fid <- flatten(id)
names(fid)
```

```
##  [1] "spectrumid"               "spectrum title"
##  [3] "acquisitionnum"           "passthreshold"
##  [5] "rank"                     "calculatedmasstocharge"
##  [7] "experimentalmasstocharge" "chargestate"
##  [9] "omssa:evalue"             "omssa:pvalue"
## [11] "isdecoy"                  "post"
## [13] "pre"                      "end"
## [15] "start"                    "accession"
## [17] "length"                   "description"
## [19] "pepseq"                   "modified"
## [21] "modification"             "idFile"
## [23] "spectrumFile"             "databaseFile"
```

```
dim(fid)
```

```
## [1] 101  24
```

# 4 Raw data abstraction with `MSnExp` objects

*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* (Gatto and Lilley [2012](#ref-Gatto2012)) provides base functions and
classes for MS-based proteomics that allow facile data and meta-data
processing, manipulation and plotting (see for instance figure below).

```
library("MSnbase")
## uses a simple dummy test included in the package
mzXML <- dir(system.file(package="MSnbase",dir="extdata"),
             full.name=TRUE,
             pattern="mzXML$")
basename(mzXML)
```

```
## [1] "dummyiTRAQ.mzXML"
```

```
## reads the raw data into and MSnExp instance
raw <- readMSData(mzXML, verbose = FALSE, centroided = TRUE)
raw
```

```
## MSn experiment data ("MSnExp")
## Object size in memory: 0.18 Mb
## - - - Spectra data - - -
##  MS level(s): 2
##  Number of spectra: 5
##  MSn retention times: 25:01 - 25:02 minutes
## - - - Processing information - - -
## Data loaded: Tue Nov  4 11:40:05 2025
##  MSnbase version: 2.36.0
## - - - Meta data  - - -
## phenoData
##   rowNames: dummyiTRAQ.mzXML
##   varLabels: sampleNames
##   varMetadata: labelDescription
## Loaded from:
##   dummyiTRAQ.mzXML
## protocolData: none
## featureData
##   featureNames: F1.S1 F1.S2 ... F1.S5 (5 total)
##   fvarLabels: spectrum
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
```

```
## Extract a single spectrum
raw[[3]]
```

```
## Object of class "Spectrum2"
##  Precursor: 645.3741
##  Retention time: 25:02
##  Charge: 2
##  MSn level: 2
##  Peaks count: 2125
##  Total ion count: 150838188
```

```
plot(raw, full = TRUE)
plot(raw[[3]], full = TRUE, reporters = iTRAQ4)
```

![The `plot` method can be used on experiments, i.e. spectrum collections (top), or individual spectra (bottom).](data:image/png;base64...)

Figure 1: The `plot` method can be used on experiments, i.e. spectrum collections (top), or individual spectra (bottom)

## 4.1 `mgf` read/write support

Read and write support for data in the
[`mgf`](http://www.matrixscience.com/help/data_file_help.html#GEN)
and `mzTab` formats are available via the `readMgfData`/`writeMgfData`
and `readMzTabData`/`writeMzTabData` functions, respectively. An
example for the latter is shown in the next section.

# 5 Quantitative proteomics

As an running example throughout this document, we will use a TMT
6-plex data set, `PXD000001` to illustrate quantitative data
processing. The code chunk below first downloads this data file from
the ProteomeXchange server using the *[rpx](https://bioconductor.org/packages/3.22/rpx)* package.

## 5.1 The `mzTab` format

The first code chunk downloads the `mzTab` data from the
ProteomeXchange repository (Vizcaino et al. [2014](#ref-Vizcaino2014)).

```
## Experiment information
library("rpx")
px1 <- PXDataset("PXD000001")
```

```
## Loading PXD000001 from cache.
```

```
px1
```

```
## Project PXD000001 with 11 files
##
```

```
## Resource ID BFC102 in cache in /home/biocbuild/.cache/R/rpx.
```

```
##  [1] 'F063721.dat' ... [11] 'erwinia_carotovora.fasta'
##  Use 'pxfiles(.)' to see all files.
```

```
pxfiles(px1)
```

```
## Project PXD000001 files (11):
##  [remote] F063721.dat
##  [local]  F063721.dat-mztab.txt
##  [remote] PRIDE_Exp_Complete_Ac_22134.xml.gz
##  [remote] PRIDE_Exp_mzData_Ac_22134.xml.gz
##  [remote] PXD000001_mztab.txt
##  [remote] README.txt
##  [local]  TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML
##  [remote] TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzXML
##  [local]  TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.mzXML
##  [remote] TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.raw
##  ...
```

```
## Downloading the mzTab data
mztab <- pxget(px1, "F063721.dat-mztab.txt")
```

```
## Loading F063721.dat-mztab.txt from cache.
```

```
mztab
```

```
## [1] "/home/biocbuild/.cache/R/rpx/161494d52e74d_F063721.dat-mztab.txt"
```

The code below loads the `mzTab` file into R and generates an `MSnSet`
instance111 Here, we specify `mzTab` format version 0.9. Recent files
have been generated according to the latest specifications, version
1.0, and the `version` does not need to be specified explicitly.,
removes missing values and calculates protein intensities by summing
the peptide quantitation data. The figure below illustrates the
intensities for 5 proteins.

```
## Load mzTab peptide data
qnt <- readMzTabData(mztab, what = "PEP", version = "0.9")
```

```
## Warning in readMzTabData_v0.9(file, what, verbose): Version 0.9 is deprecated.
## Please see '?readMzTabData' and '?MzTab' for details.
```

```
sampleNames(qnt) <- reporterNames(TMT6)
head(exprs(qnt))
```

```
##   TMT6.126 TMT6.127 TMT6.128 TMT6.129 TMT6.130 TMT6.131
## 1 10630132 11238708 12424917 10997763  9928972 10398534
## 2 11105690 12403253 13160903 12229367 11061660 10131218
## 3  1183431  1322371  1599088  1243715  1306602  1159064
## 4  5384958  5508454  6883086  6136023  5626680  5213771
## 5 18033537 17926487 21052620 19810368 17381162 17268329
## 6  9873585 10299931 11142071 10258214  9664315  9518271
```

```
## remove missing values
qnt <- filterNA(qnt)
processingData(qnt)
```

```
## - - - Processing information - - -
## mzTab read: Tue Nov  4 11:40:09 2025
## Subset [1528,6][1528,6] Tue Nov  4 11:40:09 2025
## Removed features with more than 0 NAs: Tue Nov  4 11:40:09 2025
## Dropped featureData's levels Tue Nov  4 11:40:09 2025
##  MSnbase version: 2.36.0
```

```
## combine into proteins
## - using the 'accession' feature meta data
## - sum the peptide intensities
protqnt <- combineFeatures(qnt,
                           groupBy = fData(qnt)$accession,
                           method = sum)
```

```
cls <- brewer.pal(5, "Set1")
matplot(t(tail(exprs(protqnt), n = 5)), type = "b",
        lty = 1, col = cls,
        ylab = "Protein intensity (summed peptides)",
        xlab = "TMT reporters")
legend("topright", tail(featureNames(protqnt), n=5),
       lty = 1, bty = "n", cex = .8, col = cls)
```

![Protein quantitation data.](data:image/png;base64...)

Figure 2: Protein quantitation data

```
qntS <- normalise(qnt, "sum")
qntV <- normalise(qntS, "vsn")
qntV2 <- normalise(qnt, "vsn")

acc <- c("P00489", "P00924",
         "P02769", "P62894",
         "ECA")

idx <- sapply(acc, grep, fData(qnt)$accession)
idx2 <- sapply(idx, head, 3)
small <- qntS[unlist(idx2), ]

idx3 <- sapply(idx, head, 10)
medium <- qntV[unlist(idx3), ]

m <- exprs(medium)
colnames(m) <- c("126", "127", "128",
                 "129", "130", "131")
rownames(m) <- fData(medium)$accession
rownames(m)[grep("CYC", rownames(m))] <- "CYT"
rownames(m)[grep("ENO", rownames(m))] <- "ENO"
rownames(m)[grep("ALB", rownames(m))] <- "BSA"
rownames(m)[grep("PYGM", rownames(m))] <- "PHO"
rownames(m)[grep("ECA", rownames(m))] <- "Background"

cls <- c(brewer.pal(length(unique(rownames(m)))-1, "Set1"),
         "grey")
names(cls) <- unique(rownames(m))
wbcol <- colorRampPalette(c("white", "darkblue"))(256)
```

```
heatmap(m, col = wbcol, RowSideColors=cls[rownames(m)])
```

![A heatmap.](data:image/png;base64...)

Figure 3: A heatmap

```
dfr <- data.frame(exprs(small),
                  Protein = as.character(fData(small)$accession),
                  Feature = featureNames(small),
                  stringsAsFactors = FALSE)
colnames(dfr) <- c("126", "127", "128", "129", "130", "131",
                   "Protein", "Feature")
dfr$Protein[dfr$Protein == "sp|P00924|ENO1_YEAST"] <- "ENO"
dfr$Protein[dfr$Protein == "sp|P62894|CYC_BOVIN"]  <- "CYT"
dfr$Protein[dfr$Protein == "sp|P02769|ALBU_BOVIN"] <- "BSA"
dfr$Protein[dfr$Protein == "sp|P00489|PYGM_RABIT"] <- "PHO"
dfr$Protein[grep("ECA", dfr$Protein)] <- "Background"
dfr2 <- melt(dfr)
```

```
## Using Protein, Feature as id variables
```

```
ggplot(aes(x = variable, y = value, colour = Protein),
       data = dfr2) +
  geom_point() +
  geom_line(aes(group=as.factor(Feature)), alpha = 0.5) +
  facet_grid(. ~ Protein) + theme(legend.position="none") +
  labs(x = "Reporters", y = "Normalised intensity")
```

![Spikes plot using `r CRANpkg('ggplot2')`.](data:image/png;base64...)

Figure 4: Spikes plot using `r CRANpkg('ggplot2')`

## 5.2 Third-party data

It is possible to import any arbitrary text-based spreadsheet as
*MSnSet* object using either `readMSnSet` or
`readMSnSet2`. The former takes three spreadsheets as input
(for the expression data and the feature and sample meta-data). The
latter uses a single spreadsheet and a vector of expression columns to
populate the assay data and the feature meta-data. Detailed examples
are provided in the `MSnbase-io` vignette, that can be
consulted from R with `vignette("MSnbase-io")` or
[online](https://bioconductor.org/packages/release/bioc/vignettes/MSnbase/inst/doc/MSnbase-io.html).

## 5.3 Working with raw data

We reuse our dedicated `px1` ProteomeXchange data object to
download the raw data (in `mzXML` format) and load it with the
`readMSData` from the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package that
produces a raw data experiment object of class `MSnExp` (a new
*on-disk* infrastructure is now available to access the raw
data on disk on demand, rather than loading it all in memory, enabling
the management of more and larger files - see the
`benchmarking` vignette in the *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package for
details). The raw data is then quantified using the
`quantify` method specifying the TMT 6-plex isobaric tags
and a 7th peak of interest corresponding to the un-dissociated
reporter tag peaks (see the `MSnbase-demo` vignette in
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* for details).

```
mzxml <- pxget(px1, "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.mzXML")
```

```
## Loading TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.mzXML from cache.
```

```
rawms <- readMSData(mzxml, centroided = TRUE, verbose = FALSE)
qntms <- quantify(rawms, reporters = TMT7, method = "max")
qntms
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 6103 features, 7 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: TMT7.126 TMT7.127 ... TMT7.230 (7 total)
##   varLabels: mz reporters
##   varMetadata: labelDescription
## featureData
##   featureNames: F1.S0001 F1.S0002 ... F1.S6103 (6103 total)
##   fvarLabels: spectrum fileIdx ... collision.energy (12 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: No annotation
## - - - Processing information - - -
## Data loaded: Tue Nov  4 11:40:59 2025
## TMT7 quantification by max: Tue Nov  4 11:42:04 2025
##  MSnbase version: 2.36.0
```

Identification data in the `mzIdentML` format can be added to
`MSnExp` or `MSnSet` instances with the
`addIdentificationData` function. See the function
documentation for examples.

```
d <- data.frame(Signal = rowSums(exprs(qntms)[, 1:6]),
                Incomplete = exprs(qntms)[, 7])
d <- log(d)
cls <- rep("#00000050", nrow(qnt))
pch <- rep(1, nrow(qnt))
cls[grep("P02769", fData(qnt)$accession)] <- "gold4" ## BSA
cls[grep("P00924", fData(qnt)$accession)] <- "dodgerblue" ## ENO
cls[grep("P62894", fData(qnt)$accession)] <- "springgreen4" ## CYT
cls[grep("P00489", fData(qnt)$accession)] <- "darkorchid2" ## PHO
pch[grep("P02769", fData(qnt)$accession)] <- 19
pch[grep("P00924", fData(qnt)$accession)] <- 19
pch[grep("P62894", fData(qnt)$accession)] <- 19
pch[grep("P00489", fData(qnt)$accession)] <- 19
```

```
mzp <- plotMzDelta(rawms, reporters = TMT6, verbose = FALSE) + ggtitle("")
```

```
mzp
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_vline()`).
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_text()`).
```

![A m/z delta plot.](data:image/png;base64...)

Figure 5: A m/z delta plot

```
plot(Signal ~ Incomplete, data = d,
     xlab = expression(Incomplete~dissociation),
     ylab = expression(Sum~of~reporters~intensities),
     pch = 19,
     col = "#4582B380")
grid()
abline(0, 1, lty = "dotted")
abline(lm(Signal ~ Incomplete, data = d), col = "darkblue")
```

![Incomplete dissociation.](data:image/png;base64...)

Figure 6: Incomplete dissociation

```
MAplot(qnt[, c(4, 2)], cex = .9, col = cls, pch = pch, show.statistics = FALSE)
```

![MAplot on an `MSnSet` instance.](data:image/png;base64...)

Figure 7: MAplot on an `MSnSet` instance

## 5.4 The *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)* package

This section illustrates some of *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)*’s data
processing capabilities (Gibb and Strimmer [2012](#ref-Gibb2012)). The code is taken from the
`processing-peaks.R` script downloaded from
the [package homepage](http://strimmerlab.org/software/maldiquant/).

### Loading the data

```
## load packages
library("MALDIquant")
library("MALDIquantForeign")
## getting test data
datapath <-
  file.path(system.file("Examples",
                        package = "readBrukerFlexData"),
            "2010_05_19_Gibb_C8_A1")
dir(datapath)
```

```
## [1] "0_A1" "0_A2"
```

```
sA1 <- importBrukerFlex(datapath, verbose=FALSE)
# in the following we use only the first spectrum
s <- sA1[[1]]

summary(mass(s))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   999.9  2373.3  4331.4  4721.3  6874.2 10001.9
```

```
summary(intensity(s))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##       4     180    1562    2841    4656   32594
```

```
head(as.matrix(s))
```

```
##           mass intensity
## [1,]  999.9388     11278
## [2,] 1000.1316     11350
## [3,] 1000.3244     10879
## [4,] 1000.5173     10684
## [5,] 1000.7101     10740
## [6,] 1000.9030     10947
```

```
plot(s)
```

![Spectrum plotting in `r CRANpkg('MALDIquant')`.](data:image/png;base64...)

Figure 8: Spectrum plotting in `r CRANpkg('MALDIquant')`

### {Preprocessing}

```
## sqrt transform (for variance stabilization)
s2 <- transformIntensity(s, method="sqrt")
s2
```

```
## S4 class type            : MassSpectrum
## Number of m/z values     : 22431
## Range of m/z values      : 999.939 - 10001.925
## Range of intensity values: 2e+00 - 1.805e+02
## Memory usage             : 361.602 KiB
## Name                     : 2010_05_19_Gibb_C8_A1.A1
## File                     : /home/biocbuild/bbs-3.22-bioc/R/site-library/readBrukerFlexData/Examples/2010_05_19_Gibb_C8_A1/0_A1/1/1SLin/fid
```

```
## smoothing - 5 point moving average
s3 <- smoothIntensity(s2, method="MovingAverage", halfWindowSize=2)
s3
```

```
## S4 class type            : MassSpectrum
## Number of m/z values     : 22431
## Range of m/z values      : 999.939 - 10001.925
## Range of intensity values: 3.606e+00 - 1.792e+02
## Memory usage             : 361.602 KiB
## Name                     : 2010_05_19_Gibb_C8_A1.A1
## File                     : /home/biocbuild/bbs-3.22-bioc/R/site-library/readBrukerFlexData/Examples/2010_05_19_Gibb_C8_A1/0_A1/1/1SLin/fid
```

```
## baseline subtraction
s4 <- removeBaseline(s3, method="SNIP")
s4
```

```
## S4 class type            : MassSpectrum
## Number of m/z values     : 22431
## Range of m/z values      : 999.939 - 10001.925
## Range of intensity values: 0e+00 - 1.404e+02
## Memory usage             : 361.602 KiB
## Name                     : 2010_05_19_Gibb_C8_A1.A1
## File                     : /home/biocbuild/bbs-3.22-bioc/R/site-library/readBrukerFlexData/Examples/2010_05_19_Gibb_C8_A1/0_A1/1/1SLin/fid
```

### Peak picking

```
## peak picking
p <- detectPeaks(s4)
length(p) # 181
```

```
## [1] 186
```

```
peak.data <- as.matrix(p) # extract peak information
```

```
par(mfrow=c(2,3))
xl <- range(mass(s))
# use same xlim on all plots for better comparison
plot(s, sub="", main="1: raw", xlim=xl)
plot(s2, sub="", main="2: variance stabilisation", xlim=xl)
plot(s3, sub="", main="3: smoothing", xlim=xl)
plot(s4, sub="", main="4: base line correction", xlim=xl)
plot(s4, sub="", main="5: peak detection", xlim=xl)
points(p)
top20 <- intensity(p) %in% sort(intensity(p), decreasing=TRUE)[1:20]
labelPeaks(p, index=top20, underline=TRUE)
plot(p, sub="", main="6: peak plot", xlim=xl)
labelPeaks(p, index=top20, underline=TRUE)
```

![Spectrum plotting in `r CRANpkg('MALDIquant')`.](data:image/png;base64...)

Figure 9: Spectrum plotting in `r CRANpkg('MALDIquant')`

## 5.5 Working with peptide sequences

```
library(BRAIN)
atoms <- getAtomsFromSeq("SIVPSGASTGVHEALEMR")
unlist(atoms)
```

```
##   C   H   N   O   S
##  77 129  23  27   1
```

```
library(Rdisop)
pepmol <- getMolecule(paste0(names(atoms),
                             unlist(atoms),
                             collapse = ""))
pepmol
```

```
## $formula
## [1] "C77H129N23O27S"
##
## $score
## [1] 1
##
## $exactmass
## [1] 1839.915
##
## $charge
## [1] 0
##
## $parity
## [1] "e"
##
## $valid
## [1] "Valid"
##
## $DBE
## [1] 25
##
## $isotopes
## $isotopes[[1]]
##              [,1]         [,2]         [,3]         [,4]         [,5]
## [1,] 1839.9148968 1840.9177145 1841.9195806 1.842921e+03 1.843923e+03
## [2,]    0.3519956    0.3343445    0.1924172 8.209705e-02 2.826633e-02
##              [,6]         [,7]         [,8]         [,9]        [,10]
## [1,] 1.844925e+03 1.845926e+03 1.846928e+03 1.847930e+03 1.848932e+03
## [2,] 8.218776e-03 2.078352e-03 4.666647e-04 9.448871e-05 1.745985e-05
```

```
##
library(OrgMassSpecR)
```

```
## Loading required package: grid
```

```
##
## Attaching package: 'grid'
```

```
## The following object is masked from 'package:Biostrings':
##
##     pattern
```

```
data(itraqdata)

simplottest <-
  itraqdata[featureNames(itraqdata) %in% paste0("X", 46:47)]
sim <- SpectrumSimilarity(as(simplottest[[1]], "data.frame"),
                          as(simplottest[[2]], "data.frame"),
                          top.lab = "itraqdata[['X46']]",
                          bottom.lab = "itraqdata[['X47']]",
                          b = 25)
title(main = paste("Spectrum similarity", round(sim, 3)))
```

![](data:image/png;base64...)

```
MonoisotopicMass(formula = list(C = 2, O = 1, H=6))
```

```
## [1] 46.04186
```

```
molecule <- getMolecule("C2H5OH")
molecule$exactmass
```

```
## [1] 46.04186
```

```
## x11()
## plot(t(.pepmol$isotopes[[1]]), type = "h")

## x <- IsotopicDistribution(formula = list(C = 2, O = 1, H=6))
## t(molecule$isotopes[[1]])
## par(mfrow = c(2,1))
## plot(t(molecule$isotopes[[1]]), type = "h")
## plot(x[, c(1,3)], type = "h")

## data(myo500)
## masses <- c(147.053, 148.056)
## intensities <- c(93, 5.8)
## molecules <- decomposeIsotopes(masses, intensities)

## experimental eno peptides
exppep <-
  as.character(fData(qnt[grep("ENO", fData(qnt)[, 2]), ])[, 1]) ## 13
minlength <- min(nchar(exppep))

if (!file.exists("P00924.fasta"))
    eno <- download.file("http://www.uniprot.org/uniprot/P00924.fasta",
                         destfile = "P00924.fasta")
eno <- paste(readLines("P00924.fasta")[-1], collapse = "")
enopep <- Digest(eno, missed = 1)
nrow(enopep) ## 103
```

```
## [1] 103
```

```
sum(nchar(enopep$peptide) >= minlength) ## 68
```

```
## [1] 68
```

```
pepcnt <- enopep[enopep[, 1] %in% exppep, ]
nrow(pepcnt) ## 13
```

```
## [1] 13
```

The following code chunks demonstrate how to use the *[cleaver](https://bioconductor.org/packages/3.22/cleaver)*
package for in-silico cleavage of polypeptides, e.g. cleaving of
*Gastric juice peptide 1 (P01358)* using *Trypsin*:

```
library(cleaver)
cleave("LAAGKVEDSD", enzym = "trypsin")
```

```
## $LAAGKVEDSD
## [1] "LAAGK" "VEDSD"
```

Sometimes cleavage is not perfect and the enzym miss some cleavage positions:

```
## miss one cleavage position
cleave("LAAGKVEDSD", enzym = "trypsin", missedCleavages = 1)
```

```
## $LAAGKVEDSD
## [1] "LAAGKVEDSD"
```

```
## miss zero or one cleavage positions
cleave("LAAGKVEDSD", enzym = "trypsin", missedCleavages = 0:1)
```

```
## $LAAGKVEDSD
## [1] "LAAGK"      "VEDSD"      "LAAGKVEDSD"
```

Example code to generate an Texshade image to be included directly in
a Latex document or R vignette is presented below. The R code
generates a Texshade environment and the annotated sequence display
code that is written to a TeX file that can itself be included into a
LaTeX or Sweave document.

```
seq1file <- "seq1.tex"
cat("\\begin{texshade}{Figures/P00924.fasta}
     \\setsize{numbering}{footnotesize}
     \\setsize{residues}{footnotesize}
     \\residuesperline*{70}
     \\shadingmode{functional}
     \\hideconsensus
     \\vsepspace{1mm}
     \\hidenames
     \\noblockskip\n", file = seq1file)
tmp <- sapply(1:nrow(pepcnt), function(i) {
  col <- ifelse((i %% 2) == 0, "Blue", "RoyalBlue")
  cat("\\shaderegion{1}{", pepcnt$start[i], "..", pepcnt$stop[i], "}{White}{", col, "}\n",
      file = seq1file, append = TRUE)
})
cat("\\end{texshade}
    \\caption{Visualising observed peptides for the Yeast enolase protein. Peptides are shaded in blue and black.
              The last peptide is a mis-cleavage and overlaps with \`IEEELGDNAVFAGENFHHGDK`.}
    \ {#fig:seq}
  \\end{center}
\\end{figure}\n\n",
    file = seq1file, append = TRUE)
```

### N15 incorporation

```
## 15N incorporation rates from 0, 0.1, ..., 0.9, 0.95, 1
incrate <- c(seq(0, 0.9, 0.1), 0.95, 1)
inc <- lapply(incrate, function(inc)
              IsotopicDistributionN("YEVQGEVFTKPQLWP", inc))
par(mfrow = c(4,3))
for (i in 1:length(inc))
  plot(inc[[i]][, c(1, 3)], xlim = c(1823, 1848), type = "h",
       main = paste0("15N incorporation at ", incrate[i]*100, "%"))
```

![Isotopic envelope for the `YEVQGEVFTKPQLWP` peptide at different N15 incorporation rates ](data:image/png;base64...)

Figure 10: Isotopic envelope for the `YEVQGEVFTKPQLWP` peptide at different N15 incorporation rates

# 6 MS2 spectra identification

## 6.1 Post-search Filtering of MS/MS IDs Using *[MSnID](https://bioconductor.org/packages/3.22/MSnID)*

The main purpose of *[MSnID](https://bioconductor.org/packages/3.22/MSnID)* package is to make sure that
the peptide and protein identifications resulting from MS/MS searches
are sufficiently confident for a given application.} MS/MS peptide and
protein identification is a process that prone to uncertanities. A
typical and currently most reliable way to quantify uncertainty in the
list of identify spectra, peptides or proteins relies on so-called
decoy database. For bottom-up (i.e. involving protein digestion)
approaches a common way to construct a decoy database is simple
inversion of protein amino-acid sequences. If the spectrum matches to
normal protein sequence it can be true or false match. Matches to
decoy part of the database are false only (excluding the
palindromes). Therefore the false discovery rate (FDR) of
identifications can be estimated as ratio of hits to decoy over normal
parts of the protein sequence database. There are multiple levels of
identification that FDR can be estimated for. First, is at the level
of peptide/protein- to-spectrum matches. Second is at the level of
unique peptide sequences. Note, true peptides tend to be identified by
more then one spectrum. False peptide tend to be sporadic. Therefore,
after collapsing the redundant peptide identifications from multiple
spectra to the level of unique peptide sequence, the FDR typically
increases. The extend of FDR increase depends on the type and
complexity of the sample. The same trend is true for estimating the
identification FDR at the protein level. True proteins tend to be
identified with multiple peptides, while false protein identifications
are commonly covered only by one peptide. Therefore FDR estimate tend
to be even higher for protein level compare to peptide level. The
estimation of the FDR is also affected by the number of LC-MS (runs)
datasets in the experiment. Again, true identifications tend to be
more consistent from run to run, while false are sporadic. After
collapsing the redundancy across the runs, the number of true
identification reduces much stronger compare to false
identifications. Therefore, the peptide and protein FDR estimates need
to be re-evaluated. The main objective of the MSnID package is to
provide convenience tools for handling tasks on estimation of FDR,
defining and optimizing the filtering criteria and ensuring confidence
in MS/MS identification data. The user can specify the criteria for
filtering the data (e.g. goodness or p-value of matching of
experimental and theoretical fragmentation mass spectrum, deviation of
theoretical from experimentally measured mass, presence of missed
cleavages in the peptide sequence, etc), evaluate the performance of
the filter judging by FDRs at spectrum, peptide and protein levels,
and finally optimize the filter to achieve the maximum number of
identifications while not exceeding maximally allowed FDR upper
threshold.

### Starting Project and Importing Data

To start a project one have to specify a directory. Currently the only
use of the directory is for storing cached results.

```
library("MSnID")
```

```
##
## Attaching package: 'MSnID'
```

```
## The following object is masked from 'package:ProtGenerics':
##
##     peptides
```

```
msnid <- MSnID(".")
```

```
## Note, the anticipated/suggested columns in the
## peptide-to-spectrum matching results are:
## -----------------------------------------------
## accession
## calculatedMassToCharge
## chargeState
## experimentalMassToCharge
## isDecoy
## peptide
## spectrumFile
## spectrumID
```

Data can imported as `data.frame` or read from mzIdentML file.

```
PSMresults <- read.delim(system.file("extdata", "human_brain.txt",
                                     package="MSnID"),
                         stringsAsFactors=FALSE)
psms(msnid) <- PSMresults
show(msnid)
```

```
## MSnID object
## Working directory: "."
## #Spectrum Files:  1
## #PSMs: 767 at 49 % FDR
## #peptides: 687 at 57 % FDR
## #accessions: 665 at 65 % FDR
```

```
mzids <- system.file("extdata", "c_elegans.mzid.gz", package="MSnID")
msnid <- read_mzIDs(msnid, mzids)
```

```
## Reading from mzIdentMLs ...
```

```
## reading c_elegans.mzid.gz...
```

```
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
## Warning in type.convert.default(...): 'as.is' should be specified by the
## caller; using TRUE
```

```
##  DONE!
```

```
show(msnid)
```

```
## MSnID object
## Working directory: "."
## #Spectrum Files:  1
## #PSMs: 12263 at 36 % FDR
## #peptides: 9489 at 44 % FDR
## #accessions: 7414 at 76 % FDR
```

### Analysis of Peptide Sequences

A particular properties of peptide sequences we are interested in are

1. irregular cleavages at the termini of the peptides and
2. missing cleavage site within the peptide sequences.

A particular properties of peptide sequences we are interested in are
(1) irregular cleavages at the termini of the peptides and (2) missing
cleavage site within the peptide sequences:

* Counting the number of irregular cleavage termimi (0, 1 or 2) in
  peptides sequence creates a new column `numIrregCleavages`.
* Counting the number of missed cleavages in peptides sequence
  correspondingly creates a `numMissCleavages` column.

The default regular expressions for the `validCleavagePattern`
and `missedCleavagePattern` correspond to trypsin specificity.

```
msnid <- assess_termini(msnid, validCleavagePattern="[KR]\\.[^P]")
msnid <- assess_missed_cleavages(msnid, missedCleavagePattern="[KR](?=[^P$])")
prop.table(table(msnid$numIrregCleavages))
```

```
##
##           0           1           2
## 0.801574390 0.189294149 0.009131462
```

Now the object has two more columns, `numIrregCleavages` and
`numMissCleavages`, evidently corresponding to the number of
termini with irregular cleavages and number of missed cleavages within
the peptide sequence. The figure below shows that peptides with 2 or
more missed cleavages are likely to be false identifications.

```
pepCleav <- unique(psms(msnid)[,c("numMissCleavages", "isDecoy", "peptide")])
pepCleav <- as.data.frame(table(pepCleav[,c("numMissCleavages", "isDecoy")]))
library("ggplot2")
ggplot(pepCleav, aes(x=numMissCleavages, y=Freq, fill=isDecoy)) +
    geom_bar(stat='identity', position='dodge') +
    ggtitle("Number of Missed Cleavages")
```

![](data:image/png;base64...)

### Defining the Filter

The criteria that will be used for filtering the MS/MS data has to be present
in the `MSnID` object. We will use -log10 transformed MS-GF+
Spectrum E-value, reflecting the goodness of match experimental and
theoretical fragmentation patterns as one the filtering criteria.
Let’s store it under the “msmsScore” name. The score density distribution
shows that it is a good discriminant between non-decoy (red)
and decoy hits (green).

For alternative MS/MS search engines refer to the engine-specific manual for
the names of parameters reflecting the quality of MS/MS spectra matching.
Examples of such parameters are `E-Value` for X!Tandem
and `XCorr` and `$\Delta$Cn2` for SEQUEST.

As a second criterion we will be using the absolute mass measurement
error (in ppm units) of the parent ion. The mass measurement errors tend to
be small for non-decoy (enriched with real identificaiton) hits (red line) and
is effectively uniformly distributed for decoy hits.

```
msnid$msmsScore <- -log10(msnid$`MS-GF:SpecEValue`)
msnid$absParentMassErrorPPM <- abs(mass_measurement_error(msnid))
```

MS/MS fiters are handled by a special *MSnIDFilter* class
objects. Individual filtering criteria can be set by name (that is
present in `names(msnid)`), comparison operator (>, <, = , …)
defining if we should retain hits with higher or lower given the
threshold and finally the threshold value itself. The filter below set
in such a way that retains only those matches that has less then 5 ppm
of parent ion mass measurement error and more the
\(10^7\) MS-GF:SpecEValue.

```
filtObj <- MSnIDFilter(msnid)
filtObj$absParentMassErrorPPM <- list(comparison="<", threshold=5.0)
filtObj$msmsScore <- list(comparison=">", threshold=8.0)
show(filtObj)
```

```
## MSnIDFilter object
## (absParentMassErrorPPM < 5) & (msmsScore > 8)
```

The stringency of the filter can be evaluated at different levels.

```
evaluate_filter(msnid, filtObj, level="PSM")
```

```
##            fdr    n
## PSM 0.00272745 5147
```

```
evaluate_filter(msnid, filtObj, level="peptide")
```

```
##                fdr    n
## peptide 0.00424371 3313
```

```
evaluate_filter(msnid, filtObj, level="accession")
```

```
##                  fdr    n
## accession 0.01770658 1207
```

### Optimizing the Filter

The threshold values in the example above are not necessarily optimal and set
just be in the range of probable values. Filters can be optimized to ensure
maximum number of identifications (peptide-to-spectrum matches,
unique peptide sequences or proteins) within a given FDR upper limit.

First, the filter can be optimized simply by stepping through
individual parameters and their combinations. The idea has been described in
(Piehowski et al. [2013](#ref-Piehowski2013a)). The resulting `MSnIDFilter` object can be
used for final data filtering or can be used as a good starting parameters for
follow-up refining optimizations with more advanced algorithms.

```
filtObj.grid <- optimize_filter(filtObj, msnid, fdr.max=0.01,
                                method="Grid", level="peptide",
                                n.iter=500)
show(filtObj.grid)
```

```
## MSnIDFilter object
## (absParentMassErrorPPM < 10) & (msmsScore > 7.8)
```

The resulting `filtObj.grid` can be further fine tuned with such
optimization routines as simulated annealing or Nelder-Mead optimization.

```
filtObj.nm <- optimize_filter(filtObj.grid, msnid, fdr.max=0.01,
                                method="Nelder-Mead", level="peptide",
                                n.iter=500)
show(filtObj.nm)
```

```
## MSnIDFilter object
## (absParentMassErrorPPM < 10) & (msmsScore > 7.8)
```

Evaluate non-optimized and optimized filters.

```
evaluate_filter(msnid, filtObj, level="peptide")
```

```
##                fdr    n
## peptide 0.00424371 3313
```

```
evaluate_filter(msnid, filtObj.grid, level="peptide")
```

```
##                 fdr    n
## peptide 0.009220702 3393
```

```
evaluate_filter(msnid, filtObj.nm, level="peptide")
```

```
##                 fdr    n
## peptide 0.009777778 3408
```

Finally applying filter to remove predominantly false identifications.

```
msnid <- apply_filter(msnid, filtObj.nm)
show(msnid)
```

```
## MSnID object
## Working directory: "."
## #Spectrum Files:  1
## #PSMs: 5288 at 0.63 % FDR
## #peptides: 3408 at 0.98 % FDR
## #accessions: 1253 at 3.8 % FDR
```

Removing hits to decoy and contaminant sequences using the same
`apply_filter` method.

```
msnid <- apply_filter(msnid, "isDecoy == FALSE")
show(msnid)
```

```
## MSnID object
## Working directory: "."
## #Spectrum Files:  1
## #PSMs: 5255 at 0 % FDR
## #peptides: 3375 at 0 % FDR
## #accessions: 1207 at 0 % FDR
```

```
msnid <- apply_filter(msnid, "!grepl('Contaminant',accession)")
show(msnid)
```

```
## MSnID object
## Working directory: "."
## #Spectrum Files:  1
## #PSMs: 5246 at 0 % FDR
## #peptides: 3368 at 0 % FDR
## #accessions: 1205 at 0 % FDR
```

### Interface with Other Bioconductor Packages

One can extract the entire PSMs tables as `data.frame` or `data.table`

```
psm.df <- psms(msnid)
psm.dt <- as(msnid, "data.table")
```

If only interested in the non-redundant list of confidently identified
peptides or proteins

```
peps <- MSnID::peptides(msnid)
head(peps)
```

```
## [1] "K.AISQIQEYVDYYGGSGVQHIALNTSDIITAIEALR.A"
## [2] "K.SAGSGYLVGDSLTFVDLLVAQHTADLLAANAALLDEFPQFK.A"
## [3] "K.NSIFTNVAETANGEYFWEGLEDEIADKNVDITTWLGEK.W"
## [4] "R.VFCLLGDGESAEGSVWEAAAFASIYKLDNLVAIVDVNR.L"
## [5] "R.TTDSDGNNTGLDLYTVDQVEHSNYVEQNFLDFIFVFR.K"
## [6] "R.KFDADGSGKLEFDEFCALVYTVANTVDKETLEKELR.E"
```

```
prots <- accessions(msnid)
head(prots)
```

```
## [1] "CE02347" "CE07055" "CE12728" "CE36358" "CE36359" "CE36360"
```

```
prots <- proteins(msnid) # may be more intuitive then accessions
head(prots)
```

```
## [1] "CE02347" "CE07055" "CE12728" "CE36358" "CE36359" "CE36360"
```

The *[MSnID](https://bioconductor.org/packages/3.22/MSnID)* package is aimed at providing convenience
functionality to handle MS/MS identifications. Quantification
*per se* is outside of the scope of the package. The only type
of quantitation that can be seamlessly tied with MS/MS identification
analysis is so-called *spectral counting* approach. In such an
approach a peptide abundance is considered to be directly proportional
to the number of matched MS/MS spectra. In its turn protein abunance
is proportional to the sum of the number of spectra of the matching
peptides. The *MSnID* object can be converted to an
*MSnSet* object defined in *[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* that extends
generic Bioconductor *eSet* class to quantitative proteomics
data. The spectral count data can be analyzed with *[msmsEDA](https://bioconductor.org/packages/3.22/msmsEDA)*,
*[msmsTests](https://bioconductor.org/packages/3.22/msmsTests)* or *[DESeq](https://bioconductor.org/packages/3.22/DESeq)* packages.

```
msnset <- as(msnid, "MSnSet")
library("MSnbase")
head(fData(msnset))
```

```
##                                                                     peptide
## -.APPSQDVLKEIFNLYDEELDGK.I                       -.APPSQDVLKEIFNLYDEELDGK.I
## -.APPSQDVLKEIFNLYDEELDGKIDGTQVGDVAR.A -.APPSQDVLKEIFNLYDEELDGKIDGTQVGDVAR.A
## -.APPTFADLGK.S                                               -.APPTFADLGK.S
## -.GFQNLWFSHPR.K                                             -.GFQNLWFSHPR.K
## -.GIDINHKHDR.V                                               -.GIDINHKHDR.V
## -.MFSNLFIFL.V                                                 -.MFSNLFIFL.V
##                                          accession
## -.APPSQDVLKEIFNLYDEELDGK.I            CE01236,....
## -.APPSQDVLKEIFNLYDEELDGKIDGTQVGDVAR.A CE01236,....
## -.APPTFADLGK.S                             CE29443
## -.GFQNLWFSHPR.K                            CE26849
## -.GIDINHKHDR.V                             CE16650
## -.MFSNLFIFL.V                              CE21589
```

```
head(exprs(msnset))
```

```
##                                       c_elegans_A_3_1_21Apr10_Draco_10-03-04_dta.txt
## -.APPSQDVLKEIFNLYDEELDGK.I                                                         1
## -.APPSQDVLKEIFNLYDEELDGKIDGTQVGDVAR.A                                              4
## -.APPTFADLGK.S                                                                     2
## -.GFQNLWFSHPR.K                                                                    1
## -.GIDINHKHDR.V                                                                     2
## -.MFSNLFIFL.V                                                                      1
```

Note, the convertion from `MSnID` to `MSnSet` uses
peptides as features. The number of redundant peptide observations
represent so-called spectral count that can be used for rough
quantitative analysis. Summing of all of the peptide counts to a
proteins level can be done with `combineFeatures` function from
*[MSnbase](https://bioconductor.org/packages/3.22/MSnbase)* package.

```
msnset <- combineFeatures(msnset,
                            fData(msnset)$accession,
                            redundancy.handler="unique",
                            fun="sum",
                            cv=FALSE)
```

```
## Warning in .combineFeatures(object, groupBy, method, fcol, redundancy.handler,
## : Parameter 'fun' is deprecated. Please use 'method' instead
```

```
head(fData(msnset))
```

```
##                                     peptide accession
## CE00078                         K.RLPVAPR.G   CE00078
## CE00103 K.LPNDDIGVQVSYLGEPHTFTPEQVLAALLTK.L   CE00103
## CE00134                       I.PAEVAEHLK.A   CE00134
## CE00209            K.ALEGPGPGEDAAHSENNPPR.N   CE00209
## CE00302                  K.LTYFDIHGLAEPIR.L   CE00302
## CE00318        K.ALNALCAQLMTELADALEVLDTDK.S   CE00318
```

```
head(exprs(msnset))
```

```
##         c_elegans_A_3_1_21Apr10_Draco_10-03-04_dta.txt
## CE00078                                            1.0
## CE00103                                            1.0
## CE00134                                            1.0
## CE00209                                            2.0
## CE00302                                            1.0
## CE00318                                            2.2
```

# 7 Quality control

Quality control (QC) is an essential part of any high throughput data
driven approach. Bioconductor has a rich history of QC for various
genomics data and currently two packages support proteomics QC.

*[proteoQC](https://bioconductor.org/packages/3.22/proteoQC)* provides a dedicated a dedicated pipeline that will
produce a dynamic and extensive html report. It uses the
*[rTANDEM](https://bioconductor.org/packages/3.22/rTANDEM)* package to automate the generation of identification
data and uses information about the experimental/replication design.

The *[qcmetrics](https://bioconductor.org/packages/3.22/qcmetrics)* package is a general framework to define QC
metrics and bundle them together to generate html or pdf reports. It
provides some ready made metrics for MS data and N15 labelled
data.

# 8 Annotation

In this section, we briefly present some Bioconductor annotation
infrastructure.

We start with the *[hpar](https://bioconductor.org/packages/3.22/hpar)* package, an interface to the
*Human Protein Atlas* (Uhlén et al. [2005](#ref-Uhlen2005), Uhlen2010), to retrieve
subcellular localisation information for the `ENSG00000002746`
ensemble gene.

```
id <- "ENSG00000105323"
library("hpar")
subcell <- hpaSubcellularLoc()
```

```
## see ?hpar and browseVignettes('hpar') for documentation
```

```
## loading from cache
```

```
subset(subcell, Gene == id)
```

```
##                 Gene Gene.name Reliability Main.location Additional.location
## 2357 ENSG00000105323  HNRNPUL1    Enhanced   Nucleoplasm
##      Extracellular.location    Enhanced Supported Approved Uncertain
## 2357                        Nucleoplasm
##      Single.cell.variation.intensity Single.cell.variation.spatial
## 2357
##      Cell.cycle.dependency                    GO.id
## 2357                       Nucleoplasm (GO:0005654)
```

Below, we make use of the human annotation package
*[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* and the Gene Ontology annotation package
*[GO.db](https://bioconductor.org/packages/3.22/GO.db)* to retrieve compatible information with above.

```
library("org.Hs.eg.db")
library("GO.db")
ans <- AnnotationDbi::select(org.Hs.eg.db,
                             keys = id,
                             columns = c("ENSEMBL", "GO", "ONTOLOGY"),
                             keytype = "ENSEMBL")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
ans <- ans[ans$ONTOLOGY == "CC", ]
ans
```

```
##            ENSEMBL         GO EVIDENCE ONTOLOGY
## 7  ENSG00000105323 GO:0005634      IBA       CC
## 8  ENSG00000105323 GO:0005634      IDA       CC
## 9  ENSG00000105323 GO:0005634      IEA       CC
## 10 ENSG00000105323 GO:0005634      TAS       CC
## 11 ENSG00000105323 GO:0005654      IDA       CC
## 16 ENSG00000105323 GO:0045202      IEA       CC
## 17 ENSG00000105323 GO:1990904      IEA       CC
```

```
sapply(as.list(GOTERM[ans$GO]), slot, "Term")
```

```
##                  GO:0005634                  GO:0005634
##                   "nucleus"                   "nucleus"
##                  GO:0005634                  GO:0005634
##                   "nucleus"                   "nucleus"
##                  GO:0005654                  GO:0045202
##               "nucleoplasm"                   "synapse"
##                  GO:1990904
## "ribonucleoprotein complex"
```

Finally, this information can also be retrieved from on-line databases
using the *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)* package (Durinck et al. [2005](#ref-Durinck2005)).

```
library("biomaRt")
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")
```

```
efilter <- "ensembl_gene_id"
eattr <- c("go_id", "name_1006", "namespace_1003")
bmres <- getBM(attributes=eattr, filters = efilter, values = id, mart = ensembl)
bmres[bmres$namespace_1003 == "cellular_component", "name_1006"]
```

```
## [1] "nucleus"                   "nucleoplasm"
## [3] "ribonucleoprotein complex" "synapse"
```

# 9 Other packages

## 9.1 Bioconductor packages

This section provides a complete list of packages available in the
relevant Bioconductor version 3.22
[*biocView*](http://www.bioconductor.org/packages/devel/BiocViews.html%3E) categories.
the tables below represent the packages for the `Proteomics`
(187 packages), `MassSpectrometry`
(147 packages) and
`MassSpectrometryData` (26
experiment packages) categories.

The tables can easily be generated with the `proteomicsPackages`,
`massSpectrometryPackages` and `massSpectrometryDataPackages`
functions. The respective package tables can then be interactively
explored using the `display` function.

```
pp <- proteomicsPackages()
display(pp)
```

## 9.2 Other CRAN packages

The CRAN task view on [Chemometrics and Computational
Physics](http://cran.r-project.org/web/views/ChemPhys.html) is another
useful ressource listing additional packages, including a set of
packages for mass spectrometry and proteomics, some of which are
illustrated in this document.

* *[MALDIquant](https://CRAN.R-project.org/package%3DMALDIquant)* provides tools for quantitative analysis of
  MALDI-TOF mass spectrometry data, with support for baseline
  correction, peak detection and plotting of mass spectra.
* *[OrgMassSpecR](https://CRAN.R-project.org/package%3DOrgMassSpecR)* is for organic/biological mass
  spectrometry, with a focus on graphical display, quantification
  using stable isotope dilution, and protein hydrogen/deuterium
  exchange experiments.
* *[FTICRMS](https://CRAN.R-project.org/package%3DFTICRMS)* provides functions for Analyzing Fourier
  Transform-Ion Cyclotron Resonance Mass Spectrometry Data.
* *[titan](https://CRAN.R-project.org/package%3Dtitan)* provides a GUI to analyze mass spectrometric
  data on the relative abundance of two substances from a titration
  series.
* *[digeR](https://CRAN.R-project.org/package%3DdigeR)* provides a GUI interface for analysing 2D DIGE
  data. It allows to perform correlation analysis, score plot,
  classification, feature selection and power analysis for 2D DIGE
  experiment data.
* *[protViz](https://CRAN.R-project.org/package%3DprotViz)* helps with quality checks, visualizations and
  analysis of mass spectrometry data, coming from proteomics
  experiments. The package is developed, tested and used at the
  Functional Genomics Center Zurich.

Suggestions for additional R packages are welcome and will be added to
the vignette. Please send suggestions and possibly a short
description and/or a example utilisation with code to the
RforProteomics package maintainer. The only requirement is that the
package must be available on an official package channel (CRAN,
Bioconductor, R-forge, Omegahat), i.e. not only available through a
personal web page.

# 10 Session information

All software and respective versions used in this document, as
returned by `sessionInfo()` are detailed below.

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
##  [1] MSnID_1.44.0             cleaver_1.48.0           OrgMassSpecR_0.5-3
##  [4] msdata_0.50.0            reshape2_1.4.4           biomaRt_2.66.0
##  [7] Rdisop_1.70.0            GO.db_3.22.0             org.Hs.eg.db_3.22.0
## [10] BRAIN_1.56.0             Biostrings_2.78.0        Seqinfo_1.0.0
## [13] XVector_0.50.0           PolynomF_2.0-8           hpar_1.52.0
## [16] rols_3.6.0               mzID_1.48.0              beanplot_1.3.1
## [19] ggplot2_4.0.0            lattice_0.22-7           e1071_1.7-16
## [22] msmsTests_1.48.0         msmsEDA_1.48.0           pRolocdata_1.48.0
## [25] pRoloc_1.50.0            BiocParallel_1.44.0      MLInterfaces_1.90.0
## [28] cluster_2.1.8.1          annotate_1.88.0          XML_3.99-0.19
## [31] AnnotationDbi_1.72.0     IRanges_2.44.0           MALDIquantForeign_0.14.1
## [34] MALDIquant_1.22.3        RColorBrewer_1.1-3       xtable_1.8-4
## [37] rpx_2.18.0               knitr_1.50               DT_0.34.0
## [40] protViz_0.7.9            BiocManager_1.30.26      RforProteomics_1.48.0
## [43] MSnbase_2.36.0           ProtGenerics_1.42.0      S4Vectors_0.48.0
## [46] mzR_2.44.0               Rcpp_1.1.0               Biobase_2.70.0
## [49] BiocGenerics_0.56.0      generics_0.1.4           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] segmented_2.1-4             fs_1.6.6
##   [3] matrixStats_1.5.0           bitops_1.0-9
##   [5] lubridate_1.9.4             httr_1.4.7
##   [7] doParallel_1.0.17           tools_4.5.1
##   [9] R6_2.6.1                    lazyeval_0.2.2
##  [11] withr_3.0.2                 prettyunits_1.2.0
##  [13] gridExtra_2.3               preprocessCore_1.72.0
##  [15] cli_3.6.5                   readBrukerFlexData_1.9.3
##  [17] labeling_0.4.3              sass_0.4.10
##  [19] mvtnorm_1.3-3               S7_0.2.0
##  [21] randomForest_4.7-1.2        proxy_0.4-27
##  [23] R.utils_2.13.0              dichromat_2.0-0.1
##  [25] MetaboCoreUtils_1.18.0      parallelly_1.45.1
##  [27] limma_3.66.0                impute_1.84.0
##  [29] RSQLite_2.4.3               FNN_1.1.4.1
##  [31] crosstalk_1.2.2             gtools_3.9.5
##  [33] dplyr_1.1.4                 dendextend_1.19.1
##  [35] Matrix_1.7-4                abind_1.4-8
##  [37] R.methodsS3_1.8.2           lifecycle_1.0.4
##  [39] yaml_2.3.10                 edgeR_4.8.0
##  [41] SummarizedExperiment_1.40.0 gplots_3.2.0
##  [43] biocViews_1.78.0            recipes_1.3.1
##  [45] qvalue_2.42.0               SparseArray_1.10.1
##  [47] BiocFileCache_3.0.0         blob_1.2.4
##  [49] gdata_3.0.1                 ExperimentHub_3.0.0
##  [51] crayon_1.5.3                PSMatch_1.14.0
##  [53] KEGGREST_1.50.0             magick_2.9.0
##  [55] pillar_1.11.1               GenomicRanges_1.62.0
##  [57] future.apply_1.20.0         lpSolve_5.6.23
##  [59] codetools_0.2-20            glue_1.8.0
##  [61] pcaMethods_2.2.0            data.table_1.17.8
##  [63] MultiAssayExperiment_1.36.0 vctrs_0.6.5
##  [65] png_0.1-8                   gtable_0.3.6
##  [67] kernlab_0.9-33              cachem_1.1.0
##  [69] gower_1.0.2                 xfun_0.54
##  [71] S4Arrays_1.10.0             prodlim_2025.04.28
##  [73] coda_0.19-4.1               survival_3.8-3
##  [75] ncdf4_1.24                  timeDate_4051.111
##  [77] iterators_1.0.14            tinytex_0.57
##  [79] hardhat_1.4.2               lava_1.8.2
##  [81] statmod_1.5.1               ipred_0.9-15
##  [83] nlme_3.1-168                bit64_4.6.0-1
##  [85] progress_1.2.3              filelock_1.0.3
##  [87] LaplacesDemon_16.1.6        R.cache_0.17.0
##  [89] bslib_0.9.0                 affyio_1.80.0
##  [91] KernSmooth_2.23-26          rpart_4.1.24
##  [93] colorspace_2.1-2            DBI_1.2.3
##  [95] nnet_7.3-20                 tidyselect_1.2.1
##  [97] bit_4.6.0                   compiler_4.5.1
##  [99] curl_7.0.0                  httr2_1.2.1
## [101] graph_1.88.0                xml2_1.4.1
## [103] DelayedArray_0.36.0         plotly_4.11.0
## [105] bookdown_0.45               scales_1.4.0
## [107] caTools_1.18.3              hexbin_1.28.5
## [109] affy_1.88.0                 RBGL_1.86.0
## [111] rappdirs_0.3.3              stringr_1.5.2
## [113] digest_0.6.37               mixtools_2.0.0.1
## [115] rmarkdown_2.30              htmltools_0.5.8.1
## [117] pkgconfig_2.0.3             base64enc_0.1-3
## [119] MatrixGenerics_1.22.0       dbplyr_2.5.1
## [121] fastmap_1.2.0               rlang_1.1.6
## [123] htmlwidgets_1.6.4           farver_2.1.2
## [125] jquerylib_0.1.4             jsonlite_2.0.0
## [127] mclust_6.1.2                ModelMetrics_1.2.2.2
## [129] R.oo_1.27.1                 RCurl_1.98-1.17
## [131] magrittr_2.0.4              viridis_0.6.5
## [133] MsCoreUtils_1.22.0          vsn_3.78.0
## [135] stringi_1.8.7               pROC_1.19.0.1
## [137] MASS_7.3-65                 AnnotationHub_4.0.0
## [139] plyr_1.8.9                  readMzXmlData_2.8.4
## [141] parallel_4.5.1              listenv_0.10.0
## [143] splines_4.5.1               hms_1.1.4
## [145] Spectra_1.20.0              locfit_1.5-9.12
## [147] igraph_2.2.1                RUnit_0.4.33.1
## [149] QFeatures_1.20.0            BiocVersion_3.22.0
## [151] evaluate_1.0.5              foreach_1.5.2
## [153] tidyr_1.3.1                 purrr_1.1.0
## [155] future_1.67.0               clue_0.3-66
## [157] BiocBaseUtils_1.12.0        AnnotationFilter_1.34.0
## [159] viridisLite_0.4.2           class_7.3-23
## [161] tibble_3.3.0                memoise_2.0.1
## [163] timechange_0.3.0            globals_0.18.0
## [165] caret_7.0-1                 sampling_2.11
```

# References

Chambers, M C, B Maclean, R Burke, D Amodei, D L Ruderman, S Neumann, L Gatto, et al. 2012. “A Cross-Platform Toolkit for Mass Spectrometry and Proteomics.” *Nat Biotechnol* 30 (10): 918–20. <https://doi.org/10.1038/nbt.2377>.

Cuadros-Inostroza, Alvaro, Camila Caldana, Henning Redestig, Jan Lisec, Hugo Pena-Cortes, Lothar Willmitzer, and Matthew A Hannah. 2009. “TargetSearch - a Bioconductor Package for the Efficient Pre-Processing of GC-MS Metabolite Profiling Data.” *BMC Bioinformatics* 10: 428. <https://doi.org/10.1186/1471-2105-10-428>.

Durinck, S, Y Moreau, A Kasprzyk, S Davis, B De Moor, A Brazma, and W Huber. 2005. “BioMart and Bioconductor: A Powerful Link Between Biological Databases and Microarray Data Analysis.” *Bioinformatics* 21 (16): 3439–40. <https://doi.org/10.1093/bioinformatics/bti525>.

Gatto, Laurent, and Andy Christoforou. 2013. “Using R and Bioconductor for Proteomics Data Analysis.” *BBA - Proteins and Proteomics*. <https://doi.org/10.1016/j.bbapap.2013.04.032>.

Gatto, L, L M Breckels, T Naake, and S Gibb. 2015. “Visualisation of proteomics data using R and Bioconductor.” *Proteomics*, February. <https://doi.org/10.1002/pmic.201400392>.

Gatto, L, and K S Lilley. 2012. “MSnbase – an R/Bioconductor Package for Isobaric Tagged Mass Spectrometry Data Visualization, Processing and Quantitation.” *Bioinformatics* 28 (2): 288–9. <https://doi.org/10.1093/bioinformatics/btr645>.

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biol* 5 (10): –80. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Gibb, S, and K Strimmer. 2012. “MALDIquant: A Versatile R Package for the Analysis of Mass Spectrometry Data.” *Bioinformatics* 28 (17): 2270–1. <https://doi.org/10.1093/bioinformatics/bts447>.

Piehowski, Paul D., Vladislav A. Petyuk, John D. Sandoval, Kristin E. Burnum, Gary R. Kiebel, Matthew E. Monroe, Gordon A. Anderson, David G Camp 2nd, and Richard D. Smith. 2013. “STEPS: A Grid Search Methodology for Optimized Peptide Identification Filtering of Ms/Ms Database Search Results.” *Proteomics* 13 (5): 766–70. <https://doi.org/10.1002/pmic.201200096>.

Smith, C A, E J Want, G O’Maille, R Abagyan, and G Siuzdak. 2006. “XCMS: Processing Mass Spectrometry Data for Metabolite Profiling Using Nonlinear Peak Alignment, Matching, and Identification.” *Anal Chem* 78 (3): 779–87. <https://doi.org/10.1021/ac051437y>.

Uhlén, Mathias, Erik Björling, Charlotta Agaton, Cristina Al-Khalili A. Szigyarto, Bahram Amini, Elisabet Andersen, Ann-Catrin C. Andersson, et al. 2005. “A human protein atlas for normal and cancer tissues based on antibody proteomics.” *Molecular & Cellular Proteomics : MCP* 4 (12): 1920–32. <https://doi.org/10.1074/mcp.M500279-MCP200>.

Vizcaino, Juan A, Eric W Deutsch, Rui Wang, Attila Csordas, Florian Reisinger, Daniel Rios, Jose A Dianes, et al. 2014. “ProteomeXchange Provides Globally Coordinated Proteomics Data Submission and Dissemination.” *Nat Biotech* 32 (3): 223–26. <https://doi.org/10.1038/nbt.2839>.