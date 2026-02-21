# Introduction to GeneStructureTools

Beth Signal

#### 2025-10-30

#### Package

GeneStructureTools 1.30.0

# Contents

* [1 Introduction](#introduction)
* [2 Importing Differential Splicing Data](#importing-differential-splicing-data)
  + [2.1 Whippet](#whippet)
  + [2.2 leafcutter](#leafcutter)
* [3 Summarise changes in gene structures due to splicing](#summarise-changes-in-gene-structures-due-to-splicing)
  + [3.1 Whippet](#whippet-1)
* [4 Altering Gene and Transcript Structures](#altering-gene-and-transcript-structures)
  + [4.1 Exon skipping](#exon-skipping)
  + [4.2 Intron Retention](#intron-retention)
  + [4.3 Alternative acceptor and donor splice sites](#alternative-acceptor-and-donor-splice-sites)
    - [4.3.1 Aternative acceptor](#aternative-acceptor)
    - [4.3.2 Aternative donor](#aternative-donor)
  + [4.4 Alternative first/last exons](#alternative-firstlast-exons)
    - [4.4.1 Alternative first exons](#alternative-first-exons)
    - [4.4.2 Alternative last exons](#alternative-last-exons)
  + [4.5 Alternative Intron usage (leafcutter)](#alternative-intron-usage-leafcutter)
* [5 Annotate Open Reading Frames](#annotate-open-reading-frames)
* [6 DEXSeq](#dexseq)
  + [6.1 GTF reannotation](#gtf-reannotation)
  + [6.2 DEXSeq event overlapping](#dexseq-event-overlapping)
* [7 Session Info](#session-info)

![](data:image/png;base64...)

# 1 Introduction

GeneStructureTools is a package for the manipulation and analysis of transcribed gene structures.

We have provided functions for importing Whippet and leafcutter alternative splicing data, and the analysis of these splicing events.
Splicing events can also be defined manually if you are using a different splicing analysis tool to Whippet.
For specific events - currently including exon skipping, intron retention, alternative splice site usage and alternative first/last exons - transcripts can be made in silico which use the two splicing modes - i.e. transcripts containing and transcripts skipping an exon.
These transcripts do not have to be pre-annotated, and thus all potential isoforms can be compared for an event.

Current comparisons of transcripts include annotating and analysing ORF and UTR features (length, locations, difference/similarity between transcripts), and predicting nonsense mediated decay (NMD) potential.

We also have functions for re-annotation of .GTF features, such as annotating UTRs as 3’ or 5’, and assigning a broader biotype for genes and transcripts so more informative analysis can be performed between these classes.

# 2 Importing Differential Splicing Data

Currently, very few available tools output splicing event type information (i.e. exon skipping, intron retention) within tested genes.
GeneStructureTools currently has functions for processing data from:

[**whippet**](https://github.com/timbitz/Whippet.jl)

[**DEXSeq**](http://bioconductor.org/packages/release/bioc/html/DEXSeq.html)

[**leafcutter**](https://github.com/davidaknowles/leafcutter)

**Data Preparation**

We have pre-prepared data from mouse embryonic stem cell (ESC) development (Gloss et. al, 2017, Accession Number [GSE75028](https://www.ebi.ac.uk/ena/data/view/PRJNA302257)), at days 0 and 5, and run whippet on each replicate using the reccomended parameters and the Gencode vM14 annotation.
You can download the whippet, leafcutter, and DEXSeq files [here](https://drive.google.com/open?id=0BxH-QCp3c0OVZXpQMDNFVUlwWDA).

You will also need to download the Gencode GTF file from [here](http://www.gencodegenes.org/mouse_releases/14.html).

For the purposes of this vignette, small subsets of these data are available in the package data (inst/extdata).

Data provided is typical output for leafcutter and Whippet. For details on what each file contains, please refer to their respective manuals ( [leafcutter](http://davidaknowles.github.io/leafcutter/index.html) | [Whippet](https://github.com/timbitz/Whippet.jl) ).

DEXSeq data is processed as reccomended by the (DEXSeq) manual. The script used to process raw output is [here](https://github.com/betsig/GeneStructureTools/blob/master/inst/extdata/dexseq_process.R)

## 2.1 Whippet

To run a full analysis on Whippet output, you will need the raw .psi.gz (percent spliced in) and .jnc.gz (junction read counts) files for each sample. In addition, you will need to compare conditions using `whippet-delta.jl` and have a resulting .diff.gz file.

**Read in Whippet files from downloaded data**

```
# Load packages
library(GeneStructureTools)
library(GenomicRanges)
library(stringr)
library(BSgenome.Mmusculus.UCSC.mm10)
library(Gviz)
library(rtracklayer)

# list of files in the whippet directory
whippet_file_directory <- "~/Downloads/GeneStructureTools_VignetteFiles/"

# read in files as a whippetDataSet
wds <- readWhippetDataSet(whippet_file_directory)

# create a sample table with sample id, condition and replicate
whippet_sampleTable <- data.frame(sample=c("A01","B01","A21","B21"),
                                  condition=c("01","01","21","21"),
                                  replicate=(c("A","B","A","B")))

# read in gtf annotation
gtf <- rtracklayer::import("~/Downloads/gencode.vM14.annotation.gtf.gz")
exons <- gtf[gtf$type=="exon"]
transcripts <- gtf[gtf$type=="transcript"]

# add first/last annotation (speeds up later steps)
if(!("first_last" %in% colnames(mcols(exons)))){
    t <- as.data.frame(table(exons$transcript_id))
    exons$first_last <- NA
    exons$first_last[exons$exon_number == 1] <- "first"
    exons$first_last[exons$exon_number ==
    t$Freq[match(exons$transcript_id, t$Var1)]] <- "last"
}

# specify the BSGenome annotation
g <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10
```

**Read in Whippet files from package data**

```
# Load packages
suppressPackageStartupMessages({
library(GeneStructureTools)
library(GenomicRanges)
library(stringr)
library(BSgenome.Mmusculus.UCSC.mm10)
library(Gviz)
library(rtracklayer)
})
# list of files in the whippet directory
whippet_file_directory <- system.file("extdata","whippet/",
package = "GeneStructureTools")

# read in files as a whippetDataSet
wds <- readWhippetDataSet(whippet_file_directory)

# create a sample table with sample id, condition and replicate
whippet_sampleTable <- data.frame(sample=c("A01","B01","A21","B21"),
                                  condition=c("01","01","21","21"),
                                  replicate=(c("A","B","A","B")))

# read in gtf annotation
gtf <- rtracklayer::import(system.file("extdata","example_gtf.gtf",
package = "GeneStructureTools"))
exons <- gtf[gtf$type=="exon"]
transcripts <- gtf[gtf$type=="transcript"]

# add first/last annotation (speeds up later steps)
if(!("first_last" %in% colnames(mcols(exons)))){
    t <- as.data.frame(table(exons$transcript_id))
    exons$first_last <- NA
    exons$first_last[exons$exon_number == 1] <- "first"
    exons$first_last[exons$exon_number ==
    t$Freq[match(exons$transcript_id, t$Var1)]] <- "last"
}

# specify the BSGenome annotation
g <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10
```

## 2.2 leafcutter

Only the file containg the leafcutter results for each intron, and the .gtf file used with leafcutter needs to be read in for results processing. The leafcutter results file is generated after running [prepare\_results.R](https://github.com/davidaknowles/leafcutter/blob/master/leafviz/prepare_results.R) on your data, then extracting out the intron data table.

First, find the location of the leafviz2table.R script:

```
#find location of the script
system.file("extdata","leafviz2table.R", package = "GeneStructureTools")
```

Then run it on your leafviz output .RData file.
The first argument is the leafviz output RData file, and the second is the name of the table you wish to write the intron results to.

```
Rscript leafviz2table.R leafviz.RData per_intron_results.tab
```

We have an processed example file available in extdata/leafcutter with a small sample of significant events.

```
# read in gtf annotation
gtf <- rtracklayer::import(system.file("extdata","example_gtf.gtf", package = "GeneStructureTools"))
exons <- gtf[gtf$type=="exon"]

# specify the BSGenome annotation
g <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10

# list of files in the leafcutter directory
leafcutter_files <- list.files(system.file("extdata","leafcutter/", package = "GeneStructureTools"),full.names = TRUE)

intron_results <- read.delim(leafcutter_files[grep("per_intron_results.tab", leafcutter_files)], stringsAsFactors = FALSE)
```

# 3 Summarise changes in gene structures due to splicing

## 3.1 Whippet

```
# filter events for significance
wds <- filterWhippetEvents(
whippetDataSet = wds,
probability = 0.95, # min probability
psiDelta = 0.1, # min change in PSI
eventTypes = "all", # all event types
minCounts = 100, # mean of at least 100 counts in one condition
sampleTable = whippet_sampleTable)

# check for changes in gene/transcript structure
whippet_summary <- whippetTranscriptChangeSummary(wds,
exons = exons,
transcripts = transcripts,
BSgenome = g,
NMD = FALSE # ignore nonsense mediated decay
)
head(whippet_summary)
```

```
##                    gene node                    coord strand type   psi_a
## 1 ENSMUSG00000032883.15    3   chr1:78663141-78663280      +   CE 0.35304
## 2 ENSMUSG00000024038.16    6  chr17:31527310-31528401      +   CE 0.13662
## 3 ENSMUSG00000018379.17    5  chr11:88049216-88049411      +   RI 0.37136
## 4 ENSMUSG00000034064.14    3  chr16:38549434-38549636      -   AA 0.38094
## 5 ENSMUSG00000035478.14    2  chr10:80399122-80399217      -   AD 0.45017
## 6 ENSMUSG00000026421.14    2 chr1:135729147-135729274      +   AF 0.84840
##     psi_b psi_delta probability complexity entropy
## 1 0.13494   0.21810       1.000         K1  0.9619
## 2 0.27537  -0.13875       0.998         K1  0.9006
## 3 0.21276   0.15861       1.000         K1  0.9590
## 4 0.23379   0.14716       0.990         K1  0.9638
## 5 0.33980   0.11036       0.953         K1  0.9937
## 6 0.99487  -0.14647       1.000         K1  0.6421
##                                           unique_name comparison condition_1
## 1   ENSMUSG00000032883.15_chr1:78663141-78663280_CE_3    01_v_21          01
## 2  ENSMUSG00000024038.16_chr17:31527310-31528401_CE_6    01_v_21          01
## 3  ENSMUSG00000018379.17_chr11:88049216-88049411_RI_5    01_v_21          01
## 4  ENSMUSG00000034064.14_chr16:38549434-38549636_AA_3    01_v_21          01
## 5  ENSMUSG00000035478.14_chr10:80399122-80399217_AD_2    01_v_21          01
## 6 ENSMUSG00000026421.14_chr1:135729147-135729274_AF_2    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts node
## 1          21           1               89.5              213.5    3
## 2          21           2              706.0              456.5    6
## 3          21           3              569.5              662.0    5
## 4          21           4              103.5              109.0    3
## 5          21           5               98.5              107.5    2
## 6          21           6               51.5              196.5    2
##                      coord strand type   psi_a   psi_b psi_delta probability
## 1   chr1:78663141-78663280      +   CE 0.35304 0.13494   0.21810       1.000
## 2  chr17:31527310-31528401      +   CE 0.13662 0.27537  -0.13875       0.998
## 3  chr11:88049216-88049411      +   RI 0.37136 0.21276   0.15861       1.000
## 4  chr16:38549434-38549636      -   AA 0.38094 0.23379   0.14716       0.990
## 5  chr10:80399122-80399217      -   AD 0.45017 0.33980   0.11036       0.953
## 6 chr1:135729147-135729274      +   AF 0.84840 0.99487  -0.14647       1.000
##   complexity entropy                                         unique_name
## 1         K1  0.9619   ENSMUSG00000032883.15_chr1:78663141-78663280_CE_3
## 2         K1  0.9006  ENSMUSG00000024038.16_chr17:31527310-31528401_CE_6
## 3         K1  0.9590  ENSMUSG00000018379.17_chr11:88049216-88049411_RI_5
## 4         K1  0.9638  ENSMUSG00000034064.14_chr16:38549434-38549636_AA_3
## 5         K1  0.9937  ENSMUSG00000035478.14_chr10:80399122-80399217_AD_2
## 6         K1  0.6421 ENSMUSG00000026421.14_chr1:135729147-135729274_AF_2
##   comparison condition_1 condition_2 coord_match condition_1_counts
## 1    01_v_21          01          21           1               89.5
## 2    01_v_21          01          21           2              706.0
## 3    01_v_21          01          21           3              569.5
## 4    01_v_21          01          21           4              103.5
## 5    01_v_21          01          21           5               98.5
## 6    01_v_21          01          21           6               51.5
##   condition_2_counts                       id orf_length_bygroup_x
## 1              213.5   chr1:78663141-78663280                  720
## 2              456.5  chr17:31527310-31528401                  104
## 3              662.0  chr11:88049216-88049411                  201
## 4              109.0  chr16:38549434-38549636                  410
## 5              107.5  chr10:80399122-80399217                  313
## 6              196.5 chr1:135729147-135729274                  166
##   orf_length_bygroup_y utr3_length_bygroup_x utr3_length_bygroup_y
## 1                  720                  1328                  1328
## 2                  468                    74                    74
## 3                  253                   763                   411
## 4                  317                  1485                  1488
## 5                  281                   185                   185
## 6                  166                  1898                   709
##   utr5_length_bygroup_x utr5_length_bygroup_y filtered percent_orf_shared
## 1                   460                   320    FALSE          1.0000000
## 2                    57                    57    FALSE          0.2222222
## 3                    37                    37    FALSE          0.0000000
## 4                     2                   520    FALSE          0.7731707
## 5                   192                   192    FALSE          0.8977636
## 6                  1135                  2596    FALSE          1.0000000
##   max_percent_orf_shared orf_percent_kept_x orf_percent_kept_y
## 1              1.0000000          1.0000000          1.0000000
## 2              0.2222222          1.0000000          0.2222222
## 3              0.7944664          0.0000000          0.0000000
## 4              0.7731707          0.7731707          1.0000000
## 5              0.8977636          0.8977636          1.0000000
## 6              1.0000000          1.0000000          1.0000000
```

###leafcutter

```
leafcutter_summary <- leafcutterTranscriptChangeSummary(intron_results,
                                                        exons = exons,
                                                        BSgenome = g,
                                                        NMD = FALSE,
                                                        showProgressBar = FALSE)

head(leafcutter_summary[!duplicated(leafcutter_summary$cluster),])
```

```
##          cluster  status    loglr df            p     p.adjust  genes
## 5 chr16:clu_1396 Success 20.16004  2 1.756329e-09 2.720554e-06 Eif4a2
## 1 chr10:clu_1204 Success 18.48627  2 9.365149e-09 7.253308e-06 Bclaf1
## 6 chr15:clu_1488 Success 23.03735  6 2.860878e-08 1.107875e-05 Tarbp2
## 2 chr17:clu_1281 Success 20.57316  4 2.506720e-08 1.107875e-05  Rnps1
## 8   chr5:clu_225 Success 16.41082  2 7.462287e-08 2.311817e-05 Hnrnpd
## 7 chr14:clu_1512 Success 15.00163  2 3.054042e-07 7.884518e-05   Ktn1
##            FDR                             intron       logef       T01
## 5 2.720554e-06   chr16:23111896:23112351:clu_1396  0.30823371 0.2657849
## 1 7.253308e-06   chr10:20333572:20334499:clu_1204 -0.56647927 0.3521539
## 6 1.107875e-05 chr15:102518602:102519122:clu_1488 -0.47200141 0.2294254
## 2 1.107875e-05   chr17:24414734:24415041:clu_1281 -0.07302291 0.1145809
## 8 2.311817e-05     chr5:99967387:99976534:clu_225  0.55565460 0.3165242
## 7 7.884518e-05   chr14:47724970:47725929:clu_1512 -0.46578048 0.3338764
##         T02      deltapsi   chr     start       end clusterID   verdict   gene
## 5 0.4410376  0.1752527121 chr16  23111896  23112351  clu_1396 annotated Eif4a2
## 1 0.2269207 -0.1252331984 chr10  20333572  20334499  clu_1204 annotated Bclaf1
## 6 0.2597079  0.0302825713 chr15 102518602 102519122  clu_1488 annotated Tarbp2
## 2 0.1140728 -0.0005080613 chr17  24414734  24415041  clu_1281 annotated  Rnps1
## 8 0.3905444  0.0740202209  chr5  99967387  99976534   clu_225 annotated Hnrnpd
## 7 0.1656536 -0.1682228169 chr14  47724970  47725929  clu_1512 annotated   Ktn1
##               ensemblID transcripts constitutive.score orf_length_bygroup_x
## 5 ENSMUSG00000022884.14           +                  1                  408
## 1 ENSMUSG00000037608.16           +                  1                  919
## 6 ENSMUSG00000023051.10           +                  1                  132
## 2 ENSMUSG00000034681.16           +                  1                  305
## 8 ENSMUSG00000000568.15           -                  1                  336
## 7 ENSMUSG00000021843.16           +                  1                 1327
##   orf_length_bygroup_y utr3_length_bygroup_x utr3_length_bygroup_y
## 5                  363                   615                   857
## 1                  870                  2442                  2442
## 6                  274                  1265                   334
## 2                  282                   710                   710
## 8                  361                   366                   366
## 7                 1303                   469                   469
##   utr5_length_bygroup_x utr5_length_bygroup_y filtered percent_orf_shared
## 5                    34                    34    FALSE          0.7671569
## 1                   236                   236    FALSE          0.9466812
## 6                   224                    92    FALSE          0.0000000
## 2                   293                    59    FALSE          0.9245902
## 8                   294                   294    FALSE          0.9307479
## 7                    32                    32    FALSE          0.9819141
##   max_percent_orf_shared orf_percent_kept_x orf_percent_kept_y
## 5              0.8897059          0.7671569          0.8622590
## 1              0.9466812          0.9466812          1.0000000
## 6              0.4817518          0.0000000          0.0000000
## 2              0.9245902          0.9245902          1.0000000
## 8              0.9307479          1.0000000          0.9307479
## 7              0.9819141          0.9819141          1.0000000
```

# 4 Altering Gene and Transcript Structures

whippetTranscriptChangeSummary() combines several functions for analysing changes in gene structures. While this has been made to simplify analysis from whippet data, individual functions can be used on other data sources or manually annotated gene structures.
It may also be helpful to run each individual step if you would like to manually investigate changes to genes.

## 4.1 Exon skipping

Exon skipping, or cassette exon usage, occurs when a single exon is spliced out of the mature transcript.

![](data:image/png;base64...)

Removal of a skipped exon

**1.a. Find skipped exon events**

```
# filter out skipped exon events (coded as "CE")
# we will be looking at Ndufv3 (ENSMUSG00000024038.16)
wds.ce <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="CE", idList="ENSMUSG00000024038.16")

diffSplicingResults(wds.ce)
```

```
##                    gene node                   coord strand type   psi_a
## 2 ENSMUSG00000024038.16    6 chr17:31527310-31528401      +   CE 0.13662
##     psi_b psi_delta probability complexity entropy
## 2 0.27537  -0.13875       0.998         K1  0.9006
##                                          unique_name comparison condition_1
## 2 ENSMUSG00000024038.16_chr17:31527310-31528401_CE_6    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 2          21           2                706              456.5
```

```
# psi_a = 0.137, psi_b = 0.275
# percentage of transcripts skipping exon 3 decreases from timepoint 1 to 21

# whippet outputs the skipped exon coordinates
coordinates(wds.ce)
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |                     id
##          <Rle>         <IRanges>  <Rle> |            <character>
##   [1]    chr17 31527310-31528401      + | chr17:31527310-31528..
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

**2. Find transcripts which overlap the skipped exon, and create normal & skipped exon isoforms**

```
# find exons in the gtf that overlap the skipped exon event
exons.ce <- findExonContainingTranscripts(wds.ce,
                                          exons = exons,
                                          transcripts = transcripts)
# make skipped and included exon transcripts
# removes the skipped exon from all transcripts which contain it
skippedExonTranscripts <- skipExonInTranscript(skippedExons = exons.ce,
                                               exons=exons,
                                               match="skip",
                                               whippetDataSet = wds.ce)
```

```
## make Gvis models
# set up for visualisation
gtr <- GenomeAxisTrack()

# all transcripts for the gene
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id ==
skippedExonTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# reference transcript
geneModelNormal <- GeneRegionTrack(makeGeneModel(
skippedExonTranscripts[skippedExonTranscripts$set=="included_exon"]),
                                   name="Reference Isoform",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# for the skipped exon transcript
geneModelSkipped <- GeneRegionTrack(makeGeneModel(
skippedExonTranscripts[skippedExonTranscripts$set=="skipped_exon"]),
                                   name="Alternative Isoform",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

plotTracks(list(gtr,geneModel.all,geneModelNormal, geneModelSkipped),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

```
# Only the transcript isoform containing the skipped exon (exon 3)
# is used for analysis, and a 'novel' isoform is created by exon skipping
```

## 4.2 Intron Retention

Intron Retention occurs when an intron is not spliced out of the mature transcript.

![](data:image/png;base64...)

Addition of a retained intron

**1. Create normal and retained isoform structures from whippet coordinates**

```
# filter out retained events (coded as "RI")
# we will be looking at Srsf1 (ENSMUSG00000018379.17)
wds.ri <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="RI", idList="ENSMUSG00000018379.17")

diffSplicingResults(wds.ri)
```

```
##                    gene node                   coord strand type   psi_a
## 3 ENSMUSG00000018379.17    5 chr11:88049216-88049411      +   RI 0.37136
##     psi_b psi_delta probability complexity entropy
## 3 0.21276   0.15861           1         K1   0.959
##                                          unique_name comparison condition_1
## 3 ENSMUSG00000018379.17_chr11:88049216-88049411_RI_5    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 3          21           3              569.5                662
```

**2. Find transcripts which overlap the intron, and create normal & retained intron isoforms**

```
# find exons pairs in the gtf that bound the retained intron event
exons.ri <- findIntronContainingTranscripts(wds.ri,
                                            exons)

# make retained and non-retained transcripts
# adds the intron into all transcripts which overlap it
retainedIntronTranscripts <- addIntronInTranscript(exons.ri,
                                                   exons = exons,
                                                   whippetDataSet = wds.ri,
                                                   glueExons = TRUE)
```

```
## make Gviz models
# all transcripts for the gene
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id == retainedIntronTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# reference transcript
geneModelNormal <- GeneRegionTrack(makeGeneModel(
retainedIntronTranscripts[retainedIntronTranscripts$set=="spliced_intron"]),
                                   name="Reference Isoform",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# for the retained intron transcript
geneModelRetained <- GeneRegionTrack(makeGeneModel(
retainedIntronTranscripts[retainedIntronTranscripts$set=="retained_intron"]),
                                   name="Alternative Isoform",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

# Only the transcript isoforms with exons at the boundries of the retained intron are used for analysis, and 'novel' isoforms are created by intron retention
plotTracks(list(gtr,geneModel.all,geneModelNormal, geneModelRetained),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

## 4.3 Alternative acceptor and donor splice sites

Creation of alternative donor/acceptor isoforms currently relies on junction read counts supplied by whippet.

![](data:image/png;base64...)

Creation of transcripts with an alternative donor (left) or acceptor (right) splice site.

### 4.3.1 Aternative acceptor

**1. Create normal and alternative isoform structures from whippet coordinates**

```
# filter out alternative acceptor events (coded as "AA")
wds.aa <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="AA", idList="ENSMUSG00000034064.14")

diffSplicingResults(wds.aa)
```

```
##                    gene node                   coord strand type   psi_a
## 4 ENSMUSG00000034064.14    3 chr16:38549434-38549636      -   AA 0.38094
##     psi_b psi_delta probability complexity entropy
## 4 0.23379   0.14716        0.99         K1  0.9638
##                                          unique_name comparison condition_1
## 4 ENSMUSG00000034064.14_chr16:38549434-38549636_AA_3    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 4          21           4              103.5                109
```

```
# AA/AD coordinates range from the normal acceptor splice site to the alternative acceptor splice site
coordinates(wds.aa)
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |                     id
##          <Rle>         <IRanges>  <Rle> |            <character>
##   [1]    chr16 38549434-38549636      - | chr16:38549434-38549..
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
# find exons pairs in the gtf that bound the retained intron event
junctionPairs.aa <- findJunctionPairs(wds.aa,
                                   type="AA")
junctionPairs.aa
```

```
## GRanges object with 2 ranges and 5 metadata columns:
##       seqnames            ranges strand |                     id
##          <Rle>         <IRanges>  <Rle> |            <character>
##   [1]    chr16 38549433-38550083      - | ENSMUSG00000034064.1..
##   [2]    chr16 38549636-38550083      - | ENSMUSG00000034064.1..
##                        gene             whippet_id      search         set
##                 <character>            <character> <character> <character>
##   [1] ENSMUSG00000034064.14 chr16:38549434-38549..       right           Y
##   [2] ENSMUSG00000034064.14 chr16:38549434-38549..       right           X
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
# make transcripts with alternative junction usage
altTranscripts <- replaceJunction(wds.aa,
                                  junctionPairs.aa,
                                  exons,
                                  type="AA")

# make transcripts using junction X
xTranscripts <- altTranscripts[altTranscripts$set=="AA_X"]
# make transcripts using junction Y
yTranscripts <- altTranscripts[altTranscripts$set=="AA_Y"]
```

```
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id == altTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# transcript X
geneModelX <- GeneRegionTrack(makeGeneModel(xTranscripts),
                                   name="Isoform X",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# transcript Y
geneModelY<- GeneRegionTrack(makeGeneModel(yTranscripts),
                                   name="Isoform Y",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

plotTracks(list(gtr,geneModel.all,geneModelX, geneModelY),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

```
# Zoomed in at the alternative acceptor site
plotTracks(list(gtr,geneModel.all,geneModelX, geneModelY),
from = 38547500, to = 38551000)
```

![](data:image/png;base64...)

### 4.3.2 Aternative donor

**1. Create normal and alternative isoform structures from whippet coordinates**

```
# filter out alternative acceptor events (coded as "AD")
# we will be looking at Mdbd3 (ENSMUSG00000035478.14)
wds.ad <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="AD", idList="ENSMUSG00000035478.14")

diffSplicingResults(wds.ad)
```

```
##                    gene node                   coord strand type   psi_a  psi_b
## 5 ENSMUSG00000035478.14    2 chr10:80399122-80399217      -   AD 0.45017 0.3398
##   psi_delta probability complexity entropy
## 5   0.11036       0.953         K1  0.9937
##                                          unique_name comparison condition_1
## 5 ENSMUSG00000035478.14_chr10:80399122-80399217_AD_2    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 5          21           5               98.5              107.5
```

```
# AD coordinates range from the normal donor splice site to the alternative donor splice site
coordinates(wds.ad)
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |                     id
##          <Rle>         <IRanges>  <Rle> |            <character>
##   [1]    chr10 80399122-80399217      - | chr10:80399122-80399..
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
# find exons pairs in the gtf that bound the retained intron event
junctionPairs.ad <- findJunctionPairs(wds.ad, type="AD")

# make transcripts with alternative junction usage
altTranscripts <- replaceJunction(wds.ad,
                                  junctionPairs.ad,
                                  exons, type="AD")

# make transcripts using junction X
xTranscripts <- altTranscripts[altTranscripts$set=="AD_X"]
# make transcripts using junction Y
yTranscripts <- altTranscripts[altTranscripts$set=="AD_Y"]
```

```
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id == altTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# transcript X
geneModelX <- GeneRegionTrack(makeGeneModel(xTranscripts),
                                   name="Isoform X",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# transcript Y
geneModelY<- GeneRegionTrack(makeGeneModel(yTranscripts),
                                   name="Isoform Y",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

plotTracks(list(gtr,geneModel.all,geneModelX, geneModelY),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

## 4.4 Alternative first/last exons

Creation of alternative first/last isoforms currently relies on junction read counts supplied by whippet.

![](data:image/png;base64...)

Creation of transcripts with an alternative first (left) or last (right) exon.

### 4.4.1 Alternative first exons

**1. Create normal and alternative isoform structures from whippet coordinates**

```
# filter out alternative acceptor events (coded as "AF")
# we will be looking at Csrp1 (ENSMUSG00000026421.14)
wds.af <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="AF", idList="ENSMUSG00000026421.14")

diffSplicingResults(wds.af)
```

```
##                    gene node                    coord strand type  psi_a
## 6 ENSMUSG00000026421.14    2 chr1:135729147-135729274      +   AF 0.8484
##     psi_b psi_delta probability complexity entropy
## 6 0.99487  -0.14647           1         K1  0.6421
##                                           unique_name comparison condition_1
## 6 ENSMUSG00000026421.14_chr1:135729147-135729274_AF_2    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 6          21           6               51.5              196.5
```

```
# whippet outputs first (or last) exon being tested only
# AF/AL coordinates range are exon coordinates for the tested first/last exon
coordinates(wds.af)
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames              ranges strand |                     id
##          <Rle>           <IRanges>  <Rle> |            <character>
##   [1]     chr1 135729147-135729274      + | chr1:135729147-13572..
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
# find junction pairs that use the same acceptor/donor as the specified first/last exon
# i.e. find the alternative first/last exon
junctionPairs.af <- findJunctionPairs(wds.af, type="AF")
```

```
# make transcripts with alternative junction usage
altTranscripts <- replaceJunction(wds.af, junctionPairs.af,
                                  exons,
                                  type="AF")

# make transcripts using exon X
xTranscripts <- altTranscripts[altTranscripts$set=="AF_X"]
# make transcripts using exon Y
yTranscripts <- altTranscripts[altTranscripts$set=="AF_Y"]
```

```
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id == altTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# reference transcript
geneModelX <- GeneRegionTrack(makeGeneModel(xTranscripts),
                                   name="Isoform X",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# for the retained intron transcript
geneModelY<- GeneRegionTrack(makeGeneModel(yTranscripts),
                                   name="Isoform Y",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

# Only the transcript isoforms with exons at the boundries of the retained intron are used for analysis, and 'novel' isoforms are created by intron retention
plotTracks(list(gtr,geneModel.all,geneModelX, geneModelY),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

### 4.4.2 Alternative last exons

**1. Create normal and alternative isoform structures from whippet coordinates**

```
# filter out alternative acceptor events (coded as "AL")
# we will be looking at Ppm1b (ENSMUSG00000061130.12)
wds.al <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="AL", idList="ENSMUSG00000061130.12")

diffSplicingResults(wds.al)
```

```
##                    gene node                   coord strand type  psi_a   psi_b
## 7 ENSMUSG00000061130.12    8 chr17:85013566-85014776      +   AL 0.6706 0.50781
##   psi_delta probability complexity entropy
## 7   0.16279       0.969         K2   1.226
##                                          unique_name comparison condition_1
## 7 ENSMUSG00000061130.12_chr17:85013566-85014776_AL_8    01_v_21          01
##   condition_2 coord_match condition_1_counts condition_2_counts
## 7          21           7              155.5              187.5
```

```
# whippet outputs first (or last) exon being tested only
# AF/AL coordinates range are exon coordinates for the tested first/last exon
coordinates(wds.al)
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames            ranges strand |                     id
##          <Rle>         <IRanges>  <Rle> |            <character>
##   [1]    chr17 85013566-85014776      + | chr17:85013566-85014..
##   -------
##   seqinfo: 5 sequences from an unspecified genome; no seqlengths
```

```
# find junction pairs that use the same acceptor/donor as the specified first/last exon
# i.e. find the alternative first/last exon
junctionPairs.al <- findJunctionPairs(wds.al, type="AL")

# make transcripts with alternative junction usage
altTranscripts <- replaceJunction(wds.al, junctionPairs.al,
                                  exons,
                                  type="AL")

# make transcripts using junction X
xTranscripts <- altTranscripts[altTranscripts$set=="AL_X"]
# make transcripts using junction Y
yTranscripts <- altTranscripts[altTranscripts$set=="AL_Y"]
```

```
geneModel.all <- GeneRegionTrack(makeGeneModel(exons[exons$gene_id == altTranscripts$gene_id[1]]),
                                 name="Reference Gene",
                                 showId=TRUE,
                                 transcriptAnnotation = "transcript")
# reference transcript
geneModelX <- GeneRegionTrack(makeGeneModel(xTranscripts),
                                   name="Isoform X",
                                   showId=TRUE, fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")
# for the retained intron transcript
geneModelY<- GeneRegionTrack(makeGeneModel(yTranscripts),
                                   name="Isoform Y",
                                   showId=TRUE, fill="#94AFD8",
                                   transcriptAnnotation = "transcript")

# Only the transcript isoforms with exons at the boundries of the retained intron are used for analysis, and 'novel' isoforms are created by intron retention
plotTracks(list(gtr,geneModel.all,geneModelX, geneModelY),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

## 4.5 Alternative Intron usage (leafcutter)

leafcutter uses an intron-centric view of splicing, and therefore all tested events are given as intron coordinates in clusters. Alternative isoforms are generated in sets. If possible, all downregulated introns/junctions are grouped together in a set, and all upregulated introns/junctions in another.

alternativeIntronUsage() first finds transcripts which overlap each intron set, and have perfect matches to the start and end of the intron (i.e. share splice sites). If exons are present within the range overlapping the intron set, these are replaced with exons that preserve the intron usage set.

**Three intron cluster**

![](data:image/png;base64...)

Alternative intron leafcutter event in Eif4a2

```
# select a single cluster
cluster <- leafcutter_summary[leafcutter_summary$cluster=="chr16:clu_1396",]

# generate alternative isoforms
altIsoforms1396 <- alternativeIntronUsage(cluster, exons)
# downregulated isoforms
altIsoforms1396_dnreg <- altIsoforms1396[grep("dnre",
                                            altIsoforms1396$transcript_id)]
# upregulated isoforms
altIsoforms1396_upreg <- altIsoforms1396[grep("upre",
                                            altIsoforms1396$transcript_id)]

# visualise
gtr <- GenomeAxisTrack()

geneModel.ref <- GeneRegionTrack(makeGeneModel(
exons[exons$gene_id=="ENSMUSG00000022884.14"]),
                                    name="Reference Gene",
                                    showId=TRUE,
                                    transcriptAnnotation = "transcript")

geneModel.dnreg <- GeneRegionTrack(makeGeneModel(altIsoforms1396_dnreg),
                                    name="Downregulated isoforms",
                                    showId=TRUE,fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")

geneModel.upreg <- GeneRegionTrack(makeGeneModel(altIsoforms1396_upreg),
                                name="Upregulated isoforms",fill="#94AFD8",
                                showId=TRUE,
                                transcriptAnnotation = "transcript")

plotTracks(list(geneModel.ref,geneModel.dnreg, geneModel.upreg),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)
**Five intron cluster**
More sets may be used if the number of introns in each cluster is greater than three.
In this case, the downregulated introns can overlap, so are split into two sets: e+d+b, and c

![](data:image/png;base64...)

Alternative intron leafcutter event in Rnps1

```
# select a single cluster
cluster <- leafcutter_summary[leafcutter_summary$cluster=="chr17:clu_1281",]

# generate alternative isoforms
altIsoforms1281 <- alternativeIntronUsage(cluster, exons)

# downregulated isoforms
altIsoforms1281_dnreg <- altIsoforms1281[grep("dnre",
                                            altIsoforms1281$transcript_id)]
# upregulated isoforms
altIsoforms1281_upreg <- altIsoforms1281[grep("upre",
                                            altIsoforms1281$transcript_id)]

# visualise
gtr <- GenomeAxisTrack()

geneModel.ref <- GeneRegionTrack(makeGeneModel(
exons[exons$gene_id=="ENSMUSG00000034681.16"]),
                                    name="Reference Gene",
                                    showId=TRUE,
                                    transcriptAnnotation = "transcript")

geneModel.dnreg <- GeneRegionTrack(makeGeneModel(altIsoforms1281_dnreg),
                                    name="Downregulated isoforms",
                                    showId=TRUE,fill="#4D7ABE",
                                   transcriptAnnotation = "transcript")

geneModel.upreg <- GeneRegionTrack(makeGeneModel(altIsoforms1281_upreg),
                                name="Upregulated isoforms",fill="#94AFD8",
                                showId=TRUE,
                                transcriptAnnotation = "transcript")

plotTracks(list(geneModel.ref,geneModel.dnreg, geneModel.upreg),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

# 5 Annotate Open Reading Frames

**1. Find open reading frame features**

```
# we will be looking at Ndufv3 (ENSMUSG00000024038.16) again
wds.ce <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="CE", idList="ENSMUSG00000024038.16")

# find exons in the gtf that overlap the skipped exon event
exons.ce <- findExonContainingTranscripts(wds.ce,
                                          exons = exons,
                                          transcripts = transcripts)
# make skipped and included exon transcripts
# removes the skipped exon from all transcripts which contain it
skippedExonTranscripts <- skipExonInTranscript(skippedExons = exons.ce,
                                               exons=exons,
                                               match="exact",
                                               whippetDataSet=wds.ce)
# make non-skipped exon transcripts
normalTranscripts <- exons[exons$transcript_id %in%
                                        exons.ce$transcript_id]

# get ORF details for each set of transcripts
orfs_normal <- getOrfs(normalTranscripts, BSgenome = g,
                       returnLongestOnly = FALSE, allFrames = TRUE)
orfs_skipped <- getOrfs(skippedExonTranscripts[skippedExonTranscripts$set ==
                                                                "skipped_exon"],
                        BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE)
orfs_included <- getOrfs(skippedExonTranscripts[skippedExonTranscripts$set ==
                                                               "included_exon"],
                         BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE)
head(orfs_normal[,-8])
```

```
##                      id               gene_id frame seq_length seq_length_nt
## 1 ENSMUST00000046288.14 ENSMUSG00000024038.16     1        512          1537
## 2 ENSMUST00000046288.14 ENSMUSG00000024038.16     2        512          1537
## 3 ENSMUST00000046288.14 ENSMUSG00000024038.16     3        511          1537
##   start_site stop_site orf_length start_site_nt stop_site_nt utr3_length
## 1        428       466         38          1282         1399         139
## 2        358       406         48          1073         1220         318
## 3         19       487        468            57         1464          74
##   min_dist_to_junction_a exon_a_from_start min_dist_to_junction_b
## 1                     78                 3                    140
## 2                    991                 2                    102
## 3                    143                 3                     75
##   exon_b_from_final
## 1                 0
## 2                 1
## 3                 0
```

```
# id: transcript isoform id
# gene_id: gene id
# frame: which open reading frame (1:3)
# seq_length: sequence length (in AA)
# seq_length_nt: sequence length (in nt)
# start_site: ORF start site (in AA)
# stop_site: ORF stop site (in AA)
# orf_sequence: ORF sequence (not shown)
# orf_length: ORF length (in AA)
# start_site_nt:  ORF start site (in nt) / 5'UTR length
# stop_site_nt:  ORF stop site (in nt)
# utr3_length: 3'UTR length (in nt)
# min_dist_to_junction_a: distance from stop codon to upstream junction (junction A)
# exon_a_from_start: junction A exon number
# min_dist_to_junction_b: distance from stop codon to downstream junction (junction B),
# exon_b_from_final: junction B exon number (counting backwards from the final exon)
```

We can also annotate upstream open reading frames for transcripts

```
# either as an indivudual data.frame with all uORFs
upstreamORFs <- getUOrfs(normalTranscripts, BSgenome = g, orfs=orfs_normal, findExonB=TRUE)

head(upstreamORFs)
```

```
##                       id frame overlaps_main_ORF uorf_length start_site_nt
## 3  ENSMUST00000046288.14     1        downstream         468            57
## 11 ENSMUST00000046288.14     1          upstream          10           229
## 9  ENSMUST00000046288.14     1          upstream          13           382
## 4  ENSMUST00000046288.14     1          upstream          29           553
## 7  ENSMUST00000046288.14     1          upstream          18           709
## 5  ENSMUST00000046288.14     1          upstream          23           749
##    stop_site_nt dist_to_start_nt min_dist_to_junction_b exon_b_from_final
## 3          1464             -182                     75                 0
## 11          262             1020                   1060                 1
## 9           424              858                    898                 1
## 4           643              639                    679                 1
## 7           766              516                    556                 1
## 5           821              461                    501                 1
```

```
# id: transcript id
# frame: reading frame for ORIGINAL orf data
# overlaps_main_orf: is the entire uorf upstream of the main orf (upstream), or is there  some overlap with the main orf (downsteam) - i.e. uORF stop codon is within the main ORF
# uorf_length: length of the uorf (in AA)
# start_site_nt: position (in nt) where the uorf start codon occurs within the transcript
# stop_site_nt: position (in nt) where the uorf stop codon occurs within the transcript
# dist_to_start_nt: distance (in nt) from the uorf stop codon to the main orf start codon
# min_dist_to_junction_b: distance from the uorf stop codon to the nearest downstream exon end/splice junction
# exon_b_from_final: relative exon number (from the end) of the uorf stop codon containing exon

# or as a summary by using the getOrfs() function
# with uORFS=TRUE
orfs_normal <- getOrfs(normalTranscripts, BSgenome = g,
                       returnLongestOnly = FALSE, allFrames = TRUE,
                       uORFs=TRUE)

head(orfs_normal[,-8])
```

```
##                      id               gene_id frame seq_length seq_length_nt
## 1 ENSMUST00000046288.14 ENSMUSG00000024038.16     1        512          1537
## 2 ENSMUST00000046288.14 ENSMUSG00000024038.16     2        512          1537
## 3 ENSMUST00000046288.14 ENSMUSG00000024038.16     3        511          1537
##   start_site stop_site orf_length start_site_nt stop_site_nt utr3_length
## 1        428       466         38          1282         1399         139
## 2        358       406         48          1073         1220         318
## 3         19       487        468            57         1464          74
##   min_dist_to_junction_a exon_a_from_start min_dist_to_junction_b
## 1                     78                 3                    140
## 2                    991                 2                    102
## 3                    143                 3                     75
##   exon_b_from_final total_uorfs upstream_count downstream_count max_uorf
## 1                 0           8              7                1      468
## 2                 1           7              6                1      468
## 3                 0           0              0                0        0
##   uorf_maxb
## 1      1060
## 2      1060
## 3         0
```

```
# this adds the following columns:
# total_uorfs: total number of uorfs found for the transcript and annotated open reading frame.
# upstream_count: number of uorfs that are located fully upstream of the main orf
# downstream_count: number of uorfs which partially overlap the main orf
# max_uorf: maximum length of an annotated uorf. If no uorfs annotated, = 0
# uorf_maxb: maximum distance from the uorf stop codon to the nearest downstream exon end/splice junction
```

**2. Compare ORFs**

```
# compare normal and skipped isoforms
orfChange <- orfDiff(orfsX = orfs_included,
                     orfsY = orfs_skipped,
                     filterNMD = FALSE,
                     compareBy="gene",
                     geneSimilarity = TRUE,
                     compareUTR=TRUE,
                     allORFs = orfs_normal)

orfChange
```

```
##                        id orf_length_bygroup_x orf_length_bygroup_y
## 1 chr17:31527310-31528401                  468                  104
##   utr3_length_bygroup_x utr3_length_bygroup_y utr5_length_bygroup_x
## 1                    74                    74                    57
##   utr5_length_bygroup_y filtered percent_orf_shared max_percent_orf_shared
## 1                    57    FALSE          0.2222222              0.2222222
##   orf_percent_kept_x orf_percent_kept_y gene_similarity_x gene_similarity_y
## 1          0.2222222                  1                 1         0.2222222
```

```
# id: splicing event ID
# orf_length_by_group_x: longest orf in first set of transcripts (included exon)
# orf_length_by_group_y: longest orf in second set of transcripts (skipped exon)
# utr3_length_by_group_x: 3'UTR length in first set of transcripts (included exon)
# utr3_length_by_group_y: 3'UTR length in second set of transcripts (skipped exon)
# utr5_length_by_group_x: 5'UTR length in first set of transcripts (included exon)
# utr5_length_by_group_y: 5'UTR length in second set of transcripts (skipped exon)
# filtered: filtered for NMD ?
# percent_orf_shared: percent of the ORF shared between skipped and included exon transcripts
# max_percent_orf_shared: theoretical maximum percent of the ORF that could be shared (orf_length_by_group_y / orf_length_by_group_x) or (orf_length_by_group_x / orf_length_by_group_y)
# orf_percent_kept_x: percent of the ORF in group x (included exon) contained in group y (skipped exon)
# orf_percent_kept_y: percent of the ORF in group y (skipped exon) contained in group x (included exon)
# gene_similarity_x: max percent of a normal ORF shared in the group x (included exon) transcript. If multiple ORF frames and transcripts are available, this is the maximum value from comparing the skipped isoform ORF to ALL normal isoform ORFs.
# gene_similarity_y: max percent of a normal ORF shared in the group y (skipped exon) transcript. If multiple ORF frames and transcripts are available, this is the maximum value from comparing the skipped isoform ORF to ALL normal isoform ORFs.
```

**2.b. Compare ORFs with NMD probability**

You can also use our package [“notNMD”](https://github.com/betsig/notNMD) to predict nonsense-mediated decay potential in transcripts

```
# devtools::install_github("betsig/notNMD")
library(notNMD)

# we will be looking at Ndufv3 (ENSMUSG00000024038.16) again
wds.ce <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="CE", idList="ENSMUSG00000024038.16")

# find exons in the gtf that overlap the skipped exon event
exons.ce <- findExonContainingTranscripts(wds.ce,
                                          exons = exons,
                                          transcripts = transcripts)
# make skipped and included exon transcripts
# removes the skipped exon from all transcripts which contain it
skippedExonTranscripts <- skipExonInTranscript(skippedExons = exons.ce,
                                               exons=exons,
                                               match="exact",
                                               whippetDataSet=wds.ce)
# make non-skipped exon transcripts
normalTranscripts <- exons[exons$transcript_id %in% exons.ce$transcript_id]

# get ORF details for each set of transcripts
# note that notNMD requires upstream orf annotations
orfs_normal <- getOrfs(normalTranscripts, BSgenome = g,
                       returnLongestOnly = FALSE, allFrames = TRUE, uORFs=TRUE)
orfs_skipped <- getOrfs(skippedExonTranscripts[skippedExonTranscripts$set ==
                                                                "skipped_exon"],
                        BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE, uORFs=TRUE)
orfs_included <- getOrfs(skippedExonTranscripts[skippedExonTranscripts$set ==
                                                               "included_exon"],
                         BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE, uORFs=TRUE)

# calculate NMD probability
# --- note that if you have a different method for assessing NMD potential, you may substitute the values here
orfs_normal$nmd_prob <- notNMD::predictNMD(orfs_normal, "prob")
orfs_normal$nmd_class <- notNMD::predictNMD(orfs_normal)
orfs_skipped$nmd_prob <- notNMD::predictNMD(orfs_skipped, "prob")
orfs_skipped$nmd_class <- notNMD::predictNMD(orfs_skipped)
orfs_included$nmd_prob <- notNMD::predictNMD(orfs_included, "prob")
orfs_included$nmd_class <- notNMD::predictNMD(orfs_included)

orfs_normal <- orfs_normal[which(!is.na(orfs_normal$orf_length)),]
orfs_skipped <- orfs_skipped[which(!is.na(orfs_skipped$orf_length)),]
orfs_included <- orfs_included[which(!is.na(orfs_included$orf_length)),]

# compare normal and skipped isoforms
# this time setting filterNMD to TRUE, which removes NMD targeted frames/isoforms where possible
orfChange <- orfDiff(orfsX = orfs_included,
                     orfsY = orfs_skipped,
                     filterNMD = TRUE,
                     geneSimilarity = TRUE,
                     compareUTR=TRUE,
                     allORFs = orfs_normal)
nmdChange <- attrChangeAltSpliced(orfs_included,orfs_skipped,
                                           attribute="nmd_prob",
                                           compareBy="gene",
                                           useMax=FALSE)
m <- match(orfChange$id, nmdChange$id)
orfChange <- cbind(orfChange, nmdChange[m,-1])
```

This adds an extra two columns to the orfChange output:

`nmd_prob_bygroup_x`: mininmum NMD probability in first set of transcripts (normalTranscripts)
`nmd_prob_bygroup_y`: mininmum NMD probability in second set of transcripts (skippedExonTranscripts)

```
# plot ORFs on transcripts
# annotate UTR/CDS locations
geneModel.skipped <- annotateGeneModel(skippedExonTranscripts[
    skippedExonTranscripts$set=="skipped_exon"], orfs_skipped)
geneModel.included <- annotateGeneModel(skippedExonTranscripts[
    skippedExonTranscripts$set=="included_exon"], orfs_included)

grtr.included <- GeneRegionTrack(geneModel.included,
                            name="Included Isoform",
                            showId=TRUE, fill="#4D7ABE",
                            transcriptAnnotation = "transcript")
# make tracks for non-nmd targeted CDS
grtrCDS.included <- GeneRegionTrack(
    geneModel.included[geneModel.included$feature == "CDS",],
                                name="Included Isoform CDS",
                                showId=TRUE,fill="#CB3634",
                                transcriptAnnotation = "transcript")

grtr.skipped <- GeneRegionTrack(geneModel.skipped,
                            name="Skipped Isoform",
                            showId=TRUE, fill="#4D7ABE",
                            transcriptAnnotation = "transcript")
# make tracks for non-nmd targeted CDS
grtrCDS.skipped <- GeneRegionTrack(
      geneModel.skipped[geneModel.skipped$feature == "CDS",],
                                name="Skipped Isoform CDS",
                                showId=TRUE,fill="#CB3634",
                                transcriptAnnotation = "transcript")
plotTracks(list(gtr, grtr.included, grtr.skipped,
grtrCDS.included,grtrCDS.skipped),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

```
# Full length transcripts in blue, CDS only in red
```

By using GeneStructureTools and examining visually, we find that skipping of exon 3 in Ndufv3 decreases the size open reading frame (from 468 to 104AA), by removing an in frame exon - UTR lengths are unchanged and no alternative ORF sequence is generated.

```
# we will be looking at Srsf1 (ENSMUSG00000018379.17) again
wds.ri <- filterWhippetEvents(wds, psiDelta=0,probability=0,
event="RI", idList="ENSMUSG00000018379.17")

# find flanking exons
exons.ri <- findIntronContainingTranscripts(wds.ri,
                                            exons)

# make retained and non-retained transcripts
# adds the intron into all transcripts which overlap it
retainedIntronTranscripts <- addIntronInTranscript(exons.ri,
                                                   exons = exons,
                                                   glueExons = TRUE,
                                                   whippetDataSet=wds.ri)
# make non-retained intron transcripts
normalTranscripts <- exons[exons$transcript_id %in%
                                        exons.ri$transcript_id]

# get ORF details for each set of transcripts
orfs_normal <- getOrfs(normalTranscripts, BSgenome = g,
                       returnLongestOnly = FALSE, allFrames = TRUE)
orfs_retained <- getOrfs(
retainedIntronTranscripts[retainedIntronTranscripts$set == "retained_intron"],
                        BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE)
orfs_spliced <- getOrfs(
retainedIntronTranscripts[retainedIntronTranscripts$set == "spliced_intron"],
                         BSgenome = g,
                        returnLongestOnly = FALSE, allFrames = TRUE)

# compare normal and retained isoforms
orfChange <- orfDiff(orfsX = orfs_spliced,
                     orfsY = orfs_retained,
                     filterNMD = FALSE,
                     geneSimilarity = TRUE,
                     compareUTR=TRUE)

orfChange
```

```
##                        id orf_length_bygroup_x orf_length_bygroup_y
## 1 chr11:88049216-88049411                  253                  201
##   utr3_length_bygroup_x utr3_length_bygroup_y utr5_length_bygroup_x
## 1                   411                   763                    37
##   utr5_length_bygroup_y filtered percent_orf_shared max_percent_orf_shared
## 1                    37    FALSE                  0              0.7944664
##   orf_percent_kept_x orf_percent_kept_y
## 1                  0                  0
```

```
# plot ORFs on transcripts

# annotate UTR/CDS locations
geneModel.retained <- annotateGeneModel(
retainedIntronTranscripts[retainedIntronTranscripts$set == "retained_intron"],
                                                                orfs_retained)
geneModel.spliced <- annotateGeneModel(
retainedIntronTranscripts[retainedIntronTranscripts$set == "spliced_intron"],
                                                                orfs_retained)

grtr.spliced <- GeneRegionTrack(geneModel.spliced,
                            name="Spliced Isoform",
                            showId=TRUE, fill="#4D7ABE",
                            transcriptAnnotation = "transcript")
grtrCDS.spliced <- GeneRegionTrack(
geneModel.spliced[geneModel.spliced$feature == "CDS",],
                                name="Spliced Isoform CDS",
                                showId=TRUE,fill="#CB3634",
                                transcriptAnnotation = "transcript")

grtr.retained <- GeneRegionTrack(geneModel.retained,
                            name="Retained Isoform",
                            showId=TRUE, fill="#4D7ABE",
                            transcriptAnnotation = "transcript")
grtrCDS.retained <- GeneRegionTrack(
geneModel.retained[geneModel.retained$feature == "CDS",],
                                name="Retained Isoform CDS",
                                showId=TRUE,fill="#CB3634",
                                transcriptAnnotation = "transcript")
gtr <- GenomeAxisTrack()
plotTracks(list(gtr, grtr.spliced, grtrCDS.spliced,
grtr.retained, grtrCDS.retained),
extend.left = 1000, extend.right = 1000)
```

![](data:image/png;base64...)

```
# Full length transcripts in blue, CDS only in red
```

By using GeneStructureTools and examining visually, we find that intron retention in Srsf1 decreases the size open reading frame (from 253 to 201AA), by generating a premature stop codon.

If notNMD is installed and loaded, `NMD` can be set to `TRUE` in the `whippetTranscriptChangeSummary` function.

```
summary <- whippetTranscriptChangeSummary(
whippetDataSet=wds,
exons = exons,
transcripts = transcripts,
BSgenome = g,
NMD = TRUE
)
```

# 6 DEXSeq

DEXSeq tests exons (or ‘exonic parts’) for differential usage between conditions. GeneStructureTools provides a few helper functions to help further annotate where in a transcript differential exon usage occurs.

## 6.1 GTF reannotation

**Annotation of 5’ and 3’ UTRs**

Reannotates any blocks in a gtf GRanges that are annotated as a UTR and have a CDS block annotated in the same transcript.

```
gtf <- rtracklayer::import(system.file("extdata","example_gtf.gtf",
package = "GeneStructureTools"))

table(gtf$type)
```

```
##
##        gene  transcript        exon         CDS start_codon  stop_codon
##          70         453        4039        2919         225         225
##         UTR
##         788
```

```
gtf_UTRannotated <- UTR2UTR53(gtf)
#some transfer from exon annotation to UTR3/5 due to overlapping with a reannotated UTR
table(gtf$type, gtf_UTRannotated$type)
```

```
##
##                CDS  UTR UTR3 UTR5 exon gene start_codon stop_codon transcript
##   gene           0    0    0    0    0   70           0          0          0
##   transcript     0    0    0    0    0    0           0          0        453
##   exon           0    0  233  132 3674    0           0          0          0
##   CDS         2919    0    0    0    0    0           0          0          0
##   start_codon    0    0    0    0    0    0         225          0          0
##   stop_codon     0    0   13    0    0    0           0        212          0
##   UTR            0    1  457  330    0    0           0          0          0
```

**Annotation of broader transcript biotypes**

Reannotates transcript biotypes into lncRNA, nmd, protein coding, pseudogene, retained intron, and short ncRNA categories.

```
gtf <- addBroadTypes(gtf)
table(gtf$transcript_type, gtf$transcript_type_broad)
```

```
##
##                                 lncRNA  nmd protein_coding pseudogene
##   antisense                         25    0              0          0
##   bidirectional_promoter_lncRNA      3    0              0          0
##   lincRNA                            7    0              0          0
##   macro_lncRNA                       5    0              0          0
##   miRNA                              0    0              0          0
##   non_stop_decay                     0   17              0          0
##   nonsense_mediated_decay            0 1091              0          0
##   polymorphic_pseudogene             0    0              0         18
##   processed_pseudogene               0    0              0          2
##   processed_transcript             308    0              0          0
##   protein_coding                     0    0           6577          0
##   pseudogene                         0    0              0          3
##   retained_intron                    0    0              0          0
##   sense_intronic                     3    0              0          0
##   sense_overlapping                  5    0              0          0
##   snRNA                              0    0              0          0
##   snoRNA                             0    0              0          0
##
##                                 retained_intron short_ncRNA
##   antisense                                   0           0
##   bidirectional_promoter_lncRNA               0           0
##   lincRNA                                     0           0
##   macro_lncRNA                                0           0
##   miRNA                                       0           6
##   non_stop_decay                              0           0
##   nonsense_mediated_decay                     0           0
##   polymorphic_pseudogene                      0           0
##   processed_pseudogene                        0           0
##   processed_transcript                        0           0
##   protein_coding                              0           0
##   pseudogene                                  0           0
##   retained_intron                           575           0
##   sense_intronic                              0           0
##   sense_overlapping                           0           0
##   snRNA                                       0           2
##   snoRNA                                      0           2
```

```
# Ful table of all transcript types and their broader version from gencode vM14
transcript_types <- read.delim("transcript_types_broad_table.txt")
transcript_types
```

```
##                       transcript_type transcript_type_broad    freq
## 1            3prime_overlapping_ncRNA                lncRNA      10
## 2                           antisense                lncRNA   14930
## 3       bidirectional_promoter_lncRNA                lncRNA     715
## 4                             lincRNA                lncRNA   30775
## 5                        macro_lncRNA                lncRNA       9
## 6                processed_transcript                lncRNA   78867
## 7                      sense_intronic                lncRNA     878
## 8                   sense_overlapping                lncRNA     215
## 9                      non_stop_decay                   nmd     313
## 10            nonsense_mediated_decay                   nmd  142846
## 11                     protein_coding        protein_coding 1243574
## 12             polymorphic_pseudogene            pseudogene     958
## 13               processed_pseudogene            pseudogene   17449
## 14                         pseudogene            pseudogene     365
## 15   transcribed_processed_pseudogene            pseudogene     513
## 16     transcribed_unitary_pseudogene            pseudogene      39
## 17 transcribed_unprocessed_pseudogene            pseudogene    1373
## 18    translated_processed_pseudogene            pseudogene      26
## 19                 unitary_pseudogene            pseudogene     199
## 20             unprocessed_pseudogene            pseudogene    8743
## 21                    retained_intron       retained_intron  101930
## 22                          IG_C_gene           short_ncRNA     225
## 23                    IG_C_pseudogene           short_ncRNA       4
## 24                          IG_D_gene           short_ncRNA      57
## 25                    IG_D_pseudogene           short_ncRNA       6
## 26                          IG_J_gene           short_ncRNA      42
## 27                         IG_LV_gene           short_ncRNA      18
## 28                      IG_pseudogene           short_ncRNA       5
## 29                          IG_V_gene           short_ncRNA    1767
## 30                    IG_V_pseudogene           short_ncRNA     423
## 31                              miRNA           short_ncRNA    4404
## 32                           misc_RNA           short_ncRNA    1132
## 33                            Mt_rRNA           short_ncRNA       4
## 34                            Mt_tRNA           short_ncRNA      44
## 35                           ribozyme           short_ncRNA      44
## 36                               rRNA           short_ncRNA     708
## 37                             scaRNA           short_ncRNA     102
## 38                              scRNA           short_ncRNA       2
## 39                             snoRNA           short_ncRNA    3016
## 40                              snRNA           short_ncRNA    2766
## 41                               sRNA           short_ncRNA       4
## 42                                TEC           short_ncRNA    6179
## 43                          TR_C_gene           short_ncRNA      98
## 44                          TR_D_gene           short_ncRNA      12
## 45                          TR_J_gene           short_ncRNA     210
## 46                    TR_J_pseudogene           short_ncRNA      20
## 47                          TR_V_gene           short_ncRNA    1206
## 48                    TR_V_pseudogene           short_ncRNA      81
```

## 6.2 DEXSeq event overlapping

DEXSeq data should be processed as per the DEXSeq manual for differential exon usage.
The script with details for how to generate the significant results table are in `inst/extdata/dexseq_process.R`.
You can process your own DEXSeq results from the `DEXSeqResults` object generated by `DEXSeqResults(dxd)`.

```
# load dexseq processed data
load("dexseq_processed.Rdata")
# create results data.frame from the DEXSeqResults object
dexseq_results <- as.data.frame(dxr1)
# 3395 events significant
dexseq_results.significant <- dexseq_results[which(dexseq_results$padj < 1e-12 & abs(dexseq_results$log2fold_21_01) > 1),]
write.table(dexseq_results.significant, file="dexseq_results_significant.txt",
            sep="\t", quote=FALSE)
```

```
# import dexseq gtf

gtf <- rtracklayer::import(system.file("extdata","example_gtf.gtf",
package = "GeneStructureTools"))
gtf <- UTR2UTR53(gtf)

dexseq_ranges <- rtracklayer::import(system.file("extdata",
"gencode.vM14.dexseq.gtf", package = "GeneStructureTools"))

dexseq_results.significant <- read.delim(system.file("extdata",
"dexseq_results_significant.txt", package = "GeneStructureTools"))

# find the exon type of the significant events
dexseq_results.significant$overlap_types <-
findDEXexonType(rownames(dexseq_results.significant), dexseq_ranges, gtf=gtf)
overlap_types <- table(dexseq_results.significant$overlap_types)

# broader definition
dexseq_results.significant$overlap_types_broad <- summariseExonTypes(dexseq_results.significant$overlap_types)
table(dexseq_results.significant$overlap_types_broad)
```

```
##
##            CDS           UTR3           UTR5 noncoding_exon    start_codon
##             11              6              3             10              3
##     stop_codon
##              7
```

# 7 Session Info

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
##  [1] Gviz_1.54.0                        BSgenome.Mmusculus.UCSC.mm10_1.4.3
##  [3] BSgenome_1.78.0                    rtracklayer_1.70.0
##  [5] BiocIO_1.20.0                      Biostrings_2.78.0
##  [7] XVector_0.50.0                     stringr_1.5.2
##  [9] GenomicRanges_1.62.0               Seqinfo_1.0.0
## [11] IRanges_2.44.0                     S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0                generics_0.1.4
## [15] GeneStructureTools_1.30.0          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] deldir_2.0-4                gridExtra_2.3
##   [5] httr2_1.2.1                 biomaRt_2.66.0
##   [7] rlang_1.1.6                 magrittr_2.0.4
##   [9] biovizBase_1.58.0           matrixStats_1.5.0
##  [11] compiler_4.5.1              RSQLite_2.4.3
##  [13] GenomicFeatures_1.62.0      png_0.1-8
##  [15] vctrs_0.6.5                 ProtGenerics_1.42.0
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] backports_1.5.0             dbplyr_2.5.1
##  [23] Rsamtools_2.26.0            rmarkdown_2.30
##  [25] UCSC.utils_1.6.0            tinytex_0.57
##  [27] bit_4.6.0                   xfun_0.53
##  [29] cachem_1.1.0                cigarillo_1.0.0
##  [31] GenomeInfoDb_1.46.0         jsonlite_2.0.0
##  [33] progress_1.2.3              blob_1.2.4
##  [35] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [37] jpeg_0.1-11                 parallel_4.5.1
##  [39] prettyunits_1.2.0           cluster_2.1.8.1
##  [41] VariantAnnotation_1.56.0    R6_2.6.1
##  [43] bslib_0.9.0                 stringi_1.8.7
##  [45] RColorBrewer_1.1-3          rpart_4.1.24
##  [47] jquerylib_0.1.4             Rcpp_1.1.0
##  [49] bookdown_0.45               SummarizedExperiment_1.40.0
##  [51] knitr_1.50                  base64enc_0.1-3
##  [53] Matrix_1.7-4                nnet_7.3-20
##  [55] tidyselect_1.2.1            rstudioapi_0.17.1
##  [57] stringdist_0.9.15           dichromat_2.0-0.1
##  [59] abind_1.4-8                 yaml_2.3.10
##  [61] codetools_0.2-20            curl_7.0.0
##  [63] lattice_0.22-7              tibble_3.3.0
##  [65] plyr_1.8.9                  Biobase_2.70.0
##  [67] KEGGREST_1.50.0             S7_0.2.0
##  [69] evaluate_1.0.5              foreign_0.8-90
##  [71] BiocFileCache_3.0.0         pillar_1.11.1
##  [73] BiocManager_1.30.26         filelock_1.0.3
##  [75] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [77] RCurl_1.98-1.17             ensembldb_2.34.0
##  [79] hms_1.1.4                   ggplot2_4.0.0
##  [81] scales_1.4.0                glue_1.8.0
##  [83] lazyeval_0.2.2              Hmisc_5.2-4
##  [85] tools_4.5.1                 interp_1.1-6
##  [87] data.table_1.17.8           GenomicAlignments_1.46.0
##  [89] XML_3.99-0.19               latticeExtra_0.6-31
##  [91] colorspace_2.1-2            AnnotationDbi_1.72.0
##  [93] htmlTable_2.4.3             restfulr_0.0.16
##  [95] Formula_1.2-5               cli_3.6.5
##  [97] rappdirs_0.3.3              S4Arrays_1.10.0
##  [99] dplyr_1.1.4                 AnnotationFilter_1.34.0
## [101] gtable_0.3.6                sass_0.4.10
## [103] digest_0.6.37               SparseArray_1.10.0
## [105] htmlwidgets_1.6.4           rjson_0.2.23
## [107] farver_2.1.2                memoise_2.0.1
## [109] htmltools_0.5.8.1           lifecycle_1.0.4
## [111] httr_1.4.7                  bit64_4.6.0-1
```