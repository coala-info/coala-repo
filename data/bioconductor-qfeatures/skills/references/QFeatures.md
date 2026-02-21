# Quantitative features for mass spectrometry data

Laurent Gatto

#### 30 October 2025

#### Abstract

This vignette describes the functionality implemented in the QFeatures package. QFeatures provides infrastructure to manage and process quantitative features for high-throughput mass spectrometry assays, including proteomics and metabolomics. This vignette is distributed under a CC BY-SA license.

#### Package

QFeatures 1.20.0

# 1 Introduction

The `QFeatures` package provides infrastructure (that is classes to
store data and the methods to process and manipulate them) to manage
and analyse quantitative features from mass spectrometry
experiments. It is based on the `SummarizedExperiment` and
`MultiAssayExperiment` classes. Assays in a QFeatures object have a
hierarchical relation: proteins are composed of peptides, themselves
produced by spectra, as depicted in figure
[1](#fig:featuresplot). Throughout the aggregation and processing of
these data, the relations between assays are tracked and recorded,
thus allowing users to easily navigate across spectra, peptide and
protein quantitative data.

![Conceptual representation of a `QFeatures` object and the aggregative relation between different assays.](data:image/png;base64...)

Figure 1: Conceptual representation of a `QFeatures` object and the aggregative relation between different assays

In the following sections, we are going to demonstrate how to create a
single-assay `QFeatures` objects starting from a spreadsheet, how to
compute the next assays (peptides and proteins), and how these can be
manipulated and explored.

```
library("QFeatures")
```

# 2 Creating `QFeatures` object

While `QFeatures` objects can be created manually (see `?QFeatures`
for details), most users will probably possess quantitative data in a
spreadsheet or a dataframe. In such cases, the easiest is to use the
`readQFeatures` function to extract the quantitative data and metadata
columns. Below, we load the `hlpsms` dataframe that contains data for
3010 PSMs from the TMT-10plex hyperLOPIT spatial
proteomics experiment from (Christoforou et al. [2016](#ref-Christoforou:2016)). The `quantCols`
argument specifies that columns 1 to 10 contain quantitation data, and
that the assay should be named `psms` in the returned `QFeatures`
object, to reflect the nature of the data.

```
data(hlpsms)
hl <- readQFeatures(hlpsms, quantCols = 1:10, name = "psms")
```

```
## Checking arguments.
```

```
## Loading data as a 'SummarizedExperiment' object.
```

```
## Formatting sample annotations (colData).
```

```
## Formatting data as a 'QFeatures' object.
```

```
hl
```

```
## An instance of class QFeatures (type: bulk) with 1 set:
##
##  [1] psms: SummarizedExperiment with 3010 rows and 10 columns
```

Below, we see that we can extract an assay using its index or its
name. The individual assays are stored as *SummarizedExperiment*
object and further access its quantitative data and metadata using the
`assay` and `rowData` functions

```
hl[[1]]
```

```
## class: SummarizedExperiment
## dim: 3010 10
## metadata(0):
## assays(1): ''
## rownames(3010): 1 2 ... 3009 3010
## rowData names(18): Sequence ProteinDescriptions ... RTmin markers
## colnames(10): X126 X127C ... X130N X131
## colData names(0):
```

```
hl[["psms"]]
```

```
## class: SummarizedExperiment
## dim: 3010 10
## metadata(0):
## assays(1): ''
## rownames(3010): 1 2 ... 3009 3010
## rowData names(18): Sequence ProteinDescriptions ... RTmin markers
## colnames(10): X126 X127C ... X130N X131
## colData names(0):
```

```
head(assay(hl[["psms"]]))
```

```
##         X126      X127C       X127N      X128C       X128N      X129C
## 1 0.12283431 0.08045915 0.070804055 0.09386901 0.051815695 0.13034383
## 2 0.35268185 0.14162381 0.167523880 0.07843497 0.071087436 0.03214548
## 3 0.01546089 0.16142297 0.086938133 0.23120844 0.114664348 0.09610188
## 4 0.04702854 0.09288723 0.102012167 0.11125409 0.067969116 0.14155358
## 5 0.01044693 0.15866147 0.167315736 0.21017494 0.147946673 0.07088253
## 6 0.04955362 0.01215244 0.002477681 0.01297833 0.002988949 0.06253195
##        X129N       X130C      X130N       X131
## 1 0.17540095 0.040068658 0.11478839 0.11961594
## 2 0.06686260 0.031961793 0.02810434 0.02957384
## 3 0.15977819 0.010127118 0.08059400 0.04370403
## 4 0.18015910 0.035329902 0.12166589 0.10014038
## 5 0.17555789 0.007088253 0.02884754 0.02307803
## 6 0.01726511 0.172651119 0.37007905 0.29732174
```

```
head(rowData(hl[["psms"]]))
```

```
## DataFrame with 6 rows and 18 columns
##      Sequence ProteinDescriptions NbProteins ProteinGroupAccessions
##   <character>         <character>  <integer>            <character>
## 1     SQGEIDk       Tetratrico...          1                 Q8BYY4
## 2     YEAQGDk       Vacuolar p...          1                 P46467
## 3     TTScDTk       C-type man...          1                 Q64449
## 4     aEELESR       Liprin-alp...          1                 P60469
## 5     aQEEAIk       Isoform 2 ...          2               P13597-2
## 6    dGAVDGcR       Structural...          1                 Q6P5D8
##   Modifications    qValue       PEP  IonScore NbMissedCleavages
##     <character> <numeric> <numeric> <integer>         <integer>
## 1 K7(TMT6ple...     0.008   0.11800        27                 0
## 2 K7(TMT6ple...     0.001   0.01070        27                 0
## 3 C4(Carbami...     0.008   0.11800        11                 0
## 4 N-Term(TMT...     0.002   0.04450        24                 0
## 5 N-Term(Car...     0.001   0.00850        36                 0
## 6 N-Term(TMT...     0.000   0.00322        26                 0
##   IsolationInterference IonInjectTimems Intensity    Charge      mzDa      MHDa
##               <integer>       <integer> <numeric> <integer> <numeric> <numeric>
## 1                     0              70    335000         2   503.274   1005.54
## 2                     0              70    926000         2   520.267   1039.53
## 3                     0              70    159000         2   521.258   1041.51
## 4                     0              70    232000         2   531.785   1062.56
## 5                     0              70    212000         2   537.804   1074.60
## 6                     0              70    865000         2   539.761   1078.51
##   DeltaMassPPM     RTmin       markers
##      <numeric> <numeric>   <character>
## 1        -0.38     24.02       unknown
## 2         0.61     18.85       unknown
## 3         1.11     10.17       unknown
## 4         0.35     29.18       unknown
## 5         1.70     25.56 Plasma mem...
## 6        -0.67     21.27 Nucleus - ...
```

For further details on how to manipulate such objects, refer to the
*[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* (Ramos et al. [2017](#ref-Ramos:2017)) and
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* (Morgan et al. [2019](#ref-SE)) packages.

As illustrated in figure [1](#fig:featuresplot), an central
characteristic of `QFeatures` objects is the aggregative relation
between their assays. This can be obtained with the
`aggregateFeatures` function that will aggregate quantitative features
from one assay into a new one. In the next code chunk, we aggregate
PSM-level data into peptide by grouping all PSMs that were matched the
same peptide sequence. Below, the aggregation function is set, as an
example, to the mean. The new assay is named *peptides*.

```
hl <- aggregateFeatures(hl, "psms", "Sequence",
                        name = "peptides", fun = colMeans)
```

```
## Your row data contain missing values. Please read the relevant
## section(s) in the aggregateFeatures manual page regarding the effects
## of missing values on data aggregation.
```

```
##
Aggregated: 1/1
```

```
hl
```

```
## An instance of class QFeatures (type: bulk) with 2 sets:
##
##  [1] psms: SummarizedExperiment with 3010 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 2923 rows and 10 columns
```

```
hl[["peptides"]]
```

```
## class: SummarizedExperiment
## dim: 2923 10
## metadata(0):
## assays(2): assay aggcounts
## rownames(2923): AAAVSTEGk AAIDYQk ... ykVEEASDLSISk ykVPQTEEPTAk
## rowData names(7): Sequence ProteinDescriptions ... markers .n
## colnames(10): X126 X127C ... X130N X131
## colData names(0):
```

Below, we repeat the aggregation operation by grouping peptides into
proteins as defined by the *ProteinGroupAccessions* variable.

```
hl <- aggregateFeatures(hl, "peptides", "ProteinGroupAccessions",
                        name = "proteins", fun = colMeans)
```

```
##
Aggregated: 1/1
```

```
hl
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 3010 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 2923 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 1596 rows and 10 columns
```

```
hl[["proteins"]]
```

```
## class: SummarizedExperiment
## dim: 1596 10
## metadata(0):
## assays(2): assay aggcounts
## rownames(1596): A2A432 A2A6Q5-3 ... Q9Z2Z9 Q9Z315
## rowData names(3): ProteinGroupAccessions markers .n
## colnames(10): X126 X127C ... X130N X131
## colData names(0):
```

The sample assayed in a `QFeatures` object can be documented in the
`colData` slot. The `hl` data doens’t currently possess any sample
metadata. These can be addedd as a new `DataFrame` with matching names
(i.e. the `DataFrame` rownames must be identical assay’s colnames) or
can be added one variable at at time, as shown below.

```
colData(hl)
```

```
## DataFrame with 10 rows and 0 columns
```

```
hl$tag <- c("126", "127N", "127C", "128N", "128C", "129N", "129C",
            "130N", "130C", "131")
colData(hl)
```

```
## DataFrame with 10 rows and 1 column
##               tag
##       <character>
## X126          126
## X127C        127N
## X127N        127C
## X128C        128N
## X128N        128C
## X129C        129N
## X129N        129C
## X130C        130N
## X130N        130C
## X131          131
```

# 3 Manipulating feature metadata

The `QFeatures` package provides some utility functions that streamline
the accession and manipulation of the feature metadata.

The feature metadata, more generally referred to as `rowData` in the
Bioconductor ecosystem, is specific to each assay in a `QFeatures`
object. Therefore there are as many `rowData` tables as there are
assays. `rowDataNames` provides a list where each element contains the
name of the `rowData` columns available in the corresponding assay.

```
rowDataNames(hl)
```

```
## CharacterList of length 3
## [["psms"]] Sequence ProteinDescriptions NbProteins ... RTmin markers
## [["peptides"]] Sequence ProteinDescriptions NbProteins ... markers .n
## [["proteins"]] ProteinGroupAccessions markers .n
```

We saw above how to get the `rowData` from an assay, but we can also
extract the `rowData` for all assays by calling the function on the
`QFeautures` object directly. Similarly to `rowDataNames`, a list is
returned where each element contains the `rowData` available in the
corresponding assay.

```
rowData(hl)
```

```
## DataFrameList of length 3
## names(3): psms peptides proteins
```

In some cases, we are interested in extracting the `rowData` as a
single data table. This is easily performed using the `rbindRowData`
function. The function will automatically select the columns that are
common to all selected assays.

```
rbindRowData(hl, i = c("peptides", "proteins"))
```

```
## DataFrame with 4519 rows and 5 columns
##            assay       rowname ProteinGroupAccessions       markers        .n
##      <character>   <character>            <character>   <character> <integer>
## 1       peptides     AAAVSTEGk                 Q9ERE8       unknown         1
## 2       peptides       AAIDYQk                 Q3THS6       unknown         1
## 3       peptides AAISQPGISE...                 Q8BP40 Mitochondr...         1
## 4       peptides AALAHSEIAT...               Q9QXS1-3       unknown         1
## 5       peptides    AAMIVNQLSk                 Q02257 Plasma mem...         1
## ...          ...           ...                    ...           ...       ...
## 4515    proteins        Q9Z2V5                 Q9Z2V5       unknown         1
## 4516    proteins        Q9Z2W0                 Q9Z2W0       unknown         1
## 4517    proteins        Q9Z2X1                 Q9Z2X1       unknown         1
## 4518    proteins        Q9Z2Z9                 Q9Z2Z9       unknown         3
## 4519    proteins        Q9Z315                 Q9Z315       unknown         1
```

We can also replace and add columns in the `rowData`. This requires
to provide a `List` where the names of the `List` point to the assay
to be updated and the elements of the `List` contain `DataFrame`s with
the replacement values. If the `DataFrame` contains a column that is
not present in the `rowData`, that column will get added to the
`rowData`. For instance, let’s add a `rowData` variables with the mean
protein expression as well as the associated standard deviation.
First, we need to create the `DataFrame` with the mean expression.

```
dF <- DataFrame(mean = rowSums(assay(hl[["proteins"]])),
                sd = rowSds(assay(hl[["proteins"]])))
```

Then, we create the list and name the element `proteins` so that the
new data is added to the `rowData` of the `proteins` assay. To add
the list, we insert it back into the `rowData`.

```
rowData(hl) <- List(proteins = dF)
```

As shown below, the new `mean` and `sd` variables have been added to the
`rowData` of the `proteins` assay.

```
rowData(hl)[["proteins"]]
```

```
## DataFrame with 1596 rows and 5 columns
##          ProteinGroupAccessions     markers        .n      mean        sd
##                     <character> <character> <integer> <numeric> <numeric>
## A2A432                   A2A432     unknown         1         1 0.0822395
## A2A6Q5-3               A2A6Q5-3     unknown         1         1 0.0891478
## A2A8L5                   A2A8L5     unknown         2         1 0.1009041
## A2AF47                   A2AF47     unknown         1         1 0.0749159
## A2AGT5                   A2AGT5     unknown         6         1 0.1065126
## ...                         ...         ...       ...       ...       ...
## Q9Z2V5                   Q9Z2V5     unknown         1         1 0.0882136
## Q9Z2W0                   Q9Z2W0     unknown         1         1 0.0565321
## Q9Z2X1                   Q9Z2X1     unknown         1         1 0.1539930
## Q9Z2Z9                   Q9Z2Z9     unknown         3         1 0.0930030
## Q9Z315                   Q9Z315     unknown         1         1 0.1234534
```

Note that you can also replace an existing column in the `rowData` by
naming the column name in the `DataFrame` after the column to replace.

# 4 Subsetting

One particularity of the `QFeatures` infrastructure is that the
features of the constitutive assays are linked through an aggregative
relation. This relation is recorded when creating new assays with
`aggregateFeatures` and is exploited when subsetting `QFeature` by their
feature names.

In the example below, we are interested in the Stat3B isoform of the
Signal transducer and activator of transcription 3 (STAT3) with
accession number P42227-2. This accession number corresponds to a
feature name in the *proteins* assay. But this protein row was
computed from 8 peptide rows in the *peptides* assay, themselves
resulting from the aggregation of 8 rows in the *psms* assay.

```
stat3 <- hl["P42227-2", , ]
stat3
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 9 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 8 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 1 rows and 10 columns
```

We can easily visualise this new *QFeatures* object using `ggplot2`
once converted into a `data.frame`. See the visualization vignette for
more details about data exploration from a `QFeatures` object.

```
stat3_df <- data.frame(longForm(stat3))
stat3_df$assay <- factor(stat3_df$assay,
                        levels = c("psms", "peptides", "proteins"))
library("ggplot2")
ggplot(data = stat3_df,
       aes(x = colname,
           y = value,
           group = rowname)) +
    geom_line() + geom_point() +
    facet_grid(~ assay)
```

![](data:image/png;base64...)

Below we repeat the same operation for the Signal transducer and
activator of transcription 1 (STAT1) and 3 (STAT3) accession numbers,
namely P42227-2 and P42225. We obtain a new `QFeatures` instance
containing 2 proteins, 9 peptides and 10 PSMS. From this, we can
readily conclude that STAT1 was identified by a single PSM/peptide.

```
stat <- hl[c("P42227-2", "P42225"), , ]
stat
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 10 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 9 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 2 rows and 10 columns
```

Below, we visualise the expression profiles for the two proteins.

```
stat_df <- data.frame(longForm(stat))
stat_df$stat3 <- ifelse(stat_df$rowname %in% stat3_df$rowname,
                        "STAT3", "STAT1")
stat_df$assay <- factor(stat_df$assay,
                        levels = c("psms", "peptides", "proteins"))

ggplot(data = stat_df,
       aes(x = colname,
           y = value,
           group = rowname)) +
    geom_line() + geom_point() +
    facet_grid(stat3 ~ assay)
```

![](data:image/png;base64...)

The subsetting by feature names is also available as a call to the
`subsetByFeature` function, for use with the pipe operator.

```
hl |>
    subsetByFeature("P42227-2")
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 9 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 8 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 1 rows and 10 columns
```

```
hl |>
    subsetByFeature(c("P42227-2", "P42225"))
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 10 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 9 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 2 rows and 10 columns
```

and possibly

```
hl |>
    subsetByFeature("P42227-2") |>
    longForm() |>
    as.data.frame() |>
    ggplot(aes(x = colname,
               y = value,
               group = rowname)) +
    geom_line() +
    facet_grid(~ assay)
```

to reproduce the line plot.

# 5 Filtering

QFeatures is assays can also be filtered based on variables in their
respective row data slots using the `filterFeatures` function. The
filters can be defined using the formula interface or using
`AnnotationFilter` objects from the `r BiocStyle::Biocpkg("AnnotationFilter")` package
(Morgan and Rainer [2019](#ref-AnnotationFilter)). In addition to the pre-defined filters (such as
`SymbolFilter`, `ProteinIdFilter`, … that filter on gene symbol,
protein identifier, …), this package allows users to define
arbitrary character or numeric filters using the `VariableFilter`.

```
mito_filter <- VariableFilter(field = "markers",
                              value = "Mitochondrion",
                              condition = "==")
mito_filter
```

```
## class: CharacterVariableFilter
## condition: ==
## value: Mitochondrion
```

```
qval_filter <- VariableFilter(field = "qValue",
                              value = 0.001,
                              condition = "<=")
qval_filter
```

```
## class: NumericVariableFilter
## condition: <=
## value: 0.001
```

These filter can then readily be applied to all assays’ row data
slots. The `mito_filter` will return all PSMs, peptides and proteins
that were annotated as localising to the mitochondrion.

```
filterFeatures(hl, mito_filter)
```

```
## 'markers' found in 3 out of 3 assay(s).
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 167 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 162 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 113 rows and 10 columns
```

The `qval_filter`, on the other hand, will only return a subset of
PSMs, because the `qValue` variable is only present in the `psms`
assays. The q-values are only relevant to PSMs and that variable was
dropped from the other assays.

```
filterFeatures(hl, qval_filter)
```

```
## 'qValue' found in 1 out of 3 assay(s).
```

```
## No filter applied to the following assay(s) because one or more
## filtering variables are missing in the rowData: peptides, proteins. You
## can control whether to remove or keep the features using the 'keep'
## argument (see '?filterFeature').
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 2466 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 0 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 0 rows and 10 columns
```

The same filters can be created using the forumla interface:

```
filterFeatures(hl, ~ markers == "Mitochondrion")
```

```
## 'markers' found in 3 out of 3 assay(s).
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 167 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 162 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 113 rows and 10 columns
```

```
filterFeatures(hl, ~ qValue <= 0.001)
```

```
## 'qValue' found in 1 out of 3 assay(s).
```

```
## No filter applied to the following assay(s) because one or more
## filtering variables are missing in the rowData: peptides, proteins. You
## can control whether to remove or keep the features using the 'keep'
## argument (see '?filterFeature').
```

```
## An instance of class QFeatures (type: bulk) with 3 sets:
##
##  [1] psms: SummarizedExperiment with 2466 rows and 10 columns
##  [2] peptides: SummarizedExperiment with 0 rows and 10 columns
##  [3] proteins: SummarizedExperiment with 0 rows and 10 columns
```

# Session information

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
##  [1] gplots_3.2.0                dplyr_1.1.4
##  [3] ggplot2_4.0.0               QFeatures_1.20.0
##  [5] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
##  [4] caTools_1.18.3          lattice_0.22-7          bitops_1.0-9
##  [7] vctrs_0.6.5             tools_4.5.1             tibble_3.3.0
## [10] cluster_2.1.8.1         pkgconfig_2.0.3         BiocBaseUtils_1.12.0
## [13] KernSmooth_2.23-26      Matrix_1.7-4            RColorBrewer_1.1-3
## [16] S7_0.2.0                lifecycle_1.0.4         compiler_4.5.1
## [19] farver_2.1.2            stringr_1.5.2           statmod_1.5.1
## [22] tinytex_0.57            clue_0.3-66             htmltools_0.5.8.1
## [25] sass_0.4.10             yaml_2.3.10             lazyeval_0.2.2
## [28] pillar_1.11.1           jquerylib_0.1.4         tidyr_1.3.1
## [31] MASS_7.3-65             limma_3.66.0            DelayedArray_0.36.0
## [34] cachem_1.1.0            magick_2.9.0            abind_1.4-8
## [37] gtools_3.9.5            tidyselect_1.2.1        digest_0.6.37
## [40] stringi_1.8.7           reshape2_1.4.4          purrr_1.1.0
## [43] bookdown_0.45           labeling_0.4.3          fastmap_1.2.0
## [46] grid_4.5.1              cli_3.6.5               SparseArray_1.10.0
## [49] magrittr_2.0.4          S4Arrays_1.10.0         dichromat_2.0-0.1
## [52] withr_3.0.2             scales_1.4.0            rmarkdown_2.30
## [55] XVector_0.50.0          igraph_2.2.1            evaluate_1.0.5
## [58] knitr_1.50              rlang_1.1.6             Rcpp_1.1.0
## [61] glue_1.8.0              BiocManager_1.30.26     msdata_0.49.0
## [64] jsonlite_2.0.0          AnnotationFilter_1.34.0 R6_2.6.1
## [67] plyr_1.8.9              ProtGenerics_1.42.0     MsCoreUtils_1.22.0
```

# License

This vignette is distributed under a
[CC BY-SA license](https://creativecommons.org/licenses/by-sa/2.0/)
license.

# References

Christoforou, Andy, Claire M Mulvey, Lisa M Breckels, Aikaterini Geladaki, Tracey Hurrell, Penelope C Hayward, Thomas Naake, et al. 2016. “A Draft Map of the Mouse Pluripotent Stem Cell Spatial Proteome.” *Nat Commun* 7: 8992. <https://doi.org/10.1038/ncomms9992>.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2019. *SummarizedExperiment: SummarizedExperiment Container*.

Morgan, Martin, and Johannes Rainer. 2019. *AnnotationFilter: Facilities for Filtering Bioconductor Annotation Resources*. <https://github.com/Bioconductor/AnnotationFilter>.

Ramos, Marcel, Lucas Schiffer, Angela Re, Rimsha Azhar, Azfar Basunia, Carmen Rodriguez Cabrera, Tiffany Chan, et al. 2017. “Software for the Integration of Multi-Omics Experiments in Bioconductor.” *Cancer Research* 77(21); e39-42.