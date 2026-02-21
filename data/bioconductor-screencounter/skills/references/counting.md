# Counting barcodes in sequencing screens

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: February 6, 2020

#### Package

screenCounter 1.10.0

# Contents

* [1 Overview](#overview)
* [2 Counting single barcodes](#counting-single-barcodes)
* [3 Counting combinatorial barcodes](#counting-combinatorial-barcodes)
* [4 Counting dual barcodes](#counting-dual-barcodes)
* [5 Counting dual barcodes (single-end)](#counting-dual-barcodes-single-end)
* [6 Counting random barcodes](#counting-random-barcodes)
* [7 Further options](#further-options)
  + [7.1 Supporting mismatches](#supporting-mismatches)
  + [7.2 Searching the other strand](#searching-the-other-strand)
  + [7.3 Parallelization across files](#parallelization-across-files)
* [8 Session information](#session-information)

# 1 Overview

The *screenCounter* package implements several functions to quantify the frequency of barcodes in a sequencing screen experiment.
These functions on the raw FASTQ files, yielding a matrix of counts for each barcode in each sample for downstream analysis.
Quantification can be performed for both single and combinatorial barcodes, though only single-end sequencing data are currently supported.

# 2 Counting single barcodes

The “barcode” is considered to be the entire sequence structure that is used to label a particular molecular or biological entity.
This includes regions of variable sequence that distinguish one barcode from another as well as constant sequences that flank or separate the variable regions.
The most common barcode design uses only one variable region, which we refer to as a “single barcode”.

```
# Example of a single barcode:

CAGCAGCATGCTGNNNNNNNNNNNNNNCAGCATCGTGC
-------------^^^^^^^^^^^^^^-----------
constant     variable      constant
flank        region        flank
```

To demonstrate, let’s mock up a FASTQ file from a single-end sequencing screen.
For simplicity, we will assume that each read only contains the barcode.
However, it is entirely permissible to have additional (unknown) flanking sequences in the read.

```
# Our pool of known variable sequences, one per barcode:
known <- c("AAAAAAAA", "CCCCCCCC", "GGGGGGGG", "TTTTTTTT")

# Mocking up some sequence data, where each read randomly contains
# one of the variable sequences, flanked by constant regions.
library(Biostrings)
chosen <- sample(known, 1000, replace=TRUE)
reads <- sprintf("GTAC%sCATG", chosen)
names(reads) <- sprintf("READ_%i", seq_along(reads))

# Writing to a FASTQ file.
single.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(reads), file=single.fq, format="fastq")
```

We quantify single barcodes across one or more files using the `matrixOfSingleBarcodes()` function.
This produces a `SummarizedExperiment` containing a count matrix of frequencies of each barcode (row) in each file (column).
The order of rows corresponds to the order of variable regions in `known` that distinguishes each barcode.

```
library(screenCounter)
out <- matrixOfSingleBarcodes(single.fq,
    flank5="GTAC", flank3="CATG", choices=known)
out
```

```
## class: SummarizedExperiment
## dim: 4 1
## metadata(0):
## assays(1): counts
## rownames(4): AAAAAAAA CCCCCCCC GGGGGGGG TTTTTTTT
## rowData names(1): choices
## colnames(1): file2f6584764b9561.fastq
## colData names(3): paths nreads nmapped
```

```
assay(out)
```

```
##          file2f6584764b9561.fastq
## AAAAAAAA                      242
## CCCCCCCC                      265
## GGGGGGGG                      252
## TTTTTTTT                      241
```

We specify the constant sequences that immediately flank the variable region111 A template structure can also be specified in `template=`, which may be more convenient..
This improves stringency of barcode identification as the barcode will not be recognized in the read sequence unless the constant sequences match perfectly.
It also improves speed as the matching of the variable sequence is only performed at positions along the read where the flanking constant sequences have matched.

Obviously, users should not supply the full length of the flanking sequence if that sequence is not captured in the read.
For example, the 3’ flanking sequence may be lost in experiments using short reads that only reach to the end of the variable region.
In such cases, an empty string should be specified as `flank3=`.

# 3 Counting combinatorial barcodes

A more complex experimental design involves combinatorial barcodes where multiple variable regions are randomly ligated to form a single sequence.
This exploits combinatorial complexity to generate a large number of unique barcodes from a limited pool of known variable sequences.

```
# Example of a combinatorial barcode:

CAGCTANNNNNNNNNNCACGNNNNNNNNNNCAGCT
------^^^^^^^^^^----^^^^^^^^^^-----
      variable      variable
```

To demonstrate, let’s mock up another FASTQ file of single-end read data.
Again, for simplicity, we will assume that each read sequence contains only the barcode.

```
# Our pool of known variable sequences:
known1 <- c("AAAA", "CCCC", "GGGG", "TTTT")
known2 <- c("ATTA", "CGGC", "GCCG", "TAAT")

# Mocking up some sequence data, where each read randomly contains
# two of the variable sequences within a template structure.
library(Biostrings)
chosen1 <- sample(known1, 1000, replace=TRUE)
chosen2 <- sample(known2, 1000, replace=TRUE)
reads <- sprintf("GTAC%sCATG%sGTAC", chosen1, chosen2)
names(reads) <- sprintf("READ_%i", seq_along(reads))

# Writing to a FASTQ file.
combo.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(reads), file=combo.fq, format="fastq")
```

We quantify combinatorial barcodes across one or more files using the `matrixOfComboBarcodes()` function.
This requires a template for the barcode structure to specify how the variable sequences are used to construct the final barcode.
It is permissible for each variable sequence to be sampled from a different known pool.

```
out <- matrixOfComboBarcodes(combo.fq,
    template="GTACNNNNCATGNNNNGTAC",
    choices=list(first=known1, second=known2))
out
```

```
## class: SummarizedExperiment
## dim: 16 1
## metadata(0):
## assays(1): counts
## rownames(16): BARCODE_1 BARCODE_2 ... BARCODE_15 BARCODE_16
## rowData names(2): first second
## colnames(1): file2f65843eff6c74.fastq
## colData names(3): paths nreads nmapped
```

This function yields a `SummarizedExperiment` object containing a matrix of frequencies of each barcode (row) in each file (column).

```
assay(out)
```

```
##            file2f65843eff6c74.fastq
## BARCODE_1                        58
## BARCODE_2                        58
## BARCODE_3                        66
## BARCODE_4                        69
## BARCODE_5                        77
## BARCODE_6                        68
## BARCODE_7                        68
## BARCODE_8                        68
## BARCODE_9                        74
## BARCODE_10                       63
## BARCODE_11                       52
## BARCODE_12                       49
## BARCODE_13                       60
## BARCODE_14                       50
## BARCODE_15                       64
## BARCODE_16                       56
```

The identities of the variable regions in each combinatorial barcode are specified in the `rowData`,
which contains the variable sequences in `known1` and `known2` that define each barcode.

```
rowData(out)
```

```
## DataFrame with 16 rows and 2 columns
##                  first      second
##            <character> <character>
## BARCODE_1         AAAA        ATTA
## BARCODE_2         AAAA        CGGC
## BARCODE_3         AAAA        GCCG
## BARCODE_4         AAAA        TAAT
## BARCODE_5         CCCC        ATTA
## ...                ...         ...
## BARCODE_12        GGGG        TAAT
## BARCODE_13        TTTT        ATTA
## BARCODE_14        TTTT        CGGC
## BARCODE_15        TTTT        GCCG
## BARCODE_16        TTTT        TAAT
```

# 4 Counting dual barcodes

Another experimental design involves the use of dual barcodes, often to modulate the expression of two genes at once.
The aim is to, again, count the frequency of each combination of barcodes among the observed read pairs.
This differs from the combinatorial barcodes in that the dual barcodes are present on paired reads, with one barcode per read;
in addition, not all combinations of two barcodes may be valid.

```
# Example of a dual barcode:

# READ 1:
CAGCTANNNNNNNNNNCACG
------^^^^^^^^^^----
      variable

# READ 2:
CACGGTTNNNNNNNNNNCAGC
-------^^^^^^^^^^----
       variable
```

To demonstrate, let’s mock up some FASTQ files of paired-end read data.
Again, for simplicity, we will assume that each read sequence contains only the barcode.

```
# Creating an example dual barcode sequencing experiment.
known.pool1 <- c("AGAGAGAGA", "CTCTCTCTC",
    "GTGTGTGTG", "CACACACAC")
known.pool2 <- c("ATATATATA", "CGCGCGCGC",
    "GAGAGAGAG", "CTCTCTCTC")

# Mocking up the barcode sequences.
N <- 1000
read1 <- sprintf("CAGCTACGTACG%sCCAGCTCGATCG",
   sample(known.pool1, N, replace=TRUE))
names(read1) <- seq_len(N)

read2 <- sprintf("TGGGCAGCGACA%sACACGAGGGTAT",
   sample(known.pool2, N, replace=TRUE))
names(read2) <- seq_len(N)

# Writing them to FASTQ files.
tmp <- tempfile()
tmp1 <- paste0(tmp, "_1.fastq")
writeXStringSet(DNAStringSet(read1), filepath=tmp1, format="fastq")
tmp2 <- paste0(tmp, "_2.fastq")
writeXStringSet(DNAStringSet(read2), filepath=tmp2, format="fastq")
```

Let us imagine that only a subset of the barcode combinations are actually valid.
This is often the case because, in these studies,
the combinations are explicitly designed to refer to known phenomena (e.g., gene combinations)
rather than being randomized as described for combinatorial barcodes.

```
choices <- expand.grid(known.pool1, known.pool2)
choices <- DataFrame(barcode1=choices[,1], barcode2=choices[,2])
choices <- choices[sample(nrow(choices), nrow(choices)*0.9),]
```

We quantify dual barcodes across one or more *pairs* of files using the `matrixOfDualBarcodes()` function.
This requires templates for the barcode structure to specify how the variable sequences are used to construct each final barcode;
the first template corresponds to the first barcode, while the second template corresponds to the second barcode.
Many of the options available for single barcode matching in `matrixOfSingleBarcodes()` are also available here
and can be specificed separately for each barcode.

```
out <- matrixOfDualBarcodes(list(c(tmp1, tmp2)),
    choices=choices,
    template=c("CAGCTACGTACGNNNNNNNNNCCAGCTCGATCG",
               "TGGGCAGCGACANNNNNNNNNACACGAGGGTAT"))
out
```

```
## class: SummarizedExperiment
## dim: 14 1
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(2): barcode1 barcode2
## colnames(1): file2f65845d5685ab_1.fastq
## colData names(3): paths1 paths2 npairs
```

This function yields a `SummarizedExperiment` object containing a matrix of frequencies
of each barcode pair (row) in each pair of files (column).

```
assay(out)
```

```
##       file2f65845d5685ab_1.fastq
##  [1,]                         52
##  [2,]                         62
##  [3,]                         61
##  [4,]                         63
##  [5,]                         70
##  [6,]                         60
##  [7,]                         70
##  [8,]                         60
##  [9,]                         58
## [10,]                         54
## [11,]                         56
## [12,]                         71
## [13,]                         69
## [14,]                         75
```

Further diagnostics about the mapping are provided in the `colData`:

```
colData(out)
```

```
## DataFrame with 1 row and 3 columns
##                                            paths1                 paths2
##                                       <character>            <character>
## file2f65845d5685ab_1.fastq /tmp/RtmpQkhyBi/file.. /tmp/RtmpQkhyBi/file..
##                               npairs
##                            <integer>
## file2f65845d5685ab_1.fastq      1000
```

The identities of the variable regions corresponding to each row are specified in the `rowData`,
which contains the variable sequences in `barcode1` and `barcode1` that define each barcode combination.

```
rowData(out)
```

```
## DataFrame with 14 rows and 2 columns
##      barcode1  barcode2
##      <factor>  <factor>
## 1   GTGTGTGTG CTCTCTCTC
## 2   CTCTCTCTC CGCGCGCGC
## 3   CTCTCTCTC ATATATATA
## 4   AGAGAGAGA GAGAGAGAG
## 5   AGAGAGAGA CTCTCTCTC
## ...       ...       ...
## 10  AGAGAGAGA ATATATATA
## 11  GTGTGTGTG ATATATATA
## 12  CACACACAC GAGAGAGAG
## 13  GTGTGTGTG GAGAGAGAG
## 14  GTGTGTGTG CGCGCGCGC
```

By default, we assume that the read sequence in the first FASTQ file contains the first barcode (i.e., `choices[,1]`)
and the second FASTQ file contains the second barcode.
If the arrangement is randomized, we can set `randomized=TRUE` to search the first FASTQ file for the second barcode and vice versa.
Note that this will filter out read pairs that match different valid combinations in both arrangements.

# 5 Counting dual barcodes (single-end)

A variation of the dual barcode design involves both variable regions being on a single read.

```
# Example of a dual barcode:

CAGCTANNNNNNNNNNCACGCACGGTTNNNNNNNNNNCAGC
------^^^^^^^^^^-----------^^^^^^^^^^----
      variable             variable
```

To demonstrate, let’s mock up another FASTQ file of single-end read data.
Again, for simplicity, we will assume that each read sequence contains only the barcode.

```
# Creating an example dual barcode sequencing experiment.
known.pool1 <- c("AGAGAGAGA", "CTCTCTCTC",
    "GTGTGTGTG", "CACACACAC")
known.pool2 <- c("ATATATATA", "CGCGCGCGC",
    "GAGAGAGAG", "CTCTCTCTC")

# Mocking up the barcode sequences.
N <- 1000
read <- sprintf("CAGCTACGTACG%sCCAGCTCGATCG%sACACGAGGGTAT",
   sample(known.pool1, N, replace=TRUE),
   sample(known.pool2, N, replace=TRUE))
names(read) <- seq_len(N)

# Writing them to FASTQ files.
tmp <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(read), filepath=tmp, format="fastq")
```

Let us imagine that only a subset of the barcode combinations are actually valid:

```
choices <- expand.grid(known.pool1, known.pool2)
choices <- DataFrame(barcode1=choices[,1], barcode2=choices[,2])
choices <- choices[sample(nrow(choices), nrow(choices)*0.9),]
```

We quantify single-end dual barcodes across files using the `matrixOfDualBarcodesSingleEnd()` function.
Many of the options available for single barcode matching in `matrixOfSingleBarcodes()` are also available here
and can be specificed separately for each barcode.

```
out <- matrixOfDualBarcodesSingleEnd(tmp, choices=choices,
    template="CAGCTACGTACGNNNNNNNNNCCAGCTCGATCGNNNNNNNNNACACGAGGGTAT")
out
```

```
## class: SummarizedExperiment
## dim: 14 1
## metadata(0):
## assays(1): counts
## rownames: NULL
## rowData names(2): barcode1 barcode2
## colnames(1): file2f658417c8346d.fastq
## colData names(2): paths nreads
```

This function yields a `SummarizedExperiment` object containing a matrix of frequencies
of each valid barcode combination (row) in each file (column).

```
assay(out)
```

```
##       file2f658417c8346d.fastq
##  [1,]                       51
##  [2,]                       59
##  [3,]                       62
##  [4,]                       63
##  [5,]                       63
##  [6,]                       53
##  [7,]                       70
##  [8,]                       61
##  [9,]                       68
## [10,]                       58
## [11,]                       61
## [12,]                       78
## [13,]                       63
## [14,]                       62
```

Further diagnostics about the mapping are provided in the `colData`:

```
colData(out)
```

```
## DataFrame with 1 row and 2 columns
##                                           paths    nreads
##                                     <character> <integer>
## file2f658417c8346d.fastq /tmp/RtmpQkhyBi/file..      1000
```

The identities of the variable regions corresponding to each row are specified in the `rowData`,
which contains the variable sequences in `barcode1` and `barcode1` that define each barcode combination.

```
rowData(out)
```

```
## DataFrame with 14 rows and 2 columns
##      barcode1  barcode2
##      <factor>  <factor>
## 1   GTGTGTGTG CGCGCGCGC
## 2   GTGTGTGTG CTCTCTCTC
## 3   GTGTGTGTG GAGAGAGAG
## 4   CTCTCTCTC ATATATATA
## 5   CTCTCTCTC CGCGCGCGC
## ...       ...       ...
## 10  CTCTCTCTC GAGAGAGAG
## 11  CACACACAC GAGAGAGAG
## 12  AGAGAGAGA GAGAGAGAG
## 13  CACACACAC CTCTCTCTC
## 14  GTGTGTGTG ATATATATA
```

# 6 Counting random barcodes

In this barcode design, the variable region is not sampled from a pool of known sequences but is instead randomly synthesized from a nucleotide mixture.
We cannot use any of the previous functions as they need a known pool;
rather, we need to extract the observed sequences (and their frequencies) from the reads.
To demonstrate, let’s mock up a FASTQ file from a single-end sequencing screen with a single random variable region.

```
# Mocking up a 8-bp random variable region.
N <- 1000
randomized <- lapply(1:N, function(i) {
    paste(sample(c("A", "C", "G", "T"), 8, replace=TRUE), collapse="")
})
barcodes <- sprintf("CCCAGT%sGGGATAC", randomized)
names(barcodes) <- sprintf("READ_%i", seq_along(barcodes))

# Writing to a FASTQ file.
single.fq <- tempfile(fileext=".fastq")
writeXStringSet(DNAStringSet(barcodes), file=single.fq, format="fastq")
```

For this design, we can count the frequency of each observed barcode using the `matrixOfRandomBarcodes()` function.
This produces a `SummarizedExperiment` containing a count matrix of frequencies for each barcode.

```
library(screenCounter)
out <- matrixOfRandomBarcodes(single.fq,
    template="CCCAGTNNNNNNNNGGGATAC")
out
```

```
## class: SummarizedExperiment
## dim: 994 1
## metadata(0):
## assays(1): counts
## rownames(994): AAAAAACG AAAACGTC ... TTTTCTAC TTTTGGAC
## rowData names(1): sequences
## colnames(1): file2f658453d9d6e9.fastq
## colData names(3): paths nreads nmapped
```

```
head(assay(out))
```

```
##          file2f658453d9d6e9.fastq
## AAAAAACG                        1
## AAAACGTC                        1
## AAAAGAGC                        1
## AAAATGAG                        1
## AAACACCG                        1
## AAACATGC                        1
```

# 7 Further options

## 7.1 Supporting mismatches

Mismatch tolerance can be enabled by setting `substitutions` to the desired number of mismatches.
This may improve barcode recovery in the presence of sequencing errors.
While such errors are rare per base222 At least on Illumina machines., they will be more likely to occur when considering the entire length of the barcode.

In practice, mismatch tolerance is turned off by default in all counting functions.
This is because many errors are introduced during barcode synthesis, more than those due to library preparation or sequencing.
Synthesis errors result in genuinely different barcodes (e.g., guides targeting different regions, or different molecular tags) that should not be counted together.
Nonetheless, this setting may be useful for debugging experiments with low mapping rates.

Indels are not tolerated in any matches.

## 7.2 Searching the other strand

By default, the counting functions will search the read sequence on both the original strand reported by the sequencer and on the reverse complement.
It is possible to change this behaviour with the `strand=` argument to only search one of the strands.
The most appropriate setting requires knowledge of the sequencing protocol and the barcode design.
For example:

* Single-end sequencing of a construct where the barcode is only covered by a read sequenced from one of the ends.
  This requires `strand="original"` if the barcode is on the forward strand of the reachable end, or `strand="reverse"` if it is on the reverse strand.
  If the sequencing is performed from a randomly chosen end, only 50% of the reads will contain barcodes.
* Single-end sequencing of a construct where the barcode can be covered by reads from either end.
  This requires `strand="both"` to search both strands of each read.
  This avoids loss of 50% of reads provided that the constant regions are captured by reads from both ends.

Paired-end sequencing of single or combinatorial barcodes requires some more consideration:

* A construct where the barcode can only be covered by a read sequenced from one of the ends *and* that end is known in advance.
  In this case, the data can be treated as single-end.
  Counting can be performed using the file containing reads from that end with `strand="original"` or `strand="reverse"`.
* A construct where the barcode can only be covered by a read sequenced from one of the ends *and* that end is randomly chosen.
  Users can run the counting functions on each file separately with `strand="original"` or `strand="reverse"` and sum the counts.
  (We assume that the chance of randomly encountering the barcode sequence and its flanking constant regions is negligible,
  so each read pair will not contribute more than once to the final count.)
* Paired-end sequencing of a construct where the barcode can be covered by both reads.
  In this case, one of the files can be chosen for use with `strand="both"`.
  Alternatively, users can consolidate read pairs into a consensus read333 For example, see [*FLASh*](https://ccb.jhu.edu/software/FLASH/) or [*vsearch*](https://github.com/torognes/) with `--fastq_mergepairs`. prior to using `strand="both"`.

For paired-end sequencing of dual barcodes, each paired barcode is covered by exactly one paired read in the same direction.
This means that we should never have to set `strand="both"` as the strand orientation should be known ahead of time.
The most that should need to be done is to set `strand` separately for each barcode,
which is achieved by passing a vector of length 2 to specify the orientation for the first and second barcodes, respectively;
or to set `randomized=TRUE` as described above.

## 7.3 Parallelization across files

Counting functions are parallelized across files using the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* framework.
Each file is processed separately on a single worker to create the final matrix of counts.

```
# Pretend that these are different samples:
all.files <- c(single.fq, single.fq, single.fq)

# Parallel execution:
library(BiocParallel)
out <- matrixOfSingleBarcodes(all.files,
    flank5="GTAC", flank3="CATG", choices=known,
    BPPARAM=SnowParam(2))
out
```

```
## class: SummarizedExperiment
## dim: 4 3
## metadata(0):
## assays(1): counts
## rownames(4): AAAAAAAA CCCCCCCC GGGGGGGG TTTTTTTT
## rowData names(1): choices
## colnames(3): file2f658453d9d6e9.fastq file2f658453d9d6e9.fastq
##   file2f658453d9d6e9.fastq
## colData names(3): paths nreads nmapped
```

Users should read the [relevant documentation](https://bioconductor.org/packages/3.22/BiocParallel/vignettes/Introduction_To_BiocParallel.pdf) to determine the most effective parallelization approach for their system.
For example, users working on a cluster should use `BatchToolsParam()`, while users on a local non-Windows machines may prefer to use `MulticoreParam()`.

# 8 Session information

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
##  [1] BiocParallel_1.44.0         screenCounter_1.10.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           Biostrings_2.78.0
##  [9] Seqinfo_1.0.0               XVector_0.50.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 crayon_1.5.3        Rcpp_1.1.0
##  [7] parallel_4.5.1      jquerylib_0.1.4     yaml_2.3.10
## [10] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [13] S4Arrays_1.10.0     knitr_1.50          DelayedArray_0.36.0
## [16] bookdown_0.45       snow_0.4-4          bslib_0.9.0
## [19] rlang_1.1.6         cachem_1.1.0        xfun_0.53
## [22] sass_0.4.10         SparseArray_1.10.0  cli_3.6.5
## [25] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [28] evaluate_1.0.5      codetools_0.2-20    abind_1.4-8
## [31] rmarkdown_2.30      tools_4.5.1         htmltools_0.5.8.1
```