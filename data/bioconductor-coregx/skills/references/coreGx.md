# CoreGx: Class and Function Abstractions for PharmacoGx, RadioGx and ToxicoGx

# CoreGx

This package provides a foundation for the PharmacoGx, RadioGx and ToxicoGx
packages. It is not intended for standalone use, only as a dependency for the
aforementioned software. Its existence allows abstracting generic definitions,
method definitions and class structures common to all three of the Gx suite
packages.

## Importing and Using CoreGx

Load the pacakge:

```
library(CoreGx)
library(Biobase)
library(SummarizedExperiment)
```

## The CoreSet Class

The `CoreSet` class is intended as a general purpose data structure for storing
multiomic treatment response data. Extensions of this class have been
customized for their respective fields of study. For example, the `PharmacoSet`
class inherits from the `CoreSet` and is specialized for storing and analyzing
drug sensitivity and perturbation experiments on cancer cell lines together with
associated multiomic data for each treated sample. The RadioSet class serves
a role similar to the PharmacoSet with radiation instead of drug treatments.
Finally, the ToxicoSet class is used to store toxicity data for healthy
human and rat hepatocytes along with the associated multiomic profile for each
treatment.

```
getClass("CoreSet")
```

```
## Class "CoreSet" [package "CoreGx"]
##
## Slots:
##
## Name:  treatmentResponse        annotation molecularProfiles            sample
## Class: list_OR_LongTable              list       list_OR_MAE        data.frame
##
## Name:          treatment       datasetType      perturbation          curation
## Class:        data.frame         character              list              list
```

The `annotation` slot holds the CoreSet name, the original constructor call, and
a range of metadata about the R session in which the constructor was called.
This allows easy comparison of `CoreSet` versions across time and ensures the
code used to generate a `CoreSet` is well-documented and reproducible.

The `molecularProfiles` slot contains a list of `SummarizedExperiment` objects
for each multi-omic molecular datatype available for a given experiment. Within
the `SummarizedExperiments` are feature and sample annotations for each data
type. We are currently in the process of adopting the `MultiAssayExperiment`
class instead of a `list` for storing molecular profile `SummarizedExperiment`s.
However, the `list` version of the `molecularProfiles` slot is still supported
for backwards compatability.

The `sample` slot contains a `data.frame` with annotations for samples used in
the molecularProfiles or sensitivity slot. It should at minimum have the
standardized column ‘sampleid’, with a unique identifier for each sample in the
`CoreSet`.

The `treatment` slot contains a `data.frame` of metadata for treatments applied
to samples in the `molecularProfiles` or `treatmentResponse` slot. It should at
minimum have the standarized column ‘treatmentid’, containing a unique
identifier for each treatment in the `CoreSet`.

The `datasetType` slot contains a character vector indicating the experiment
type the `CoreSet` contains. This slot is soft deprecated and may be removed
in future updates.

The `treatmentResponse` slot contains a list of raw, curated and meta data for
treatment-response experiments. We are currently in the process of adopting
our new S4-class, the `TreamtentResponseExperiment` to store treatment-response
data within a `CoreSet` and inheriting classes. However, the old `list` format
for sensitivity experiments will continue to be support for backwards
compatability.

The `perturbation` slot contains a list of raw, curated and meta data for
perturbation experiments. This slot is soft-deprecated and may be removed
in the future. The reason is that treatment perturbation experiments can be
efficiently stored in the `colData` slot of their respective
`SummarizedExperiment` objects and thus no longer require their own space within
a `CoreSet`.

The `curation` slot contains a list of manually curated identifiers
such as standardized cell-line, tissue and treatment names. Inclusion of such
identifiers ensures a consistent nomenclature is used across all datasets
curated into the classes inheriting from the `CoreSet`, enabling results from
such datasets to be easily compared to validate results from published studies or
combine them for use in larger meta-analyses. The slot contains a list of
`data.frame`s, one for each entity, and should at minimum include a mapping from
curated identifiers used throughout the object to those used in the original
dataset publication.

