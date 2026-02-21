# Introduction to CAGEfightR

Malte Thodberg

#### 29 October 2025

#### Abstract

CAGEfightR is an R/Bioconductor for analyzing 5’-end data such as CAGE, PRO-Cap, START-Seq, TSS-Seq, etc. Functionality includes identification and quantification of both TSSs and enhancers, detailed annotation using transcript models, TSS-enhancer correlations, super enhancer identification, quantification of gene expression and visualizing it all in a genome browser.

#### Package

CAGEfightR 1.30.0

# Contents

* [1 Installation](#installation)
* [2 Citation](#citation)
* [3 Getting help](#getting-help)
* [4 Quick start for the impatient](#quick-start-for-the-impatient)
* [5 Introduction and overview](#introduction-and-overview)
  + [5.1 Introduction to CAGE data](#introduction-to-cage-data)
  + [5.2 Central S4-classes](#central-s4-classes)
  + [5.3 Overview of functions](#overview-of-functions)
  + [5.4 Pipeability](#pipeability)
* [6 Detailed Introduction](#detailed-introduction)
  + [6.1 CAGE Transcription Start Site (CTSS) level analysis](#cage-transcription-start-site-ctss-level-analysis)
    - [6.1.1 Calculating pooled CTSSs](#calculating-pooled-ctsss)
    - [6.1.2 Calculating CTSS support to remove excess noise](#calculating-ctss-support-to-remove-excess-noise)
    - [6.1.3 Unidirectional (tag) clustering: Finding Transcription Start Sites (TSSs)](#unidirectional-tag-clustering-finding-transcription-start-sites-tsss)
    - [6.1.4 Bidirectional clustering: Finding Enhancers](#bidirectional-clustering-finding-enhancers)
  + [6.2 Cluster level analysis](#cluster-level-analysis)
    - [6.2.1 Quantifying expression at cluster level](#quantifying-expression-at-cluster-level)
    - [6.2.2 Removing weakly expressed clusters](#removing-weakly-expressed-clusters)
    - [6.2.3 Annotation with transcript models](#annotation-with-transcript-models)
    - [6.2.4 Quantifying shape of Tag Clusters](#quantifying-shape-of-tag-clusters)
    - [6.2.5 Spatial analysis of clusters](#spatial-analysis-of-clusters)
  + [6.3 Gene level analysis](#gene-level-analysis)
    - [6.3.1 Annotation with gene models](#annotation-with-gene-models)
    - [6.3.2 Quantify expression at gene-level](#quantify-expression-at-gene-level)
    - [6.3.3 Filtering clusters based on gene composition](#filtering-clusters-based-on-gene-composition)
  + [6.4 Plotting CAGE data in a genome browser](#plotting-cage-data-in-a-genome-browser)
  + [6.5 Parallel execution](#parallel-execution)
* [7 Session Info](#session-info)

# 1 Installation

Install the most recent stable version from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("CAGEfightR")
```

And load `CAGEfightR`:

```
library(CAGEfightR)
```

Alternatively, you can install the development version directly from GitHub using `devtools`:

```
devtools::install_github("MalteThodberg/CAGEfightR")
```

# 2 Citation

If you use CAGEfightR, please cite the following article:

```
citation("CAGEfightR")
#> To cite CAGEfightR in publications use:
#>
#>   Thodberg et al, CAGEfightR: analysis of 5′-end data using
#>   R/Bioconductor, BMC Bioinformatics, 20, 487. (2019)
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {CAGEfightR : analysis of 5 ′ -end data using R / Bioconductor},
#>     author = {Malte Thodberg and Axel Thieffry and Kristoffer Vitting-Seerup and Robin Andersson and Albin Sandelin},
#>     year = {2019},
#>     journal = {BMC Bioinformatics},
#>     doi = {10.1186/s12859-019-3029-5},
#>     volume = {20},
#>     issue = {1},
#>     pages = {487},
#>   }
```

# 3 Getting help

For general questions about the usage of CAGEfightR, use the [official Bioconductor support forum](https://support.bioconductor.org) and tag your question “CAGEfightR”. We strive to answer questions as quickly as possible.

For technical questions, bug reports and suggestions for new features, we refer to the [CAGEfightR github page](https://github.com/MalteThodberg/CAGEfightR/issues).

# 4 Quick start for the impatient

A CAGEfightR anaysis usually starts with loading CAGE Transcription Start Sites (CTSSs) from BigWig-files, one for each strand (If you do not have CTSSs as BigWig-files, look at `convertBED2BigWig` for instructions on how to convert file formats):

```
# Load the example data
data("exampleDesign")
head(exampleDesign)

# Locate files on your harddrive
bw_plus <- system.file("extdata",
                       exampleDesign$BigWigPlus,
                       package = "CAGEfightR")
bw_minus <- system.file("extdata",
                        exampleDesign$BigWigMinus,
                        package = "CAGEfightR")

# Create two named BigWigFileList-objects:
bw_plus <- BigWigFileList(bw_plus)
bw_minus <- BigWigFileList(bw_minus)
names(bw_plus) <- exampleDesign$Name
names(bw_minus) <- exampleDesign$Name
```

The first step is to quantify CTSSs across all samples using `quantifyCTSSs`, which will return the results as a `RangedSummarizedExperiment`:

```
# Get genome information
genomeInfo <- SeqinfoForUCSCGenome("mm9")

# Quantify CTSSs
CTSSs <- quantifyCTSSs(plusStrand=bw_plus,
                       minusStrand=bw_minus,
                       design=exampleDesign,
                       genome=genomeInfo)
#> Checking design...
#> Checking supplied genome compatibility...
#> Iterating over 1 genomic tiles in 3 samples using 4 worker(s)...
#> Importing CTSSs from plus strand...
#> Importing CTSSs from minus strand...
#> Merging strands...
#> Formatting output...
#> ### CTSS summary ###
#> Number of samples: 3
#> Number of CTSSs: 0.04126 millions
#> Sparsity: 57.06 %
#> Type of rowRanges: StitchedGPos
#> Final object size: 1.77 MB
```

The wrapper function `quickTSSs` will automatically find and quantify candidate TSSs, returning the results as a `RangedSummarizedExperiment`:

```
TSSs <- quickTSSs(CTSSs)
#>  - Running calcTPM and calcPooled:
#> Calculating library sizes...
#> Calculating TPM...
#>
#>  - Running clusterUnidirectionally:
#> Splitting by strand...
#> Slice-reduce to find clusters...
#> Calculating statistics...
#> Preparing output...
#> Tag clustering summary:
#>   Width Count Percent
#>   Total 21008 100.0 %
#>     >=1 18387  87.5 %
#>    >=10  2487  11.8 %
#>   >=100   134   0.6 %
#>  >=1000     0   0.0 %
#>
#>  - Running quantifyClusters:
#> Finding overlaps...
#> Aggregating within clusters...
```

Similarly, `quickEnhancers` will find and quantify candidate enhancers:

```
enhancers <- quickEnhancers(CTSSs)
#>  - Running calcTPM and calcPooled:
#> Calculating library sizes...
#> Calculating TPM...
#>
#>  - Running clusterBidirectionally:
#> Pre-filtering bidirectional candidate regions...
#> Retaining for analysis: 50%
#> Splitting by strand...
#> Calculating windowed coverage on plus strand...
#> Calculating windowed coverage on minus strand...
#> Calculating balance score...
#> Slice-reduce to find bidirectional clusters...
#> Calculating statistics...
#> Preparing output...
#> # Bidirectional clustering summary:
#> Number of bidirectional clusters: 656
#> Maximum balance score: 1
#> Minimum balance score: 0.95032498525678
#> Maximum width: 1365
#> Minimum width: 401
#>
#>  - Running subsetByBidirectionality:
#> Calculating bidirectionality...
#> Subsetting...
#> Removed 282 out of 656 regions (43%)
#>
#>  - Running quantifyClusters:
#> Finding overlaps...
#> Aggregating within clusters...
```

We can then use transcript models stored in a `TxDb`-object to annotate each candidate TSS and enhancer with their transcript context:

```
# Use the built in annotation for mm9
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
#> Loading required package: GenomicFeatures
#> Loading required package: AnnotationDbi
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

# Annotate both TSSs and enhancers
TSSs <- assignTxType(TSSs, txModels=txdb)
#> Finding hierachical overlaps...
#> ### Overlap summary: ###
#>       txType count percentage
#> 1   promoter   275        1.3
#> 2   proximal   354        1.7
#> 3    fiveUTR   247        1.2
#> 4   threeUTR  1330        6.3
#> 5        CDS  1611        7.7
#> 6       exon   160        0.8
#> 7     intron 11945       56.9
#> 8  antisense  2745       13.1
#> 9 intergenic  2341       11.1
enhancers <- assignTxType(enhancers, txModels=txdb)
#> Finding hierachical overlaps...
#> ### Overlap summary: ###
#>       txType count percentage
#> 1   promoter    23        6.1
#> 2   proximal    14        3.7
#> 3    fiveUTR     4        1.1
#> 4   threeUTR    29        7.8
#> 5        CDS    42       11.2
#> 6       exon     5        1.3
#> 7     intron   220       58.8
#> 8  antisense     0        0.0
#> 9 intergenic    37        9.9
```

Usually, candidate enhancers overlapping known transcripts are removed:

```
enhancers <- subset(enhancers, txType %in% c("intergenic", "intron"))
```

For usage with other Bioconductor package, it can be useful to merge candidate TSSs and enhancers into a single object:

```
# Add an identifier column
rowRanges(TSSs)$clusterType <- "TSS"
rowRanges(enhancers)$clusterType <- "enhancer"

# Combine TSSs and enhancers, discarding TSSs if they overlap enhancers
RSE <- combineClusters(TSSs, enhancers, removeIfOverlapping="object1")
#> Removing overlapping features from object1: 822
#> Keeping assays: counts
#> Keeping columns: score, thick, txType, clusterType
#> Merging metadata...
#> Stacking and re-sorting...
```

For use with packages for calling differential expression (DESeq2, edgeR, limma, etc.) very lowly expressed features are removed:

```
# Only keep features with more than 0 counts in more than 1 sample:
RSE <- subsetBySupport(RSE,
                       inputAssay = "counts",
                       outputColumn = "support",
                       unexpressed = 0,
                       minSamples = 1)
#> Calculating support...
#> Subsetting...
#> Removed 16064 out of 20443 regions (78.6%)
```

For interfacing with other tools for gene-level analysis, we can quantify gene expression:

```
gene_level <- quickGenes(RSE, geneModels = txdb)
#>  - Running assignGeneID:
#> Extracting genes...
#>   84 genes were dropped because they have exons located on both strands of the
#>   same reference sequence or on more than one reference sequence, so cannot be
#>   represented by a single genomic range.
#>   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
#>   object, or use suppressMessages() to suppress this message.
#> Overlapping while taking distance to nearest TSS into account...
#> Finding hierachical overlaps...
#> ### Overlap Summary: ###
#> Features overlapping genes: 84.95 %
#> Number of unique genes: 113
#>
#>  - Removing unstranded clusters...
#>
#>  - Running quantifyGenes:
#> Quantifying genes: 113
```

But it is much cooler to leverage some of the unique features of 5’-end methods, for example, we can calculate the correlation of expression of nearby TSSs and enhancers:

```
# Set TSSs as reference points
rowRanges(RSE)$clusterType <- factor(rowRanges(RSE)$clusterType,
                                     levels=c("TSS", "enhancer"))

# Find pairs and calculate kendall correlation between them
links <- findLinks(RSE,
                   inputAssay="counts",
                   maxDist=5000,
                   directional="clusterType",
                   method="kendall")
#> Finding directional links from TSS to enhancer...
#> Calculating 1627 pairwise correlations...
#> Preparing output...
#> # Link summary:
#> Number of links: 1627
#> Summary of pairwise distance:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>     0.0   987.5  2011.0  2207.4  3416.0  4999.0
```

Other 5’-end analysis tasks include classifying TSSs based on shape, and identifying groups of closely space enhancers (super enhancers). This and more is described in more detail below!

# 5 Introduction and overview

## 5.1 Introduction to CAGE data

Cap Analysis of Gene Expression (CAGE) is one of the most popular 5’-end high-throughput assays for profiling Transcription Start Site (TSS) activity. CAGE is based on sequencing the first 20-30 basepairs of capped full-length RNAs, called CAGE-tags. When mapped to a reference genome, CAGE-tags can be used to identify both TSSs and enhancers. See the `CAGEfightR` paper for additional introduction.

CAGE-data is often represented as CAGE TSSs (CTSSs), which is the the number of CAGE-tag 5’-ends mapping to each genomic position. CTSSs thereby represent a genome-wide, basepair resolution, quantitative atlas of transcription. CTSSs are inherently sparse, as only very few genomic positions are CTSSs, and only very few CTSSs have a high number of CAGE-tags.

Analysis of CAGE data is often focused on identifying clusters of CTSSs that corresponds to activity of individual TSSs and enhancers. Having access to both TSSs and enhancers in a single experiment makes CAGE well suited for studying many aspects of transcriptional regulation, for example differential expression, motif analysis and alternative TSS usage.

While the examples in this vignette is based on CAGE, other 5’-end methods (PRO-Cap, START-Seq, TSS-Seq, etc.) can be analyzed in the same way.

## 5.2 Central S4-classes

There are two key S4-classes to understand when using CAGEfightR:

The `GRanges`-class: Genomic locations or ranges are stored as `GRanges`-objects from the *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* package. `GRanges` contain chromosome (`seqnames`), start (`start`) and end (`end`) positions of ranges, along with chromosome lengths (`seqinfo`). An important additional feature is information on each range via metadata columns (`mcols`). These can be almost anything, as long as they can be put into a `DataFrame`. Some metadata columns have special meanings: the score column (accesible via the `score` function) and thick column, as these columns can be exported to a standard BED-format file via the `export` function from the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package.

The `RangedSummarizedExperiment`-class: Complete experiments can be stored as `RangedSummarizedExperiment`-objects from the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, which implements the idea of the “three tables of genomics”. A `RangedSummarizedExperiment` can store several matrices of the same shape, e.g. counts and normalized expression values (accesible via `assay` and `assays`), along with information about each sample as a `DataFrame`-object (accesible via `colData`) and about each feature as a `GRanges`-object like above (accesible via `rowRanges`). Many `GRanges` methods also work on`RangedSummarizedExperiment`-objects, like `sort`, `findOverlaps`, etc.. Storing all information as a single `RangedSummarizedExperiment` helps keeping data organized, for example when extracting subsets of the data, where `subset` can be used to simultaneously extract requested data from all three tables at once.

Other S4-classes includes `TxDb`-objects from *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*, `GInteractions`-object from *[InteractionSet](https://bioconductor.org/packages/3.22/InteractionSet)* and various track-objects from *[Gviz](https://bioconductor.org/packages/3.22/Gviz)*. See [Annotation with transcript models](#annotation-with-transcript-models), [Spatial analysis of clusters](#spatial-analysis-of-clusters) and [Plotting CAGE data in a genome browser](#plotting-cage-data-in-a-genome-browser) for more details.

## 5.3 Overview of functions

CAGEfightR conceptually analyses CAGE-data at 3 levels:

1. CTSS-level: Analysis at the level of number of CAGE tags per CTSS.
2. Cluster-level: Analysis at the level of clusters of CTSSs, usually TSSs and/or enhancers.
3. Gene-level: Analysis at the level of annotated genes.

For easier overview, functions in `CAGEfightR` are organized by prefixes. The most important groups are:

The `quantify*`-functions summarizes CAGE data to a higher level. In all cases, data is a stored as a `RangedSummarizedExperiment`:

* `quantifyCTSSs`: Quantify the number of CAGE-tags for each CTSSs from BigWig-files.
* `quantifyClusters`: Quantify the number of CAGE-tags within clusters of CTSSs, usually TSSs or enhancers.
* `quantifyGenes`: Quantify the number of CAGE-tags within annotated genes, by summing the number of CAGE-tags annotated clusters.

The `calc*`-functions modify data stored in a `RangedSummarizedExperiment`. The following `calc*` functions perform basic calculations applicable to all three levels:

* `calcTotalTags`: Calculate the total number of CAGE tags in a library.
* `calcTPM`: Calcuate Tags-Per-Million (TPM).
* `calcPooled`: Calculate a pooled signal across all samples.
* `calcSupport`: Count the number of samples expression a feature above some level. Useful for removing lowly expressed features via the `subsetBySupport` wrapper.

Some `calc*` functions only work for a specfic level:

* `calcShape`: Quantify the shape of TCs using `shape*`-functions.
* `calcBidirectionality`: Count the number of samples showing bidirectional transcription. Useful for finding candidate enhancers via the `subsetByBidirectionality` wrapper.
* `calcComposition`: Calculate how much each TSSs contribute to gene expression. Useful for removing lowly expressed TSSs via the `subsetByComposition` wrapper.

The `cluster*`-functions can cluster CTSSs to find TSSs or enhancers:

* `clusterUnidirectionally`: Find unidirectional or Tag Clusters (TCs). Search threshold can be be found using `tuneTagClustering`. TCs can be modified using the `trim*`-functions.
* `clusterBidirectionally`: Find bidirectional clusters (BCs) for enhancer identification.

The `assign*`-functions can annotate CTSSs and clusters with transcript and genes models:

* `assignTxID`: Annotate clusters with transcript IDs.
* `assignTxType`: Annotate clusters based on their overlap with known transcripts, for example to determine whether a TSS is known or novel.
* `assignGeneID`: Annotate with gene IDs, for example prior to running quantifyGenes.

The `find*`-functions perform spatial analysis of clusters:

* `findLinks`: Finds nearby pairs of clusters and calculates correlation of expression between them. This can be used to find nearby TSSs-enhancer pairs that show similar expression.
* `findStretches`: Find groups of clusters along the genome. This can be used to find tightly spaced groups of enhancers, often refered to as “super enhancers”.

Other groups of functions are

* `check*`-functions for making sure objects are correctly formatted.
* `convert*`-functions convert CTSSs between different file formats.
* `bw*`-functions for checking BigWig-files.
* `swap*`-functions for manipulating `GRanges`-objects.
* `track*`-functions for genome browser visualization.
* `combine*`-functions for safe merging of different types of clusters.
* `quick*`-functions are high-level wrappers for many other functions, intended to be used as single-line execution of the standard pipeline.
* `utils*`-functions expose some of the inner workings of `CAGEfightR` and are mainly intended for expert users and developers.

## 5.4 Pipeability

The majority of functions in `CAGEfightR` are *endomorphisms*, meaning they returned modified versions of the input objects. This often works by adding calculated values as new metadata columns, accesible via `rowData` or `mcols`.

While not used in this vignette, this means that CAGEfightR is highly compatible with the pipes from the *[magrittr](https://CRAN.R-project.org/package%3Dmagrittr)* package.

The main exceptions to pipeable functions this are the `quantify*`-functions, that instead summarize data between different levels.

# 6 Detailed Introduction

The following section contains a detailed walkthrough of most of the functions in `CAGEfightR`, using the built-in dataset. To keep this vignette compact, the example dataset is extremely small - for a more realistic analysis of a full CAGE dataset using both `CAGEfightR` and additional packages, see *[CAGEWorkflow](https://bioconductor.org/packages/3.22/CAGEWorkflow)*.

## 6.1 CAGE Transcription Start Site (CTSS) level analysis

As shown in the introduction [Quick start for the impatient](#quick-start-for-the-impatient), the first step of a `CAGEfightR` analysis is import of CTSSs from BigWig-files with the `quantifyCTSSs` function. Rather than repeating this, we use the built-in `exampleCTSSs` object:

```
data(exampleCTSSs)
exampleCTSSs
#> class: RangedSummarizedExperiment
#> dim: 41256 3
#> metadata(0):
#> assays(1): counts
#> rownames: NULL
#> rowData names(1): score
#> colnames(3): C547 C548 C549
#> colData names(4): Name BigWigPlus BigWigMinus totalTags
```

This is a somewhat special `RangedSummarizedExperiment`: The assay is not a normal `matrix`, but rather a *sparse matrix* (`dgCMatrix` from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package). Since CAGE data is inherently sparse (vast majority sites in the genome have no counts), storing CTSSs as a sparse matrix allows for much faster and memory efficient processing of data:

```
head(assay(exampleCTSSs))
#> 6 x 3 sparse Matrix of class "dgCMatrix"
#>      C547 C548 C549
#> [1,]    1    .    .
#> [2,]    .    .    1
#> [3,]    1    .    .
#> [4,]    .    1    .
#> [5,]    1    .    .
#> [6,]    .    .    1
```

The ranges are stored as `GPos`, where all ranges a one basepair wide. Again, this is much more memory-efficient way of storing CTSSs:

```
rowRanges(exampleCTSSs)
#> StitchedGPos object with 41256 positions and 1 metadata column:
#>           seqnames       pos strand |     score
#>              <Rle> <integer>  <Rle> | <numeric>
#>       [1]    chr18  72690884      + | 0.0804106
#>       [2]    chr18  72730496      + | 0.0690738
#>       [3]    chr18  73169663      + | 0.0804106
#>       [4]    chr18  73190583      + | 0.0814478
#>       [5]    chr18  73234436      + | 0.0804106
#>       ...      ...       ...    ... .       ...
#>   [41252]    chr19  61304387      - | 0.0814478
#>   [41253]    chr19  61304427      - | 0.0690738
#>   [41254]    chr19  61332796      - | 0.0690738
#>   [41255]    chr19  61333667      - | 0.1628955
#>   [41256]    chr19  61333668      - | 0.0814478
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

### 6.1.1 Calculating pooled CTSSs

For clustering CTSSs, we first want to calculate the the overall CTSSs signal across all samples, called *pooled* CTSSs. However, since the different samples have different library sizes, CTSS counts must first be normalized. The simplest way of doing this is to use Tags-Per-Million (TPM, not to be confused with Transcripts-Per-Million or TxPM used in RNA-Seq):

```
exampleCTSSs <- calcTPM(exampleCTSSs, inputAssay="counts", outputAssay="TPM", outputColumn="subsetTags")
#> Calculating library sizes...
#> Calculating TPM...
```

`calcTPM` will calculate the total number of tags for each sample and store them in colData, and then scale counts into TPM and add them as a new assay:

```
# Library sizes
colData(exampleCTSSs)
#> DataFrame with 3 rows and 5 columns
#>             Name       BigWigPlus       BigWigMinus totalTags subsetTags
#>      <character>      <character>       <character> <numeric>  <numeric>
#> C547        C547 mm9.C547.plus.bw mm9.C547.minus.bw  12436172      63230
#> C548        C548 mm9.C548.plus.bw mm9.C548.minus.bw  12277807      52342
#> C549        C549 mm9.C549.plus.bw mm9.C549.minus.bw  14477276      69728

# TPM values
head(assay(exampleCTSSs, "TPM"))
#> 6 x 3 sparse Matrix of class "dgCMatrix"
#>          C547     C548     C549
#> [1,] 15.81528  .        .
#> [2,]  .        .       14.34144
#> [3,] 15.81528  .        .
#> [4,]  .       19.10512  .
#> [5,] 15.81528  .        .
#> [6,]  .        .       14.34144
```

As this is just a subset of the original dataset, we instead use the total number tags from the the complete dataset, by specifying the name of the column in colData (Note that a warning is passed that we are overwritting the previous TPM assay):

```
exampleCTSSs <- calcTPM(exampleCTSSs,
                        inputAssay="counts",
                        totalTags="totalTags",
                        outputAssay="TPM")
#> Using supplied library sizes...
#> Warning in calcTPM(exampleCTSSs, inputAssay = "counts", totalTags =
#> "totalTags", : object already has an assay named TPM: It will be overwritten!
#> Calculating TPM...
head(assay(exampleCTSSs, "TPM"))
#> 6 x 3 sparse Matrix of class "dgCMatrix"
#>           C547       C548       C549
#> [1,] 0.0804106 .          .
#> [2,] .         .          0.06907377
#> [3,] 0.0804106 .          .
#> [4,] .         0.08144777 .
#> [5,] 0.0804106 .          .
#> [6,] .         .          0.06907377
```

`calcPooled` will calculate pooled CTSSs by summing up TPM across samples for each CTSS and store it in the score-column:

```
# Library sizes
exampleCTSSs <- calcPooled(exampleCTSSs, inputAssay="TPM")
#> Warning in calcPooled(exampleCTSSs, inputAssay = "TPM"): object already has a
#> column named score in rowData: It will be overwritten!
rowRanges(exampleCTSSs)
#> StitchedGPos object with 41256 positions and 1 metadata column:
#>           seqnames       pos strand |     score
#>              <Rle> <integer>  <Rle> | <numeric>
#>       [1]    chr18  72690884      + | 0.0804106
#>       [2]    chr18  72730496      + | 0.0690738
#>       [3]    chr18  73169663      + | 0.0804106
#>       [4]    chr18  73190583      + | 0.0814478
#>       [5]    chr18  73234436      + | 0.0804106
#>       ...      ...       ...    ... .       ...
#>   [41252]    chr19  61304387      - | 0.0814478
#>   [41253]    chr19  61304427      - | 0.0690738
#>   [41254]    chr19  61332796      - | 0.0690738
#>   [41255]    chr19  61333667      - | 0.1628955
#>   [41256]    chr19  61333668      - | 0.0814478
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

### 6.1.2 Calculating CTSS support to remove excess noise

In some cases you might have a very large number of and/or very noisy samples (For example due to poor RNA quality), which can lead to an increase in the number of single tags spread across the genome. To alleviate this issue, CTSSs appearing in only a single or few samples can be discarded. We refer to this as calculating the *support*: the number of samples expressing a feature above some threshold:

```
# Count number of samples with MORE ( > ) than 0 counts:
exampleCTSSs <- calcSupport(exampleCTSSs,
                            inputAssay="counts",
                            outputColumn="support",
                            unexpressed=0)
table(rowRanges(exampleCTSSs)$support)
#>
#>     1     2     3
#> 33162  4297  3797
```

The majority of CTSSs are only expressed in a single sample. We can discard these sites using `subset`, and then recalculate TPM values:

```
supportedCTSSs <- subset(exampleCTSSs, support > 1)
supportedCTSSs <- calcTPM(supportedCTSSs, totalTags="totalTags")
#> Using supplied library sizes...
#> Warning in calcTPM(supportedCTSSs, totalTags = "totalTags"): object already has
#> an assay named TPM: It will be overwritten!
#> Calculating TPM...
supportedCTSSs <- calcPooled(supportedCTSSs)
#> Warning in calcPooled(supportedCTSSs): object already has a column named score
#> in rowData: It will be overwritten!
```

Note, `CAGEfightR` warned that it was overwritting columns: Another option would be to save the output as new columns. The `subsetBySupport` function wraps the common task of calling `calcSupport` and `subset`.

### 6.1.3 Unidirectional (tag) clustering: Finding Transcription Start Sites (TSSs)

Once we have obtained pooled CTSSs, we can identify various types of clusters: Transcripts are rarely transcribed from just a single CTSS, but rather from a collection or cluster of nearby CTSSs corresponding to a single TSS.

The simplest way of doing this is to group nearby CTSSs on the same strand into Tag Clusters (TCs), which are likely candidates for real TSSs (although some post-filtering is almost always a good idea, see next section). `CAGEfightR` does this by a slice-reduce approach: It finds sites above some value (slice) and then merges nearby sites (reduce). In the simplest form this can be run as:

```
simple_TCs <- clusterUnidirectionally(exampleCTSSs,
                                     pooledCutoff=0,
                                     mergeDist=20)
#> Splitting by strand...
#> Slice-reduce to find clusters...
#> Calculating statistics...
#> Preparing output...
#> Tag clustering summary:
#>   Width Count Percent
#>   Total 21008 100.0 %
#>     >=1 18387  87.5 %
#>    >=10  2487  11.8 %
#>   >=100   134   0.6 %
#>  >=1000     0   0.0 %
```

`clusterUnidirectionally` find TCs and outputs some summary statistics. We see that we have some very wide TCs (> 100 bp wide, in real datasets it’s not uncommon to see > 1000 bp wide). This is often the result of a just few spread-out tags that link several major TCs, which does not represent the TSS structure very well. One way of dealing with this is to increase the the pooled cutoff for calling clusters. Another way is to first filter the CTSSs based on support:

```
# Use a higher cutoff for clustering
higher_TCs <- clusterUnidirectionally(exampleCTSSs,
                                     pooledCutoff=0.1,
                                     mergeDist=20)
#> Splitting by strand...
#> Slice-reduce to find clusters...
#> Calculating statistics...
#> Preparing output...
#> Tag clustering summary:
#>   Width Count Percent
#>   Total  3392   100 %
#>     >=1  2895    85 %
#>    >=10   440    13 %
#>   >=100    57     2 %
#>  >=1000     0     0 %

# Use CTSSs pre-filtered on support.
prefiltered_TCs <- clusterUnidirectionally(supportedCTSSs,
                                     pooledCutoff=0,
                                     mergeDist=20)
#> Splitting by strand...
#> Slice-reduce to find clusters...
#> Calculating statistics...
#> Preparing output...
#> Tag clustering summary:
#>   Width Count Percent
#>   Total  2295   100 %
#>     >=1  1898    83 %
#>    >=10   348    15 %
#>   >=100    49     2 %
#>  >=1000     0     0 %
```

Both approaches reduces the overall width of the TCs identified, in particular the most wide TCs. In practice, whether or not a higher pooled cutoff and/or prefiltering is used depends on how noisy a given dataset is. A large number of very wide clusters (> 1000 bp wide) and unusual location of TCs relative to known genes (See [Annotation with transcript models](#annotation-with-transcript-models) below) could indicate an unstable tag clustering.

Now let’s take a closer look at what’s returned:

```
simple_TCs
#> GRanges object with 21008 ranges and 2 metadata columns:
#>                             seqnames            ranges strand |      score
#>                                <Rle>         <IRanges>  <Rle> |  <numeric>
#>   chr18:72690884-72690884;+    chr18          72690884      + |  0.0804106
#>   chr18:72730496-72730496;+    chr18          72730496      + |  0.0690738
#>   chr18:73169663-73169663;+    chr18          73169663      + |  0.0804106
#>   chr18:73190583-73190583;+    chr18          73190583      + |  0.0814478
#>   chr18:73234436-73234436;+    chr18          73234436      + |  0.0804106
#>                         ...      ...               ...    ... .        ...
#>   chr19:61304092-61304092;-    chr19          61304092      - |  0.0690738
#>   chr19:61304278-61304387;-    chr19 61304278-61304387      - | 86.4736313
#>   chr19:61304427-61304427;-    chr19          61304427      - |  0.0690738
#>   chr19:61332796-61332796;-    chr19          61332796      - |  0.0690738
#>   chr19:61333667-61333668;-    chr19 61333667-61333668      - |  0.2443433
#>                                 thick
#>                             <IRanges>
#>   chr18:72690884-72690884;+  72690884
#>   chr18:72730496-72730496;+  72730496
#>   chr18:73169663-73169663;+  73169663
#>   chr18:73190583-73190583;+  73190583
#>   chr18:73234436-73234436;+  73234436
#>                         ...       ...
#>   chr19:61304092-61304092;-  61304092
#>   chr19:61304278-61304387;-  61304320
#>   chr19:61304427-61304427;-  61304427
#>   chr19:61332796-61332796;-  61332796
#>   chr19:61333667-61333668;-  61333667
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The `GRanges` includes the chromosome, start and end positions of each TCs, as well as two other key values: The TC peak in the thick column: This the single position within the TC with the highest pooled TPM, and the sum of pooled TPM within the TC in the score column. In case you want to save TCs to a bed file, you can use the `export` function from the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package.

### 6.1.4 Bidirectional clustering: Finding Enhancers

CAGE is a unique technology in that it allows for the robust identification of enhancers by transcription of enhancer RNAs (eRNAs). Active enhancers produce weak but consistent bidirectional transcription of capped eRNAs, resulting in a characteristic CTSS pattern of two diverging peaks approximally 400 basepairs apart. A similar approach can be used for other 5’-end methods such as PRO-Cap.

CAGEfightR can identify this pattern by calculating a balance score ranging from 0 to 1, where 1 corresponds to perfectly divergent site (Technically, the balance score is the *Bhattacharyya coefficient* measuring agreement with the “ideal” divergent site, see the `CAGEfightR` paper). Again, a slice-reduce approach can be use to identify invidividual enhancers based on the balance scores. We refer to this approach as *bidirectional clustering* as opposed to the conventional *unidirectional clustering* used to identify TSSs: and hence the name of the cluster functions: `clusterBidirectionally` and `clusterUnidirectionally`:

```
BCs <- clusterBidirectionally(exampleCTSSs, balanceThreshold=0.95)
#> Pre-filtering bidirectional candidate regions...
#> Retaining for analysis: 50%
#> Splitting by strand...
#> Calculating windowed coverage on plus strand...
#> Calculating windowed coverage on minus strand...
#> Calculating balance score...
#> Slice-reduce to find bidirectional clusters...
#> Calculating statistics...
#> Preparing output...
#> # Bidirectional clustering summary:
#> Number of bidirectional clusters: 658
#> Maximum balance score: 1
#> Minimum balance score: 0.950315219659836
#> Maximum width: 1365
#> Minimum width: 401
```

Let’s look closer at the returned `GRanges`:

```
BCs
#> GRanges object with 658 ranges and 3 metadata columns:
#>                           seqnames            ranges strand |     score
#>                              <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:73731201-73731785    chr18 73731201-73731785      * |  0.160821
#>   chr18:73731954-73732359    chr18 73731954-73732359      * |  1.221660
#>   chr18:73750120-73750566    chr18 73750120-73750566      * |  0.242269
#>   chr18:73752491-73752954    chr18 73752491-73752954      * |  0.149484
#>   chr18:73802189-73802734    chr18 73802189-73802734      * |  0.150522
#>                       ...      ...               ...    ... .       ...
#>   chr19:61182775-61183301    chr19 61182775-61183301      * |  0.311343
#>   chr19:61193379-61193914    chr19 61193379-61193914      * |  0.762907
#>   chr19:61194240-61194692    chr19 61194240-61194692      * |  0.218558
#>   chr19:61202164-61202703    chr19 61202164-61202703      * |  0.149484
#>   chr19:61260538-61260972    chr19 61260538-61260972      * |  0.138148
#>                               thick   balance
#>                           <IRanges> <numeric>
#>   chr18:73731201-73731785  73731493  1.000000
#>   chr18:73731954-73732359  73732158  0.997127
#>   chr18:73750120-73750566  73750343  0.985341
#>   chr18:73752491-73752954  73752722  0.999280
#>   chr18:73802189-73802734  73802461  0.999153
#>                       ...       ...       ...
#>   chr19:61182775-61183301  61183042  0.999802
#>   chr19:61193379-61193914  61193600  0.999770
#>   chr19:61194240-61194692  61194460  0.999280
#>   chr19:61202164-61202703  61202433  0.999280
#>   chr19:61260538-61260972  61260755  1.000000
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The `GRanges` includes the chromosome, start and end positions of each Bidirectional Cluster (BC), as well as two other key values: the score column holds the sum of pooled CTSSs of the BC (on both strands) and the BC midpoint in the thick column: This is the maximally balanced site in the BC Again, the `export` function from the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package can be used to export enhancers to a BED-file.

As balance here is solely defined on the pooled CTSSs, a useful filter is to make sure the BC is observed to be bidirectional in at least a single sample. Similarly to how we calculated support, we can calculate the sample-wise *bidirectionality* of BCs:

```
# Calculate number of bidirectional samples
BCs <- calcBidirectionality(BCs, samples=exampleCTSSs)

# Summarize
table(BCs$bidirectionality)
#>
#>   0   1   2   3
#> 281 308  43  26
```

Many BCs are not observed to be bidirectional in one or more samples. We can remove these using `subset` (The `subsetBySupport` function wraps the common task of calling `calcBidirectionality` and `subset`):

```
enhancers <- subset(enhancers, bidirectionality > 0)
```

This bidirectional clustering approach identifies *any* bidirectional site in the genome. This means that for example bidirectional promoters will also detected (given that they are sufficiently balanced). To remove these cases, annotation with transcript models can be used to remove bidirectional clusters overlapping known promoters and exons. This is described in the next section.

## 6.2 Cluster level analysis

Once interesting clusters (unidirectional TSSs candidates and bidirectional enhancer candidates) have been identified, they can be quantified and annotated with transcript models. We show this functionality using the built-in example data:

```
# Load the example datasets
data(exampleCTSSs)
data(exampleUnidirectional)
data(exampleBidirectional)
```

### 6.2.1 Quantifying expression at cluster level

To look at differential expression, we must quantify the expression of each TC in each sample (in almost all cases you want to quantify the raw CTSS counts). This can be done using the `quantifyClusters` function (The example datasets have already been quantified, so here we will re-quantify the clusters):

```
requantified_TSSs <- quantifyClusters(exampleCTSSs,
                                      clusters=rowRanges(exampleUnidirectional),
                                      inputAssay="counts")
#> Finding overlaps...
#> Aggregating within clusters...
requantified_enhancers <- quantifyClusters(exampleCTSSs,
                                           clusters=rowRanges(exampleBidirectional),
                                           inputAssay="counts")
#> Finding overlaps...
#> Aggregating within clusters...
```

This returns a RangedSummarizedExperiment with clusters in rowRanges and a count matrix in assays.

### 6.2.2 Removing weakly expressed clusters

We often wish to remove weakly expressed clusters. Similarly to CTSSs, a simple approach is to remove cluster based on counts using the `subsetBySupport` function:

```
# Only keep BCs expressed in more than one sample
supported_enhancers <- subsetBySupport(exampleBidirectional,
                                       inputAssay="counts",
                                       unexpressed=0,
                                       minSamples=1)
#> Calculating support...
#> Subsetting...
#> Removed 107 out of 377 regions (28.4%)
```

Similarly, we can also first calculate TPM values for clusters, and then filter on TPM values:

```
# Calculate TPM using pre-calculated total tags:
exampleUnidirectional <- calcTPM(exampleUnidirectional,
                                 totalTags = "totalTags")
#> Using supplied library sizes...
#> Calculating TPM...

# Only TSSs expressed at more than 1 TPM in more than 2 samples
exampleUnidirectional <- subsetBySupport(exampleUnidirectional,
                                         inputAssay="TPM",
                                         unexpressed=1,
                                         minSamples=2)
#> Calculating support...
#> Subsetting...
#> Removed 20836 out of 21008 regions (99.2%)
```

### 6.2.3 Annotation with transcript models

While CAGE can identify TSSs and enhancers completely independent of annotation, it is often useful to compare these to existing annotations. Bioconductor stores transcript models using the `TxDb` class from the *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* package. There are multiple ways to obtain a `TxDb` object:

* Use the `TxDb`-objects included as Bioconductor packages: For this vignette we use the *[TxDb.Mmusculus.UCSC.mm9.knownGene](https://bioconductor.org/packages/3.22/TxDb.Mmusculus.UCSC.mm9.knownGene)* package.
* Import a GTF or GFF3 file using the `makeTxDbFromGFF` function from *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*.
* Use the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package to directly download `TxDb` objects for a wide range of organisms.
* Use `makeTxDbFromBiomart`, `makeTxDbFromUCSC` or `makeTxDbFromEnsembl` from *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* to create `TxDb`-objects from various online sources.

In case you really do not want to use a `TxDb` object, all annotation functions in `CAGEfightR` also accepts `GRanges` or `GRangesList` as input.

```
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
txdb
#> TxDb object:
#> # Db type: TxDb
#> # Supporting package: GenomicFeatures
#> # Data source: UCSC
#> # Genome: mm9
#> # Organism: Mus musculus
#> # Taxonomy ID: 10090
#> # UCSC Table: knownGene
#> # Resource URL: http://genome.ucsc.edu/
#> # Type of Gene ID: Entrez Gene ID
#> # Full dataset: yes
#> # miRBase build ID: NA
#> # transcript_nrow: 55419
#> # exon_nrow: 246570
#> # cds_nrow: 213117
#> # Db created by: GenomicFeatures package from Bioconductor
#> # Creation time: 2015-10-07 18:13:02 +0000 (Wed, 07 Oct 2015)
#> # GenomicFeatures version at creation time: 1.21.30
#> # RSQLite version at creation time: 1.0.0
#> # DBSCHEMAVERSION: 1.1
```

First, we might simply inquire as to what transcripts overlaps our clusters, which is done via the `assignTxID` function:

```
exampleUnidirectional <- assignTxID(exampleUnidirectional,
                                    txModels=txdb,
                                    outputColumn="txID")
#> Extracting transcripts...
#> Finding hierachical overlaps...
#> ### Overlap Summary: ###
#> Features overlapping transcripts: 87.79 %
#> Number of unique transcripts: 232
```

Note, that a single TC can overlap multiple transcripts (names are separated with a `;`):

```
rowRanges(exampleUnidirectional)[5:6]
#> GRanges object with 2 ranges and 4 metadata columns:
#>                             seqnames            ranges strand |     score
#>                                <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:74427824-74428010;+    chr18 74427824-74428010      + |   63.7753
#>   chr18:74442758-74442841;+    chr18 74442758-74442841      + |   11.3312
#>                                 thick   support                  txID
#>                             <IRanges> <integer>           <character>
#>   chr18:74427824-74428010;+  74427933         3 uc008fph.2;uc008fpj.2
#>   chr18:74442758-74442841;+  74442817         3 uc008fpl.2;uc008fpm.2
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

In many cases, we are not so much interested in what specific transcripts a cluster overlaps, but rather *where* in a transcript a cluster lies - for example whether it is located at the annotated TSSs, in the 5’-UTR or in the CDS region. However, due to overlapping transcripts, these categories might overlap, for example a region might be an exon in one transcripts, but skipped in another due to alternative splicing. To get around this, `CAGEfightR` implements a hierachical annotation scheme (See the `CAGEfightR` paper for a detailed description), implemented in the `assignTxType` function:

```
exampleUnidirectional <- assignTxType(exampleUnidirectional,
                                      txModels=txdb,
                                      outputColumn="txType")
#> Finding hierachical overlaps...
#> ### Overlap summary: ###
#>       txType count percentage
#> 1   promoter   102       59.3
#> 2   proximal    11        6.4
#> 3    fiveUTR    14        8.1
#> 4   threeUTR     3        1.7
#> 5        CDS     8        4.7
#> 6       exon     0        0.0
#> 7     intron    13        7.6
#> 8  antisense     6        3.5
#> 9 intergenic    15        8.7
```

The function returns a small summary of the annotation: At the top of the hierachy we have overlap with annotated promoter (+/- 100 basepairs from the annotated TSSs, with this distance being changeable when running the function), followed by proximal (-1000 upstream of the annotated TSS). Coding transcripts can be annotated as 5’-UTR, 3-’UTR, CDS and intron, while non-coding transcripts are simply annotated as exon or intron. At the bottom of the hierachy, clusters overlapping genes on the opposite strand are annotated as antisense. Finally, in case a cluster does not overlap any transcript, it is annotated as intergenic.

Highly expressed TSSs can be quite wide, and overlap many different categories. It can be useful to only annotate the TSSs peak rather than the the entire TSSs to obtain more representative annotations:

```
exampleUnidirectional <- assignTxType(exampleUnidirectional,
                                      txModels=txdb,
                                      outputColumn="peakTxType",
                                      swap="thick")
#> Finding hierachical overlaps with swapped ranges...
#> ### Overlap summary: ###
#>       txType count percentage
#> 1   promoter    95       55.2
#> 2   proximal    15        8.7
#> 3    fiveUTR    16        9.3
#> 4   threeUTR     3        1.7
#> 5        CDS     6        3.5
#> 6       exon     0        0.0
#> 7     intron    16        9.3
#> 8  antisense     6        3.5
#> 9 intergenic    15        8.7
```

Annotation with transcript models are particular useful for enhancer detecting, since BCs might in some cases be very balanced bidirectional promoters. We can remove BCs overlapping known transcripts:

```
# Annotate with TxTypes
exampleBidirectional <- assignTxType(exampleBidirectional,
                                     txModels=txdb,
                                     outputColumn="txType")
#> Finding hierachical overlaps...
#> ### Overlap summary: ###
#>       txType count percentage
#> 1   promoter    23        6.1
#> 2   proximal    14        3.7
#> 3    fiveUTR     4        1.1
#> 4   threeUTR    29        7.7
#> 5        CDS    42       11.1
#> 6       exon     5        1.3
#> 7     intron   223       59.2
#> 8  antisense     0        0.0
#> 9 intergenic    37        9.8

# Only keep intronic and intergenic enhancers
exampleBidirectional <- subset(exampleBidirectional,
                               txType %in% c("intron", "intergenic"))
```

Of course, this way of filtering relies on having accurate transcript models!

### 6.2.4 Quantifying shape of Tag Clusters

We have already looked at two characteristics of Tag Clusters (TCs) in addition their genomic location: the expression level (score column) and TSSs peak (thick column). One can further describe TCs beyond these two measures. For example, it was found that mammalian TSSs can be divided into “sharp” or “broad” TSSs, by comparing the Interquartile Range (IQR). We refer to such a measure as a *shape statistic* and `CAGEfightR` includes a few built-in functions for shape statistics (IQR, entropy) as well as an easy framework for implementing your own.

Let’s see how this works by calculating the IQR for TSSs. First, we need to calculate pooled CTSS:

```
# Recalculate pooled signal
exampleCTSSs <- calcTPM(exampleCTSSs, totalTags = "totalTags")
#> Using supplied library sizes...
#> Calculating TPM...
exampleCTSSs <- calcPooled(exampleCTSSs)
#> Warning in calcPooled(exampleCTSSs): object already has a column named score in
#> rowData: It will be overwritten!

# Calculate shape
exampleUnidirectional <- calcShape(exampleUnidirectional,
                                   pooled=exampleCTSSs,
                                   outputColumn = "IQR",
                                   shapeFunction = shapeIQR,
                                   lower=0.25, upper=0.75)
#> Splitting by strand...
#> Applying function to each cluster...
#> Preparing output output...
```

A plot of the distribution of IQR values reveals the distinction between broad and sharp TSSs:

```
hist(rowRanges(exampleUnidirectional)$IQR,
     breaks=max(rowRanges(exampleUnidirectional)$IQR),
     xlim=c(0,100),
     xlab = "IQR",
     col="red")
```

![](data:image/png;base64...)

`shapeEntropy` works in the same way. Advanced users may implement their own shape statistic by writing a new function:

```
# Write a function that quantifies the lean of a TSS
shapeLean <- function(x, direction){
    # Coerce to normal vector
    x <- as.vector(x)

    # Find highest position:
    i <- which.max(x)

    # Calculate sum
    i_total <- sum(x)

    # Calculate lean fraction
    if(direction == "right"){
        i_lean <- sum(x[i:length(x)])
    }else if(direction == "left"){
        i_lean <- sum(x[1:i])
    }else{
        stop("direction must be left or right!")
    }

    # Calculate lean
    o <- i_lean / i_total

    # Return
    o
}

# Calculate lean statistics,
# additional arguments can be passed to calcShape via "..."
exampleUnidirectional <- calcShape(exampleUnidirectional,
                                   exampleCTSSs,
                                   outputColumn="leanRight",
                                   shapeFunction=shapeLean,
                                   direction="right")
#> Splitting by strand...
#> Applying function to each cluster...
#> Preparing output output...

exampleUnidirectional <- calcShape(exampleUnidirectional,
                                   exampleCTSSs,
                                   outputColumn="leanLeft",
                                   shapeFunction=shapeLean,
                                   direction="left")
#> Splitting by strand...
#> Applying function to each cluster...
#> Preparing output output...
```

### 6.2.5 Spatial analysis of clusters

Since CAGE provides both the precise location and expression of clusters, one can analyze how these two are related: Do features that are adjacent in genomic space also show the same expression patterns? The classic example is finding likely TSS-enhancer interaction candidates by looking for closely spaced TSSs and enhancers that have highly correlated expression. Another example is finding stretches of closely spaced enhancers called “super enhancers” that often behave differently that solitary enhancers.

The `findLinks`-function finds nearby pairs and calculates the correlation of their expression. In the simple case, all possible links (or pairs) between TCs can be found:

```
library(InteractionSet)
TC_pairs <- findLinks(exampleUnidirectional,
                      inputAssay="TPM",
                      maxDist=10000,
                      method="kendall")
#> Finding links...
#> Calculating 70 pairwise correlations...
#> Preparing output...
#> # Link summary:
#> Number of links: 70
#> Summary of pairwise distance:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    21.0    89.0   351.5   857.3   953.0  5249.0

TC_pairs
#> GInteractions object with 70 interactions and 3 metadata columns:
#>        seqnames1           ranges1     seqnames2           ranges2 |  distance
#>            <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
#>    [1]     chr18 73732354-73732632 ---     chr18 73733025-73733167 |       392
#>    [2]     chr18 75526955-75527080 ---     chr18 75527198-75527345 |       117
#>    [3]     chr18 75526955-75527080 ---     chr18 75527370-75527692 |       289
#>    [4]     chr18 75526955-75527080 ---     chr18 75527781-75527888 |       700
#>    [5]     chr18 75526955-75527080 ---     chr18 75527910-75528053 |       829
#>    ...       ...               ... ...       ...               ... .       ...
#>   [66]     chr19 59419710-59419784 ---     chr19 59420174-59420376 |       389
#>   [67]     chr19 60019206-60019377 ---     chr19 60019434-60019572 |        56
#>   [68]     chr19 61302434-61302599 ---     chr19 61303017-61303145 |       417
#>   [69]     chr19 61302434-61302599 ---     chr19 61304278-61304387 |      1678
#>   [70]     chr19 61303017-61303145 ---     chr19 61304278-61304387 |      1132
#>         estimate   p.value
#>        <numeric> <numeric>
#>    [1]  1.000000  0.333333
#>    [2] -0.333333  1.000000
#>    [3] -0.333333  1.000000
#>    [4]  0.333333  1.000000
#>    [5] -0.333333  1.000000
#>    ...       ...       ...
#>   [66]  0.333333  1.000000
#>   [67]  1.000000  0.333333
#>   [68]  0.333333  1.000000
#>   [69]  0.333333  1.000000
#>   [70]  1.000000  0.333333
#>   -------
#>   regions: 172 ranges and 9 metadata columns
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The results are returned as a `GInteractions`-object from the *[InteractionSet](https://bioconductor.org/packages/3.22/InteractionSet)* package. In addition to the links themselves, the distance, correlation estimate and correlation p-value is calculated. The `findLinks`-function is fairly flexible and can be used to calculate other correlation measures (see the `?findLinks` help page for how to do this). For example, one might want to calculate Pearson correlations on log TPM values instead of Kendall correlations.

Instead of simply finding all links, one can only look at links connecting TSSs and enhancers, e.g. nearby TCs and BCs. To find these, we must first merge the two sets of clusters and mark that we consider the TCs the reference points:

```
# Mark the type of cluster
rowRanges(exampleUnidirectional)$clusterType <- "TSS"
rowRanges(exampleBidirectional)$clusterType <- "enhancer"

# Merge the dataset
colData(exampleBidirectional) <- colData(exampleUnidirectional)
SE <- combineClusters(object1=exampleUnidirectional,
                      object2=exampleBidirectional,
                      removeIfOverlapping="object1")
#> Removing overlapping features from object1: 1
#> Keeping assays: counts
#> Keeping columns: score, thick, txType, clusterType
#> Merging metadata...
#> Stacking and re-sorting...

# Mark that we consider TSSs as the reference points
rowRanges(SE)$clusterType <- factor(rowRanges(SE)$clusterType,
                                    levels=c("TSS", "enhancer"))

# Recalculate TPM values
SE <- calcTPM(SE, totalTags="totalTags")
#> Using supplied library sizes...
#> Calculating TPM...

# Find link between the groups:
TCBC_pairs <- findLinks(SE,
                      inputAssay="TPM",
                      maxDist=10000,
                      directional="clusterType",
                      method="kendall")
#> Finding directional links from TSS to enhancer...
#> Calculating 139 pairwise correlations...
#> Preparing output...
#> # Link summary:
#> Number of links: 139
#> Summary of pairwise distance:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>      40    1710    3131    4008    5832   10000

TCBC_pairs
#> GInteractions object with 139 interactions and 4 metadata columns:
#>         seqnames1           ranges1     seqnames2           ranges2 |
#>             <Rle>         <IRanges>         <Rle>         <IRanges> |
#>     [1]     chr18 73975205-73975329 ---     chr18 73972185-73972592 |
#>     [2]     chr18 74601980-74602282 ---     chr18 74603575-74604023 |
#>     [3]     chr18 74601980-74602282 ---     chr18 74604817-74605228 |
#>     [4]     chr18 74938603-74938899 ---     chr18 74942224-74942707 |
#>     [5]     chr18 75165494-75165595 ---     chr18 75166311-75166787 |
#>     ...       ...               ... ...       ...               ... .
#>   [135]     chr19 57432920-57433003 ---     chr19 57430719-57431120 |
#>   [136]     chr19 57432920-57433003 ---     chr19 57437999-57438437 |
#>   [137]     chr19 59149970-59150224 ---     chr19 59149129-59149573 |
#>   [138]     chr19 60656742-60656955 ---     chr19 60655711-60656154 |
#>   [139]     chr19 60866497-60866666 ---     chr19 60871144-60871629 |
#>         orientation  distance  estimate   p.value
#>         <character> <integer> <numeric> <numeric>
#>     [1]    upstream      2612  0.000000  1.000000
#>     [2]  downstream      1292  1.000000  0.333333
#>     [3]  downstream      2534 -0.333333  1.000000
#>     [4]  downstream      3324 -0.816497  0.220671
#>     [5]  downstream       715 -1.000000  0.333333
#>     ...         ...       ...       ...       ...
#>   [135]  downstream      1799  0.000000  1.000000
#>   [136]    upstream      4995 -1.000000  0.333333
#>   [137]  downstream       396 -0.333333  1.000000
#>   [138]  downstream       587  0.333333  1.000000
#>   [139]    upstream      4477  0.000000  1.000000
#>   -------
#>   regions: 431 ranges and 4 metadata columns
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

When performing a directional analysis like this, the orientation between links is also calculated: In this case it is whether the enhancer is upstream or downstream of the TSS.

The `findStretches`-function can identify groups of closely spaced clusters, where all clusters are within a certain distance of another member. For example, to find super enhancer candidates, one can find stretches of closely spaced BCs:

```
stretches <- findStretches(exampleBidirectional,
              inputAssay="counts",
              minSize=3,
              mergeDist=10000,
              method="spearman")
#> Finding stretches...
#> Calculating correlations...
#> # Stretch summary:
#> Number of stretches: 24
#> Total number of clusters inside stretches: 96 / 260
#> Minimum clusters: 3
#> Maximum clusters: 9
#> Minimum width: 3142
#> Maximum width: 34155
#> Summary of average pairwise correlations:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#> -0.3333 -0.1257  0.1220  0.1770  0.3928  0.9107
stretches
#> GRanges object with 24 ranges and 3 metadata columns:
#>                           seqnames            ranges strand |        revmap
#>                              <Rle>         <IRanges>  <Rle> | <IntegerList>
#>   chr18:73805496-73827703    chr18 73805496-73827703      * |     1,2,3,...
#>   chr18:75529400-75552484    chr18 75529400-75552484      * |  28,29,30,...
#>   chr18:76418539-76426039    chr18 76418539-76426039      * |      44,45,46
#>   chr18:82662914-82679036    chr18 82662914-82679036      * |      73,74,75
#>   chr18:84583172-84594031    chr18 84583172-84594031      * |  88,89,90,...
#>                       ...      ...               ...    ... .           ...
#>   chr19:57923988-57929596    chr19 57923988-57929596      * |   215,216,217
#>   chr19:58118521-58124179    chr19 58118521-58124179      * |   225,226,227
#>   chr19:60966834-60969975    chr19 60966834-60969975      * |   242,243,244
#>   chr19:61014226-61025438    chr19 61014226-61025438      * |   247,248,249
#>   chr19:61171848-61183301    chr19 61171848-61183301      * |   257,258,259
#>                           nClusters     aveCor
#>                           <integer>  <numeric>
#>   chr18:73805496-73827703         6 -0.0666667
#>   chr18:75529400-75552484         6 -0.1666667
#>   chr18:76418539-76426039         3  0.9106836
#>   chr18:82662914-82679036         3  0.7440169
#>   chr18:84583172-84594031         4  0.0833333
#>                       ...       ...        ...
#>   chr19:57923988-57929596         3   0.910684
#>   chr19:58118521-58124179         3  -0.333333
#>   chr19:60966834-60969975         3   0.166667
#>   chr19:61014226-61025438         3   0.666667
#>   chr19:61171848-61183301         3  -0.333333
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
```

The location of all stretches with a minimum number of BCs (in this case 3) is returned as a `GRanges`. The number of clusters within the stretch and the average pairwise correlation (Spearman correlation of counts in this example) in the stretch is also returned. The revmap column can be used to extract the resulting stretches as a `GRangesList`:

```
extractList(rowRanges(exampleBidirectional), stretches$revmap)
#> GRangesList object of length 24:
#> [[1]]
#> GRanges object with 6 ranges and 5 metadata columns:
#>                           seqnames            ranges strand |     score
#>                              <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:73805496-73805921    chr18 73805496-73805921      * |  0.160821
#>   chr18:73811498-73811931    chr18 73811498-73811931      * |  0.162896
#>   chr18:73812468-73812873    chr18 73812468-73812873      * |  0.393828
#>   chr18:73813421-73813962    chr18 73813421-73813962      * |  0.830944
#>   chr18:73822839-73823308    chr18 73822839-73823308      * |  0.323717
#>   chr18:73827264-73827703    chr18 73827264-73827703      * |  0.311343
#>                               thick   balance   txType clusterType
#>                           <IRanges> <numeric> <factor> <character>
#>   chr18:73805496-73805921  73805708  1.000000   intron    enhancer
#>   chr18:73811498-73811931  73811714  1.000000   intron    enhancer
#>   chr18:73812468-73812873  73812670  0.951325   intron    enhancer
#>   chr18:73813421-73813962  73813687  0.999160   intron    enhancer
#>   chr18:73822839-73823308  73823073  0.966402   intron    enhancer
#>   chr18:73827264-73827703  73827483  0.999802   intron    enhancer
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> [[2]]
#> GRanges object with 6 ranges and 5 metadata columns:
#>                           seqnames            ranges strand |     score
#>                              <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:75529400-75529863    chr18 75529400-75529863      * |  0.312380
#>   chr18:75537081-75537483    chr18 75537081-75537483      * |  0.438153
#>   chr18:75539502-75539917    chr18 75539502-75539917      * |  0.288669
#>   chr18:75543024-75543476    chr18 75543024-75543476      * |  0.312380
#>   chr18:75545832-75546286    chr18 75545832-75546286      * |  0.160821
#>   chr18:75552024-75552484    chr18 75552024-75552484      * |  0.322680
#>                               thick   balance   txType clusterType
#>                           <IRanges> <numeric> <factor> <character>
#>   chr18:75529400-75529863  75529631  0.969038   intron    enhancer
#>   chr18:75537081-75537483  75537282  0.987364   intron    enhancer
#>   chr18:75539502-75539917  75539709  0.962625   intron    enhancer
#>   chr18:75543024-75543476  75543250  0.999835   intron    enhancer
#>   chr18:75545832-75546286  75546059  1.000000   intron    enhancer
#>   chr18:75552024-75552484  75552243  1.000000   intron    enhancer
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> [[3]]
#> GRanges object with 3 ranges and 5 metadata columns:
#>                           seqnames            ranges strand |     score
#>                              <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:76418539-76418952    chr18 76418539-76418952      * |  0.138148
#>   chr18:76423837-76424258    chr18 76423837-76424258      * |  0.138148
#>   chr18:76425514-76426039    chr18 76425514-76426039      * |  0.218558
#>                               thick   balance   txType clusterType
#>                           <IRanges> <numeric> <factor> <character>
#>   chr18:76418539-76418952  76418745         1   intron    enhancer
#>   chr18:76423837-76424258  76424047         1   intron    enhancer
#>   chr18:76425514-76426039  76425732         1   intron    enhancer
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> ...
#> <21 more elements>
```

## 6.3 Gene level analysis

CAGE can detect TSSs and enhancers completely independent of existing gene models. However many databases of functional annotation, such as GO and KEGG terms, are only available at gene level. One might need to compare CAGE data to existing RNA-Seq or Microarray data only available at the level of genes.

Another typical analysis is to look at Differential TSS Usage (DTU), sometimes refered to as alternative TSSs or promoter switches. Here the aim is to identify if genes utilize different TSSs under different conditions, independently of whether the overall gene expression changes.

### 6.3.1 Annotation with gene models

In a similar fashion to transcript annotation described above [Annotation with transcript models](#annotation-with-transcript-models), gene models are obtained via `TxDb` objects:

```
# Load example TSS
data(exampleUnidirectional)

# Keep only TCs expressed at more than 1 TPM in more than 2 samples:
exampleUnidirectional <- calcTPM(exampleUnidirectional,
                                 totalTags = "totalTags")
#> Using supplied library sizes...
#> Calculating TPM...
exampleUnidirectional <- subsetBySupport(exampleUnidirectional,
                                         inputAssay="TPM",
                                         unexpressed=1,
                                         minSamples=2)
#> Calculating support...
#> Subsetting...
#> Removed 20836 out of 21008 regions (99.2%)

# Use the Bioconductor mm9 UCSC TxXb
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
```

The `assignGeneID` function annotate ranges with gene IDs:

```
exampleUnidirectional <- assignGeneID(exampleUnidirectional,
                                      geneModels=txdb,
                                      outputColumn="geneID")
#> Extracting genes...
#>   84 genes were dropped because they have exons located on both strands of the
#>   same reference sequence or on more than one reference sequence, so cannot be
#>   represented by a single genomic range.
#>   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
#>   object, or use suppressMessages() to suppress this message.
#> Overlapping while taking distance to nearest TSS into account...
#> Finding hierachical overlaps...
#> ### Overlap Summary: ###
#> Features overlapping genes: 88.37 %
#> Number of unique genes: 88
```

TSSs not overlappping any genes receive NA, and in the (usually rare) case of a TC overlapping multiple genes, the gene with the closest annotated TSS is chosen:

What type of gene ID is returned of course depends on the source of the `TxDb` object supplied. In this case, it is Entrez IDs, the most commonly used ID system in Bioconductor. Entrez IDs can be used to find the corresponding gene symbols using an `OrgDb` object:

```
# Use Bioconductor OrgDb package
library(org.Mm.eg.db)
#>
odb <- org.Mm.eg.db

# Match IDs to symbols
symbols <- mapIds(odb,
                  keys=rowRanges(exampleUnidirectional)$geneID,
                  keytype="ENTREZID",
                  column="SYMBOL")
#> 'select()' returned 1:1 mapping between keys and columns

# Add to object
rowRanges(exampleUnidirectional)$symbol <- as.character(symbols)
```

For most gene-level operations in `CAGEfightR` NAs (TCs not overlapping genes) are simply removed. If you wish to keep these TCs, you can relabel them as “Novel” genes via the `assignMissingID` function:

```
exampleUnidirectional <- assignMissingID(exampleUnidirectional,
                                         outputColumn="symbol")
#> Assigned 2 missing IDs
```

### 6.3.2 Quantify expression at gene-level

Once TCs have been assigned to genes, TC expression can be summed up within genes to obtain a gene-level expression matrix via the `quantifyGenes` function:

```
genelevel <- quantifyGenes(exampleUnidirectional,
                           genes="geneID",
                           inputAssay="counts")
#> Quantifying genes: 88
```

This returns a `RangedSummarizedExperiment` with the same number of rows as genes. The ranges are returned as a `GRangesList` of the individual TSSs making up the expression of the genes:

```
rowRanges(genelevel)
#> GRangesList object of length 88:
#> $`100217439`
#> GRanges object with 5 ranges and 5 metadata columns:
#>                             seqnames            ranges strand |     score
#>                                <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr19:53899594-53899628;-    chr19 53899594-53899628      - |   5.33930
#>   chr19:55817615-55817747;-    chr19 55817615-55817747      - |   7.08360
#>   chr19:56738118-56738213;-    chr19 56738118-56738213      - |  12.16317
#>   chr19:57432920-57433003;-    chr19 57432920-57433003      - |   7.09694
#>   chr19:60842388-60842752;-    chr19 60842388-60842752      - |  17.65180
#>                                 thick   support      geneID      symbol
#>                             <IRanges> <integer> <character> <character>
#>   chr19:53899594-53899628;-  53899605         3   100217439     Snora19
#>   chr19:55817615-55817747;-  55817695         3   100217439     Snora19
#>   chr19:56738118-56738213;-  56738161         3   100217439     Snora19
#>   chr19:57432920-57433003;-  57432963         3   100217439     Snora19
#>   chr19:60842388-60842752;-  60842645         3   100217439     Snora19
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> $`100217466`
#> GRanges object with 1 range and 5 metadata columns:
#>                             seqnames            ranges strand |     score
#>                                <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:74938323-74938515;-    chr18 74938323-74938515      - |   243.887
#>                                 thick   support      geneID      symbol
#>                             <IRanges> <integer> <character> <character>
#>   chr18:74938323-74938515;-  74938434         3   100217466    Scarna17
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> $`100502841`
#> GRanges object with 1 range and 5 metadata columns:
#>                             seqnames            ranges strand |     score
#>                                <Rle>         <IRanges>  <Rle> | <numeric>
#>   chr18:78135139-78135265;+    chr18 78135139-78135265      + |   101.861
#>                                 thick   support      geneID      symbol
#>                             <IRanges> <integer> <character> <character>
#>   chr18:78135139-78135265;+  78135206         3   100502841        Epg5
#>   -------
#>   seqinfo: 35 sequences (1 circular) from mm9 genome
#>
#> ...
#> <85 more elements>
```

Gene-level values are accesible via the `rowData` function:

```
rowData(genelevel)
#> DataFrame with 88 rows and 1 column
#>           nClusters
#>           <integer>
#> 100217439         5
#> 100217466         1
#> 100502841         1
#> 107029            1
#> 107368            2
#> ...             ...
#> 76539             1
#> 76987             2
#> 78832             1
#> 93737             1
#> 94281             1
```

The gene-level expression matrix can now be supplied to many other Bioconductor packages, including DESeq2, edgeR, limma, etc.

### 6.3.3 Filtering clusters based on gene composition

When looking at Differential TSS Usage (DTU) we are interested in changes in the contribution of individual TCs to overall gene expression. Since CAGE can detect even very lowly expressed TSSs, it is common to see TSSs making up only a very small fraction of the total gene expression. Removing these TSSs can improve power and clarity of downstream analyses.

`CAGEfightR` can calculate the *composition* value of intragenic TCs, defined as the number of samples expressing a TC at more than a certain fraction of total gene expression. This is implemented in the `calcComposition` function:

```
# Remove TSSs not belonging to any genes
intragenicTSSs <- subset(exampleUnidirectional, !is.na(geneID))

# Calculate composition:
# The number of samples expressing TSSs above 10% of the total gene expression.
intragenicTSSs <- calcComposition(intragenicTSSs,
                                  outputColumn="composition",
                                  unexpressed=0.1,
                                  genes="geneID")

# Overview of composition values:
table(rowRanges(intragenicTSSs)$composition)
#>
#>   0   1   2   3
#>  21   9   6 116
```

We can see that many TCs makes up less than 10% in all samples. These can be removed with `subset`:

```
# Remove TSSs with a composition score less than 3
intragenicTSSs <- subset(intragenicTSSs, composition > 2)
```

The `subsetByComposition` function wraps the common task of calling `calcComposition` and `subset`. After filtering, the resulting expression matrix can be used with popular Bioconductor packages for DTU calling, such as DEXSeq, DRIMSeq, edgeR, limma, etc.

## 6.4 Plotting CAGE data in a genome browser

[Zenbu](http://fantom.gsc.riken.jp/zenbu/) is an excellent online genome browser for visualizing CAGE data in relation to annotation in an interative manner. For producing figures (or possibly a very large number of figures) of specific genomic regions, it can be useful to use R to generate genome browser-like plots.

`CAGEfightR` can produce genome browser plots via the popular and extensive *[Gviz](https://bioconductor.org/packages/3.22/Gviz)* package. `CAGEfightR` provides functions for generating genome browser tracks for both CTSSs and clusters. For general generation and customization of `Gviz` plots we refer to the extensive *[Gviz](https://bioconductor.org/packages/3.22/Gviz)* manual. Below we include some basic examples of visualizing CAGE data.

First we load use the built-in datasets:

```
library(Gviz)
#> Loading required package: grid

data("exampleCTSSs")
data("exampleUnidirectional")
data("exampleBidirectional")
```

First we make a track of pooled CTSSs:

```
# Calculate pooled CTSSs
exampleCTSSs <- calcTPM(exampleCTSSs, totalTags="totalTags")
#> Using supplied library sizes...
#> Calculating TPM...
exampleCTSSs <- calcPooled(exampleCTSSs)
#> Warning in calcPooled(exampleCTSSs): object already has a column named score in
#> rowData: It will be overwritten!

# Built the track
pooled_track <- trackCTSS(exampleCTSSs, name="CTSSs")
#> Splitting pooled signal by strand...
#> Preparing track...
```

The returned object is a `DataTrack`, which we can plot a specific genomic region of:

```
# Plot the main TSS of the myob gene
plotTracks(pooled_track, from=74601950, to=74602100, chromosome="chr18")
```

![](data:image/png;base64...)

Secondly, we make a track of clusters: This function can handle both TSSs and enhancers, so we first merge them into a single object:

```
# Remove columns
exampleUnidirectional$totalTags <- NULL
exampleBidirectional$totalTags <- NULL

# Combine TSSs and enhancers, discarding TSSs if they overlap enhancers
CAGEclusters <- combineClusters(object1=exampleUnidirectional,
                                object2=exampleBidirectional,
                                removeIfOverlapping="object1")
#> Removing overlapping features from object1: 1220
#> Keeping assays: counts
#> Keeping columns: score, thick
#> Merging metadata...
#> Stacking and re-sorting...

# Only keep features with more than 0 counts in more than 2 samples
CAGEclusters <- subsetBySupport(CAGEclusters,
                                inputAssay = "counts",
                                unexpressed=0,
                                minSamples=2)
#> Calculating support...
#> Subsetting...
#> Removed 18566 out of 20165 regions (92.1%)

# Build track
cluster_track <- trackClusters(CAGEclusters, name="Clusters", col=NA)
#> Setting thick and thin features...
#> Merging and sorting...
#> Preparing track...
```

The returned object is a `GeneRegionTrack`, which we can plot the same genomic region of:

```
# Plot the main TSS of the myob gene
plotTracks(cluster_track, from=74601950, to=74602100, chromosome="chr18")
```

![](data:image/png;base64...)

Of course, we want to combine several different tracks into a single overview. There is multiple ways of doing this, and the code below is just one such way:

```
# Genome axis tracks
axis_track <- GenomeAxisTrack()

# Transcript model track
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
tx_track <- GeneRegionTrack(txdb,
                            chromosome = "chr18",
                            name="Gene Models",
                            col=NA,
                            fill="bisque4",
                            shape="arrow")

# Merge all tracks
all_tracks <- list(axis_track, tx_track, cluster_track, pooled_track)

# Plot the Hdhd2 gene
plotTracks(all_tracks, from=77182700, to=77184000, chromosome="chr18")
```

![](data:image/png;base64...)

```
# Plot an intergenic enhancer
plotTracks(all_tracks, from=75582473, to=75582897, chromosome="chr18")
```

![](data:image/png;base64...)

Finally we might one to zoom out even further and look at TSS-enhancer correlations across large distances in the genome. First we find links between TSSs and enhancers:

```
# Unstranded clusters are enhancers
rowRanges(CAGEclusters)$clusterType <- factor(ifelse(strand(CAGEclusters)=="*",
                                              "enhancer", "TSS"),
                                              levels=c("TSS", "enhancer"))

# Find links
links <- findLinks(CAGEclusters,
                   inputAssay="counts",
                   directional="clusterType",
                   method="kendall")
#> Finding directional links from TSS to enhancer...
#> Calculating 789 pairwise correlations...
#> Preparing output...
#> # Link summary:
#> Number of links: 789
#> Summary of pairwise distance:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>       0    1138    3177    3944    6692    9961

# Only look at positive correlation
links <- subset(links, estimate > 0)
```

Then we can plot the links using arches, scaling the height of the arches according to p-values:

```
# Save as a track
all_tracks$links_track <- trackLinks(links,
                          name="TSS-enhancer",
                          col.interactions="black",
                          col.anchors.fill ="dimgray",
                          col.anchors.line = NA,
                          interaction.measure="p.value",
                          interaction.dimension.transform="log",
                          col.outside="grey")

# Plot region around
plotTracks(all_tracks,
           from=84255991-1000,
           to=84255991+1000,
           chromosome="chr18",
           sizes=c(1, 1, 1, 1, 2))
```

![](data:image/png;base64...)

In this case, the upstream enhancer has similar expression to two intronic TSSs, but not the annotated TSS.

## 6.5 Parallel execution

Currently, two functions can utilize multiple cores for computation, `quantifyCTSSs` and `findLinks`. The central one is `quantifyCTSSs`, which is usually the slowest and most memory consuming step of a `CAGEfightR` analysis. `quantifyCTSSs` automatically uses the default backend registered with the *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* package. This can be changed in the following way:

```
library(BiocParallel)

# Setup for parallel execution with 3 threads:
register(MulticoreParam(workers=3))

# Disable parallel execution
register(SerialParam())
```

# 7 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] Gviz_1.54.0
#>  [2] org.Mm.eg.db_3.22.0
#>  [3] InteractionSet_1.38.0
#>  [4] TxDb.Mmusculus.UCSC.mm9.knownGene_3.2.2
#>  [5] GenomicFeatures_1.62.0
#>  [6] AnnotationDbi_1.72.0
#>  [7] CAGEfightR_1.30.0
#>  [8] SummarizedExperiment_1.40.0
#>  [9] Biobase_2.70.0
#> [10] MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0
#> [12] rtracklayer_1.70.0
#> [13] GenomicRanges_1.62.0
#> [14] Seqinfo_1.0.0
#> [15] IRanges_2.44.0
#> [16] S4Vectors_0.48.0
#> [17] BiocGenerics_0.56.0
#> [18] generics_0.1.4
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3         rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0             magrittr_2.0.4
#>   [5] magick_2.9.0               farver_2.1.2
#>   [7] rmarkdown_2.30             BiocIO_1.20.0
#>   [9] vctrs_0.6.5                memoise_2.0.1
#>  [11] Rsamtools_2.26.0           RCurl_1.98-1.17
#>  [13] base64enc_0.1-3            tinytex_0.57
#>  [15] htmltools_0.5.8.1          S4Arrays_1.10.0
#>  [17] progress_1.2.3             curl_7.0.0
#>  [19] SparseArray_1.10.0         Formula_1.2-5
#>  [21] sass_0.4.10                bslib_0.9.0
#>  [23] htmlwidgets_1.6.4          httr2_1.2.1
#>  [25] cachem_1.1.0               GenomicAlignments_1.46.0
#>  [27] igraph_2.2.1               lifecycle_1.0.4
#>  [29] pkgconfig_2.0.3            Matrix_1.7-4
#>  [31] R6_2.6.1                   fastmap_1.2.0
#>  [33] digest_0.6.37              colorspace_2.1-2
#>  [35] lobstr_1.1.2               Hmisc_5.2-4
#>  [37] RSQLite_2.4.3              filelock_1.0.3
#>  [39] httr_1.4.7                 abind_1.4-8
#>  [41] compiler_4.5.1             bit64_4.6.0-1
#>  [43] htmlTable_2.4.3            S7_0.2.0
#>  [45] backports_1.5.0            BiocParallel_1.44.0
#>  [47] DBI_1.2.3                  biomaRt_2.66.0
#>  [49] rappdirs_0.3.3             DelayedArray_0.36.0
#>  [51] rjson_0.2.23               tools_4.5.1
#>  [53] foreign_0.8-90             nnet_7.3-20
#>  [55] glue_1.8.0                 restfulr_0.0.16
#>  [57] checkmate_2.3.3            cluster_2.1.8.1
#>  [59] gtable_0.3.6               BSgenome_1.78.0
#>  [61] ensembldb_2.34.0           data.table_1.17.8
#>  [63] hms_1.1.4                  XVector_0.50.0
#>  [65] pillar_1.11.1              stringr_1.5.2
#>  [67] dplyr_1.1.4                pryr_0.1.6
#>  [69] BiocFileCache_3.0.0        lattice_0.22-7
#>  [71] bit_4.6.0                  deldir_2.0-4
#>  [73] biovizBase_1.58.0          tidyselect_1.2.1
#>  [75] Biostrings_2.78.0          knitr_1.50
#>  [77] gridExtra_2.3              bookdown_0.45
#>  [79] ProtGenerics_1.42.0        xfun_0.53
#>  [81] stringi_1.8.7              UCSC.utils_1.6.0
#>  [83] lazyeval_0.2.2             yaml_2.3.10
#>  [85] evaluate_1.0.5             codetools_0.2-20
#>  [87] cigarillo_1.0.0            interp_1.1-6
#>  [89] GenomicFiles_1.46.0        tibble_3.3.0
#>  [91] BiocManager_1.30.26        cli_3.6.5
#>  [93] rpart_4.1.24               jquerylib_0.1.4
#>  [95] GenomicInteractions_1.44.0 dichromat_2.0-0.1
#>  [97] Rcpp_1.1.0                 GenomeInfoDb_1.46.0
#>  [99] dbplyr_2.5.1               png_0.1-8
#> [101] XML_3.99-0.19              parallel_4.5.1
#> [103] ggplot2_4.0.0              assertthat_0.2.1
#> [105] blob_1.2.4                 prettyunits_1.2.0
#> [107] latticeExtra_0.6-31        jpeg_0.1-11
#> [109] AnnotationFilter_1.34.0    bitops_1.0-9
#> [111] VariantAnnotation_1.56.0   scales_1.4.0
#> [113] crayon_1.5.3               rlang_1.1.6
#> [115] KEGGREST_1.50.0
```