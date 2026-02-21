# RNAmodR.ML: detecting patterns of post-transcriptional modifications using machine learning

Felix G.M. Ernst and Denis L.J. Lafontaine

#### 2025-10-30

#### Package

RNAmodR.ML 1.24.0

# 1 Introduction

Post-transcriptional modifications can be found abundantly in rRNA and tRNA and
can be detected classically via several strategies. However, difficulties arise
if the identity and the position of the modified nucleotides is to be determined
at the same time. Classically, a primer extension, a form of reverse
transcription (RT), would allow certain modifications to be accessed by blocks
during the RT changes or changes in the cDNA sequences. Other modification would
need to be selectively treated by chemical reactions to influence the outcome of
the reverse transcription.

With the increased availability of high throughput sequencing, these classical
methods were adapted to high throughput methods allowing more RNA molecules to
be accessed at the same time. However, patterns of some modification cannot be
detected by accessing small number of parameters. For these cases machine
learning models can be trained on data from positions known to be modified
in order to detect additional modified positions.

To extend the functionality of the `RNAmodR` package and classical detection
strategies used for RiboMethSeq or AlkAnilineSeq (see `RNAmodR.RiboMethSeq` and
`RNAmodR.AlkAnilineSeq` packages) towards detection through machine learning
models, `RNAmodR.ML` provides classes and an example workflow.

# 2 Using RNAmodR.ML

```
## No methods found in package 'rtracklayer' for request: 'trackName<-' when loading 'AnnotationHubData'
```

```
## Warning: replacing previous import 'utils::findMatches' by
## 'S4Vectors::findMatches' when loading 'ExperimentHubData'
```

```
library(rtracklayer)
library(GenomicRanges)
library(RNAmodR.ML)
library(RNAmodR.Data)
```

The `ModifierML` class extends the `Modifier` class from the `RNAmodR` package
and adds one slot, `mlModel`, a getter/setter `getMLModel`/`setMLModel`, an
additional `useMLModel` function to be called from the `aggregate` function.

The slot `mlModel` can either be an empty character or contain a name of a
`ModifierMLModel` class, which is loaded upon creation of a `ModifierML` object,
and serves as a wrapper around a machine learning model. For different types of
machine learning models `ModifierMLModel` derived classes are available, which
currently are:

