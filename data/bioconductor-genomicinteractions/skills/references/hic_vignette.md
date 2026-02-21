# HiC vignette for GenomicInteractions package

#### Liz Ing-Simmons

#### 2025-10-30

## Introduction

This vignette shows you how GenomicInteractions can be used to investigate significant interactions in HiC data that has been analysed using [HOMER](http://homer.salk.edu/homer/) software [1]. GenomicInteractions can take a HOMER [interaction file](http://homer.salk.edu/homer/interactions/HiCinteractions.html) as input.

HiC data comes from [chromosome conformation capture](http://en.wikipedia.org/wiki/Chromosome_conformation_capture) followed by high-throughput sequencing. Unlike 3C, 4C or 5C, which target specific regions, it can provide genome-wide information about the spatial proximity of regions of the genome. The raw data takes the form of paired-end reads connecting restriction fragments. The resolution of a HiC experiment is limited by the number of paired-end sequencing reads produced and by the sizes of restriction fragments. To increase the power to distinguish real interactions from random noise, HiC data is commonly analysed in bins from 20kb - 1Mb. There are a variety of tools available for binning the data, controlling for noise (e.g. self-ligations of restriction fragments), and finding significant interactions.

The data we are using comes from [this paper](http://genome.cshlp.org/content/23/12/2066.full) [2] and can be downloaded from [GEO](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE48763). It is HiC data from wild type mouse double positive thymocytes. The experiment was carried out using the HindIII restriction enzyme. The paired-end reads were aligned to the mm9 mouse genome assembly and HOMER software was used to filter reads and detect significant interactions at a resolution of 100kb. For the purposes of this vignette, we will consider only data from chromosomes 14 and 15.

## Making a GenomicInteractions object

Load the data by specifying the file location and experiment type. You can also include an experiment name and description.

```
library(Gviz)
library(GenomicInteractions)
library(GenomicRanges)
library(InteractionSet)
```

```
hic_file <- system.file("extdata", "Seitan2013_WT_100kb_interactions.txt",
                        package="GenomicInteractions")

hic_data <- makeGenomicInteractionsFromFile(hic_file,
                    type="homer",
                    experiment_name = "HiC 100kb",
                    description = "HiC 100kb resolution")
seqlengths(hic_data) <- c(chr15 = 103494974, chr14 = 125194864)
```

The `GenomicInteractions` class is an extension of the `GInteractions` class from the `InteractionSet` package. The object contains a set of regions involved in interactions, stored as a `GRanges` object, and two sets of indices giving the regions involved in each interaction (the anchors). Metadata for each interaction (e.g. p-value, FDR) is stored as a `DataFrame` accessed by `mcols()` or `elementMetadata()`, similar to the metadata of a simple `GRanges`. You can also access single metadata columns using `$`.

```
hic_data
```

```
## GenomicInteractions object with 23276 interactions and 14 metadata columns:
##           seqnames1             ranges1     seqnames2           ranges2 |
##               <Rle>           <IRanges>         <Rle>         <IRanges> |
##       [1]     chr15   97600000-97699999 ---     chr15 97500000-97599999 |
##       [2]     chr15   74800000-74899999 ---     chr15 74700000-74799999 |
##       [3]     chr14   55000000-55099999 ---     chr14 54800000-54899999 |
##       [4]     chr15   80400000-80499999 ---     chr15 80300000-80399999 |
##       [5]     chr14   55100000-55199999 ---     chr14 54800000-54899999 |
##       ...       ...                 ... ...       ...               ... .
##   [23272]     chr15   82900000-82999999 ---     chr15   6500000-6599999 |
##   [23273]     chr15 100500000-100599999 ---     chr15 89000000-89099999 |
##   [23274]     chr15   46500000-46599999 ---     chr15 19200000-19299999 |
##   [23275]     chr14   58500000-58599999 ---     chr14 15100000-15199999 |
##   [23276]     chr14   72100000-72199999 ---     chr14 47000000-47099999 |
##              counts     InteractionID       PeakID.1.   strand.1.
##           <integer>       <character>     <character> <character>
##       [1]       344     interaction66  chr15-97600000           +
##       [2]       373     interaction94  chr15-74800000           +
##       [3]       258    interaction103  chr14-55000000           +
##       [4]       397    interaction118  chr15-80400000           +
##       [5]       213    interaction122  chr14-55100000           +
##       ...       ...               ...             ...         ...
##   [23272]         7 interaction279065  chr15-82900000           +
##   [23273]         9 interaction279070 chr15-100500000           +
##   [23274]         9 interaction279096  chr15-46500000           +
##   [23275]         8 interaction279101  chr14-58500000           +
##   [23276]        10 interaction279102  chr14-72100000           +
##           Total.Reads.1.      PeakID.2.   strand.2. Total.Reads.2.    Distance
##                <integer>    <character> <character>      <integer> <character>
##       [1]           7144 chr15-97500000           +           8598       80527
##       [2]           8002 chr15-74700000           +          11112       93528
##       [3]           7617 chr14-54800000           +          11577      198082
##       [4]           9403 chr15-80300000           +          11387       80980
##       [5]           6775 chr14-54800000           +          11577      298783
##       ...            ...            ...         ...            ...         ...
##   [23272]           9936  chr15-6500000           +          12876    76405433
##   [23273]           8840 chr15-89000000           +          11127    11504595
##   [23274]          13170 chr15-19200000           +           9540    27303452
##   [23275]          14212 chr14-15100000           +           8057    43413143
##   [23276]          11299 chr14-47000000           +          13665    25090445
##           Expected.Reads   Z.score      LogP
##                <numeric> <numeric> <numeric>
##       [1]        59.6631   4.88746  -327.744
##       [2]        79.8436   4.30370  -290.945
##       [3]        37.4725   3.64848  -284.012
##       [4]        94.9088   3.99679  -274.607
##       [5]        25.4555   3.55835  -271.035
##       ...            ...       ...       ...
##   [23272]        1.52056   1.53689  -6.90821
##   [23273]        2.45306   1.30185  -6.90814
##   [23274]        2.45312   1.31508  -6.90780
##   [23275]        1.97143   1.40053  -6.90776
##   [23276]        2.96131   1.24805  -6.90776
##           FDR.Benjamini..based.on.3.68e.08.total.tests. Circos.Thickness
##                                               <numeric>        <integer>
##       [1]                                             0               30
##       [2]                                             0               26
##       [3]                                             0               26
##       [4]                                             0               24
##       [5]                                             0               24
##       ...                                           ...              ...
##   [23272]                                             1                2
##   [23273]                                             1                2
##   [23274]                                             1                2
##   [23275]                                             1                2
##   [23276]                                             1                2
##   -------
##   regions: 2154 ranges and 0 metadata columns
##   seqinfo: 2 sequences from an unspecified genome
```

```
mcols(hic_data)
```

```
## DataFrame with 23276 rows and 14 columns
##          counts     InteractionID       PeakID.1.   strand.1. Total.Reads.1.
##       <integer>       <character>     <character> <character>      <integer>
## 1           344     interaction66  chr15-97600000           +           7144
## 2           373     interaction94  chr15-74800000           +           8002
## 3           258    interaction103  chr14-55000000           +           7617
## 4           397    interaction118  chr15-80400000           +           9403
## 5           213    interaction122  chr14-55100000           +           6775
## ...         ...               ...             ...         ...            ...
## 23272         7 interaction279065  chr15-82900000           +           9936
## 23273         9 interaction279070 chr15-100500000           +           8840
## 23274         9 interaction279096  chr15-46500000           +          13170
## 23275         8 interaction279101  chr14-58500000           +          14212
## 23276        10 interaction279102  chr14-72100000           +          11299
##            PeakID.2.   strand.2. Total.Reads.2.    Distance Expected.Reads
##          <character> <character>      <integer> <character>      <numeric>
## 1     chr15-97500000           +           8598       80527        59.6631
## 2     chr15-74700000           +          11112       93528        79.8436
## 3     chr14-54800000           +          11577      198082        37.4725
## 4     chr15-80300000           +          11387       80980        94.9088
## 5     chr14-54800000           +          11577      298783        25.4555
## ...              ...         ...            ...         ...            ...
## 23272  chr15-6500000           +          12876    76405433        1.52056
## 23273 chr15-89000000           +          11127    11504595        2.45306
## 23274 chr15-19200000           +           9540    27303452        2.45312
## 23275 chr14-15100000           +           8057    43413143        1.97143
## 23276 chr14-47000000           +          13665    25090445        2.96131
##         Z.score      LogP FDR.Benjamini..based.on.3.68e.08.total.tests.
##       <numeric> <numeric>                                     <numeric>
## 1       4.88746  -327.744                                             0
## 2       4.30370  -290.945                                             0
## 3       3.64848  -284.012                                             0
## 4       3.99679  -274.607                                             0
## 5       3.55835  -271.035                                             0
## ...         ...       ...                                           ...
## 23272   1.53689  -6.90821                                             1
## 23273   1.30185  -6.90814                                             1
## 23274   1.31508  -6.90780                                             1
## 23275   1.40053  -6.90776                                             1
## 23276   1.24805  -6.90776                                             1
##       Circos.Thickness
##              <integer>
## 1                   30
## 2                   26
## 3                   26
## 4                   24
## 5                   24
## ...                ...
## 23272                2
## 23273                2
## 23274                2
## 23275                2
## 23276                2
```

```
head(hic_data$LogP)
```

```
## [1] -327.74 -290.94 -284.01 -274.61 -271.04 -234.65
```

```
hic_data$p.value <- exp(hic_data$LogP)
```

The set of all regions included in the object can be accessed using `regions()`, or the first and second anchors of the interactions can be accessed using `anchors()`. You can also choose to just return the indices of the ranges of `regions()` that correspond to the anchors.

We also provide convenience functions `anchorOne` and `anchorTwo` to return the first/second anchors as GRanges.

```
regions(hic_data)
```

```
## GRanges object with 2154 ranges and 0 metadata columns:
##          seqnames              ranges strand
##             <Rle>           <IRanges>  <Rle>
##      [1]    chr15     3000000-3099999      *
##      [2]    chr15     3100000-3199999      *
##      [3]    chr15     3200000-3299999      *
##      [4]    chr15     3300000-3399999      *
##      [5]    chr15     3400000-3499999      *
##      ...      ...                 ...    ...
##   [2150]    chr14 124700000-124799999      *
##   [2151]    chr14 124800000-124899999      *
##   [2152]    chr14 124900000-124999999      *
##   [2153]    chr14 125000000-125099999      *
##   [2154]    chr14 125100000-125189535      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome
```

```
anchors(hic_data, type = "first")
```

```
## GRanges object with 23276 ranges and 0 metadata columns:
##           seqnames              ranges strand
##              <Rle>           <IRanges>  <Rle>
##       [1]    chr15   97600000-97699999      *
##       [2]    chr15   74800000-74899999      *
##       [3]    chr14   55000000-55099999      *
##       [4]    chr15   80400000-80499999      *
##       [5]    chr14   55100000-55199999      *
##       ...      ...                 ...    ...
##   [23272]    chr15   82900000-82999999      *
##   [23273]    chr15 100500000-100599999      *
##   [23274]    chr15   46500000-46599999      *
##   [23275]    chr14   58500000-58599999      *
##   [23276]    chr14   72100000-72199999      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome
```

```
head(anchors(hic_data, type = "first", id = TRUE))
```

```
## [1]  939  711 1458  767 1459  629
```

```
anchorOne(hic_data)
```

```
## GRanges object with 23276 ranges and 0 metadata columns:
##           seqnames              ranges strand
##              <Rle>           <IRanges>  <Rle>
##       [1]    chr15   97600000-97699999      *
##       [2]    chr15   74800000-74899999      *
##       [3]    chr14   55000000-55099999      *
##       [4]    chr15   80400000-80499999      *
##       [5]    chr14   55100000-55199999      *
##       ...      ...                 ...    ...
##   [23272]    chr15   82900000-82999999      *
##   [23273]    chr15 100500000-100599999      *
##   [23274]    chr15   46500000-46599999      *
##   [23275]    chr14   58500000-58599999      *
##   [23276]    chr14   72100000-72199999      *
##   -------
##   seqinfo: 2 sequences from an unspecified genome
```

We can check that the anchors are of the expected size (100kb).

```
summary(width(regions(hic_data)))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   89536  100000  100000   99991  100000  100000
```

Some anchors are shorter than 100kb due to the bin being at the end of a chromosome. There are 23276 interactions in total, with a total of 447000 reads supporting them. To calculate the average number of reads per interaction, first use `interactionCounts()` to get the number of reads supporting each individual interaction.

```
head(interactionCounts(hic_data))
```

```
## [1] 344 373 258 397 213 441
```

```
mean(interactionCounts(hic_data))
```

```
## [1] 19.204
```

However, since we have FDRs and p-values, it is probably more informative to use these to find interactions of interest. Note that the FDR column in the dataset will be named differently depending on the number of interactions in your data. For simplicity in this document we will rename it!

```
plot(density(hic_data$p.value))
```

![](data:image/png;base64...)

```
hic_data$fdr <- hic_data$FDR.Benjamini..based.on.3.68e.08.total.tests.
plot(density(hic_data$fdr))
```

![](data:image/png;base64...)

## Summary statistics

The package provides some functions to plot summary statistics of your data that may be of interest, such as the percentage of interactions that are between regions on the same chromosome (*cis*-interactions) or on different chromosomes (*trans*-interactions), or the number of reads supporting each interaction. These plots can be used to assess the level of noise in your dataset - the presence of many interactions with high FDRs or low read counts suggests that the data may be noisy and contain a lot of false positive interactions. You can subset the GenomicInteractions object by FDR or by number of reads.

```
sum(hic_data$fdr < 0.1)
```

```
## [1] 8171
```

```
hic_data_subset <- hic_data[hic_data$fdr < 0.1]
```

```
plotCisTrans(hic_data)
```

![](data:image/png;base64...)

```
plotCisTrans(hic_data_subset)
```

![](data:image/png;base64...)

```
plotCounts(hic_data, cut=30)
```

![](data:image/png;base64...)

```
plotCounts(hic_data_subset, cut=30)
```

![](data:image/png;base64...)

Subsetting by FDR will tend to remove interactions that are supported by fewer reads. *Trans* interactions tend to have lower read support than *cis* interactions, so the percentage of *trans* interactions decreases.

## Annotation

One of the most powerful features of GenomicInteractions is that it allows you to annotate interactions by whether the anchors overlap genomic features of interest, such as promoters or enhancers.

Genome annotation data can be obtained from, for example, UCSC databases using the GenomicFeatures package. We will use promoters of Refseq genes extended to a width of 5kb. Downloading all the data can be a slow process, so the data for promoters for chromosomes 14 and 15 is provided with this package.

We will also use a set of putative enhancers defined in Shen et al 2012 using mouse ENCODE data.

```
## Not run
library(GenomicFeatures)
mm9.refseq.db <- makeTxDbFromUCSC(genome="mm9", table="refGene")
refseq.genes = genes(mm9.refseq.db)
refseq.transcripts = transcriptsBy(mm9.refseq.db, by="gene")
refseq.transcripts = refseq.transcripts[ names(refseq.transcripts) %in% unlist(refseq.genes$gene_id) ]
mm9_refseq_promoters <- promoters(refseq.transcripts, 2500,2500)
mm9_refseq_promoters <- unlist(mm9_refseq_promoters[seqnames(mm9_refseq_promoters) %in% c("chr14", "chr15")])
mm9_refseq_promoters <- unique(mm9_refseq_promoters) # some duplicate promoters from different transcript isoforms

#get gene symbols
mart = useMart("ensembl", dataset="mmusculus_gene_ensembl")
genes <- getBM(attributes = c("mgi_symbol", "refseq_mrna"), filter = "refseq_mrna",
               values = mm9_refseq_promoters$tx_name, mart = mart)
mm9_refseq_promoters$geneSymbol <- genes$mgi_symbol[match(mm9_refseq_promoters$tx_name, genes$refseq_mrna)]

names(mm9_refseq_promoters) <- mm9_refseq_promoters$geneSymbol
na.symbol <- is.na(names(mm9_refseq_promoters))
names(mm9_refseq_promoters)[na.symbol] <- mm9_refseq_promoters$tx_name[na.symbol]
```

```
#Not run

## get enhancers from http://chromosome.sdsc.edu/mouse/download.html
download.file("http://chromosome.sdsc.edu/mouse/download/thymus.zip", "thymus.zip")
unzip("thymus.zip")
thymus_enh <- read.table("thymus/thymus.enhancer.txt", sep="\t", stringsAsFactors = FALSE)
thymus_enh <- GRanges(seqnames=thymus_enh$V1, ranges=IRanges(thymus_enh$V2, width=1))
thymus_enh <- resize(thymus_enh, fix="center", width=500)
thymus_enh <- thymus_enh[seqnames(thymus_enh) %in% c("chr14", "chr15")]
names(thymus_enh) <- paste("ENH", as.character(thymus_enh), sep = "_")
```

`annotateInteractions` takes a list of features in GRanges or GRangesList format and annotates the interaction anchors based on overlap with these features. The list of annotation features should have descriptive names, as these names are stored in the annotated GenomicInteractions object and used to assign anchor (node) classes.

```
data("mm9_refseq_promoters")
data("thymus_enhancers")
annotation.features <- list(promoter = mm9_refseq_promoters, enhancer = thymus_enh)
annotateInteractions(hic_data_subset, annotation.features)
```

```
## Warning in annotateInteractions(hic_data_subset, annotation.features): Some
## features contain duplicate IDs which will result in duplicate annotations
```

```
## Annotating with promoter ...
```

```
## Annotating with enhancer ...
```

In addition, the features themselves should have names or IDs. These can be the `names()` of the feature object, or an “id” metadata column (note lowercase). These names or IDs for each feature are stored in the metadata columns of the regions of the GenomicInteractions object. Each anchor may overlap multiple features of each type, so the columns containing feature names or IDs are stored as lists.

```
head(regions(hic_data_subset))
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames          ranges strand |  node.class             promoter.id
##          <Rle>       <IRanges>  <Rle> | <character>                  <list>
##   [1]    chr15 3000000-3099999      * |      distal                    <NA>
##   [2]    chr15 3100000-3199999      * |    enhancer                    <NA>
##   [3]    chr15 3200000-3299999      * |    promoter Ccdc152,Sepp1,Sepp1,...
##   [4]    chr15 3300000-3399999      * |      distal                    <NA>
##   [5]    chr15 3400000-3499999      * |      distal                    <NA>
##   [6]    chr15 3500000-3599999      * |    promoter                 Ghr,Ghr
##                                                                enhancer.id
##                                                                     <list>
##   [1]                                                                 <NA>
##   [2] ENH_chr15:3122350-31..,ENH_chr15:3180350-31..,ENH_chr15:3183250-31..
##   [3]                        ENH_chr15:3214450-32..,ENH_chr15:3259750-32..
##   [4]                                                                 <NA>
##   [5]                                                                 <NA>
##   [6]                                                                 <NA>
##   -------
##   seqinfo: 2 sequences from an unspecified genome
```

```
head(regions(hic_data_subset)$promoter.id)
```

```
## [[1]]
## [1] NA
##
## [[2]]
## [1] NA
##
## [[3]]
## [1] "Ccdc152" "Sepp1"   "Sepp1"   "Sepp1"
##
## [[4]]
## [1] NA
##
## [[5]]
## [1] NA
##
## [[6]]
## [1] "Ghr" "Ghr"
```

## Node classes

Node classes (or anchor classes) are assigned to each anchor based on overlap with annotation features and the order of those features within the list passed to the annotation function. If the list is `list(promoter=..., transcript=...)` then an anchor which overlaps both a promoter and a transcript will be given the node class “promoter”. The features earlier in the list take priority. Any anchors which are not annotated with any of the given features will be assigned the class “distal”. In this case anchors can be “promoter”, “enhancer”, or “distal”.

As the anchors are large, most of them overlap at least one promoter or enhancer.

```
table(regions(hic_data_subset)$node.class)
```

```
##
##   distal enhancer promoter
##      989      275      890
```

## Interaction types

Interaction types are determined by the classes of the interacting nodes. As we only have two node classes, we have three possible interaction classes, summarised in the plot below. Most of the interactions are between promoters. We can subset the data to look at interaction types that are of particular interest.

```
plotInteractionAnnotations(hic_data_subset, legend = TRUE)
```

![](data:image/png;base64...)

Distal regions interacting with a promoter may contain regulatory elements such as enhancers or insulators. To get all promoter–distal interactions:

```
length(hic_data_subset[isInteractionType(hic_data_subset, "promoter", "distal")])
```

```
## [1] 492
```

As this is a common type of interaction of interest, there is a function specifically for identifying these interactions (see the reference manual or `help(isInteractionType)` for additional built in interaction types). `isInteractionType` can be used with any pair of node classes. There are also functions for identifying *cis* or *trans* interactions.

```
length(hic_data_subset[is.pd(hic_data_subset)])
```

```
## [1] 492
```

```
sum(is.trans(hic_data_subset))
```

```
## [1] 6
```

However in this case we have annotated the anchors with known enhancer positions, so we can subset the data to get just enhancer–promoter interactions.

To find the strongest promoter–enhancer interaction:

```
hic_data_ep <- hic_data_subset[isInteractionType(hic_data_subset, "promoter", "enhancer")]

max(interactionCounts(hic_data_ep))
```

```
## [1] 385
```

```
most_counts <- hic_data_ep[which.max(interactionCounts(hic_data_ep))]
most_counts
```

```
## GenomicInteractions object with 1 interaction and 16 metadata columns:
##       seqnames1           ranges1     seqnames2           ranges2 |    counts
##           <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
##   [1]     chr15 59400000-59499999 ---     chr15 59300000-59399999 |       385
##        InteractionID      PeakID.1.   strand.1. Total.Reads.1.      PeakID.2.
##          <character>    <character> <character>      <integer>    <character>
##   [1] interaction816 chr15-59400000           +          14076 chr15-59300000
##         strand.2. Total.Reads.2.    Distance Expected.Reads   Z.score      LogP
##       <character>      <integer> <character>      <numeric> <numeric> <numeric>
##   [1]           +          13320       79223         152.99   2.57926  -128.741
##       FDR.Benjamini..based.on.3.68e.08.total.tests. Circos.Thickness
##                                           <numeric>        <integer>
##   [1]                                             0               10
##           p.value       fdr
##         <numeric> <numeric>
##   [1] 1.22661e-56         0
##   -------
##   regions: 2154 ranges and 3 metadata columns
##   seqinfo: 2 sequences from an unspecified genome
```

Or the most significant promoter–enhancer interaction:

```
min(hic_data_ep$p.value)
```

```
## [1] 9.9935e-102
```

```
min_pval <- hic_data_ep[which.min(hic_data_ep$p.value)]
min_pval
```

```
## GenomicInteractions object with 1 interaction and 16 metadata columns:
##       seqnames1           ranges1     seqnames2           ranges2 |    counts
##           <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
##   [1]     chr15 59100000-59199999 ---     chr15 58800000-58899999 |       250
##        InteractionID      PeakID.1.   strand.1. Total.Reads.1.      PeakID.2.
##          <character>    <character> <character>      <integer>    <character>
##   [1] interaction188 chr15-59100000           +          13566 chr15-58800000
##         strand.2. Total.Reads.2.    Distance Expected.Reads   Z.score      LogP
##       <character>      <integer> <character>      <numeric> <numeric> <numeric>
##   [1]           +          11010      305729        44.2523   2.90834  -232.562
##       FDR.Benjamini..based.on.3.68e.08.total.tests. Circos.Thickness
##                                           <numeric>        <integer>
##   [1]                                             0               20
##            p.value       fdr
##          <numeric> <numeric>
##   [1] 9.99354e-102         0
##   -------
##   regions: 2154 ranges and 3 metadata columns
##   seqinfo: 2 sequences from an unspecified genome
```

The distance between these interacting regions, or any interacting regions, can be found using `calculateDistances`. For *trans* interactions the distance will be NA.

```
calculateDistances(most_counts, method="midpoint")
```

```
## [1] 100000
```

```
calculateDistances(min_pval,method="midpoint")
```

```
## [1] 300000
```

```
summary(calculateDistances(hic_data_subset,method="midpoint"))
```

```
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's
##    100000   1100000   6200000  15298995  22700000 112700000         6
```

## Visualising interactions of interest

The interaction with the highest number of counts in this dataset is between an anchor containing the promoter of a gene called Trib1, and an adjacent region containing more than ten putative enhancers.

```
anchorOne(most_counts)$promoter.id
```

```
## [[1]]
## [1] "Trib1"
```

```
anchorTwo(most_counts)$enhancer.id
```

```
## [[1]]
##  [1] "ENH_chr15:59317450-59317949" "ENH_chr15:59321250-59321749"
##  [3] "ENH_chr15:59339600-59340099" "ENH_chr15:59348250-59348749"
##  [5] "ENH_chr15:59352650-59353149" "ENH_chr15:59357650-59358149"
##  [7] "ENH_chr15:59362650-59363149" "ENH_chr15:59369750-59370249"
##  [9] "ENH_chr15:59380150-59380649" "ENH_chr15:59385400-59385899"
## [11] "ENH_chr15:59398650-59399149"
```

`GenomicInteractions` provides methods to visualise interactions using the `Gviz` package in order to investigate regions of interest further. For example, we can view interactions in the region around the Trib1 promoter by creating an `InteractionTrack`.

```
Trib1_region <- resize(mm9_refseq_promoters["Trib1"], fix = "center", width = 1000000)
interaction_track <- InteractionTrack(hic_data_subset, name = "HiC", chromosome = "chr15")
plotTracks(interaction_track, chromosome="chr15",
           from=start(Trib1_region), to=end(Trib1_region))
```

![](data:image/png;base64...)

Using functions from the `Gviz` package we can add more data to the plot to visualise features in this region and customise how this data is displayed. Here interactions within the region of interest are coloured red, and interactions with other regions of chr15 are shown in blue. The height of the arcs representing the interactions is scaled to the number of counts supporting them.

```
promoterTrack <- AnnotationTrack(mm9_refseq_promoters, genome="mm9", name="Promoters",
                             id=names(mm9_refseq_promoters),  featureAnnotation="id")
enhTrack <- AnnotationTrack(thymus_enh, genome="mm9", name="Enhancers", stacking = "dense")

displayPars(promoterTrack) <- list(fill = "deepskyblue", col = NA,
                                   fontcolor.feature = "black", fontsize=8,
                                   just.group="below")
displayPars(enhTrack) <- list(fill = "black", col = NA)
displayPars(interaction_track) = list(col.interactions="red",
                                      col.anchors.fill ="blue",
                                      col.anchors.line = "black",
                                      interaction.dimension="height",
                                      interaction.measure ="counts",
                                      plot.trans=FALSE,
                                      plot.outside = TRUE,
                                      col.outside="lightblue",
                                      anchor.height = 0.1)

plotTracks(list(interaction_track, promoterTrack, enhTrack),
           chromosome="chr15", from=start(Trib1_region), to=end(Trib1_region),
           sizes=c(0.6, 0.2, 0.2))
```

![](data:image/png;base64...)

You can see what customisation options are available for a Gviz track using `availableDisplayPars()`, and find more information about this and other track types in the Gviz vignette.

## Export to BED12 format

Interactions stored in a `GenomicInteractions` object can be exported to [BED12 format](http://bedtools.readthedocs.org/en/latest/content/general-usage.html) for viewing in a genome browser. Anchors are visualised as thick blocks connected by thinner interactions.

```
## Not run
export.bed12(hic_data_subset, fn="hic_data_FDR0.1.bed", drop.trans = TRUE)
```

## References

1. Heinz S, Benner C, Spann N, Bertolino E et al. Simple Combinations of Lineage-Determining Transcription Factors Prime cis-Regulatory Elements Required for Macrophage and B Cell Identities. Mol Cell (2010).
2. Seitan, VC et al. Cohesin-based chromatin interactions enable regulated gene expression within pre-existing architectural compartments. Genome Research (2013).
3. Shen, Y et al. A map of cis-regulatory sequences in the mouse genome. Nature (2012).