The `CoreSet` class provides a set of standardized accessor methods which
simplify curation, annotation, and retrieval of data associated with a specfic
treatment response experiment. All accessors are implemented as generics to
allow new methods to be defined on classes inheriting from the `CoreSet`.

```
methods(class="CoreSet")
```

```
##  [1] annotation              annotation<-            curation
##  [4] curation<-              datasetType             datasetType<-
##  [7] dateCreated             dateCreated<-           fNames
## [10] fNames<-                featureInfo             featureInfo<-
## [13] mDataNames              mDataNames<-            molecularProfiles
## [16] molecularProfiles<-     molecularProfilesSlot   molecularProfilesSlot<-
## [19] name                    name<-                  pertNumber
## [22] pertNumber<-            phenoInfo               phenoInfo<-
## [25] sampleInfo              sampleInfo<-            sampleNames
## [28] sampleNames<-           sensNumber              sensNumber<-
## [31] sensitivityInfo         sensitivityInfo<-       sensitivityMeasures
## [34] sensitivityMeasures<-   sensitivityProfiles     sensitivityProfiles<-
## [37] sensitivityRaw          sensitivityRaw<-        show
## [40] subsetByFeature         subsetBySample          subsetByTreatment
## [43] treatmentInfo           treatmentInfo<-         treatmentNames
## [46] treatmentNames<-        treatmentResponse       treatmentResponse<-
## [49] updateObject
## see '?methods' for accessing help and source code
```

We have provided a sample `CoreSet` (cSet) in this package. In the below code
we load the example cSet and demonstrate a few of the accessor methods.

```
data(clevelandSmall_cSet)
clevelandSmall_cSet
```

```
## <CoreSet>
## Name: Cleveland
## Date Created: Sat Feb 18 15:10:56 2023
## Number of samples:  10
## Molecular profiles: <MultiAssayExperiment>
##    ExperimentList class object of length 2:
##     [1] rna : SummarizedExperiment with 1000 rows and 9 columns
##     [2] rnaseq : SummarizedExperiment with 1000 rows and 9 columns
## Treatment response: <TreatmentResponseExperiment>
##    dim:  9 10
##    assays(2): sensitivity profiles
##    rownames(9): radiation:1:1 radiation:1:2 ... radiation:8:1 radiation:10:1
##    rowData(3): treatment1id treatment1dose replicate_id
##    colnames(10): CHP-212 IMR-32 KP-N-S19s ... SK-N-SH SNU-245 SNU-869
##    colData(2): sampleid rn
##    metadata(1): experiment_metadata
```

Access a specific molecular profiles:

```
mProf <- molecularProfiles(clevelandSmall_cSet, "rna")
mProf[seq_len(5), seq_len(5)]
```

```
##                 NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152
## ENSG00000000003                                   10.280970
## ENSG00000000005                                    3.647436
## ENSG00000000419                                   11.883769
## ENSG00000000457                                    7.515721
## ENSG00000000460                                    7.808139
##                 GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654
## ENSG00000000003                                         10.304971
## ENSG00000000005                                          4.895494
## ENSG00000000419                                         11.865191
## ENSG00000000457                                          7.187144
## ENSG00000000460                                          7.789921
##                 BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860
## ENSG00000000003                                    9.596987
## ENSG00000000005                                    3.793174
## ENSG00000000419                                   12.498285
## ENSG00000000457                                    8.076655
## ENSG00000000460                                    8.456691
##                 SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474
## ENSG00000000003                                    8.620860
## ENSG00000000005                                    3.674918
## ENSG00000000419                                   11.674671
## ENSG00000000457                                    6.790332
## ENSG00000000460                                    6.663846
##                 WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582
## ENSG00000000003                                    9.866551
## ENSG00000000005                                    3.748959
## ENSG00000000419                                   12.228260
## ENSG00000000457                                    7.292420
## ENSG00000000460                                    8.869378
```

Access cell-line metadata:

