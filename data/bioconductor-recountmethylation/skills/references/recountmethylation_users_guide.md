Code

* Show All Code
* Hide All Code

# recountmethylation User’s Guide

Sean K. Maden, Reid F. Thompson, Kasper D. Hansen and Abhinav Nellore

#### 30 October, 2025

#### Package

recountmethylation 1.20.0

# Contents

* [1 Introduction and overview](#introduction-and-overview)
  + [1.1 Compilation releases](#compilation-releases)
  + [1.2 Database files and access](#database-files-and-access)
  + [1.3 ExperimentHub integration](#experimenthub-integration)
  + [1.4 Disclaimer](#disclaimer)
* [2 Background](#background)
  + [2.1 DNAm arrays](#dnam-arrays)
  + [2.2 `SummarizedExperiment` object classes](#summarizedexperiment-object-classes)
  + [2.3 Database file types](#database-file-types)
  + [2.4 Sample metadata](#sample-metadata)
* [3 `HDF5-SummarizedExperiment` example](#hdf5-summarizedexperiment-example)
  + [3.1 Obtain the test database](#obtain-the-test-database)
  + [3.2 Inspect and summarize the database](#inspect-and-summarize-the-database)
* [4 `HDF5` database and example](#hdf5-database-and-example)
  + [4.1 Obtain the test database](#obtain-the-test-database-1)
  + [4.2 Inspect and summarize the database](#inspect-and-summarize-the-database-1)
* [5 Validate DNAm datasets](#validate-dnam-datasets)
  + [5.1 Download and read IDATs from the GEO database server](#download-and-read-idats-from-the-geo-database-server)
  + [5.2 Compare DNAm signals](#compare-dnam-signals)
  + [5.3 Compare DNAm Beta-values](#compare-dnam-beta-values)
* [6 Troubleshooting and tips](#troubleshooting-and-tips)
  + [6.1 Issue: large file downloads don’t complete](#issue-large-file-downloads-dont-complete)
  + [6.2 Issue: unexpected function behaviors for `DelayedArray` inputs](#issue-unexpected-function-behaviors-for-delayedarray-inputs)
* [7 Get more help](#get-more-help)
* [8 Session info](#session-info)
* [Works Cited](#works-cited)

# 1 Introduction and overview

`recountmethylation` is an R/Bioconductor package providing resources to access
and analyze compilations of public DNA methylation (DNAm) array data from the
Gene Expression Omnibus (GEO). The database compilation files span two array
platforms and include mined, mapped, and model-based sample metadata. The DNAm
signals can be accessed in a variety of formats and data storage types. This
User’s Guide shows how to use the `recountmethylation` package, including
crucial background about the platforms and datatypes, and runnable examples using
2 small example files. Additional info and more advanced analysis examples are
contained in other package vignettes.

## 1.1 Compilation releases

The `recountmethylation` resource now includes three compilation versions,
detailed in the table below. The initial versions only included samples run
using the HM450K platform, while newer versions also included samples run using
the EPIC platform. These compilations currently include 93,306 samples run on the HM450K
platform, 38,122 samples run on the EPIC platform, and 131,428 total samples.

```
dft <- data.frame(release = c("first", "second", "third", "total"),
                  version.label = c("0.0.1", "0.0.2", "0.0.3", "all"),
                  date = c("11/20/2020", "01/06/2021", "12/21/2022", "12/21/2022"),
                  hm450k.samples = c(35360, 50400, 7546,
                                     sum(c(35360, 50400, 7546))),
                  epic.samples = c(0, 12650, 25472,
                                   sum(c(0, 12650, 25472))))
dft$combined.samples <- dft$hm450k.samples + dft$epic.samples
knitr::kable(dft, align = "c")
```

| release | version.label | date | hm450k.samples | epic.samples | combined.samples |
| --- | --- | --- | --- | --- | --- |
| first | 0.0.1 | 11/20/2020 | 35360 | 0 | 35360 |
| second | 0.0.2 | 01/06/2021 | 50400 | 12650 | 63050 |
| third | 0.0.3 | 12/21/2022 | 7546 | 25472 | 33018 |
| total | all | 12/21/2022 | 93306 | 38122 | 131428 |

## 1.2 Database files and access

Database compilation file download and access is managed by the `get_db`
functions, where the DNAm array platform type using the `platform` argument
(see `?get_db` for details). Both HM450K and EPIC/HM850K platforms are
currently supported (see below for platform details). Note you will need
between 50-180 Gb of disk space to store a single database file. Files pair
sample metadata and assay data in various formats, including `HDF5-SummarizedExperiment`
database directories, and `HDF5` database files with the `.h5` extension.

The databases are located at
<https://methylation.recount.bio/>,
and file details are viewable as follows:

```
sm <- as.data.frame(smfilt(get_servermatrix()))
if(is(sm, "data.frame")){knitr::kable(sm, align = "c")}
```

| filename | date | time | size (bytes) |
| --- | --- | --- | --- |
| remethdb\_h5-rg\_epic\_0-0-2\_1589820348.h5 | 14-Nov-2023 | 19:32 | 66751358297 |
| remethdb\_h5se-gm\_epic\_0-0-2\_1589820348 | 14-Nov-2023 | 17:18 | `assays.h5` = 56956363488;`se.rds` = 8475111 |
| remethdb\_h5se-gr\_epic\_0-0-2\_1607018051 | 14-Nov-2023 | 20:08 | `assays.h5` = 82090895411;`se.rds` = 8475201 |
| remethdb\_h5se-rg\_epic\_0-0-2\_1589820348 | 14-Nov-2023 | 20:20 | `assays.h5` = 68707689800;`se.rds` = 3059883 |
| remethdb\_h5-rg\_hm450k\_0-0-2\_1607018051.h5 | 14-Nov-2023 | 22:21 | 193342823766 |
| remethdb\_h5se-gm\_hm450k\_0-0-2\_1607018051 | 14-Nov-2023 | 17:52 | `assays.h5` = 130935841655;`se.rds` = 5372091 |
| remethdb\_h5se-gr\_hm450k\_0-0-2\_1607018051 | 14-Nov-2023 | 23:01 | `assays.h5` = 184355830172;`se.rds` = 5372008 |
| remethdb\_h5se-rg\_hm450k\_0-0-2\_1607018051 | 14-Nov-2023 | 18:29 | `assays.h5` = 164788908310;`se.rds` = 3179962 |
| remethdb-h5se\_gr-test\_0-0-1\_1590090412 | 14-Nov-2023 | 21:53 | `assays.h5` = 132596;`se.rds` = 68522 |
| remethdb-h5\_rg-test\_0-0-1\_1590090412.h5 | 14-Nov-2023 | 21:28 | 252757 |

## 1.3 ExperimentHub integration

The DNAm array database files are indexed on `ExperimentHub`, and are
viewable as follows. Note, the cache needs to be set with `R_user_dir()` per instructions [here](https://bioconductor.org/packages/devel/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html#default-caching-location-update).

```
cache.path <- tools::R_user_dir("recountmethylation")
setExperimentHubOption("CACHE", cache.path)
hub <- ExperimentHub::ExperimentHub()                    # connect to the hubs
rmdat <- AnnotationHub::query(hub, "recountmethylation") # query the hubs
```

In addition to using the `getdb` functions, the `HDF5` (“.h5”" extension)
files may be downloaded from the hubs.

```
fpath <- rmdat[["EH3778"]] # download with default caching
rhdf5::h5ls(fpath)         # load the h5 file
```

Note that whether downloads use the hubs or `getdb` functions, caching
is implemented to check for previously downloaded database files.

## 1.4 Disclaimer

Please note the following disclaimer, which also shows when `recountmethylation`
is loaded:

```
Databases accessed with `recountmethylation` contain data from GEO
(ncbi.nlm.nih.gov/geo/), a live public database where alterations to
online records can cause discrepancies with stored data over time.
We cannot guarantee the accuracy of stored data, and advise users
cross-check their findings with latest available records.
```

# 2 Background

This section includes essential background about DNAm array platforms, assays
and file types, and sample metadata.

## 2.1 DNAm arrays

Databases include human samples run on the Illumina Infinium HM450K BeadArray
platform. HM450K is a popular 2-channel platform that probes over 480,000 CpG
loci genome-wide, with enriched coverage at CG islands, genes, and enhancers
[[1](#ref-sandoval_validation_2011)]. The more recently released EPIC/HM850K platform
contains an expanded probe set targeting over 850,000 CpGs, including
more than 90% of the HM450K probes, with greater coverage of potential intergenic
regulatory regions [[2](#ref-pidsley_critical_2016)].

Array processing generates 2 intensity files (IDATs) per sample, one each for
the red and green color channels. These raw files also contain control signals
useful for quality evaluations [[3](#ref-noauthor_illumina_2010)]. The BeadArray probes use
either of 2 bead technologies, known as Type I and Type II, where the majority
(72%) of probes use the latter. For Type II probes, a single bead assay informs
a single probe, while Type I probes use 2 beads each. Practically, this means
the bead-specific matrices found in `RGChannelSet` objects are larger than the
probe-specific matrices found in derived object types (e.g. for HM450K samples,
622,399 assays for red/green signal matrices versus 485,512 assays for
methylated/unmethylated signal, DNAm fractions matrices, see below).

## 2.2 `SummarizedExperiment` object classes

DNAm array sample IDATs can be read into an R session as an object of class
`RGChannelSet`, a type of `SummarizedExperiment`. These objects support
analyses of high-throughput genomics datasets, and they include slots for
assay matrices, sample metadata, and experiment metadata. During a typical
workflow, normalization and preprocessing convert `RGChannelSet` objects into
new types like `MethylSet` and `RatioSet`. While not all IDAT information is
accessible from every object type (e.g. only `RGChannelSet`s can contain
control assays), derived objects like `MethylSet`s and `RatioSet`s may be
smaller and/or faster to access.

Three `SummarizedExperiment` databases are provided as
`HDF5-SummarizedExperiment` files, including an unnormalized `RGChannelSet`
(red/green signals), an unnormalized `MethylSet` (methylated/unmethylated
signals) and a normalized `GenomicRatioSet` (DNAm fractions). For the latter,
DNAm fractions (logit2 Beta-values, or M-values) were normalized using the
out-of-band signal or “noob” method, an effective within-sample normalization
that removes signal artifacts [[4](#ref-triche_low-level_2013)].

## 2.3 Database file types

Database files are stored as either `HDF5` or `HDF5-SummarizedExperiment`. For
most R users, the latter files will be most convenient to work with. `HDF5`, or
hierarchical data format 5, combines compression and chunking for convenient
handling of large datasets. `HDF5-SummarizedExperiment` files combine the
benefits of `HDF5` and `SummarizedExperiment` entities using a
DelayedArray-powered backend. Once an `HDF5-SummarizedExperiment` file is
loaded, it can be treated similarly to a `SummarizedExperiment` object in
active memory. That is, summary and subset operations execute rapidly, and
realization of large data chunks in active memory is delayed until called for
by the script (see examples).

## 2.4 Sample metadata

Sample metadata are included with DNAm assays in the database files. Currently,
metadata variables include GEO record IDs for samples (GSM) and studies (GSE),
sample record titles, learned labels for tissue and disease, sample type
predictions from the MetaSRA-pipeline, and DNAm model-based predictions for
age, sex, and blood cell types. Access sample metadata from
`SummarizedExperiment` objects using the `pData` minfi function (see examples).
Examples in the `data_analyses` vignette illustrate some ways to utilize the
provided sample metadata.

Provided metadata derives from the GSE-specific SOFT files, which contain
experiment, sample, and platform metadata. Considerable efforts were made to
learn, harmonize, and predict metadata labels. Certain types of info lacking
in the `recountmethylation` metadata may be available in the SOFT files,
especially if it is sample non-specific (e.g. methods text, PubMed ID, etc.)
or redundant with DNAm-derived metrics (e.g. DNAm summaries, predicted sex,
etc.).

It is good practice to validate the harmonized metadata with original metadata
records, especially where labels are ambiguous or there is insufficient
information for a given query. GEO GSM and GSE records can be viewed from a
browser, or SOFT files may be downloaded directly. Packages like GEOmetadb and
GEOquery are also useful to query and summarize GEO metadata.

# 3 `HDF5-SummarizedExperiment` example

This example shows basic handling for `HDF5-SummarizedExperiment` (a.k.a.
“h5se”) files. For these files, the `getdb` function returns the loaded file.
Thanks to a `DelayedArray` backend, even full-sized `h5se` databases can be
treated as if they were fully loaded into active memory.

## 3.1 Obtain the test database

The test `h5se` dataset includes sample metadata and noob-normalized
DNAm fractions (Beta-values) for chromosome 22 probes for 2 samples.
Datasets can be downloaded using the `getdb` series of functions
(see `?getdb` for details), where the `dfp` argument specifies the
download destination. The test `h5se` file is included in the package
“inst” directory, and can be loaded as follows.

```
dn <- "remethdb-h5se_gr-test_0-0-1_1590090412"
path <- system.file("extdata", dn, package = "recountmethylation")
h5se.test <- HDF5Array::loadHDF5SummarizedExperiment(path)
```

## 3.2 Inspect and summarize the database

Common characterization functions can be used on the dataset after it has been
loaded. These include functions for `SummarizedExperiment`-like objects, such
as the `getBeta`, `pData`, and `getAnnotation` minfi functions. First, inspect
the dataset using standard functions like `class`, `dim`, and `summary` as
follows.

```
class(h5se.test) # inspect object class
```

```
## [1] "GenomicRatioSet"
## attr(,"package")
## [1] "minfi"
```

```
dim(h5se.test) # get object dimensions
```

```
## [1] 8552    2
```

```
summary(h5se.test) # summarize dataset components
```

```
## [1] "GenomicRatioSet object of length 8552 with 0 metadata columns"
```

Access the sample metadata for the 2 available samples using `pData`.

```
h5se.md <- minfi::pData(h5se.test) # get sample metadata
dim(h5se.md)                       # get metadata dimensions
```

```
## [1]  2 19
```

```
colnames(h5se.md) # get metadata column names
```

```
##  [1] "gsm"            "gsm_title"      "gseid"          "disease"
##  [5] "tissue"         "sampletype"     "arrayid_full"   "basename"
##  [9] "age"            "predage"        "sex"            "predsex"
## [13] "predcell.CD8T"  "predcell.CD4T"  "predcell.NK"    "predcell.Bcell"
## [17] "predcell.Mono"  "predcell.Gran"  "storage"
```

Next get CpG probe-specific DNAm fractions, or “Beta-values”, with `getBeta`
(rows are probes, columns are samples).

```
h5se.bm <- minfi::getBeta(h5se.test) # get dnam fractions
dim(h5se.bm)                         # get dnam fraction dimensions
```

```
## [1] 8552    2
```

```
colnames(h5se.bm) <- h5se.test$gsm       # assign sample ids to dnam fractions
knitr::kable(head(h5se.bm), align = "c") # show table of dnam fractions
```

|  | GSM1038308 | GSM1038309 |
| --- | --- | --- |
| cg00017461 | 0.9807283 | 0.9746836 |
| cg00077299 | 0.3476970 | 0.3456837 |
| cg00079563 | 0.8744652 | 0.9168005 |
| cg00087182 | 0.9763206 | 0.9760947 |
| cg00093544 | 0.0225112 | 0.0265087 |
| cg00101350 | 0.9736359 | 0.9789818 |

Access manifest information for probes with `getAnnotation`. This includes the
bead addresses, probe type, and genome coordinates and regions. For full details
about the probe annotations, consult the minfi and Illumina platform documentation.

```
an <- minfi::getAnnotation(h5se.test) # get platform annotation
dim(an)                               # get annotation dimensions
```

```
## [1] 8552   33
```

```
colnames(an) # get annotation column names
```

```
##  [1] "chr"                      "pos"
##  [3] "strand"                   "Name"
##  [5] "AddressA"                 "AddressB"
##  [7] "ProbeSeqA"                "ProbeSeqB"
##  [9] "Type"                     "NextBase"
## [11] "Color"                    "Probe_rs"
## [13] "Probe_maf"                "CpG_rs"
## [15] "CpG_maf"                  "SBE_rs"
## [17] "SBE_maf"                  "Islands_Name"
## [19] "Relation_to_Island"       "Forward_Sequence"
## [21] "SourceSeq"                "Random_Loci"
## [23] "Methyl27_Loci"            "UCSC_RefGene_Name"
## [25] "UCSC_RefGene_Accession"   "UCSC_RefGene_Group"
## [27] "Phantom"                  "DMR"
## [29] "Enhancer"                 "HMM_Island"
## [31] "Regulatory_Feature_Name"  "Regulatory_Feature_Group"
## [33] "DHS"
```

```
ant <- as.matrix(t(an[c(1:4), c(1:3, 5:6, 9, 19, 24, 26)])) # subset annotation
knitr::kable(ant, align = "c")                              # show annotation table
```

|  | cg00017461 | cg00077299 | cg00079563 | cg00087182 |
| --- | --- | --- | --- | --- |
| chr | chr22 | chr22 | chr22 | chr22 |
| pos | 30663316 | 18632618 | 43253521 | 24302043 |
| strand | - | + | + | + |
| AddressA | 31616369 | 13618325 | 65630302 | 37797387 |
| AddressB | 70798487 | 37626331 | 55610348 | 20767312 |
| Type | I | I | I | I |
| Relation\_to\_Island | OpenSea | N\_Shore | Island | N\_Shore |
| UCSC\_RefGene\_Name | OSM | USP18 | ARFGAP3;ARFGAP3 | GSTT2B;GSTT2 |
| UCSC\_RefGene\_Group | TSS1500 | TSS200 | TSS200;TSS200 | Body;Body |

# 4 `HDF5` database and example

To provide more workflow options, bead-specific red and green signal data have
been provided with sample metadata in an `HDF5`/`h5` file. This example shows
how to handle objects of this type with `recountmethylation`.

## 4.1 Obtain the test database

The test `h5` file includes metadata and bead-specific signals from
chromosome 22 for the same 2 samples as in the `h5se` test file.
Note `getdb` functions for `h5` files simply return the database path.
Since the test `h5` file has also been included in the package “inst” folder,
get the path to load the file as follows.

```
dn <- "remethdb-h5_rg-test_0-0-1_1590090412.h5"     # get the h5se directory name
h5.test <- system.file("extdata", "h5test", dn,
                    package = "recountmethylation") # get the h5se dir path
```

## 4.2 Inspect and summarize the database

Use the file path to read data into an `RGChannelSet` with the `getrg`
function. Setting `all.gsm = TRUE` obtains data for all samples in the
database files, while passing a vector of GSM IDs to `gsmv` argument
will query a subset of available samples. Signals from all available
probes are retrieved by default, and probe subsets can be obtained by
passing a vector of valid bead addresses to the `cgv` argument.

```
h5.rg <- getrg(dbn = h5.test, all.gsm = TRUE) # get red/grn signals from an h5 db
```

To avoid exhausting active memory with the full-sized `h5` dataset, provide
either `gsmv` or `cgv` to `getrg`, and set either `all.cg` or `all.gsm` to
FALSE (see `?getrg` for details).

As in the previous example, use `pData` and `getAnnotation` to get sample
metadata and array manifest information, respectively. Access the green and
red signal matrices in the `RGChannelSet` with the `getRed` and `getGreen`
minfi functions.

```
h5.red <- minfi::getRed(h5.rg)     # get red signal matrix
h5.green <- minfi::getGreen(h5.rg) # get grn signal matrix
dim(h5.red)                        # get dimensions of red signal matrix
```

```
## [1] 11162     2
```

```
knitr::kable(head(h5.red), align = "c") # show first rows of red signal matrix
```

|  | GSM1038308 | GSM1038309 |
| --- | --- | --- |
| 10601475 | 1234 | 1603 |
| 10603366 | 342 | 344 |
| 10603418 | 768 | 963 |
| 10605304 | 2368 | 2407 |
| 10605460 | 3003 | 3322 |
| 10608343 | 357 | 399 |

```
knitr::kable(head(h5.green), align = "c") # show first rows of grn signal matrix
```

|  | GSM1038308 | GSM1038309 |
| --- | --- | --- |
| 10601475 | 6732 | 8119 |
| 10603366 | 288 | 356 |
| 10603418 | 267 | 452 |
| 10605304 | 4136 | 4395 |
| 10605460 | 1395 | 1762 |
| 10608343 | 840 | 1269 |

```
identical(rownames(h5.red), rownames(h5.green)) # check cpg probe names identical
```

```
## [1] TRUE
```

Rows in these signal matrices map to bead addresses rather than probe IDs.
These matrices have more rows than the `h5se` test Beta-value matrix because
any type I probes use data from 2 beads each.

# 5 Validate DNAm datasets

This section demonstrates validation using the test databases. Full code
to reproduce this section is provided but not evaluated, as it involves a
download from the GEO servers. As the disclaimer notes, it is good practice
to validate data against the latest available GEO files. This step may be
most useful for newer samples published close to the end compilation date
(through November 7, 2020 for current version), which may be more prone to
revisions at initial publication.

## 5.1 Download and read IDATs from the GEO database server

Use the `gds_idat2rg` function to download IDATs for the 2 test samples
and load these into a new `RGChannelSet` object. Do this by passing a vector
of GSM IDs to `gsmv` and the download destination to `dfp`. (note, chunks in
this section are fully executable, but not evaluated for this vignette).

```
# download from GEO
dlpath <- tempdir()                                     # get a temp dir path
gsmv <- c("GSM1038308", "GSM1038309")                   # set sample ids to identify
geo.rg <- gds_idat2rg(gsmv, dfp = dlpath)               # load sample idats into rgset
colnames(geo.rg) <- gsub("\\_.*", "", colnames(geo.rg)) # assign sample ids to columns
```

## 5.2 Compare DNAm signals

Extract the red and green signal matrices from `geo.rg`.

```
geo.red <- minfi::getRed(geo.rg)      # get red signal matrix
geo.green <- minfi::getGreen(geo.rg)  # get grn signal matrix
```

Match indices and labels between the GEO and `h5` test signal matrices.

```
int.addr <- intersect(rownames(geo.red), rownames(h5.red)) # get probe address ids
geo.red <- geo.red[int.addr,]                              # subset geo rgset red signal
geo.green <- geo.green[int.addr,]                          # subset gro rgset grn signal
geo.red <- geo.red[order(match(rownames(geo.red), rownames(h5.red))),]
geo.green <- geo.green[order(match(rownames(geo.green), rownames(h5.green))),]
identical(rownames(geo.red), rownames(h5.red))             # check identical addresses, red
identical(rownames(geo.green), rownames(h5.green))         # check identical addresses, grn
class(h5.red) <- "integer"; class(h5.green) <- "integer"   # set matrix data classes to integer
```

Finally, compare the signal matrix data.

```
identical(geo.red, h5.red) # compare matrix signals, red
```

```
identical(geo.green, h5.green) # compare matrix signals, grn
```

## 5.3 Compare DNAm Beta-values

Before comparing the GEO-downloaded data to data from the `h5se.test` database,
normalize the data using the same out-of-band or “noob” normalization technique
that was used to generate data in the `h5se` database.

```
geo.gr <- minfi::preprocessNoob(geo.rg) # get normalized se data
```

Next, extract the Beta-values.

```
geo.bm <- as.matrix(minfi::getBeta(geo.gr)) # get normalized dnam fractions matrix
```

Now match row and column labels and indices.

```
h5se.bm <- as.matrix(h5se.bm) # set dnam fractions to matrix
int.cg <- intersect(rownames(geo.bm), rownames(h5se.bm))
geo.bm <- geo.bm[int.cg,]     # subset fractions on shared probe ids
geo.bm <- geo.bm[order(match(rownames(geo.bm), rownames(h5se.bm))),]
```

Finally, compare the two datasets.

```
identical(summary(geo.bm), summary(h5se.bm)) # check identical summary values
```

```
identical(rownames(geo.bm), rownames(h5se.bm)) # check identical probe ids
```

# 6 Troubleshooting and tips

This section describes how to address potential issues with accessing the
database files or working with the `DelayedArray` based objects locally.

## 6.1 Issue: large file downloads don’t complete

If repeated attempts to download the database compilation files fail, you
may try the following:

* First ensure your internet connection is stable and there is sufficient
  space at the download destination for the database file.
* Second, try increasing your timeout duration beyond the default before
  repeating the download attempt with `getdb`. Check the current timeout
  for an R session with `getOptions('timeout')`, then manually increase
  the timeout duration with `options(timeout = new.time)`.
* Finally, you may attempt to download a server file using command line
  calls to your system terminal or console. For instance, on a Mac you
  might try `wget -r <file_url>`. If this doesn’t work, you can again
  attempt to increase the timeout duration and repeat the download attempt.

## 6.2 Issue: unexpected function behaviors for `DelayedArray` inputs

Unexpected function behaviors may arise when using `DelayedArray`-based inputs.
These essentially arise from lacking interoperativity between normal matrices
and the `DelayedArray`-based matrices. Known examples include:

* `minfi::detectionP()`:

Throws error for specific subsets of data, such as for queries of exactly
50 samples.

```
detectionP(rg[,1:50]) # get detection pvalues from rgset
"Error in .local(Red, Green, locusNames, controlIdx, TypeI.Red, TypeI.Green, dim(Red_grid) == dim(detP_sink_grid) are not all TRUE"
```

* `minfi::preprocessFunnorm()`:

Throws error when called for an `RGChannelSet` of type `HDF5-SummarizedExperiment`.

```
preprocessFunnorm(rg) # get noob-normalized data
"Error: 'preprocessFunnorm()' only supports matrix-backed minfi objects.""
```

These and other related errors may be addressed by instantiating the data query,
or the data chunk, as a new non-`DelayedArray` object. For example, remake a
subset of the full `h5se` dataset, `rg`, as follows.

```
rg.h5se <- loadHDF5SummarizedExperiment(rg.path)        # full h5se RGChannelSet
rg.sub <- rg.h5se[,c(1:20)]                             # subset samples of interest
rg.new <- RGChannelSet(Red = getRed(rg.sub),
                       Green = getGreen(rg.sub),
                       annotation = annotation(rg.sub)) # re-make as non-DA object
gr <- preprocessFunnorm(rg.new)                         # repeat preprocessing
```

Alternatively, non-`DelayedArray` `RGChannelSet` objects can be readily generated from
the full `h5` `RGChannelSet` database with the provided function `getrg()`.

# 7 Get more help

Consult the Data Analyses [vignette](link.url) and main [manuscript](link.url)
for analysis examples and details about data compilations.

# 8 Session info

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
##  [1] ExperimentHub_3.0.0
##  [2] AnnotationHub_4.0.0
##  [3] BiocFileCache_3.0.0
##  [4] dbplyr_2.5.1
##  [5] basilisk_1.22.0
##  [6] reticulate_1.44.0
##  [7] limma_3.66.0
##  [8] gridExtra_2.3
##  [9] knitr_1.50
## [10] recountmethylation_1.20.0
## [11] HDF5Array_1.38.0
## [12] h5mread_1.2.0
## [13] rhdf5_2.54.0
## [14] DelayedArray_0.36.0
## [15] SparseArray_1.10.0
## [16] S4Arrays_1.10.0
## [17] abind_1.4-8
## [18] Matrix_1.7-4
## [19] ggplot2_4.0.0
## [20] minfiDataEPIC_1.35.0
## [21] IlluminaHumanMethylationEPICanno.ilm10b2.hg19_0.6.0
## [22] IlluminaHumanMethylationEPICmanifest_0.3.0
## [23] minfiData_0.55.0
## [24] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [25] IlluminaHumanMethylation450kmanifest_0.4.0
## [26] minfi_1.56.0
## [27] bumphunter_1.52.0
## [28] locfit_1.5-9.12
## [29] iterators_1.0.14
## [30] foreach_1.5.2
## [31] Biostrings_2.78.0
## [32] XVector_0.50.0
## [33] SummarizedExperiment_1.40.0
## [34] Biobase_2.70.0
## [35] MatrixGenerics_1.22.0
## [36] matrixStats_1.5.0
## [37] GenomicRanges_1.62.0
## [38] Seqinfo_1.0.0
## [39] IRanges_2.44.0
## [40] S4Vectors_0.48.0
## [41] BiocGenerics_0.56.0
## [42] generics_0.1.4
## [43] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            magick_2.9.0
##   [5] GenomicFeatures_1.62.0    farver_2.1.2
##   [7] rmarkdown_2.30            BiocIO_1.20.0
##   [9] vctrs_0.6.5               multtest_2.66.0
##  [11] memoise_2.0.1             Rsamtools_2.26.0
##  [13] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [15] askpass_1.2.1             tinytex_0.57
##  [17] htmltools_0.5.8.1         curl_7.0.0
##  [19] Rhdf5lib_1.32.0           sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] httr2_1.2.1               plyr_1.8.9
##  [25] cachem_1.1.0              GenomicAlignments_1.46.0
##  [27] lifecycle_1.0.4           pkgconfig_2.0.3
##  [29] R6_2.6.1                  fastmap_1.2.0
##  [31] digest_0.6.37             siggenes_1.84.0
##  [33] reshape_0.8.10            AnnotationDbi_1.72.0
##  [35] RSQLite_2.4.3             base64_2.0.2
##  [37] filelock_1.0.3            labeling_0.4.3
##  [39] mgcv_1.9-3                httr_1.4.7
##  [41] compiler_4.5.1            beanplot_1.3.1
##  [43] rngtools_1.5.2            withr_3.0.2
##  [45] bit64_4.6.0-1             S7_0.2.0
##  [47] BiocParallel_1.44.0       DBI_1.2.3
##  [49] MASS_7.3-65               openssl_2.3.4
##  [51] rappdirs_0.3.3            rjson_0.2.23
##  [53] tools_4.5.1               rentrez_1.2.4
##  [55] glue_1.8.0                quadprog_1.5-8
##  [57] restfulr_0.0.16           nlme_3.1-168
##  [59] rhdf5filters_1.22.0       grid_4.5.1
##  [61] gtable_0.3.6              tzdb_0.5.0
##  [63] preprocessCore_1.72.0     tidyr_1.3.1
##  [65] data.table_1.17.8         hms_1.1.4
##  [67] xml2_1.4.1                BiocVersion_3.22.0
##  [69] pillar_1.11.1             genefilter_1.92.0
##  [71] splines_4.5.1             dplyr_1.1.4
##  [73] lattice_0.22-7            survival_3.8-3
##  [75] rtracklayer_1.70.0        bit_4.6.0
##  [77] GEOquery_2.78.0           annotate_1.88.0
##  [79] tidyselect_1.2.1          bookdown_0.45
##  [81] xfun_0.53                 scrime_1.3.5
##  [83] statmod_1.5.1             yaml_2.3.10
##  [85] evaluate_1.0.5            codetools_0.2-20
##  [87] cigarillo_1.0.0           tibble_3.3.0
##  [89] BiocManager_1.30.26       cli_3.6.5
##  [91] xtable_1.8-4              jquerylib_0.1.4
##  [93] dichromat_2.0-0.1         Rcpp_1.1.0
##  [95] dir.expiry_1.18.0         png_0.1-8
##  [97] XML_3.99-0.19             readr_2.1.5
##  [99] blob_1.2.4                mclust_6.1.1
## [101] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
## [103] bitops_1.0-9              scales_1.4.0
## [105] illuminaio_0.52.0         purrr_1.1.0
## [107] crayon_1.5.3              rlang_1.1.6
## [109] KEGGREST_1.50.0
```

# Works Cited

1. Sandoval, J., Heyn, H. A., Moran, S., Serra-Musach, J., Pujana, M. A., Bibikova, M., and Esteller, M. (2011). Validation of a DNA methylation microarry for 450,000 CpG sites in the human genome. Epigenetics *6*, 692–702. Available at: <http://www.landesbioscience.com/journals/epigenetics/article/16196/?nocache=1384341162>.

2. Pidsley, R., Zotenko, E., Peters, T. J., Lawrence, M. G., Risbridger, G. P., Molloy, P., Van Djik, S., Muhlhausler, B., Stirzaker, C., and Clark, S. J. (2016). Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling. Genome Biology *17*. Available at: <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5055731/> [Accessed April 19, 2019].

3. Illumina Genome Studio Methylation Module v1.8 (2010). Available at: <https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/genomestudio/genomestudio-2011-1/genomestudio-methylation-v1-8-user-guide-11319130-b.pdf> [Accessed August 20, 2019].

4. Triche, T. J., Weisenberger, D. J., Van Den Berg, D., Laird, P. W., and Siegmund, K. D. (2013). Low-level processing of Illumina Infinium DNA Methylation BeadArrays. Nucleic Acids Research *41*, e90.