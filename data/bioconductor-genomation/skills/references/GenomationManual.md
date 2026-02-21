# genomation: a toolkit for annotation and visualization of genomic data

#### 2025-10-30

# 1 Introduction

![](data:image/png;base64...) `genomation` is a toolkit for annotation and in bulk visualization of genomic intervals (scored or unscored) over predefined regions. The genomic intervals which the package can handle can be anything with a minimal information of chromosome, start and end. The intervals could have any length and most of the time they are associated with a score. Typical examples of such data sets include aligned
reads from high-throughput sequencing (HTS) experiments, percent methylation values for CpGs (or other cytosines), locations of transcription factor binding, and so on. On the other hand, throughout the vignette we use the phrase “genomic annotation” to refer to the regions of the genome associated with a potential function which does not necessarily have a score (examples: CpG islands, genes, enhancers, promoter, exons, etc. ). These genomic annotations are usually the regions of interest, and distribution of genomic intervals over/around the annotations are can make the way for biological interpretation of the data. The pipeline for computational knowledge extraction consists of three steps: data filtering, integration of data from multiple sources or generation of predictive models and biological interpretation of produced models, which leads to novel hypotheses that can be tested in the wetlab.`genomation` aims to facilitate the integration of multiple sources of genomic intervals with genomic annotation or already published experimental results.

# 2 Access the data

High-throughput data which will be used to show the functonality of the `genomation` are located in two places. The annotation and cap analysis of gene expression (CAGE) data comes prepared with the `genomation` package, while the raw HTS data can be found in the sister package `genomationData`. To install the `genomation` and the complementary data package the from the Bioconductor repository, copy and paste the following lines into your R interpreter:

```
BiocManager::install('genomationData')
BiocManager::install('genomation')
```

The r Biocpkg(“genomationData”) vignette contains a verbose description of included files. To list the available data, type:

```
list.files(system.file('extdata',package='genomationData'))
```

```
##  [1] "H1.Bisulfite-Seq.combined.chr21.bedGraph.gz"
##  [2] "SamplesInfo.txt"
##  [3] "wgEncodeBroadHistoneH1hescCtcfStdAlnRep1.chr21.bam"
##  [4] "wgEncodeBroadHistoneH1hescCtcfStdAlnRep1.chr21.bam.bai"
##  [5] "wgEncodeBroadHistoneH1hescCtcfStdPk.broadPeak.gz"
##  [6] "wgEncodeBroadHistoneH1hescP300kat3bAlnRep1.chr21.bam"
##  [7] "wgEncodeBroadHistoneH1hescP300kat3bAlnRep1.chr21.bam.bai"
##  [8] "wgEncodeBroadHistoneH1hescP300kat3bPk.broadPeak.gz"
##  [9] "wgEncodeBroadHistoneH1hescSuz12051317AlnRep1.chr21.bam"
## [10] "wgEncodeBroadHistoneH1hescSuz12051317AlnRep1.chr21.bam.bai"
## [11] "wgEncodeBroadHistoneH1hescSuz12051317Pk.broadPeak.gz"
## [12] "wgEncodeHaibTfbsA549Rad21V0422111RawRep1.chr21.bw"
## [13] "wgEncodeHaibTfbsH1hescRad21V0416102AlnRep1.chr21.bam"
## [14] "wgEncodeHaibTfbsH1hescRad21V0416102AlnRep1.chr21.bam.bai"
## [15] "wgEncodeHaibTfbsH1hescRad21V0416102PkRep1.broadPeak.gz"
## [16] "wgEncodeRikenCageA549CellPapAlnRep1.chr21.bam"
## [17] "wgEncodeRikenCageA549CellPapAlnRep1.chr21.bam.bai"
## [18] "wgEncodeSydhTfbsH1hescZnf143IggrabAlnRep1.chr21.bam"
## [19] "wgEncodeSydhTfbsH1hescZnf143IggrabAlnRep1.chr21.bam.bai"
## [20] "wgEncodeSydhTfbsH1hescZnf143IggrabPk.narrowPeak.gz"
```

To see the descriptions of the files:

