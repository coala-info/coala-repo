# ASCAT to RaggedExperiment

Lydia King1 and Marcel Ramos2

1University of Galway, Ireland
2Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### 30 October 2025

#### Package

RaggedExperiment 1.34.0

# 1 Introduction

The *[RaggedExperiment](https://bioconductor.org/packages/3.22/RaggedExperiment)* package provides a flexible data
representation for copy number, mutation and other ragged array schema for
genomic location data. The output of Allele-Specific Copy number Analysis of
Tumors (ASCAT) can be classed as a ragged array and contains whole genome
allele-specific copy number information for each sample in the analysis. For
more information on ASCAT and guidelines on how to generate ASCAT data please
see the ASCAT
[website](https://www.crick.ac.uk/research/labs/peter-van-loo/software) and
[github](https://github.com/VanLoo-lab/ascat). To carry out further analysis of
the ASCAT data, utilising the functionalities of `RaggedExperiment`, the ASCAT
data must undergo a number of operations to get it in the correct format for use
with `RaggedExperiment`.

# 2 Installation

```
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("RaggedExperiment")
```

Loading the package:

```
library(RaggedExperiment)
library(GenomicRanges)
```

# 3 Structure of ASCAT data

The data shown below is the output obtained from ASCAT. ASCAT takes Log R Ratio
(LRR) and B Allele Frequency (BAF) files and derives the allele-specific copy
number profiles of tumour cells, accounting for normal cell admixture and tumour
aneuploidy. It should be noted that if working with raw CEL files, the first
step is to preprocess the CEL files using the PennCNV-Affy pipeline described
[here](https://penncnv.openbioinformatics.org/en/latest/user-guide/affy/). The
PennCNV-Affy pipeline produces the LRR and BAF files used as inputs for ASCAT.

Depending on user preference, the output of ASCAT can be multiple files, each
one containing allele-specific copy number information for one of the samples
processed in an ASCAT run, or can be a single file containing allele-specific
copy number information for all samples processed in an ASCAT run.

Let’s load up and have a look at ASCAT data that contains copy number
information for just one sample i.e. sample1. Here we load up the data, check
that it only contains allele-specific copy number calls for 1 sample and look at
the first 10 rows of the dataframe.

```
ASCAT_data_S1 <- read.delim(
    system.file(
        "extdata", "ASCAT_Sample1.txt",
        package = "RaggedExperiment", mustWork = TRUE
    ),
    header = TRUE
)

unique(ASCAT_data_S1$sample)
```

```
## [1] "sample1"
```

```
head(ASCAT_data_S1, n = 10)
```

```
##     sample chr  startpos    endpos nMajor nMinor
## 1  sample1   1     61735 152555527      1      1
## 2  sample1   1 152555706 152586540      0      0
## 3  sample1   1 152586576 152761923      1      1
## 4  sample1   1 152761939 152768700      0      0
## 5  sample1   1 152773905 249224388      1      1
## 6  sample1   2     12784  32630548      1      1
## 7  sample1   2  32635284  33331778      2      1
## 8  sample1   2  33333871 243089456      1      1
## 9  sample1   3     60345 197896118      1      1
## 10 sample1   4     12281 191027923      1      1
```

Now let’s load up and have a look at ASCAT data that contains copy number
information for the three processed samples i.e. sample1, sample2 and sample3.
Here we load up the data, check that it contains allele-specific copy number
calls for the 3 samples and look at the first 10 rows of the dataframe. We also
note that as expected the copy number calls for sample1 are the same as above.

```
ASCAT_data_All <- read.delim(
    system.file(
        "extdata", "ASCAT_All_Samples.txt",
        package = "RaggedExperiment", mustWork = TRUE
    ),
    header = TRUE
)

unique(ASCAT_data_All$sample)
```

```
## [1] "sample1" "sample2" "sample3"
```

```
head(ASCAT_data_All, n = 10)
```

```
##     sample chr  startpos    endpos nMajor nMinor
## 1  sample1   1     61735 152555527      1      1
## 2  sample1   1 152555706 152586540      0      0
## 3  sample1   1 152586576 152761923      1      1
## 4  sample1   1 152761939 152768700      0      0
## 5  sample1   1 152773905 249224388      1      1
## 6  sample1   2     12784  32630548      1      1
## 7  sample1   2  32635284  33331778      2      1
## 8  sample1   2  33333871 243089456      1      1
## 9  sample1   3     60345 197896118      1      1
## 10 sample1   4     12281 191027923      1      1
```

From the output above we can see that the ASCAT data has 6 columns named sample,
chr, startpos, endpos, nMajor and nMinor. These correspond to the sample ID,
chromosome, the start position and end position of the genomic ranges and the
copy number of the major and minor alleles i.e. the homologous chromosomes.

# 4 Converting ASCAT data to `GRanges` format

The `RaggedExperiment` class derives from a `GRangesList` representation and can
take a `GRanges` object, a `GRangesList` or a list of `Granges` as inputs. To be
able to use the ASCAT data in `RaggedExperiment` we must convert the ASCAT data
into `GRanges` format. Ideally, we want each of our `GRanges` objects to
correspond to an individual sample.

## 4.1 ASCAT to `GRanges` objects

In the case where the ASCAT data has only 1 sample it is relatively simple to
produce a `GRanges` object.

```
sample1_ex1 <- GRanges(
    seqnames = Rle(paste0("chr", ASCAT_data_S1$chr)),
    ranges = IRanges(
        start = ASCAT_data_S1$startpos, end = ASCAT_data_S1$endpos
    ),
    strand = Rle(strand("*")),
    nmajor = ASCAT_data_S1$nMajor,
    nminor = ASCAT_data_S1$nMinor
)

sample1_ex1
```

```
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nmajor    nminor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]     chr1     61735-152555527      * |         1         1
##    [2]     chr1 152555706-152586540      * |         0         0
##    [3]     chr1 152586576-152761923      * |         1         1
##    [4]     chr1 152761939-152768700      * |         0         0
##    [5]     chr1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]    chr21   10736871-48096957      * |         1         1
##   [38]    chr22   16052528-51234455      * |         1         1
##   [39]     chrX     168477-54984266      * |         1         1
##   [40]     chrX   54988163-66944988      * |         2         0
##   [41]     chrX  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

Here we create a `GRanges` object by taking each column of the ASCAT data and
assigning them to the appropriate argument in the `GRanges` function. From above
we can see that the chromosome information is prefixed with “chr” and becomes
the seqnames column, the start and end positions are combined into an `IRanges`
object and given to the ranges argument, the strand column contains a `*` for
each entry as we don’t have strand information and the metadata columns contain
the allele-specific copy number calls and are called nmajor and nminor. The
`GRanges` object we have just created contains 41 ranges (rows) and 2 metadata
columns.

Another way that we can easily convert our ASCAT data, containing 1 sample, to a
`GRanges` object is to use the `makeGRangesFromDataFrame` function from the
`GenomicsRanges` package. Here we indicate what columns in our data correspond
to the chromosome (given to the `seqnames` argument), start and end positions
(`start.field` and `end.field` arguments), whether to ignore strand information
and assign all entries `*` (`ignore.strand`) and also whether to keep the other
columns in the dataframe, nmajor and nminor, as metadata columns
(`keep.extra.columns`).

```
sample1_ex2 <- makeGRangesFromDataFrame(
    ASCAT_data_S1[,-c(1)],
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE
)

sample1_ex2
```

```
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-152555527      * |         1         1
##    [2]        1 152555706-152586540      * |         0         0
##    [3]        1 152586576-152761923      * |         1         1
##    [4]        1 152761939-152768700      * |         0         0
##    [5]        1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]       21   10736871-48096957      * |         1         1
##   [38]       22   16052528-51234455      * |         1         1
##   [39]        X     168477-54984266      * |         1         1
##   [40]        X   54988163-66944988      * |         2         0
##   [41]        X  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

In the case where the ASCAT data contains more than 1 sample you can first use
the `split` function to split the whole dataframe into multiple dataframes, one
for each sample, and then create a `GRanges` object for each dataframe. Code to
split the dataframe, based on sample ID, is given below and then the same
procedure used to produce `sample1_ex2` can be implemented to create the
`GRanges` object. Alternatively, an easier and more efficient way to do this is
to use the `makeGRangesListFromDataFrame` function from the `GenomicsRanges`
package. This will be covered in the next section.

```
sample_list <- split(
    ASCAT_data_All,
    f = ASCAT_data_All$sample
)
```

## 4.2 ASCAT to `GRangesList` instance

To produce a `GRangesList` instance from the ASCAT dataframe we can use the
`makeGRangesListFromDataFrame` function. This function takes the same arguments
as the `makeGRangesFromDataFrame` function used above, but also has an argument
specifying how the rows of the `df` are split (`split.field`). Here we will
split on sample. This function can be used in cases where the ASCAT data
contains only 1 sample or where it contains multiple samples.

Using `makeGRangesListFromDataFrame` to create a list of `GRanges` objects where
ASCAT data has only 1 sample:

```
sample_list_GRanges_ex1 <- makeGRangesListFromDataFrame(
    ASCAT_data_S1,
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE,
    split.field = "sample"
)

sample_list_GRanges_ex1
```

```
## GRangesList object of length 1:
## $sample1
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-152555527      * |         1         1
##    [2]        1 152555706-152586540      * |         0         0
##    [3]        1 152586576-152761923      * |         1         1
##    [4]        1 152761939-152768700      * |         0         0
##    [5]        1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]       21   10736871-48096957      * |         1         1
##   [38]       22   16052528-51234455      * |         1         1
##   [39]        X     168477-54984266      * |         1         1
##   [40]        X   54988163-66944988      * |         2         0
##   [41]        X  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

Using `makeGRangesListFromDataFrame` to create a `list` of `GRanges` objects
where ASCAT data has multiple samples:

```
sample_list_GRanges_ex2 <- makeGRangesListFromDataFrame(
    ASCAT_data_All,
    ignore.strand=TRUE,
    seqnames.field="chr",
    start.field="startpos",
    end.field="endpos",
    keep.extra.columns=TRUE,
    split.field = "sample"
)

sample_list_GRanges_ex2
```

```
## GRangesList object of length 3:
## $sample1
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-152555527      * |         1         1
##    [2]        1 152555706-152586540      * |         0         0
##    [3]        1 152586576-152761923      * |         1         1
##    [4]        1 152761939-152768700      * |         0         0
##    [5]        1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]       21   10736871-48096957      * |         1         1
##   [38]       22   16052528-51234455      * |         1         1
##   [39]        X     168477-54984266      * |         1         1
##   [40]        X   54988163-66944988      * |         2         0
##   [41]        X  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
##
## $sample2
## GRanges object with 64 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-238045995      * |         1         1
##    [2]        1 238046253-249224388      * |         2         0
##    [3]        2     12784-243089456      * |         1         1
##    [4]        3     60345-197896118      * |         1         1
##    [5]        4     12281-191027923      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [60]        X     168477-18760388      * |         1         1
##   [61]        X   18761872-22174817      * |         2         0
##   [62]        X   22175673-55224760      * |         1         1
##   [63]        X   55230288-67062507      * |         2         0
##   [64]        X  67065988-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
##
## $sample3
## GRanges object with 30 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-121482979      * |         2         0
##    [2]        1 144007049-249224388      * |         2         2
##    [3]        2     12784-243089456      * |         2         0
##    [4]        3     60345-197896118      * |         2         0
##    [5]        4     12281-191027923      * |         2         0
##    ...      ...                 ...    ... .       ...       ...
##   [26]       20      61305-62956153      * |         2         2
##   [27]       21   10736871-44320760      * |         2         0
##   [28]       21   44320989-48096957      * |         3         0
##   [29]       22   16052528-51234455      * |         2         0
##   [30]        X    168477-155233846      * |         2         2
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

Each `GRanges` object in the `list` can then be accessed using square bracket
notation.

```
sample1_ex3 <- sample_list_GRanges_ex2[[1]]

sample1_ex3
```

```
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nMajor    nMinor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]        1     61735-152555527      * |         1         1
##    [2]        1 152555706-152586540      * |         0         0
##    [3]        1 152586576-152761923      * |         1         1
##    [4]        1 152761939-152768700      * |         0         0
##    [5]        1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]       21   10736871-48096957      * |         1         1
##   [38]       22   16052528-51234455      * |         1         1
##   [39]        X     168477-54984266      * |         1         1
##   [40]        X   54988163-66944988      * |         2         0
##   [41]        X  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

Another way we can produce a `GRangesList` instance is to use the `GRangesList`
function. This function creates a list that contains all our `GRanges` objects.
This is straightforward in that we use the `GRangesList` function with our
`GRanges` objects as named or unnamed inputs. Below we have created a list that
includes 1 `GRanges` objects, created in section 4.1., corresponding to sample1.

```
sample_list_GRanges_ex3 <- GRangesList(
    sample1 = sample1_ex1
)

sample_list_GRanges_ex3
```

```
## GRangesList object of length 1:
## $sample1
## GRanges object with 41 ranges and 2 metadata columns:
##        seqnames              ranges strand |    nmajor    nminor
##           <Rle>           <IRanges>  <Rle> | <integer> <integer>
##    [1]     chr1     61735-152555527      * |         1         1
##    [2]     chr1 152555706-152586540      * |         0         0
##    [3]     chr1 152586576-152761923      * |         1         1
##    [4]     chr1 152761939-152768700      * |         0         0
##    [5]     chr1 152773905-249224388      * |         1         1
##    ...      ...                 ...    ... .       ...       ...
##   [37]    chr21   10736871-48096957      * |         1         1
##   [38]    chr22   16052528-51234455      * |         1         1
##   [39]     chrX     168477-54984266      * |         1         1
##   [40]     chrX   54988163-66944988      * |         2         0
##   [41]     chrX  66945740-155233846      * |         1         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

# 5 Constructing a `RaggedExperiment` object from ASCAT output

Now we have created the `GRanges` objects and `GRangesList` instances we can
easily use `RaggedExperiment`.

## 5.1 Using `GRanges` objects

From above we have a `GRanges` object derived from the ASCAT data containing 1
sample i.e. `sample1_ex1` / `sample1_ex2` and the capabilities to produce
individual `GRanges` objects derived from the ASCAT data containing 3 samples.
We can now use these `GRanges` objects as inputs to `RaggedExperiment`. Note
that we create column data `colData` to describe the samples.

Using `GRanges` object where ASCAT data only has 1 sample:

```
colDat_1 = DataFrame(id = 1)

ragexp_1 <- RaggedExperiment(
    sample1 = sample1_ex2,
    colData = colDat_1
)

ragexp_1
```

```
## class: RaggedExperiment
## dim: 41 1
## assays(2): nMajor nMinor
## rownames: NULL
## colnames(1): sample1
## colData names(1): id
```

In the case where you have multiple `GRanges` objects, corresponding to
different samples, the code is similar to above. Each sample is inputted into
the `RaggedExperiment` function and `colDat_1` corresponds to the id for each
sample i.e. 1, 2 and 3, if 3 samples are provided.

## 5.2 Using a `GRangesList` instance

From before we have a `GRangesList` derived from the ASCAT data containing 1
sample i.e. `sample_list_GRanges_ex1` and the `GRangesList` derived from the
ASCAT data containing 3 samples i.e. `sample_list_GRanges_ex2`. We can now use
this `GRangesList` as the input to `RaggedExperiment`.

Using `GRangesList` where ASCAT data only has 1 sample:

```
ragexp_2 <- RaggedExperiment(
    sample_list_GRanges_ex1,
    colData = colDat_1
)

ragexp_2
```

```
## class: RaggedExperiment
## dim: 41 1
## assays(2): nMajor nMinor
## rownames: NULL
## colnames(1): sample1
## colData names(1): id
```

Using `GRangesList` where ASCAT data only has multiple samples:

```
colDat_3 = DataFrame(id = 1:3)

ragexp_3 <- RaggedExperiment(
    sample_list_GRanges_ex2,
    colData = colDat_3
)

ragexp_3
```

```
## class: RaggedExperiment
## dim: 135 3
## assays(2): nMajor nMinor
## rownames: NULL
## colnames(3): sample1 sample2 sample3
## colData names(1): id
```

We can also use the `GRangesList` produced using the `GRangesList` function:

```
ragexp_4  <- RaggedExperiment(
    sample_list_GRanges_ex3,
    colData = colDat_1
)

ragexp_4
```

```
## class: RaggedExperiment
## dim: 41 1
## assays(2): nmajor nminor
## rownames: NULL
## colnames(1): sample1
## colData names(1): id
```

# 6 Downstream Analysis

Now that we have the ASCAT data converted to `RaggedExperiment` objects, we can
use the \*Assay functions that are described in the `RaggedExperiment` vignette
found in the [landing page](https://bioconductor.org/packages/RaggedExperiment/). These functions provide several different
functions for representing ranged data in a rectangular matrix. They make it
easy to find genomic segments shared/not shared between each sample considered
and provide the corresponding allele-specific copy number calls for each sample
across each segment.

# 7 Session Information

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
## [1] RaggedExperiment_1.34.0 GenomicRanges_1.62.0    Seqinfo_1.0.0
## [4] IRanges_2.44.0          S4Vectors_0.48.0        BiocGenerics_0.56.0
## [7] generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5                   knitr_1.50
##  [3] rlang_1.1.6                 xfun_0.53
##  [5] DelayedArray_0.36.0         jsonlite_2.0.0
##  [7] SummarizedExperiment_1.40.0 htmltools_0.5.8.1
##  [9] BiocBaseUtils_1.12.0        MatrixGenerics_1.22.0
## [11] sass_0.4.10                 Biobase_2.70.0
## [13] rmarkdown_2.30              grid_4.5.1
## [15] abind_1.4-8                 evaluate_1.0.5
## [17] jquerylib_0.1.4             fastmap_1.2.0
## [19] yaml_2.3.10                 lifecycle_1.0.4
## [21] bookdown_0.45               BiocManager_1.30.26
## [23] compiler_4.5.1              XVector_0.50.0
## [25] lattice_0.22-7              digest_0.6.37
## [27] R6_2.6.1                    SparseArray_1.10.0
## [29] Matrix_1.7-4                bslib_0.9.0
## [31] tools_4.5.1                 matrixStats_1.5.0
## [33] S4Arrays_1.10.0             cachem_1.1.0
```