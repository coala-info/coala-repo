# SIAMCAT input files formats

Konrad Zych, Jakob Wirbel, and Georg Zeller1\*

1EMBL Heidelberg

\*georg.zeller@embl.de

#### Date last modified: 2018-09-24

# Contents

* [1 Introduction](#introduction)
* [2 Loading your data into R](#loading-your-data-into-r)
  + [2.1 SIAMCAT input](#siamcat-input)
    - [2.1.1 Features](#features)
    - [2.1.2 Metadata](#metadata)
    - [2.1.3 Label](#label)
  + [2.2 LEfSe format files](#lefse-format-files)
  + [2.3 metagenomeSeq format files](#metagenomeseq-format-files)
  + [2.4 BIOM format files](#biom-format-files)
  + [2.5 Creating a siamcat object of a phyloseq object](#creating-a-siamcat-object-of-a-phyloseq-object)
* [3 Creating a siamcat-class object](#creating-a-siamcat-class-object)
  + [3.1 phyloseq, label and orig\_feat slots](#phyloseq-label-and-orig_feat-slots)
  + [3.2 All the other slots](#all-the-other-slots)
  + [3.3 Accessing and assigning slots](#accessing-and-assigning-slots)
  + [3.4 Slots inside the slots](#slots-inside-the-slots)

# 1 Introduction

This vignette illustrates how to read and input your own data to the
`SIAMCAT` package. We will cover reading in text files from the disk,
formatting them and using them to create an object of `siamcat-class`.

The `siamcat-class` is the centerpiece of the package. All of the input data
and result are stored inside of it. The structure of the object is described
below in the [siamcat-class object](#siamcat-class-object) section.

# 2 Loading your data into R

## 2.1 SIAMCAT input

Generally, there are three types of input for `SIAMCAT`:

### 2.1.1 Features

The features should be a `matrix`, a `data.frame`, or an `otu_table`,
organized as follows:

`features (in rows) x samples (in columns).`

|  | Sample\_1 | Sample\_2 | Sample\_3 | Sample\_4 | Sample\_5 |
| --- | --- | --- | --- | --- | --- |
| **Feature\_1** | 0.59 | 0.71 | 0.78 | 0.61 | 0.66 |
| **Feature\_2** | 0.00 | 0.02 | 0.00 | 0.00 | 0.00 |
| **Feature\_3** | 0.02 | 0.00 | 0.00 | 0.00 | 0.20 |
| **Feature\_4** | 0.34 | 0.00 | 0.13 | 0.07 | 0.00 |
| **Feature\_5** | 0.06 | 0.16 | 0.00 | 0.00 | 0.00 |

> Please note that `SIAMCAT` is supposed to work with **relative abundances**.
> Other types of data (e.g. counts) will also work, but not all functions of the
> package will result in meaningful outputs.

An example of a typical feature file is attached to the `SIAMCAT` package,
containing data from a publication investigating the microbiome in colorectal
cancer (CRC) patients and controls (the study can be found here:
[Zeller et al](http://europepmc.org/abstract/MED/25432777)). The metagenomics
data were processed with the [MOCAT](http://mocat.embl.de/) pipeline, returning
taxonomic profiles on the species levels (`specI`):

```
library(SIAMCAT)
fn.in.feat  <- system.file(
    "extdata",
    "feat_crc_zeller_msb_mocat_specI.tsv",
    package = "SIAMCAT"
)
```

One way to load such data into `R` could be the use of `read.table`

*(Beware of the defaults in R! They are not always useful…)*

```
feat <- read.table(fn.in.feat, sep='\t',
    header=TRUE, quote='',
    stringsAsFactors = FALSE, check.names = FALSE)
# look at some features
feat[110:114, 1:2]
```

```
##                                CCIS27304052ST-3-0 CCIS15794887ST-4-0
## Bacteroides caccae [h:1096]          1.557937e-03       1.761949e-03
## Bacteroides eggerthii [h:1097]       2.734527e-05       4.146882e-05
## Bacteroides stercoris [h:1098]       1.173786e-03       2.475838e-03
## Bacteroides clarus [h:1099]          4.830533e-04       4.589747e-06
## Methanohalophilus mahii [h:11]       0.000000e+00       0.000000e+00
```

### 2.1.2 Metadata

The metadata should be either a matrix or a `data.frame`.

`samples (in rows) x metadata (in columns)`:

|  | Age | Gender | BMI |
| --- | --- | --- | --- |
| **Sample\_1** | 52 | 1 | 20 |
| **Sample\_2** | 37 | 1 | 18 |
| **Sample\_3** | 66 | 2 | 24 |
| **Sample\_4** | 54 | 2 | 26 |
| **Sample\_5** | 65 | 2 | 30 |

The `rownames` of the metadata should match the `colnames` of the feature
matrix.

Again, an example of such a file is attached to the `SIAMCAT` package, taken
from the same study:

```
fn.in.meta  <- system.file(
    "extdata",
    "num_metadata_crc_zeller_msb_mocat_specI.tsv",
    package = "SIAMCAT"
)
```

Also here, the `read.table` can be used to load the data into `R`.

```
meta <- read.table(fn.in.meta, sep='\t',
    header=TRUE, quote='',
    stringsAsFactors = FALSE, check.names = FALSE)
head(meta)
```

```
##                    age gender bmi diagnosis localization crc_stage fobt
## CCIS27304052ST-3-0  52      1  20         0           NA         0    0
## CCIS15794887ST-4-0  37      1  18         0           NA         0    0
## CCIS74726977ST-3-0  66      2  24         1           NA         0    0
## CCIS16561622ST-4-0  54      2  26         0           NA         0    0
## CCIS79210440ST-3-0  65      2  30         0           NA         0    1
## CCIS82507866ST-3-0  57      2  24         0           NA         0    0
##                    wif_test
## CCIS27304052ST-3-0        0
## CCIS15794887ST-4-0        0
## CCIS74726977ST-3-0       NA
## CCIS16561622ST-4-0        0
## CCIS79210440ST-3-0        0
## CCIS82507866ST-3-0        0
```

### 2.1.3 Label

Finally, the label can come in different three different flavours:

* **Named vector**: A named vector containing information about cases and
  controls. The names of the vector should match the `rownames` of the metadata
  and the `colnames` of the feature data.
  The label can contain either the information about cases and controls either

  + as integers (e.g. `0` and `1`),
  + as characters (e.g. `CTR` and `IBD`), or
  + as factors.
* **Metadata column**: You can provide the name of a column in the metadata for
  the creation of the label. See below for an example.
* **Label file**: `SIAMCAT` has a function called `read.label`, which will
  create a label object from a label file. The file should be organized as
  follows:

  + The first line is supposed to read:
    `#BINARY:1=[label for cases];-1=[label for controls]`
  + The second row should contain the sample identifiers as tab-separated
    list (consistent with feature and metadata).
  + The third row is then supposed to contain the actual class labels
    (tab-separated): `1` for each case and `-1` for each control.

  An example file is attached to the package again, if you want to have a
  look at it.

For our example dataset, we can create the label object out of the metadata
column called `diagnosis`:

```
label <- create.label(meta=meta, label="diagnosis",
    case = 1, control=0)
```

When we later plot the results, it might be nicer to have names for the
different groups stored in the label object (instead of `1` and `0`). We can
also supply them to the `create.label` function:

```
label <- create.label(meta=meta, label="diagnosis",
    case = 1, control=0,
    p.lab = 'cancer', n.lab = 'healthy')
```

```
## Label used as case:
##    1
## Label used as control:
##    0
```

```
## + finished create.label.from.metadata in 0.001 s
```

```
label$info
```

```
## healthy  cancer
##      -1       1
```

> Note:
> If you have no label information for your dataset, you can still create a
> `SIAMCAT` object from your features alone. The `SIAMCAT` object without label
> information will contain a `TEST` label that can be used for making holdout
> predictions. Other functions, e.g. model training, will not work on such an
> object.

## 2.2 LEfSe format files

[LEfSe](https://bitbucket.org/biobakery/biobakery/wiki/lefse) is a tool for
identification of associations between micriobial features and up to two
metadata. LEfSe uses LDA (linear discriminant analysis).

LEfSe input file is a `.tsv` file. The first few rows contain the metadata. The
following row contains sample names and the rest of the rows are occupied by
features. The first column holds the row names:

| label | healthy | healthy | healthy | cancer | cancer |
| --- | --- | --- | --- | --- | --- |
| **age** | 52 | 37 | 66 | 54 | 65 |
| **gender** | 1 | 1 | 2 | 2 | 2 |
| **Sample\_info** | Sample\_1 | Sample\_2 | Sample\_3 | Sample\_4 | Sample\_5 |
| **Feature\_1** | 0.59 | 0.71 | 0.78 | 0.61 | 0.66 |
| **Feature\_2** | 0.00 | 0.02 | 0.00 | 0.00 | 0.00 |
| **Feature\_3** | 0.02 | 0.00 | 0.00 | 0.00 | 0.00 |
| **Feature\_4** | 0.34 | 0.00 | 0.43 | 0.00 | 0.00 |
| **Feature\_5** | 0.56 | 0.56 | 0.00 | 0.00 | 0.00 |

An example of such a file is attached to the `SIAMCAT` package:

```
fn.in.lefse<- system.file(
    "extdata",
    "LEfSe_crc_zeller_msb_mocat_specI.tsv",
    package = "SIAMCAT"
)
```

`SIAMCAT` has a dedicated function to read LEfSe format files. The `read.lefse`
function will read in the input file and extract metadata and features:

```
meta.and.features <- read.lefse(fn.in.lefse,
    rows.meta = 1:6, row.samples = 7)
meta <- meta.and.features$meta
feat <- meta.and.features$feat
```

We can then create a label object from one of the columns of the meta object and
create a `siamcat` object:

```
label <- create.label(meta=meta, label="label", case = "cancer")
```

```
## Label used as case:
##    cancer
## Label used as control:
##    healthy
```

```
## + finished create.label.from.metadata in 0.002 s
```

## 2.3 metagenomeSeq format files

[metagenomeSeq](http://bioconductor.org/packages/metagenomeSeq/) is an R
package to determine differentially abundant features between multiple samples.

There are two ways to input data into metagenomeSeq:

1. two files, one for metadata and one for features - those can be used
   in `SIAMCAT` just like described in [SIAMCAT input](#SIAMCAT-input) with
   `read.table`:

```
fn.in.feat  <- system.file(
    "extdata",
    "CHK_NAME.otus.count.csv",
    package = "metagenomeSeq"
)
feat <- read.table(fn.in.feat, sep='\t',
    header=TRUE, quote='', row.names = 1,
    stringsAsFactors = FALSE, check.names = FALSE
)
```

2. `BIOM` format file, that can be used in `SIAMCAT` as described in the
   [following section](BIOM-format-files)

## 2.4 BIOM format files

The BIOM format files can be added to `SIAMCAT` via `phyloseq`. First the file
should be imported using the `phyloseq` function `import_biom`. Then a
`phyloseq` object can be imported as a `siamcat` object as descibed in the
[next section.](#Creating-a-siamcat-object-of-a-phyloseq-object)

## 2.5 Creating a siamcat object of a phyloseq object

The `siamcat` object extends on the `phyloseq` object. Therefore, creating
a `siamcat` object from a `phyloseq` object is really straightforward. This
can be done with the `siamcat` constructor function. First, however, we need
to create a label object:

```
data("GlobalPatterns") ## phyloseq example data
label <- create.label(meta=sample_data(GlobalPatterns),
    label = "SampleType",
    case = c("Freshwater", "Freshwater (creek)", "Ocean"))
```

```
## Label used as case:
##    Freshwater,Freshwater (creek),Ocean
## Label used as control:
##    rest
```

```
## + finished create.label.from.metadata in 0.003 s
```

```
# run the constructor function
siamcat <- siamcat(phyloseq=GlobalPatterns, label=label)
```

```
## + starting validate.data
```

```
## +++ checking overlap between labels and features
```

```
## + Keeping labels of 26 sample(s).
```

```
## +++ checking sample number per class
```

```
## Data set has a limited number of training examples:
##  rest    18
##  Case    8
## Note that a dataset this small/skewed is not necessarily suitable for analysis in this pipeline.
```

```
## +++ checking overlap between samples and metadata
```

```
## + finished validate.data in 0.109 s
```

# 3 Creating a siamcat-class object

The `siamcat-class` is the centerpiece of the package. All of the is stored
inside of the object:
![internal make-up of a siamcat object](data:image/png;base64...)

In the figure above, rectangles depict slots of the object and the class of
the object stored in the slot is given in the ovals. There are two
obligatory slots -**phyloseq** (containing the metadata as `sample_data` and
the original features as `otu_table`) and **label** - marked with thick borders.

The `siamcat` object is constructed using the `siamcat()` function. There are
two ways to initialize it:

* **Features**: You can provide a feature `matrix`, `data.frame`, or
  `otu_table` to the function (together with label and metadata information):

  ```
  siamcat <- siamcat(feat=feat, label=label, meta=meta)
  ```
* **phyloseq**: The alternative is to create a `siamcat` object directly out
  of a `phyloseq` object:

  ```
  siamcat <- siamcat(phyloseq=phyloseq, label=label)
  ```

Please note that you **have to** provide either `feat` or `phyloseq` and that
you **cannot** provide both.

In order to explain the `siamcat` object better we will show how each of the
slots is filled.

## 3.1 phyloseq, label and orig\_feat slots

The phyloseq and label slots are obligatory.

* The phyloseq slot is an object of class `phyloseq`, which is described in the
  help file of the `phyloseq` class. Help can be accessed by typing into R
  console: `help('phyloseq-class')`.
  + The `otu_table` slot in `phyloseq` -see `help('otu_table-class')`-
    stores the original feature table. For `SIAMCAT`, this slot can be
    accessed by `orig_feat`.
* The label slot contains a list. This list has a specific set of entries
  -see `help('label-class')`- that are automatically generated by the
  `read.label` or `create.label` functions.

The `phyloseq`, label and orig\_feat are filled when the `siamcat` object is
first created with the constructor function.
![construction](data:image/png;base64...)

## 3.2 All the other slots

Other slots are filled during the run of the `SIAMCAT` workflow:
![workflow](data:image/png;base64...)

## 3.3 Accessing and assigning slots

Each slot in `siamcat` can be accessed by typing

```
slot_name(siamcat)
```

e.g. for the `eval_data` slot you can types

```
eval_data(siamcat)
```

There is one notable exception: the phyloseq slot has to be accessed with
`physeq(siamcat)` due to technical reasons.

Slots will be filled during the `SIAMCAT` workflow by the package’s functions.
However, if for any reason a slot needs to be assigned outside of the workflow,
the following formula can be used:

```
slot_name(siamcat) <- object_to_assign
```

e.g. to assign a `new_label` object to the `label` slot:

```
label(siamcat) <- new_label
```

*Please note that this may lead to unforeseen consequences…*

## 3.4 Slots inside the slots

There are two slots that have slots inside of them. First, the `model_list`
slot has a `models` slot that contains the actual list of
[mlr](https://mlr-org.github.io/mlr-tutorial/devel/html/index.html) models
-can be accessed via `models(siamcat)`- and `model.type` which is a character
with the name of the method used to train the model: `model_type(siamcat)`.

The phyloseq slot has a complex structure. However, unless the phyloseq
object is created outside of the `SIAMCAT` workflow, only two slots of phyloseq
slot will be occupied: the `otu_table` slot containing the features table and
the `sam_data` slot containing metadata information. Both can be accessed by
typing either `features(siamcat)` or `meta(siamcat)`.

Additional slots inside the phyloseq slots do not have dedicated accessors,
but can easily be reached once the phyloseq object is exported from the
`siamcat` object:

```
phyloseq <- physeq(siamcat)
tax_tab <- tax_table(phyloseq)
head(tax_tab)
```

```
## Taxonomy Table:     [6 taxa by 7 taxonomic ranks]:
##        Kingdom   Phylum          Class          Order          Family
## 549322 "Archaea" "Crenarchaeota" "Thermoprotei" NA             NA
## 522457 "Archaea" "Crenarchaeota" "Thermoprotei" NA             NA
## 951    "Archaea" "Crenarchaeota" "Thermoprotei" "Sulfolobales" "Sulfolobaceae"
## 244423 "Archaea" "Crenarchaeota" "Sd-NA"        NA             NA
## 586076 "Archaea" "Crenarchaeota" "Sd-NA"        NA             NA
## 246140 "Archaea" "Crenarchaeota" "Sd-NA"        NA             NA
##        Genus        Species
## 549322 NA           NA
## 522457 NA           NA
## 951    "Sulfolobus" "Sulfolobusacidocaldarius"
## 244423 NA           NA
## 586076 NA           NA
## 246140 NA           NA
```

If you want to find out more about the phyloseq data structure, head over to
the
[phyloseq](https://bioconductor.org/packages/release/bioc/html/phyloseq.html)
BioConductor page.
# Session Info

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
##  [1] ggpubr_0.6.2     SIAMCAT_2.14.0   phyloseq_1.54.0  mlr3_1.2.0
##  [5] lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2    dplyr_1.1.4
##  [9] purrr_1.1.0      readr_2.1.5      tidyr_1.3.1      tibble_3.3.0
## [13] ggplot2_4.0.0    tidyverse_2.0.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3   jsonlite_2.0.0       shape_1.4.6.1
##   [4] magrittr_2.0.4       magick_2.9.0         farver_2.1.2
##   [7] corrplot_0.95        nloptr_2.2.1         rmarkdown_2.30
##  [10] vctrs_0.6.5          multtest_2.66.0      minqa_1.2.8
##  [13] PRROC_1.4            tinytex_0.57         rstatix_0.7.3
##  [16] htmltools_0.5.8.1    progress_1.2.3       curl_7.0.0
##  [19] broom_1.0.10         Rhdf5lib_1.32.0      Formula_1.2-5
##  [22] rhdf5_2.54.0         pROC_1.19.0.1        sass_0.4.10
##  [25] parallelly_1.45.1    bslib_0.9.0          plyr_1.8.9
##  [28] palmerpenguins_0.1.1 mlr3tuning_1.4.0     cachem_1.1.0
##  [31] uuid_1.2-1           igraph_2.2.1         lifecycle_1.0.4
##  [34] iterators_1.0.14     pkgconfig_2.0.3      Matrix_1.7-4
##  [37] R6_2.6.1             fastmap_1.2.0        rbibutils_2.3
##  [40] future_1.67.0        digest_0.6.37        numDeriv_2016.8-1.1
##  [43] S4Vectors_0.48.0     mlr3misc_0.19.0      vegan_2.7-2
##  [46] labeling_0.4.3       timechange_0.3.0     abind_1.4-8
##  [49] mgcv_1.9-3           compiler_4.5.1       beanplot_1.3.1
##  [52] bit64_4.6.0-1        withr_3.0.2          S7_0.2.0
##  [55] backports_1.5.0      carData_3.0-5        ggsignif_0.6.4
##  [58] LiblineaR_2.10-24    MASS_7.3-65          biomformat_1.38.0
##  [61] permute_0.9-8        tools_4.5.1          ape_5.8-1
##  [64] glue_1.8.0           lgr_0.5.0            nlme_3.1-168
##  [67] rhdf5filters_1.22.0  grid_4.5.1           checkmate_2.3.3
##  [70] gridBase_0.4-7       cluster_2.1.8.1      reshape2_1.4.4
##  [73] ade4_1.7-23          generics_0.1.4       gtable_0.3.6
##  [76] tzdb_0.5.0           data.table_1.17.8    hms_1.1.4
##  [79] utf8_1.2.6           car_3.1-3            XVector_0.50.0
##  [82] BiocGenerics_0.56.0  foreach_1.5.2        pillar_1.11.1
##  [85] vroom_1.6.6          bbotk_1.7.1          splines_4.5.1
##  [88] lattice_0.22-7       survival_3.8-3       bit_4.6.0
##  [91] tidyselect_1.2.1     Biostrings_2.78.0    knitr_1.50
##  [94] reformulas_0.4.2     infotheo_1.2.0.1     gridExtra_2.3
##  [97] bookdown_0.45        IRanges_2.44.0       Seqinfo_1.0.0
## [100] stats4_4.5.1         xfun_0.53            Biobase_2.70.0
## [103] matrixStats_1.5.0    stringi_1.8.7        yaml_2.3.10
## [106] boot_1.3-32          evaluate_1.0.5       codetools_0.2-20
## [109] archive_1.1.12       BiocManager_1.30.26  cli_3.6.5
## [112] Rdpack_2.6.4         jquerylib_0.1.4      mlr3learners_0.13.0
## [115] dichromat_2.0-0.1    Rcpp_1.1.0           globals_0.18.0
## [118] parallel_4.5.1       prettyunits_1.2.0    paradox_1.0.1
## [121] lme4_1.1-37          listenv_0.9.1        glmnet_4.1-10
## [124] lmerTest_3.1-3       scales_1.4.0         crayon_1.5.3
## [127] rlang_1.1.6          mlr3measures_1.1.0
```