```
sampleInfo = read.table(system.file("extdata/SamplesInfo.txt", package = "genomationData"),
    header = TRUE, sep = "\t")
sampleInfo[1:5, 1:5]
```

```
##                                                 fileName dataOrigin cellType
## 1     wgEncodeBroadHistoneH1hescCtcfStdAlnRep1.chr21.bam     Encode   H1hesc
## 2   wgEncodeBroadHistoneH1hescP300kat3bAlnRep1.chr21.bam     Encode   H1hesc
## 3 wgEncodeBroadHistoneH1hescSuz12051317AlnRep1.chr21.bam     Encode   H1hesc
## 4   wgEncodeHaibTfbsH1hescRad21V0416102AlnRep1.chr21.bam     Encode   H1hesc
## 5    wgEncodeSydhTfbsH1hescZnf143IggrabAlnRep1.chr21.bam     Encode   H1hesc
##   sampleName experimentType
## 1       Ctcf        ChipSeq
## 2       P300        ChipSeq
## 3      Suz12        ChipSeq
## 4      Rad21        ChipSeq
## 5     Znf143        ChipSeq
```

Basic annotation data and processed experimental data can be found within the `genomation` package. The data can be accesed throught the data command or located in the extdata folder.

```
library(genomation)
data(cage)
data(cpgi)

list.files(system.file("extdata", package = "genomation"))
```

# 3 Data input

One of larger hindrances in computational genomics stems from the myriad of formats that are used to store the data. Although some formats have been selected as de facto standards for specific kind of biological data (e.g. BAM, VCF), almost all publications come with supplementary tables that do not have the same structure, but hold similar information. The tables usually have a tabular format, contain the locationof elements in genomic coordinates and various metadata colums. `genomation` contais functions to read genomic intervals and genomic annotation provided they are in a tabular format. These functions will read the data from flat files into GRanges or GRangesList objects.

readGeneric is the workhorse of the `genomation` package. It is a function developed specifically for input of genomic data in tabular formats, and their conversion to a GRanges object. By default, the function persumes that the file is a standard .bed file containing columns chr, start, end.

```
library(genomation)
tab.file1 = system.file("extdata/tab1.bed", package = "genomation")
readGeneric(tab.file1, header = TRUE)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]    chr21 9437272-9439473      *
##   [2]    chr21 9483485-9484663      *
##   [3]    chr21 9647866-9648116      *
##   [4]    chr21 9708935-9709231      *
##   [5]    chr21 9825442-9826296      *
##   [6]    chr21 9909011-9909218      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

If the file contains meta data columns (as in extended bed format), it is possible to read all or some of the additional columns. To select columns which you want to read in, use the meta.col argument

```
readGeneric(tab.file1, header = TRUE, keep.all.metadata = TRUE)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames          ranges strand |    cpgNum     gcNum    perCpg
##          <Rle>       <IRanges>  <Rle> | <integer> <integer> <numeric>
##   [1]    chr21 9437272-9439473      * |       285      1426      25.9
##   [2]    chr21 9483485-9484663      * |       165       818      28.0
##   [3]    chr21 9647866-9648116      * |        18       168      14.4
##   [4]    chr21 9708935-9709231      * |        31       218      20.9
##   [5]    chr21 9825442-9826296      * |       120       568      28.1
##   [6]    chr21 9909011-9909218      * |        20       143      19.3
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
readGeneric(tab.file1, header = TRUE, meta.col = list(CpGnum = 4))
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames          ranges strand |    CpGnum
##          <Rle>       <IRanges>  <Rle> | <integer>
##   [1]    chr21 9437272-9439473      * |       285
##   [2]    chr21 9483485-9484663      * |       165
##   [3]    chr21 9647866-9648116      * |        18
##   [4]    chr21 9708935-9709231      * |        31
##   [5]    chr21 9825442-9826296      * |       120
##   [6]    chr21 9909011-9909218      * |        20
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

If the file contains header, the function will automatically recognize the columns using the header names.