```
cInfo <- sampleInfo(clevelandSmall_cSet)
cInfo[seq_len(5), seq_len(5)]
```

```
##            sampleid          tissueid CellLine       Primarysite     Histology
## SK-N-FI     SK-N-FI autonomic_ganglia    SKNFI autonomic_ganglia neuroblastoma
## IMR-32       IMR-32 autonomic_ganglia    IMR32 autonomic_ganglia neuroblastoma
## SK-N-AS     SK-N-AS autonomic_ganglia    SKNAS autonomic_ganglia neuroblastoma
## CHP-212     CHP-212 autonomic_ganglia   CHP212 autonomic_ganglia neuroblastoma
## KP-N-S19s KP-N-S19s autonomic_ganglia  KPNSI9S autonomic_ganglia neuroblastoma
```

Access treatment-response data:

```
sensProf <- sensitivityProfiles(clevelandSmall_cSet)
sensProf[seq_len(5), seq_len(5)]
```

```
## [1] 1 2 3 4 5
```

For more information about the accessor methods available for the `CoreSet`
class please see the `class?CoreSet` help page.

## Extending the CoreSet Class

Given that the CoreSet class is intended for extension, we will show some
examples of how to define a new class based on it and implement new methods
for the generics provided for the CoreSet class.

Here we will define a new class, the `DemoSet`, with an additional slot, the
`demoSlot`. We will then view the available methods for this class as well as
define new S4 methods on it.

```
DemoSet <- setClass("DemoSet",
                    representation(demoSlot="character"),
                    contains="CoreSet")
getClass("DemoSet")
```

```
## Class "DemoSet" [in ".GlobalEnv"]
##
## Slots:
##
## Name:           demoSlot treatmentResponse        annotation molecularProfiles
## Class:         character list_OR_LongTable              list       list_OR_MAE
##
## Name:             sample         treatment       datasetType      perturbation
## Class:        data.frame        data.frame         character              list
##
## Name:           curation
## Class:              list
##
## Extends: "CoreSet"
```

Here we can see the class extending `CoreSet` has all of the same slots as the
original `CoreSet`, plus the new slot we defined: `demoSlot`.

We can see which methods are available for this new class.

```
methods(class="DemoSet")
```

```
##  [1] annotation              annotation<-            curation
##  [4] curation<-              datasetType             datasetType<-
##  [7] dateCreated             dateCreated<-           fNames
## [10] fNames<-                featureInfo             featureInfo<-
## [13] mDataNames              mDataNames<-            molecularProfiles
## [16] molecularProfiles<-     molecularProfilesSlot   molecularProfilesSlot<-
## [19] name                    name<-                  pertNumber
## [22] pertNumber<-            phenoInfo               phenoInfo<-
## [25] sampleInfo              sampleInfo<-            sampleNames
## [28] sampleNames<-           sensNumber              sensNumber<-
## [31] sensitivityInfo         sensitivityInfo<-       sensitivityMeasures
## [34] sensitivityMeasures<-   sensitivityProfiles     sensitivityProfiles<-
## [37] sensitivityRaw          sensitivityRaw<-        show
## [40] subsetByFeature         subsetBySample          subsetByTreatment
## [43] treatmentInfo           treatmentInfo<-         treatmentNames
## [46] treatmentNames<-        treatmentResponse       treatmentResponse<-
## [49] updateObject
## see '?methods' for accessing help and source code
```

We see that all the accessors defined for the `CoreSet` are also defined for the
inheriting `DemoSet`. These methods all assume the inherit slots have the same
structure as the `CoreSet`. If this is not true, for example, if molecularProfiles
holds `ExpressionSet`s instead of `SummarizedExperiment`s, we can redefine
existing methods as follows:

```
clevelandSmall_dSet <- DemoSet(clevelandSmall_cSet)
class(clevelandSmall_dSet@molecularProfiles[['rna']])
```

```
## [1] "SummarizedExperiment"
## attr(,"package")
## [1] "SummarizedExperiment"
```

