Handling metadata and annotations

AlpsNMR authors

2025-10-29

Abstract

Package

This vignette shows some examples on how to explore sample metadata and add additional
sample annotations, coming from one or more CSV or Excel ﬁles.

AlpsNMR 4.12.0

Contents

1

2

3

4

5

6

Getting started .

.

.

.

.

.

.

.

.

.

Exploring the sample metadata .

Sample annotations .

Further annotations .

Summary .

.

.

.

.

.

.

Session Information .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

5

6

8

8

Handling metadata and annotations

1

Getting started

We start by loading AlpsNMR and some convenience libraries:

library(dplyr)

library(readxl)

library(AlpsNMR)

We also load the demo samples, see the introduction vignette for further details:

MeOH_plasma_extraction_dir <- system.file("dataset-demo", package = "AlpsNMR")
zip_files <- list.files(MeOH_plasma_extraction_dir, pattern = glob2rx("*.zip"), full.names = TRUE)
dataset <- nmr_read_samples(sample_names = zip_files)
dataset <- nmr_interpolate_1D(dataset, axis = NULL)
dataset
## An nmr_dataset_1D (3 samples)

plot(dataset, chemshift_range = c(3.4, 3.6))

2

Exploring the sample metadata

Most NMR formats include besides the actual NMR spectra, a lot of additional information
describing the acquisition properties, instrument settings, and spectral processing information.

AlpsNMR parses all that information whenever possible, and stores it in the nmr_datasetobject,
so the user can inspect it. Since there may be a lot of information, the data is stored in
several data frames.

The available data frames are:

nmr_meta_groups(dataset)
"orig"
## [1] "info"

"title"

"acqus"

"procs"

"levels"

"external"

We can further explore each of those groups.

For instance, for the acqus group we ﬁnd 239 columns:

acqus_metadata <- nmr_meta_get(dataset, groups = "acqus")
acqus_metadata
## # A tibble: 3 x 239

##

##

NMRExperiment acqus_TITLE
<chr>

<chr>

acqus_JCAMPDX acqus_DATATYPE acqus_NPOINTS

<dbl> <chr>

<chr>

## 1 10

## 2 20

Parameter file, TopS~

Parameter file, TopS~

5 Parameter Val~ "13\t$$ modi~

5 Parameter Val~ "15\t$$ modi~

## 3 30
## # i 234 more variables: acqus_ORIGIN <chr>, acqus_OWNER <chr>,
## #

Parameter file, TopS~

acqus_Stamp <list>, acqus_ACQT0 <dbl>, acqus_AMP <list>,
acqus_AMPCOIL <list>, acqus_ANAVPT <dbl>, acqus_AQSEQ <dbl>,
acqus_AQ_mod <dbl>, acqus_AUNM <chr>, acqus_AUTOPOS <chr>, acqus_BF1 <dbl>,
acqus_BF2 <dbl>, acqus_BF3 <dbl>, acqus_BF4 <dbl>, acqus_BF5 <dbl>,
acqus_BF6 <dbl>, acqus_BF7 <dbl>, acqus_BF8 <dbl>, acqus_BWFAC <list>,
acqus_BYTORDA <dbl>, acqus_CAGPARS <list>, acqus_CHEMSTR <chr>, ...

## #

## #

## #

## #

## #

5 Parameter Val~ "13\t$$ modi~

2

Handling metadata and annotations

Here follows a long list of all the columns available:

##

colnames(acqus_metadata)
[1] "NMRExperiment"
##
[4] "acqus_DATATYPE"
[7] "acqus_OWNER"