```
readGeneric(tab.file1, header = TRUE, keep.all.metadata = TRUE)
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames          ranges strand |    cpgNum     gcNum    perCpg
##          <Rle>       <IRanges>  <Rle> | <integer> <integer> <numeric>
##   [1]    chr21 9437272-9439473      * |       285      1426      25.9
##   [2]    chr21 9483485-9484663      * |       165       818      28.0
##   [3]    chr21 9647866-9648116      * |        18       168      14.4
##   [4]    chr21 9708935-9709231      * |        31       218      20.9
##   [5]    chr21 9825442-9826296      * |       120       568      28.1
##   [6]    chr21 9909011-9909218      * |        20       143      19.3
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

If the files have permutted columns, such that the first three do not represent chromosome, start and end, you can select an arbitrary set of columns using the chr, start and end arguments.

```
tab.file2 = system.file("extdata/tab2.bed", package = "genomation")
readGeneric(tab.file2, chr = 3, start = 2, end = 1)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]    chr21 9437272-9439473      *
##   [2]    chr21 9483485-9484663      *
##   [3]    chr21 9647866-9648116      *
##   [4]    chr21 9708935-9709231      *
##   [5]    chr21 9825442-9826296      *
##   [6]    chr21 9909011-9909218      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

readGeneric function can easily be extended to read almost any kind of biological data. As an example we have provided convenience functions to read the Encode narrowPeak and broadPeak formats, and gtf formatted files.

```
gff.file = system.file("extdata/chr21.refseq.hg19.gtf", package = "genomation")
gff = gffToGRanges(gff.file)
head(gff)
```

```
## GRanges object with 6 ranges and 6 metadata columns:
##       seqnames          ranges strand |       source     type     score
##          <Rle>       <IRanges>  <Rle> |     <factor> <factor> <numeric>
##   [1]    chr21 9825832-9826011      + | hg19_refGene     exon         0
##   [2]    chr21 9826203-9826263      + | hg19_refGene     exon         0
##   [3]    chr21 9907189-9907492      - | hg19_refGene     exon         0
##   [4]    chr21 9909047-9909277      - | hg19_refGene     exon         0
##   [5]    chr21 9966322-9966380      - | hg19_refGene     exon         0
##   [6]    chr21 9968516-9968593      - | hg19_refGene     exon         0
##           phase     gene_id transcript_id
##       <integer> <character>   <character>
##   [1]      <NA>   NR_037421     NR_037421
##   [2]      <NA>   NR_037458     NR_037458
##   [3]      <NA>   NR_038328     NR_038328
##   [4]      <NA>   NR_038328     NR_038328
##   [5]      <NA>   NR_038328     NR_038328
##   [6]      <NA>   NR_038328     NR_038328
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

In order to split the last column of the gff file, use the split.group=TRUE argument.

```
gff = gffToGRanges(gff.file, split.group = TRUE)
head(gff)
```

There are specific functions to read genomic annotation from flat bed files. readFeatureFlank is a convenience function used to get the ranges flanking the set of interest. As an example, it could be used to get the CpG island shores, which have been shown to harbour condition specific differential methylation.

```
# reading genes stored as a BED files
cpgi.file = system.file("extdata/chr21.CpGi.hg19.bed", package = "genomation")
cpgi.flanks = readFeatureFlank(cpgi.file)
head(cpgi.flanks$flanks)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames          ranges strand
##          <Rle>       <IRanges>  <Rle>
##   [1]    chr21 9823442-9825441      *
##   [2]    chr21 9826297-9828296      *
##   [3]    chr21 9907011-9909010      *
##   [4]    chr21 9909219-9911218      *
##   [5]    chr21 9966264-9968263      *
##   [6]    chr21 9968621-9970620      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# 4 Extraction and visualization of genomic data

A standard step in a computational genomics experiment is visualization of average enrichment over a certain predefined set of ranges, such as mean coverage of a certain histone modification around a transcription factor binding site, or visualization of histone positions around transcription start sites.

## 4.1 Extraction of data over genomic windows

*ScoreMatrix* and *ScoreMatrixBin* are functions used to extract data over predefined windows.

*ScoreMatrix* is used when all of the windows have the same width, such as a designated area around the transcription start site, while the *ScoreMatrixBin* is designed for use with windows of unequal width (e.g. enrichment of methylation over exons).