* `ModifierMLranger` for models generated with the `ranger` package
  [(Wright and Ziegler [2017](#ref-Wright.2017))](#References)
* `ModifierMLkeras` for models generated with the `keras` package
  [(Allaire and Chollet [2018](#ref-Allaire.2018))](#References)

To illustrate how to develop a machine learning model with help from the
`RNAmodR.ML` package, an example is given below.

# 3 Development of new `Modifier` class

As an example for this vignette, we will try to detect D positions in
AlkAnilineSeq data. First define a specific `ModifierML` class loading pileup
and coverage data. In this example, the RNA specific `RNAModifierML` class is
used.

```
setClass("ModMLExample",
         contains = c("RNAModifierML"),
         prototype = list(mod = c("D"),
                          score = "score",
                          dataType = c("PileupSequenceData",
                                       "CoverageSequenceData"),
                          mlModel = character(0)))
# constructor function for ModMLExample
ModMLExample <- function(x, annotation = NA, sequences = NA, seqinfo = NA,
                           ...){
  RNAmodR:::Modifier("ModMLExample", x = x, annotation = annotation,
                     sequences = sequences, seqinfo = seqinfo, ...)
}

setClass("ModSetMLExample",
         contains = "ModifierSet",
         prototype = list(elementType = "ModMLExample"))
# constructor function for ModSetMLExample
ModSetMLExample <- function(x, annotation = NA, sequences = NA, seqinfo = NA,
                              ...){
  RNAmodR:::ModifierSet("ModMLExample", x, annotation = annotation,
                        sequences = sequences, seqinfo = seqinfo, ...)
}
```

Since the `mlModel` slot contains an empty character, the creation of the object
will not automatically trigger a search for modifications. However, it will
aggregate the data in the format we want to use. The `aggregate_example`
function is just an example and the aggregation of the data is part of the
model building. (See (#Summary))

```
setMethod(
  f = "aggregateData",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      aggregate_example(x)
    }
)
```

# 4 Getting training data

To gather training data, we just create a `ModMLExample` object and let it do
its job.

```
me <-  ModMLExample(files[[1]], annotation, sequences)
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ...
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## OK
## Loading Pileup data from BAM files ... OK
## Loading Coverage data from BAM files ... OK
## Aggregating data and calculating scores ... Starting to search for 'Dihydrouridine' ...
```

```
## Warning: ML model not set. Skipped search for modifications ...
```

```
## done.
```

Afterwards we need to load/create coordinates for positions known to be modified
as well as positions known to be unmodified.

```
data("dmod",package = "RNAmodR.ML")
# we just select the next U position from known positions
nextUPos <- function(gr){
  nextU <- lapply(seq.int(1L,2L),
                  function(i){
                    subseq <- subseq(sequences(me)[dmod$Parent], start(dmod)+3L)
                    pos <- start(dmod) + 2L +
                      vapply(strsplit(as.character(subseq),""),
                    function(y){which(y == "U")[i]},integer(1))
                    ans <- dmod
                    ranges(ans) <- IRanges(start = pos, width = 1L)
                    ans
                  })
  nextU <- do.call(c,nextU)
  nextU$mod <- NULL
  unique(nextU)
}
nondmod <- nextUPos(dmod)
nondmod <- nondmod[!(nondmod %in% dmod)]
coord <- unique(c(dmod,nondmod))
coord <- coord[order(as.integer(coord$Parent))]
```

With these coordinates the aggregated data of the `ModMLExample` can be subset
to a training data set using the function `trainingData`.

```
trainingData <- trainingData(me,coord)
trainingData <- unlist(trainingData, use.names = FALSE)
# converting logical labels to integer
trainingData$labels <- as.integer(trainingData$labels)
```

# 5 Training a model

How a specific model can be trained or what kind of strategies can be employed
to successfully train a model, is out of scope for the vignette. For this
example a random forest is trained using the functionality provided by the
`ranger` package.

```
library(ranger)
model <- ranger(labels ~ ., data.frame(trainingData))
```

# 6 Constructing a ‘ModifierMLModel’

Now, the trained model can be used to create a new `ModifierMLModel` class and
object.

```
setClass("ModifierMLexample",
         contains = c("ModifierMLranger"),
         prototype = list(model = model))
ModifierMLexample <- function(...){
  new("ModifierMLexample")
}
mlmodel <- ModifierMLexample()
```

To be able to use the model via the `ModifierMLModel` class, we also need to
define an accessor to the predictions made by the model. This function is called
`useModel` and is already prefined for the `ModifierMLModel` classes mentioned
above in secion [Using RNAmodR.ML](#RNAmodR.ML).

```
getMethod("useModel", c("ModifierMLranger","ModifierML"))
```

```
## Method Definition:
##
## function (x, y)
## {
##     data <- getAggregateData(y)
##     model <- x@model
##     if (!is(model, "ranger")) {
##         stop("model is not a ranger model")
##     }
##     unlisted_data <- unlist(data, use.names = FALSE)
##     p <- predict(x@model, data.frame(unlisted_data))
##     relist(p$predictions, data)
## }
## <bytecode: 0x5751cc7adef8>
## <environment: namespace:RNAmodR.ML>
##
## Signatures:
##         x                  y
## target  "ModifierMLranger" "ModifierML"
## defined "ModifierMLranger" "ModifierML"
```

If the results of these function is not usable for a specific model, it can
redefined for your needs. As defined by `RNAmodR.ML` the function returns a
`NumericList` along the aggregated data of the `ModifierML` object.

# 7 Setting and using the model

The generated `ModifierMLexample` wrapper can now be set for the `ModifierML`
object using the `setMLModel` function. (If a model is saved as part of a
package, this step ist not necessary, because it can be part of the class
definition)

```
setMLModel(me) <- mlmodel
```

In order for the prediction data to be usable, another function has to be
implemented to save the predictions in the aggregated data. The function is
called `useMLModel`.

```
setMethod(f = "useMLModel",
          signature = signature(x = "ModMLExample"),
          definition =
            function(x){
              predictions <- useModel(getMLModel(x), x)
              data <- getAggregateData(x)
              unlisted_data <- unlist(data, use.names = FALSE)
              unlisted_data$score <- unlist(predictions)
              x@aggregate <- relist(unlisted_data,data)
              x
            }
)
```

By re-running the `aggregate` function and force an update of the data, the
predictions are made and used to populate the `score` column as outlined above.

```
me <- aggregate(me, force = TRUE)
```

# 8 Performance

During the model building phase some form of a performance measurement usually
is included. In addition to these model specific measurements, `RNAmodR.ML`
includes the functionality from the `ROCR` package inherited from the `RNAmodR`
package. With this the performance of a model can evaluted over the training set
or any coordinates.

```
plotROC(me, dmod)
```

![Performance of the maching learning model to distinguish unmodified from modified nucleotides.](data:image/png;base64...)

Figure 1: Performance of the maching learning model to distinguish unmodified from modified nucleotides

# 9 Using a `ModifierML` class

Since we want to use the `ModifierML` object to detect modifications, we also
need to define the `findMod` function. Based on the information on the
performance, we set a threshold of `0.8` for the prediction score for detecting
D modifications. In the example below this threshold is hardcoded in the
`find_mod_example` function, but can also be implemented using the `settings`
function.

```
setMethod(
  f = "findMod",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      find_mod_example(x, 25L)
    }
)
```

Now we can redfine the `ModMLExample` class with the slot `mlModel` already set
to the `ModifierMLexample` class. The `ModMLExample` is now complete.

```
rm(me)
setClass("ModMLExample",
         contains = c("RNAModifierML"),
         prototype = list(mod = c("D"),
                          score = "score",
                          dataType = c("PileupSequenceData",
                                       "CoverageSequenceData"),
                          mlModel = "ModifierMLexample"))
me <-  ModMLExample(files[[1]], annotation, sequences)
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ...
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## OK
## Loading Pileup data from BAM files ... OK
## Loading Coverage data from BAM files ... OK
## Aggregating data and calculating scores ... Starting to search for 'Dihydrouridine' ... done.
```

The detected modifications can be access using the `modifications` function.

```
mod <- modifications(me)
mod <- split(mod, factor(mod$Parent,levels = unique(mod$Parent)))
mod
```

```
## GRangesList object of length 35:
## $`1`
## GRanges object with 2 ranges and 5 metadata columns:
##             seqnames    ranges strand |         mod      source        type
##                <Rle> <IRanges>  <Rle> | <character> <character> <character>
##   [1] Q0020_15S_RRNA        48      + |           D  RNAmodR.ML      RNAMOD
##   [2] Q0020_15S_RRNA       323      + |           D  RNAmodR.ML      RNAMOD
##           score      Parent
##       <numeric> <character>
##   [1]  0.906338           1
##   [2]  0.823105           1
##   -------
##   seqinfo: 60 sequences from an unspecified genome; no seqlengths
##
## $`3`
## GRanges object with 4 ranges and 5 metadata columns:
##       seqnames    ranges strand |         mod      source        type     score
##          <Rle> <IRanges>  <Rle> | <character> <character> <character> <numeric>
##   [1]  RDN18-1       229      + |           D  RNAmodR.ML      RNAMOD  0.814467
##   [2]  RDN18-1       454      + |           D  RNAmodR.ML      RNAMOD  0.803700
##   [3]  RDN18-1      1225      + |           D  RNAmodR.ML      RNAMOD  0.826467
##   [4]  RDN18-1      1669      + |           D  RNAmodR.ML      RNAMOD  0.820700
##            Parent
##       <character>
##   [1]           3
##   [2]           3
##   [3]           3
##   [4]           3
##   -------
##   seqinfo: 60 sequences from an unspecified genome; no seqlengths
##
## $`4`
## GRanges object with 7 ranges and 5 metadata columns:
##       seqnames    ranges strand |         mod      source        type     score
##          <Rle> <IRanges>  <Rle> | <character> <character> <character> <numeric>
##   [1]  RDN25-1         2      + |           D  RNAmodR.ML      RNAMOD  0.865067
##   [2]  RDN25-1       748      + |           D  RNAmodR.ML      RNAMOD  0.867533
##   [3]  RDN25-1      1415      + |           D  RNAmodR.ML      RNAMOD  0.821367
##   [4]  RDN25-1      1720      + |           D  RNAmodR.ML      RNAMOD  0.828767
##   [5]  RDN25-1      2297      + |           D  RNAmodR.ML      RNAMOD  0.810100
##   [6]  RDN25-1      2571      + |           D  RNAmodR.ML      RNAMOD  0.821700
##   [7]  RDN25-1      2759      + |           D  RNAmodR.ML      RNAMOD  0.805767
##            Parent
##       <character>
##   [1]           4
##   [2]           4
##   [3]           4
##   [4]           4
##   [5]           4
##   [6]           4
##   [7]           4
##   -------
##   seqinfo: 60 sequences from an unspecified genome; no seqlengths
##
## ...
## <32 more elements>
```

# 10 Refining a model

Some of the modification found look reasonable. However, some of the positions
seem to be noise.

```
options(ucscChromosomeNames=FALSE)
```

```
plotDataByCoord(sequenceData(me),mod[["4"]][1])
```

![Visualization of sequence data](data:image/png;base64...)

Figure 2: Visualization of sequence data

Several options exist to improve the model: Either the threshold applied to the
prediction score can be raised to a higher value, like `0.9` or the model can
maybe retrained by including these position in another training data set. In
addition, the training data might be improved in general by higher sequencing
depth.

```
nonValidMod <- mod[c("1","4")]
nonValidMod[["18"]] <- nonValidMod[["18"]][2]
nonValidMod[["26"]] <- nonValidMod[["26"]][2]
nonValidMod <- unlist(nonValidMod)
nonValidMod <- nonValidMod[,"Parent"]
coord <- unique(c(dmod,nondmod,nonValidMod))
coord <- coord[order(as.integer(coord$Parent))]
```

As an example, a new model is trained including the wrongly identified
positions from the previous model as unmodified positions.

```
trainingData <- trainingData(me,coord)
trainingData <- unlist(trainingData, use.names = FALSE)
trainingData$labels <- as.integer(trainingData$labels)
```

```
model2 <- ranger(labels ~ ., data.frame(trainingData), num.trees = 2000)
setClass("ModifierMLexample2",
         contains = c("ModifierMLranger"),
         prototype = list(model = model2))
ModifierMLexample2 <- function(...){
  new("ModifierMLexample2")
}
mlmodel2 <- ModifierMLexample2()
me2 <- me
setMLModel(me2) <- mlmodel2
me2 <- aggregate(me2, force = TRUE)
```

After updating the `ModifierMLexample` class and aggregating the data again
the performance looks a bit better…

```
plotROC(me2, dmod, score="score")
```

![Performance aggregation of multiple samples and strategies.](data:image/png;base64...)

Figure 3: Performance aggregation of multiple samples and strategies

… and leads to a better result for detecting D modifications. Some positions
are not detected anymore, which suggest that this model is still not an optimal
solution and other factors could and should be improved upon as suggested above.

```
setMethod(
  f = "findMod",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      find_mod_example(x, 25L)
    }
)
me2 <- modify(me2, force = TRUE)
modifications(me2)
```

```
## GRanges object with 44 ranges and 5 metadata columns:
##         seqnames    ranges strand |         mod      source        type
##            <Rle> <IRanges>  <Rle> | <character> <character> <character>
##    [1]  tA-AGC-D        47      + |           D  RNAmodR.ML      RNAMOD
##    [2]  tA-TGC-A        20      + |           D  RNAmodR.ML      RNAMOD
##    [3]  tA-TGC-A        47      + |           D  RNAmodR.ML      RNAMOD
##    [4]  tC-GCA-B        19      + |           D  RNAmodR.ML      RNAMOD
##    [5]  tC-GCA-B        46      + |           D  RNAmodR.ML      RNAMOD
##    ...       ...       ...    ... .         ...         ...         ...
##   [40]  tV-AAC-O        48      + |           D  RNAmodR.ML      RNAMOD
##   [41]  tV-CAC-D        47      + |           D  RNAmodR.ML      RNAMOD
##   [42] tW-CCA-G1        16      + |           D  RNAmodR.ML      RNAMOD
##   [43] tW-CCA-G1        46      + |           D  RNAmodR.ML      RNAMOD
##   [44]  tY-GTA-D        21      + |           D  RNAmodR.ML      RNAMOD
##            score      Parent
##        <numeric> <character>
##    [1]  0.954708           6
##    [2]  0.805858           7
##    [3]  0.953908           7
##    [4]  0.911121           8
##    [5]  0.937208           8
##    ...       ...         ...
##   [40]  0.919542          56
##   [41]  0.904183          57
##   [42]  0.800942          59
##   [43]  0.818433          59
##   [44]  0.903117          60
##   -------
##   seqinfo: 60 sequences from an unspecified genome; no seqlengths
```

In addition to training a single model, several models can be trained and
combined to a `ModifierSet`.

```
mse <- ModSetMLExample(list(one = me, two = me2))
```

An overall performance over several models can be analyzed or the individual
performance compaired.

```
plotROC(mse, dmod, score= "score",
        plot.args = list(avg = "threshold", spread.estimate = "stderror"))
```

![Performance average across models](data:image/png;base64...)

Figure 4: Performance average across models

If several models are trained and each provides useful information, these can be
package into a single `ModifierMLModel` class to combine the output of several
models. Some of the functions outlined above need, e.g. `useMLModel` and/or
`useModel`, to be modified to provide one or more scores for detecting a
modification.

# 11 Packaging

If the created models can be saved to file, they can also be included in a
package. This would allow others to use the models and the models can
potentially be improved upon with increasing version numbers.

# 12 Summary

`RNAmodR.ML` provides the interface for machine learning models to be used
with `RNAmodR` to detect modified nucleotides in high throughput sequencing
data. For your own work defining a working model might take some time. We hope
that by using `RNAmodR.ML` the steps surrounding this crucial step might become
a bit easier.

However, if some steps or design choices made for `RNAmodR.ML` do not suit your
need, let us know. Contributions are always welcome as well.

# 13 Hints

We also want to provide some additional hints and suggestions for developing
machine learning models.

1. the aggregate function is used in the example above as a feature engineering
   tool. You might want to skip this step, if you want to use a deep learning
   model for example with `keras`.
2. If you don’t want to engage in a feature enginering step and just want to
   aggregate the sequence data as is, just do a custom `cbind` on the data from
   the `SequenceData` objects (`cbind` works on `SequenceData` objects, if they
   are of the same type. Convert each of them to a `CompressedSplitDataFrameList`
   using `as(x,"CompressedSplitDataFrameList")`).
3. in a deep learning context, if a coordinate is selected without a flanking
   value, e.g. when using `trainingData`, a 2D tensor is returned (sample,
   values). This can be converted into a 3D tensor by providing a flanking value.

# 14 Sessioninfo

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
##  [1] ranger_0.17.0            Rsamtools_2.26.0         RNAmodR.Data_1.23.0
##  [4] ExperimentHubData_1.36.0 AnnotationHubData_1.40.0 futile.logger_1.4.3
##  [7] ExperimentHub_3.0.0      AnnotationHub_4.0.0      BiocFileCache_3.0.0
## [10] dbplyr_2.5.1             RNAmodR.ML_1.24.0        RNAmodR_1.24.0
## [13] Modstrings_1.26.0        Biostrings_2.78.0        XVector_0.50.0
## [16] rtracklayer_1.70.0       GenomicRanges_1.62.0     Seqinfo_1.0.0
## [19] IRanges_2.44.0           S4Vectors_0.48.0         BiocGenerics_0.56.0
## [22] generics_0.1.4           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] BiocIO_1.20.0               bitops_1.0-9
##   [3] filelock_1.0.3              tibble_3.3.0
##   [5] graph_1.88.0                XML_3.99-0.19
##   [7] rpart_4.1.24                lifecycle_1.0.4
##   [9] httr2_1.2.1                 lattice_0.22-7
##  [11] ensembldb_2.34.0            OrganismDbi_1.52.0
##  [13] backports_1.5.0             magrittr_2.0.4
##  [15] Hmisc_5.2-4                 sass_0.4.10
##  [17] rmarkdown_2.30              jquerylib_0.1.4
##  [19] yaml_2.3.10                 RUnit_0.4.33.1
##  [21] Gviz_1.54.0                 DBI_1.2.3
##  [23] RColorBrewer_1.1-3          abind_1.4-8
##  [25] purrr_1.1.0                 AnnotationFilter_1.34.0
##  [27] biovizBase_1.58.0           RCurl_1.98-1.17
##  [29] nnet_7.3-20                 VariantAnnotation_1.56.0
##  [31] rappdirs_0.3.3              AnnotationForge_1.52.0
##  [33] codetools_0.2-20            DelayedArray_0.36.0
##  [35] tidyselect_1.2.1            UCSC.utils_1.6.0
##  [37] farver_2.1.2                matrixStats_1.5.0
##  [39] base64enc_0.1-3             GenomicAlignments_1.46.0
##  [41] jsonlite_2.0.0              Formula_1.2-5
##  [43] tools_4.5.1                 progress_1.2.3
##  [45] stringdist_0.9.15           Rcpp_1.1.0
##  [47] glue_1.8.0                  gridExtra_2.3
##  [49] SparseArray_1.10.0          BiocBaseUtils_1.12.0
##  [51] xfun_0.53                   MatrixGenerics_1.22.0
##  [53] GenomeInfoDb_1.46.0         dplyr_1.1.4
##  [55] withr_3.0.2                 formatR_1.14
##  [57] BiocManager_1.30.26         fastmap_1.2.0
##  [59] latticeExtra_0.6-31         caTools_1.18.3
##  [61] digest_0.6.37               R6_2.6.1
##  [63] colorspace_2.1-2            gtools_3.9.5
##  [65] jpeg_0.1-11                 dichromat_2.0-0.1
##  [67] biomaRt_2.66.0              RSQLite_2.4.3
##  [69] cigarillo_1.0.0             data.table_1.17.8
##  [71] prettyunits_1.2.0           httr_1.4.7
##  [73] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [75] pkgconfig_2.0.3             gtable_0.3.6
##  [77] blob_1.2.4                  S7_0.2.0
##  [79] htmltools_0.5.8.1           bookdown_0.45
##  [81] RBGL_1.86.0                 ProtGenerics_1.42.0
##  [83] scales_1.4.0                Biobase_2.70.0
##  [85] png_0.1-8                   colorRamps_2.3.4
##  [87] knitr_1.50                  lambda.r_1.2.4
##  [89] rstudioapi_0.17.1           reshape2_1.4.4
##  [91] rjson_0.2.23                checkmate_2.3.3
##  [93] curl_7.0.0                  biocViews_1.78.0
##  [95] cachem_1.1.0                stringr_1.5.2
##  [97] KernSmooth_2.23-26          BiocVersion_3.22.0
##  [99] parallel_4.5.1              foreign_0.8-90
## [101] AnnotationDbi_1.72.0        restfulr_0.0.16
## [103] pillar_1.11.1               grid_4.5.1
## [105] vctrs_0.6.5                 gplots_3.2.0
## [107] cluster_2.1.8.1             htmlTable_2.4.3
## [109] evaluate_1.0.5              magick_2.9.0
## [111] tinytex_0.57                GenomicFeatures_1.62.0
## [113] cli_3.6.5                   compiler_4.5.1
## [115] futile.options_1.0.1        rlang_1.1.6
## [117] crayon_1.5.3                interp_1.1-6
## [119] plyr_1.8.9                  stringi_1.8.7
## [121] deldir_2.0-4                BiocParallel_1.44.0
## [123] BiocCheck_1.46.0            txdbmaker_1.6.0
## [125] lazyeval_0.2.2              Matrix_1.7-4
## [127] BSgenome_1.78.0             hms_1.1.4
## [129] bit64_4.6.0-1               ggplot2_4.0.0
## [131] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
## [133] ROCR_1.0-11                 memoise_2.0.1
## [135] bslib_0.9.0                 bit_4.6.0
```

# References

Allaire, JJ, and François Chollet. 2018. *Keras: R Interface to ’Keras’*. [https://CRAN.R-project.org/package=keras](https://CRAN.R-project.org/package%3Dkeras).

Wright, Marvin N., and Andreas Ziegler. 2017. “ranger: A Fast Implementation of Random Forests for High Dimensional Data in C++ and R.” *Journal of Statistical Software* 77 (1): 1–17. <https://doi.org/10.18637/jss.v077.i01>.