##
## [10] "acqus_AMP"
## [13] "acqus_AQSEQ"
## [16] "acqus_AUTOPOS"
## [19] "acqus_BF3"
## [22] "acqus_BF6"
## [25] "acqus_BWFAC"
## [28] "acqus_CHEMSTR"
## [31] "acqus_D"
## [34] "acqus_DECBNUC"
## [37] "acqus_DECSTAT"
## [40] "acqus_DQDMODE"
## [43] "acqus_DSPFIRM"
## [46] "acqus_EXP"
## [49] "acqus_FL2"
## [52] "acqus_FN_INDIRECT"
## [55] "acqus_FQ2LIST"
## [58] "acqus_FQ5LIST"
## [61] "acqus_FQ8LIST"
## [64] "acqus_FS"
## [67] "acqus_FnILOOP"
## [70] "acqus_GPNAM"
## [73] "acqus_GPZ"
## [76] "acqus_HDDUTY"
## [79] "acqus_HL1"
## [82] "acqus_HL4"
## [85] "acqus_HPPRGN"
## [88] "acqus_INP"
## [91] "acqus_L"
## [94] "acqus_LINPSTP"
## [97] "acqus_LOCKGN"
## [100] "acqus_LOCNUC"
## [103] "acqus_LOCSW"
## [106] "acqus_MASRLST"
## [109] "acqus_NC"
## [112] "acqus_NS"
## [115] "acqus_NUC3"
## [118] "acqus_NUC6"
## [121] "acqus_NUCLEUS"
## [124] "acqus_NusFPNZ"
## [127] "acqus_NusSPTYPE"
## [130] "acqus_O1"
## [133] "acqus_O4"
## [136] "acqus_O7"
## [139] "acqus_P"
## [142] "acqus_PARMODE"
## [145] "acqus_PHCOR"

"acqus_TITLE"
"acqus_NPOINTS"
"acqus_Stamp"
"acqus_AMPCOIL"
"acqus_AQ_mod"
"acqus_BF1"
"acqus_BF4"
"acqus_BF7"
"acqus_BYTORDA"
"acqus_CNST"
"acqus_DATE"
"acqus_DECIM"
"acqus_DIGMOD"
"acqus_DR"
"acqus_DSPFVS"
"acqus_FCUCHAN"
"acqus_FL3"
"acqus_FOV"
"acqus_FQ3LIST"
"acqus_FQ6LIST"
"acqus_FRQLO3"
"acqus_FTLPGN"
"acqus_FnMODE"
"acqus_GPX"
"acqus_GRDPROG"
"acqus_HDRATE"
"acqus_HL2"
"acqus_HOLDER"
"acqus_IN"
"acqus_INSTRUM"
"acqus_LFILTER"
"acqus_LOCKED"
"acqus_LOCKPOW"
"acqus_LOCPHAS"
"acqus_LTIME"
"acqus_MULEXPNO"
"acqus_NLOGCH"
"acqus_NUC1"
"acqus_NUC4"
"acqus_NUC7"
"acqus_NUSLIST"
"acqus_NusJSP"
"acqus_NusT2"
"acqus_O2"
"acqus_O5"
"acqus_O8"
"acqus_PACOIL"
"acqus_PCPD"
"acqus_PHLIST"

"acqus_JCAMPDX"
"acqus_ORIGIN"
"acqus_ACQT0"
"acqus_ANAVPT"
"acqus_AUNM"
"acqus_BF2"
"acqus_BF5"
"acqus_BF8"
"acqus_CAGPARS"
"acqus_CPDPRG"
"acqus_DE"
"acqus_DECNUC"
"acqus_DIGTYP"
"acqus_DS"
"acqus_DTYPA"
"acqus_FL1"
"acqus_FL4"
"acqus_FQ1LIST"
"acqus_FQ4LIST"
"acqus_FQ7LIST"
"acqus_FRQLO3N"
"acqus_FW"
"acqus_FnTYPE"
"acqus_GPY"
"acqus_GRPDLY"
"acqus_HGAIN"
"acqus_HL3"
"acqus_HPMOD"
"acqus_INF"
"acqus_INTEGFAC"
"acqus_LGAIN"
"acqus_LOCKFLD"
"acqus_LOCKPPM"
"acqus_LOCSHFT"
"acqus_MASR"
"acqus_NBL"
"acqus_NOVFLW"
"acqus_NUC2"
"acqus_NUC5"
"acqus_NUC8"
"acqus_NusAMOUNT"
"acqus_NusSEED"
"acqus_NusTD"
"acqus_O3"
"acqus_O6"
"acqus_OVERFLW"
"acqus_PAPS"
"acqus_PEXSEL"
"acqus_PHP"

3

Handling metadata and annotations

"acqus_PL"
"acqus_PLW"
"acqus_PQSCALE"
"acqus_PRGAIN"
"acqus_PW"
"acqus_QNP"
"acqus_RECPH"
"acqus_RECSEL"
"acqus_RSEL"
"acqus_SFO1"
"acqus_SFO4"
"acqus_SFO7"
"acqus_SOLVOLD"
"acqus_SPINCNT"
"acqus_SPOFFS"
"acqus_SUBNAM"
"acqus_SW_h"