Both functions have 2 main arguments: *target* and *windows*. *target* is the data that we want to extract, while the *windows* represents the regions over which we want to see the enrichment. The target data can be in 3 forms: a GRanges, a RLeList or a path to an indexed .bam file. The *windows* can be GRanges or GRangesList object.

As an example we will extract the density of cage tags around the promoters on the human chromosome 21.

```
data(cage)
data(promoters)
sm = ScoreMatrix(target = cage, windows = promoters)
```

```
## Warning in .local(target, windows, strand.aware): 2 windows fall off the target
```

```
sm
```

```
##   scoreMatrix with dims: 1055 2001
```

*ScoreMatrixBin* function has an additional *bin.num* argument which specifies the number of bins that will represent each window
(ie. it converts windows of unequal width into ones of equal width.). By default, the binning function is set to *mean*.

```
data(cage)
gff.file = system.file("extdata/chr21.refseq.hg19.gtf", package = "genomation")
exons = gffToGRanges(gff.file, filter = "exon")
sm = ScoreMatrixBin(target = cage, windows = exons, bin.num = 50)
sm
```

Running *ScoreMatrixBin* with *bin.num=50* on a set of exons warned us that some of the exons are shorter than 50 bp and were thus removed from the set before binning. The rownames of the resulting *ScoreMatrix* object correspond to the ranges that were used to construct the windows (e.g. row name 10 means that the 10th element in the target GRanges object was used to extract the data). If a certain rowname is not present in the ScoreMatrix object, that means that the corresponding range was filtered out (e.g. the range could have been on a chromosome that was not present in the target).

The *windows* of *ScoreMatrixBin* might be not only GRanges, but also GRangesList object. For instance, *ScoreMatrixBin* can be used to calculate transcript coverage of a set of exons. In the example below, *ScoreMatrixBin* function calculates coverage of concatenated exons within each transcript together, bins them into 50 bins and calculate average coverage within bins.

```
data(cage)
library(GenomicRanges)
gff.file = system.file("extdata/chr21.refseq.hg19.gtf", package = "genomation")
exons = gffToGRanges(gff.file, filter = "exon")
transcripts = split(exons, exons$transcript_id)
sm = ScoreMatrixBin(target = cage, windows = transcripts, bin.num = 10)
sm
```

To simultaneously work on multiple files you can use the *ScoreMatrixList* function. The function also has 2 obligatory arguments *targets* and *windows*. While the *windows* is the same as in *ScoreMatrix*, the targets argument contains results from multiple experiments. It can be in one of the three formats: a list of RleLists, a list of GRanges (or a GRangesList object), or a character vector designating a set of .bam or .bigWig files.

```
data(promoters)
data(cpgi)
data(cage)

cage$tpm = NULL
targets = list(cage = cage, cpgi = cpgi)
sm = ScoreMatrixList(targets = targets, windows = promoters, bin.num = 50)
```

```
## Warning in .local(target, windows, bin.num, bin.op, strand.aware): 2 windows
## fall off the target
```

```
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
```

```
## Warning in .local(target, windows, bin.num, bin.op, strand.aware): 2 windows
## fall off the target
```

```
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
## Warning in listSliceMean(mat, bin.num): subscript out of bounds (index 2001 >=
## vector size 2001)
```

```
sm
```

```
## scoreMatrixlist of length:2
```

```
## 1. scoreMatrix with dims: 1055 50
```

```
## 2. scoreMatrix with dims: 1055 50
```

If all of the windows have the same width *ScoreMatrixList* will use the *ScoreMatrix* function. That can be overridden by explicitly specifying the *bin.num* argument, as we did in the example.

## 4.2 Visualization of multiple genomic experiments

There are 2 basic modes of visualization of enrichment over windows: either as a heatmap, or as a histogram. *heatMatrix*, *plotMeta* and *multiHeatMatrix* are functions for visualization of *ScoreMatrix* and *ScoreMatrixList* objects.

We will plot the distribution of CAGE tags around promoters on human chr21.

