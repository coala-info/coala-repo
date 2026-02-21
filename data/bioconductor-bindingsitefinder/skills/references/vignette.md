# Definition of binding sites from iCLIP signal

Mirko Brüggemann1 and Kathi Zarnack1

1Buchmann Institute for Molecular Life Sciences (BMLS), Frankfurt Germany

#### 29 October 2025

#### Abstract

Precise knowledge on the binding sites of an RNA-binding protein (RBP) is key to understand (post-) transcriptional regulatory processes. The package BindingSiteFinder provides all functionalities to define exact binding sites defined from iCLIP data. The following vignette describes the complete workflow.

#### Package

BindingSiteFinder 2.8.0

# 1 Preface

## 1.1 Motivation

Most cellular processes are regulated by RNA-binding proteins (RBPs). Knowledge on their exact positioning can be obtained from individual-nucleotide resolution UV crosslinking and immunoprecipitation (iCLIP) experiments. In a recent publication we described a complete analysis workflow to detect RBP binding sites from iCLIP data. The workflow covers all essential steps from quality control of sequencing reads, different peak calling options, to the downstream analysis and definition of binding sites. The pre-processing and peak calling steps rely on publicly available software, whereas the definition of the final binding sites follows a custom procedure implemented in BindingSiteFinder. This vignette explains how equally sized binding sites can be defined from a genome-wide iCLIP coverage.

## 1.2 Prerequisites

