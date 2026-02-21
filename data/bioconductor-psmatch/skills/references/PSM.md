# Working with PSM data

#### 30 October 2025

**Package**: *[PSMatch](https://bioconductor.org/packages/3.22/PSMatch)*
**Authors**: Laurent Gatto [aut, cre] (ORCID:
<https://orcid.org/0000-0002-1520-2268>),
Johannes Rainer [aut] (ORCID: <https://orcid.org/0000-0002-6977-7147>),
Sebastian Gibb [aut] (ORCID: <https://orcid.org/0000-0001-7406-4443>),
Samuel Wieczorek [ctb],
Thomas Burger [ctb],
Guillaume Deflandre [ctb] (ORCID:
<https://orcid.org/0009-0008-1257-2416>)
**Last modified:** 2025-10-29 20:13:47.106662
**Compiled**: Thu Oct 30 01:51:59 2025

# 1 Installation instructions

To install the package from Bioconductor, make sure you have the
`BiocManager` package, available from CRAN, and then run

```
BiocManager::install("PSMatch")
```

# 2 Introduction

This vignette is one among several illustrating how to use the
`PSMatch` package, focusing on the handling and processing of
proteomics identification data using the `PSM` class. For a general
overview of the package, see the `PSMatch` package manual page
(`?PSMatch`) and references therein.

# 3 Handling and processing identification data

## 3.1 Loading PSM data

We are going to use an `mzid` file from the `msdata` package.

```
f <- msdata::ident(full.names = TRUE, pattern = "TMT")
basename(f)
```

```
## [1] "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid"
```

The `PSM()` function parses one or multiple `mzid` files and returns
an object of class `PSM`. This class is a simple extension of the
`DFrame` class, representing the peptide-spectrum matches in a tabular
format.

```
library("PSMatch")
id <- PSM(f)
id
```

```
## PSM with 5802 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

This table contains 5802 matches for 5343 scans and
4938 peptides sequences, each annotated by 35 variables.

```
nrow(id) ## number of matches
```

```
## [1] 5802
```

```
length(unique(id$spectrumID)) ## number of scans
```

```
## [1] 5343
```

```
length(unique(id$sequence))   ## number of peptide sequences
```

```
## [1] 4938
```

```
names(id)
```

```
##  [1] "sequence"                 "spectrumID"
##  [3] "chargeState"              "rank"
##  [5] "passThreshold"            "experimentalMassToCharge"
##  [7] "calculatedMassToCharge"   "peptideRef"
##  [9] "modNum"                   "isDecoy"
## [11] "post"                     "pre"
## [13] "start"                    "end"
## [15] "DatabaseAccess"           "DBseqLength"
## [17] "DatabaseSeq"              "DatabaseDescription"
## [19] "scan.number.s."           "acquisitionNum"
## [21] "spectrumFile"             "idFile"
## [23] "MS.GF.RawScore"           "MS.GF.DeNovoScore"
## [25] "MS.GF.SpecEValue"         "MS.GF.EValue"
## [27] "MS.GF.QValue"             "MS.GF.PepQValue"
## [29] "modPeptideRef"            "modName"
## [31] "modMass"                  "modLocation"
## [33] "subOriginalResidue"       "subReplacementResidue"
## [35] "subLocation"
```

The PSM data are read as is, without any filtering. As we can see
below, we still have all the hits from the forward and reverse (decoy)
databases.

```
table(id$isDecoy)
```

```
##
## FALSE  TRUE
##  2906  2896
```

## 3.2 Keeping all matches

The data also contains multiple matches for several spectra. The table
below shows the number of individual MS scans that have 1, 2, … up
to 5 matches.

```
table(table(id$spectrumID))
```

```
##
##    1    2    3    4    5
## 4936  369   26   10    2
```

More specifically, we can see below how scan 1774 has 4 matches, all
to sequence `RTRYQAEVR`, which itself matches to 4 different proteins:

```
i <- grep("scan=1774", id$spectrumID)
id[i, ]
```

```
## PSM with 4 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

```
id[i, "DatabaseAccess"]
```

```
## [1] "ECA2104" "ECA2867" "ECA3427" "ECA4142"
```

If the goal is to keep all the matches, but arranged by scan/spectrum,
one can *reduce* the `DataFrame` object by the `spectrumID` variable,
so that each scan correponds to a single row that still stores all
values111 The rownames aren’t needed here and are removed to reduce
to output in the the next code chunks displaying parts of `id2`.:

```
id2 <- reducePSMs(id, id$spectrumID)
rownames(id2) <- NULL ## rownames not needed here
dim(id2)
```

```
## [1] 5343   35
```

The resulting object contains a single entrie for scan 1774 with
information for the multiple matches stored as a list within the table
cell.

```
j <- grep("scan=1774", id2$spectrumID)
id2[j, ]
```

```
## Reduced PSM with 1 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

```
id2[j, "DatabaseAccess"]
```

```
## CharacterList of length 1
## [["controllerType=0 controllerNumber=1 scan=1774"]] ECA2104 ECA2867 ECA3427 ECA4142
```

The identification data could be used to annotate an raw mass
spectrometry `Spectra` object (see the `Spectra::joinSpectraData()`
function for details).

## 3.3 Filtering data

Often, the PSM data is filtered to only retain reliable matches. The
`MSnID` package can be used to set thresholds to attain user-defined
PSM, peptide or protein-level FDRs. Here, we will simply filter out
wrong or the least reliable identifications.

### 3.3.1 Remove decoy hits

```
id <- filterPsmDecoy(id)
```

```
## Removed 2896 decoy hits.
```

```
id
```

```
## PSM with 2906 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

### 3.3.2 Keep first rank matches

```
id <- filterPsmRank(id)
```

```
## Removed 155 PSMs with rank > 1.
```

```
id
```

```
## PSM with 2751 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

### 3.3.3 Remove shared peptides

The data still contains shared peptides, i.e. those that different
proteins. For example `QKTRCATRAFKANKGRAR` matches proteins `ECA2869`
and `ECA4278`.

```
id[id$sequence == "QKTRCATRAFKANKGRAR", "DatabaseAccess"]
```

```
## [1] "ECA2869" "ECA4278"
```

We can filter these out to retain unique peptides.

```
id <- filterPsmShared(id)
```

```
## Removed 85 shared peptides.
```

```
id
```

```
## PSM with 2666 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

This last filtering leaves us with 2666 PSMs.

Note that the `ConnectedComponents` approach defined in this package
allows one to explore protein groups defined by such shared peptides
more thoroughly and make informed decision as to which shared peptides
to retain and which ones to drop. For details see the related vignette
or the
[`ConnectedComponents`](https://rformassspectrometry.github.io/PSMatch/reference/ConnectedComponents.html)
manual page.

### 3.3.4 All filters in one function

This can also be achieved with the `filterPSMs()` function:

```
id <- PSM(f)
filterPSMs(id)
```

```
## Starting with 5802 PSMs:
```

```
## Removed 2896 decoy hits.
```

```
## Removed 155 PSMs with rank > 1.
```

```
## Removed 85 shared peptides.
```

```
## 2666 PSMs left.
```

```
## PSM with 2666 rows and 35 columns.
## names(35): sequence spectrumID ... subReplacementResidue subLocation
```

# 4 The `mzR` and `mzID` parsers

The `PSM()` function can take two different values for the `parser`
parameter, namely `"mzR"` (the default value) and `"mzID"`.

* **mzR** uses the `openIDfile()` function from the
  *[mzR](https://bioconductor.org/packages/3.22/mzR)* to parse the `mzId` file(s), and then
  coerces the data to a `data.frame` which is eventually returned as
  a `PSM` object. The parser function uses dedicated code from the
  Proteowizard project (included in `mzR`) and is generally the
  fastest approach.
* **mzID** parses the `mzId` file with `mzID()` function from the
  *[mzID](https://bioconductor.org/packages/3.22/mzID)* package, and then flattens the data to
  a `data.frame` with `mzID::flatten()` and eventuelly returns a
  `PSM` object. The `mzID` package relies on the *[XML](https://CRAN.R-project.org/package%3DXML)*
  package. Is is slower but is is more robust to variations in the
  `mzID` implementation, as is thus a useful backup when the `mzR`
  backend fails.

```
system.time(id1 <- PSM(f, parser = "mzR"))
```

```
##    user  system elapsed
##   0.278   0.003   0.281
```

```
system.time(id2 <- PSM(f, parser = "mzID"))
```

```
## Loading required namespace: mzID
```

```
## reading TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid...
```

```
##  DONE!
```

```
##    user  system elapsed
##   7.941   0.056   7.998
```

Other differences in the two parsers include the columns that are
returned, the way they name them, and, as will shown below the matches
that are returned. Note for instance (and this will be important
later), that there is no equivalent of `"modLocation"` in `id2`.

```
names(id1)
```

```
##  [1] "sequence"                 "spectrumID"
##  [3] "chargeState"              "rank"
##  [5] "passThreshold"            "experimentalMassToCharge"
##  [7] "calculatedMassToCharge"   "peptideRef"
##  [9] "modNum"                   "isDecoy"
## [11] "post"                     "pre"
## [13] "start"                    "end"
## [15] "DatabaseAccess"           "DBseqLength"
## [17] "DatabaseSeq"              "DatabaseDescription"
## [19] "scan.number.s."           "acquisitionNum"
## [21] "spectrumFile"             "idFile"
## [23] "MS.GF.RawScore"           "MS.GF.DeNovoScore"
## [25] "MS.GF.SpecEValue"         "MS.GF.EValue"
## [27] "MS.GF.QValue"             "MS.GF.PepQValue"
## [29] "modPeptideRef"            "modName"
## [31] "modMass"                  "modLocation"
## [33] "subOriginalResidue"       "subReplacementResidue"
## [35] "subLocation"
```

```
names(id2)
```

```
##  [1] "spectrumid"                "scan number(s)"
##  [3] "acquisitionnum"            "passthreshold"
##  [5] "rank"                      "calculatedmasstocharge"
##  [7] "experimentalmasstocharge"  "chargestate"
##  [9] "ms-gf:denovoscore"         "ms-gf:evalue"
## [11] "ms-gf:pepqvalue"           "ms-gf:qvalue"
## [13] "ms-gf:rawscore"            "ms-gf:specevalue"
## [15] "assumeddissociationmethod" "isotopeerror"
## [17] "isdecoy"                   "post"
## [19] "pre"                       "end"
## [21] "start"                     "accession"
## [23] "length"                    "description"
## [25] "pepseq"                    "modified"
## [27] "modification"              "idFile"
## [29] "spectrumFile"              "databaseFile"
```

We also have different number of matches in the two tables:

```
nrow(id1)
```

```
## [1] 5802
```

```
nrow(id2)
```

```
## [1] 5759
```

```
table(id1$isDecoy)
```

```
##
## FALSE  TRUE
##  2906  2896
```

```
table(id2$isdecoy)
```

```
##
## FALSE  TRUE
##  2886  2873
```

Let’s first filter the PSM tables to facilitate focus the comparison
of relevant scans. Note that the default `filterPSMs()` arguments are
set to work with both parser.

```
id1_filtered <- filterPSMs(id1)
```

```
## Starting with 5802 PSMs:
```

```
## Removed 2896 decoy hits.
```

```
## Removed 155 PSMs with rank > 1.
```

```
## Removed 85 shared peptides.
```

```
## 2666 PSMs left.
```

```
id2_filtered <- filterPSMs(id2)
```

```
## Starting with 5759 PSMs:
```

```
## Removed 2873 decoy hits.
```

```
## Removed 155 PSMs with rank > 1.
```

```
## Removed 85 shared peptides.
```

```
## 2646 PSMs left.
```

As can be seen, we are also left with 2666 vs
2646 PSMs after filtering.

The difference doesn’t stem from different scans, given that the
spectum identifiers are identical in both tables:

```
identical(sort(unique(id1_filtered$spectrumID)),
          sort(unique(id2_filtered$spectrumid)))
```

```
## [1] TRUE
```

The difference is obvious when we tally a table of spectrum id
occurences in the filtered tables. In `id2_filtered`, each scan is
unique, i.e matched only once.

```
anyDuplicated(id2_filtered$spectrumid)
```

```
## [1] 0
```

However, for `id1_filtered`, we see that some scans are still repeat
up to 4 times in the table:

```
table(table(id1_filtered$spectrumID))
```

```
##
##    1    2    3    4
## 2630   13    2    1
```

The example below shows that these differences stem from the
modification location (`"modLocation"`), that is not report by the
`mzID` parser:

```
k <- names(which(table(id1_filtered$spectrumID) == 4))
id1_filtered[id1_filtered$spectrumID == k, "sequence"]
```

```
## [1] "KCNQCLKVACTLFYCK" "KCNQCLKVACTLFYCK" "KCNQCLKVACTLFYCK" "KCNQCLKVACTLFYCK"
```

```
id1_filtered[id1_filtered$spectrumID == k, "modLocation"]
```

```
## [1]  2  5 10 15
```

```
id1_filtered[id1_filtered$spectrumID == k, "modName"]
```

```
## [1] "Carbamidomethyl" "Carbamidomethyl" "Carbamidomethyl" "Carbamidomethyl"
```

If we remove the `"modLocation"` column, we recoved the same number of
PSMs than with the `mzID` parser.

```
id1_filtered$modLocation <- NULL
nrow(unique(id1_filtered))
```

```
## [1] 2646
```

```
nrow(unique(id2_filtered))
```

```
## [1] 2646
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] Spectra_1.20.0              BiocParallel_1.44.0
##  [3] factoextra_1.0.7            ggplot2_4.0.0
##  [5] QFeatures_1.20.0            MultiAssayExperiment_1.36.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           PSMatch_1.14.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1        dplyr_1.1.4             farver_2.1.2
##  [4] S7_0.2.0                fastmap_1.2.0           lazyeval_0.2.2
##  [7] XML_3.99-0.19           digest_0.6.37           lifecycle_1.0.4
## [10] cluster_2.1.8.1         ProtGenerics_1.42.0     magrittr_2.0.4
## [13] compiler_4.5.1          rlang_1.1.6             sass_0.4.10
## [16] tools_4.5.1             igraph_2.2.1            yaml_2.3.10
## [19] ggsignif_0.6.4          knitr_1.50              labeling_0.4.3
## [22] S4Arrays_1.10.0         DelayedArray_0.36.0     plyr_1.8.9
## [25] RColorBrewer_1.1-3      abind_1.4-8             withr_3.0.2
## [28] purrr_1.1.0             grid_4.5.1              ggpubr_0.6.2
## [31] iterators_1.0.14        scales_1.4.0            MASS_7.3-65
## [34] dichromat_2.0-0.1       tinytex_0.57            cli_3.6.5
## [37] crayon_1.5.3            mzR_2.44.0              rmarkdown_2.30
## [40] reshape2_1.4.4          BiocBaseUtils_1.12.0    ncdf4_1.24
## [43] cachem_1.1.0            stringr_1.5.2           parallel_4.5.1
## [46] AnnotationFilter_1.34.0 BiocManager_1.30.26     XVector_0.50.0
## [49] vctrs_0.6.5             Matrix_1.7-4            carData_3.0-5
## [52] jsonlite_2.0.0          car_3.1-3               bookdown_0.45
## [55] rstatix_0.7.3           ggrepel_0.9.6           Formula_1.2-5
## [58] clue_0.3-66             magick_2.9.0            foreach_1.5.2
## [61] tidyr_1.3.1             jquerylib_0.1.4         glue_1.8.0
## [64] codetools_0.2-20        stringi_1.8.7           gtable_0.3.6
## [67] mzID_1.48.0             tibble_3.3.0            pillar_1.11.1
## [70] htmltools_0.5.8.1       R6_2.6.1                doParallel_1.0.17
## [73] evaluate_1.0.5          lattice_0.22-7          backports_1.5.0
## [76] broom_1.0.10            msdata_0.49.0           bslib_0.9.0
## [79] MetaboCoreUtils_1.18.0  Rcpp_1.1.0              SparseArray_1.10.0
## [82] xfun_0.53               MsCoreUtils_1.22.0      fs_1.6.6
## [85] pkgconfig_2.0.3
```