```
data(cage)
data(promoters)
sm = ScoreMatrix(target = cage, windows = promoters)

heatMatrix(sm, xcoords = c(-1000, 1000))
plotMeta(sm, xcoords = c(-1000, 1000))
```

![](data:image/png;base64...)![](data:image/png;base64...)

The *heatMatrix* function can also take a list of numeric vectors designating row names, or a factor variable that represent our annotation over the windows.

```
library(GenomicRanges)
data(cage)
data(promoters)
data(cpgi)

sm = ScoreMatrix(target = cage, windows = promoters, strand.aware = TRUE)
cpg.ind = which(countOverlaps(promoters, cpgi) > 0)
nocpg.ind = which(countOverlaps(promoters, cpgi) == 0)
heatMatrix(sm, xcoords = c(-1000, 1000), group = list(CpGi = cpg.ind, noCpGi = nocpg.ind))
```

![](data:image/png;base64...)

Because the enrichment in windows can have a high dynamic range, it is sometimes convenient to scale the matrix before plotting.

```
sm.scaled = scaleScoreMatrix(sm)
heatMatrix(sm.scaled, xcoords = c(-1000, 1000), group = list(CpGi = cpg.ind, noCpGi = nocpg.ind))
```

![](data:image/png;base64...)

Several experiments can be plotted in a side by side fashion using a combination of ScoreMatrixList and multiHeatMatrix.

```
cage$tpm = NULL
targets = list(cage = cage, cpgi = cpgi)
sml = ScoreMatrixList(targets = targets, windows = promoters, bin.num = 50, strand.aware = TRUE)
multiHeatMatrix(sml, xcoords = c(-1000, 1000))
```

![](data:image/png;base64...)

We can put the clustering function clustfun to see whether there are any patterns present in the data.

```
multiHeatMatrix(sml, xcoords = c(-1000, 1000), clustfun = function(x) kmeans(x, centers = 2)$cluster)
```

![](data:image/png;base64...)

More advance usage of the ScoreMatrix family of functions and their visualtization can be found in the specific use-cases at the end of the vignette.

# 5 Annotation of genomic intervals

Searching for correlation between sets of genomic intervals is a standard exploratory method in computational genomics. It is usually done by looking at the overlap between 2 or more sets of ranges and calculating various overlap statistics. `genomation` contains two sets of functions for annotation of ranges: the first one is used to facilitate the general annotation of any sets of ranges, while the second one is used to annotate a given feature with gene structures (promoter, exon, intron).

## 5.1 Annotation by generic features

Firstly, we will select the broadPeak files from the `genomatonData` package, and read in the peaks for the Ctcf transcription factor

```
library(genomationData)
genomationDataPath = system.file("extdata", package = "genomationData")
sampleInfo = read.table(file.path(genomationDataPath, "SamplesInfo.txt"), header = TRUE,
    sep = "\t", stringsAsFactors = FALSE)

peak.files = list.files(genomationDataPath, full.names = TRUE, pattern = "broadPeak")
names(peak.files) = sampleInfo$sampleName[match(basename(peak.files), sampleInfo$fileName)]

ctcf.peaks = readBroadPeak(peak.files["Ctcf"])
```

Now we will annotate the human the Ctcf binding sites using the CpG islands. Because the CpG islands are restricted to chromosomes 21 and 22, we will set the *intersect.chr = TRUE*, which will limit the analysis only to the chromosomes that are present in both data sets.

```
data(cpgi)
peak.annot = annotateWithFeature(ctcf.peaks, cpgi, intersect.chr = TRUE)
```

```
## intersecting chromosomes...
```

```
peak.annot
```

```
## summary of target set annotation with feature annotation:
```

```
## Rows in target set: 3964
```

```
## ----------------------------
```

```
## percentage of target elements overlapping with features:
```

```
##  cpgi other
##  7.62 92.38
```

```
##
```

```
## percentage of feature elements overlapping with target:
```

```
## [1] 36.94
```

```
##
```

The output of the annotateWithFeature function shows three types of information: The total number of elements in the target dataset, the percentage of target dataset that overlaps with the feature dataset. And the percentage of the feature elements that overlap the target.

## 5.2 Annotation of genomic intervals by gene structures