## [148] "acqus_PH_ref"
## [151] "acqus_PLSTRT"
## [154] "acqus_PQPHASE"
## [157] "acqus_PRECHAN"
## [160] "acqus_PULPROG"
## [163] "acqus_ProjAngle"
## [166] "acqus_RECCHAN"
## [169] "acqus_RECPRFX"
## [172] "acqus_RO"
## [175] "acqus_SELREC"
## [178] "acqus_SFO3"
## [181] "acqus_SFO6"
## [184] "acqus_SOLVENT"
## [187] "acqus_SPECTR"
## [190] "acqus_SPOAL"
## [193] "acqus_SPW"
## [196] "acqus_SWIBOX"
## [199] "acqus_SigLockShift" "acqus_TD"
## [202] "acqus_TD_INDIRECT"
## [205] "acqus_TE1"
## [208] "acqus_TE4"
## [211] "acqus_TE_PIDX"
## [214] "acqus_TOTROT"
## [217] "acqus_USERA2"
## [220] "acqus_USERA5"
## [223] "acqus_VALIST"
## [226] "acqus_VPLIST"
## [229] "acqus_WBSW"
## [232] "acqus_YL"
## [235] "acqus_ZGOPTNS"
## [238] "acqus_ZL3"

"acqus_TDav"
"acqus_TE2"
"acqus_TEG"
"acqus_TE_STAB"
"acqus_TUBE_TYPE"
"acqus_USERA3"
"acqus_V9"
"acqus_VCLIST"
"acqus_VTLIST"
"acqus_XGAIN"
"acqus_YMAX_a"
"acqus_ZL1"
"acqus_ZL4"

"acqus_PLSTEP"
"acqus_PLWMAX"
"acqus_PR"
"acqus_PROBHD"
"acqus_PYNM"
"acqus_RD"
"acqus_RECPRE"
"acqus_RG"
"acqus_S"
"acqus_SFO2"
"acqus_SFO5"
"acqus_SFO8"
"acqus_SP"
"acqus_SPNAM"
"acqus_SPPEX"
"acqus_SW"
"acqus_SWfinal"
"acqus_TD0"
"acqus_TE"
"acqus_TE3"
"acqus_TE_MAGNET"
"acqus_TL"
"acqus_USERA1"
"acqus_USERA4"
"acqus_VALIDCODE"
"acqus_VDLIST"
"acqus_WBST"
"acqus_XL"
"acqus_YMIN_a"
"acqus_ZL2"

We can check for instance that the nuclei used on all samples is 1H:

acqus_metadata[, c("NMRExperiment", "acqus_NUC1")]
## # A tibble: 3 x 2

##

##

NMRExperiment acqus_NUC1
<chr>

<chr>

## 1 10

## 2 20

## 3 30

1H

1H

1H

Similarly, we can obtain the processing settings:

procs_metadata <- nmr_meta_get(dataset, groups = "procs")
procs_metadata
## # A tibble: 3 x 137

##

##

NMRExperiment procs_TITLE
<chr>

<chr>

procs_JCAMPDX procs_DATATYPE procs_NPOINTS

<dbl> <chr>

<chr>

## 1 10

## 2 20

## 3 30

Parameter file, TopS~

Parameter file, TopS~

Parameter file, TopS~

5 Parameter Val~ "6\t$$ modif~

5 Parameter Val~ "11\t$$ modi~

5 Parameter Val~ "6\t$$ modif~

4

Handling metadata and annotations

## # i 132 more variables: procs_ORIGIN <chr>, procs_OWNER <chr>,
## #

procs_Stamp <list>, procs_ABSF1 <dbl>, procs_ABSF2 <dbl>, procs_ABSG <dbl>,
procs_ABSL <dbl>, procs_ALPHA <dbl>, procs_AQORDER <dbl>,
procs_ASSFAC <dbl>, procs_ASSFACI <dbl>, procs_ASSFACX <dbl>,
procs_ASSWID <dbl>, procs_AUNMP <chr>, procs_AXLEFT <dbl>,
procs_AXNAME <chr>, procs_AXNUC <chr>, procs_AXRIGHT <dbl>,
procs_AXTYPE <dbl>, procs_AXUNIT <chr>, procs_AZFE <dbl>, ...

