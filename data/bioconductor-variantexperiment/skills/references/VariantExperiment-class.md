# VariantExperiment: A RangedSummarizedExperiment Container for Large-Scale Variant Data with GDS Backend

#### last edit: 04/10/2024

#### Package

VariantExperiment 1.24.0

# 1 Introduction

With the rapid development of the biotechnologies, the sequencing
(e.g., DNA, bulk/single-cell RNA, etc.) and other types of biological
data are getting increasingly larger-profile. The memory space in R
has been an obstable for fast and efficient data processing, because
most available *R* or *Bioconductor* packages are developed based on
in-memory data manipulation. [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment) has achieved
efficient on-disk saving/reading of the large-scale count data as
[HDF5Array](https://bioconductor.org/packages/HDF5Array) objects. However, there was still no such light-weight
containers available for high-throughput variant data (e.g., DNA-seq,
genotyping, etc.).

We have developed [VariantExperiment](https://bioconductor.org/packages/VariantExperiment), a *Bioconductor* package to
contain variant data into `RangedSummarizedExperiment` object. The
package converts and represent VCF/GDS files using standard
`SummarizedExperiment` metaphor. It is a container for high-through
variant data with GDS back-end.

In `VariantExperiment`, The high-throughput variant data is saved in
[DelayedArray](https://bioconductor.org/packages/DelayedArray) objects with GDS back-end. In addition to the
light-weight `Assay` data, it also supports the on-disk saving of
annotation data for both features and samples (corresponding to
`rowData/colData` respectively) by implementing the
[DelayedDataFrame](http://bioconductor.org/packages/DelayedDataFrame) data structure. The on-disk representation of
both assay data and annotation data realizes on-disk reading and
processing and saves *R* memory space significantly. The interface of
`RangedSummarizedExperiment` data format enables easy and common
manipulations for high-throughput variant data with common
[SummarizedExperiment](https://bioconductor.org/packages/SummarizedExperiment) metaphor in *R* and *Bioconductor*.

# 2 Installation

1. Download the package from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("VariantExperiment")
```

Or install the development version of the package from Github.

```
BiocManager::install("Bioconductor/VariantExperiment")
```

2. Load the package into R session.

```
library(VariantExperiment)
```

# 3 Background

## 3.1 GDSArray

[GDSArray](https://bioconductor.org/packages/GDSArray) is a *Bioconductor* package that represents `GDS` files as
objects derived from the [DelayedArray](https://bioconductor.org/packages/DelayedArray) package and `DelayedArray`
class. It converts `GDS` nodes into a `DelayedArray`-derived data
structure. The rich common methods and data operations defined on
`GDSArray` makes it more *R*-user-friendly than working with the GDS
file directly.

The `GDSArray()` constructor takes 2 arguments: the file path and the
GDS node name (which can be retrieved with the `gdsnodes()` function)
inside the GDS file.

```
library(GDSArray)
```

```
## Loading required package: gdsfmt
```

```
## Loading required package: DelayedArray
```

```
## Loading required package: Matrix
```

```
##
## Attaching package: 'Matrix'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
## Loading required package: S4Arrays
```

```
## Loading required package: abind
```

```
##
## Attaching package: 'S4Arrays'
```

```
## The following object is masked from 'package:abind':
##
##     abind
```

```
## The following object is masked from 'package:base':
##
##     rowsum
```

```
## Loading required package: SparseArray
```

```
##
## Attaching package: 'DelayedArray'
```

```
## The following objects are masked from 'package:base':
##
##     apply, scale, sweep
```

```
file <- GDSArray::gdsExampleFileName("seqgds")
```

```
## This is a SeqArray GDS file
```

```
gdsnodes(file)
```

```
##  [1] "sample.id"                  "variant.id"
##  [3] "position"                   "chromosome"
##  [5] "allele"                     "genotype/data"
##  [7] "genotype/~data"             "genotype/extra.index"
##  [9] "genotype/extra"             "phase/data"
## [11] "phase/~data"                "phase/extra.index"
## [13] "phase/extra"                "annotation/id"
## [15] "annotation/qual"            "annotation/filter"
## [17] "annotation/info/AA"         "annotation/info/AC"
## [19] "annotation/info/AN"         "annotation/info/DP"
## [21] "annotation/info/HM2"        "annotation/info/HM3"
## [23] "annotation/info/OR"         "annotation/info/GP"
## [25] "annotation/info/BN"         "annotation/format/DP/data"
## [27] "annotation/format/DP/~data" "sample.annotation/family"
```

```
GDSArray(file, "genotype/data")
```

```
## <2 x 90 x 1348> GDSArray object of type "integer":
## ,,1
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ,,2
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ...
##
## ,,1347
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     0     0     0     0   .     0     0     0     0
## [2,]     0     0     0     0   .     0     0     0     0
##
## ,,1348
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     3     3     3     3
## [2,]     3     3     1     3   .     3     3     3     3
```

```
GDSArray(file, "sample.id")
```

```
## <90> GDSArray object of type "character":
##      [1]       [2]       [3]       .         [89]      [90]
## "NA06984" "NA06985" "NA06986"         . "NA12891" "NA12892"
```

More details about `GDS` or `GDSArray` format can be found in the
vignettes of the [gdsfmt](https://bioconductor.org/packages/gdsfmt), [SNPRelate](https://bioconductor.org/packages/SNPRelate), [SeqArray](https://bioconductor.org/packages/SeqArray), [GDSArray](https://bioconductor.org/packages/GDSArray)
and [DelayedArray](https://bioconductor.org/packages/DelayedArray) packages.

## 3.2 DelayedDataFrame

[DelayedDataFrame](http://bioconductor.org/packages/DelayedDataFrame) is a *Bioconductor* package that implements
delayed operations on `DataFrame` objects using standard `DataFrame`
metaphor. Each column of data inside `DelayedDataFrame` is represented
as 1-dimensional `GDSArray` with on-disk GDS file. Methods like
`show`,`validity check`, `[`, `[[` subsetting, `rbind`, `cbind` are
implemented for `DelayedDataFrame`. The `DelayedDataFrame` stays lazy
until an explicit realization call like `DataFrame()` constructor or
`as.list()` triggered. More details about [DelayedDataFrame](http://bioconductor.org/packages/DelayedDataFrame) data
structure could be found in the vignette of [DelayedDataFrame](http://bioconductor.org/packages/DelayedDataFrame)
package.

# 4 `VariantExperiment` class

## 4.1 `VariantExperiment` class

`VariantExperiment` class is defined to extend
`RangedSummarizedExperiment`. The difference would be that the assay
data are saved as `DelayedArray`, and the annotation data are saved by
default as `DelayedDataFrame` (with option to save as ordinary
`DataFrame`), both of which are representing the data on-disk with
`GDS` back-end.

Conversion methods into `VariantExperiment` object are
defined directly for `VCF` and `GDS` files.   Here we show one simple
example to convert a DNA-sequencing data in GDS format into
`VariantExperiment` and some class-related operations.

```
ve <- makeVariantExperimentFromGDS(file)
ve
```

```
## class: VariantExperiment
## dim: 1348 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(1348): 1 2 ... 1347 1348
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(1): family
```

In this example, the sequencing file in GDS format was converted into
a `VariantExperiment` object, with all available assay data saved into
the `assay` slot, all available feature annotation nodes into
`rowRanges/rowData` slot, and all available sample annotation nodes
into `colData` slot. The available values for each arguments in
`makeVariantExperimentFromGDS()` function can be retrieved using the
`showAvailable()` function.

```
args(makeVariantExperimentFromGDS)
```

```
## function (file, ftnode, smpnode, assayNames = NULL, rowDataColumns = NULL,
##     colDataColumns = NULL, rowDataOnDisk = TRUE, colDataOnDisk = TRUE,
##     infoColumns = NULL)
## NULL
```

```
showAvailable(file)
```

```
## CharacterList of length 4
## [["assayNames"]] genotype/data phase/data annotation/format/DP/data
## [["rowDataColumns"]] allele annotation/id annotation/qual annotation/filter
## [["colDataColumns"]] family
## [["infoColumns"]] AC AN DP HM2 HM3 OR GP BN
```

## 4.2 slot accessors

Assay data are in `GDSArray` format, and could be retrieve by the
`assays()/assay()` function. **NOTE** that when converted into a
`VariantExperiment` object, the assay data will be checked and
permuted, so that the first 2 dimensions always match to features
(variants/snps) and samples respectively, no matter how are the
dimensions are with the original GDSArray that can be constructed.

```
assays(ve)
```

```
## List of length 3
## names(3): genotype/data phase/data annotation/format/DP/data
```

```
assay(ve, 1)
```

```
## <1348 x 90 x 2> DelayedArray object of type "integer":
## ,,1
##      NA06984 NA06985 NA06986 NA06989 ... NA12889 NA12890 NA12891 NA12892
##    1       3       3       0       3   .       0       0       0       0
##    2       3       3       0       3   .       0       0       0       0
##  ...       .       .       .       .   .       .       .       .       .
## 1347       0       0       0       0   .       0       0       0       0
## 1348       3       3       0       3   .       3       3       3       3
##
## ,,2
##      NA06984 NA06985 NA06986 NA06989 ... NA12889 NA12890 NA12891 NA12892
##    1       3       3       0       3   .       0       0       0       0
##    2       3       3       0       3   .       0       0       0       0
##  ...       .       .       .       .   .       .       .       .       .
## 1347       0       0       0       0   .       0       0       0       0
## 1348       3       3       1       3   .       3       3       3       3
```

```
GDSArray(file, "genotype/data")  ## original GDSArray from GDS file before permutation
```

```
## <2 x 90 x 1348> GDSArray object of type "integer":
## ,,1
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ,,2
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     0     0     0     0
## [2,]     3     3     0     3   .     0     0     0     0
##
## ...
##
## ,,1347
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     0     0     0     0   .     0     0     0     0
## [2,]     0     0     0     0   .     0     0     0     0
##
## ,,1348
##       [,1]  [,2]  [,3]  [,4] ... [,87] [,88] [,89] [,90]
## [1,]     3     3     0     3   .     3     3     3     3
## [2,]     3     3     1     3   .     3     3     3     3
```

In this example, the original `GDSArray` object from genotype data was
`2 x 90 x 1348`. But it was permuted to `1348 x 90 x 2` when
constructed into the `VariantExperiment` object.

The `rowData()` of the `VariantExperiment` is by default saved in
`DelayedDataFrame` format. We can use `rowRanges()` / `rowData()` to
retrieve the feature-related annotation file, with/without a
GenomicRange format.

```
rowRanges(ve)
```

```
## GRanges object with 1348 ranges and 13 metadata columns:
##        seqnames    ranges strand | annotation.id annotation.qual
##           <Rle> <IRanges>  <Rle> |    <GDSArray>      <GDSArray>
##      1        1   1105366      * |   rs111751804             NaN
##      2        1   1105411      * |   rs114390380             NaN
##      3        1   1110294      * |     rs1320571             NaN
##    ...      ...       ...    ... .           ...             ...
##   1346       22  43691009      * |     rs8135982             NaN
##   1347       22  43691073      * |   rs116581756             NaN
##   1348       22  48958933      * |     rs5771206             NaN
##        annotation.filter            REF            ALT    info.AC    info.AN
##               <GDSArray> <DelayedArray> <DelayedArray> <GDSArray> <GDSArray>
##      1              PASS              T              C          4        114
##      2              PASS              G              A          1        106
##      3              PASS              G              A          6        154
##    ...               ...            ...            ...        ...        ...
##   1346              PASS              C              T         11        142
##   1347              PASS              G              A          1        152
##   1348              PASS              A              G          1          6
##           info.DP   info.HM2   info.HM3    info.OR     info.GP    info.BN
##        <GDSArray> <GDSArray> <GDSArray> <GDSArray>  <GDSArray> <GDSArray>
##      1       3251          0          0              1:1115503        132
##      2       2676          0          0              1:1115548        132
##      3       7610          1          1              1:1120431         88
##    ...        ...        ...        ...        ...         ...        ...
##   1346        823          0          0            22:45312345        116
##   1347       1257          0          0            22:45312409        132
##   1348         48          0          0            22:50616806        114
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

```
rowData(ve)
```

```
## DelayedDataFrame with 1348 rows and 13 columns
##      annotation.id annotation.qual annotation.filter            REF
##         <GDSArray>      <GDSArray>        <GDSArray> <DelayedArray>
## 1      rs111751804             NaN              PASS              T
## 2      rs114390380             NaN              PASS              G
## 3        rs1320571             NaN              PASS              G
## ...            ...             ...               ...            ...
## 1346     rs8135982             NaN              PASS              C
## 1347   rs116581756             NaN              PASS              G
## 1348     rs5771206             NaN              PASS              A
##                 ALT    info.AC    info.AN    info.DP   info.HM2   info.HM3
##      <DelayedArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray>
## 1                 C          4        114       3251          0          0
## 2                 A          1        106       2676          0          0
## 3                 A          6        154       7610          1          1
## ...             ...        ...        ...        ...        ...        ...
## 1346              T         11        142        823          0          0
## 1347              A          1        152       1257          0          0
## 1348              G          1          6         48          0          0
##         info.OR     info.GP    info.BN
##      <GDSArray>  <GDSArray> <GDSArray>
## 1                 1:1115503        132
## 2                 1:1115548        132
## 3                 1:1120431         88
## ...         ...         ...        ...
## 1346            22:45312345        116
## 1347            22:45312409        132
## 1348            22:50616806        114
```

sample-related annotation is by default in `DelayedDataFrame` format,
and could be retrieved by `colData()`.

```
colData(ve)
```

```
## DelayedDataFrame with 90 rows and 1 column
##             family
##         <GDSArray>
## NA06984       1328
## NA06985
## NA06986      13291
## ...            ...
## NA12890       1463
## NA12891
## NA12892
```

The `gdsfile()` will retrieve the gds file path associated with the
`VariantExperiment` object.

```
gdsfile(ve)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SeqArray/extdata/CEU_Exon.gds"
```

Some other getter function like `metadata()` will return any metadata
that we have saved inside the `VariantExperiment` object.

```
metadata(ve)
```

```
## list()
```

# 5 Coercion methods

To take advantage of the functions and methods that are defined on
`SummarizedExperiment`, from which the `VariantExperiment` extends, we
have defined coercion methods from `VCF` and `GDS` to
`VariantExperiment`.

## 5.1 From `VCF` to `VariantExperiment`

The coercion function of `makeVariantExperimentFromVCF` could
convert the `VCF` file directly into `VariantExperiment` object. To
achieve the best storage efficiency, the assay data are saved in
`DelayedArray` format, and the annotation data are saved in
`DelayedDataFrame` format (with no option of ordinary `DataFrame`),
which could be retrieved by `rowData()` for feature related
annotations and `colData()` for sample related annotations (Only when
`sample.info` argument is specified).

```
vcf <- SeqArray::seqExampleFileName("vcf")
ve <- makeVariantExperimentFromVCF(vcf, out.dir = tempfile())
ve
```

```
## class: VariantExperiment
## dim: 1348 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(1348): 1 2 ... 1347 1348
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(0):
```

Internally, the `VCF` file was converted into a on-disk `GDS` file,
which could be retrieved by:

```
gdsfile(ve)
```

```
## [1] "/tmp/RtmphPAQ4T/file3db9416aefa642/se.gds"
```

assay data is in `DelayedArray` format:

```
assay(ve, 1)
```

```
## <1348 x 90 x 2> DelayedArray object of type "integer":
## ,,1
##      NA06984 NA06985 NA06986 NA06989 ... NA12889 NA12890 NA12891 NA12892
##    1       3       3       0       3   .       0       0       0       0
##    2       3       3       0       3   .       0       0       0       0
##  ...       .       .       .       .   .       .       .       .       .
## 1347       0       0       0       0   .       0       0       0       0
## 1348       3       3       0       3   .       3       3       3       3
##
## ,,2
##      NA06984 NA06985 NA06986 NA06989 ... NA12889 NA12890 NA12891 NA12892
##    1       3       3       0       3   .       0       0       0       0
##    2       3       3       0       3   .       0       0       0       0
##  ...       .       .       .       .   .       .       .       .       .
## 1347       0       0       0       0   .       0       0       0       0
## 1348       3       3       1       3   .       3       3       3       3
```

feature-related annotation is in `DelayedDataFrame` format:

```
rowData(ve)
```

```
## DelayedDataFrame with 1348 rows and 13 columns
##      annotation.id annotation.qual annotation.filter            REF
##         <GDSArray>      <GDSArray>        <GDSArray> <DelayedArray>
## 1      rs111751804             NaN              PASS              T
## 2      rs114390380             NaN              PASS              G
## 3        rs1320571             NaN              PASS              G
## ...            ...             ...               ...            ...
## 1346     rs8135982             NaN              PASS              C
## 1347   rs116581756             NaN              PASS              G
## 1348     rs5771206             NaN              PASS              A
##                 ALT    info.AC    info.AN    info.DP   info.HM2   info.HM3
##      <DelayedArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray>
## 1                 C          4        114       3251          0          0
## 2                 A          1        106       2676          0          0
## 3                 A          6        154       7610          1          1
## ...             ...        ...        ...        ...        ...        ...
## 1346              T         11        142        823          0          0
## 1347              A          1        152       1257          0          0
## 1348              G          1          6         48          0          0
##         info.OR     info.GP    info.BN
##      <GDSArray>  <GDSArray> <GDSArray>
## 1                 1:1115503        132
## 2                 1:1115548        132
## 3                 1:1120431         88
## ...         ...         ...        ...
## 1346            22:45312345        116
## 1347            22:45312409        132
## 1348            22:50616806        114
```

User could also have the opportunity to save the sample related
annotation info directly into the `VariantExperiment` object, by
providing the file path to the `sample.info` argument, and then
retrieve by `colData()`.

```
sampleInfo <- system.file("extdata", "Example_sampleInfo.txt",
                          package="VariantExperiment")
vevcf <- makeVariantExperimentFromVCF(vcf, sample.info = sampleInfo)
```

```
## Warning in (function (node, name, val = NULL, storage = storage.mode(val), :
## Missing characters are converted to "".
```

```
colData(vevcf)
```

```
## DelayedDataFrame with 90 rows and 1 column
##             family
##         <GDSArray>
## NA06984       1328
## NA06985
## NA06986      13291
## ...            ...
## NA12890       1463
## NA12891
## NA12892
```

Arguments could be specified to take only certain info columns or format
columns from the vcf file.

```
vevcf1 <- makeVariantExperimentFromVCF(vcf, info.import=c("OR", "GP"))
rowData(vevcf1)
```

```
## DelayedDataFrame with 1348 rows and 7 columns
##      annotation.id annotation.qual annotation.filter            REF
##         <GDSArray>      <GDSArray>        <GDSArray> <DelayedArray>
## 1      rs111751804             NaN              PASS              T
## 2      rs114390380             NaN              PASS              G
## 3        rs1320571             NaN              PASS              G
## ...            ...             ...               ...            ...
## 1346     rs8135982             NaN              PASS              C
## 1347   rs116581756             NaN              PASS              G
## 1348     rs5771206             NaN              PASS              A
##                 ALT    info.OR     info.GP
##      <DelayedArray> <GDSArray>  <GDSArray>
## 1                 C              1:1115503
## 2                 A              1:1115548
## 3                 A              1:1120431
## ...             ...        ...         ...
## 1346              T            22:45312345
## 1347              A            22:45312409
## 1348              G            22:50616806
```

In the above example, only 2 info entries (“OR” and “GP”) are read
into the `VariantExperiment` object.

The `start` and `count` arguments could be used to specify the start
position and number of variants to read into `Variantexperiment`
object.

```
vevcf2 <- makeVariantExperimentFromVCF(vcf, start=101, count=1000)
vevcf2
```

```
## class: VariantExperiment
## dim: 1000 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(1000): 101 102 ... 1099 1100
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(0):
```

For the above example, only 1000 variants are read into the
`VariantExperiment` object, starting from the position of 101.

## 5.2 From `GDS` to `VariantExperiment`

The coercion function of `makeVariantExperimentFromGDS` coerces `GDS`
files into `VariantExperiment` objects directly, with the assay data
saved as `DelayedArray`, and the `rowData()/colData()` in
`DelayedDataFrame` by default (with the option of ordinary `DataFrame`
object).

```
gds <- SeqArray::seqExampleFileName("gds")
ve <- makeVariantExperimentFromGDS(gds)
ve
```

```
## class: VariantExperiment
## dim: 1348 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(1348): 1 2 ... 1347 1348
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(1): family
```

Arguments could be specified to take only certain annotation columns
for features and samples. All available data entries for
`makeVariantExperimentFromGDS` arguments could be retrieved by the
`showAvailable()` function with the gds file name as input.

```
showAvailable(gds)
```

```
## CharacterList of length 4
## [["assayNames"]] genotype/data phase/data annotation/format/DP/data
## [["rowDataColumns"]] allele annotation/id annotation/qual annotation/filter
## [["colDataColumns"]] family
## [["infoColumns"]] AC AN DP HM2 HM3 OR GP BN
```

Note that the `infoColumns` from gds file will be saved as columns
inside the `rowData()`, with the prefix of
“info.”. `rowDataOnDisk/colDataOnDisk` could be set as `FALSE` to
save all annotation data in ordinary `DataFrame` format.

```
ve3 <- makeVariantExperimentFromGDS(gds,
                                    rowDataColumns = c("allele", "annotation/id"),
                                    infoColumns = c("AC", "AN", "DP"),
                                    rowDataOnDisk = TRUE,
                                    colDataOnDisk = FALSE)
rowData(ve3)  ## DelayedDataFrame object
```

```
## DelayedDataFrame with 1348 rows and 6 columns
##      annotation.id            REF            ALT    info.AC    info.AN
##         <GDSArray> <DelayedArray> <DelayedArray> <GDSArray> <GDSArray>
## 1      rs111751804              T              C          4        114
## 2      rs114390380              G              A          1        106
## 3        rs1320571              G              A          6        154
## ...            ...            ...            ...        ...        ...
## 1346     rs8135982              C              T         11        142
## 1347   rs116581756              G              A          1        152
## 1348     rs5771206              A              G          1          6
##         info.DP
##      <GDSArray>
## 1          3251
## 2          2676
## 3          7610
## ...         ...
## 1346        823
## 1347       1257
## 1348         48
```

```
colData(ve3)  ## DataFrame object
```

```
## DataFrame with 90 rows and 1 column
##              family
##         <character>
## NA06984        1328
## NA06985
## NA06986       13291
## ...             ...
## NA12890        1463
## NA12891
## NA12892
```

## 5.3 customization for certain gds types

For GDS formats of `SEQ_ARRAY` (defined in [SeqArray](https://bioconductor.org/packages/SeqArray) as
`SeqVarGDSClass` class) and `SNP_ARRAY` (defined in [SNPRelate](https://bioconductor.org/packages/SNPRelate) as
`SNPGDSFileClass` class), we have made some customized transfer of
certain nodes when reading into `VariantExperiment` object for users’
convenience.

The `allele` node in `SEQ_ARRAY` gds file is converted into 2 columns
in `rowData()` asn `REF` and `ALT`.

```
veseq <- makeVariantExperimentFromGDS(file,
                                      rowDataColumns = c("allele"),
                                      infoColumns = character(0))
rowData(veseq)
```

```
## DelayedDataFrame with 1348 rows and 2 columns
##                 REF            ALT
##      <DelayedArray> <DelayedArray>
## 1                 T              C
## 2                 G              A
## 3                 G              A
## ...             ...            ...
## 1346              C              T
## 1347              G              A
## 1348              A              G
```

The `snp.allele` node in `SNP_ARRAY` gds file was converted into 2
columns in `rowData()` as `snp.allele1` and `snp.allele2`.

```
snpfile <- SNPRelate::snpgdsExampleFileName()
vesnp <- makeVariantExperimentFromGDS(snpfile,
                                      rowDataColumns = c("snp.allele"))
rowData(vesnp)
```

```
## DelayedDataFrame with 9088 rows and 2 columns
##         snp.allele1    snp.allele2
##      <DelayedArray> <DelayedArray>
## 1                 G              T
## 2                 C              T
## 3                 A              G
## ...             ...            ...
## 9086              A              G
## 9087              C              T
## 9088              A              C
```

# 6 Subsetting methods

`VariantExperiment` supports basic subsetting operations using `[`,
`[[`, `$`, and ranged-based subsetting operations using
`subsetByOverlap`.

## 6.1 two-dimensional subsetting

```
ve[1:10, 1:5]
```

```
## class: VariantExperiment
## dim: 10 5
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(10): 1 2 ... 9 10
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(5): NA06984 NA06985 NA06986 NA06989 NA06994
## colData names(1): family
```

## 6.2 `$` subsetting

The `$` subsetting can be operated directly on `colData()` columns,
for easy sample extraction. **NOTE** that the `colData/rowData` are
(by default) in the `DelayedDataFrame` format, with each column saved
as `GDSArray`. So when doing subsetting, we need to use `as.logical()`
to convert the 1-dimensional `GDSArray` into ordinary vector.

```
colData(ve)
```

```
## DelayedDataFrame with 90 rows and 1 column
##             family
##         <GDSArray>
## NA06984       1328
## NA06985
## NA06986      13291
## ...            ...
## NA12890       1463
## NA12891
## NA12892
```

```
ve[, as.logical(ve$family == "1328")]
```

```
## class: VariantExperiment
## dim: 1348 2
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(1348): 1 2 ... 1347 1348
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(2): NA06984 NA06989
## colData names(1): family
```

subsetting by `rowData()` columns.

```
rowData(ve)
```

```
## DelayedDataFrame with 1348 rows and 13 columns
##      annotation.id annotation.qual annotation.filter            REF
##         <GDSArray>      <GDSArray>        <GDSArray> <DelayedArray>
## 1      rs111751804             NaN              PASS              T
## 2      rs114390380             NaN              PASS              G
## 3        rs1320571             NaN              PASS              G
## ...            ...             ...               ...            ...
## 1346     rs8135982             NaN              PASS              C
## 1347   rs116581756             NaN              PASS              G
## 1348     rs5771206             NaN              PASS              A
##                 ALT    info.AC    info.AN    info.DP   info.HM2   info.HM3
##      <DelayedArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray> <GDSArray>
## 1                 C          4        114       3251          0          0
## 2                 A          1        106       2676          0          0
## 3                 A          6        154       7610          1          1
## ...             ...        ...        ...        ...        ...        ...
## 1346              T         11        142        823          0          0
## 1347              A          1        152       1257          0          0
## 1348              G          1          6         48          0          0
##         info.OR     info.GP    info.BN
##      <GDSArray>  <GDSArray> <GDSArray>
## 1                 1:1115503        132
## 2                 1:1115548        132
## 3                 1:1120431         88
## ...         ...         ...        ...
## 1346            22:45312345        116
## 1347            22:45312409        132
## 1348            22:50616806        114
```

```
ve[as.logical(rowData(ve)$REF == "T"),]
```

```
## class: VariantExperiment
## dim: 214 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(214): 1 4 ... 1320 1328
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(1): family
```

## 6.3 Range-based operations

`VariantExperiment` objects support all of the `findOverlaps()`
methods and associated functions. This includes `subsetByOverlaps()`,
which makes it easy to subset a `VariantExperiment` object by an
interval.

```
ve1 <- subsetByOverlaps(ve, GRanges("22:1-48958933"))
ve1
```

```
## class: VariantExperiment
## dim: 23 90
## metadata(0):
## assays(3): genotype/data phase/data annotation/format/DP/data
## rownames(23): 1326 1327 ... 1347 1348
## rowData names(13): annotation.id annotation.qual ... info.GP info.BN
## colnames(90): NA06984 NA06985 ... NA12891 NA12892
## colData names(1): family
```

In this example, only 23 out of 1348 variants were retained with the
`GRanges` subsetting.

# 7 Save / load `VariantExperiment` object

Note that after the subsetting by `[`, `$` or `Ranged-based operations`, and you feel satisfied with the data for downstream
analysis, you need to save that `VariantExperiment` object to
synchronize the gds file (on-disk) associated with the subset of data
(in-memory representation) before any statistical analysis. Otherwise,
an error will be returned.

0
## save `VariantExperiment` object

Use the function `saveVariantExperiment` to synchronize the on-disk
and in-memory representation. This function writes the processed data
as `ve.gds`, and save the *R* object (which lazily represent the
backend data set) as `ve.rds` under the specified directory. It
finally returns a new `VariantExperiment` object into current R
session generated from the newly saved data.

```
a <- tempfile()
ve2 <- saveVariantExperiment(ve1, dir=a, replace=TRUE, chunk_size = 30)
```

## 7.1 load `VariantExperiment` object

You can alternatively use `loadVariantExperiment` to load the
synchronized data into R session, by providing only the file
directory. It reads the `VariantExperiment` object saved as `ve.rds`, as lazy
representation of the backend `ve.gds` file under the specific
directory.

```
ve3 <- loadVariantExperiment(dir=a)
gdsfile(ve3)
```

```
## [1] "/tmp/RtmphPAQ4T/file3db9415548cc6e/ve.gds"
```

```
all.equal(ve2, ve3)
```

```
## [1] TRUE
```

# 8 Session Info

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
##  [1] GDSArray_1.30.0             DelayedArray_0.36.0
##  [3] SparseArray_1.10.0          S4Arrays_1.10.0
##  [5] abind_1.4-8                 Matrix_1.7-4
##  [7] gdsfmt_1.46.0               VariantExperiment_1.24.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0          crayon_1.5.3            compiler_4.5.1
##  [4] BiocManager_1.30.26     Biostrings_2.78.0       parallel_4.5.1
##  [7] SNPRelate_1.44.0        jquerylib_0.1.4         RhpcBLASctl_0.23-42
## [10] yaml_2.3.10             fastmap_1.2.0           lattice_0.22-7
## [13] R6_2.6.1                XVector_0.50.0          knitr_1.50
## [16] bookdown_0.45           bslib_0.9.0             rlang_1.1.6
## [19] cachem_1.1.0            xfun_0.53               sass_0.4.10
## [22] cli_3.6.5               digest_0.6.37           grid_4.5.1
## [25] SeqArray_1.50.0         DelayedDataFrame_1.26.0 lifecycle_1.0.4
## [28] evaluate_1.0.5          rmarkdown_2.30          tools_4.5.1
## [31] htmltools_0.5.8.1
```