To find the distribution of our designated intervals around gene structures, we will first read the transcript features from a file using the *readTranscriptFeatures* function. *readTranscriptFeatures* reads a bed12 formatted file and parses the coordinates into a *GRangesList* containing four elements: exons, introns. promoters and transcription start sites (TSSes).

```
bed.file = system.file("extdata/chr21.refseq.hg19.bed", package = "genomation")
gene.parts = readTranscriptFeatures(bed.file)
```

```
## Reading the table...
```

```
## Calculating intron coordinates...
```

```
## Calculating exon coordinates...
```

```
## Calculating TSS coordinates...
```

```
## Calculating promoter coordinates...
```

```
## Outputting the final GRangesList...
```

*annotateWithGeneParts* will give us the overlap statistics between our CTCF peaks and gene structures. We will again use the *intersect.chr=TRUE* to limit the analysis.

```
ctcf.annot = annotateWithGeneParts(ctcf.peaks, gene.parts, intersect.chr = TRUE)
```

```
## intersecting chromosomes...
```

```
ctcf.annot
```

```
## Summary of target set annotation with genic parts
```

```
## Rows in target set: 1681
```

```
## -----------------------
```

```
## percentage of target features overlapping with annotation:
```

```
##   promoter       exon     intron intergenic
##       9.58      13.50      47.65      47.17
```

```
##
## percentage of target features overlapping with annotation:
```

```
## (with promoter > exon > intron precedence):
```

```
##   promoter       exon     intron intergenic
##       9.58       7.91      35.34      47.17
```

```
##
```

```
## percentage of annotation boundaries with feature overlap:
```

```
## promoter     exon   intron
##    38.36    15.40    29.33
```

```
##
```

```
## summary of distances to the nearest TSS:
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##       0    7978   28473   66058   74688 1194683
```

```
##
```

annotateWithGeneParts can also take a set of feature ranges as an argument. We will use the readGeneric function to load all of the broadPeak files in the `genomationData`, which we will then annotate.

```
peaks = GRangesList(lapply(peak.files, readGeneric))
names(peaks) = names(peak.files)
annot.list = annotateWithGeneParts(peaks, gene.parts, intersect.chr = TRUE)
```

```
## Working on: Ctcf
```

```
## intersecting chromosomes...
```

```
## Working on: P300
```

```
## intersecting chromosomes...
```

```
## Working on: Suz12
```

```
## intersecting chromosomes...
```

```
## Working on: Rad21
```

```
## intersecting chromosomes...
```

Gene annotation of multiple feature objects can be visualized in a form of a heatmap, where rows represent samples, columns the gene structure, and the value is the percentage of overlap given by priority. If *cluster=TRUE*, then the function will use hierarhical clustering to order the heatmap.

```
plotGeneAnnotation(annot.list)
plotGeneAnnotation(annot.list, cluster = TRUE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 6 Use cases for `genomation` package

The `genomation` package provides generalizable functions for genomic data analysis and visualization. Below we will demonstrate the functionality on specific use cases

## 6.1 Visualization of ChiP sequencing data

We will visualize the binding profiles of 6 transcription factors around the Ctcf binding sites.

In the fist step we will select the \*.bam files containing mapped reads.

```
genomationDataPath = system.file("extdata", package = "genomationData")
bam.files = list.files(genomationDataPath, full.names = TRUE, pattern = "bam$")
bam.files = bam.files[!grepl("Cage", bam.files)]
```

Firstly, we will read in the Ctcf peaks, filter regions from human chromosome 21, and order them by their signal values. In the end we will resize all ranges to have a uniform width of 500 bases, fixed on the center of the peak.

```
ctcf.peaks = readBroadPeak(file.path(genomationDataPath, "wgEncodeBroadHistoneH1hescCtcfStdPk.broadPeak.gz"))
ctcf.peaks = ctcf.peaks[seqnames(ctcf.peaks) == "chr21"]
ctcf.peaks = ctcf.peaks[order(-ctcf.peaks$signalValue)]
ctcf.peaks = resize(ctcf.peaks, width = 1000, fix = "center")
```

In order to extract the coverage values of all transcription factors around chipseq peaks, we will use the *ScoreMatrixList* function. *ScoreMatrixList* assign names to each element of the list based on the names of the bam files. We will use the names of the files to find the corresponding names of each sample in the SamplesInfo.txt. Using the *heatmapProfile* on our *ScoreMatrixList*, we can plot the underlying signal side by side.

```
sml = ScoreMatrixList(bam.files, ctcf.peaks, bin.num = 50, type = "bam")
sampleInfo = read.table(system.file("extdata/SamplesInfo.txt", package = "genomationData"),
    header = TRUE, sep = "\t")
