# The Shiny Variant Explorer

Kévin Rue-Albrecht1,2\*

1Department of Medicine, Imperial College London, UK
2Nuffield Department of Medicine, University of Oxford, UK

\*kevinrue67@gmail.com

#### 30 October 2025

#### Abstract

[Shiny](http://shiny.rstudio.com) web-application that demonstrates the functionalities of the *TVTB* package integrated in a programming-free environment.

#### Package

BiocStyle 2.38.0

# Contents

* [1 Preliminary notes](#Preliminary)
* [2 Pre-requisites](#Prerequisites)
* [3 Launching the Shiny Variant Explorer](#Launch)
* [4 Overall layout of the web-application](#OverallLayout)
* [5 Input panel](#Input)
  + [5.1 Phenotypes](#InputPhenotypes)
  + [5.2 Genomic ranges](#InputGRanges)
    - [5.2.1 BED file](#InputBED)
    - [5.2.2 UCSC format](#InputUCSC)
    - [5.2.3 Ensembl-based annotation packages](#InputEnsDb)
  + [5.3 Variants](#InputVariants)
    - [5.3.1 Single-VCF mode](#SingleVCF)
    - [5.3.2 Multi-VCF mode](#MultiVCF)
    - [5.3.3 VCF scan parameters](#scanVcfParam)
  + [5.4 Annotations](#EnsDbPkg)
* [6 Frequencies panel](#Frequencies)
  + [6.1 Overall frequencies](#OverallFrequencies)
  + [6.2 Phenotype-level frequencies](#PhenoLevelFrequencies)
* [7 Filters panel](#VcfFilterRules)
* [8 Views panel](#Views)
* [9 Plots panel](#Plots)
* [10 Settings panel](#settings-panel)
  + [10.1 Advanced settings](#AdvancedSettings)
    - [10.1.1 Genotypes](#AdvancedGenotypes)
    - [10.1.2 INFO key suffixes](#AdvancedSuffixes)
    - [10.1.3 Miscellaneous settings](#AdvancedMiscellaneous)
  + [10.2 Parallel settings](#ParallelSettings)
* [11 Session information](#SessionInfo)
* [12 Global configuration](#GlobalConfig)
* [13 Vignette session](#VignetteSessionInfo)
* [14 References](#References)
* **Appendix**

# 1 Preliminary notes

The Shiny Variant Explorer (*tSVE*) was primarily developped to demonstrate
features implemented in the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)*, **not** as a production
environment.
As a result, a few important considerations should be made
to clarify what should and should **not** be expected from the
web-application:

* Bug fixes will be treated with a much lower priority relative to those
  related to package methods.
* It is technically not feasible to offer in a web-interface the same degree
  of flexibility as the command-line environment (*e.g.* `...`111 The `...` argument is called “ellipsis”.).
* Greater control over the input and output data is possible at the
  command-line (*e.g.* refinement of `ggplot` objects,
  definition of custom genomic ranges).
* Requests for new features should apply to the package first.
  Only features relevant to the package functionalities
  may be made available in the web-application.
* Figures (`ggplot`) are currently the only output that can be exported from
  the web-application (using the web browser
  “Download image”, or equivalent context menu item).
  In the future, action buttons may be added to export
  tables (*e.g.* CSV format) and figures (*e.g.* PDF format).
* This vignette is largely static as the web-application may only be used
  in an interactive session.
* First-time users are encouraged to follow this vignette
  sequentially (*i.e* in order, without skipping sections),
  as it takes readers through the sequence of actions of a typical analysis.
  + This vignette was designed to be read beside an open *R* session with
    the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package installed, so that users may follow
    the instructions marked by the word **Action** and bulleted points
    in the following sections.

# 2 Pre-requisites

The *Shiny Variant Explorer* suggests a few additional package dependencies
compared to the package, to support certain forms of data input and display.

**Input**

* The *[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* package and relevant `EnsDb`222 In the future, the web-application may also
  support `TxDb` and `OrganismDb` annotation packages. annotation
  packages are required if that interface is used to query genomic ranges
  (demonstrated in this [section](#InputEnsDb)).
* The *[EnsDb.Hsapiens.v75](https://bioconductor.org/packages/3.22/EnsDb.Hsapiens.v75)* is required to query
  genomic ranges associated by gene names for the demonstration data333 In the future, the web-application may also use annotation packages
  to facet statistics and figures by genomic range(s)..
* The *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package is required if a BED file is used
  to provide genomic ranges (demonstrated in this [section](#InputBED)).

**Display**

* The latest version of the *[DT](https://github.com/rstudio/DT)* package is recommended
  to benefit from the latest developments (*e.g.* column filters inactivated
  if a single value exist in that column; version *>= 0.2.2*).
* The *[shiny](https://github.com/rstudio/shiny)* package is required for all Shiny
  web-applications.

# 3 Launching the Shiny Variant Explorer

The `TVTB::tSVE()` method launches the web-application.

# 4 Overall layout of the web-application

Overall, the web-application is implemented as a web-page
with a top level navigation bar organised
from left to right to reflect progression through a typical analysis,
with the exception of the last two menu items **Settings** and **Session**,
which may be useful to check and update at any point.

Here is a brief overview of the menu items:

* **Input**
  + Control which samples, phenotypes, genomic ranges, and VCF fields
    must be imported.
  + An `EnsDb` annotation package may be selected to use the associated
    database interface.
* **Frequencies**
  + Add and remove INFO fields that contain calculated genotype counts
    and allele frequencies.
  + Add and remove genotype counts and allele frequencies across all
    samples, or within individual phenotype levels.
* **Filters**
  + Define and apply *VCF filter rules* (detailed in a separate vignette).
* **Views**
  + Display and examine major objects of the analysis and their slots.
* **Plots**
  + Display data plots and associated data tables.
* **Settings**
  + Control advanced parameters of the analysis and web-application.
* **Session**
  + Display session information and other relevant information.

# 5 Input panel

The **Input** panel controls the major input parameters of the analysis,
including phenotypes (and therefore samples), genomic ranges,
and fields to import from VCF file(s).
Those inputs are useful to import only data of interest, as well as
to limit memory usage and duration of calculations.

## 5.1 Phenotypes

Phenotypes are critical to define groups of samples that may be compared
in summary statistics, tables, and plots.
Moreover, phenotypes also implicitely define the set of samples required
in the analysis (unique sample identifiers usually set as `rownames`
of the phenotypes).

The web-application accepts phenotypes stored in a text file, with the
following requirements:

* Fields must be delimited by “white space”
  (default separator for the `read.table` function).
* The first column of the file must contain unique sample identifiers,
  as syntactically valid `rownames`.
* The first row of the file must phenotype names, as syntactically valid
  `colnames`.

When provided, phenotypes will be used to import from VCF file(s)
only genotypes for the corresponding samples identifiers.
Moreover, an error message will be displayed if any of the sample identifiers
present in the phenotypes is absent from the VCF file(s).

Note that the web-application does not *absolutely* require phenotype
information. In the absence of phenotype information, all samples are imported
from VCF file(s).

> **Action**:
>
> * Click on the *Browse* action button
> * Navigate to the `extdata` folder of the *TVTB* installation directory
> * Select the file `integrated_samples.txt`
>
> Alternatively: click the *Sample file* button

**Notes**

* The *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* installation directory can be identified
  using the following command in an *R* session:

```
system.file("extdata", package = "TVTB")
```

* The file selection pop-up window that is open by the action button browses
  files on the server side. *This point is only relevant if the
  package/web-application is run on a remote server.*

## 5.2 Genomic ranges

Genomic ranges are critical to import only variants in
targeted genomic regions or features (*e.g.* genes, transcripts, exons),
as well as to limit memory usage and duration of calculations.

The Shiny Variant Explorer currently supports three types of input to define
genomic ranges:

* BED file
* UCSC-style text input
* `EnsDb` annotation packages

Currently, the web-application uses genomic ranges solely
to query the corresponding variants from VCF file(s).
In the future, those genomic ranges may also be used to produce
faceted summary statistics and plots.

**Notes**:

* The web-application does not *absolutely* require genomic ranges.
  In the absence of genomic ranges, all variants are imported from VCF
  file(s). *Caution recommended with large files!*
* When VCF file(s) are parsed (in a later [section](#InputVariants)),
  only the genomic ranges from the currently selected input mode are
* The active genomic ranges are only taken from the currently selected input
  mode

### 5.2.1 BED file

If a BED file is supplied, the web-application parses it using the
*[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* `import.bed` method.
Therefore the file must respect the
[BED file format](https://genome.ucsc.edu/FAQ/FAQformat.html#format1)
guidelines.

> **Action**:
>
> * Click on the *Browse* action button
> * Navigate to the `extdata` folder of the *TVTB* installation directory
> * Select the file `SLC24A5.bed`
>
> Alternatively: click the *Sample file* button

**Notes**:

* The BED file defines the same genomic range
  that was used to extract variant from the
  [1000 Genomes Project](http://www.1000genomes.org) Phase 3
  release VCF file used in this vignette.
* The file selection window that is open by the action button browses
  files on the server side (see [Phenotypes](#InputPhenotypes) section
  above).

### 5.2.2 UCSC format

Sequence names (*i.e.* chromosomes), start, and end positions of one or more
genomic ranges may be defined in the text field,
with individual regions separated by `";"`.

> **Action**:
>
> * Paste `15:48,413,169-48,434,869` in the text field
>
> Alternatively: click the *Sample input* button

**Notes**:

* The web-application automatically trims `","` characters from the text
  input, before coercing the start and end positions to `numeric`
* Multiple genomic ranges may be supplied (*e.g.*
  `1:123-456;2:234-345;2:456-789`)

### 5.2.3 Ensembl-based annotation packages

Currently, genomic ranges encoding only gene-coding regions may be retrieved
from an Ensembl-based database.
This feature was adapted from the web-application implemented in the
*[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* package.

> **Action**:
>
> * Paste `SLC24A5` in the text field
>
> Alternatively: click the *Sample input* button

## 5.3 Variants

At the core of the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package, variants must be imported from
one or more VCF file(s) annotated by the Ensembl Variant Effect Predictor
([VEP](http://www.ensembl.org/info/docs/tools/vep))
script (McLaren et al. [2010](#ref-RN1)).

Considering the large size of most VCF file(s), it is common practice to
split genetic variants into multiple files, each file used to store
variants located on a single chromosome (more generally; a single sequence).
The Shiny Variant Explorer supports two situations:

* All variants are stored in a single VCF file (“Single-VCF” mode).
* Variants are split into one file per sequence, with the requirement that
  files be named with a pattern including the sequence name
  (must match the `seqnames` slot of the genomic ranges described
  [above](#InputGRanges) (“Multi-VCF mode”).

In addition, VCF files can store a plethora of information in their various
fields. It is often useful to select only a subset of fields relevant for
a particular analysis, to limit memory usage.
The web-application uses the
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* `scanVcfHeader` to parse the header of
the VCF file (*Single-VCF* mode) or the first VCF file (*Multi-VCF* mode),
to display the list of available fields that users may choose to import.
A few considerations must be made:

* The web-application requires that Ensembl VEP predictions be present in the
  INFO field.
* The web-application requires that the `"GT"` key be present in the
  FORMAT field.

### 5.3.1 Single-VCF mode

This mode display an action button that must be used to select the VCF file
from which to import variants.

> **Action**:
>
> * Click on the *Browse* action button
> * Navigate to the `extdata` folder of the *TVTB* installation directory
> * Select the file `chr15.phase3_integrated.vcf.gz`
>
> Alternatively: click the *Sample file* button

### 5.3.2 Multi-VCF mode

This mode requires two pieces of information:

* The path to the folder that contains one or more VCF file(s).
* The naming pattern of VCF file(s), with the following requirement:
  + The pattern must include `"%s"` to declare the emplacement of the
    sequence (*i.e.* chromosome) name in the pattern.

Note that a summary of VCF file(s) detected using the given the folder and
pattern is displayed on the right, to help users determine whether the
parameters are correct. In addition, the content of the given folder is
displayed at the bottom of the page, beside the same content filtered for
the VCF file naming pattern.

> **Action**:
>
> *None*. The text fields should already be filled with default values,
> pointing to the single example VCF file (`chr15.phase3_integrated.vcf.gz`).

### 5.3.3 VCF scan parameters

This panel allows users to select the INFO and FORMAT fields to import
(in the `info` and `geno` slots of the `VCF` object, respectively).

It is important to note that the FORMAT/GT and INFO/ fields—where
`<vep>` stands for the INFO key where Ensembl VEP predictions are stored—are
implicitely imported from the VCF.
Similarly, the mandatory FIXED fields `CHROM`, `POS`, `ID`, `REF`, `ALT`,
`QUAL`, and `FILTER` are automatically imported to populate
the `rowRanges` slot of the `VCF` object.

> **Action**:
>
> * Click the *Deselect all* action button under the *INFO fields*
>   selection input to import only the INFO/CSQ and FORMAT/GT fields.
> * Click the *Import variants* action button
>
> A summary of variants, phenotypes, and samples imported will appear beside
> the action button.

## 5.4 Annotations

This panel allows users to select a pre-installed annotation package.
Currently, only `EnsDb` annotation packages are supported,
and only **gene**-coding regions may be queried.

> **Action**:
>
> * If none of the `EnsDb` packages are installed, it will simply **not** be
>   possible to use the `ensembl` interface of the *Genomic ranges* input
>   tab.
> * If the `EnsDb.Hsapiens.v75` package is the only `EnsDb` packages installed,
>   no action is required; the package should already be pre-selected.
> * If the `EnsDb.Hsapiens.v75` package is **not** the only `EnsDb` packages
>   installed, users should select it in the list of choices.

# 6 Frequencies panel

This panel demonstrates the use of three methods implemented in the
*[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package, namely `addFrequencies`, `addOverallFrequencies`,
and `addPhenoLevelFrequencies`.

## 6.1 Overall frequencies

This panel allows users to *Add* and *Remove* INFO fields
that contain genotype counts
(*i.e.* homozygote reference, heterozygote, homozygote alternate)
and allele frequencies
(*i.e.* alternate allele frequency, minor allele frequency)
calculated across all the samples and variants imported.
The web-application uses the homozygote reference, heterozygote,
and homozygote alternate genotypes defined in the
[Advanced settings](#AdvancedSettings)
panel.

Importantly, the name of the INFO keys that are used to store
the calculated values can be defined in the
[Advanced settings](#AdvancedSettings) panel.

> **Action**:
>
> * Click the *Add* action button
> * See the *Latest changes* message update at the top of the screen.
> * Optionally, the [Views](#Views) panel can be used to examine the new fields

## 6.2 Phenotype-level frequencies

This panel allows users to *Refresh* the list of INFO fields
that contain genotype counts and allele frequencies
calculated within *groups of samples* associated with
various levels of a given phenotype.

> **Action**:
>
> * Select `super_pop` in the list of phenotypes
> * Click the *Select all* action button
> * Click the *Refresh* action button
> * See the *Latest changes* message update at the top of the screen.
> * Optionally, the [Views](#Views) panel can be used to examine the new fields

# 7 Filters panel

One of the flagship features of the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package
are the *VCF filter rules*, extending the
*[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* `FilterRules` class to new classes of filter rules
that can be evaluated within environments defined by the various slots
of `VCF` objects.

Generally speaking, `FilterRules` greatly facilitate the design
and combination of powerful filter rules for table-like objects,
such as the `fixed` and `info` slots of
*[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* `VCF` objects,
as well as Ensembl VEP predictions stored in the meta-columns of `GRanges`
returned by the *[ensemblVEP](https://bioconductor.org/packages/3.22/ensemblVEP)* `parseCSQToGRanges` method.

A separate vignette describes in greater detail the use of classes
that contain *VCF filter rules*. A simple example is shown below.

> **Action**:
>
> * Select `VEP` as the *Type* of filter
> * Paste `grepl("missense",Consequence)` in the text field
> * Leave the *Active?* checkbox ticked
> * Click the *Add filter* action button
> * See the list of rules update at the bottom of the screen
> * Click the *Apply filters* action button
> * See the summary of filtered variants update beside the action button
> * Optionally, the [Views](#Views) panel can be used to examine the new fields
>
> Alternatively: click the *Sample input* button

# 8 Views panel

This panel offers the chance to examine the main objects of the session,
namely:

* The active genomic ranges
* The `rowRanges` and selected meta-columns of the filtered variants.
* Selected field of the `info` slot (of the filtered variants).
* Selected Ensembl VEP predictions (of the filtered variants).
* Selected phenotypes attached to the variants.
* Subset of genotypes (among the filtered variants).
  + Genotypes for all filtered variants may be displayed as a heatmap
    (`ggplot`).

> **Action**:
>
> * In the various panels, select fields to examine each object
>   + In particular, note the INFO fields that contain genotype counts
>     and allele frequencies calculated [earlier](#Frequencies)
> * Go to the *Heatmap* tab of the *Genotypes* panel
> * Click the *Go!* action button to calculate and display the heatmap

# 9 Plots panel

This panel demonstrates the use of two methods implemented in the
*[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package, namely `tabulateVepByPhenotype`
and `densityVepByPhenotype`.

# 10 Settings panel

This panel stores more advanced settings that users may not need to edit as
frequently, if at all. Those settings are divided in two sub-panels:

* **Advanced**
  + Genotypes, INFO key suffixes, and VCF yield size
* **Parallel**
  + Use of multiple CPUs to accelerate calculations

## 10.1 Advanced settings

### 10.1.1 Genotypes

It is critical to accurately identify and define how the different
genotypes—homozygote reference, heterozygote, and homozygote alternate—are
encoded in the VCF file, to produce accurate
[genotypes counts and frequencies](#Frequencies), for instance.
This generally requires examining the
content of the FORMAT/GT field outside of the web-application.
For instance, the functions `unique` and `table` may be used to identify
(and count) all the distinct genotype codes in the `geno` slot (`"GT"` key) of
a `VCF` object.

The default selected values are immediately compatible with the demonstration
data set. Users who wish to select genotypes codes not yet available
among the current choices may
either contact the package maintainer to add them in a future release,
or edit the [Global configuration file](#GlobalConfig)
of the web-application locally.

### 10.1.2 INFO key suffixes

Currently, the three calculated genotypes counts and two allele frequencies
require five INFO fields to store their respective values.

Considering that *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* offers the possibility to calculate
counts and frequencies for the overall data set, and for each level of each
phenotype, it is important to define a clear and consistent naming mechanism
that does not conflict with INFO keys imported from the VCF file(s).
In the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package, a suffix is required for each type of
genotype and frequency calculated, to generate INFO as follows:

* Overall counts and frequencies are stored in INFO keys named `<suffix>`
* Counts and frequencies calculated for individual levels of
  selected phenotypes are stored under INFO keys formed as
  `<phenotype>_<level>_<suffix>`

Again, the default values are immediately compatible with the demonstration
data set. For other data sets, it may be necessary to change those values,
either by preference, or to avoid conflict with INFO keys imported from
the VCF file(s).

### 10.1.3 Miscellaneous settings

Other rarely used settings in this panel include:

* VCF yield size
  + Only applicable when VCF file(s) are parsed without defined
    [genomic ranges](#InputGRanges). See the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)*
    documentation.

## 10.2 Parallel settings

Several functionalities of the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* package are applied
to independent subsets of data (*e.g.* counting genotypes in various levels
of a given phenotype). Such processes can benefit from multi-threaded
calculations. Multi-threading settings in the Shiny web-application are
somewhat experimental, as they have been validated only on a small set of
operating systems, while some issues have been reported for others.

| Report | Operating System | Cluster Class | Cluster type | # Cores |
| --- | --- | --- | --- | --- |
| OK | Ubuntu 14.04 | Multicore | FORK | 2 |
| OK | Scientific Linux 6.7 | Multicore | FORK | 2 |
| Hang1 | OS X El Capitan | Snow | SOCK | 2 |

1. Application hangs while CPUs work infinitely at full capacity.

# 11 Session information

The last panel of the Shiny Variant Explorer offers detailed views of
objects and settings in the current session, including:

* **Session info**
  + The `sessionInfo()` value
* **TVTB settings**
  + See the vignette *Introduction to TVTB* for more information
* **General settings**
  + Including the current value of various input widgets
* **Advanced settings**
  + including the current value of more input widgets
* **BED**
  + Structural view of the active genomic ranges
* **Variants**
  + Overview of the raw `VCF` object
* **VEP**
  + Structural view of the `GRanges` that store the Ensembl VEP predictions
* **Phenotypes**
  + Structural view of the phenotype information attached to the variants
* **Genotypes**
  + Structural view of the `geno` slot (`"GT"` key) of the raw variants

# 12 Global configuration

Most default values are stored in the `global.R` file of the web-application.
All the files of the web-application are stored in the `extdata/shinyApp`
folder of the *[TVTB](https://bioconductor.org/packages/3.22/TVTB)* installation directory
(see an [earlier section](#InputPhenotypes) to identify this directory).

Users who wish to change the default values of certain input widgets
(*e.g.* genotype codes)
may edit the `global.R` file accordingly. However, the file will be reset at
each package update.

# 13 Vignette session

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] TVTB_1.36.0      knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                GenomicFeatures_1.62.0
##   [7] farver_2.1.2                rmarkdown_2.30
##   [9] BiocIO_1.20.0               vctrs_0.6.5
##  [11] memoise_2.0.1               Rsamtools_2.26.0
##  [13] RCurl_1.98-1.17             base64enc_0.1-3
##  [15] tinytex_0.57                htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0             progress_1.2.3
##  [19] curl_7.0.0                  SparseArray_1.10.0
##  [21] Formula_1.2-5               sass_0.4.10
##  [23] bslib_0.9.0                 htmlwidgets_1.6.4
##  [25] plyr_1.8.9                  Gviz_1.54.0
##  [27] httr2_1.2.1                 cachem_1.1.0
##  [29] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [31] pkgconfig_2.0.3             Matrix_1.7-4
##  [33] R6_2.6.1                    fastmap_1.2.0
##  [35] MatrixGenerics_1.22.0       digest_0.6.37
##  [37] colorspace_2.1-2            GGally_2.4.0
##  [39] AnnotationDbi_1.72.0        S4Vectors_0.48.0
##  [41] Hmisc_5.2-4                 GenomicRanges_1.62.0
##  [43] RSQLite_2.4.3               labeling_0.4.3
##  [45] filelock_1.0.3              httr_1.4.7
##  [47] abind_1.4-8                 compiler_4.5.1
##  [49] withr_3.0.2                 bit64_4.6.0-1
##  [51] pander_0.6.6                htmlTable_2.4.3
##  [53] S7_0.2.0                    backports_1.5.0
##  [55] BiocParallel_1.44.0         DBI_1.2.3
##  [57] ggstats_0.11.0              biomaRt_2.66.0
##  [59] rappdirs_0.3.3              DelayedArray_0.36.0
##  [61] rjson_0.2.23                tools_4.5.1
##  [63] foreign_0.8-90              nnet_7.3-20
##  [65] glue_1.8.0                  restfulr_0.0.16
##  [67] grid_4.5.1                  checkmate_2.3.3
##  [69] reshape2_1.4.4              cluster_2.1.8.1
##  [71] generics_0.1.4              gtable_0.3.6
##  [73] BSgenome_1.78.0             tidyr_1.3.1
##  [75] ensembldb_2.34.0            data.table_1.17.8
##  [77] hms_1.1.4                   XVector_0.50.0
##  [79] BiocGenerics_0.56.0         pillar_1.11.1
##  [81] stringr_1.5.2               limma_3.66.0
##  [83] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [85] lattice_0.22-7              deldir_2.0-4
##  [87] rtracklayer_1.70.0          bit_4.6.0
##  [89] EnsDb.Hsapiens.v75_2.99.0   biovizBase_1.58.0
##  [91] tidyselect_1.2.1            Biostrings_2.78.0
##  [93] gridExtra_2.3               bookdown_0.45
##  [95] IRanges_2.44.0              Seqinfo_1.0.0
##  [97] ProtGenerics_1.42.0         SummarizedExperiment_1.40.0
##  [99] stats4_4.5.1                xfun_0.53
## [101] Biobase_2.70.0              statmod_1.5.1
## [103] matrixStats_1.5.0           stringi_1.8.7
## [105] UCSC.utils_1.6.0            lazyeval_0.2.2
## [107] yaml_2.3.10                 evaluate_1.0.5
## [109] codetools_0.2-20            cigarillo_1.0.0
## [111] interp_1.1-6                tibble_3.3.0
## [113] BiocManager_1.30.26         cli_3.6.5
## [115] rpart_4.1.24                jquerylib_0.1.4
## [117] dichromat_2.0-0.1           Rcpp_1.1.0
## [119] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [121] png_0.1-8                   XML_3.99-0.19
## [123] parallel_4.5.1              ggplot2_4.0.0
## [125] blob_1.2.4                  prettyunits_1.2.0
## [127] jpeg_0.1-11                 latticeExtra_0.6-31
## [129] AnnotationFilter_1.34.0     bitops_1.0-9
## [131] VariantAnnotation_1.56.0    scales_1.4.0
## [133] purrr_1.1.0                 crayon_1.5.3
## [135] rlang_1.1.6                 KEGGREST_1.50.0
```

# 14 References

McLaren, W., B. Pritchard, D. Rios, Y. Chen, P. Flicek, and F. Cunningham. 2010. “Deriving the Consequences of Genomic Variants with the Ensembl API and SNP Effect Predictor.” Journal Article. *Bioinformatics* 26 (16): 2069–70. <https://doi.org/10.1093/bioinformatics/btq330>.

# Appendix