```
expressionSets <- lapply(molecularProfilesSlot(clevelandSmall_dSet), FUN=as,
  'ExpressionSet')
molecularProfilesSlot(clevelandSmall_dSet) <- expressionSets

# Now this will error
tryCatch({molecularProfiles(clevelandSmall_dSet, 'rna')},
         error=function(e)
             print(paste("Error: ", e$message)))
```

```
## [1] "Error:  unable to find an inherited method for function 'assay' for signature 'x = \"ExpressionSet\", i = \"numeric\"'"
```

Since we changed the data in the `molecularProfiles` slot of the `DemoSet`,
the original method from `CoreGx` no longer works. Thus we get an error when
trying to access that slot. To fix this we will need to set a new S4 method
for the molecularProfiles generic function defined in `CoreGx`.

```
setMethod(molecularProfiles,
          signature("DemoSet"),
          function(object, mDataType) {
            pData(object@molecularProfiles[[mDataType]])
          })
```

This new method is now called whenever we use the `molecularProfiles` method
on a `DemoSet`. Since the new method uses `ExpressionSet` accessor methods
instead of `SummarizedExperiment` accessor methods, we now expect to be able
to access the data in our modified slot.

```
# Now we test our new method
mProf <- molecularProfiles(clevelandSmall_dSet, 'rna')
head(mProf)[seq_len(5), seq_len(5)]
```

```
##                                                                                          samplename
## NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152             NIECE_p_NCLE_RNA3_HG-U133_Plus_2_G10_296152
## GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654 GILDS_p_NCLE_RNA11_Redo_HG-U133_Plus_2_G02_587654
## BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860             BUNDS_p_NCLE_RNA5_HG-U133_Plus_2_B11_419860
## SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474             SILOS_p_NCLE_RNA9_HG-U133_Plus_2_A04_523474
## WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582             WATCH_p_NCLE_RNA8_HG-U133_Plus_2_B04_474582
##                                                                                                   filename
## NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152             NIECE_p_NCLE_RNA3_HG-U133_Plus_2_G10_296152.CEL.gz
## GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654 GILDS_p_NCLE_RNA11_Redo_HG-U133_Plus_2_G02_587654.CEL.gz
## BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860             BUNDS_p_NCLE_RNA5_HG-U133_Plus_2_B11_419860.CEL.gz
## SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474             SILOS_p_NCLE_RNA9_HG-U133_Plus_2_A04_523474.CEL.gz
## WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582             WATCH_p_NCLE_RNA8_HG-U133_Plus_2_B04_474582.CEL.gz
##                                                         chiptype
## NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152       HG-U133_Plus_2
## GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654 HG-U133_Plus_2
## BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860       HG-U133_Plus_2
## SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474       HG-U133_Plus_2
## WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582       HG-U133_Plus_2
##                                                   hybridization.date
## NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152                 07/15/08
## GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654         2010-05-21
## BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860                 12/19/08
## SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474               2009-12-08
## WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582               2009-08-14
##                                                   hybridization.hour
## NIECE_P_NCLE_RNA3_HG-U133_PLUS_2_G10_296152                 12:54:10
## GILDS_P_NCLE_RNA11_REDO_HG-U133_PLUS_2_G02_587654          16:45:06Z
## BUNDS_P_NCLE_RNA5_HG-U133_PLUS_2_B11_419860                 11:43:19
## SILOS_P_NCLE_RNA9_HG-U133_PLUS_2_A04_523474                20:44:59Z
## WATCH_P_NCLE_RNA8_HG-U133_PLUS_2_B04_474582                17:15:45Z
```

We can see our new method works! In order to finish updating the methods
for our new class, we would have to redefine all the methods which access the
modified slot.

However, additional work needs to be done to define accessors for the new
`demoSlot`. Since no generics are available in CoreGx to access this slot,
we need to first define a generic, then implement methods which dispatch on
the ‘DemoSet’ class to retrieve data in the slot.

```
# Define generic for setter method
setGeneric('demoSlot<-', function(object, value) standardGeneric('demoSlot<-'))
```