names(sml) = sampleInfo$sampleName[match(names(sml), sampleInfo$fileName)]
multiHeatMatrix(sml, xcoords = c(-500, 500), col = c("lightgray", "blue"))
```

![Heatmap profile of unscaled coverage shows a slight colocalization of Ctcf, Rad21 and Znf143.](data:image/png;base64...)

Heatmap profile of unscaled coverage shows a slight colocalization of Ctcf, Rad21 and Znf143.

Because of the large range of signal values in chipseq peaks, the *heatmapProfile* will not show the true extent of colocalization. To get around this, it is advisable to independently scale the rows of each element in the ScoreMatrixList.

```
sml.scaled = scaleScoreMatrixList(sml)
multiHeatMatrix(sml.scaled, xcoords = c(-500, 500), col = c("lightgray", "blue"))
```

![Heatmap profile of scaled coverage shows much stronger colocalization   of the transcription factors; nevertheless, it is evident that some of the CTCF   peaks have a very weak enrichment](data:image/png;base64...)

Heatmap profile of scaled coverage shows much stronger colocalization of the transcription factors; nevertheless, it is evident that some of the CTCF peaks have a very weak enrichment

## 6.2 Combinatorial binding of transcription factors

In the first step we will read all peak files into a GRanges list. We will use the SamplesInfo file from the `genomationData` to get he names of the samples. Four of the peak files are in the Encode broadPeak format, while one is in the narrowPeak. To read the files, we will use the readGeneric function. It enables us to select from the files only columns of interest. As the last step, we will restrict ourselves to peaks that are located on chromosome 21 and have width 100 and 1000 bp

```
genomationDataPath = system.file("extdata", package = "genomationData")
sampleInfo = read.table(file.path(genomationDataPath, "SamplesInfo.txt"), header = TRUE,
    sep = "\t", stringsAsFactors = FALSE)

peak.files = list.files(genomationDataPath, full.names = TRUE, pattern = "Peak.gz$")
peaks = list()
for (i in 1:length(peak.files)) {
    file = peak.files[i]
    name = sampleInfo$sampleName[match(basename(file), sampleInfo$fileName)]
    message(name)
    peaks[[name]] = readGeneric(file, meta.col = list(score = 5))
}
```

```
## Ctcf
```

```
## P300
```

```
## Suz12
```

```
## Rad21
```

```
## Znf143
```

```
peaks = GRangesList(peaks)
peaks = peaks[seqnames(peaks) == "chr21" & width(peaks) < 1000 & width(peaks) > 100]
```

To find the combination of binding sites we will use the *findFeatureComb* function. It takes a granges list object, finds the union of the ranges and designates each range by the combination of overlaps from the original set. By default, the returned ranges will have a numeric *class* meta data column, which designates the correponding combination. If you are interested in the names of the TF which make the combinations, put the *use.names=TRUE*.

```
tf.comb = findFeatureComb(peaks, width = 1000)
```

To visualize the results, we will plot the enricment of resulting regions. Before doing that we will order the regions by their *class* argument.

```
tf.comb = tf.comb[order(tf.comb$class)]
bam.files = list.files(genomationDataPath, full.names = TRUE, pattern = "bam$")
bam.files = bam.files[!grepl("Cage", bam.files)]
sml = ScoreMatrixList(bam.files, tf.comb, bin.num = 20, type = "bam")
names(sml) = sampleInfo$sampleName[match(names(sml), sampleInfo$fileName)]
sml.scaled = scaleScoreMatrixList(sml)
multiHeatMatrix(sml.scaled, xcoords = c(-500, 500), col = c("lightgray", "blue"))
```

![](data:image/png;base64...)

The plot shows perfectly how misleading the peak calling process can be. Although the plots show that CTFC, Rad21 and Znf143 have almost perfect colozalization, peak callers have trouble identifying peaks in regions with lower enrichments and as a result, we get different statistics when using overlaps.

### 6.2.1 Using data from AnnotationHub

We can also use data from AnnotationHub since it can return data as GRanges object. Below we download CpG island and DNAse peak locations from AnnotationHub and get a scoreMatrix on the CpG islands.

```
library(AnnotationHub)
ah = AnnotationHub()
# retrieve CpG island data from annotationHub
cpgi_query <- query(ah, c("CpG Islands", "UCSC", "hg19"))
cpgi <- ah[[names(cpgi_query)]]
dnase_query <- query(ah, c("wgEncodeOpenChromDnase8988tPk.narrowPeak.gz", "UCSC",
    "hg19"))
