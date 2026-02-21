# Classes for genomic interaction data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 16 April 2021

#### Package

InteractionSet 1.38.0

# 1 Introduction

Recently developed techniques such as Hi-C and ChIA-PET have driven the study of genomic interactions, i.e., physical interactions between pairs of genomic regions.
The *[InteractionSet](https://github.com/LTLA/InteractionSet)* package provides classes to represent these interactions, and to store the associated experimental data.
The aim is to provide package developers with stable class definitions that can be manipulated through a large set of methods.
It also provides users with a consistent interface across different packages that use the same classes, making it easier to perform analyses with multiple packages.

Three classes are available from this package:

* the `GInteractions` class, which represents pairwise interactions between genomic regions.
* the `InteractionSet` class, which contains experimental data relevant to each interaction.
* the `ContactMatrix` class, which stores data in a matrix where each row and column represents a genomic region.

This vignette will give a brief description of each class and its associated methods.

# 2 Description of the `GInteractions` class

## 2.1 Construction

The `GInteractions` class stores any number of pairwise interactions between two genomic regions.
The regions themselves are represented by a `GRanges` object from the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* package.
For example, say we have an `all.regions` object containing consecutive intervals (while any regions can be used here, consecutive intervals are just simpler to explain):

```
library(InteractionSet)
all.regions <- GRanges("chrA", IRanges(0:9*10+1, 1:10*10))
```

Now, let’s say we’ve got a bunch of interactions between elements of `all.regions`.
We’ll consider three pairwise interactions – one between region #1 and #3, another between #5 and #2, and the last between #10 and #6.
These three interactions can be represented with:

```
index.1 <- c(1,5,10)
index.2 <- c(3,2,6)
region.1 <- all.regions[index.1]
region.2 <- all.regions[index.2]
```

Construction of a `GInteractions` object can be performed by supplying the interacting regions:

```
gi <- GInteractions(region.1, region.2)
```

This generates a `GInteractions` object of length 3, where each entry corresponds to a pairwise interaction.
Alternatively, the indices can be supplied directly, along with the coordinates of the regions they refer to:

```
gi <- GInteractions(index.1, index.2, all.regions)
gi
```

```
## GInteractions object with 3 interactions and 0 metadata columns:
##       seqnames1   ranges1     seqnames2   ranges2
##           <Rle> <IRanges>         <Rle> <IRanges>
##   [1]      chrA      1-10 ---      chrA     21-30
##   [2]      chrA     41-50 ---      chrA     11-20
##   [3]      chrA    91-100 ---      chrA     51-60
##   -------
##   regions: 10 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Note that the `GRanges` are not stored separately for each interaction.
Rather, a common `GRanges` object is used within the `GInteractions` object.
Each interaction simply stores the indices to point at the two relevant intervals in the common set, representing the interacting regions for that interaction.
This is because, in many cases, the same intervals are re-used for different interactions, e.g., common bins in Hi-C data, common peaks in ChIA-PET data.
Storing indices rather than repeated `GRanges` entries saves memory in the final representation.

## 2.2 Getters

The interacting regions are referred to as anchor regions, because they “anchor” the ends of the interaction
(think of them like the cups in a string telephone).
These anchor regions can be accessed, funnily enough, with the `anchors` method:

```
anchors(gi)
```

```
## $first
## GRanges object with 3 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA      1-10      *
##   [2]     chrA     41-50      *
##   [3]     chrA    91-100      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $second
## GRanges object with 3 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA     21-30      *
##   [2]     chrA     11-20      *
##   [3]     chrA     51-60      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

This returns a `GRangesList` of length 2, where the *i*^th interaction is that between the *i*^th region of `first` and that of `second`.
We can also obtain `GRanges` for the first or second anchor regions by themselves, by specifying `type="first"` or `"second"`, respectively.
Alternatively, we can get the indices for each interaction directly by setting `id=TRUE`:

```
anchors(gi, id=TRUE)
```

```
## $first
## [1]  1  5 10
##
## $second
## [1] 3 2 6
```

The set of common regions to which those indices point can be obtained with the `regions` method:

```
regions(gi)
```

```
## GRanges object with 10 ranges and 0 metadata columns:
##        seqnames    ranges strand
##           <Rle> <IRanges>  <Rle>
##    [1]     chrA      1-10      *
##    [2]     chrA     11-20      *
##    [3]     chrA     21-30      *
##    [4]     chrA     31-40      *
##    [5]     chrA     41-50      *
##    [6]     chrA     51-60      *
##    [7]     chrA     61-70      *
##    [8]     chrA     71-80      *
##    [9]     chrA     81-90      *
##   [10]     chrA    91-100      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

From a developer’s perspective, this is useful as it is often more efficient to manipulate the indices and regions separately.
For example, common operations can be applied to the output of `regions(gi)`, and the relevant results retrieved with the anchor indices.
This is usually faster than applying those operations on repeated instances of the regions in `anchors(gi)`.
Also note that `regions(gi)` is sorted – this is automatically performed within the `GInteractions` class, and is enforced throughout for consistency.
(Anchor indices are similarly adjusted to account for this sorting, so the indices supplied to the constructor may not be the same as that returned by `anchors`.)

Finally, it’s worth pointing out that the `GInteractions` object inherits from the `Vector` base class in the *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* package,
and subsequently has access to all of its methods.
For example, general metadata can be accessed using the `metadata` method, while interaction-specific metadata can be accessed with the `mcols` method.
For convenience, specific fields in `mcols` can also be accessed directly with the `$` operator.

## 2.3 Setters

Modification of the anchors in an existing `GInteractions` object can be performed by supplying new anchor indices.
For example, the code below re-specifies the three pairwise interactions as that between regions #1 and #5; between #2 and #6; and between #3 and #7.

```
temp.gi <- gi
anchorIds(temp.gi) <- list(1:3, 5:7)
```

This replacement method probably won’t get much use, as it would generally be less confusing to construct a new `GInteractions` object.
Nonetheless, it is provided just in case it’s needed (and to avoid people hacking away at the slots).

Modification of the common regions is probably more useful to most people.
The most typical application would be to annotate regions with some metadata, e.g., GC content, surrounding genes, whether or not it is a promoter or enhancer:

```
temp.gi <- gi
annotation <- rep(c("E", "P", "N"), length.out=length(all.regions))
regions(temp.gi)$anno <- annotation
```

This will show up when the anchor regions are retrieved:

```
anchors(temp.gi)
```

```
## $first
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames    ranges strand |        anno
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chrA      1-10      * |           E
##   [2]     chrA     41-50      * |           P
##   [3]     chrA    91-100      * |           E
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $second
## GRanges object with 3 ranges and 1 metadata column:
##       seqnames    ranges strand |        anno
##          <Rle> <IRanges>  <Rle> | <character>
##   [1]     chrA     21-30      * |           N
##   [2]     chrA     11-20      * |           P
##   [3]     chrA     51-60      * |           N
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The existing common regions can be replaced with a superset by using the `replaceRegions` method.
This may be useful, e.g., in cases where we want to make the anchor indices point to the correct entries in a larger set of regions.

```
temp.gi <- gi
super.regions <- GRanges("chrA", IRanges(0:19*10+1, 1:20*10))
replaceRegions(temp.gi) <- super.regions
```

Alternatively, any additional regions can be added directly to the common set with the `appendRegions` method.
This is a bit more efficient than calling `replaceRegions` on the concatenation of the extra regions with the existing common set.

```
temp.gi <- gi
extra.regions <- GRanges("chrA", IRanges(10:19*10+1, 11:20*10))
appendRegions(temp.gi) <- extra.regions
```

Finally, the derivation from `Vector` means that we can set some metadata fields as well.
For example, general metadata can be dumped into the `GInteractions` object using the `metadata` method:

```
metadata(gi)$description <- "I am a GInteractions object"
metadata(gi)
```

```
## $description
## [1] "I am a GInteractions object"
```

Interaction-specific metadata can also be stored via the `mcols` replacement method or through the `$` wrapper.
One application might be to store interesting metrics relevant to each interaction, such as normalized contact frequencies:

```
set.seed(1000)
norm.freq <- rnorm(length(gi)) # obviously, these are not real frequencies.
gi$norm.freq <- norm.freq
mcols(gi)
```

```
## DataFrame with 3 rows and 1 column
##    norm.freq
##    <numeric>
## 1 -0.4457783
## 2 -1.2058566
## 3  0.0411263
```

## 2.4 Subsetting and combining

Subsetting of a `GInteractions` object will return a new object containing only the specified interactions:

```
sub.gi <- gi[1:2]
sub.gi
```

```
## GInteractions object with 2 interactions and 1 metadata column:
##       seqnames1   ranges1     seqnames2   ranges2 | norm.freq
##           <Rle> <IRanges>         <Rle> <IRanges> | <numeric>
##   [1]      chrA      1-10 ---      chrA     21-30 | -0.445778
##   [2]      chrA     41-50 ---      chrA     11-20 | -1.205857
##   -------
##   regions: 10 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
anchors(sub.gi, id=TRUE)
```

```
## $first
## [1] 1 5
##
## $second
## [1] 3 2
```

Note that the common regions are *not* modified by subsetting of the `GInteractions` object.
Subsetting only affects the interactions, i.e., the anchor indices, not the regions to which those indices point.

```
identical(regions(gi), regions(sub.gi))
```

```
## [1] TRUE
```

Objects can also be concatenated using `c`.
This forms a new `GInteractions` object that contains all of the interactions in the constituent objects.
Both methods will also work on objects with different sets of common regions, with the final common set of regions being formed from a union of the constituent sets.

```
c(gi, sub.gi)
```

```
## GInteractions object with 5 interactions and 1 metadata column:
##       seqnames1   ranges1     seqnames2   ranges2 |  norm.freq
##           <Rle> <IRanges>         <Rle> <IRanges> |  <numeric>
##   [1]      chrA      1-10 ---      chrA     21-30 | -0.4457783
##   [2]      chrA     41-50 ---      chrA     11-20 | -1.2058566
##   [3]      chrA    91-100 ---      chrA     51-60 |  0.0411263
##   [4]      chrA      1-10 ---      chrA     21-30 | -0.4457783
##   [5]      chrA     41-50 ---      chrA     11-20 | -1.2058566
##   -------
##   regions: 10 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
new.gi <- gi
regions(new.gi) <- resize(regions(new.gi), width=20)
c(gi, new.gi)
```

```
## GInteractions object with 6 interactions and 1 metadata column:
##       seqnames1   ranges1     seqnames2   ranges2 |  norm.freq
##           <Rle> <IRanges>         <Rle> <IRanges> |  <numeric>
##   [1]      chrA      1-10 ---      chrA     21-30 | -0.4457783
##   [2]      chrA     41-50 ---      chrA     11-20 | -1.2058566
##   [3]      chrA    91-100 ---      chrA     51-60 |  0.0411263
##   [4]      chrA      1-20 ---      chrA     21-40 | -0.4457783
##   [5]      chrA     41-60 ---      chrA     11-30 | -1.2058566
##   [6]      chrA    91-110 ---      chrA     51-70 |  0.0411263
##   -------
##   regions: 20 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 2.5 Sorting, duplication and matching

Before we start, we make a slightly more complicated object so we get more interesting results.

```
new.gi <- gi
anchorIds(new.gi) <- list(1:3, 5:7)
combined <- c(gi, new.gi)
```

The `swapAnchors` method is applied here to ensure that the first anchor index is always less than the second anchor index for each interaction.
This eliminates redundant permutations of anchor regions and ensures that an interaction between regions #1 and #2 is treated the same as an interaction between regions #2 and #1.
Obviously, this assumes that redundant permutations are uninteresting – also see `StrictGInteractions` below, which is a bit more convenient.

```
combined <- swapAnchors(combined)
```

Ordering of `GInteractions` objects is performed using the anchor indices.
Specifically, interactions are ordered such that the first anchor index is increasing.
Any interactions with the same first anchor index are ordered by the second index.

```
order(combined)
```

```
## [1] 1 4 2 5 6 3
```

```
sorted <- sort(combined)
anchors(sorted, id=TRUE)
```

```
## $first
## [1] 1 1 2 2 3 6
##
## $second
## [1]  3  5  5  6  7 10
```

Recall that the common regions are already sorted within each `GInteractions` object.
This means that sorting by the anchor indices is equivalent to sorting on the anchor regions themselves.
In the example below, the anchor regions are sorted properly within the sorted object.

```
anchors(sorted, type="first")
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA      1-10      *
##   [2]     chrA      1-10      *
##   [3]     chrA     11-20      *
##   [4]     chrA     11-20      *
##   [5]     chrA     21-30      *
##   [6]     chrA     51-60      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Duplicated interactions are identified as those that have identical pairs of anchor indices.
In the example below, all of the repeated entries in `doubled` are marked as duplicates.
The `unique` method returns a `GInteractions` object where all duplicated entries are removed.

```
doubled <- c(combined, combined)
duplicated(doubled)
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
```

Identical interactions can also be matched between `GInteractions` objects.
We coerce the permutations to a consistent format with `swapAnchors` for comparing between objects.
The `match` method then looks for entries in the second object with the same anchor indices as each entry in the first object.
Obviously, the common regions must be the same for this to be sensible.

```
anchorIds(new.gi) <- list(4:6, 1:3)
new.gi <- swapAnchors(new.gi)
swap.gi <- swapAnchors(gi)
match(new.gi, swap.gi)
```

```
## [1] NA  2 NA
```

Finally, `GInteractions` objects can be compared in a parallel manner.
This determines whether the *i*^th interaction in one object is equal to the *i*^th interaction in the other object.
Again, the common regions should be the same for both objects.

```
new.gi==swap.gi
```

```
## [1] FALSE  TRUE FALSE
```

## 2.6 Distance calculations

We are often interested in the distances between interacting regions on the linear genome, to determine if an interaction is local or distal.
These distances can be easily obtained with the `pairdist` method.
To illustrate, let’s construct some interactions involving multiple chromosomes:

```
all.regions <- GRanges(rep(c("chrA", "chrB"), c(10, 5)),
    IRanges(c(0:9*10+1, 0:4*5+1), c(1:10*10, 1:5*5)))
index.1 <- c(5, 15,  3, 12, 9, 10)
index.2 <- c(1,  5, 11, 13, 7,  4)
gi <- GInteractions(index.1, index.2, all.regions)
```

By default, `pairdist` returns the distances between the midpoints of the anchor regions for each interaction.
Any inter-chromosomal interactions will not have a defined distance along the linear genome, so a `NA` is returned instead.

```
pairdist(gi)
```

```
## [1] 40 NA NA  5 20 60
```

Different types of distances can be obtained by specifying the `type` argument, e.g., `"gap"`, `"span"`, `"diagonal"`.
In addition, whether an interaction is intra-chromosomal or not can be determined with the `intrachr` function:

```
intrachr(gi)
```

```
## [1]  TRUE FALSE FALSE  TRUE  TRUE  TRUE
```

## 2.7 Overlap methods

Overlaps in one dimension can be identified between anchor regions and a linear genomic interval.
Say we want to identify all interactions with at least one anchor region lying within a region of interest (e.g., a known promoter or gene).
This can be done with the `findOverlaps` method:

```
of.interest <- GRanges("chrA", IRanges(30, 60))
olap <- findOverlaps(gi, of.interest)
olap
```

```
## Hits object with 4 hits and 0 metadata columns:
##       queryHits subjectHits
##       <integer>   <integer>
##   [1]         1           1
##   [2]         2           1
##   [3]         3           1
##   [4]         6           1
##   -------
##   queryLength: 6 / subjectLength: 1
```

This returns a `Hits` object containing pairs of indices, where each pair represents an overlap between the interaction (`query`) with a genomic interval (`subject`).
Here, each reported interaction has at least one anchor region overlapping the interval specified in `of.interest`:

```
anchors(gi[queryHits(olap)])
```

```
## $first
## GRanges object with 4 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA     41-50      *
##   [2]     chrB     21-25      *
##   [3]     chrA     21-30      *
##   [4]     chrA    91-100      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
##
## $second
## GRanges object with 4 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA      1-10      *
##   [2]     chrA     41-50      *
##   [3]     chrB       1-5      *
##   [4]     chrA     31-40      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Longer `GRanges` can be specified if there are several regions of interest.
Standard arguments can be supplied to `findOverlaps` to modify its behaviour, e.g., `type`, `minoverlap`.
The `use.region` argument can be set to specify which regions in the `GInteractions` object are to be overlapped.
The `overlapsAny`, `countOverlaps` and `subsetByOverlaps` methods are also available and behave as expected.

A more complex situation involves identifying overlapping interactions in the two-dimensional interaction space.
Say we have an existing interaction betweeen two regions, represented by an `GInteractions` object named `paired.interest`.
We want to determine if any of our “new” interactions in `gi` overlap with the existing interaction, e.g., to identify corresponding interactions between data sets.
In particular, we only consider an overlap if each anchor region of the new interaction overlaps a corresponding anchor region of the existing interaction.
To illustrate:

```
paired.interest <- GInteractions(of.interest, GRanges("chrB", IRanges(10, 40)))
olap <- findOverlaps(gi, paired.interest)
olap
```

```
## Hits object with 1 hit and 0 metadata columns:
##       queryHits subjectHits
##       <integer>   <integer>
##   [1]         2           1
##   -------
##   queryLength: 6 / subjectLength: 1
```

The existing interaction in `paired.interest` occurs between one interval on chromosome A (i.e., `of.interest`) and another on chromosome B.
Of all the interactions in `gi`, only `gi[2]` is considered to be overlapping, despite the fact that several interactions have 1D overlaps with `of.interest`.
This is because only `gi[2]` has an anchor region with a concomitant overlap with the interacting partner region on chromosome B.
Again, arguments can be supplied to `findOverlaps` to tune its behaviour.
The `overlapsAny`, `countOverlaps` and `subsetByOverlaps` methods are also available for these two-dimensional overlaps.

## 2.8 Linking sets of regions

A slightly different problem involves finding interactions that link any entries across two sets of regions.
For example, we might be interested in identifying interactions between a set of genes and a set of enhancers.
Using `findOverlaps` to perform 2D overlaps would be tedious, as we would have to manually specify every possible gene-enhancer combination.
Instead, our aim can be achieved using the `linkOverlaps` function:

```
all.genes <- GRanges("chrA", IRanges(0:9*10, 1:10*10))
all.enhancers <- GRanges("chrB", IRanges(0:9*10, 1:10*10))
out <- linkOverlaps(gi, all.genes, all.enhancers)
head(out)
```

```
## DataFrame with 4 rows and 3 columns
##       query  subject1  subject2
##   <integer> <integer> <integer>
## 1         2         5         3
## 2         2         6         3
## 3         3         3         1
## 4         3         4         1
```

This returns a data frame where each row species an interaction in `query`, the region it overlaps in `subject1` (i.e., the gene),
and the overlapping region in `subject2` (i.e., the enhancer).
If there are multiple overlaps to either set, all combinations of two overlapping regions are reported.
One can also identify interactions within a single set by doing:

```
out <- linkOverlaps(gi, all.genes)
head(out)
```

```
## DataFrame with 6 rows and 3 columns
##       query  subject1  subject2
##   <integer> <integer> <integer>
## 1         1         5         1
## 2         1         5         2
## 3         1         6         1
## 4         1         6         2
## 5         5         9         7
## 6         5         9         8
```

Here, both `subject1` and `subject2` refer to linked entries in `all.genes`.

## 2.9 Finding the bounding box

Groups of interactions can be summarized by identifying the minimum bounding box.
This refers to the smallest rectangle that can contain all interactions in the interaction space.
We can then save the coordinates of the bounding box, rather than having to deal with the coordinates of the individual interactions.
To illustrate, we’ll set up a grouping vector based on chromosome pairings:

```
all.chrs <- as.character(seqnames(regions(gi)))
group.by.chr <- paste0(all.chrs[anchors(gi, type="first", id=TRUE)], "+",
                       all.chrs[anchors(gi, type="second", id=TRUE)])
```

Bounding box identification can be performed using the `boundingBox` function.
For any intra-chromosomal groups, it is generally recommended to run `swapAnchors` prior to running `boundingBox`.
This puts all interactions on the same side of the diagonal and results in smaller minimum bounding boxes
(assuming we’re not interested in the permutation of anchors in each interaction).

```
swap.gi <- swapAnchors(gi)
boundingBox(swap.gi, group.by.chr)
```

```
## GInteractions object with 4 interactions and 0 metadata columns:
##             seqnames1   ranges1     seqnames2   ranges2
##                 <Rle> <IRanges>         <Rle> <IRanges>
##   chrA+chrA      chrA      1-70 ---      chrA    41-100
##   chrA+chrB      chrA     21-30 ---      chrB       1-5
##   chrB+chrA      chrA     41-50 ---      chrB     21-25
##   chrB+chrB      chrB      6-10 ---      chrB     11-15
##   -------
##   regions: 8 ranges and 0 metadata columns
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

This function returns a `GInteractions` object where the anchor regions represent the sides of each bounding box.
The example above identifies the bounding box for all interactions on each pair of chromosomes.
Note that it is only defined when all interactions in a group lie on the same pair of chromosomes.
The function will fail if, e.g., the group contains both inter- and intra-chromosomal interactions.

## 2.10 Enforcing anchor ordering in `StrictGInteractions`

It is somewhat tedious to have to run `swapAnchors` prior to every call to `sort`, `unique`, `boundingBox`, etc.
An alternative is to use a subclass named `StrictGInteractions`, for which the first anchor index is always greater than or equal to the second anchor index.
This ensures that the interactions are all standardized prior to comparison within or between objects.
Objects of this subclass can be constructed by setting the `mode` argument in the `GInteractions` constructor:

```
sgi <- GInteractions(index.1, index.2, all.regions, mode="strict")
class(sgi)
```

```
## [1] "StrictGInteractions"
## attr(,"package")
## [1] "InteractionSet"
```

Alternatively, an existing `GInteractions` object can be easily turned into a `StrictGInteractions` object.
This requires little effort as all of the slots are identical between the two classes.
The only difference lies in the enforcement of the anchor permutation within each interaction.

```
sgi <- as(gi, "StrictGInteractions")
```

All methods that apply to `GInteractions` can also be used for a `StrictGInteractions`.
The only difference is that anchor assignments will automatically enforce the standard permutation, by shuffling values between the first and second anchor indices.

```
anchorIds(sgi) <- list(7:12, 1:6)
anchors(sgi, id=TRUE)
```

```
## $first
## [1] 1 2 3 4 5 6
##
## $second
## [1]  7  8  9 10 11 12
```

In general, this subclass is more convenient to use if the permutation of anchor indices is not considered to be informative.

# 3 Description of the `InteractionSet` class

## 3.1 Construction

The `InteractionSet` class inherits from `SummarizedExperiment` and holds the experimental data associated with each interaction (along with the interactions themselves).
Each row of an `InteractionSet` object corresponds to one pairwise interaction, while each column corresponds to a sample, e.g., a Hi-C or ChIA-PET library.
A typical use would be to store the count matrix for each interaction in each sample:

```
set.seed(1000)
Nlibs <- 4
counts <- matrix(rpois(Nlibs*length(gi), lambda=10), ncol=Nlibs)
lib.data <- DataFrame(lib.size=seq_len(Nlibs)*1e6)
iset <- InteractionSet(counts, gi, colData=lib.data)
iset
```

```
## class: InteractionSet
## dim: 6 4
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

The constructor takes an existing `GInteractions` object of length equal to the number of rows in the matrix.
Multiple matrices can also be stored by supplying them as a list.
For example, if we have a matrix of normalized interaction frequencies, these could be stored along with the counts:

```
norm.freq <- matrix(rnorm(Nlibs*length(gi)), ncol=Nlibs)
iset2 <- InteractionSet(list(counts=counts, norm.freq=norm.freq), gi, colData=lib.data)
iset2
```

```
## class: InteractionSet
## dim: 6 4
## metadata(0):
## assays(2): counts norm.freq
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

Users and developers familiar with the `RangedSummarizedExperiment` class should have little trouble dealing with the `InteractionSet` class.
The latter is simply the analogue of the former, after replacing genomic intervals in the `GRanges` object with pairwise interactions in a `GInteractions` object.

## 3.2 Getters

The `InteractionSet` object supports all access methods in the `SummarizedExperiment` class, e.g., `colData`, `metadata` and so on.
In particular, the `assay` and `assays` methods can be used to extract the data matrices:

```
assay(iset)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    8    5   10   10
## [2,]    6   13    3   10
## [3,]    5    5    8   11
## [4,]    7    9   10   10
## [5,]   12    5   11   11
## [6,]   13    4   11   10
```

```
assay(iset2, 2)
```

```
##             [,1]       [,2]       [,3]       [,4]
## [1,] -0.04101814  0.5601652 -1.5290771  0.3305996
## [2,] -1.99163226 -0.2016566 -1.1162936  0.6859423
## [3,]  1.72479034 -1.0595593 -0.6015164 -0.2400144
## [4,]  1.30351018 -0.8572085 -0.1606118 -0.1214134
## [5,]  1.44145260 -0.9848534  0.9340341  0.6012967
## [6,]  0.78692136 -0.9289698 -2.2852293  1.0204081
```

The `interactions` method extracts the `GInteractions` object containing the interactions for all rows:

```
interactions(iset)
```

```
## GInteractions object with 6 interactions and 0 metadata columns:
##       seqnames1   ranges1     seqnames2   ranges2
##           <Rle> <IRanges>         <Rle> <IRanges>
##   [1]      chrA     41-50 ---      chrA      1-10
##   [2]      chrB     21-25 ---      chrA     41-50
##   [3]      chrA     21-30 ---      chrB       1-5
##   [4]      chrB      6-10 ---      chrB     11-15
##   [5]      chrA     81-90 ---      chrA     61-70
##   [6]      chrA    91-100 ---      chrA     31-40
##   -------
##   regions: 15 ranges and 0 metadata columns
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Access methods for the `GInteractions` class can also be directly applied to the `InteractionSet` object.
These methods are wrappers that will operate on the `GInteractions` object within each `InteractionSet`, which simplifies the calling sequence:

```
anchors(iset, id=TRUE) # easier than anchors(interactions(iset)), id=TRUE)
```

```
## $first
## [1]  5 15  3 12  9 10
##
## $second
## [1]  1  5 11 13  7  4
```

```
regions(iset)
```

```
## GRanges object with 15 ranges and 0 metadata columns:
##        seqnames    ranges strand
##           <Rle> <IRanges>  <Rle>
##    [1]     chrA      1-10      *
##    [2]     chrA     11-20      *
##    [3]     chrA     21-30      *
##    [4]     chrA     31-40      *
##    [5]     chrA     41-50      *
##    ...      ...       ...    ...
##   [11]     chrB       1-5      *
##   [12]     chrB      6-10      *
##   [13]     chrB     11-15      *
##   [14]     chrB     16-20      *
##   [15]     chrB     21-25      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

## 3.3 Setters

Again, replacement methods for `SummarizedExperiment` are supported in the `InteractionSet` class.
For example, the `colData` holds library-specific information – one might add library sizes to the `colData` with:

```
lib.size <- seq_len(Nlibs) * 1e6
colData(iset)$lib.size <- lib.size
iset$lib.size <- lib.size # same result.
```

The interactions themselves can be replaced using the `interactions` replacement method:

```
new.gi <- interactions(iset)
new.iset <- iset
interactions(new.iset) <- new.gi
```

Of course, the replacement methods described for the `GInteractions` class is also available for `InteractionSet` objects.
These methods will operate directly on the `GInteractions` object contained within each `InteractionSet`.
This is often more convenient than extracting the interactions, modifying them and then replacing them with `interactions<-`.

```
regions(interactions(new.iset))$score <- 1
regions(new.iset)$score <- 1 # same as above.
```

## 3.4 Subsetting and combining

Subsetting an `InteractionSet` by row will form a new object containing only the specified interactions (and the associated data for all samples),
analogous to subsetting of a `GInteractions` object.
However, subsetting the object by column will form a new object containing only the data relevant to the specified *samples*.
This new object will still contain all interactions, unless subsetting by row is simultaneously performed.

```
iset[1:3,]
```

```
## class: InteractionSet
## dim: 3 4
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

```
iset[,1:2]
```

```
## class: InteractionSet
## dim: 6 2
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

`InteractionSet` objects can be combined row-wise using `rbind`.
This forms a new `InteractionSet` object containing all interactions from each individual object, with the associated data across all samples.
For example, the example below forms a new object with an extra copy of the first interaction:

```
rbind(iset, iset[1,])
```

```
## class: InteractionSet
## dim: 7 4
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

Objects with the same interactions can also be combined column-wise with the `cbind` method.
This is typically used to combine data for the same interactions but from different samples.
The example below forms an `InteractionSet` object with an extra copy of the data from sample 3:

```
cbind(iset, iset[,3])
```

```
## class: InteractionSet
## dim: 6 5
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
## type: GInteractions
## regions: 15
```

## 3.5 Other methods

Sorting, duplicate detection, distance calculation and overlap methods for `InteractionSet` objects are equivalent to those for `GInteractions`.
Namely, the methods for the former are effectively wrappers that operate on the `GInteractions` object within each `InteractionSet`.
As a consequence, only the anchor indices will be used for sorting and duplication identification.
Experimental data will *not* be used to distinguish between rows of an `InteractionSet` that correspond to the same interaction.
Also keep in mind that you should use `swapAnchors` to standardize the interactions before comparing within or between `InteractionSet` objects
(or alternatively, construct your `InteractionSet` objects with a `StrictGInteractions` object).

# 4 Description of the `ContactMatrix` class

## 4.1 Construction

The `ContactMatrix` class inherits from the `Annotated` class, and is designed to represent the data in matrix format.
Each row and column of the matrix corresponds to a genomic region, such that each cell of the matrix represents an interaction between the corresponding row and column.
The value of that cell is typically set to the read pair count for that interaction, but any relevant metric can be used.
Construction is achieved by passing a matrix along with the ranges of the interacting regions for all rows and columns:

```
row.indices <- 1:10
col.indices <- 9:15
row.regions <- all.regions[row.indices]
col.regions <- all.regions[col.indices]
Nr <- length(row.indices)
Nc <- length(col.indices)
counts <- matrix(rpois(Nr*Nc, lambda=10), Nr, Nc)
cm <- ContactMatrix(counts, row.regions, col.regions)
```

For purposes of memory efficiency, the interacting regions for each row or column are internally stored as described for `GInteractions`,
i.e., as anchor indices pointing to a set of (sorted) common regions.
Rectangular matrices are supported, so the number and order of rows need not be the same as that of the columns in each `ContactMatrix`.
Construction can also be achieved directly from the indices and the set of common regions, as shown below:

```
cm <- ContactMatrix(counts, row.indices, col.indices, all.regions)
cm
```

```
## class: ContactMatrix
## dim: 10 7
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

The matrix itself is stored as a `Matrix` object from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.
This provides support for sparse matrix representations that can save a lot of memory, e.g., when storing read counts for sparse areas of the interaction space.

## 4.2 Getters

The data matrix can be extracted using the `as.matrix` method:

```
as.matrix(cm)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7]
##  [1,]   11    5   10    9    9    9   13
##  [2,]    8    8   14   17    8    9   11
##  [3,]   11   15   12    7   10   15    7
##  [4,]   10    6   11    9   11    8    9
##  [5,]    5    6   13   11   11   10   10
##  [6,]    7   12   10   11   10    5    8
##  [7,]    8   10    8   12    9    8   12
##  [8,]   11   14   14    8    6   13    7
##  [9,]   18    9   11   16   12   15   13
## [10,]   11    8    9    5    9    2   10
```

Anchor regions corresponding to each row and column can be extracted with `anchors`.
This is shown below for the row-wise regions.
Indices can also be extracted with `id=TRUE`, as described for the `GInteractions` class.

```
anchors(cm, type="row")
```

```
## GRanges object with 10 ranges and 0 metadata columns:
##        seqnames    ranges strand
##           <Rle> <IRanges>  <Rle>
##    [1]     chrA      1-10      *
##    [2]     chrA     11-20      *
##    [3]     chrA     21-30      *
##    [4]     chrA     31-40      *
##    [5]     chrA     41-50      *
##    [6]     chrA     51-60      *
##    [7]     chrA     61-70      *
##    [8]     chrA     71-80      *
##    [9]     chrA     81-90      *
##   [10]     chrA    91-100      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

The common set of regions can be extracted with `regions`:

```
regions(cm)
```

```
## GRanges object with 15 ranges and 0 metadata columns:
##        seqnames    ranges strand
##           <Rle> <IRanges>  <Rle>
##    [1]     chrA      1-10      *
##    [2]     chrA     11-20      *
##    [3]     chrA     21-30      *
##    [4]     chrA     31-40      *
##    [5]     chrA     41-50      *
##    ...      ...       ...    ...
##   [11]     chrB       1-5      *
##   [12]     chrB      6-10      *
##   [13]     chrB     11-15      *
##   [14]     chrB     16-20      *
##   [15]     chrB     21-25      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Inheritance from `Annotated` also means that general metadata can be accessed using the `metadata` method.

## 4.3 Setters

Parts or all of the data matrix can be modified using the `as.matrix` replacement method:

```
temp.cm <- cm
as.matrix(temp.cm[1,1]) <- 0
```

The `anchorIds` replacement method can be used to replace the row or column anchor indices:

```
anchorIds(temp.cm) <- list(1:10, 1:7)
```

The `regions`, `replaceRegions` and `appendRegions` replacement methods are also available and work as described for `GInteractions` objects.
In the example below, the common regions can be updated to include GC content:

```
regions(temp.cm)$GC <- runif(length(regions(temp.cm))) # not real values, obviously.
regions(temp.cm)
```

```
## GRanges object with 15 ranges and 1 metadata column:
##        seqnames    ranges strand |        GC
##           <Rle> <IRanges>  <Rle> | <numeric>
##    [1]     chrA      1-10      * |  0.497083
##    [2]     chrA     11-20      * |  0.569044
##    [3]     chrA     21-30      * |  0.303726
##    [4]     chrA     31-40      * |  0.135940
##    [5]     chrA     41-50      * |  0.868492
##    ...      ...       ...    ... .       ...
##   [11]     chrB       1-5      * |  0.538591
##   [12]     chrB      6-10      * |  0.660270
##   [13]     chrB     11-15      * |  0.601533
##   [14]     chrB     16-20      * |  0.798828
##   [15]     chrB     21-25      * |  0.688482
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Finally, the `metadata` replacement method can be used to set general metadata:

```
metadata(temp.cm)$description <- "I am a ContactMatrix"
metadata(temp.cm)
```

```
## $description
## [1] "I am a ContactMatrix"
```

There is no slot to store metadata for each cell of the matrix.
Any representation of interaction-specific metadata in matrix form would be equivalent to constructing a new `ContactMatrix`
– so, we might as well do that, instead of trying to cram additional data into an existing object.

## 4.4 Subsetting and combining

Subsetting returns a `ContactMatrix` containing only the specified rows or columns:

```
cm[1:5,]
```

```
## class: ContactMatrix
## dim: 5 7
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

```
cm[,1:5]
```

```
## class: ContactMatrix
## dim: 10 5
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

It should be stressed that the subset indices have no relation to the anchor indices.
For example, the second subsetting call does not select columns corresponding to anchor regions #1 to #5.
Rather, it selects the first 5 columns, which actually correspond to anchor regions #9 to #13:

```
anchors(cm[,1:5], type="column", id=TRUE)
```

```
## [1]  9 10 11 12 13
```

It is also possible to transpose a `ContactMatrix`, to obtain an object where the rows and columns are exchanged:

```
t(cm)
```

```
## class: ContactMatrix
## dim: 7 10
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

Combining can be done with `rbind` to combine by row, for objects with the same column anchor regions;
or with `cbind` to combine by column, for objects with the same row anchor regions.
This forms a new matrix with the additional rows or columns, as one might expect for matrices.

```
rbind(cm, cm[1:5,]) # extra rows
```

```
## class: ContactMatrix
## dim: 15 7
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

```
cbind(cm, cm[,1:5]) # extra columns
```

```
## class: ContactMatrix
## dim: 10 12
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

Note that only the regions need to be the same for `cbind` and `rbind`.
Both methods will still work if the indices are different but point to the same genomic coordinates.
In such cases, the returned `ContactMatrix` will contain refactored indices pointing to a union of the common regions from all constituent objects.

## 4.5 Sorting and duplication

Sorting of a `ContactMatrix` involves permuting the rows and columns so that both row and column indices are in ascending order.
This representation is easiest to interpret, as adjacent rows or columns will correspond to adjacent regions.

```
temp.cm <- cm
anchorIds(temp.cm) <- list(10:1, 15:9)
anchors(sort(temp.cm), id=TRUE)
```

```
## $row
##  [1]  1  2  3  4  5  6  7  8  9 10
##
## $column
## [1]  9 10 11 12 13 14 15
```

Note that the `order` function does not return an integer vector, as one might expect.
Instead, it returns a list of two integer vectors, where the first and second vector contains the permutation required to sort the rows and columns, respectively:

```
order(temp.cm)
```

```
## $row
##  [1] 10  9  8  7  6  5  4  3  2  1
##
## $column
## [1] 7 6 5 4 3 2 1
```

Duplicated rows or columns are defined as those with the same index as another row or column, respectively.
The `duplicated` method will return a list of two logical vectors, indicating which rows or columns are considered to be duplicates (first occurrence is treated as a non-duplicate).
The `unique` method will return a `ContactMatrix` where all duplicate rows or columns are removed.

```
temp.cm <- rbind(cm, cm)
duplicated(temp.cm)
```

```
## $row
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE
## [13]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
##
## $column
## [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```
unique(temp.cm)
```

```
## class: ContactMatrix
## dim: 10 7
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

Users should be aware that the values of the data matrix are *not* considered when identifying duplicates or during sorting.
Only the anchor indices are used for ordering and duplicate detection.
Rows or columns with the same anchor indices will not be distinguished by the corresponding matrix values.

## 4.6 Distance calculation

The `pairdist` function can be applied to a `ContactMatrix`, returning a matrix of distances of the same dimension as the supplied object.
Each cell contains the distance between the midpoints of the corresponding row/column anchor regions.

```
pairdist(cm)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7]
##  [1,]   80   90   NA   NA   NA   NA   NA
##  [2,]   70   80   NA   NA   NA   NA   NA
##  [3,]   60   70   NA   NA   NA   NA   NA
##  [4,]   50   60   NA   NA   NA   NA   NA
##  [5,]   40   50   NA   NA   NA   NA   NA
##  [6,]   30   40   NA   NA   NA   NA   NA
##  [7,]   20   30   NA   NA   NA   NA   NA
##  [8,]   10   20   NA   NA   NA   NA   NA
##  [9,]    0   10   NA   NA   NA   NA   NA
## [10,]   10    0   NA   NA   NA   NA   NA
```

Recall that distances are undefined for inter-chromosomal interactions, so the values for the corresponding cells in the matrix are simply set to `NA`.
Different distance definitions can be used by changing the `type` argument, as described for `GInteractions`.

The `intrachr` function can also be used to identify those cells corresponding to intra-chromosomal interactions:

```
intrachr(cm)
```

```
##       [,1] [,2]  [,3]  [,4]  [,5]  [,6]  [,7]
##  [1,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [2,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [3,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [4,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [5,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [6,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [7,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [8,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
##  [9,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
## [10,] TRUE TRUE FALSE FALSE FALSE FALSE FALSE
```

## 4.7 Overlap methods

The `ContactMatrix` class has access to the `overlapsAny` method when the `subject` argument is a `GRanges` object.
This method returns a list of two logical vectors indicating whether the row or column anchor regions overlap the interval(s) of interest.

```
of.interest <- GRanges("chrA", IRanges(50, 100))
olap <- overlapsAny(cm, of.interest)
olap
```

```
## $row
##  [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
##
## $column
## [1]  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE
```

Users can use this to subset the `ContactMatrix`, to select only those rows or columns that overlap the regions of interest.
Alternatively, we can set up AND or OR masks with these vectors, using the `outer` function:

```
and.mask <- outer(olap$row, olap$column, "&")
or.mask <- outer(olap$row, olap$column, "|")
```

This can be used to mask all uninteresting entries in the data matrix for examination.
For example, say we’re only interested in the entries corresponding to interactions within the `of.interest` interval:

```
my.matrix <- as.matrix(cm)
my.matrix[!and.mask] <- NA
my.matrix
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7]
##  [1,]   NA   NA   NA   NA   NA   NA   NA
##  [2,]   NA   NA   NA   NA   NA   NA   NA
##  [3,]   NA   NA   NA   NA   NA   NA   NA
##  [4,]   NA   NA   NA   NA   NA   NA   NA
##  [5,]    5    6   NA   NA   NA   NA   NA
##  [6,]    7   12   NA   NA   NA   NA   NA
##  [7,]    8   10   NA   NA   NA   NA   NA
##  [8,]   11   14   NA   NA   NA   NA   NA
##  [9,]   18    9   NA   NA   NA   NA   NA
## [10,]   11    8   NA   NA   NA   NA   NA
```

Two-dimensional overlaps can also be performed with a `ContrastMatrix` by running `overlapsAny` with `GInteractions` as the `subject`.
This returns a logical matrix indicating which cells of the query matrix have overlaps with entries in the subject object.
For example, if the first interacting region is `of.interest`, and the second interacting region is some interval at the start of chromosome B (below), we can do:

```
olap <- overlapsAny(cm, GInteractions(of.interest, GRanges("chrB", IRanges(1, 20))))
olap
```

```
##        [,1]  [,2]  [,3]  [,4]  [,5]  [,6]  [,7]
##  [1,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [2,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [3,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [4,] FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [5,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
##  [6,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
##  [7,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
##  [8,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
##  [9,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
## [10,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
```

# 5 Converting between classes

## 5.1 Inflating a `GInteractions` into a `ContactMatrix`

If we have a `GInteractions` object, we can convert this into a `ContactMatrix` with specified rows and columns.
Each pairwise interaction in the `GInteractions` corresponds to zero, one or two cells of the `ContactMatrix` (zero if it lies outside of the specified rows and columns, obviously;
two for some interactions when the `ContactMatrix` crosses the diagonal of the interaction space).
Each cell is filled with an arbitrary value associated with the corresponding interaction, e.g., counts, normalized contact frequencies.
Cells with no corresponding interactions in the `GInteractions` object are set to `NA`.

```
counts <- rpois(length(gi), lambda=10)
desired.rows <- 2:10
desired.cols <- 1:5
new.cm <- inflate(gi, desired.rows, desired.cols, fill=counts)
new.cm
```

```
## class: ContactMatrix
## dim: 9 5
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

```
anchors(new.cm, id=TRUE)
```

```
## $row
## [1]  2  3  4  5  6  7  8  9 10
##
## $column
## [1] 1 2 3 4 5
```

```
as.matrix(new.cm)
```

```
##       [,1] [,2] [,3] [,4] [,5]
##  [1,]   NA   NA   NA   NA   NA
##  [2,]   NA   NA   NA   NA   NA
##  [3,]   NA   NA   NA   NA   NA
##  [4,]   13   NA   NA   NA   NA
##  [5,]   NA   NA   NA   NA   NA
##  [6,]   NA   NA   NA   NA   NA
##  [7,]   NA   NA   NA   NA   NA
##  [8,]   NA   NA   NA   NA   NA
##  [9,]   NA   NA   NA    7   NA
```

In the above example, the desired rows and columns are specified by supplying two integer vectors containing the indices for the anchor regions of interest.
An alternative approach involves simply passing a `GRanges` object to the `inflate` method.
The desired rows/columns are defined as those where the corresponding anchor regions overlap any of the intervals in the `GRanges` object.

```
inflate(gi, GRanges("chrA", IRanges(50, 100)), GRanges("chrA", IRanges(10, 50)), fill=counts)
```

```
## class: ContactMatrix
## dim: 6 5
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

Finally, a character vector can be passed to select all rows/columns lying in a set of chromosomes.

```
inflate(gi, "chrA", "chrB", fill=counts)
```

```
## class: ContactMatrix
## dim: 10 5
## type: matrix
## rownames: NULL
## colnames: NULL
## metadata(0):
## regions: 15
```

The same method is used to convert an `InteractionSet` object into a `ContactMatrix`, by operating on the underlying `GInteractions` object stored the former.
Some additional arguments are available to extract specific data values from the `InteractionSet` to fill the `ContactMatrix`.
For example, if we were to fill the `ContactMatrix` using the counts from the 3rd library in `iset`, we could do:

```
new.cm <- inflate(iset, desired.rows, desired.cols, sample=3)
as.matrix(new.cm)
```

```
##       [,1] [,2] [,3] [,4] [,5]
##  [1,]   NA   NA   NA   NA   NA
##  [2,]   NA   NA   NA   NA   NA
##  [3,]   NA   NA   NA   NA   NA
##  [4,]   10   NA   NA   NA   NA
##  [5,]   NA   NA   NA   NA   NA
##  [6,]   NA   NA   NA   NA   NA
##  [7,]   NA   NA   NA   NA   NA
##  [8,]   NA   NA   NA   NA   NA
##  [9,]   NA   NA   NA   11   NA
```

## 5.2 Deflating a `ContactMatrix` into an `InteractionSet`

The reverse procedure can also be used to convert a `ContactMatrix` into an `InteractionSet`.
This will report pairwise interactions corresponding to each non-`NA` cell of the matrix, with the value of that cell stored as experimental data in the `InteractionSet`:

```
new.iset <- deflate(cm)
new.iset
```

```
## class: InteractionSet
## dim: 69 1
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames(1): 1
## colData names(0):
## type: StrictGInteractions
## regions: 15
```

Note that any duplicated interactions are automatically removed.
Such duplications may occur if there are duplicated rows/columns or – more practically – when the `ContactMatrix` crosses the diagonal of the interaction space.
In most cases, duplicate removal is sensible as the values of the matrix should be reflected around the diagonal, such that the information in duplicated entries is redundant.
However, if this is not the case, we can preserve duplicates for later processing:

```
deflate(cm, collapse=FALSE)
```

```
## class: InteractionSet
## dim: 70 1
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames(1): 1
## colData names(0):
## type: GInteractions
## regions: 15
```

## 5.3 Linearizing an `InteractionSet` into a `RangedSummarizedExperiment`

The `InteractionSet` stores experimental data for pairwise interactions that span the two-dimensional interaction space.
This can be “linearized” into one-dimensional data across the linear genome by only considering the interactions involving a single anchor region.
For example, let’s say we’re interested in the interactions involving a particular region of chromosome A, defined below as `x`:

```
x <- GRanges("chrA", IRanges(42, 48))
rse <- linearize(iset, x)
rse
```

```
## class: RangedSummarizedExperiment
## dim: 2 4
## metadata(0):
## assays(1): ''
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(1): lib.size
```

The `linearize` function will select all interactions involving `x` and return a `RangedSummarizedExperiment` object containing the data associated with those interactions.
The genomic interval for each row in `rse` corresponds to the *other* (i.e., non-`x`) region involved in each selected interaction.
Of course, for self-interactions between `x` and itself, the function just reports `x` in the corresponding interval.

```
rowRanges(rse)
```

```
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]     chrA      1-10      *
##   [2]     chrB     21-25      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

This conversion method is useful for collapsing 2D data into a 1D form for easier processing.
For example, if sequencing counts were being stored in `iset`, then the linearized data in `rse` could be analyzed as if it represented genomic coverage
(where the depth of coverage represents the intensity of the interaction between each region in `rowRanges(rse)` and the region of interest in `x`).
One application would be in converting Hi-C data into pseudo-4C data, given a user-specified “bait” region as `x`.

# 6 Summary

So, there we have it – three classes to handle interaction data in a variety of forms.
We’ve covered most of the major features in this vignette, though details for any given method can be found through the standard methods,
e.g., `?"anchors,GInteractions"` to get the man page for the `anchors` method.
If you think of some general functionality that might be useful and isn’t present here, just let us know and we’ll try to stick it in somewhere.

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
##  [1] InteractionSet_1.38.0       SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              knitr_1.50
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 Rcpp_1.1.0          jquerylib_0.1.4
##  [7] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
## [10] R6_2.6.1            XVector_0.50.0      S4Arrays_1.10.0
## [13] DelayedArray_0.36.0 bookdown_0.45       bslib_0.9.0
## [16] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [19] sass_0.4.10         SparseArray_1.10.0  cli_3.6.5
## [22] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [25] evaluate_1.0.5      abind_1.4-8         rmarkdown_2.30
## [28] tools_4.5.1         htmltools_0.5.8.1
```