```
## [1] "demoSlot<-"
```

```
# Define a setter method
setReplaceMethod('demoSlot',
                 signature(object='DemoSet', value="character"),
                 function(object, value) {
                   object@demoSlot <- value
                   return(object)
                 })

# Lets add something to our demoSlot
demoSlot(clevelandSmall_dSet) <- c("This", "is", "the", "demoSlot")
```

```
# Define generic for getter method
setGeneric('demoSlot', function(object, ...) standardGeneric("demoSlot"))
```

```
## [1] "demoSlot"
```

```
# Define a getter method
setMethod("demoSlot",
          signature("DemoSet"),
          function(object) {
            paste(object@demoSlot, collapse=" ")
          })

# Test our getter method
demoSlot(clevelandSmall_dSet)
```

```
## [1] "This is the demoSlot"
```

Now you should have all the knowledge you need to extend the CoreSet class
for use in other treatment-response experiments!

For more information about this package and the possibility of collaborating on
its extension please contact benjamin.haibe.kains@utoronto.ca.

# sessionInfo

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
##  [1] knitr_1.50                  data.table_1.17.8
##  [3] CoreGx_2.14.0               SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocGenerics_0.56.0
## [13] generics_0.1.4              formatR_1.14
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                S7_0.2.0
##  [5] bitops_1.0-9                fastmap_1.2.0
##  [7] BumpyMatrix_1.18.0          shinyjs_2.1.0
##  [9] promises_1.4.0              digest_0.6.37
## [11] mime_0.13                   lifecycle_1.0.4
## [13] cluster_2.1.8.1             statmod_1.5.1
## [15] magrittr_2.0.4              compiler_4.5.1
## [17] rlang_1.1.6                 sass_0.4.10
## [19] tools_4.5.1                 igraph_2.2.1
## [21] yaml_2.3.10                 htmlwidgets_1.6.4
## [23] S4Arrays_1.10.0             bench_1.1.4
## [25] DelayedArray_0.36.0         marray_1.88.0
## [27] RColorBrewer_1.1-3          abind_1.4-8
## [29] BiocParallel_1.44.0         KernSmooth_2.23-26
## [31] grid_4.5.1                  relations_0.6-15
## [33] caTools_1.18.3              xtable_1.8-4
## [35] ggplot2_4.0.0               scales_1.4.0
## [37] gtools_3.9.5                dichromat_2.0-0.1
## [39] MultiAssayExperiment_1.36.0 cli_3.6.5
## [41] rmarkdown_2.30              crayon_1.5.3
## [43] otel_0.2.0                  visNetwork_2.1.4
## [45] BiocBaseUtils_1.12.0        sets_1.0-25
## [47] cachem_1.1.0                parallel_4.5.1
## [49] BiocManager_1.30.26         XVector_0.50.0
## [51] vctrs_0.6.5                 Matrix_1.7-4
## [53] jsonlite_2.0.0              slam_0.1-55
## [55] lsa_0.73.3                  bookdown_0.45
## [57] limma_3.66.0                jquerylib_0.1.4
## [59] glue_1.8.0                  codetools_0.2-20
## [61] DT_0.34.0                   cowplot_1.2.0
## [63] gtable_0.3.6                later_1.4.4
## [65] shinydashboard_0.7.3        tibble_3.3.0
## [67] pillar_1.11.1               htmltools_0.5.8.1
## [69] gplots_3.2.0                fgsea_1.36.0
## [71] R6_2.6.1                    evaluate_1.0.5
## [73] shiny_1.11.1                lattice_0.22-7
## [75] backports_1.5.0             SnowballC_0.7.1
## [77] httpuv_1.6.16               bslib_0.9.0
## [79] fastmatch_1.1-6             Rcpp_1.1.0
## [81] SparseArray_1.10.0          checkmate_2.3.3
## [83] xfun_0.53                   piano_2.26.0
## [85] pkgconfig_2.0.3
```