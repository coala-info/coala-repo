# RgnTX: colocalization analysis of transcriptome elements in the presence of isoform heterogeneity and ambiguity

Yue Wang1,2\* and Jia Meng3,4\*\*

1Department of Mathematical Sciences, Xi’an Jiaotong-Liverpool University, China;
2Department of Computer Science, Institute of Systems, Molecular and Integrative Biology, University of Liverpool, United Kingdom;
3Department of Biological Sciences, Xi’an Jiaotong-Liverpool University, China;
4Institute of Integrative Biology, University of Liverpool, United Kingdom;

\*yue.wang19@student.xjtlu.edu.cn
\*\*Jia.Meng@xjtlu.edu.cn

#### 2025-10-07

#### Abstract

This vignette describes the Bioconductor RgnTX package. We developed it for the colocalization analysis of transcriptome elements, where permutation test is performed to statistically estimate association between transcriptome region sets. RgnTX allows user-defined restriction of transcriptome areas during the shuffling, and therefore offers high flexibility in the null model to simulate the realistic transcriptome-wide background such as the complex alternative splicing patterns. The setting of null models (randomization) and colocalization measures can be independently chosen from many pre-defined choices when performing statistical colocalization analysis. Importantly, RgnTX also supports the testing of transcriptome elements without clear isoform association, which is often the real scenario due to technical limitations.

# 1 Introduction

Recent development of high-throughput sequencing technology has generated large amounts of data at transcriptome level such as RNA-binding protein target sites, RNA modifications and other RNA-related genomic features. These transcriptome attributes can be converted to a set of locations or regions.