dnaseP <- ah[[names(dnase_query)]]
sm = ScoreMatrixBin(target = dnaseP, windows = cpgi, strand.aware = FALSE)
```

# 7 sessionInfo

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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
## [1] GenomicRanges_1.62.0  Seqinfo_1.0.0         IRanges_2.44.0
## [4] S4Vectors_0.48.0      BiocGenerics_0.56.0   generics_0.1.4
## [7] genomationData_1.41.0 genomation_1.42.0     knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 impute_1.84.0
##  [3] gtable_0.3.6                rjson_0.2.23
##  [5] xfun_0.53                   bslib_0.9.0
##  [7] ggplot2_4.0.0               Biobase_2.70.0
##  [9] lattice_0.22-7              seqPattern_1.42.0
## [11] tzdb_0.5.0                  vctrs_0.6.5
## [13] tools_4.5.1                 bitops_1.0-9
## [15] curl_7.0.0                  parallel_4.5.1
## [17] tibble_3.3.0                pkgconfig_2.0.3
## [19] KernSmooth_2.23-26          Matrix_1.7-4
## [21] data.table_1.17.8           BSgenome_1.78.0
## [23] RColorBrewer_1.1-3          S7_0.2.0
## [25] cigarillo_1.0.0             lifecycle_1.0.4
## [27] stringr_1.5.2               compiler_4.5.1
## [29] farver_2.1.2                Rsamtools_2.26.0
## [31] Biostrings_2.78.0           codetools_0.2-20
## [33] htmltools_0.5.8.1           sass_0.4.10
## [35] RCurl_1.98-1.17             yaml_2.3.10
## [37] pillar_1.11.1               crayon_1.5.3
## [39] jquerylib_0.1.4             BiocParallel_1.44.0
## [41] DelayedArray_0.36.0         cachem_1.1.0
## [43] abind_1.4-8                 tidyselect_1.2.1
## [45] digest_0.6.37               stringi_1.8.7
## [47] reshape2_1.4.4              dplyr_1.1.4
## [49] restfulr_0.0.16             fastmap_1.2.0
## [51] archive_1.1.12              cli_3.6.5
## [53] SparseArray_1.10.0          magrittr_2.0.4
## [55] S4Arrays_1.10.0             dichromat_2.0-0.1
## [57] XML_3.99-0.19               readr_2.1.5
## [59] scales_1.4.0                bit64_4.6.0-1
## [61] plotrix_3.8-4               rmarkdown_2.30
## [63] XVector_0.50.0              httr_1.4.7
## [65] matrixStats_1.5.0           bit_4.6.0
## [67] hms_1.1.4                   evaluate_1.0.5
## [69] BiocIO_1.20.0               rtracklayer_1.70.0
## [71] rlang_1.1.6                 Rcpp_1.1.0
## [73] gridBase_0.4-7              glue_1.8.0
## [75] formatR_1.14                vroom_1.6.6
## [77] jsonlite_2.0.0              plyr_1.8.9
## [79] R6_2.6.1                    MatrixGenerics_1.22.0
## [81] GenomicAlignments_1.46.0
```