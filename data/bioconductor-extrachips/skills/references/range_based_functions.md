# extraChIPs: Range-Based operations

Stevie Pederson1,2,3\*

1Black Ochre Data Laboratories, Telethon Kids Institute, Adelaide, Australia
2Dame Roma Mitchell Cancer Researc Laboratories, University of Adelaide
3John Curtin School of Medical Research, Australian National University

\*stephen.pederson.au@gmail.com

#### 25 November 2025

#### Package

extraChIPs 1.14.2

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Coercion](#coercion)
* [4 Formation of Consensus Peaks](#formation-of-consensus-peaks)
* [5 Simple Operations Retaining `mcols()`](#simple-operations-retaining-mcols)
  + [5.1 Simplifying single `GRanges` objects](#simplifying-single-granges-objects)
  + [5.2 Set Operations with Two `GRanges` Objects](#set-operations-with-two-granges-objects)
  + [5.3 Overlapping proportions](#overlapping-proportions)
* [6 More Complex Operations](#more-complex-operations)
  + [6.1 Range Partitioning](#range-partitioning)
  + [6.2 Stitching Ranges](#stitching-ranges)
* [7 Session Info](#session-info)

# 1 Introduction

This package is designed to enable the Gene Regulatory Analysis using Variable
IP ([GRAVI](https://github.com/smped/GRAVI)) workflow, as a method for
detecting differential binding in ChIP-Seq datasets.
As a workflow focussed on data integration, most functions provided by the
package `extraChIPs` are designed to enable comparison across datasets.
This vignette looks primarily at functions which work with `GenomicRanges`
objects.

# 2 Installation

In order to use the package `extraChIPs` and follow this vignette, we recommend
using the package `BiocManager` hosted on CRAN.
Once this is installed, the additional packages required for this vignette
(`tidyverse`, `plyranges` and `Gviz`) can also be installed.

```
if (!"BiocManager" %in% rownames(installed.packages()))
  install.packages("BiocManager")
BiocManager::install(c("tidyverse", "plyranges", "Gviz"))
BiocManager::install("extraChIPs")
```

# 3 Coercion

The advent of the `tidyverse` has led to `tibble` objects becoming a common
alternative to `data.frame` or `DataFrame` objects.
Simple functions within `extraChIP` enable coercion from `GRanges`,
`GInteractions` and `DataFrame` objects to tibble objects, with list columns
correctly handled.
By default these coercion functions will coerce `GRanges` elements to a
character vector.
Similarly, `GRanges` represented as a character column can be coerced to the
ranges element of a `GRanges` object.

First let’s coerce from a `tibble` (or S3 `data.frame`) to a `GRanges`

```
library(tidyverse)
library(extraChIPs)
set.seed(73)
df <- tibble(
  range = c("chr1:1-10:+", "chr1:5-10:+", "chr1:5-6:+"),
  gene_id = "gene1",
  tx_id = paste0("transcript", 1:3),
  score = runif(3)
)
df
```

```
## # A tibble: 3 × 4
##   range       gene_id tx_id        score
##   <chr>       <chr>   <chr>        <dbl>
## 1 chr1:1-10:+ gene1   transcript1 0.442
## 2 chr1:5-10:+ gene1   transcript2 0.0831
## 3 chr1:5-6:+  gene1   transcript3 0.615
```

```
gr <- colToRanges(df, "range")
gr
```

```
## GRanges object with 3 ranges and 3 metadata columns:
##       seqnames    ranges strand |     gene_id       tx_id     score
##          <Rle> <IRanges>  <Rle> | <character> <character> <numeric>
##   [1]     chr1      1-10      + |       gene1 transcript1 0.4423369
##   [2]     chr1      5-10      + |       gene1 transcript2 0.0831099
##   [3]     chr1       5-6      + |       gene1 transcript3 0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Coercion back to a `tibble` will place the ranges as a character column by
default.
However, this can be turned off and the conventional coercion from
`as.data.frame` will instead be applied, internally wrapped in `as_tibble()`

```
as_tibble(gr)
```

```
## # A tibble: 3 × 4
##   range       gene_id tx_id        score
##   <chr>       <chr>   <chr>        <dbl>
## 1 chr1:1-10:+ gene1   transcript1 0.442
## 2 chr1:5-10:+ gene1   transcript2 0.0831
## 3 chr1:5-6:+  gene1   transcript3 0.615
```

```
as_tibble(gr, rangeAsChar = FALSE)
```

```
## # A tibble: 3 × 8
##   seqnames start   end width strand gene_id tx_id        score
##   <fct>    <int> <int> <int> <fct>  <chr>   <chr>        <dbl>
## 1 chr1         1    10    10 +      gene1   transcript1 0.442
## 2 chr1         5    10     6 +      gene1   transcript2 0.0831
## 3 chr1         5     6     2 +      gene1   transcript3 0.615
```

A simple feature which may be useful for printing gene names using `rmarkdown`
is contained in `collapseGenes()`.
Here a character vector of gene names is collapsed into a `glue` object of
length `, with gene names rendered in italics by default.

```
gn <- c("Gene1", "Gene2", "Gene3")
collapseGenes(gn)
```

*Gene1*, *Gene2* and *Gene3*

# 4 Formation of Consensus Peaks

The formation of consensus peaks incorporating ranges from multiple replicates
is a key part of many ChIP-Seq analyses.
A common format returned by tools such as `mcas2 callpeak` is the `narrowPeak`
(or `broadPeak`) format.
Sets of these across multiple replicates can imported using the function
`importPeaks()`, which returns a `GRangesList()`

```
fl <- system.file(
    c("extdata/ER_1.narrowPeak", "extdata/ER_2.narrowPeak"),
    package = "extraChIPs"
)
peaks <- importPeaks(fl)
names(peaks) <- c("ER_1", "ER_2")
```

In the above we have loaded the peaks from two replicates from the Estrogen
Receptor (ER) in T-47D cells.
To form consensus peaks we can place a restriction on the number of replicates
an overlapping peak needs to appear in.
By default, the function `makeConsensus()` sets the proportion to be zero
`(p = 0)` so all peaks are retained.
Note that a logical vector/column is returned for each replicate, along with
the number of replicates the consensus peak is derived from.

```
makeConsensus(peaks)
```

```
## GRanges object with 14 ranges and 3 metadata columns:
##        seqnames          ranges strand |      ER_1      ER_2         n
##           <Rle>       <IRanges>  <Rle> | <logical> <logical> <numeric>
##    [1]     chr1   856458-856640      * |      TRUE     FALSE         1
##    [2]     chr1   868541-868839      * |     FALSE      TRUE         1
##    [3]     chr1 1008550-1010075      * |      TRUE      TRUE         2
##    [4]     chr1 1014770-1016015      * |      TRUE      TRUE         2
##    [5]     chr1 1051307-1051918      * |      TRUE      TRUE         2
##    ...      ...             ...    ... .       ...       ...       ...
##   [10]     chr1 1608098-1608346      * |      TRUE      TRUE         2
##   [11]     chr1 1690460-1690641      * |     FALSE      TRUE         1
##   [12]     chr1 1790733-1790975      * |      TRUE     FALSE         1
##   [13]     chr1 1878927-1879257      * |      TRUE      TRUE         2
##   [14]     chr1 1900588-1900902      * |      TRUE     FALSE         1
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

However, we may wish for peaks to appear in all replicates, so we can set the
argument `p = 1` (or any other value \(0 \leq p \leq 1\)).

```
makeConsensus(peaks, p = 1)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames          ranges strand |      ER_1      ER_2         n
##          <Rle>       <IRanges>  <Rle> | <logical> <logical> <numeric>
##   [1]     chr1 1008550-1010075      * |      TRUE      TRUE         2
##   [2]     chr1 1014770-1016015      * |      TRUE      TRUE         2
##   [3]     chr1 1051307-1051918      * |      TRUE      TRUE         2
##   [4]     chr1 1368372-1369009      * |      TRUE      TRUE         2
##   [5]     chr1 1608098-1608346      * |      TRUE      TRUE         2
##   [6]     chr1 1878927-1879257      * |      TRUE      TRUE         2
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

In addition, we may wish to keep the values from the `mcols` as part of our
consensus peaks, such as the `qValue`.
This can be specified using the `var` argument, and will return a
`CompressedList` as returned by `reduceMC()`, seen below.

```
makeConsensus(peaks, p = 1, var = "qValue")
```

```
## GRanges object with 6 ranges and 4 metadata columns:
##       seqnames          ranges strand |          qValue      ER_1      ER_2
##          <Rle>       <IRanges>  <Rle> |   <NumericList> <logical> <logical>
##   [1]     chr1 1008550-1010075      * | 635.748,605.040      TRUE      TRUE
##   [2]     chr1 1014770-1016015      * | 95.1223,78.3953      TRUE      TRUE
##   [3]     chr1 1051307-1051918      * | 65.5538,95.9677      TRUE      TRUE
##   [4]     chr1 1368372-1369009      * | 22.5483,29.1231      TRUE      TRUE
##   [5]     chr1 1608098-1608346      * | 72.3235,64.8439      TRUE      TRUE
##   [6]     chr1 1878927-1879257      * | 33.8900,14.4909      TRUE      TRUE
##               n
##       <numeric>
##   [1]         2
##   [2]         2
##   [3]         2
##   [4]         2
##   [5]         2
##   [6]         2
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We could even identify the peak centre and pass these to the set of consensus
peaks for downstream peak re-centreing.

```
library(plyranges)
peaks %>%
    endoapply(mutate, centre = start + peak) %>%
    makeConsensus(p = 1, var = "centre")
```

```
## GRanges object with 6 ranges and 4 metadata columns:
##       seqnames          ranges strand |          centre      ER_1      ER_2
##          <Rle>       <IRanges>  <Rle> |   <NumericList> <logical> <logical>
##   [1]     chr1 1008550-1010075      * | 1009212,1009212      TRUE      TRUE
##   [2]     chr1 1014770-1016015      * | 1014981,1014949      TRUE      TRUE
##   [3]     chr1 1051307-1051918      * | 1051565,1051634      TRUE      TRUE
##   [4]     chr1 1368372-1369009      * | 1368613,1368767      TRUE      TRUE
##   [5]     chr1 1608098-1608346      * | 1608247,1608247      TRUE      TRUE
##   [6]     chr1 1878927-1879257      * | 1879087,1879094      TRUE      TRUE
##               n
##       <numeric>
##   [1]         2
##   [2]         2
##   [3]         2
##   [4]         2
##   [5]         2
##   [6]         2
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

We could then find the mean of the peak centres for an averaged centre.

```
peaks %>%
    endoapply(mutate, centre = start + peak) %>%
    makeConsensus(p = 1, var = "centre") %>%
    mutate(centre = vapply(centre, mean, numeric(1)))
```

```
## GRanges object with 6 ranges and 4 metadata columns:
##       seqnames          ranges strand |    centre      ER_1      ER_2         n
##          <Rle>       <IRanges>  <Rle> | <numeric> <logical> <logical> <numeric>
##   [1]     chr1 1008550-1010075      * |   1009212      TRUE      TRUE         2
##   [2]     chr1 1014770-1016015      * |   1014965      TRUE      TRUE         2
##   [3]     chr1 1051307-1051918      * |   1051600      TRUE      TRUE         2
##   [4]     chr1 1368372-1369009      * |   1368690      TRUE      TRUE         2
##   [5]     chr1 1608098-1608346      * |   1608247      TRUE      TRUE         2
##   [6]     chr1 1878927-1879257      * |   1879090      TRUE      TRUE         2
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# 5 Simple Operations Retaining `mcols()`

The standard set operations implemented in the package `GenomicRanges` will
always drop the `mcols` element by default.
The `extraChIPs` functions `reduceMC()`, `setdiffMC()`, `intersectMC()` and
`unionMC()` all produce the same output as their similarly-named functions,
however, the `mcols()` elements in the query object are also returned.
Where required, columns are coerced into `CompressedList` columns.
This can particularly useful when needed to propagate the information contained
in the initial ranges through to subsequent analytic steps

## 5.1 Simplifying single `GRanges` objects

The classical approach to defining TSS regions for a set of transcripts would be
to use the function `resize`()`, setting the width as 1.

```
tss <- resize(gr, width = 1)
tss
```

```
## GRanges object with 3 ranges and 3 metadata columns:
##       seqnames    ranges strand |     gene_id       tx_id     score
##          <Rle> <IRanges>  <Rle> | <character> <character> <numeric>
##   [1]     chr1         1      + |       gene1 transcript1 0.4423369
##   [2]     chr1         5      + |       gene1 transcript2 0.0831099
##   [3]     chr1         5      + |       gene1 transcript3 0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

As we can see, two transcripts start at position 5, so we may choose to reduce
this, which would lose the `mcols` element.
The alternative `reduceMC()` will retain all `mcols`.

```
GenomicRanges::reduce(tss)
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1         1      +
##   [2]     chr1         5      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
reduceMC(tss)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames    ranges strand |     gene_id                   tx_id
##          <Rle> <IRanges>  <Rle> | <character>         <CharacterList>
##   [1]     chr1         1      + |       gene1             transcript1
##   [2]     chr1         5      + |       gene1 transcript2,transcript3
##                     score
##             <NumericList>
##   [1]            0.442337
##   [2] 0.0831099,0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

By default, this function will attempt to coerce `mcols` to a new `mcol` of the
appropriate type, however, when multiple values are inevitable such as for the
`tx_id` column above, these will be coerced to a `CompressedList`.
The simplification of the multiple values seen in the `gene_id` can also be
turned off if desired should repeated values be important for downstream
analysis.

```
reduceMC(tss, simplify = FALSE)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames    ranges strand |         gene_id                   tx_id
##          <Rle> <IRanges>  <Rle> | <CharacterList>         <CharacterList>
##   [1]     chr1         1      + |           gene1             transcript1
##   [2]     chr1         5      + |     gene1,gene1 transcript2,transcript3
##                     score
##             <NumericList>
##   [1]            0.442337
##   [2] 0.0831099,0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

This allows for simple integration with `tidyverse` nesting strategies.

```
reduceMC(tss, simplify = FALSE) %>%
  as_tibble() %>%
  unnest(everything())
```

```
## # A tibble: 3 × 4
##   range    gene_id tx_id        score
##   <chr>    <chr>   <chr>        <dbl>
## 1 chr1:1:+ gene1   transcript1 0.442
## 2 chr1:5:+ gene1   transcript2 0.0831
## 3 chr1:5:+ gene1   transcript3 0.615
```

Whilst `reduceMC` relies on the range-reduction as implemented in
`GenomicRanges::reduce()`, some alternative approaches are included, such as
`chopMC()`, which finds identical ranges and nests the mcols element as
`CompressedList` objects.

```
chopMC(tss)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames    ranges strand |     gene_id                   tx_id
##          <Rle> <IRanges>  <Rle> | <character>         <CharacterList>
##   [1]     chr1         1      + |       gene1             transcript1
##   [2]     chr1         5      + |       gene1 transcript2,transcript3
##                     score
##             <NumericList>
##   [1]            0.442337
##   [2] 0.0831099,0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

In the case of the object `tss`, this output is identical to `reduceMC()`,
however, given that there are no identical ranges in `gr` the two functions
would behave very differently on that object.

A final operation for simplifying `GRanges` objects would be `distinctMC()`
which is a wrapper to `dplyr]::distinct` incorporating both the range and
`mcols`.
The columns to search can be called using `<data-masking>` approaches as detailed
in the manual.

```
distinctMC(tss)
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1         1      +
##   [2]     chr1         5      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
distinctMC(tss, gene_id)
```

```
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames    ranges strand |     gene_id
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chr1         1      + |       gene1
##   [2]     chr1         5      + |       gene1
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.2 Set Operations with Two `GRanges` Objects

Whilst `reduce/reduceMC` is applied to a single `GRanges` object, the set
operation functions `intersect`, `setdiff` and `union` are valuable approaches
for comparing ranges.
Using the `*MC()` functions will retain `mcols` elements from the *query range*.

```
peaks <- GRanges(c("chr1:1-5", "chr1:9-12:*"))
peaks$peak_id <- c("peak1", "peak2")
GenomicRanges::intersect(gr, peaks, ignore.strand = TRUE)
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1       1-5      *
##   [2]     chr1      9-10      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
intersectMC(gr, peaks, ignore.strand = TRUE)
```

```
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames    ranges strand |     gene_id
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chr1       1-5      * |       gene1
##   [2]     chr1      9-10      * |       gene1
##                                     tx_id                         score
##                           <CharacterList>                 <NumericList>
##   [1] transcript1,transcript2,transcript3 0.4423369,0.0831099,0.6146112
##   [2]             transcript1,transcript2           0.4423369,0.0831099
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
setdiffMC(gr, peaks, ignore.strand = TRUE)
```

```
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |     gene_id
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chr1       6-8      * |       gene1
##                                     tx_id                         score
##                           <CharacterList>                 <NumericList>
##   [1] transcript1,transcript2,transcript3 0.4423369,0.0831099,0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
unionMC(gr, peaks, ignore.strand = TRUE)
```

```
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |     gene_id
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chr1      1-12      * |       gene1
##                                     tx_id                         score
##                           <CharacterList>                 <NumericList>
##   [1] transcript1,transcript2,transcript3 0.4423369,0.0831099,0.6146112
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

There is a performance overhead to preparation of mcols as `CompressedList`
objects and all `mcols` in the query object will be returned.
If only wishing to retain a subset of `mcols`, these should be selected prior
to passing to these functions.

```
gr %>%
  select(tx_id) %>%
  intersectMC(peaks, ignore.strand = TRUE)
```

```
## GRanges object with 2 ranges and 1 metadata column:
##       seqnames    ranges strand |                               tx_id
##          <Rle> <IRanges>  <Rle> |                     <CharacterList>
##   [1]     chr1       1-5      * | transcript1,transcript2,transcript3
##   [2]     chr1      9-10      * |             transcript1,transcript2
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.3 Overlapping proportions

Whilst the functions `findOverlaps()` and `overlapsAny()` are extremely
useful, the addition of `propOverlap()` returns a numeric vector with
the proportion of each query range (`x`) which overlaps any range in the
subject range (`y`)

```
propOverlap(gr, peaks)
```

```
## [1] 0.7 0.5 0.5
```

This is also extended to enable comparison across multiple features and to
classify each peak by which features that it overlaps the most strongly.

```
bestOverlap(gr, peaks, var = "peak_id")
```

```
## [1] "peak1" "peak2" "peak1"
```

# 6 More Complex Operations

## 6.1 Range Partitioning

In addition to standard set operations, one set of ranges can be used to
partition another set of ranges, returning `mcols` from both ranges.
Ranges from the query range (`x`) are returned after being partitioned by the
ranges in the subject range (`y`).
Subject ranges used for partitioning *must be non-overlapping*, and if
overlapping ranges are provided, these will be reduced prior to partitioning.

This enables the identification of specific ranges from the query range (`x`)
which overlap ranges from the subject range (`y`)
Under this approach, `mcols` from both `query` and `subject` ranges will be
returned to enable the clear ranges which are common and distinct within the
two sets of ranges.

```
partitionRanges(gr, peaks)
```

```
## GRanges object with 5 ranges and 4 metadata columns:
##       seqnames    ranges strand |     peak_id     gene_id
##          <Rle> <IRanges>  <Rle> | <character> <character>
##   [1]     chr1       1-5      + |       peak1       gene1
##   [2]     chr1         5      + |       peak1       gene1
##   [3]     chr1         6      + |        <NA>       gene1
##   [4]     chr1       6-8      + |        <NA>       gene1
##   [5]     chr1      9-10      + |       peak2       gene1
##                         tx_id               score
##               <CharacterList>       <NumericList>
##   [1]             transcript1            0.442337
##   [2] transcript2,transcript3 0.0831099,0.6146112
##   [3]             transcript3            0.614611
##   [4] transcript1,transcript2 0.4423369,0.0831099
##   [5] transcript1,transcript2 0.4423369,0.0831099
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Whilst this shares some similarity with `intersectMC()` the additional
capabilities provide greater flexibility.

```
partitionRanges(gr, peaks) %>%
  subset(is.na(peak_id))
```

```
## GRanges object with 2 ranges and 4 metadata columns:
##       seqnames    ranges strand |     peak_id     gene_id
##          <Rle> <IRanges>  <Rle> | <character> <character>
##   [1]     chr1         6      + |        <NA>       gene1
##   [2]     chr1       6-8      + |        <NA>       gene1
##                         tx_id               score
##               <CharacterList>       <NumericList>
##   [1]             transcript3            0.614611
##   [2] transcript1,transcript2 0.4423369,0.0831099
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 6.2 Stitching Ranges

Using the function `stitchRanges()` we are able to join together sets of nearby
ranges, but with the option of placing clear barriers between ranges, across
which ranges cannot be joined.
This may be useful if joining enhancers to form putative super-enhancers, but
explicitly omitting defined promoter regions.

```
enh <- GRanges(c("chr1:1-10", "chr1:101-110", "chr1:181-200"))
prom <- GRanges("chr1:150:+")
se <- stitchRanges(enh, exclude = prom, maxgap = 100)
se
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chr1     1-110      *
##   [2]     chr1   181-200      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

As a visualisation (below) ranges within 100bp were stitched together, however
the region defined as a ‘promoter’ acted as a barrier and ranges were not
stitched together across this barrier.

![](data:image/png;base64...)

# 7 Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] magrittr_2.0.4              quantro_1.44.0
##  [3] here_1.0.2                  ggrepel_0.9.6
##  [5] glue_1.8.0                  scales_1.4.0
##  [7] plyranges_1.30.1            extraChIPs_1.14.2
##  [9] ggside_0.4.1                patchwork_1.3.2
## [11] edgeR_4.8.0                 limma_3.66.0
## [13] rtracklayer_1.70.0          BiocParallel_1.44.0
## [15] csaw_1.44.0                 SummarizedExperiment_1.40.0
## [17] Biobase_2.70.0              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           Rsamtools_2.26.0
## [21] Biostrings_2.78.0           XVector_0.50.0
## [23] GenomicRanges_1.62.0        IRanges_2.44.0
## [25] S4Vectors_0.48.0            Seqinfo_1.0.0
## [27] BiocGenerics_0.56.0         generics_0.1.4
## [29] lubridate_1.9.4             forcats_1.0.1
## [31] stringr_1.6.0               dplyr_1.1.4
## [33] purrr_1.2.0                 readr_2.1.6
## [35] tidyr_1.3.1                 tibble_3.3.0
## [37] ggplot2_4.0.1               tidyverse_2.0.0
## [39] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.2             BiocIO_1.20.0
##   [3] bitops_1.0-9              preprocessCore_1.72.0
##   [5] XML_3.99-0.20             lifecycle_1.0.4
##   [7] doParallel_1.0.17         rprojroot_2.1.1
##   [9] lattice_0.22-7            MASS_7.3-65
##  [11] base64_2.0.2              scrime_1.3.5
##  [13] minfi_1.56.0              sass_0.4.10
##  [15] rmarkdown_2.30            jquerylib_0.1.4
##  [17] yaml_2.3.10               metapod_1.18.0
##  [19] doRNG_1.8.6.2             askpass_1.2.1
##  [21] DBI_1.2.3                 RColorBrewer_1.1-3
##  [23] abind_1.4-8               quadprog_1.5-8
##  [25] RCurl_1.98-1.17           rentrez_1.2.4
##  [27] genefilter_1.92.0         SimpleUpset_0.1.3
##  [29] annotate_1.88.0           DelayedMatrixStats_1.32.0
##  [31] codetools_0.2-20          DelayedArray_0.36.0
##  [33] xml2_1.5.0                tidyselect_1.2.1
##  [35] futile.logger_1.4.3       UCSC.utils_1.6.0
##  [37] farver_2.1.2              beanplot_1.3.1
##  [39] illuminaio_0.52.0         GenomicAlignments_1.46.0
##  [41] jsonlite_2.0.0            multtest_2.66.0
##  [43] survival_3.8-3            iterators_1.0.14
##  [45] foreach_1.5.2             tools_4.5.2
##  [47] Rcpp_1.1.0                SparseArray_1.10.3
##  [49] mgcv_1.9-4                xfun_0.54
##  [51] GenomeInfoDb_1.46.0       HDF5Array_1.38.0
##  [53] withr_3.0.2               formatR_1.14
##  [55] BiocManager_1.30.27       fastmap_1.2.0
##  [57] rhdf5filters_1.22.0       openssl_2.3.4
##  [59] digest_0.6.39             timechange_0.3.0
##  [61] R6_2.6.1                  dichromat_2.0-0.1
##  [63] RSQLite_2.4.4             cigarillo_1.0.0
##  [65] h5mread_1.2.1             utf8_1.2.6
##  [67] data.table_1.17.8         InteractionSet_1.38.0
##  [69] httr_1.4.7                S4Arrays_1.10.0
##  [71] pkgconfig_2.0.3           gtable_0.3.6
##  [73] blob_1.2.4                S7_0.2.1
##  [75] siggenes_1.84.0           htmltools_0.5.8.1
##  [77] bookdown_0.45             png_0.1-8
##  [79] knitr_1.50                lambda.r_1.2.4
##  [81] tzdb_0.5.0                rjson_0.2.23
##  [83] nlme_3.1-168              curl_7.0.0
##  [85] bumphunter_1.52.0         cachem_1.1.0
##  [87] rhdf5_2.54.0              parallel_4.5.2
##  [89] AnnotationDbi_1.72.0      restfulr_0.0.16
##  [91] GEOquery_2.78.0           pillar_1.11.1
##  [93] grid_4.5.2                reshape_0.8.10
##  [95] vctrs_0.6.5               xtable_1.8-4
##  [97] evaluate_1.0.5            VennDiagram_1.7.3
##  [99] GenomicFeatures_1.62.0    cli_3.6.5
## [101] locfit_1.5-9.12           compiler_4.5.2
## [103] futile.options_1.0.1      rlang_1.1.6
## [105] crayon_1.5.3              rngtools_1.5.2
## [107] labeling_0.4.3            nor1mix_1.3-3
## [109] mclust_6.1.2              plyr_1.8.9
## [111] stringi_1.8.7             Matrix_1.7-4
## [113] hms_1.1.4                 sparseMatrixStats_1.22.0
## [115] bit64_4.6.0-1             Rhdf5lib_1.32.0
## [117] KEGGREST_1.50.0           statmod_1.5.1
## [119] memoise_2.0.1             bslib_0.9.0
## [121] bit_4.6.0
```