## #

## #

## #

## #

## #

3

Sample annotations

Besides the sample metadata, most studies usually have design variables or annotations, that
describe the biological sample. These annotations do not come from the instrument itself,
but rather usually are deﬁned on an external CSV or Excel ﬁle.

AlpsNMR supports adding external annotations from data frames.

Let’s load a table from an Excel ﬁle, that has some annotations for our demo dataset:

excel_file <- file.path(MeOH_plasma_extraction_dir, "dummy_metadata.xlsx")
subject_timepoint <- read_excel(excel_file, sheet = 1)
subject_timepoint
## # A tibble: 3 x 3

##

##

NMRExperiment SubjectID TimePoint

<chr>

<chr>

<chr>

## 1 10

## 2 20

## 3 30

Ana

Ana

Elia

baseline

3 months

baseline

Note how this table includes a ﬁrst column named NMRExperiment. This column allows us to
match the rows in the table with our samples.

We can embed these external annotations in our dataset:

dataset <- nmr_meta_add(dataset, metadata = subject_timepoint, by = "NMRExperiment")

We can retrieve these external columns from the dataset:

nmr_meta_get(dataset, groups = "external")
## # A tibble: 3 x 3

##

##

NMRExperiment SubjectID TimePoint

<chr>

<chr>

<chr>

## 1 10

## 2 20

## 3 30

Ana

Ana

Elia

baseline

3 months

baseline

After adding the annotations to the dataset, we can use them in plots:

plot(dataset, color = "TimePoint", linetype = "SubjectID", chemshift_range = c(3.4, 3.6))
## Warning: ! Passing aes_string arguments to plot(nmr_dataset, ...) is deprecated.
## i Please pass aes arguments instead

## This warning is displayed once every 8 hours.
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.

5

Handling metadata and annotations

## i Please use tidy evaluation idioms with `aes()`.
## i See also `vignette("ggplot2-in-packages")` for more information.
## i The deprecated feature was likely used in the AlpsNMR package.

##

Please report the issue at <https://github.com/sipss/AlpsNMR/issues>.

## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.

4

Further annotations

Sometimes due to the study design we have more than one table that we want to match with
our data.

For instance, a collaborator just sent us this table:

additional_annotations <- data.frame(

NMRExperiment = c("10", "20", "30"),

SampleCollectionDay = c(1, 91, 3)

)
additional_annotations
##

NMRExperiment SampleCollectionDay

## 1

## 2

## 3

10

20

30

1

91

3

Since we have the NMRExperiment column it is very easy to include it:

dataset <- nmr_meta_add(dataset, additional_annotations)

And the column has been added:

nmr_meta_get(dataset, groups = "external")
## # A tibble: 3 x 4

6

0 200 k400 k600 k3.403.453.503.553.60Chemical Shift (ppm)Intensity (a.u.)TimePoint3 monthsbaselineSubjectIDAnaEliaHandling metadata and annotations

NMRExperiment SubjectID TimePoint SampleCollectionDay

##

##

<chr>

<chr>

<chr>

## 1 10

## 2 20

## 3 30

Ana

Ana

Elia

baseline

3 months

baseline

<dbl>

1

91

3

We received further information, but this time it is related to the SubjectID that we added
before:

subject_related_information <- data.frame(

SubjectID = c("Ana", "Elia"),

Age = c(33, 3),

Sex = c("female", "female")

)
subject_related_information
##

SubjectID Age

Sex

## 1

## 2

Ana 33 female

Elia

3 female

Note how in this case we only have two rows, and we don’t have the NMRExperiment column
anymore.

We can specify the by argument in nmr_meta_add() to use another column for merging:

dataset <- nmr_meta_add(dataset, subject_related_information, by = "SubjectID")

And the Sex and Age columns will have been added:

nmr_meta_get(dataset, groups = "external")
## # A tibble: 3 x 6

##

##

NMRExperiment SubjectID TimePoint SampleCollectionDay

Age Sex

<chr>

<chr>

<chr>

<dbl> <dbl> <chr>

## 1 10

## 2 20

## 3 30

Ana

Ana

Elia

baseline

3 months