Currently, colocalization analysis of two genomic region sets has been widely used to infer potential interactions between corresponding biological attributes. A number of methods have been developed for this. For example, *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* has been created to statistically estimate association between genomic region sets using a permutation test framework. All its functions are genome and mask-aware. However, there has been no such tools enable researchers to make data analysis and interpretation at transcriptome level. Here [RgnTX](https://github.com/yue-wang-biomath/RgnTX) is invented to fill this blank.

[RgnTX](https://github.com/yue-wang-biomath/RgnTX) extends an assumption-free permutation test framework transcriptome-wide. Different from existing approaches, [RgnTX](https://github.com/yue-wang-biomath/RgnTX) allows the integration of transcriptome annotations so as to model the complex alternative splicing patterns. Importantly, it also supports the testing of transcriptome elements without clear isoform association, which is often the real scenario due to technical limitations.

[RgnTX](https://github.com/yue-wang-biomath/RgnTX) makes a useful tool for transcriptome region set association analysis. In this vignette, with some simulated datasets, we show that permutation tests conducted in the genome and the transcriptome are significantly different and may return distinct results in section [2](#what-is-the-difference-between-permutation-tests-in-the-genome-and-the-transcriptome). The most core functions for conducting permutation tests and examples with real datasets are introduced in section [6](#permutation-test-function).

# 2 What is the difference between permutation tests in the genome and the transcriptome?

## 2.1 What does a permutation test do?

Suppose we want to know if a region set A has some association with another region set B. We could pick some random region sets, and calculate the number of overlaps between them and B. If the overlap numbers of these random region sets and B are generally smaller than that of A and B, it is more likely to say there exists some association between A and B, otherwise not.

Such permutation test framework mainly involves two steps: the randomization step (picking random region sets) and the evaluation step (evaluating overlapping counts or other test statistic). Importantly, performing it over the transcriptome and the genome can be different in both of these two steps.

## 2.2 Randomization step

Compared with the linear genome space, transcriptome space is heterogeneous due to the existence of multiple isoform transcripts, the splicing junctions and exons used by different frequencies. The isoform specificity of transcriptome elements is often lost in the process of mapping due to technical limitations. To perform isoform-aware permutation for transcriptome element with isoform ambiguity, [RgnTX](https://github.com/yue-wang-biomath/RgnTX) considers only the transcripts that overlap with it when projected to the genome, so as to retrain maximal isoform information. In this example shown by the following figures, feature 3 will be permutated on transcript Tx3 only, while feature 2 will be permutated on all the 3 transcripts.

![The genome space is linear. The figure shows four genomic features in the genome.](data:image/png;base64...)

Figure 1: The genome space is linear
The figure shows four genomic features in the genome.

![The transcriptome space is heterogeneous. It is usually unclear which specific isoform transcript is associated with the transcriptome element because it overlaps with multiple isoforms when mapped to the genome, which is often the real scenario in biological research.](data:image/png;base64...)

Figure 2: The transcriptome space is heterogeneous
It is usually unclear which specific isoform transcript is associated with the transcriptome element because it overlaps with multiple isoforms when mapped to the genome, which is often the real scenario in biological research.

![Permutation space for each feature is distinct. Each feature will be permutated only within the set of isoform transcripts it is associated with.](data:image/png;base64...)

Figure 3: Permutation space for each feature is distinct
Each feature will be permutated only within the set of isoform transcripts it is associated with.

This is supported by the [RgnTX](https://github.com/yue-wang-biomath/RgnTX) function `randomizeFeaturesTx` and the function `randomizeFeaturesTxIA`. The former is for features with known isoform belongings. The latter is for features with isoform ambiguity (IA). Besides, [RgnTX](https://github.com/yue-wang-biomath/RgnTX) also provides function `randomizeTx` supporting picking random region sets within any specified transcriptome space. Users can choose a suitable strategy to do randomization conveniently within only a few lines of codes. More details about this are introduced in section [5](#randomization-function).

## 2.3 Evaluation step

Another non-trivial task is to develop evaluation function for a test statistic, such as the number of overlaps, to be tested between two region sets. A key limitation of existing evaluation approaches is that, they were designed primarily for genome-based evaluation. Two transnscriptome elements with shared exons but are located on the independent transcripts are also considered to have overlaps by them. The information of transcripts is totally lost during comparison, which can induce substantial bias when applying to analyze transcriptome region sets.

[RgnTX](https://github.com/yue-wang-biomath/RgnTX) provides several strategies for transcriptome-level evaluation. Function `overlapCountsTX` counts the number of overlaps between two transcriptome elements in the transcriptome directly. Function `overlapCountsTXIA` calculates a weighted number of overlaps between a feature set (with isoform ambiguity) and a transcriptome region set (without isoform ambiguity). It is also possible to write a custom evaluation function and pass it to the main permutation test function. Details about this part are introduced in section [7](#evaluation-function).

## 2.4 Comparison of permutations over different kinds of spaces

We perform a series of simulations to show the difference of permutation tests conducted in the transcriptome and in the genome.

In this simulation, we randomly generated 1000 pairs of region sets in the following four spaces, with each region set containing 500 regions of 200nt long on the same 300 genes, and then count the number of overlaps between each pair.

* **DNA**: This space contains randomly picked 300 genes from a hg19 TxDb object.
* **pre-mRNA**: It contains all of the pre-mRNAs that pertain to the previously picked 300 genes.
* **mRNA**: It contains all of the mRNAs that pertain to the previously picked genes.
* **Exonic DNA**: This space involves only the part of genome that is related to the previously picked mRNAs. It is actually a linear space of these mRNAs.

Figure [4](#fig:Fig4) shows the evaluation results. In the first four cases, overlaps are counted based on the genome (or after projection). In the last case, overlaps are counted in the transcriptome directly. The former four cases are evaluated by *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* function `numOverlaps`, while the last is evaluated by [RgnTX](https://github.com/yue-wang-biomath/RgnTX) function `overlapCountsTx`.

![Overlapping counts between random region sets in different permutation spaces. Box boundaries represent the 25th and 75th percentiles; center line represents the median.](data:image/png;base64...)

Figure 4: Overlapping counts between random region sets in different permutation spaces
Box boundaries represent the 25th and 75th percentiles; center line represents the median.

As the results show, permutations over different genome and transcriptome space return distinct results. A small number of overlaps are observed in the transcriptome (the last case), which is not surprising due to the existence of multiple isoform transcripts. Interestingly, the results from exonic DNA and mRNA (projected to genome) are also different, which is due to exons used at different frequencies by isoform transcripts. These results suggest that the permutation of heterogeneous transcriptome elements can be substantially more complex than genome-based elements. Genome-based methods are not appropriate to analyze transcriptome elements. That’s why we develop [RgnTX](https://github.com/yue-wang-biomath/RgnTX) to do this.

# 3 Installation

To install this package via devtools, please use the following codes.

```
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")

devtools::install_github("yue-wang-biomath/RgnTX", build_vignettes = TRUE)
```

To install this package via BiocManager, please use the following codes.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RgnTX")
```

# 4 Feature/region format in RgnTX

[RgnTX](https://github.com/yue-wang-biomath/RgnTX) is based on the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* and *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* structure. In this section, we introduce the format of region sets and other associated metadata used in [RgnTX](https://github.com/yue-wang-biomath/RgnTX).

* **TxDb object used in RgnTX**

A TxDb object stores transcripts, exons, CDS and other types of genomic features. A TxDb object is usually required by [RgnTX](https://github.com/yue-wang-biomath/RgnTX) functions. Currently, all the examples in this vignette are based on the `TxDb.Hsapiens.UCSC.hg19.knownGene`. Users can assign other TxDb objects via related function arguments.

* **Transcript ids and names**

A TxDb object provides default ids and names for transcripts. According to *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*, a transcript is guaranteed to be related to a unique transcript id. But a transcript’s name is not guaranteed to be unique or even defined. In this vignette, all the examples use transcript ids instead of names to indicate specific transcripts.

Please pay attention not to confuse the transcript ids with other types of ids, such as ids for CDS, exons and other genomic features provided by a TxDb object, or external ids for genes like Entrez Gene and Ensembl ids. Functions in [RgnTX](https://github.com/yue-wang-biomath/RgnTX) will not work with wrong types of ids.

* **Input feature set should be either GRanges or GRangesList**

The feature/region sets in [RgnTX](https://github.com/yue-wang-biomath/RgnTX) should be either `GRanges` or `GRangesList`.

For a `GRangesList` feature set, every list element that contains a set of ranges is a feature. For a `GRanges` feature set without special instructions, a single range is a feature. For a `GRanges` feature set containing a metadata column named “group”, the set of ranges having the same group number is a feature.

The transcript ids (if available) should be provided as follows. For `GRangesList` objects, the name of each list element (feature) should be the id of the transcript that this feature is located on. For `GRanges` objects, transcript ids should be contained in a metadata column named “transcriptsHits”.

Here is an example of `GRangesList` feature set following the format required by [RgnTX](https://github.com/yue-wang-biomath/RgnTX). Its names should be transcript ids.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

set.seed(12345677)
example.list <- randomizeTx(txdb, random_num = 10, random_length = 200)
example.list
```

```
## GRangesList object of length 10:
## $`9974`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames              ranges strand
##          <Rle>           <IRanges>  <Rle>
##   [1]     chr2 202725672-202725871      +
##   -------
##   seqinfo: 8 sequences from an unspecified genome; no seqlengths
##
## $`52204`
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames              ranges strand
##          <Rle>           <IRanges>  <Rle>
##   [1]    chr14 104143758-104143860      +
##   [2]    chr14 104145721-104145817      +
##   -------
##   seqinfo: 8 sequences from an unspecified genome; no seqlengths
##
## $`73524`
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]    chr22 18893876-18893997      +
##   [2]    chr22 18894078-18894155      +
##   -------
##   seqinfo: 8 sequences from an unspecified genome; no seqlengths
##
## ...
## <7 more elements>
```

The following `GRanges` object represents the same region set as the above one. Ranges having the same group number represent a feature. The `transcriptsHits` column contains corresponding transcript ids. Both formats are accepted by [RgnTX](https://github.com/yue-wang-biomath/RgnTX) functions and can be transformed to each other via function `GRangesList2GRanges` and function `GRanges2GRangesList`.

```
example.gr <- GRangesList2GRanges(example.list)
example.gr
```

```
## GRanges object with 17 ranges and 2 metadata columns:
##        seqnames              ranges strand | transcriptsHits     group
##           <Rle>           <IRanges>  <Rle> |     <character> <integer>
##    [1]     chr2 202725672-202725871      + |            9974         1
##    [2]    chr14 104143758-104143860      + |           52204         2
##    [3]    chr14 104145721-104145817      + |           52204         2
##    [4]    chr22   18893876-18893997      + |           73524         3
##    [5]    chr22   18894078-18894155      + |           73524         3
##    ...      ...                 ...    ... .             ...       ...
##   [13]    chr17   73917325-73917345      - |           64316         8
##   [14]    chr17   73916355-73916510      - |           64316         8
##   [15]    chr17   73916166-73916188      - |           64316         8
##   [16]    chr12 122989759-122989958      - |           49210         9
##   [17]     chr7 121960010-121960209      - |           31300        10
##   -------
##   seqinfo: 8 sequences from an unspecified genome; no seqlengths
```

```
example.list <- GRanges2GRangesList(example.gr)
```

# 5 Randomization function

In [RgnTX](https://github.com/yue-wang-biomath/RgnTX), there are mainly two kinds of randomization functions. One can pick random regions over a specified space (see section [5.1](#pick-random-regions-over-a-specified-space)). One can also randomize specified features into transcriptome, i.e., input a set of features and get a randomized result of it (see section [5.2](#randomize-features-into-transcriptome)).

## 5.1 Pick random regions over a specified space

In this strategy, users need to specify a scope that random region sets will be picked from.

### 5.1.1 randomizeTx function

In this function, users can pass transcript ids via an argument to make random regions to be picked from the transcripts having these ids.

**Step 1: specify a randomization space**

One needs to determine three arguments: a TxDb data, a set of transcript ids and the type of randomized regions the function will return. As an example, we specify a randomization space formed by five mRNAs.

```
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
type <- "mature"
trans.ids <- c("170", "782", "974", "1364", "1387")
```

We feed them into the `randomizeTX` function.

**Step 2: randomizeTx function**

We use this function to pick 10 random regions, and each region is 100 nt long. Each region is picked from a random transcript among the input transcripts.

```
set.seed(12345677)
randomResults <- randomizeTx(txdb, trans_ids = trans.ids, random_num = 10,
                             random_length = 100)
```

* **txdb**: a TxDb obejct.
* **trans\_ids** (default: “all”): the ids of transcripts, which should be a character object. If this argument takes the default value `all`, random regions will be picked from the whole transcriptome.
* **random\_num**: the number of regions to be picked.
* **random\_length**: the length of each region to be picked.
* **type** (default: “mature”): this argument receives options `mature`, `full`, `fiveUTR`, `CDS` or `threeUTR`, with which users can get corresponding types of random regions. Default is “mature”, with which the function picks regions over mRNAs.
* **N** (default: 1): randomization times. The number of sets of region sets the function will return.

```
randomResults
```

```
## GRangesList object of length 10:
## $`1364`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 54433399-54433498      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`170`
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]     chr1 3599695-3599744      +
##   [2]     chr1 3624113-3624162      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`170`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]     chr1 3638649-3638748      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## ...
## <7 more elements>
```

```
width(randomResults)
```

```
## IntegerList of length 10
## [["1364"]] 100
## [["170"]] 50 50
## [["170"]] 100
## [["974"]] 6 94
## [["974"]] 100
## [["974"]] 100
## [["1387"]] 100
## [["1387"]] 100
## [["1364"]] 63 37
## [["170"]] 100
```

The function returns a `GRangesList` object. Every list element has a total length of 100 nt and represents a region on mRNA but possibly separated by intron parts. The name of each element is its relative transcript id.

### 5.1.2 randomizeTransByOrder function

This is another randomization function. The difference of this function and `randomizeTx` is that it does not take an argument about transcript ids, instead, it takes a `GRangesList` region set and picks only one random region within the space indicated by every `GRangesList` element. So the number of regions in a set this function returns is equal to the number of elements in the input `GRangesList` object.

**Step 1: specify a randomization space**

We pick a set of five mRNAs to be the scope of randomization.

```
trans.ids <- c("170", "782", "974", "1364", "1387")
exons.tx0 <- exonsBy(txdb)
regions.A <- exons.tx0[trans.ids]
regions.A
```

```
## GRangesList object of length 5:
## $`170`
## GRanges object with 13 ranges and 3 metadata columns:
##        seqnames          ranges strand |   exon_id   exon_name exon_rank
##           <Rle>       <IRanges>  <Rle> | <integer> <character> <integer>
##    [1]     chr1 3569129-3569205      + |       474        <NA>         1
##    [2]     chr1 3598897-3598994      + |       475        <NA>         2
##    [3]     chr1 3599624-3599744      + |       476        <NA>         3
##    [4]     chr1 3624113-3624355      + |       479        <NA>         4
##    [5]     chr1 3638585-3638771      + |       481        <NA>         5
##    ...      ...             ...    ... .       ...         ...       ...
##    [9]     chr1 3644693-3644781      + |       486        <NA>         9
##   [10]     chr1 3645891-3646012      + |       487        <NA>        10
##   [11]     chr1 3646564-3646712      + |       489        <NA>        11
##   [12]     chr1 3647491-3647629      + |       490        <NA>        12
##   [13]     chr1 3649311-3652765      + |       492        <NA>        13
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## ...
## <4 more elements>
```

**Step 2: randomizeTransByOrder function**

`randomizeTransByOrder` requires two inputs: a region set with `GRangesList` format as the randomization scope, and the length of each random region is going to be picked from every `GRangesList` element.

In the following example, we input a region set containing five regions. The function picks five 100 nt regions from each of them in order.

```
set.seed(12345677)
random.regions.A <- randomizeTransByOrder(regions_A = regions.A,
random_length = 100)
width(regions.A)
```

```
## IntegerList of length 5
## [["170"]] 77 98 121 243 187 116 110 143 89 122 149 139 3455
## [["782"]] 76 82 51 188 180 97 123 156 120 153 1365
## [["974"]] 631 110 77 2040
## [["1364"]] 224 34 487 132 119 89 114 85 504
## [["1387"]] 191 138 407
```

```
width(random.regions.A)
```

```
## IntegerList of length 5
## [["170"]] 100
## [["782"]] 50 50
## [["974"]] 100
## [["1364"]] 69 31
## [["1387"]] 1 99
```

## 5.2 Randomize features into transcriptome

Functions introduced in this section support randomizing two kinds of RNA-related genomic features:

* **Features without isoform ambiguity**: for features without isoform ambiguity, it is clear which specific isoform each feature is located on (See Figure [5](#fig:Fig5)). Each feature will be randomized within its relative transcript.
* **Features with isoform ambiguity**: the isoform specificity of transcriptome elements is unclear to us because each of them overlaps with multiple isoforms when mapped to the genome (See Figure [6](#fig:Fig6)). Each feature will be randomized into the set of isoform transcripts it is associated with.

![Features without isoform ambiguity.](data:image/png;base64...)

Figure 5: Features without isoform ambiguity

![Features with isoform ambiguity.](data:image/png;base64...)

Figure 6: Features with isoform ambiguity

### 5.2.1 randomizeFeatruesTx function

This function is for randomizing a feature set that does not have isoform ambiguity problem.

**Step 1: Specify a feature set (without isoform ambiguity)**

We expect users to input features following the format stated in section [3](#featureregion-format-in-rgntx), i.e., either to be a `GRanges` or `GRangesList` object with corresponding required metadata.

We generate a region set containing 100 regions of 100nt long as an example feature set.

```
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
trans.ids<- c("170", "782", "974", "1364", "1387")
RS1 <-  randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)
```

**Step 2: randomizeFeaturesTx function**

Once we have a feature set, we can use `randomizeFeaturesTx` function to randomize it. This function takes each feature, randomizes its position only within its corresponding transcript that it belongs to and keeps the original size and other associated data.

```
randomResults <- randomizeFeaturesTx(RS1, txdb, type = "mature")
```

By setting the argument `type`, one can randomize input feature set into different types of transcriptome space. The above example picks random regions from mRNAs. The below example only picks random regions from CDS.

```
randomResults <- randomizeFeaturesTx(RS1, txdb, type = "CDS")
```

By setting the argument `N`, one can get multiple sets of randomized region sets of the input feature set.

```
randomResults <- randomizeFeaturesTx(RS1, txdb, N = 5)
```

### 5.2.2 randomizeFeatruesTxIA function

This function is for randomizing a feature set that has isoform ambiguity.

**Step 1: Specify features with isoform ambiguity**

We expect users to input features following the format stated in section [3](#featureregion-format-in-rgntx). For features with isoform ambiguity, users do not need to provide transcript information.

Here we load an m\(^6\)A dataset as an input feature.

```
file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
m6A_sites_data <- readRDS(file)
m6A_sites_data[1:5]
```

```
## GRanges object with 5 ranges and 0 metadata columns:
##       seqnames              ranges strand
##          <Rle>           <IRanges>  <Rle>
##   [1]     chr8   63777549-63777550      +
##   [2]     chr9 131940220-131940221      -
##   [3]    chr10 105361286-105361287      -
##   [4]     chr7     6730337-6730338      -
##   [5]    chr13   31905447-31905448      +
##   -------
##   seqinfo: 25 sequences from an unspecified genome; no seqlengths
```

**Step 2: randomizeFeaturesTxIA function**

One does not know the specific transcript that each m\(^6\)A feature is associated with. When doing randomization, this function takes each feature and randomizes its position only within the set of isoform transcripts that each feature can be mapped to. We input five features and get five random regions. Each random region is corresponding to each feature.

```
randomResults <- randomizeFeaturesTxIA(RS = m6A_sites_data[1:5],
                                       txdb, type = "mature", N = 1)
length(randomResults)
```

```
## [1] 5
```

# 6 Permutation test function

The most important task of [RgnTX](https://github.com/yue-wang-biomath/RgnTX) is to analyze transcriptome region set association via a permutation test framework. There are several permutation test functions. They require different input ways and support user’s different needs. All the functions finally return a report that reflects the level of association being tested and can be visualized by a plot function.

## 6.1 Test between two region sets

This is the most basic strategy. It requires users to input a feature set (to be randomized) and a region set (to be compared with), and evaluates if there is an association between them.

### 6.1.1 permTestTx function

The `permTestTx` function is for features without isoform ambiguity. As an example, we generate two region sets A and B. As shown below, by our design they have at least 50 overlaps. We feed them into `permTestTx`.

```
set.seed(12345677)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
exons.tx0 <- exonsBy(txdb)
trans.ids <- sample(names(exons.tx0), 50)

A <- randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)
B <- c(randomizeTx(txdb, trans.ids, random_num = 50, random_length = 100),
       A[1:50])

permTestTx_results <- permTestTx(RS1 = A,
                                 RS2 = B,
                                 txdb = txdb,
                                 type = "mature",
                                 ntimes = 50,
                                 ev_function_1 = overlapCountsTx,
                                 ev_function_2 = overlapCountsTx)
```

This function involves these arguments:

* **RS1**: a feature set to be randomized.
* **RS2**: a region set to be compared with the feature set.
* **txdb**: a TxDb object.
* **type** (default: “mature”): The type of transctiptome space that the feature set will be randomized into. See section [4.1.1](#randomizetx-function) for more details.
* **ev\_function\_1** (default: overlapCountsTx): evaluation function that defines what statistic to be tested between RS1 and RS2. Default is [RgnTX](https://github.com/yue-wang-biomath/RgnTX) function `overlapCountsTx`. See section [6.1](#overlapcountstx-function) for more details.
* **ev\_function\_2** (default: overlapCountsTx): evaluation function that defines what statistic to be tested between randomized region sets and RS2.
* **pval\_z** (default: FALSE): there are two ways of calculating p-values. If this Boolean is `FALSE`, p-value is calculated by counting the percent of more extreme cases (with more overlaps) in random permutation than the real observation. If `TRUE`, p-value is calculated based on a z-test.

Among the above arguments, users must at least provide a feature set RS1, a region set RS2 and a TxDb object to the main function.

The `permTestTx` function automatically randomizes the feature set RS1 and creates a set of randomized region sets, which is outputted as a list named as RSL (by its inner randomization function `randomizeFeatruesTx`). `permTestTx` uses the first evaluation function `ev_function_1` to calculate the test statistic between RS1 and RS2, and the second evaluation function to compute evaluations between each random region set in RSL and RS2. Finally, all these calculated results are returned as a list, which is defined to be a `permTestTx.results` object.

```
names(permTestTx_results)
```

```
## [1] "RSL"     "RS1"     "RS2"     "orig.ev" "rand.ev" "pval"    "zscore"
## [8] "ntimes"
```

* **RSL**: a set of randomized region sets of RS1.
* **orig.ev**: real observed evaluation. The number of overlaps between RS1 and RS2.
* **rand.ev**: random evaluations. The overlapping counts between each element in RSL and RS2.
* **pval**: p-value of the test.
* **zscore**: standard z-score of the test.

To get a more intuitive view of the result, we can plot it by `plotPermResults` function.

```
p1 <- plotPermResults(permTestTx_results, binwidth = 1)
p1
```

![Association between two region sets.](data:image/png;base64...)

Figure 7: Association between two region sets

The number of overlaps between A and B, i.e., `orig.ev`, should be at least 50. As results show, the random evaluations are much less than `orig.ev`. A p-value is calculated based on the number that the random evaluations are lower than real observed evaluation, which is less than the significance level 0.05 we set. Additionally, a z-score is computed, which is the distance between mean of random evaluations and real observed evaluation divided by standard deviation of random evaluations. The low p-value and high z-score suggest that there is a statistically significant association between A and B.

### 6.1.2 permTestTxIA function

Different from `permTestTx`, this function is for features that have isoform ambiguity, i.e., features that one cannot make sure which specific transcript they are located on. For such feature, usually one can only know a several of isoforms that they can be mapped to. The `permTestTxIA` function randomizes such features into the corresponding set of isoforms by `randomizeFeatruesTxIA` function. It conducts the same protocol evaluating an association as function `permTestTx` does and also returns a `permTestTx.results` object.

## 6.2 Test involving customPick function

This strategy needs users to provide a feature set and a customPick function. The customPick function should aim to pick a specific kind of regions over a transcript (taking transcript ids as input and outputting a region over each transcript). The aim of this kind of test functions is to evaluate association between input feature set and the customPick regions. For example, suppose one wants to know if some features are associated with the last 200 nt region of transcripts more than expected, one can write a function that picks the transcript’s last 200 nt, and pass this function as a customPick function to the test function, which will then conduct a permutation test to evaluate their association level. Writing this kind of customPick function (specifiy certain regions over a transcript) can be easily done with the help of `shiftTx` function in section [9](#other-useful-functions).

The input features may be with or without isoform ambiguity. For a feature without isoform ambiguity, default evaluation function (`overlapCountsTx`) checks if it has overlap with the customPick region (indicated in red) on the transcript where it is located on (see Fig. [8](#fig:Fig8), a). If the answer is yes, the total number of overlaps is added to one and otherwise zero. While for a feature with isoform ambiguity, default evaluation function (`overlapCountsTxIA`) maps it with the customPick regions of all its isoforms (see Fig. [8](#fig:Fig8), b), and every overlap is added not one, but one divided by the number of its isoforms, to the total number of overlaps. In this example, this feature is associated with three isoforms and overlapping with the customPick regions of two of them (indicated in red). Then a value of 2/3 is added to the total overlap.

![Overlap counting ways of two kinds of features with the customPick regions.](data:image/png;base64...)

Figure 8: Overlap counting ways of two kinds of features with the customPick regions

Function `permTestTx_customPick` is for features without isoform ambiguity, while function `permTestTxIA_customPick` is for features with this problem. In this kind of strategies, features are only mapped to the regions in transcripts that they are related to. More details and examples are stated below.

### 6.2.1 permTestTx\_customPick function

As an example, we take a feature set from the CDS space, which contains 100 regions and each region is 200 nt long.

Suppose we do not know how these features are generated. We want to test if these features are associated with the CDS part of transcripts more than expected. To do that, we write a customPick function that can pick the CDS part of these transcripts.

```
getCDS = function(trans_ids, txdb,...){
  cds.tx0 <- cdsBy(txdb, use.names=FALSE)
  cds.names <- as.character(intersect(names(cds.tx0), trans_ids))
  cds = cds.tx0[cds.names]
  return(cds)
}
```

The customPick function should involve at least an argument **trans\_ids** and an ellipsis (…) so that other arguments can be passed to the main test function through this ellipsis operator. The `permTestTx_customPick` function takes the feature set RS1 and the customPick function `getCDS`.

```
set.seed(12345677)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
RS1 <- randomizeTx(txdb, "all", random_num = 100, random_length = 200,
                   type = "CDS")

permTestTx_results <- permTestTx_customPick(RS1 = RS1,
                                            txdb = txdb,
                                            customPick_function = getCDS,
                                            ntimes = 50,
                                            ev_function_1 = overlapCountsTx,
                                            ev_function_2 = overlapCountsTx)
p1 <- plotPermResults(permTestTx_results, binwidth = 1)
p1
```

![ Association between some features with CDS regions.](data:image/png;base64...)

Figure 9: Association between some features with CDS regions

As Fig. [9](#fig:Fig9) shows, it is just as we expected that the overlap number between features and the picked CDS is 100, indicated by a red line, which squares with the fact that all these features are picked from the CDS.

### 6.2.2 permTestTxIA\_customPick function

This function receives a feature set (with isoform ambiguity) and a customPick function.

Let’s take an example about testing association between N\(^6\)-Methyladenosine and the stop codon regions. The m\(^6\)A sites are derived from an miCLIP-seq dataset (Linder, et al., 2015). Due to technical restriction, it is not clear which specific transcript an m\(^6\)A feature is located on.

To test this association, we wrote a customPick function `getStopCodon` picking the stop codon regions of transcripts. It actually picks the last 100 nt of CDS and the first 100 nt of 3’UTR of transcripts given transcript ids. If a given transcript’s CDS or 3’UTR part is less than 100 nt, the function will just pick this less than 100 nt region. This function actually uses the function `shiftTx` in section [9](#other-useful-functions) provided by [RgnTX](https://github.com/yue-wang-biomath/RgnTX) to realize these tasks.

As a quick example, we feed 500 out of 9181 m\(^6\)A sites and this `getStopCodon` function into function `permTestTxIA_customPick`. Its default evaluation function calculates a weighted overlapping number between m\(^6\)A sites and the stop codon regions.

```
set.seed(12345677)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
m6A_sites_data <- readRDS(file)
RS1 <- m6A_sites_data[1:500]

permTestTx_results <- permTestTxIA_customPick(RS1 = RS1,
                                       txdb = txdb,
                                       customPick_function = getStopCodon,
                                       ntimes = 50,
                                       ev_function_1 = overlapCountsTxIA,
                                       ev_function_2 = overlapCountsTx)
p_a <- plotPermResults(permTestTx_results, binwidth = 1)
p_a
```

![ Association between N6-Methyladenosine (500 sites) and stop codon regions.](data:image/png;base64...)

Figure 10: Association between N6-Methyladenosine (500 sites) and stop codon regions

In addition, if one wants to test the whole 9181 m\(^6\)A sites with the stop codon, use the following codes, which will of course take a few more minutes than the case involves less data.

```
set.seed(12345677)
permTestTx_results <- permTestTxIA_customPick(RS1 = m6A_sites_data,
                                       txdb = txdb,
                                       customPick_function = getStopCodon,
                                       ntimes = 50)
p_b <- plotPermResults(permTestTx_results)
p_b
```

![ Association between N6-Methyladenosine and stop codon regions.](data:image/png;base64...)

Figure 11: Association between N6-Methyladenosine and stop codon regions

The weighted number of overlaps between 9181 m\(^6\)A sites and stop codon regions is 804.93 (calculated by default evaluation function in [6.2](#overlapcountstxia-function)), while the mean of random evaluations is 365.28 (calculated by default evaluation function in [6.1](#overlapcountstx-function)). The low p-value shows that the association being tested is statistically significant.

**References**:
Linder, B., et al. (2015) Single-nucleotide-resolution mapping of m\(^6\)A and m\(^6\)Am throughout the transcriptome. *Nat Methods*
**12(8)**: 767-772.

## 6.3 Test with user-provided random sets

### 6.3.1 permTestTx\_customAll function

`permTestTx_customAll` needs users to provide at least three arguments: two region sets and a list of randomized region sets.

We take an easy example to explain how this function should be used. We want to test the association between two region sets come from the same transcript. We pick two region sets RS1 and RS2 in a transcript that has the id “170”, and pick random region sets within a larger space containing 5 transcripts.

```
set.seed(12345677)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
trans.ids1<- c("170")
RS1 <- randomizeTx(txdb = txdb, trans_ids = trans.ids1,
                   random_num = 20, random_length = 100)
RS2 <- randomizeTx(txdb = txdb, trans_ids = trans.ids1,
                   random_num = 20, random_length = 100)
trans.ids2 <-  c("170", "782", "974", "1364", "1387")
RSL <- randomizeTx(txdb = txdb, trans_ids = trans.ids2,
                   random_num = 20, random_length = 100, N = 50)
```

We feed these three elements into the `permTestTx_customAll` function.

```
permTestTx_results <- permTestTx_customAll(RSL = RSL, RS1 = RS1, RS2 = RS2)
p_3 <- plotPermResults(permTestTx_results)
p_3
```

![Association between two region sets picked from the same transcript .](data:image/png;base64...)

Figure 12: Association between two region sets picked from the same transcript

The random evaluations indicated by gray boxes are the number of overlaps between RS2 with each region set in RSL. We can see the number of overlaps between RS1 and RS2 is generally larger than these random evaluations (see Fig. [12](#fig:Fig12)). This accords with the fact that they come from a smaller space so that they are associated with each other more than expected.

# 7 Evaluation function

Evaluation functions should define a statistic to be tested between two region sets. [RgnTX](https://github.com/yue-wang-biomath/RgnTX) provides some evaluation functions that can be passed to the main test functions in section [5](#permutation-test-function) via parameters `ev_function_1` or `ev_function_2`. Users can also customize their own evaluation function as examples shown in section 76.3](#custom-evaluation-function). All the evaluation functions require two input region sets following a format in section [4](#featureregion-format-in-rgntx).

## 7.1 overlapCountsTx function

Function `overlapCountsTx` calculates the number of overlaps between two region sets A and B. It has parameter `over_trans` deciding whether the overlap is counted over transcriptome or genome. If `TRUE`, regions in the two input sets that have shared genomic intervals but are located on different transcripts are not considered to have overlap with each other. This function also has a parameter `count_once`, which decides whether the overlap of multiple regions in the second region set B with a region in A should be counted once or multiple times.

## 7.2 overlapCountsTxIA function

Function `overlapCountsTxIA` accepts a feature set A (with isoform ambiguity) and a region set B (without isoform ambiguity). Each feature in A related to n\(\_1\) isoforms in B and overlapped with n\(\_2\) B regions will contribute a value of n\(\_2\)/ n\(\_1\) to the total number of overlaps, which may be a non-integer. This function is used in `permTestTxIA_customPick` function (see section [6.2.2](#permtesttxia_custompick-function)), calculating a weighted number of overlaps between an m\(^6\)A feature set (with isoform ambiguity) and a customPick region (without isoform ambiguity).

## 7.3 Custom evaluation function

Users can create their own evaluation function. The custom evaluation function must include parameters of two region sets and an ellipsis (…) so that other parameters can be passed to the main test function. Here are two examples.

* **overlapWidthTx**

Instead of calculating overlapping counts, function `overlapWidthTx` returns the sum of widths of each overlap, i.e., the total number of overlapping nucleotides between two input region sets.

* **distanceTx**

The `distanceTx` function calculates the mean of the distance from each region in A to the closest region in B. It contains a user-defined argument, `beta`, which filters out a corresponding percentage of largest distance values so as to avoid extreme large distances which may make estimating results incomparable.

# 8 Parameter setting

In this section, we present some examples to show how different parameter settings influence permutation test results. We take the example in section [6.1.1](#permtesttx-function).

* **test\_type**: This argument receives either an `one-sided` or `two-sided` option. Fig. [13](#fig:Fig13) (b) shows a `two-sided` test having a 95% confidence interval. Two critical regions are indicated in light blue on both sides.
* **alpha**: `alpha` is the significance level of a hypothesis testing. In Fig. [13](#fig:Fig13) (c) and (d) we specify it to be 0.025 and 0.1, which respectively leads to a stricter and a looser test compared to the default test (0.05).
* **Evaluation function**: The default evaluation statistic of `permTestTx` is the number of overlaps. In Fig. [13](#fig:Fig13) (e) and (f) we try different evaluation statistics: the overlapping width and the mean of distances (with beta = 0.3) respectively.
* **Randomization times**: We increase the permutation times to 500 and 2000 in Fig. [13](#fig:Fig13) (g) and (h). A larger number of permutations leads to more accurate results but also can be more computationally expensive. For a permutation test, the randomization function takes the most proportion of the time and resources. In section [11](#performance-of-randomization-function), we discuss the efficiency of [RgnTX](https://github.com/yue-wang-biomath/RgnTX) randomization functions.

```
set.seed(12345677)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
exons.tx0 <- exonsBy(txdb)
trans.ids <- sample(names(exons.tx0), 50)

A <- randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)
B <- c(randomizeTx(txdb, trans.ids, random_num = 50, random_length = 100),
       A[1:50])

permTestTx_results <- permTestTx(RS1 = A,
                                 RS2 = B,
                                 txdb = txdb,
                                 type = "mature",
                                 ntimes = 50,
                                 ev_function_1 = overlapCountsTx,
                                 ev_function_2 = overlapCountsTx)

p_a <- plotPermResults(permTestTx_results, binwidth = 1)

p_b <- plotPermResults(permTestTx_results, test_type = "two-sided")

p_c <- plotPermResults(permTestTx_results, alpha = 0.025)

p_d <- plotPermResults(permTestTx_results, alpha = 0.1)

set.seed(12345677)
permTestTx_results_e <- permTestTx( RS1 = A,
                                    RS2 = B,
                                    txdb = txdb,
                                    type = "mature",
                                    ntimes = 50,
                                    ev_function_1 = overlapWidthTx,
                                    ev_function_2 = overlapWidthTx)
p_e <- plotPermResults(permTestTx_results_e, binwidth = 150)
p_e

set.seed(12345677)
permTestTx_results_f <- permTestTx( RS1 = A,
                                    RS2 = B,
                                    txdb = txdb,
                                    type = "mature",
                                    ntimes = 50,
                                    ev_function_1 = distanceTx,
                                    ev_function_2 = distanceTx, beta = 0.3)
p_f <- plotPermResults(permTestTx_results_f)
p_f

set.seed(12345677)
permTestTx_results_g <- permTestTx(RS1 = A,
                                 RS2 = B,
                                 txdb = txdb,
                                 type = "mature",
                                 ntimes = 500,
                                 ev_function_1 = overlapCountsTx,
                                 ev_function_2 = overlapCountsTx)

p_g <- plotPermResults(permTestTx_results_g, binwidth = 1)
p_g

set.seed(12345677)
permTestTx_results_h <- permTestTx(RS1 = A,
                                 RS2 = B,
                                 txdb = txdb,
                                 type = "mature",
                                 ntimes = 2000,
                                 ev_function_1 = overlapCountsTx,
                                 ev_function_2 = overlapCountsTx)

p_h <- plotPermResults(permTestTx_results_h, binwidth = 1)
p_h
```

![Test results of an association with different argument settings.](data:image/png;base64...)

Figure 13: Test results of an association with different argument settings

# 9 Shifted Z-scores

The value of z-score represents how many standard deviations an observed value is away from the mean of random evaluations. If z-score is close to 0, observed value is about on the mean. If z-score is much larger than 0, observed value is on the positive side and far away from the mean of random evaluations. z-score can be a numerical measurement describing the strength of tested association.

Here we provide a function `shiftedZScoreTx` which shifts RNA features from their original positions, applies evaluation function reassessing association and finally calculates new z-scores, what we call shifted z-scores. Calculating shifted z-scores can help us to learn if an association is specially linked to the exact position of features. Function `plotShiftedZScoreTx` can take the output of `shiftedZScoreTx` and plot different shifted z-scores when the position of features is changed. If we saw a peak at the original point in a plot of shifted z-scores, we would say that this association is closely related to the specific position of corresponding features.

Let’s take the case in section [6.2.2](#permtesttxia_custompick-function) as an example. In this case, results show that m\(^6\)A modifications and the stop codon regions tend to have a strong positive association. Let’s use `shiftedZScoreTx` to move m\(^6\)A features around its original position and calculate corresponding shifted z-scores after each moving.

```
set.seed(12345677)
file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
m6A_sites_data <- readRDS(file)
RS1 <- m6A_sites_data[1:500]
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

permTestTx_results <- permTestTxIA_customPick(RS1 = RS1,
                                          txdb = txdb,
                                          type = "mature",
                                          customPick_function = getStopCodon,
                                          ntimes = 50)
shiftedZScoreTx_results <- shiftedZScoreTx(permTestTx_results, txdb = txdb,
                                           window = 2000,
                                           step = 200,
                                           ev_function_1 = overlapCountsTxIA)
p1 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
p1
```

![Shifted z-scores. Analysis of the association of m$^6$A and stop codon regions with window 2000 and step 200.](data:image/png;base64...)

Figure 14: Shifted z-scores
Analysis of the association of m\(^6\)A and stop codon regions with window 2000 and step 200.

We can see a clear peak in the center of the plot which suggests the tested association is strongly affected by the exact positions of m\(^6\)A features.

Fig. [15](#fig:Fig15) shows the scenario if we move the features within a smaller window. To see how a smaller position shift applied to features affects the z-scores, we set smaller values for the `window` and `step` arguments.

```
set.seed(12345677)
shiftedZScoreTx_results <- shiftedZScoreTx(permTestTx_results,
                                           window = 300,
                                           step = 10, txdb = txdb,
                                           ev_function_1 = overlapCountsTxIA)
p2 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
p2
```

![Shifted z-scores. Analysis of the association of m$^6$A and stop codon regions with window 300 and step 10.](data:image/png;base64...)

Figure 15: Shifted z-scores
Analysis of the association of m\(^6\)A and stop codon regions with window 300 and step 10.

# 10 Other useful functions

In this section, we introduce a useful function that can calculate positional shift over transcript regions. It is based on the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* and *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* structure. Most of randomization functions in [RgnTX](https://github.com/yue-wang-biomath/RgnTX) utilize it doing calculation about shifting regions.

## 10.1 shiftTx function

This function accepts a feature set following the format indicated in section [4](#featueregion-format-in-rgntx) and outputs a region set from it. Each output region is from each input feature. Besides this region set, it also receives a number of other parameters:

* **start**: starting positions. Each value represents a starting position in each input feature.
* **width**: widths. Each value represents a width of each region to be picked from each feature.
* **direction**: either to be character `left` or `right`, which means the direction to which the starting position is shifting. The former means moving to the direction of 5’ while the latter means moving to 3’.
* **strand**: either to be `+` or `-`.

The `direction` and `strand` arguments only receive one value so that this function can only process the same type of direction of shifting and the same strand type of regions at one time.

**Example:** The following example uses `shiftTx` to pick the last 200 nt CDS regions in five mRNAs (positive strand). The function starts from the end of CDS (The parameter `start` takes the largest value of each CDS.) and calculates which coordinates they end after shifting 199 nucleotides to the direction of 5’. This shifting is calculated in mRNA. The impact of introns has been excluded during calculation.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# Five transcripts with positive strand.
trans.ids <- c("170", "782", "974", "1364", "1387")

# Take the CDS part of them.
cds.tx0 <- cdsBy(txdb, use.names = FALSE)
cds.p <- cds.tx0[trans.ids]

# The width of the region from each transcript to be picked is 200.
width <- 200

# The start vector
start = as.numeric(max(end(cds.p)))

R.cds.last200 <- shiftTx(regions = cds.p, start = start, width = width,
                         direction = "left", strand = "+")
R.cds.last200
```

```
## GRanges object with 8 ranges and 2 metadata columns:
##       seqnames            ranges strand | transcriptsHits     group
##          <Rle>         <IRanges>  <Rle> |     <character> <integer>
##   [1]     chr1   3646668-3646712      + |             170         1
##   [2]     chr1   3647491-3647629      + |             170         1
##   [3]     chr1   3649311-3649326      + |             170         1
##   [4]     chr1 28863388-28863411      + |             782         2
##   [5]     chr1 28864344-28864519      + |             782         2
##   [6]     chr1 38265676-38265875      + |             974         3
##   [7]     chr1 54433413-54433612      + |            1364         4
##   [8]     chr1 55161084-55161283      + |            1387         5
##   -------
##   seqinfo: 93 sequences from an unspecified genome; no seqlengths
```

The region set we get is the set of last 200 nt CDS regions of the input five mRNAs. It can be converted to a `GRangesList` object by the `GRanges2GRangesList` function.

```
R.cds.last200.list <- GRanges2GRangesList(R.cds.last200)
R.cds.last200.list
```

```
## GRangesList object of length 5:
## $`170`
## GRanges object with 3 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]     chr1 3646668-3646712      +
##   [2]     chr1 3647491-3647629      +
##   [3]     chr1 3649311-3649326      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`782`
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 28863388-28863411      +
##   [2]     chr1 28864344-28864519      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`974`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 38265676-38265875      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`1364`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 54433413-54433612      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`1387`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]     chr1 55161084-55161283      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Each region picked from each feature is 200 nt long.

```
width(R.cds.last200.list)
```

```
## IntegerList of length 5
## [["170"]] 45 139 16
## [["782"]] 24 176
## [["974"]] 200
## [["1364"]] 200
## [["1387"]] 200
```

This function will not shift or pick regions outside the scope of input features. For example, suppose an input feature is 100 nt. If we assign `start` a value of the coordinate of its 81th nucleotide and assign `width` to be 30, the function will only return this feature’s last 20 nt region to us.

# 11 Performance of randomization function

We evaluate the time it takes for performing randomization functions `randomizeTx` (Table 1) and `randomizeFeaturesTx` (Table 2) for one time. We do each group of tests for 10 times and record the average time they spend. We set different size (row) and different number of features (column) for each group. The unit is seconds. The length of randomized regions have slight influence on the randomization time while the number of them has a more direct impact.

Table 1: Randomization time of randomizeTx.

| Num/Length | 10 | 50 | 100 | 200 |
| --- | --- | --- | --- | --- |
| 100 | 1.783995 | 1.786938 | 1.794495 | 1.761639 |
| 500 | 2.027494 | 2.024690 | 2.075795 | 2.046817 |
| 1000 | 2.341810 | 2.367650 | 2.390498 | 2.585473 |
| 2000 | 3.081001 | 3.006552 | 3.020262 | 3.302140 |
| 5000 | 5.097162 | 5.028154 | 5.107760 | 5.187891 |
| 10000 | 8.434085 | 8.959244 | 9.162599 | 9.148554 |

Table 2: Randomization time of randomizeFeaturesTx.

| Num/Length | 10 | 50 | 100 | 200 |
| --- | --- | --- | --- | --- |
| 100 | 1.770159 | 1.801999 | 1.755498 | 1.771499 |
| 500 | 2.004670 | 2.024997 | 2.096545 | 2.026999 |
| 1000 | 2.335991 | 2.322497 | 2.377498 | 2.359494 |
| 2000 | 3.034632 | 3.042497 | 3.277249 | 3.291889 |
| 5000 | 5.039495 | 5.194495 | 5.190499 | 5.235691 |
| 10000 | 8.644615 | 8.500142 | 8.819886 | 9.216726 |

# 12 Session Info

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
##  [1] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
##  [2] GenomicFeatures_1.61.6
##  [3] AnnotationDbi_1.71.1
##  [4] Biobase_2.69.1
##  [5] GenomicRanges_1.61.5
##  [6] Seqinfo_0.99.2
##  [7] IRanges_2.43.5
##  [8] S4Vectors_0.47.4
##  [9] BiocGenerics_0.55.1
## [10] generics_0.1.4
## [11] RgnTX_1.11.1
## [12] knitr_1.50
## [13] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] Biostrings_2.77.2           S7_0.2.0
##  [7] bitops_1.0-9                fastmap_1.2.0
##  [9] RCurl_1.98-1.17             GenomicAlignments_1.45.4
## [11] XML_3.99-0.19               digest_0.6.37
## [13] lifecycle_1.0.4             KEGGREST_1.49.1
## [15] RSQLite_2.4.3               magrittr_2.0.4
## [17] compiler_4.5.1              rlang_1.1.6
## [19] sass_0.4.10                 tools_4.5.1
## [21] yaml_2.3.10                 rtracklayer_1.69.1
## [23] labeling_0.4.3              S4Arrays_1.9.1
## [25] bit_4.6.0                   curl_7.0.0
## [27] DelayedArray_0.35.3         regioneR_1.41.3
## [29] RColorBrewer_1.1-3          abind_1.4-8
## [31] BiocParallel_1.43.4         withr_3.0.2
## [33] grid_4.5.1                  ggplot2_4.0.0
## [35] scales_1.4.0                tinytex_0.57
## [37] dichromat_2.0-0.1           SummarizedExperiment_1.39.2
## [39] cli_3.6.5                   rmarkdown_2.30
## [41] crayon_1.5.3                httr_1.4.7
## [43] rjson_0.2.23                DBI_1.2.3
## [45] cachem_1.1.0                parallel_4.5.1
## [47] BiocManager_1.30.26         XVector_0.49.1
## [49] restfulr_0.0.16             matrixStats_1.5.0
## [51] vctrs_0.6.5                 Matrix_1.7-4
## [53] jsonlite_2.0.0              bookdown_0.45
## [55] bit64_4.6.0-1               magick_2.9.0
## [57] jquerylib_0.1.4             glue_1.8.0
## [59] codetools_0.2-20            gtable_0.3.6
## [61] GenomeInfoDb_1.45.12        BiocIO_1.19.0
## [63] UCSC.utils_1.5.0            tibble_3.3.0
## [65] pillar_1.11.1               htmltools_0.5.8.1
## [67] BSgenome_1.77.2             R6_2.6.1
## [69] evaluate_1.0.5              lattice_0.22-7
## [71] png_0.1-8                   Rsamtools_2.25.3
## [73] memoise_2.0.1               bslib_0.9.0
## [75] Rcpp_1.1.0                  SparseArray_1.9.1
## [77] xfun_0.53                   MatrixGenerics_1.21.0
## [79] pkgconfig_2.0.3
```