The workflow described herein is based on our recently published complete iCLIP analysis pipeline (Busch et al. [2020](#ref-busch2020)). Thus, we expect the user to have preprocessed their iCLIP sequencing reads up to the point of the peak calling step. In brief, this includes basic processing of the sequencing reads, such as quality filtering, barcode handling, mapping and the generation of a single nucleotide crosslink file for all replicates under consideration. As we describe in our manuscript, replicate .bam files may or may not be merged prior to peak calling, for which we suggest PureCLIP (Krakau, Richard, and Marsico [2017](#ref-Krakau2017)). For simplicity, we address only the case in which peak calling was performed on the merge of all replicates.

![](data:image/png;base64...)

**Overview of the preprocessing workflow**.

## 1.3 Installation

The *[BindingSiteFinder](https://bioconductor.org/packages/3.22/BindingSiteFinder)* package is available at <https://bioconductor.org> and can be installed via `BiocManager::install`:

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("BindingSiteFinder")
```

**Note:** If you use BindingSiteFinder in published research, please cite:

> Busch, A., Brüggemann, M., Ebersberger, S., & Zarnack, K. (2020) iCLIP data analysis: A complete pipeline from sequencing reads to RBP binding sites. *Methods*, 178, 49-62. <https://doi.org/10.1016/j.ymeth.2019.11.008>

# 2 Quick start

This part is for the impatient user that wants to start as fast as possible. For that reason this section contains only the most basic steps and function calls to get to the final binding site set. For more details on each step see the [Standard workflow](#%20Standard%20workflow) section.

## 2.1 A quick look at the input data

It all starts with your input iCLIP data, which has to be in form of a `BSFDataSet`. This data-structure combines crosslink sites (the output from *PureCLIP*) with the individual crosslinks per replicate (iCLIP coverage). Further instructions on the data-set constructions are given in the chapter [Construction of the BindingSiteFinder dataset](##%20Construction%20of%20the%20BindingSiteFinder%20dataset).

```
files <- system.file("extdata", package="BindingSiteFinder")
load(list.files(files, pattern = ".rda$", full.names = TRUE))
bds
```

```
## Dataset:  Test set
## Object of class BSFDataSet
## #N Ranges:  19,749
## Width ranges:  1
## #N Samples:  4
## #N Conditions:  1
```

To intersect binding sites with genomic features, such as genes and transcript regions the respective regions have to be presented as `GenomicRanges` objects. Further instructions on how to import annotations from various sources are given in chapter [Construct the annotation objects](##%20Construct%20the%20annotation%20objects).

```
load(list.files(files, pattern = ".rds$", full.names = TRUE)[1])
gns
```

```
## GRanges object with 1387 ranges and 3 metadata columns:
##                      seqnames            ranges strand |            gene_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSG00000008735.14    chr22 50600793-50613981      + | ENSG00000008735.14
##   ENSG00000015475.19    chr22 17734138-17774770      - | ENSG00000015475.19
##   ENSG00000025708.14    chr22 50525752-50530032      - | ENSG00000025708.14
##   ENSG00000025770.19    chr22 50508224-50524780      + | ENSG00000025770.19
##   ENSG00000040608.14    chr22 20241415-20283246      - | ENSG00000040608.14
##                  ...      ...               ...    ... .                ...
##    ENSG00000288106.1    chr22 38886837-38903794      + |  ENSG00000288106.1
##    ENSG00000288153.1    chr22 30664961-30674134      + |  ENSG00000288153.1
##    ENSG00000288262.1    chr22 11474744-11479643      + |  ENSG00000288262.1
##    ENSG00000288540.1    chr22 48320412-48333199      - |  ENSG00000288540.1
##    ENSG00000288683.1    chr22 18077989-18131720      + |  ENSG00000288683.1
##                                   gene_type   gene_name
##                                 <character> <character>
##   ENSG00000008735.14         protein_coding    MAPK8IP2
##   ENSG00000015475.19         protein_coding         BID
##   ENSG00000025708.14         protein_coding        TYMP
##   ENSG00000025770.19         protein_coding      NCAPH2
##   ENSG00000040608.14         protein_coding       RTN4R
##                  ...                    ...         ...
##    ENSG00000288106.1                 lncRNA  AL022318.5
##    ENSG00000288153.1 unprocessed_pseudogene  AC003072.2
##    ENSG00000288262.1 unprocessed_pseudogene  CT867976.1
##    ENSG00000288540.1                 lncRNA  AL008720.2
##    ENSG00000288683.1         protein_coding  AC016027.6
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
load(list.files(files, pattern = ".rds$", full.names = TRUE)[2])
regions
```

```
## GRangesList object of length 4:
## $CDS
## GRanges object with 17035 ranges and 4 metadata columns:
##     seqnames            ranges strand |    cds_id   exon_id   exon_name
##        <Rle>         <IRanges>  <Rle> | <integer> <integer> <character>
##        chr22 15528192-15529139      + |         1      <NA>        <NA>
##        chr22 15690078-15690314      + |         2      <NA>        <NA>
##        chr22 15690078-15690709      + |         3      <NA>        <NA>
##        chr22 15690246-15690709      + |         4      <NA>        <NA>
##        chr22 15690426-15690709      + |         5      <NA>        <NA>
##   .      ...               ...    ... .       ...       ...         ...
##        chr22 50782188-50782294      - |     17031      <NA>        <NA>
##        chr22 50782188-50782294      - |     17032      <NA>        <NA>
##        chr22 50782188-50782294      - |     17033      <NA>        <NA>
##        chr22 50782188-50782294      - |     17034      <NA>        <NA>
##        chr22 50782234-50782294      - |     17035      <NA>        <NA>
##     exon_rank
##     <integer>
##          <NA>
##          <NA>
##          <NA>
##          <NA>
##          <NA>
##   .       ...
##          <NA>
##          <NA>
##          <NA>
##          <NA>
##          <NA>
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## ...
## <3 more elements>
```

## 2.2 A quick way to define binding sites

The fastest way to accurately define binding site with very little manual intervention is running the wrapper function `BSFind()`. It will perform all necessary computations and will store all results and diagnostics internally. Various plotting functions can be used to make all sorts of diagnostics. Export functions can be used to extract resulting binding sites for further processing. Each step is covered in more detail in the [Standard workflow](#%20Standard%20workflow) section.

```
# run BSFind to compute binding sites
bdsQuick = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions, est.subsetChromosome = "chr22")
# export output as .bed
exportToBED(bdsQuick, con = "./myBindingSites.bed")
```

## 2.3 The quick picture, two figures for the lazy one

To get a fast glance at the data-set with minimal user intervention that is also visually appealing, the `quickFigure()` function exists.

```
# not run
quickFigure(bdsQuick, what = "main", save.filename = "./my_fig_main.pdf", save.device = "pdf")
```

![](data:image/png;base64...)

**Quick Figure - Main**.

```
# not run
quickFigure(bdsQuick, what = "supp", save.filename = "./my_fig_supp.pdf", save.device = "pdf")
```

![](data:image/png;base64...)

**Quick Figure - Supp**.

# 3 Standard workflow

We showcase the standard workflow on the example of the RNA-binding protein U2AF2. The data-set consists of four replicates. Sequencing reads from all replicates were pre-processed up to the point of .bam files. These were then merged and subjected to peak calling with *PureCLIP*. Resulting peaks as well as the processed coverage files (.bigwigs) are what is needed as input for the following sections.

## 3.1 Manage the input data

### 3.1.1 Build the BSFDataSet

To build the `BSFDataSet` one needs two types of information. First, the result of the peak calling step (crosslink sites) and second the iCLIP coverage in the form of .bigwig files for each replicate. Here we first import the crosslink sites to be represented as a `GenomicRanges` object. We also expect that all ranges are a single nucleotide wide111 Note: We remove the column `additionalScore` after the initial load, to clean our input.

```
# load crosslink sites
csFile <- system.file("extdata", "PureCLIP_crosslink_sites_examples.bed",
                      package="BindingSiteFinder")
cs = rtracklayer::import(con = csFile, format = "BED", extraCols=c("additionalScores" = "character"))
cs$additionalScores = NULL
cs
```

```
## GRanges object with 1000 ranges and 2 metadata columns:
##          seqnames    ranges strand |        name     score
##             <Rle> <IRanges>  <Rle> | <character> <numeric>
##      [1]     chr1    629906      + |           3  27.30000
##      [2]     chr1    629911      + |           3   1.72212
##      [3]     chr1    629912      + |           3  15.68900
##      [4]     chr1    629913      + |           3  13.82090
##      [5]     chr1    629915      + |           3   6.36911
##      ...      ...       ...    ... .         ...       ...
##    [996]     chr1   2396116      + |           3   7.74693
##    [997]     chr1   2396990      + |           3   3.92442
##    [998]     chr1   2396991      + |           3  14.52750
##    [999]     chr1   2396992      + |           3   6.59018
##   [1000]     chr1   2397001      + |           3   1.27159
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The .bigwig files with the coverage information are located in a single folder. The path is given in the `files` variable. We then use the path to list all .bigwig files from each strand separately.

```
# Load clip signal files and define meta data object
files <- system.file("extdata", package="BindingSiteFinder")
clipFilesP <- list.files(files, pattern = "plus.bw$", full.names = TRUE)
clipFilesM <- list.files(files, pattern = "minus.bw$", full.names = TRUE)
```

The strand specific vectors with the `path` information that point to each replicate .bigwig file are combined with additional meta information into a meta table `data.frame`. This `data.frame` has to have at minimum three columns, which must be named `condition`, `clPlus` and `clMinus`. The `clPlus` and `clMinus` columns point towards the strand-specific coverage for each replicate. This information will be imported as `Rle objects` upon object initialization.

```
# make the meta table
meta = data.frame(
  id = c(1:4),
  condition = factor(rep("WT", 4)),
  clPlus = clipFilesP, clMinus = clipFilesM)
meta
```

```
##   id condition
## 1  1        WT
## 2  2        WT
## 3  3        WT
## 4  4        WT
##                                                                            clPlus
## 1 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep1_clip_plus.bw
## 2 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep2_clip_plus.bw
## 3 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep3_clip_plus.bw
## 4 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep4_clip_plus.bw
##                                                                            clMinus
## 1 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep1_clip_minus.bw
## 2 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep2_clip_minus.bw
## 3 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep3_clip_minus.bw
## 4 /tmp/RtmpZs7Sji/Rinst34bb677e8c1301/BindingSiteFinder/extdata/rep4_clip_minus.bw
```

With the crosslink sites and the meta table ready we are good to construct the `BSFDataSet` object using the `BSFDataSetFromBigWig()` function. We can get information of the constructed object using it’s `show` method, which show the number of ranges and crosslinks present in the object222 Note: We load a previously compiled `BSFDataSet` to save disc space..

```
library(BindingSiteFinder)
bds = BSFDataSetFromBigWig(ranges = cs, meta = meta, silent = TRUE)
```

```
exampleFile <- list.files(files, pattern = ".rda$", full.names = TRUE)
load(exampleFile)
bds
```

```
## Dataset:  Test set
## Object of class BSFDataSet
## #N Ranges:  19,749
## Width ranges:  1
## #N Samples:  4
## #N Conditions:  1
```

```
# exampleFile <- list.files(files, pattern = ".rda$", full.names = TRUE)
# load(exampleFile)
```

## 3.2 Construct the annotation objects

To take advantage of the full functionality of the package one needs to provide gene annotation information. These will be used to map computed binding sites directly on target genes and and transcript regions of protein-coding genes. Here, we use [GENCODE](https://www.gencodegenes.org/) hg38 gene annotations.

### 3.2.1 Create annotation for genes

To present gene-level information we import the annotation as a .gff3 file into a `GenomicRanges` object. To combine the ranges with the available meta information for each gene (such as a `gene_id`, `gene_name` or `gene_type`), we have to read our annotation twice. First, we import the ranges into a `TxDB` database using functionalists from [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html). This database can be queried using the `genes()` function to retrieve the positions of all genes from our resource as `GRanges` objects333 Note: It is of particular importance that one uses a valid format for the *geneID* (ENSEMBL, UCSC, …) at this point.. Second we use `rtracklayer` to import all ranges with the corresponding meta information. We then match both imports to create a single `GRanges` object which contains all genes from our annotation with relevant meta information added444 Note: We again only load a previously compiled object at this point to save disc space..

```
library(txdbmaker)
# Make annotation database from gff3 file
annoFile = "./gencode_v37_annotation.gff3"

annoDb = txdbmaker::makeTxDbFromGFF(file = annoFile, format = "gff3")
annoInfo = rtracklayer::import(annoFile, format = "gff3")
# Get genes as GRanges
gns = genes(annoDb)
idx = match(gns$gene_id, annoInfo$gene_id)
meta = cbind(elementMetadata(gns),
             elementMetadata(annoInfo)[idx,])
meta = meta[,!duplicated(colnames(meta))]
elementMetadata(gns) = meta
```

```
# Load GRanges with genes
geneFile <- list.files(files, pattern = "gns.rds$", full.names = TRUE)
load(geneFile)
gns
```

```
## GRanges object with 1387 ranges and 3 metadata columns:
##                      seqnames            ranges strand |            gene_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSG00000008735.14    chr22 50600793-50613981      + | ENSG00000008735.14
##   ENSG00000015475.19    chr22 17734138-17774770      - | ENSG00000015475.19
##   ENSG00000025708.14    chr22 50525752-50530032      - | ENSG00000025708.14
##   ENSG00000025770.19    chr22 50508224-50524780      + | ENSG00000025770.19
##   ENSG00000040608.14    chr22 20241415-20283246      - | ENSG00000040608.14
##                  ...      ...               ...    ... .                ...
##    ENSG00000288106.1    chr22 38886837-38903794      + |  ENSG00000288106.1
##    ENSG00000288153.1    chr22 30664961-30674134      + |  ENSG00000288153.1
##    ENSG00000288262.1    chr22 11474744-11479643      + |  ENSG00000288262.1
##    ENSG00000288540.1    chr22 48320412-48333199      - |  ENSG00000288540.1
##    ENSG00000288683.1    chr22 18077989-18131720      + |  ENSG00000288683.1
##                                   gene_type   gene_name
##                                 <character> <character>
##   ENSG00000008735.14         protein_coding    MAPK8IP2
##   ENSG00000015475.19         protein_coding         BID
##   ENSG00000025708.14         protein_coding        TYMP
##   ENSG00000025770.19         protein_coding      NCAPH2
##   ENSG00000040608.14         protein_coding       RTN4R
##                  ...                    ...         ...
##    ENSG00000288106.1                 lncRNA  AL022318.5
##    ENSG00000288153.1 unprocessed_pseudogene  AC003072.2
##    ENSG00000288262.1 unprocessed_pseudogene  CT867976.1
##    ENSG00000288540.1                 lncRNA  AL008720.2
##    ENSG00000288683.1         protein_coding  AC016027.6
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 3.2.2 Create annotation for transcript regions

To represent all possible transcript regions, we re-use the previously created `TxDB` annotation database. The [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html) package provides dedicated information to retrieve specific sets of ranges from such a database object, like *CDS*, *UTRs*, etc. Here we store these ranges into a `GRangestList` and name the elements accordingly555 Note: Just like for the genes, we load a pre-compiled list to save disc space..

```
# Count the overlaps of each binding site for each region of the transcript.
cdseq = cds(annoDb)
intrns = unlist(intronsByTranscript(annoDb))
utrs3 = unlist(threeUTRsByTranscript(annoDb))
utrs5 = unlist(fiveUTRsByTranscript(annoDb))
regions = GRangesList(CDS = cdseq, Intron = intrns, UTR3 = utrs3, UTR5 = utrs5)
```

```
# Load list with transcript regions
regionFile <- list.files(files, pattern = "regions.rds$", full.names = TRUE)
load(regionFile)
```

## 3.3 Performing the main analysis

Now that we have prepared our input data, we are good to use the main workhorse, the `BSFind()` function. This function is essentially a high-level wrapper around all core utility functions and provides an easy entry point into the analysis. At it’s core each analysis step consists of a utility function that computes the respective result. Each utility function further comes along with a set of diagnostic/ result plotting functions. These can be used to assess the quality of every computational step. We recommend to once run the entire analysis with `BSFind()` and then follow up on each step in detail using the plot functionalities666 Note: Here we set `est.subsetChromosom='chr22'` because we have only signal on chromosome 22 to save disc space.

```
bdsOut = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions,
              est.subsetChromosome = "chr22", veryQuiet = TRUE, est.maxBsWidth = 29)
```

It is good practice to once visualize the entire binding site definition process after `BSFind()` was executed. This helps to keep track what steps were performed and how the flow into each other777 Note: Not all binding sites can be assigned to genes or transcript regions, in these cases NA is introduced, so no binding site is lost..

```
processingStepsFlowChart(bdsOut)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the BindingSiteFinder package.
##   Please report the issue at
##   <https://github.com/ZarnackGroup/BindingSiteFinder/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![processingStepsFlowChart](data:image/png;base64...)

Figure 1: processingStepsFlowChart

As a default all of the shown steps are executed sequentially in the given order. To change that order, each utility function can be called individually to set up a customized workflow (for details see [Construct your own pipeline](##%20Construct%20your%20own%20pipeline)).

### 3.3.1 Deciding on the binding site width

The first and main step of any binding site analysis is the actual binding site definition step. In the following we showcase how you can apply the main workflow functions to accurately define binding sites and judge the results.

#### 3.3.1.1 Pre-filtering of crosslink sites

An optional step prior to the actual merging of crosslink sites into binding sites is pre-filtering. Depending on the experiment type or sequencing depth, it might be useful to retain only the most informative crosslink sites. In the case of *PureCLIP*, the positions called as significantly enriched (hereafter called *PureCLIP sites*) are associated with a binding affinity strength score (hereafter called *PureCLIP score*) which can be used as a metric for the pre-filtering step. As default *PureCLIP* sites with the lowest 1% score will be removed.

```
pureClipGlobalFilterPlot(bdsOut)
```

![pureClipGlobalFilterPlot. The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability. The selected cutoff is indicated by the dashed line. ](data:image/png;base64...)

Figure 2: pureClipGlobalFilterPlot
The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability. The selected cutoff is indicated by the dashed line.

#### 3.3.1.2 Selection of the binding site width

In case the option `bsSize` is not set, the optimal binding site width is estimated from the data directly (using the `estimateBsWidth` function). Since the final binding site width depends on the quality of the input crosslink sites, `bsSize` is estimated together with the gene-wise filter level (`cutoff.geneWiseFilter`). That is filtering by the top X% crosslink sites per gene. Filtering on gene level has been shown to be really effective in diluting the most informative signal from the data888 Note: Since we did not specify `bsSize` in `BSFind()` the binding site size is estimated automatically..

```
estimateBsWidthPlot(bdsOut)
```

![estimateBsWidthPlot. The diagnostic show the ratio between the crosslink events within binding sites and the crosslink events in adjacent windows to the binding sites. This is effectively a 'percent-bound' type ratio, with the higher the better the associated binding site width captures the distribution of the underlying crosslink events. The plot shows how that ratio behaves for different binding site width under varying levels of the gene-wise filter.](data:image/png;base64...)

Figure 3: estimateBsWidthPlot
The diagnostic show the ratio between the crosslink events within binding sites and the crosslink events in adjacent windows to the binding sites. This is effectively a ‘percent-bound’ type ratio, with the higher the better the associated binding site width captures the distribution of the underlying crosslink events. The plot shows how that ratio behaves for different binding site width under varying levels of the gene-wise filter.

*Signal-to-flank* score values are estimated on all binding sites on a given chromosome (`est.bsResolution`) for varying levels of accuracy. For `est.geneResolution` options “coarse” results in 20% steps, “medium” in 10%, “fine” in 5% and “finest” in 1% steps. For `est.bsResolution` option “coarse” and “medium” approximate binding sites by extending the center of the each merged crosslink region. In “coarse” the center is found by the maximum PureCLIP score, in “medium” the center is found by the position with the most stacked crosslinks. Option “fine” employs a full binding site definition cycle. Binding sites are tested from the minimum size, which is 3, up to `maxBsWidth`.

After iterating over all sets given the above resolutions a mean score per binding site width is calculated and the binding site width that yielded the highest score is selected as optimal. The `est.minimumStepGain` option allows control over the minimum additional gain in the score that a tested width has to have to be selected as the best option (the default is 2% increase). This essentially lets binding site sizes to be computed more conservatively, opting for smaller binding sites rather than larger ones. This is particularly useful when the estimated mean score flattens out at a certain point showing only a very small increase in the score per binding site width increase. Samples with broad binding RBPs or samples with poor coverage tend to show this behavior.

In case you already know your binding site width and/or gene-wise filtering threshold you can invoke `BSFind()` with these parameters, to avoid the execution of the utility function `estimateBsWidth()`. For details see section [If you already know your binding site size](##%20If%20you%20already%20know%20your%20binding%20site%20size).

In case you want to manually investigate which binding site size to use see the section [How to manually test different binding site sizes](##%20How%20to%20manually%20test%20different%20binding%20site%20sizes).

#### 3.3.1.3 Apply the gene-wise filter

The gene-wise filter cutoff estimated in the previous step (`cutoff.geneWiseFilter`) is applied to keep only the top percent of crosslink sites, ranked by their *PureCLIP* score. In case the value for `cutoff.geneWiseFilter` was given directly without estimation, that value is used directly.

Such a filter essentially helps to improve the binding site quality by using only the defined subset per gene of all *PureCLIP* sites for the binding site definition. This is because the strength of a binding site is tied to the expression level of the hosting gene. Thus a gene-wise percentage filter will increase the quality on all hosting genes in the same order.

Since a single *PureCLIP* site might overlap with multiple different genes given in the annotation, a diagnostic function helps to visualize the magnitude of that problem.

```
duplicatedSitesPlot(bdsOut)
```

![duplicatedSitesPlot. Diagnostic plot that show how many crosslink sites overlap how many different genes in the annotation. The grey area for 2 and 3 overlaps indicates what proportion the option overlaps='keepSingle' removes in order to keep crosslink site numbers stable. ](data:image/png;base64...)

Figure 4: duplicatedSitesPlot
Diagnostic plot that show how many crosslink sites overlap how many different genes in the annotation. The grey area for 2 and 3 overlaps indicates what proportion the option overlaps=‘keepSingle’ removes in order to keep crosslink site numbers stable.

To handle such overlapping cases the `overlaps` parameter can be used with options `"keepSingle"`, `"removeAll"` and `"keepAll"`. We recommend to stick with the default (`overlaps="keepSingle"`), which reduces the number of crosslink sites on overlapping loci to a single instance. This will conserve the number of crosslink sites. The additional options `overlaps="removeAll"` and `overlaps="keepAll"` will either increase or decrease the number of crosslink sites in the set and should be handled with care.

#### 3.3.1.4 Merge crosslink sites into binding sites

In this step we turn the single-nucleotide wide PureCLIP sites into binding sites of a desired size (`bsSize`). This most essential parameter can either be estimated automatically, or be set directly. For the inexperienced user we recommend to use the estimated size in almost all cases. An exception would be very sparse or incomplete data, which should result in warning messages during the estimation step. If you do want to use a manual size, because you have eg. prior-knowledge of your RBP please have a look at the [If you already know your binding site size](##%20If%20you%20already%20know%20your%20binding%20site%20size) section first.

Binding site merging happens by concatenation of neighboring crosslink sites into larger regions. These regions are then split up again using the crosslink coverage to guide the position of the final binding sites. This process happens iteratively, where each merge and resize round resolves more regions unitl all regions are converted into binding sites. The following diagnostic plots the number of regions that are still left to be resolved after each round and compares it to the size of these regions999 Note: Since we use a very small data-set for demonstration purpose, this plot might look different with a real-sized data-set..

```
mergeCrosslinkDiagnosticsPlot(bdsOut)
```

![mergeCrosslinkDiagnosticsPlot. Diagnostic plot with number and region size at each fitting itteration loop. ](data:image/png;base64...)

Figure 5: mergeCrosslinkDiagnosticsPlot
Diagnostic plot with number and region size at each fitting itteration loop.

A variety of different filtering options for placing a final binding site inside a merged region exist. Most importantly `merge.minClSites` gives the minimum number of initial crosslink sites that have to overlap a final binding site. How this and all other options affect the final binding site set size is displayed by the following diagnostic.

```
makeBsSummaryPlot(bdsOut)
```

![makeBsSummaryPlot. Diagnostic bar chart indicating the number of binding site after each of the indicated filter options is applied given their input values.](data:image/png;base64...)

Figure 6: makeBsSummaryPlot
Diagnostic bar chart indicating the number of binding site after each of the indicated filter options is applied given their input values.

### 3.3.2 How to ensure reproducibility among replicates

Since the initially used crosslink sites are computed from the merged signal of all replicates, binding sites resulting from the previous merge might not be reproducible among all replicates. For that reason, we specifically ask in this section which of the computed binding sites are reproduced by the individual replicates.

#### 3.3.2.1 The replicate-specific threshold

Since replicates might differ in library size, a replicate-specific threshold is computed base on the binding site support distribution. That is how many crosslinks fall into the computed binding site for each replicate. In other words, we compute the number of crosslinks per binding site and replicate. This results in the following histogram.

When calling `BSFind()` we did not specify any further cutoff for this particular step, so the 5% quantile (`cutoff`) with a lower boundary of 1 crosslink (`minCrosslinks`) is used as default. Here for example a binding site would be called reproducible by replicate No.3 if at least 4 crosslinks from that replicate fall into the range of the binding site[^8].

[^8] Note: These settings can be adapted to for example produce high and low confidence binding site sets.

```
reproducibilityFilterPlot(bdsOut)
```

![reproducibilityFilterPlot. Reproducibility crosslink histogram, with the number of crosslink sites over the number of crosslinks per binding site for each replicate. The dashed line indicates the replicate-specific cutoff.](data:image/png;base64...)

Figure 7: reproducibilityFilterPlot
Reproducibility crosslink histogram, with the number of crosslink sites over the number of crosslinks per binding site for each replicate. The dashed line indicates the replicate-specific cutoff.

#### 3.3.2.2 How many replicates are enough?

After computing the replicate-specific thresholds as indicated above, one must decide on the number of replicates that must meet the thresholds for a binding site to be seen as reproducible.

A binding site that meets the threshold for all replicates in the set would be highly reproducible, whereas a binding site that meets the threshold for a single replicate only would be not reproducible at all. To find a balance in this question we suggest to stay with the default of N-1 for the `nReps` parameter. However if your replicates show a very high variability among each other changing this parameter could be beneficial to increase the specificity of the reproducible set. The following diagnostic assists in that decision, by visualizing the degree of which reproducible sets overlap among each other.

```
reproducibilitySamplesPlot(bdsOut)
```

![reproducibilitySamplesPlot. UpSet plot indicating the degree of reproducibility overlap between each replicate. ](data:image/png;base64...)

Figure 8: reproducibilitySamplesPlot
UpSet plot indicating the degree of reproducibility overlap between each replicate.

#### 3.3.2.3 Do my replicate corrlate well?

A common question for reproducibility is the visualization of the between replicate pairwise reproducibility. The following scatter plot does exactly that. Depending on when the correlations are calculated, the binding site set is either already corrected for reproducibility or not. To compare pairwise correlations before and after the application of the reproducibility filtering see [Reproducibility scatter before and after correction](##%20Reproducibility%20scatter%20before%20and%20after%20correction).

```
reproducibilityScatterPlot(bdsOut)
```

![reproducibilityScatterPlot. Bottom left) Pairwise correlations between all replicates as scatter. Upper right) Pairwise pearson correlation coefficient. Diagnoal) Coverage distribution as density.](data:image/png;base64...)

Figure 9: reproducibilityScatterPlot
Bottom left) Pairwise correlations between all replicates as scatter. Upper right) Pairwise pearson correlation coefficient. Diagnoal) Coverage distribution as density.

### 3.3.3 Genomic target identification

A major question the follow from binding site definition is the assessment of the genomic targets that the RBP under consideration binds to. In the following section we showcase how target genes and transcript regions can be identified and what one has to consider doing so. In case you don’t have a gene annotation at hand but still want to compute binding sites, have a look at the section [Work without a gene annotation](##%20Work%20without%20a%20gene%20annotation).

#### 3.3.3.1 Target gene identification

Here we essentially overlap the annotation given in `anno.genes` with the reproducible set of binding site computed above. Depending on the source and organism, gene annotations overlap each other to some degree.
We implemented several strategies to resolve these overlaps with `overlaps="frequency"` being the recommended default. Here the most frequently present *gene\_type* is used to resolve overlaps. This however requires that the annotated genes (given in `anno.genes`) carry gene type information as a meta column. The exact column name can be specified with `match.geneType`. The same requirement holds true for the option `overlaps="hierarchy"`, where a manual hierarchical rule on the gene type is used (`overlaps.rule` is required)101010 Note: If an overlaps exists, but gene types are identical options “frequency” and “hierarchy” will cause the gene that was seen first to be selected as representative. .
The following plot visualizes among which gene types the most overlaps exist111111 Note: Strategies that work without gene type information are `overlaps="remove"` and `overlaps="keep"` that respectively remove or keep all overlapping cases..

```
geneOverlapsPlot(bdsOut)
```

![geneOverlapsPlot. UpSet plot with the number of binding sites overlapping a specific gene type from the annotation before overlaps were resolved. ](data:image/png;base64...)

Figure 10: geneOverlapsPlot
UpSet plot with the number of binding sites overlapping a specific gene type from the annotation before overlaps were resolved.

The final target gene spectrum can now be visualized with the following plot. Depending on which of the overlap strategies are being used, numbers in this plot will change slightly.

```
targetGeneSpectrumPlot(bdsOut)
```

![targetGeneSpectrumPlot. Bar chart with the number of gene and binding sites of a given gene type after overlaps were resolved. ](data:image/png;base64...)

Figure 11: targetGeneSpectrumPlot
Bar chart with the number of gene and binding sites of a given gene type after overlaps were resolved.

The assigned gene with it’s ID, name and gene type (if given) is also attached to the binding site meta data, which can be retrieved as `GRanges` object using the `getRanges()` function.

#### 3.3.3.2 Transcript region identification

Similar to the target gene, each binding site can be assigned to a hosting transcript region. This is done using the `anno.transcriptRegionList` resource that we defined earlier. Essentially each binding site is overlapped with each of the ranges given in the region list. As one would expect, the problem of overlapping annotations is increased manifold on the level of transcript regions compared to entire genes.

Options to resolve these are similar to those on gene level. Option `overlaps="frequency"` will resolve based on the most frequently observed transcript region, `overlaps="hierarchy"` uses a manual hierarchic assignment based on `overlaps.rule`121212 Note: This time the transcript type is pulled from the names of the `GRangesList` defined in `anno.transcriptRegionList`. . Additionally, option `overlaps="flag"` will just flag all overlaps with the tag *ambiguous* and option `overlaps="remove"` will remove all those cases. The following plot illustrates the degree of overlap for our example data-set.

```
transcriptRegionOverlapsPlot(bdsOut)
```

![transcriptRegionOverlapsPlot. UpSet plot with the number of binding sites overlapping a specific transcript region from the annotation before overlaps were resolved.](data:image/png;base64...)

Figure 12: transcriptRegionOverlapsPlot
UpSet plot with the number of binding sites overlapping a specific transcript region from the annotation before overlaps were resolved.

We observe that most overlaps are generated by binding sites that are either within an intron or a 3’UTR. As indicated by the plot we use the default strategy `overlaps="frequency"` is used to resolve these cases. Since introns were most frequently observed in the data, the transcript region *intron* was selected in these cases.

The final binding spectrum on transcript region level can be visualized with the following plot. Depending on which of the overlap strategies are being used, numbers in this plot will change slightly.

```
transcriptRegionSpectrumPlot(bdsOut)
```

![transcriptRegionSpectrumPlot. Bar chart with the number of binding sites for each transcript region after overlaps were resolved. ](data:image/png;base64...)

Figure 13: transcriptRegionSpectrumPlot
Bar chart with the number of binding sites for each transcript region after overlaps were resolved.

The assigned transcript region is also attached to the binding site meta data, which can be retrieved as `GRanges` object using the `getRanges()` function.

If you want to learn about how to normalize these profiles by the length of each region see section [Normalize transcript regions](##%20Normalize%20transcript%20regions).

The described matching of binding sites and transcript regions is entirely based on overlaps with the regions given in `anno.transcriptRegionList`. This means one can customize these regions by using different sets of ranges to extend and modify this list. For further details on how to do this see section [Use a different set of transcript regions](##%20Use%20a%20different%20set%20of%20transcript%20regions).

### 3.3.4 Assessing further binding site properties

Another common task is to assess the strength and shape of a binding site. We provide two additional metrics as part of our core workflow that allow to assess exactly that.

#### 3.3.4.1 Binding site strength

The affinity of a binding site to the RNA is already given to some degree by *PureCLIP*. The *PureCLIP* model computes a strength score that captures affinity for each crosslink site. Here we re-map these scores from the initial crosslink sites to the final binding sites. This is done through the `match.score` argument that point to the meta column name with the score from the initial crosslink sites131313 Note: Essentially any numerical score can be transferred from the initial crosslinks to the final binding site using this option.. As for the default we assign the highest score from all overlapping crosslink site to the binding site (`match.option="max"`). The following plot shows the distribution of scores as density for all binding sites after re-assignment.

```
globalScorePlot(bdsOut)
```

![globalScorePlot. The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability.](data:image/png;base64...)

Figure 14: globalScorePlot
The diagnostic shows the distribution of PureCLIP scores on a log2 scale with a 10% step increased coloring for easier visualization and comparability.

#### 3.3.4.2 Binding site definedness

How well the defined binding sites fit to the observed crosslink coverage can be assess through binding site definedness. This also gives first insights into
the overall binding site shape and the binding mode of the RBP. Here we assess this property through a *percent bound* score, that divides the number of crosslinks inside the binding sites by the total number of crosslinks in a region around the binding site. As default, this background region is two times the size of the binding site. In other words, we compare the signal within a binding site to a same sized window directly flanking the binding site on both sides.
A splicing factor that recognizes very clear motifs will for example form very sharp peaks, which will lead to a high *percent bound* degree. A broad binding RBP on the other hand, that scans more along the RNA, will lead to a lower definedness score.

Depending on which steps were executed in the [Genomic target identification](###%20Genomic%20target%20identification) section, the plot can be grouped by the assignment (`by="all"`, `by="transcript_region"` or `by="gene_type"`).

```
bindingSiteDefinednessPlot(bdsOut, by = "transcript")
```

![bindingSiteDefinednessPlot. Density distribution of binding site definedness as percent bound grouped by transcript region.](data:image/png;base64...)

Figure 15: bindingSiteDefinednessPlot
Density distribution of binding site definedness as percent bound grouped by transcript region.

## 3.4 Exporting your results

For proper integration with any other downstream analysis and application we provide a set of export functionalities that allow to quickly and easily retrieve any type of result.

### 3.4.1 For additional analysis in R/Bioconductor

If one stays inside the R/ Bioconductor environment one can simply extract the final binding sites as `GenomicRanges`, which enables full functionality that comes with this powerful data class. As indicated by the print all information from each processing step is kept in the meta data of the granges object. This makes it easy to combine your analysis results with orthogonal data and projects.

```
getRanges(bdsOut)
```

```
## GRanges object with 2017 ranges and 9 metadata columns:
##        seqnames            ranges strand |        bsID    bsSize   currIdx
##           <Rle>         <IRanges>  <Rle> | <character> <numeric> <integer>
##      1    chr22 11630138-11630142      + |         BS1         5         1
##      2    chr22 11630413-11630417      + |         BS2         5         2
##      3    chr22 15785546-15785550      + |         BS3         5         3
##      4    chr22 15786268-15786272      + |         BS4         5         4
##      5    chr22 15786287-15786291      + |         BS5         5         5
##    ...      ...               ...    ... .         ...       ...       ...
##   2188    chr22 50626769-50626773      - |      BS2368         5      2013
##   2190    chr22 50769684-50769688      - |      BS2370         5      2014
##   2191    chr22 50776992-50776996      - |      BS2371         5      2015
##   2192    chr22 50777869-50777873      - |      BS2372         5      2016
##   2193    chr22 50783298-50783302      - |      BS2373         5      2017
##                    geneID    geneName       geneType transcriptRegion     score
##               <character> <character>    <character>      <character> <numeric>
##      1               <NA>        <NA>     Intergenic            OTHER  334.1870
##      2               <NA>        <NA>     Intergenic            OTHER   77.5833
##      3 ENSG00000206195.11      DUXAP8         lncRNA           INTRON   15.2087
##      4 ENSG00000206195.11      DUXAP8         lncRNA           INTRON   16.5390
##      5 ENSG00000206195.11      DUXAP8         lncRNA           INTRON   13.8455
##    ...                ...         ...            ...              ...       ...
##   2188 ENSG00000100299.18        ARSA protein_coding           INTRON   37.1189
##   2190 ENSG00000079974.18      RABL2B protein_coding           INTRON   20.3594
##   2191 ENSG00000079974.18      RABL2B protein_coding           INTRON   37.5507
##   2192 ENSG00000079974.18      RABL2B protein_coding           INTRON   22.7803
##   2193 ENSG00000079974.18      RABL2B protein_coding           INTRON   16.2296
##        signalToFlankRatio
##                 <numeric>
##      1           0.891358
##      2           0.826923
##      3           0.612903
##      4           0.781250
##      5           0.372881
##    ...                ...
##   2188           0.885714
##   2190           0.892857
##   2191           0.636364
##   2192           0.810811
##   2193           0.814815
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 3.4.2 Export as UCSC BED

For visual inspection and integration with further data-sets results can be easily exported in the widely used .bed format. This offers a quick way for manual inspection of the resulting binding sites in tools like IGV or UCSC genome browser.

```
exportToBED(bdsOut, con = "./myResults.bed")
```

### 3.4.3 Export genes and feature lists

Gene targets from the target gene assignment can be exported to either `csv` or `xslx` grouped by `geneType` or `transcriptRegion`. Genes can additionally be sorted by the number of overlapping binding sites or by binding site strength score.

```
exportTargetGenes(bdsOut, format = "xslx", split = "transcriptRegion")
```

### 3.4.4 Export iCLIP signal

To export iCLIP coverage directly we do not provide a dedicated function, but rather we use the `export` function from the [rtracklayer](https://www.bioconductor.org/packages/release/bioc/html/rtracklayer.html) package. For details see the section [Exporting iCLIP signal](##%20Exporting%20iCLIP%20signal).

# 4 Diagnostic coverage polots

The analysis workflow described in the [Standard workflow](#%20Standard%20workflow) section contains all steps for a comprehensive transcriptome-wide binding site analysis. However in some instances it might be useful to drill these analysis down to specific binding sites. In the following chapter we provide some useful ideas and functions when this could be useful and what type of questions could be addressed.

## 4.1 Visualize the iCLIP coverage

To visualize the iCLIP signal (aka coverage) on a specific binding site, we provide the `bindingSiteCoveragePlot()` function. It takes a reference index for the binding site and then plots the coverage as bars in a defined range around a selected binding site. The function is based on the [Gviz](http://bioconductor.org/packages/release/bioc/html/Gviz.html) package. The `plotIdx` indicates which range should be used as center, the `flankPos` parameter allows to zoom in and out. In addition to the selected range, also all other ranges which fall into the selected window will be shown.

To specifically assess for example the reproducibility on a particular binding site, one could plot the coverage from each replicate on that site. The plot below shows the coverage from each replicate on an exemplaric binding site.

```
bindingSiteCoveragePlot(bdsOut, plotIdx = 8, flankPos = 100, autoscale = TRUE)
```

![bindingSiteCoveragePlot. Coverage plot on replicate level.](data:image/png;base64...)

Figure 16: bindingSiteCoveragePlot
Coverage plot on replicate level.

Sometimes it can also be useful to merge all replicates into a single combined coverage. This can be done by setting `mergeReplicates=TRUE`.

## 4.2 Trace back a binding site

A common case that makes use of this function is when one wants to see why a particular binding site is lost after a certain filtering step. Here, we look at a binding site that was filtered out from the final object by the reproducibility filter. Doing so, we can visually confirm that binding sites 5 and 6 were correctly removed by the reproducibility filter function.

```
rangesBeforeRepFilter = getRanges(bds)
rangesAfterRepFilter = getRanges(bdsOut)
idx = which(!match(rangesBeforeRepFilter, rangesAfterRepFilter, nomatch = 0) > 0)
rangesRemovedByFilter = rangesBeforeRepFilter[idx]
bdsRemovedRanges = setRanges(bds, rangesRemovedByFilter)

bindingSiteCoveragePlot(bdsRemovedRanges, plotIdx = 2, flankPos = 50)
```

![](data:image/png;base64...)

We could also look at the final binding site definition and see how they were derived from the initial *PureCLIP sites*. To achieve this, we make use of the `customRange` slot to add these sites at the bottom of the coverage plot.

```
pSites = getRanges(bds)
bindingSiteCoveragePlot(bdsOut, plotIdx = 8, flankPos = 20, autoscale = TRUE,
                        customRange = pSites, customRange.name = "pSites", shiftPos = -10)
```

## 4.3 Gene wise coverage

Another use case would be to check the coverage on some example genes, or as we do here on the binding site with the highest number of crosslinks:

```
bindingSiteCoverage = coverageOverRanges(bdsOut, returnOptions = "merge_positions_keep_replicates")
idxMaxCountsBs = which.max(rowSums(as.data.frame(mcols(bindingSiteCoverage))))
bindingSiteCoveragePlot(bdsOut, plotIdx = idxMaxCountsBs, flankPos = 100, mergeReplicates = FALSE, shiftPos = 50)
```

It is also possible to anchor the plot on any other `GenomicRange`. Here, we take annotated CDS regions and ask for the one with the most overlapping binding sites. We then use this ranges as center for the plot and further zoom in to a particular range. We then make use of the `customRange` slot to re-include the binding site ranges as additional annotation shown underneath the signal. Additionally, one could also add a custom annotation track in the form of a `GenomicRanges` or `TxDB` object.

```
bdsCDS = setRanges(bdsOut, regions$CDS)
cdsWithMostBs = which.max(countOverlaps(regions$CDS, getRanges(bdsOut)))

bindingSiteCoveragePlot(bdsCDS, plotIdx = cdsWithMostBs, showCentralRange = FALSE,
                       flankPos = 250, shiftPos = 50, mergeReplicates = TRUE,
                       highlight = FALSE, customRange = getRanges(bdsOut),
                       customAnnotation = regions$CDS)
```

# 5 Variations of the standard workflow

## 5.1 Normalize transcript regions

When assessing the number of binding sites per transcript region, it is common sense that more binding sites will map to *intron* as appose to for example *5’UTRs* due to the size difference of these regions. Here we describe how one can be used to normalize for this effect.

The normalization scheme we provide is based on the hosting region length of each binding site. That means the number of binding sites per region can be divided by either the sum, mean or median of the hosting region length from all binding sites (see `normalize.factor` when using `transcriptRegionSpectrumPlot()`). To avoid biases by very short or long transcript regions an upper and lower boundary can be set (see `normalize.exclude.upper` and `normalize.exclude.lower` when using `assignToTranscriptRegions()`).

Here we show the transcript region spectrum on a percentage scale once normalized and once un-normalized.

```
transcriptRegionSpectrumPlot(bdsOut, normalize = FALSE, values = "percentage")
```

```
transcriptRegionSpectrumPlot(bdsOut, normalize = TRUE, values = "percentage", normalize.factor = "median")
```

## 5.2 How to manually test different binding site sizes

In some instances the `estimateBsWidth()` function used in the `BSFind()` wrapper might not lead to optimal results. This can be the case if the starting data is of below average quality with very few crosslink sites to begin with. Here manual binding site profiling can be used to achieve the best possible result given the input data.

To guide the choice of a good width, we recommend to explicitly compute binding sites for a variety of width. Here we selected 3, 7, 19 and 29nt and manually execute `makeBindingSites()`141414 Note: Notice that we do not subset on a specific chromosome, but rather include all ranges to avoid any local pitfalls. .

```
# compute binding sites
bds1 <- makeBindingSites(object = bds, bsSize = 3)
bds2 <- makeBindingSites(object = bds, bsSize = 9)
bds3 <- makeBindingSites(object = bds, bsSize = 19)
bds4 <- makeBindingSites(object = bds, bsSize = 29)
# summarize in list
l = list(`1. bsSize = 3` = bds1, `2. bsSize = 9` = bds2,
         `3. bsSize = 19` = bds3, `4. bsSize = 29` = bds4)
```

The combined coverage over these different binding sites can help to quickly judge if the selected size does fit the data appropriately (`rangeCoveragePlot()`). Here, each plot is centered around the binding site’s midpoint and the computed width is indicated by the gray frame.

```
rangeCoveragePlot(l, width = 20, show.samples = TRUE, subset.chromosome = "chr22")
```

![rangeCoveragePlot. Crosslink coverage summarized at potential binding sites, with current size given by the grey area.](data:image/png;base64...)

Figure 17: rangeCoveragePlot
Crosslink coverage summarized at potential binding sites, with current size given by the grey area.

In our example, size = 3 appears too small, since not all of the relevant peak signal seems to be captured. On the contrary, size = 29 appears extremely large. Here, we decided for size = 9 because it seems to capture the central coverage peak best.

## 5.3 If you already know your binding site size

In case you already know what binding site size you want to use `BSFind()` can be called directly with that input size. This is usually the case if one has prior knowledge from orthogonal experiments or if the present data-set should be fix to the same size as another data-set for comparison. With a fixed binding site at hand we can call `BSFind()` with that explicit size to avoid estimation and use our manual input instead151515 Note: We also set `cutoff.geneWiseFilter=0` to turn off gene-wise filtering..

```
bdsManual = BSFind(object = bds, anno.genes = gns, anno.transcriptRegionList = regions, bsSize = 9, cutoff.geneWiseFilter = 0)
```

If you are not sure how to choose an appropriate binding site size for your data-set, see [Standard workflow](#%20Standard%20workflow) which makes use of the `estimateBsWidth()` function, or see the chapter [How to manually test different binding site sizes](##%20How%20to%20manually%20test%20different%20binding%20site%20sizes), to manually select a size value.

## 5.4 Call utility functions seperately

In the case on does not want to work with `BSFind()` as main wrapper function, all core utility function can be called separately. In our example from above where we manually decided on a binding site width of 9nt we could also call `makeBindingSites()` directly. This avoids turning off certain default options and will result in the most basic result possible, a simple set of merged binding site.

```
bdsSimple = makeBindingSites(object = bds, bsSize = 9)
```

## 5.5 Construct your own pipeline

If one is using more than one utility function with some pre-defined input options it is recommended to construct a small custom pipeline. This greatly increase readability and reproducibility of the code. Here we extend our binding site merging to 9nt from above by a pre-filter and add another layer of post-processing to it.

```
customBSFind <- function(object) {
    this.obj = pureClipGlobalFilter(object)
    this.obj = makeBindingSites(this.obj, bsSize = 9)
    this.obj = calculateSignalToFlankScore(this.obj)
    return(this.obj)
}
bdsSimple = customBSFind(bds)
```

Processing steps in custom pipelines can also be visualized with the flow chart function.

## 5.6 Work without a gene annotation

Setting up a custom pipeline can also be needed when one does not have any supporting gene annotation at hand. In those cases a simplified workflow pipeline can be defined that still allows binding site definition. To achieve this we simply combine all processing functions that do not require an explicit annotation into a new reduced wrapper161616 Note: We highly recommend using an adequate gene annotation since it improves the quality of the analysis..

```
noAnnotationBSFind <- function(object) {
    this.obj = pureClipGlobalFilter(object)
    this.obj = makeBindingSites(this.obj, bsSize = 9)
    this.obj = reproducibilityFilter(this.obj)
    this.obj = annotateWithScore(this.obj, getRanges(object))
    this.obj = calculateSignalToFlankScore(this.obj)
    return(this.obj)
}
bdsSimple = noAnnotationBSFind(bds)
```

Since no gene or transcript level assignment was performed (`assignToGenes()` and `assignToTranscriptRegions()` was not run), the related diagnostic plots are not available. Yet the diagnostics for the functions we have called in `noAnnotationBSFind()` can be used to assess the performance of our analysis.

## 5.7 Reproducibility scatter before and after correction

In order to visualize how the reproducibility filtering function improves pairwise replicate reproducibility, the `reproducibilityScatterPlot()` function can be called before and after reproducibility filtering.

```
bds.before = makeBindingSites(bds, bsSize = 9)
reproducibilityScatterPlot(bds.before)
```

```
bds.after = reproducibilityFilter(bds.before, minCrosslinks = 2)
reproducibilityScatterPlot(bds.after)
```

## 5.8 Use a different set of transcript regions

When assigning binding sites to transcript regions, the `assignToTranscriptRegions()` utility function takes the annotation ranges as a `GRangesList` input. Then binding sites are simply assigned to each list entry using the respective list name. This fact can be exploited to essentially use any kind of range set as input to assign binding site to any custom set of genomic ranges, while handling overlaps as it is described in `assignToTranscriptRegions()`.

# 6 Additional functions

Besides the standard workflow and main processing functions a variety of further useful functions that come in handy when working with iCLIP data are provided to the user. In the following sections we demonstrate some these functionalities.

## 6.1 Subset data for faster iterations

Sub-setting a `BSFinderData` object can be useful in a variety of cases, e.g. for reducing the object size for faster parameter testing, limiting the analysis to some candidate genes etc. Here, we subset the object by a random set of 100 binding sites and plot their count distribution.

```
set.seed(1234)
bdsSub = bds[sample(seq_along(getRanges(bds)), 100, replace = FALSE)]

cov = coverageOverRanges(bdsSub, returnOptions = "merge_positions_keep_replicates")
df = mcols(cov) %>%
    as.data.frame() %>%
    pivot_longer(everything())

ggplot(df, aes(x = name, y = log2(value+1), fill = name)) +
    geom_violin() +
    geom_boxplot(width = 0.1, fill = "white") +
    scale_fill_brewer(palette = "Greys") +
    theme_bw() +
    theme(legend.position = "none") +
    labs(x = "Samples", y = "#Crosslinks (log2)")
```

## 6.2 Merge replicate signal

Depending on the task at hand, one either wants to keep the iCLIP signal separated by replicates or merge the signal over the replicates (e.g. of the same condition). Merging signal can be done using the `collapseReplicates()` function. Doing so allows for example to identify the proportion of crosslink events that each sample contributes to the total of a binding site. Here, we did this for the first 100 binding sites. We sort all binding sites by their fraction and color the plot based on the replicate.

```
bdsMerge = collapseReplicates(bds)[1:100]
covTotal = coverageOverRanges(bdsMerge, returnOptions = "merge_positions_keep_replicates")

covRep = coverageOverRanges(bds[1:100], returnOptions = "merge_positions_keep_replicates")

df = cbind.data.frame(mcols(covTotal), mcols(covRep)) %>%
    mutate(rep1 = round(`1_WT`/ WT, digits = 2) * 100,
           rep2 = round(`2_WT`/ WT, digits = 2) * 100,
           rep3 = round(`3_WT`/ WT, digits = 2) * 100,
           rep4 = round(`4_WT`/ WT, digits = 2) * 100) %>%
    tibble::rowid_to_column("BsID") %>%
    dplyr::select(BsID, rep1, rep2, rep3, rep4) %>%
    pivot_longer(-BsID) %>%
    group_by(BsID) %>%
    arrange(desc(value), .by_group = TRUE) %>%
    mutate(name = factor(name, levels = name)) %>%
    group_by(name) %>%
    arrange(desc(value), .by_group = TRUE) %>%
    mutate(BsID = factor(BsID, levels = BsID))

ggplot(df, aes(x = BsID, y = value, fill = name)) +
    geom_col(position = "fill", width = 1) +
    theme_bw() +
    scale_fill_brewer(palette = "Set3") +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 7)) +
    labs(x = "Binding site ID",
         y = "Percentage",
         fill = "Replicate"
         ) +
    scale_y_continuous(labels = scales::percent)
```

## 6.3 Exporting iCLIP signal

Similar to exporting the binding sites as *BED* file for external visualization, one can do the same with the iCLIP signal itself. Here we use the `export` function from the [rtracklayer](https://www.bioconductor.org/packages/release/bioc/html/rtracklayer.html) package. We could now first merge the signal from all replicates into a single combined signal. This signal can then be exported to *.bigwig* format for easy visualization in IGV or th UCSC genome browser.

```
sgn = getSignal(bds)
export(sgn$signalPlus$`1_WT`, con = "./WT_1_plus.bw", format = "bigwig")
export(sgn$signalMinus$`1_WT`, con = "./WT_1_minus.bw", format = "bigwig")
```

```
bdsMerge = collapseReplicates(bds)
sgn = getSignal(bdsMerge)
export(sgn$signalPlus$WT, con = "./sgn_plus.bw", format = "bigwig")
export(sgn$signalPlus$WT, con = "./sgn_minus.bw", format = "bigwig")
```

## 6.4 Calculate coverage

Each `BSFDataSet` contains the binding sites as ranges as well as the individual crosslinks per sample. With the `clipCoverage()` function one can easily compute all sorts of coverage over these ranges.

In the purest form this would result in a matrix with the number of columns being equal to the number of nucleotides in the binding sites (`bsSize`) and the number of rows being equal to the number of binding sites. If this matrix is computed for all samples the result is a list of matrices with the described dimensions.

To simplify this output three parameter options exist to merge either of the three dimensions (`samples.merge`, `positions.merge`, `ranges.merge`). Merging samples will combine the coverage signal from individual samples171717 Notes: Samples can also be combined by condition if multiple conditions are present.. Merging positions combine all single nucleotide positions of the binding sites into a single value. Merging ranges will combine all ranges. For each merging operation one can choose between using the `sum` or `mean`. Depending on the shape of the result it can either be attached to the ranges present in the `BSFDataSet` which results in a `granges` type of output, or it can be returned as a `data.frame`.

```
cov = clipCoverage(bdsOut, ranges.merge = TRUE, samples.merge = FALSE, positions.merge = FALSE)
cov
```

```
## GRanges object with 2017 ranges and 13 metadata columns:
##          seqnames            ranges strand |        bsID    bsSize   currIdx
##             <Rle>         <IRanges>  <Rle> | <character> <numeric> <integer>
##      BS1    chr22 11630138-11630142      + |         BS1         5         1
##      BS2    chr22 11630413-11630417      + |         BS2         5         2
##      BS3    chr22 15785546-15785550      + |         BS3         5         3
##      BS4    chr22 15786268-15786272      + |         BS4         5         4
##      BS5    chr22 15786287-15786291      + |         BS5         5         5
##      ...      ...               ...    ... .         ...       ...       ...
##   BS2368    chr22 50626769-50626773      - |      BS2368         5      2013
##   BS2370    chr22 50769684-50769688      - |      BS2370         5      2014
##   BS2371    chr22 50776992-50776996      - |      BS2371         5      2015
##   BS2372    chr22 50777869-50777873      - |      BS2372         5      2016
##   BS2373    chr22 50783298-50783302      - |      BS2373         5      2017
##                      geneID    geneName       geneType transcriptRegion
##                 <character> <character>    <character>      <character>
##      BS1               <NA>        <NA>     Intergenic            OTHER
##      BS2               <NA>        <NA>     Intergenic            OTHER
##      BS3 ENSG00000206195.11      DUXAP8         lncRNA           INTRON
##      BS4 ENSG00000206195.11      DUXAP8         lncRNA           INTRON
##      BS5 ENSG00000206195.11      DUXAP8         lncRNA           INTRON
##      ...                ...         ...            ...              ...
##   BS2368 ENSG00000100299.18        ARSA protein_coding           INTRON
##   BS2370 ENSG00000079974.18      RABL2B protein_coding           INTRON
##   BS2371 ENSG00000079974.18      RABL2B protein_coding           INTRON
##   BS2372 ENSG00000079974.18      RABL2B protein_coding           INTRON
##   BS2373 ENSG00000079974.18      RABL2B protein_coding           INTRON
##              score signalToFlankRatio      1_WT      2_WT      3_WT      4_WT
##          <numeric>          <numeric> <numeric> <numeric> <numeric> <numeric>
##      BS1  334.1870           0.891358        55        98       132        76
##      BS2   77.5833           0.826923        11        21        39        15
##      BS3   15.2087           0.612903         0         6         8         5
##      BS4   16.5390           0.781250         3         9        12         1
##      BS5   13.8455           0.372881         1         5        14         2
##      ...       ...                ...       ...       ...       ...       ...
##   BS2368   37.1189           0.885714         3         7        17         4
##   BS2370   20.3594           0.892857         2         9        12         2
##   BS2371   37.5507           0.636364         2         9         9         8
##   BS2372   22.7803           0.810811         4         8        13         5
##   BS2373   16.2296           0.814815         4         5         8         5
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Here we added the number of crosslinks per binding site and replicate to the `granges` object of the binding sites.

# 7 Differential binding analysis

In this section we go beyond basic binding site definition and demonstrate how binding sites of a given RBP can be compared between conditions. For example one might be interested in how the binding pattern on of an RBP changes upon a specific mutation or condition.

Comparing two sets of binding sites from different biological conditions to each other is not straight forward, since a change observed between any two binding sites can also be caused by expression level changes of the hosting transcript. For that reason the following computational approach will correct for this effect resulting in a log2 fold-change for each binding site that is corrected for a potential transcript expression level change.

## 7.1 Concept and idea

The main idea of the approach is to divide given iCLIP crosslinks into two bins for each gene. The first bin holds all crosslinks that are overlapping defined binding sites and thus can be attributed to the binding affinity of the RBP. We call this bin the *binding-bin*. The second bin holds all other crosslinks, which can be attributed to the expression level of the hosting RNA. We call this bin the *background-bin*.

We now make use of the condition specific changes in the *background-bin* to correct all fold-changes for each binding site in the *binding-bin*. This is done using the `DESeq2` likelihood ratio test, by comparing a “full” model to a reduced “null” model.

![](data:image/png;base64...)

**Overview of differential binding model and workflow.**

## 7.2 Preparation of the input data

In the most basic approach one wants to compute fold-changes for each binding site for the same RBP found in of two conditions. For the following example we name our conditions *WT* and *KO*.

### 7.2.1 Define binding sites for each condition

At first binding sites have to be defined for each condition separately. This ensures that regardless of sequencing depth or expression levels not binding site can be missed or masked by either condition.181818 Note: This requires that both data sets need to be handled strict separately, from pre-processing to peak-calling and binding site definition.

Here we load two pre-computed data sets, each having two replicates for *WT* and two for the *KO*.191919 Note: Both data-sets were artificially created from the same condition for demonstration purposes. To learn how these sets can be generated from two individual data set, see the [Starting from scratch](###%20Starting%20from%20scratch) section.

```
# make artifical data sets
myDataSets = makeExampleDataSets()

bds.wt = myDataSets$wt
bds.ko = myDataSets$ko

bds.wt
```

```
## Dataset:  Example.WT
## Object of class BSFDataSet
## #N Ranges:  2,522
## Width ranges:  5
## #N Samples:  2
## #N Conditions:  2
```

```
bds.ko
```

```
## Dataset:  Example.KO
## Object of class BSFDataSet
## #N Ranges:  2,554
## Width ranges:  5
## #N Samples:  2
## #N Conditions:  2
```

### 7.2.2 Merge binding sites into a single object for testing

We follow up on the separate binding site definition by combining both binding site sets into a single set on which we then perform the differential binding testing. Merging two `BSFDataSets` can be done using the `+` operator as shown below or by using the `combineBSF()` function.

```
bds.comb = bds.wt + bds.ko
getRanges(bds.comb)
```

```
## GRanges object with 5076 ranges and 6 metadata columns:
##        seqnames            ranges strand |        bsID    bsSize
##           <Rle>         <IRanges>  <Rle> | <character> <integer>
##      1    chr22 11630138-11630142      + |         BS1         5
##      2    chr22 11630413-11630417      + |         BS2         5
##      3    chr22 15785523-15785527      + |         BS3         5
##      4    chr22 15785540-15785544      + |         BS4         5
##      5    chr22 15785546-15785550      + |         BS5         5
##    ...      ...               ...    ... .         ...       ...
##   5072    chr22 50776987-50776991      - |      BS5072         5
##   5073    chr22 50776992-50776996      - |      BS5073         5
##   5074    chr22 50777821-50777825      - |      BS5074         5
##   5075    chr22 50777869-50777873      - |      BS5075         5
##   5076    chr22 50783298-50783302      - |      BS5076         5
##                    geneID    geneName       geneType     dataset
##               <character> <character>    <character> <character>
##      1               <NA>        <NA>     Intergenic  Example.KO
##      2               <NA>        <NA>     Intergenic  Example.KO
##      3 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      4 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      5 ENSG00000206195.11      DUXAP8         lncRNA  Example.WT
##    ...                ...         ...            ...         ...
##   5072 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   5073 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   5074 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##   5075 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   5076 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 7.3 Count matrix generation

To perform the differential testing we first need to extract crosslink counts for each binding site and *background-bin* per gene. It is all crosslinks that are attributed for the *background-bin* that are used for the expression change correction. This makes the differentiation of the iCLIP signal in *binding-bin* and *background-bin* one of the must critical steps.

To fine-tune this step a variety of options exist. First each binding site can be extend by an *offset* region. All crosslinks overlapping the *offset* will be removed. This means they are not counted towards the *background-bin* or the *binding-bin*. The same holds true for the *blacklist-region* which is an additional container which can be used to remove counts from certain ranges from the *background-bin*202020 Note: The background counts per replicate is identical for binding sites on the same hosting gene..

![](data:image/png;base64...)

**Background-bin generation options.**

### 7.3.1 Calculate binding sites and background counts

Calculating the background counts requires a gene annotation information to be present in the form of a `GRanges` object. For more details on how to generate this object from a .gtf/.gff3 file please see the section [Create annotation for genes](###%20Create%20annotation%20for%20genes). The final counts are added to the meta columns of the binding site `GRanges` objects.212121 Note: Binding sites that do not overlap a distinct gene may end with NA values as background counts and can be removed in the next step.

```
bds.diff = calculateBsBackground(bds.comb, anno.genes = gns)
getRanges(bds.diff)
```

```
## GRanges object with 4961 ranges and 14 metadata columns:
##          seqnames            ranges strand |        bsID    bsSize
##             <Rle>         <IRanges>  <Rle> | <character> <integer>
##      BS3    chr22 15785523-15785527      + |         BS3         5
##      BS4    chr22 15785540-15785544      + |         BS4         5
##      BS5    chr22 15785546-15785550      + |         BS5         5
##      BS6    chr22 15785946-15785950      + |         BS6         5
##      BS7    chr22 15785962-15785966      + |         BS7         5
##      ...      ...               ...    ... .         ...       ...
##   BS5072    chr22 50776987-50776991      - |      BS5072         5
##   BS5073    chr22 50776992-50776996      - |      BS5073         5
##   BS5074    chr22 50777821-50777825      - |      BS5074         5
##   BS5075    chr22 50777869-50777873      - |      BS5075         5
##   BS5076    chr22 50783298-50783302      - |      BS5076         5
##                      geneID    geneName       geneType     dataset
##                 <character> <character>    <character> <character>
##      BS3 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS4 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS5 ENSG00000206195.11      DUXAP8         lncRNA  Example.WT
##      BS6 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS7 ENSG00000206195.11      DUXAP8         lncRNA  Example.WT
##      ...                ...         ...            ...         ...
##   BS5072 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5073 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5074 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##   BS5075 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5076 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##          counts.bs.1_WT counts.bs.2_WT counts.bs.3_KO counts.bs.4_KO
##               <numeric>      <numeric>      <numeric>      <numeric>
##      BS3              2              5              6              2
##      BS4              3              1              6              2
##      BS5              0              6              8              5
##      BS6              1              1              5              0
##      BS7              0              2              8              1
##      ...            ...            ...            ...            ...
##   BS5072              0              1              7              1
##   BS5073              2              9              9              8
##   BS5074              2              2              5              3
##   BS5075              4              8             13              5
##   BS5076              4              5              8              5
##          counts.bg.1_WT counts.bg.2_WT counts.bg.3_KO counts.bg.4_KO
##               <numeric>      <numeric>      <numeric>      <numeric>
##      BS3             11             71             74             22
##      BS4             11             71             74             22
##      BS5             11             71             74             22
##      BS6             11             71             74             22
##      BS7             11             71             74             22
##      ...            ...            ...            ...            ...
##   BS5072             11             46             71             27
##   BS5073             11             46             71             27
##   BS5074             11             46             71             27
##   BS5075             11             46             71             27
##   BS5076             11             46             71             27
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 7.3.2 Filter binding site and background counts

Depending on the crosslink signal at hand some genes might not be suitable for differential testing. This is for example when there is overall not enough signal per gene, if the distribution between conditions is heavily tailored towards one side or if there is a strong imbalance between the *background-bin* and *binding-bin* per gene. The following function can be used to remove such cases to create a more reliable test set222222 Note: The `plotBsBackgroundFilter()` function can be used to visualize each filtering option..

```
bds.diff = filterBsBackground(bds.diff)
```

```
## Warning in filterBsBackground(bds.diff): Found 34 genes with less total counts than 100.
## Removing a total of 34 genes and 39 binding sites.
```

```
## Warning in filterBsBackground(bds.diff): Found 12 genes with bs to bg ratio not meeting thresholds.
## Removing a total of 12 genes and 30 binding sites.
```

```
## Warning in filterBsBackground(bds.diff): Found 0 genes with condition balance ratio not meeting thresholds.
## Removing a total of 0 genes and 0 binding sites.
```

## 7.4 Perform differential testing

Finally differential testing can be carried out using the `calculateBsFoldChange()` function. This function computes fold-changes for each binding site using the *background-bin* for correction and the likelihood ratio test for significance testing (for details on these test see the `DESeq2` user manual). Additionally, gene-level fold-changes are computed for each hosting gene using the standard Wald test (again see the `DESeq2` user manual for further details)232323 Note: Depending on the data one might have to use the `removeNA` argument to remove edge cases where no `background-bin` counts could be computed. It is worth to manually look at such cases..

```
bds.diff = calculateBsFoldChange(bds.diff)
getRanges(bds.diff)
```

```
## GRanges object with 4892 ranges and 26 metadata columns:
##          seqnames            ranges strand |        bsID    bsSize
##             <Rle>         <IRanges>  <Rle> | <character> <integer>
##      BS3    chr22 15785523-15785527      + |         BS3         5
##      BS4    chr22 15785540-15785544      + |         BS4         5
##      BS5    chr22 15785546-15785550      + |         BS5         5
##      BS6    chr22 15785946-15785950      + |         BS6         5
##      BS7    chr22 15785962-15785966      + |         BS7         5
##      ...      ...               ...    ... .         ...       ...
##   BS5072    chr22 50776987-50776991      - |      BS5072         5
##   BS5073    chr22 50776992-50776996      - |      BS5073         5
##   BS5074    chr22 50777821-50777825      - |      BS5074         5
##   BS5075    chr22 50777869-50777873      - |      BS5075         5
##   BS5076    chr22 50783298-50783302      - |      BS5076         5
##                      geneID    geneName       geneType     dataset
##                 <character> <character>    <character> <character>
##      BS3 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS4 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS5 ENSG00000206195.11      DUXAP8         lncRNA  Example.WT
##      BS6 ENSG00000206195.11      DUXAP8         lncRNA  Example.KO
##      BS7 ENSG00000206195.11      DUXAP8         lncRNA  Example.WT
##      ...                ...         ...            ...         ...
##   BS5072 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5073 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5074 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##   BS5075 ENSG00000079974.18      RABL2B protein_coding  Example.WT
##   BS5076 ENSG00000079974.18      RABL2B protein_coding  Example.KO
##          counts.bs.1_WT counts.bs.2_WT counts.bs.3_KO counts.bs.4_KO
##               <numeric>      <numeric>      <numeric>      <numeric>
##      BS3              2              5              6              2
##      BS4              3              1              6              2
##      BS5              0              6              8              5
##      BS6              1              1              5              0
##      BS7              0              2              8              1
##      ...            ...            ...            ...            ...
##   BS5072              0              1              7              1
##   BS5073              2              9              9              8
##   BS5074              2              2              5              3
##   BS5075              4              8             13              5
##   BS5076              4              5              8              5
##          counts.bg.1_WT counts.bg.2_WT counts.bg.3_KO counts.bg.4_KO
##               <numeric>      <numeric>      <numeric>      <numeric>
##      BS3             11             71             74             22
##      BS4             11             71             74             22
##      BS5             11             71             74             22
##      BS6             11             71             74             22
##      BS7             11             71             74             22
##      ...            ...            ...            ...            ...
##   BS5072             11             46             71             27
##   BS5073             11             46             71             27
##   BS5074             11             46             71             27
##   BS5075             11             46             71             27
##   BS5076             11             46             71             27
##          bs.baseMean bs.log2FoldChange  bs.lfcSE     bs.stat bs.pvalue
##            <numeric>         <numeric> <numeric>   <numeric> <numeric>
##      BS3    18.06576        0.00201385  0.814051 6.13075e-06  0.998024
##      BS4    17.21228        0.49510922  1.263454 1.48423e-01  0.700047
##      BS5    19.86013        1.00907610  1.040451 9.79359e-01  0.322357
##      BS6     8.30315        0.92938363  1.450254 4.27508e-01  0.513214
##      BS7    10.09457        1.87552092  1.359956 2.17815e+00  0.139982
##      ...         ...               ...       ...         ...       ...
##   BS5072     8.45359         2.1633690  1.395628   2.9873966  0.083915
##   BS5073    32.75253        -0.0813876  0.622872   0.0170241  0.896190
##   BS5074    16.31571         0.2781398  0.929807   0.0907884  0.763177
##   BS5075    34.75249        -0.1357579  0.602860   0.0505005  0.822195
##   BS5076    29.04008        -0.1901605  0.684449   0.0765903  0.781972
##            bs.padj bg.baseMean bg.log2FoldChange  bg.lfcSE   bg.stat bg.pvalue
##          <numeric>   <numeric>         <numeric> <numeric> <numeric> <numeric>
##      BS3  0.999250     34.6044         -0.256956  0.464566  -0.55311  0.580188
##      BS4  0.936368     34.6044         -0.256956  0.464566  -0.55311  0.580188
##      BS5  0.811975     34.6044         -0.256956  0.464566  -0.55311  0.580188
##      BS6  0.893694     34.6044         -0.256956  0.464566  -0.55311  0.580188
##      BS7  0.621117     34.6044         -0.256956  0.464566  -0.55311  0.580188
##      ...       ...         ...               ...       ...       ...       ...
##   BS5072  0.511223     31.4992          0.251674  0.466657  0.539312  0.589672
##   BS5073  0.983324     31.4992          0.251674  0.466657  0.539312  0.589672
##   BS5074  0.950474     31.4992          0.251674  0.466657  0.539312  0.589672
##   BS5075  0.966006     31.4992          0.251674  0.466657  0.539312  0.589672
##   BS5076  0.956831     31.4992          0.251674  0.466657  0.539312  0.589672
##            bg.padj
##          <numeric>
##      BS3  0.995469
##      BS4  0.995469
##      BS5  0.995469
##      BS6  0.995469
##      BS7  0.995469
##      ...       ...
##   BS5072  0.995469
##   BS5073  0.995469
##   BS5074  0.995469
##   BS5075  0.995469
##   BS5076  0.995469
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Resulting fold-changes and P values are again added to the meta columns of the binding sites (`GRanges` format). As a quick visualization of the results the functions `plotBsMA()` and `plotBsVolcano()` can be used, each of which can produce a plot either for the binding sites (`what = "bs"`) or for the background (`what = "bg"`).

```
plotBsMA(bds.diff, what = "bs")
```

![plotBsMA. MA plot for binding site changes.](data:image/png;base64...)

Figure 18: plotBsMA
MA plot for binding site changes.

### 7.4.1 Display differential results on gene level

To investigate differential binding results for a certain gene, the `geneRegulationPlot` can be used. The function displays the regulation (log2 fold-changes) of your binding sites on a given gene relative to their position with in the gene and optional adds the transcript region to it as well.

The differential expression workflow must be followed to obtain log2 fold-changes (see section [Differential binding analysis](#%20Differential%20binding%20analysis)). Binding sites must also be assigned to their host genes with `assignToGenes` prior to this plot.

For maximum information also `assignToTranscriptRegions` should be executed as well242424 Note: The present plot is made from a small example data set due to size limitations, a plot made from real data will look more informative.. If transcript region assignments are missing, one can re-calculate them for the merged object even after the differential binding workflow. The function allows a quick and easy way to visualize regulatory patterns due to binding site positioning and transcript region location.

```
bds.diff = assignToTranscriptRegions(bds.diff, anno.transcriptRegionList = regions)
geneRegulationPlot(bds.diff, plot.geneID = "ENSG00000180957.18", anno.genes = gns)
```

![](data:image/png;base64...)

## 7.5 Differential binding variations

### 7.5.1 Starting from scratch

The following code chunks show how one can start fully from scratch with the binding site definition for the purpose of a downstream differential binding analysis. In the following example we will demonstrate the binding site definition for the conditions *WT* and *KO*.

At first one has to construct a `BSFDataSet` for each condition with the crosslinks form the peak-calling step (PureCLIP output). This serves as input for the binding sites definition with `BSFind()` (for further details see the [Performing the main analysis](##%20Performing%20the%20main%20analysis) section). As a result one gets a set of binding sites. This has to be done for each condition (in our example these are *WT* and *KO*)252525 Note: It is desired that the same binding site size is used for both conditions, which can require setting the `bsSize` argument explicitly when calling `BSFind()`..

```
############################
# Construct WT binding sites
############################
# Locate peak calling result
peaks.wt = "./myFolder/wt/pureclip.bed"
peaks.wt = import(con = peaks.wt, format = "BED", extraCols=c("additionalScores" = "character"))
peaks.wt = keepStandardChromosomes(peaks.wt, pruning.mode = "coarse")
# Locate bigwig files
clipFiles = "./myFolder/wt/bigwig/"
clipFiles = list.files(clipFiles, pattern = ".bw$", full.names = TRUE)
clipFiles = clipFiles[grepl("WT", clipFiles)]
clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# Organize clip data in dataframe
colData = data.frame(
    name = "Example.WT", id = c(1:2),
    condition = factor(c("WT", "WT"), levels = c("WT")),
    clPlus = clipFilesP, clMinus = clipFilesM)
# Construct BSFDataSet object
bdsWT.initial = BSFDataSetFromBigWig(ranges = peaksInitial, meta = colData)
# Define binding sites
bdsWT = BSFind(bdsWT.initial, anno.genes = gns, anno.transcriptRegionList = trl)
```

```
############################
# Construct KO binding sites
############################
# Locate peak calling result
peaks.ko = "./myFolder/ko/pureclip.bed"
peaks.ko = import(con = peaks.ko, format = "BED", extraCols=c("additionalScores" = "character"))
peaks.ko = keepStandardChromosomes(peaks.ko, pruning.mode = "coarse")
# Locate bigwig files
clipFiles = "./myFolder/ko/bigwig/"
clipFiles = list.files(clipFiles, pattern = ".bw$", full.names = TRUE)
clipFiles = clipFiles[grepl("KO", clipFiles)]
clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# Organize clip data in dataframe
colData = data.frame(
    name = "Example.KO", id = c(1:2),
    condition = factor(c("KO", "KO"), levels = c("KO")),
    clPlus = clipFilesP, clMinus = clipFilesM)
# Construct BSFDataSet object
bdsKO.initial = BSFDataSetFromBigWig(ranges = peaksInitial, meta = colData)
# Define binding sites
bdsKO = BSFind(bdsKO.initial, anno.genes = gns, anno.transcriptRegionList = trl)
```

### 7.5.2 Starting from existing binding sites

Sometimes one already has a set of binding sites computed and just wants to perform the differential binding analysis part for the specific set at hand. In this case the pre-computed binding sites can be imported alongside the bigwig files from both conditions into a single `BSFDataSet`. This set can then directly be used for background generation (see section [Count matrix generation](##%20Count%20matrix%20generation)).

```
# Locate bigwig files - KO
clipFilesKO = "./myFolder/ko/bigwig/"
clipFilesKO = list.files(clipFilesKO, pattern = ".bw$", full.names = TRUE)
clipFilesKO = clipFilesKO[grepl("KO", clipFilesKO)]
# Locate bigwig files - WT
clipFilesWT = "./myFolder/wt/bigwig/"
clipFilesWT = list.files(clipFilesWT, pattern = ".bw$", full.names = TRUE)
clipFilesWT = clipFilesWT[grepl("WT", clipFilesWT)]
# Merge both conditions
clipFiles = c(clipFilesWT, clipFilesKO)
# Split by strand
clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# Organize clip data in dataframe
colData = data.frame(
    name = "Example.KO", id = c(1:4),
    condition = factor(c("WT", "WT", "KO", "KO"), levels = c("WT", "KO")),
    clPlus = clipFilesP, clMinus = clipFilesM)
# Construct BSFDataSet object from pre-defined binding sites
# -> myBindingSites must be a GRanges object
bds.comb = BSFDataSetFromBigWig(ranges = myBindingSites, meta = colData)
```

### 7.5.3 How to deal with multiple comparisons?

In the case of a more complex experimental design that requires the comparison of more than two conditions, we recommend to compute as many pair-wise comparison as necessary. If one for example wants to incorporate an additional control condition (named *CTRL*) to the above setup, we would split the comparisons into three pair-wise designs (*CTRL-WT*, *CTRL-KO* and *WT-KO*). To ensure that all sets contain all binding sites found in either of the three conditions a merge over all three conditions has to be done prior to the testing.

Assuming that binding sites were defined for each condition, one would merge all binding sites doing the following:262626 Note: This also merges the meta data which we have to revert for the specific comparison that we want to compute..

```
bds.complex = combineBSF(list(ctrl = bds.ctrl, wt = bds.wt, ko = bds.ko))
```

Next all binding site ranges from this set can be extracted and used to create a new `BSFDataSet` object for each comparison that should be computed (here we compare WT-vs-KO). This is very similar to starting a differential binding analysis from an existing set of binding sites (see chapter [Starting from existing binding sites](###%20Starting%20from%20existing%20binding%20sites)).

```
# extract binding site ranges from complex merge
bindingSites.complex = getRanges(bds.complex)
# Locate bigwig files - KO
clipFilesKO = "./myFolder/ko/bigwig/"
clipFilesKO = list.files(clipFilesKO, pattern = ".bw$", full.names = TRUE)
clipFilesKO = clipFilesKO[grepl("KO", clipFilesKO)]
# Locate bigwig files - WT
clipFilesWT = "./myFolder/wt/bigwig/"
clipFilesWT = list.files(clipFilesWT, pattern = ".bw$", full.names = TRUE)
clipFilesWT = clipFilesWT[grepl("WT", clipFilesWT)]
# Merge both conditions
clipFiles = c(clipFilesWT, clipFilesKO)
# Split by strand
clipFilesP = clipFiles[grep(clipFiles, pattern = "plus")]
clipFilesM = clipFiles[grep(clipFiles, pattern = "minus")]
# Organize clip data in dataframe
colData = data.frame(
    name = "Example.KO", id = c(1:2),
    condition = factor(c("KO", "KO"), levels = c("KO")),
    clPlus = clipFilesP, clMinus = clipFilesM)
# Construct BSFDataSet object from pre-defined binding sites
bds.comb = BSFDataSetFromBigWig(ranges = bindingSites.complex, meta = colData)
```

### 7.5.4 Using the blacklist regions

In the case that the binding site definition was performed using a particularly high gene-wise level filter or if differential testing should be performed only on a subset of all defined binding sites, we recommend to use this information for the background generation by making use of the `blacklist` argument. This ensures that counts from all ranges that were at some point in the analysis identified as either a peak or a binding site will be removed from the *background-bin*.

# 8 Session info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] dplyr_1.1.4                 forcats_1.0.1
##  [3] BindingSiteFinder_2.8.0     ComplexHeatmap_2.26.0
##  [5] tidyr_1.3.1                 ggplot2_4.0.0
##  [7] rtracklayer_1.70.0          GenomicAlignments_1.46.0
##  [9] Rsamtools_2.26.0            Biostrings_2.78.0
## [11] XVector_0.50.0              SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0               IRanges_2.44.0
## [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [21] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] BiocIO_1.20.0            bitops_1.0-9             filelock_1.0.3
##   [4] tibble_3.3.0             polyclip_1.10-7          XML_3.99-0.19
##   [7] rpart_4.1.24             lifecycle_1.0.4          httr2_1.2.1
##  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
##  [13] MASS_7.3-65              ggdist_3.3.3             backports_1.5.0
##  [16] magrittr_2.0.4           Hmisc_5.2-4              sass_0.4.10
##  [19] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
##  [22] Gviz_1.54.0              DBI_1.2.3                RColorBrewer_1.1-3
##  [25] abind_1.4-8              purrr_1.1.0              AnnotationFilter_1.34.0
##  [28] biovizBase_1.58.0        RCurl_1.98-1.17          nnet_7.3-20
##  [31] VariantAnnotation_1.56.0 tweenr_2.0.3             rappdirs_0.3.3
##  [34] circlize_0.4.16          svglite_2.2.2            codetools_0.2-20
##  [37] DelayedArray_0.36.0      xml2_1.4.1               ggforce_0.5.0
##  [40] tidyselect_1.2.1         shape_1.4.6.1            UCSC.utils_1.6.0
##  [43] farver_2.1.2             viridis_0.6.5            BiocFileCache_3.0.0
##  [46] base64enc_0.1-3          jsonlite_2.0.0           GetoptLong_1.0.5
##  [49] Formula_1.2-5            iterators_1.0.14         systemfonts_1.3.1
##  [52] foreach_1.5.2            tools_4.5.1              progress_1.2.3
##  [55] Rcpp_1.1.0               glue_1.8.0               gridExtra_2.3
##  [58] SparseArray_1.10.0       xfun_0.53                DESeq2_1.50.0
##  [61] distributional_0.5.0     GenomeInfoDb_1.46.0      withr_3.0.2
##  [64] BiocManager_1.30.26      fastmap_1.2.0            GGally_2.4.0
##  [67] latticeExtra_0.6-31      digest_0.6.37            R6_2.6.1
##  [70] textshaping_1.0.4        colorspace_2.1-2         Cairo_1.7-0
##  [73] jpeg_0.1-11              dichromat_2.0-0.1        biomaRt_2.66.0
##  [76] RSQLite_2.4.3            cigarillo_1.0.0          data.table_1.17.8
##  [79] prettyunits_1.2.0        httr_1.4.7               htmlwidgets_1.6.4
##  [82] S4Arrays_1.10.0          ggstats_0.11.0           pkgconfig_2.0.3
##  [85] gtable_0.3.6             blob_1.2.4               S7_0.2.0
##  [88] htmltools_0.5.8.1        bookdown_0.45            ProtGenerics_1.42.0
##  [91] clue_0.3-66              scales_1.4.0             kableExtra_1.4.0
##  [94] png_0.1-8                knitr_1.50               rstudioapi_0.17.1
##  [97] rjson_0.2.23             checkmate_2.3.3          curl_7.0.0
## [100] cachem_1.1.0             GlobalOptions_0.1.2      stringr_1.5.2
## [103] vipor_0.4.7              parallel_4.5.1           foreign_0.8-90
## [106] AnnotationDbi_1.72.0     ggrastr_1.0.2            restfulr_0.0.16
## [109] pillar_1.11.1            vctrs_0.6.5              dbplyr_2.5.1
## [112] cluster_2.1.8.1          beeswarm_0.4.0           htmlTable_2.4.3
## [115] evaluate_1.0.5           tinytex_0.57             GenomicFeatures_1.62.0
## [118] magick_2.9.0             cli_3.6.5                locfit_1.5-9.12
## [121] compiler_4.5.1           rlang_1.1.6              crayon_1.5.3
## [124] labeling_0.4.3           interp_1.1-6             ggbeeswarm_0.7.2
## [127] plyr_1.8.9               stringi_1.8.7            viridisLite_0.4.2
## [130] deldir_2.0-4             BiocParallel_1.44.0      lazyeval_0.2.2
## [133] Matrix_1.7-4             BSgenome_1.78.0          hms_1.1.4
## [136] bit64_4.6.0-1            KEGGREST_1.50.0          memoise_2.0.1
## [139] bslib_0.9.0              bit_4.6.0
```

# Bibliography

Busch, Anke, Mirko Brüggemann, Stefanie Ebersberger, and Kathi Zarnack. 2020. “ICLIP Data Analysis: A Complete Pipeline from Sequencing Reads to Rbp Binding Sites.” *Methods* 178 (June): 49–62. <https://doi.org/10.1016/j.ymeth.2019.11.008>.

Krakau, Sabrina, Hugues Richard, and Annalisa Marsico. 2017. “PureCLIP: Capturing Target-Specific ProteinRNA Interaction Footprints from Single-Nucleotide Clip-Seq Data.” *Genome Biology* 18 (1). <https://doi.org/10.1186/s13059-017-1364-2>.