baseline

1

91

3

33 female

33 female

3 female

We can also use it in a plot:

plot(dataset, color = "SubjectID", linetype = "as.factor(Age)", chemshift_range = c(7.7, 7.8)) + ggplot2::labs(linetype = "Age")

7

Handling metadata and annotations

5

Summary

In this vignette we have seen how to explore the sample metadata, including acquisition and
processing settings, and how to embed external annotations and use them in plots.

AlpsNMR is able to merge external annotations as long as there is a common annotation in the
data that can be used as merging key.

To import external data, you may want to use the following functions:

File type

Suggested function

CSV
TSV
SPSS
xls/xlsx

readr::read_csv()
readr::read_tsv()
haven::read_spss()
readxl::read_excel()

6

Session Information

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB

LC_NUMERIC=C
LC_COLLATE=C

8

5 k10 k15 k7.7007.7257.7507.7757.800Chemical Shift (ppm)Intensity (a.u.)Age333SubjectIDAnaEliaHandling metadata and annotations

## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##

## attached base packages:

## [1] stats

graphics grDevices utils

datasets

methods

base

##

## other attached packages:
## [1] AlpsNMR_4.12.0
## [4] ggplot2_4.0.0
##

BiocParallel_1.44.0 readxl_1.4.5
dplyr_1.1.4

BiocStyle_2.38.0

## loaded via a namespace (and not attached):
baseline_1.3-7
## [1] Rdpack_2.6.4
magrittr_2.0.4
## [4] rlang_1.1.6
matrixStats_1.5.0
## [7] otel_0.2.0
reshape2_1.4.4
## [10] vctrs_0.6.5
pkgconfig_2.0.3
## [13] stringr_1.5.2
labeling_0.4.3
## [16] fastmap_1.2.0
rmarkdown_2.30
## [19] promises_1.4.0
tinytex_0.57
## [22] itertools_0.1-3
Rfast_2.1.5.2
## [25] xfun_0.53
later_1.4.4
## [28] jsonlite_2.0.0
R6_2.6.1
## [31] cluster_2.1.8.1
ranger_0.17.0
## [34] RColorBrewer_1.1-3
bookdown_0.45
## [37] Rcpp_1.1.0
snow_0.4-4
## [40] knitr_1.50
tidyselect_1.2.1
## [43] igraph_2.2.1
websocket_1.4.4
## [46] yaml_2.3.10
doRNG_1.8.6.2
## [49] processx_3.8.6
plyr_1.8.9
## [52] tibble_3.3.0
S7_0.2.0
## [55] rARPACK_0.11-0
speaq_2.7.0
## [58] signal_1.8-1
pillar_1.11.1
## [61] xml2_1.4.1
foreach_1.5.2
## [64] rngtools_1.5.2
generics_0.1.4
## [67] pcaPP_2.0-5
glue_1.8.0
## [70] scales_1.4.0
SparseM_1.84-2
## [73] data.table_1.17.8
mvtnorm_1.3-3
## [76] fs_1.6.6
impute_1.84.0
## [79] grid_4.5.1
rbibutils_2.3
## [82] tidyr_1.3.1
mixOmics_6.34.0
## [85] zigg_0.0.2
gtable_0.3.6
## [88] doSNOW_1.0.20
ggrepel_0.9.6
## [91] progressr_0.17.0
## [94] htmltools_0.5.8.1
lifecycle_1.0.4
## [97] MASS_7.3-65

gridExtra_2.3
MassSpecWavelet_1.76.0
compiler_4.5.1
rvest_1.0.5
crayon_1.5.3
utf8_1.2.6
ps_1.9.1
purrr_1.1.0
randomForest_4.7-1.2
parallel_4.5.1
stringi_1.8.7
cellranger_1.1.0
iterators_1.0.14
Matrix_1.7-4
dichromat_2.0-0.1
codetools_0.2-20
lattice_0.22-7
withr_3.0.2
evaluate_1.0.5
RcppParallel_5.1.11-1
BiocManager_1.30.26
ellipse_0.5.0
chromote_0.5.1
tools_4.5.1
RSpectra_0.16-2
cowplot_1.2.0
missForest_1.6.1
cli_3.6.5
corpcor_1.6.10
digest_0.6.37
farver_2.1.2
httr_1.4.7

9

