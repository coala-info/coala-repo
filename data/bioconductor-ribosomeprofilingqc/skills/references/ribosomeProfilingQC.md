# ribosomeProfilingQC Guide

Jianhong Ou, Mariah Hoye

#### 30 October 2025

#### Package

ribosomeProfilingQC 1.22.0

# Contents

* [1 Quick start](#quick-start)
  + [1.1 Load genome](#load-genome)
  + [1.2 Prepare annotaiton CDS](#prepare-annotaiton-cds)
  + [1.3 Inputs](#inputs)
  + [1.4 Estimate P site](#estimate-p-site)
  + [1.5 Plot start/stop windows](#plot-startstop-windows)
  + [1.6 Read all P site coordinates](#read-all-p-site-coordinates)
  + [1.7 Fragment size distribution](#fragment-size-distribution)
    - [1.7.1 Filter the reads by fragment size](#filter-the-reads-by-fragment-size)
  + [1.8 Sense/antisense strand plot](#senseantisense-strand-plot)
  + [1.9 Genomic element distribution](#genomic-element-distribution)
  + [1.10 Metagene analysis plot for 5’UTR/CDS/3’UTR](#metagene-analysis-plot-for-5utrcds3utr)
  + [1.11 Reading frame](#reading-frame)
  + [1.12 ORFscore vs coverageRate](#orfscore-vs-coveragerate)
* [2 Bad case](#bad-case)
* [3 Prepare for downstream analysis](#prepare-for-downstream-analysis)
  + [3.1 RPFs only](#rpfs-only)
    - [3.1.1 Count for RPFs](#count-for-rpfs)
    - [3.1.2 Differential analysis only for RPFs](#differential-analysis-only-for-rpfs)
    - [3.1.3 Alternative splicing, translation initiation and polyadenylation](#alternative-splicing-translation-initiation-and-polyadenylation)
  + [3.2 RPFs and RNA-seq](#rpfs-and-rna-seq)
    - [3.2.1 By counts](#by-counts)
    - [3.2.2 By coverage](#by-coverage)
* [4 Fragment Length Organization Similarity Score (FLOSS)1](#fragment-length-organization-similarity-score-floss-ingolia2014ribosome)
* [References](#references)

#Introduction

Ribosome footprinting, developed by Jonathan Weissman and
Nicholas Ingolia[1](#ref-ingolia2014ribosome),
measures translation by direct quantification of the coding sequence
currently bound by the 80S ribosome
(ribosome-protected fragments, RPFs).[2](#ref-bazzini2014identification)
In eukaryotes, the size of RPFs is around 28-nt,
where the P-site of the ribosome is typically in position 13 from the 5’ end of reads.
In bacteria, Allen et. al. were able to more accurately identify the P-site
from 3’ end of reads[3](#ref-mohammad2019systematically).

![](data:image/jpeg;base64...)

Schematic representation of ribosome profiling.

There are several packages available in Bioconductor already, including,
*riboSeqR*,[4](#ref-chung2015use) *RiboProfiling*[5](#ref-popa2016riboprofiling) and
*ORFik*[6](#ref-tjeldnes2018atlas).
These packages are powerful in analyzing the ribosome footprinting data.
The *ORFik* package can also be used to find new transcription start sites using
CageSeq data.
*RiboWaltz*[7](#ref-lauria2018ribowaltz) is another popular package which is based on
R and Bioconductor.

To help researchers quickly assess the quality of their ribosome profiling data,
we have developed the ribosomeProfilingQC package.
The *ribosomeProfilingQC* package can be used to easily make diagnostic plots
to check the mapping quality and frameshifts. In addition, it can preprocess
ribosome profiling data for subsequent differential analysis.
We have tried to make this package as user-friendly as possible and
the only input needed is a bam file of your ribosome footprinting and
RNAseq data mapped to the genome.

Please note that all following analyses are based on known Open Reading Frame
(ORF) annotation.
The sample data provided in the package is mapped to Zebrafish UCSC danRer10 assembly;
all code related to this assembly will be **highlighted in
light yellow background** for clarity.

# 1 Quick start

Here is an example using *ribosomeProfilingQC* with a subset of ribo-seq data.

First install *ribosomeProfilingQC* and other packages required to run
the examples.
Please note that the example dataset used here is from zebrafish.
To run analysis with dataset from a different species or different assembly,
please install the corresponding BSgenome and TxDb.
For example, to analyze mouse data aligned to mm10,
please install BSgenome.Mmusculus.UCSC.mm10,
and TxDb.Mmusculus.UCSC.mm10.knownGene.
You can also generate a TxDb object by
functions `makeTxDbFromGFF` from a local gff file,
or `makeTxDbFromUCSC`, `makeTxDbFromBiomart`, and `makeTxDbFromEnsembl`,
from online resources in *txdbmaker* package.

```
library(BiocManager)
BiocManager::install(c("ribosomeProfilingQC",
                       "AnnotationDbi", "Rsamtools",
                       "BSgenome.Drerio.UCSC.danRer10",
                       "TxDb.Drerio.UCSC.danRer10.refGene",
                       "motifStack"))
```

If you have trouble in install *ribosomeProfilingQC*, please check your R
version first. The *ribosomeProfilingQC* package require R >= 4.0.

```
R.version
```

```
##                _
## platform       x86_64-pc-linux-gnu
## arch           x86_64
## os             linux-gnu
## system         x86_64, linux-gnu
## status         Patched
## major          4
## minor          5.1
## year           2025
## month          08
## day            23
## svn rev        88802
## language       R
## version.string R version 4.5.1 Patched (2025-08-23 r88802)
## nickname       Great Square Root
```

```
## load library
library(ribosomeProfilingQC)
library(AnnotationDbi)
library(Rsamtools)
library(ggplot2)
```

## 1.1 Load genome

In this manual, we will use the fish genome.

```
library(BSgenome.Drerio.UCSC.danRer10)
## set genome, Drerio is a shortname for BSgenome.Drerio.UCSC.danRer10
genome <- Drerio
```

If your assembly is Human hg38 please load the human library,

```
library(BSgenome.Hsapiens.UCSC.hg38)
genome <- Hsapiens
```

If your assembly is Mouse mm10 please load the mouse library,

```
library(BSgenome.Mmusculus.UCSC.mm10)
genome <- Mmusculus
```

If you are having trouble creating or retrieving a `BSgenome`,
a `DNAStringSet` object has also been acceptable since version 1.17.1.

```
genome <- Biostrings::readDNAStringSet('filepath/to/the/genome/fasta/file')
```

## 1.2 Prepare annotaiton CDS

The function `prepareCDS` is used to prepare the information for downstream
analysis from a `TxDb` object.

```
## which is corresponding to BSgenome.Drerio.UCSC.danRer10
library(TxDb.Drerio.UCSC.danRer10.refGene)
txdb <- TxDb.Drerio.UCSC.danRer10.refGene ## give it a short name
CDS <- prepareCDS(txdb)
```

If your assembly is Human hg38 please try to load the library,

```
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene ## give it a short name
CDS <- prepareCDS(txdb)
```

If your assembly is Mouse mm10 please try to load the library,

```
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene ## give it a short name
CDS <- prepareCDS(txdb)
```

You can also create a TxDb object from a gtf file by *txdbmaker::makeTxDbFromGFF* function.
To get GTF file, you can download it from [ensembl](http://useast.ensembl.org/info/data/ftp/index.html)
or get the online file info via [*AnnotationHub*](#count-for-rpfs).
Here we use a prepared TxDb object for testing.

```
## Create a small TxDb object which only contain chr1 information.
library(txdbmaker)
txdb <- makeTxDbFromGFF(system.file("extdata",
                                    "Danio_rerio.GRCz10.91.chr1.gtf.gz",
                                    package="ribosomeProfilingQC"),
                        organism = "Danio rerio",
                        chrominfo = seqinfo(Drerio)["chr1"],
                        taxonomyId = 7955)
CDS <- prepareCDS(txdb)
```

## 1.3 Inputs

The input of *ribosomeProfilingQC* is bam file. To prepare bam file,
different from *riboSeqR* package which ask reads mapped to transcriptome,
*ribosomeProfilingQC* use the bam file mapped to whole genome.
To get correctly mapped reads, first try to map adaptor trimmed sequences to
genome assembly by bowtie2 with following parameters:
–local –ma 5 –mp 8,4 –rdg 7,7 –rfg 7,7 –fr –nofw
and then filter the reads mapped to rRNA, tRNA, snRNA, snoRNA and misc\_RNA
from Ensembl and Repeatmasker annotations. *samtools* will be a great method to filter the reads with following pheudoCode (only works for annotations with `transcript_biotype`).

```
bamfilename <- system.file("extdata", "RPF.WT.1.bam",
                           package="ribosomeProfilingQC")
bamHeader <- Rsamtools::scanBamHeader(bamfilename)
(chromsomeNameStyle <- GenomeInfoDb::seqlevelsStyle(names(bamHeader[[1]]$targets)))
library(rtracklayer)
## the gtf could be downloaded from https://www.ensembl.org/info/data/ftp/index.html
## Please make sure the version number are correct.
## check the version number at https://www.ensembl.org/info/website/archives/index.html
gtf <- import(system.file("extdata",
                          "Danio_rerio.GRCz10.91.chr1.gtf.gz",
                          package="ribosomeProfilingQC"))
gtf <- gtf[gtf$transcript_biotype %in%
             c('rRNA', 'tRNA', 'snRNA', 'snoRNA', 'misc_RNA')]
mcols(gtf) <- NULL
annotation <- 'danRer10' ## must be UCSC style, eg, GRCm38 should be mm10, GRCh38 should be hg38
rmsk <- data.table::fread(paste0('https://hgdownload.soe.ucsc.edu/goldenPath/',
                                annotation, '/database/rmsk.txt.gz'),
                          header=FALSE)
colnames(rmsk) <- c('bin', 'swScore', 'milliDiv', 'milliDel', 'milliIns',
                    'genoName', 'genoStart', 'genoEnd', 'genoLeft', 'strand',
                    'repName', 'repClass', 'repFamily', 'repStart', 'repEnd',
                    'repLeft', 'id')
rmsk_gr <- with(rmsk, GRanges(genoName, IRanges(genoStart+1, genoEnd),
                              strand = strand))
# 'UCSC' or 'ensembl', keep same as it in the bam file
GenomeInfoDb::seqlevelsStyle(gtf) <- seqlevelsStyle(rmsk_gr) <-
  chromsomeNameStyle[1]
gr <- reduce(sort(c(gtf, rmsk_gr)))
seqlevels(gr, pruning.mode="coarse") <-
  intersect(seqlevels(gr), names(bamHeader[[1]]$targets))
outputBed <- 'unused_regions.bed'
export(gr, outputBed)
filteredBamfileName <- sub('.bam$', '.fil.bam', bamfilename)
unusedBamfileName <- sub('.bam$', '.no_use.bam', bamfilename)
## run the cmd in terminal or by system/system2
## please make sure the samtools is available in PATH
## see more about samtools at https://www.htslib.org/
(cmd <- paste('samtools view -b -L', outputBed,
              '-U', filteredBamfileName,
              '-o', unusedBamfileName,
              bamfilename))
system2('samtools',
  args = c('view', '-b',
           '-L', outputBed,
           '-U', filteredBamfileName,
           '-o', unusedBamfileName,
           bamfilename))
(cmd2 <- paste('samtools bam2fq', filteredBamfileName,
               '| gzip >', sub('.bam$', '.fq.gz', filteredBamfileName)))
system2('samtools',
        args = c('bam2fq', filteredBamfileName,
               '|', 'gzip', '>', sub('.bam$', '.fq.gz', filteredBamfileName)))
```

After that, map the clean reads to
genome assembly by tophat2 with following parameters:
–library-type fr-firststrand –transcriptome-index=Transcriptome\_data/genome.
Because the library type of ribo-seq is usally strand-specific,
please make sure to map the reads with correct library type.

```
library(Rsamtools)
## input the bamFile from the ribosomeProfilingQC package
bamfilename <- system.file("extdata", "RPF.WT.1.bam",
                           package="ribosomeProfilingQC")
## For your own data, please set bamfilename as your file path.
## For example, your bam file is located at C:\mydata\a.bam
## you want to set bamfilename = "C:\\mydata\\a.bam"
## or you can change your working directory by
## setwd("C:\\mydata")
## and then set bamfilename = "a.bam"
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)
```

## 1.4 Estimate P site

As it shown in the above figure, P site of the ribosome is in position 13
(if using RNase I).
However, in different experiments, the P site may be shifted due to various
experimental conditions such as the choice of enzyme and the cell type.
The `estimatePsite` function can be used to check the P site.
The `estimatePsite` function will search start/stop codons that occur in the
reads.
The `estimatePsite` will only use 12, 13 or 14 as best P site candidates
when searching from the 5’ end.

```
estimatePsite(bamfile, CDS, genome)
```

```
## [1] 13
```

It has been shown that for certain enzymes, such as MNase,
estimating the P site from the 3’ end works much better[3](#ref-mohammad2019systematically).
The `estimatePsite` will use 15, 16 or 17 as best P site candidates
when searching from the 3’ end.

```
estimatePsite(bamfile, CDS, genome, anchor = "3end")
```

```
## [1] -16
```

## 1.5 Plot start/stop windows

The `readsEndPlot` function will plot the 5’ end or 3’ end reads shifted
from the start/stop position of CDS.
There is no difference when assign the reading frame for most of the reads
if you set best P site to 13 or 10 or 16 (from 5’ end).
The `readsEndPlot`
can help users to determine the real best Psite.
In the example below, the start codon is enriched in position -9 from
the 5’ end of reads and in position 19 from the 3’ end of reads.
This means there are a lot of ribosome that are docking at the translation
start position and most of the reads length are 28 nt.

![](data:image/png;base64...)

Ribosome docking at TSS

```
re <- readsEndPlot(bamfile, CDS, toStartCodon=TRUE)
```

![](data:image/png;base64...)

```
readsEndPlot(re$reads, CDS, toStartCodon=TRUE, fiveEnd=FALSE)
```

![](data:image/png;base64...)

If you see following distribution, that means lots of gene are in
active expression.

![](data:image/jpeg;base64...)

Active expression

If you see a warning or error message complaining about the disagreement of
chromosome sequences, please verify you are using the TxDb object with
correct genome assembly.
If this warning message is for the patch chromosomes you are not interested,
you can ignore the warning messages.

## 1.6 Read all P site coordinates

The `getPsiteCoordinates` function is used to read all P site coordinates.
Ideally, the bestpsite should be 13.
To test the data quality, we set bestpsite = 13.

```
pc <- getPsiteCoordinates(bamfile, bestpsite = 13)
```

## 1.7 Fragment size distribution

Ribosome-protected fragments should ideally be 27 to 29-nt long.
To check the fragment size distribution, use the following function:

```
readsLen <- summaryReadsLength(pc)
```

![](data:image/png;base64...)

### 1.7.1 Filter the reads by fragment size

To filter reads by their length for downstream analysis,
use the following script:

```
## for this QC demo, we will only use reads length of 28-29 nt.
pc.sub <- pc[pc$qwidth %in% c(28, 29)]
```

## 1.8 Sense/antisense strand plot

Most of the reads should be mapped to sense strand
because the ribo-seq library is strand-specific.

```
strandPlot(pc.sub, CDS)
```

![](data:image/png;base64...)

## 1.9 Genomic element distribution

For ribosome footprinting, most of the reads should map to the CDS region.
The `readsDistribution` function will show the P site locations
in different genomic elements: CDS, 5’UTR, 3’UTR, other type exon,
intron, promoter, downstream or intergenic region.
A high downstream percentage indicates that there is a high percentage
of alternative polyAdenylation sites usage from annotation data.
A high percentage in intronic regions indicates the possibility of
intron-retaining transcripts.

```
pc.sub <- readsDistribution(pc.sub, txdb, las=2)
```

![](data:image/png;base64...)

## 1.10 Metagene analysis plot for 5’UTR/CDS/3’UTR

A metagene plot can indicate the reads distribution in 5’UTR, CDS and
3’UTR region.

```
cvgs.utr5 <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="utr5")
cvgs.CDS <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="cds")
cvgs.utr3 <- coverageDepth(RPFs = bamfilename, gtf = txdb, region="utr3")
metaPlot(cvgs.utr5, cvgs.CDS, cvgs.utr3, sample=1)
```

![](data:image/png;base64...)

## 1.11 Reading frame

Function `assignReadingFrame` is used to set the reading frame for the P sites
located within the known annotated CDS.
The `plotDistance2Codon` function can be used to plot the reading frame usage
in transcription initiation or termination sites.
Function `plotFrameDensity` can be used to collapse all the RPFs in each frame.
These plots can help you to double check if the p-site position is correct
or not.
If it is correct, most of the reads should be assigned to frame0.

```
pc.sub <- assignReadingFrame(pc.sub, CDS)
plotDistance2Codon(pc.sub)
```

![](data:image/png;base64...)

```
plotFrameDensity(pc.sub)
```

![](data:image/png;base64...)

To determine how many of raw reads are mapping with P sites in frame 0.

```
pc <- assignReadingFrame(pc, CDS)
plotFrameDensity(pc)
```

![](data:image/png;base64...)

Function `plotTranscript` can be used to view the reading frame distribution
for given transcripts.

```
plotTranscript(pc.sub, c("ENSDART00000161781", "ENSDART00000166968",
                         "ENSDART00000040204", "ENSDART00000124837"))
```

![](data:image/png;base64...)

## 1.12 ORFscore vs coverageRate

ORFscore[2](#ref-bazzini2014identification) can be used to quantify the biased
distribution of RPFs toward the first frame of a given CDS.
Coverage rate for whole CDS can help researchers to check the RPFs distribution
along whole CDS.
Coverage is determined by measuring the proportion of in-frame CDS positions
with >= 1 reads.
If coverage is about 1, the whole CDS is covered by active ribosomes.

```
cvg <- frameCounts(pc.sub, coverageRate=TRUE)
ORFscore <- getORFscore(pc.sub)
## Following code will plot the ORFscores vs coverage.
## Try it by removing the '#'.
#plot(cvg[names(ORFscore)], ORFscore,
#     xlab="coverage ORF1", ylab="ORF score",
#     type="p", pch=16, cex=.5, xlim=c(0, 1))
```

# 2 Bad case

Here, we show ribosome footprinting data that is poor quality data and
should not be used for downstream analyses.

```
bamfilename <- system.file("extdata", "RPF.chr1.bad.bam",
                           package="ribosomeProfilingQC")
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)
pc <- getPsiteCoordinates(bamfile, bestpsite = 13)
pc.sub <- pc[pc$qwidth %in% c(27, 28, 29)]
## in this example, most of the reads mapped to the antisense strand
## which may indicate that there are some issues in the mapping step
strandPlot(pc.sub, CDS)
```

![](data:image/png;base64...)

```
## in this exaple, most of the reads mapped to inter-genic regions
## rather than the CDS, which could indicate that ribosome protected
## fragments are not being properly isolated/selected
pc.sub <- readsDistribution(pc.sub, txdb, las=2)
```

![](data:image/png;base64...)

```
## Selection of the proper P site is also critical.
## If we assign the wrong P site position the frame mapping will
## likely be impacted.
pc <- getPsiteCoordinates(bamfile, 12)
pc.sub <- pc[pc$qwidth %in% c(27, 28, 29)]
pc.sub <- assignReadingFrame(pc.sub, CDS)
plotDistance2Codon(pc.sub)
```

![](data:image/png;base64...)

```
plotFrameDensity(pc.sub)
```

![](data:image/png;base64...)

# 3 Prepare for downstream analysis

## 3.1 RPFs only

### 3.1.1 Count for RPFs

Downstream analysis including differential analysis, comparison with RNAseq,
and so on.
Function `frameCounts` will generate a count vector for each transcript or gene,
which can be used for differential analysis.
`countReads` can be used for count multiple files of ribo-seq.

```
library(ribosomeProfilingQC)
library(AnnotationDbi)
path <- system.file("extdata", package="ribosomeProfilingQC")
RPFs <- dir(path, "RPF.*?\\.[12].bam$", full.names=TRUE)
gtf <- file.path(path, "Danio_rerio.GRCz10.91.chr1.gtf.gz")
cnts <- countReads(RPFs, gtf=gtf, level="gene",
                   bestpsite=13, readsLen=c(28,29))
head(cnts$RPFs)
```

```
##                    RPF.KD1.1.bam RPF.KD1.2.bam RPF.WT.1.bam RPF.WT.2.bam
## ENSDARG00000000606            23            10            0            0
## ENSDARG00000002285             5             5            0            1
## ENSDARG00000002377           112            44          124           51
## ENSDARG00000002634             4             3            0            0
## ENSDARG00000002791          3051          1313         3815         1718
## ENSDARG00000002840             1             1            0            0
```

```
## To save the cnts, please try following codes by removing '#'
# write.csv(cbind(cnts$annotation[rownames(cnts$RPFs), ], cnts$RPFs),
#           "counts.csv")
```

To get GTF file, you can download it from [ensembl](http://useast.ensembl.org/info/data/ftp/index.html)
or get the online file info via `AnnotationHub`.

```
BiocManager::install("AnnotationHub")
library(AnnotationHub)
ah = AnnotationHub()
## for human hg38
hg38 <- query(ah, c("Ensembl", "GRCh38", "gtf"))
hg38 <- hg38[length(hg38)]
gtf <- mcols(hg38)$sourceurl
## for mouse mm10
mm10 <- query(ah, c("Ensembl", "GRCm38", "gtf"))
mm10 <- mm10[length(mm10)]
gtf <- mcols(mm10)$sourceurl
```

### 3.1.2 Differential analysis only for RPFs

```
library(edgeR)  ## install edgeR by BiocManager::install("edgeR")
gp <- c("KD", "KD", "CTL", "CTL") ## sample groups: KD:knockdown; CTL:Control
y <- DGEList(counts = cnts$RPFs, group = gp)
y <- calcNormFactors(y)
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
y <- estimateDisp(y, design)
## To perform quasi-likelihood F-tests:
fit <- glmQLFit(y, design)
qlf <- glmQLFTest(fit)
topTags(qlf, n=3) # set n=nrow(qlf) to pull all results.
```

```
## Coefficient:  KD
##                        logFC   logCPM        F       PValue          FDR
## ENSDARG00000094608 -16.40874 5.900260 5898.933 1.297604e-18 2.017959e-16
## ENSDARG00000025233 -16.40874 5.761365 5192.866 3.347420e-18 2.017959e-16
## ENSDARG00000092500 -16.40874 5.761365 5192.866 3.347420e-18 2.017959e-16
```

```
## To perform likelihood ratio tests:
fit <- glmFit(y, design)
lrt <- glmLRT(fit)
topTags(lrt, n=3) # set n=nrow(lrt) to pull all results.
```

```
## Coefficient:  KD
##                        logFC    logCPM       LR PValue FDR
## ENSDARG00000027355 -18.49135  9.659996 3383.294      0   0
## ENSDARG00000063297 -13.44032  8.904738 1524.262      0   0
## ENSDARG00000090408 -12.13031 10.122565 6978.830      0   0
```

### 3.1.3 Alternative splicing, translation initiation and polyadenylation

```
coverage <- coverageDepth(RPFs[grepl("KD1|WT", RPFs)],
                          gtf=txdb,
                          level="gene",
                          region="feature with extension")
group1 <- c("RPF.KD1.1", "RPF.KD1.2")
group2 <- c("RPF.WT.1", "RPF.WT.2")
## subset the data, for sample run only
coverage <- lapply(coverage, function(.ele){##do not run this for real data
  .ele$coverage <- lapply(.ele$coverage, `[`, i=seq.int(50))
  .ele$granges <- .ele$granges[seq.int(50)]
  .ele
})
se <- spliceEvent(coverage, group1, group2)
table(se$type)
```

```
##
## aSE
##  94
```

```
plotSpliceEvent(se, se$feature[1], coverage, group1, group2)
```

![](data:image/png;base64...)

## 3.2 RPFs and RNA-seq

### 3.2.1 By counts

#### 3.2.1.1 Count for RPFs and RNA-seq

The `countReads` function can be used to count multiple files of ribo-seq and
RNA-seq data.

```
path <- system.file("extdata", package="ribosomeProfilingQC")
RPFs <- dir(path, "RPF.*?\\.[12].bam$", full.names=TRUE)
RNAs <- dir(path, "mRNA.*?\\.[12].bam$", full.names=TRUE)
gtf <- file.path(path, "Danio_rerio.GRCz10.91.chr1.gtf.gz")
```

```
## make sure that the order of the genes listed in the bam files for RPFs
## and RNAseq data is the same.
cnts <- countReads(RPFs, RNAs, gtf, level="tx")
## To save the cnts, please try following codes by removing '#'
# rn <- cnts$annotation$GeneID
# write.csv(cbind(cnts$annotation,
#                 cnts$RPFs[match(rn, rownames(cnts$RPFs)), ],
#                 cnts$mRNA[match(rn, rownames(cnts$mRNA)), ]),
#           "counts.csv")
```

#### 3.2.1.2 Translational Efficiency (TE)

The absolute level of ribosome occupancy is strongly correlated with RNA levels
for both coding and noncoding transcripts.
Translational efficiency is introduced[8](#ref-ingolia2009genome)
to show the correlation.
TE is the ratio of normalized ribosome footprint abundance to mRNA density.
A common normalization method is using
Fragments Per Kilobase of transcript per Million mapped reads (FPKM).

```
fpkm <- getFPKM(cnts)
TE <- translationalEfficiency(fpkm)
```

#### 3.2.1.3 Differential analysis for TE

We suppose that the log2 transformed translational efficiency that
we calculated by the ratios of RPFs to mRNAs
has a linear correlation with real translational efficiency.
We then use the *limma* package to test the differential
translational efficiency.

```
library(limma)
gp <- c("KD", "KD", "CTL", "CTL") ## sample groups: KD:knockdown; CTL:Control
TE.log2 <- log2(TE$TE + 1)
#plot(TE.log2[, 1], TE.log2[, 3],
#     xlab=colnames(TE.log2)[1], ylab=colnames(TE.log2)[3],
#     main="Translational Efficiency", pch=16, cex=.5)
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
fit <- lmFit(TE.log2, design)
fit2 <- eBayes(fit)
topTable(fit2, number=3) ## set number=nrow(fit2) to pull all results
```

```
##                         CTL       KD  AveExpr         F      P.Value
## ENSDART00000138070 22.89899 22.35089 22.62494 1138692.4 3.919783e-08
## ENSDART00000161781 16.60558 16.66538 16.63548  459221.6 1.211153e-07
## ENSDART00000166968 15.62956 15.72061 15.67509  213771.7 3.131307e-07
##                       adj.P.Val
## ENSDART00000138070 1.955971e-05
## ENSDART00000161781 3.021826e-05
## ENSDART00000166968 3.879669e-05
```

A different way is that we can use raw counts to test whether the
change is coming from translation level but not transcription level.

```
library(edgeR)
gp <- c("KD", "KD", "CTL", "CTL")
design <- model.matrix(~0+gp)
colnames(design) <- sub("gp", "", colnames(design))
y <- lapply(cnts[c("RPFs", "mRNA")], function(.cnt){
  .y <- DGEList(counts = .cnt,
             samples = data.frame(gp=gp))
  .y <- calcNormFactors(.y)
  .y <- estimateDisp(.y, design)
  .y
})

## To perform likelihood ratio tests:
fit <- lapply(y, glmFit, design = design)
lrt <- lapply(fit, glmLRT)
topTags(lrt[["RPFs"]], n=3) # difference between CTL and KD for RPFs
```

```
## Coefficient:  KD
##                        logFC   logCPM        LR PValue FDR
## ENSDART00000148086 -18.74358 7.049795  1596.568      0   0
## ENSDART00000160650 -18.74358 9.514299 12055.745      0   0
## ENSDART00000142244 -15.83004 6.834313  1644.161      0   0
```

```
topTags(lrt[["mRNA"]], n=3) # difference between CTL and KD for mRNA
```

```
## Coefficient:  KD
##                        logFC   logCPM       LR PValue FDR
## ENSDART00000004062 -15.65935 9.082734 6117.073      0   0
## ENSDART00000024743 -15.65935 8.442090 2253.935      0   0
## ENSDART00000054388 -15.65935 8.442090 2253.935      0   0
```

```
results <- lapply(lrt, topTags, p.value = 0.05, n = nrow(lrt[[1]]))
RPFs_unique <- setdiff(rownames(results[["RPFs"]]),
                       rownames(results[["mRNA"]]))
mRNA_zero <- rownames(cnts[["mRNA"]])[rowSums(cnts[["mRNA"]]) == 0]
RPFs_unique <- RPFs_unique[!RPFs_unique %in% mRNA_zero]
head(results[["RPFs"]][RPFs_unique, ], n=3) ## top 3 events for translation level
```

```
## Coefficient:  KD
## [1] logFC  logCPM LR     PValue FDR
## <0 rows> (or 0-length row.names)
```

### 3.2.2 By coverage

#### 3.2.2.1 Maximum N-mer translational efficiency

If we plot the correlation mRNAs or RPFs levels to translational efficiency
calculated by all counts within a transcript,
we will find that TE is not well normalized.
It shows a higher value in lowly expressed transcripts
and a low value in highly expressed transcripts.

```
plotTE(TE, sample=2, xaxis="mRNA", log2=TRUE)
```

![](data:image/png;base64...)

```
#plotTE(TE, sample=2, xaxis="RPFs", log2=TRUE)
```

This issue can be fixed by calculating the maximum value (TE max) in the most
highly ribosome-occupied 90 nt window within a feature[8](#ref-ingolia2009genome).
Please note that the normalization method for TE max is not FPKM any more.

```
cvgs <- coverageDepth(RPFs, RNAs, txdb)
TE90 <- translationalEfficiency(cvgs, window = 90, normByLibSize=TRUE)
plotTE(TE90, sample=2, xaxis="mRNA", log2=TRUE)
```

![](data:image/png;base64...)

Above examples are TE90 for CDS region. Following codes show how to
calculate TE90 for 3’UTR regions.

```
cvgs.utr3 <- coverageDepth(RPFs, RNAs, txdb, region="utr3")
TE90.utr3 <- translationalEfficiency(cvgs.utr3, window = 90)
## Following code will plot the TE90 for 3'UTR regions.
## Try it by removing the '#'.
#plotTE(TE90.utr3, sample=2, xaxis="mRNA", log2=TRUE)
#plotTE(TE90.utr3, sample=2, xaxis="RPFs", log2=TRUE)
```

We can also try a different method to fix that issue by normalization the counts
of RPFs and RNAs by different methods but not FPKM.

```
cnts_normByEdgeR <- normBy(cnts, method = 'edgeR')
TE_edgeR <- translationalEfficiency(cnts_normByEdgeR)
plotTE(TE_edgeR)
```

![](data:image/png;base64...)

Additional method is that normalize the log2 transformed TE with mRNA counts.

```
TE.log2_norm <- normalizeTEbyLoess(TE)
## please note that output is log2 transformed TE.
plotTE(TE.log2_norm, log2 = FALSE)
```

![](data:image/png;base64...)

#### 3.2.2.2 Ribosome Release Score (RRS)

RRS is calculated as the ratio of RPFs (normalized by RNA-seq reads) in
the CDS to RPFs in the 3’UTR.
Because it is hard to define the CDS region for non-coding RNAs,
RRS of non-coding RNAs can not be calculated by Function `ribosomeReleaseScore`.

```
RRS <- ribosomeReleaseScore(TE90, TE90.utr3, log2 = TRUE)
## Following code will compare RSS for 2 samples.
## Try it by removing the '#'.
#plot(RRS[, 1], RRS[, 3],
#     xlab="log2 transformed RRS of KD1",
#     ylab="log2 transformed RRS of WT1")
## Following code will show RSS along TE90.
## Try it by removing the '#'.
#plot(RRS[, 1], log2(TE90$TE[rownames(RRS), 1]),
#     xlab="log2 transformed RSS of KD1",
#     ylab="log2 transformed TE of KD1")
```

#### 3.2.2.3 Metagene analysis plot

Plot metagene coverage for CDS, 5’UTR and 3’UTR.
You will notice that the coverage for the RPF data is
much more enriched in the CDS as compared to the
corresponding RNAseq data

```
cvgs.utr5 <- coverageDepth(RPFs, RNAs, txdb, region="utr5")
## set sample to different number to plot metagene analysis
## for different samples
#metaPlot(cvgs.utr5, cvgs, cvgs.utr3, sample=2, xaxis = "RPFs")
metaPlot(cvgs.utr5, cvgs, cvgs.utr3, sample=2, xaxis = "mRNA")
```

![](data:image/png;base64...)

# 4 Fragment Length Organization Similarity Score (FLOSS)[1](#ref-ingolia2014ribosome)

FLOSS can be used to compare the distribution of reads length to
a background such as a cluster of genes.
The gene cluster could be extracted from gtf/gff files downloaded from [ensembl](http://useast.ensembl.org/info/data/ftp/index.html).

```
## documentation: https://useast.ensembl.org/Help/Faq?id=468
gtf <- import("Danio_rerio.GRCz10.91.gtf.gz")
```

The gtf files can be also download via `AnnotationHub`

```
BiocManager::install("AnnotationHub")
library(AnnotationHub)
ah = AnnotationHub()
## for human hg38
hg38 <- query(ah, c("Ensembl", "GRCh38", "gtf"))
hg38 <- hg38[[length(hg38)]]
## for mouse mm10
mm10 <- query(ah, c("Ensembl", "GRCm38", "gtf"))
mm10 <- mm10[[length(mm10)]]
## because the gene ids in TxDb.Mmusculus.UCSC.mm10.knownGene and
## TxDb.Hsapiens.UCSC.hg38.knownGene
## are entriz_id, the gene_id in mm10 or hg38 need to changed to entriz_id.
library(ChIPpeakAnno)
library(org.Mm.eg.db)
mm10$gene_id <- ChIPpeakAnno::xget(mm10$gene_id, org.Mm.egENSEMBL2EG)
library(org.Hg.eg.db)
hg38$gene_id <- ChIPpeakAnno::xget(hg38$gene_id, org.Mm.egENSEMBL2EG)
```

```
gtf <- gtf[!is.na(gtf$gene_id)]
gtf <- gtf[gtf$gene_id!=""]
## protein coding
protein <-
  gtf$gene_id[gtf$transcript_biotype %in%
                  c("IG_C_gene", "IG_D_gene", "IG_J_gene", "IG_LV_gene",
                    "IG_M_gene", "IG_V_gene", "IG_Z_gene",
                    "nonsense_mediated_decay", "nontranslating_CDS",
                    "non_stop_decay",
                    "protein_coding", "TR_C_gene", "TR_D_gene", "TR_gene",
                    "TR_J_gene", "TR_V_gene")]
## mitochondrial genes
mito <- gtf$gene_id[grepl("^mt\\-", gtf$gene_name) |
                        gtf$transcript_biotype %in% c("Mt_tRNA", "Mt_rRNA")]
## long noncoding
lincRNA <-
  gtf$gene_id[gtf$transcript_biotype %in%
                  c("3prime_overlapping_ncrna", "lincRNA",
                    "ncrna_host", "non_coding")]
## short noncoding
sncRNA <-
  gtf$gene_id[gtf$transcript_biotype %in%
                  c("miRNA", "miRNA_pseudogene", "misc_RNA",
                    "misc_RNA_pseudogene", "Mt_rRNA", "Mt_tRNA",
                    "Mt_tRNA_pseudogene", "ncRNA", "pre_miRNA",
                    "RNase_MRP_RNA", "RNase_P_RNA", "rRNA", "rRNA_pseudogene",
                    "scRNA_pseudogene", "snlRNA", "snoRNA",
                    "snRNA_pseudogene", "SRP_RNA", "tmRNA", "tRNA",
                    "tRNA_pseudogene", "ribozyme", "scaRNA", "sRNA")]
## pseudogene
pseudogene <-
  gtf$gene_id[gtf$transcript_biotype %in%
                  c("disrupted_domain", "IG_C_pseudogene", "IG_J_pseudogene",
                    "IG_pseudogene", "IG_V_pseudogene", "processed_pseudogene",
                    "pseudogene", "transcribed_processed_pseudogene",
                    "transcribed_unprocessed_pseudogene",
                    "translated_processed_pseudogene",
                    "translated_unprocessed_pseudogene", "TR_J_pseudogene",
                    "TR_V_pseudogene", "unitary_pseudogene",
                    "unprocessed_pseudogene")]
danrer10.annotations <- list(protein=unique(protein),
                             mito=unique(mito),
                             lincRNA=unique(lincRNA),
                             pseudogene=unique(pseudogene))
```

Here we load the pre-saved chr1 annotations for sample codes.

```
danrer10.annotations <-
  readRDS(system.file("extdata",
                      "danrer10.annotations.rds",
                      package = "ribosomeProfilingQC"))
```

```
library(ribosomeProfilingQC)
library(txdbmaker)
## prepare CDS annotation
txdb <- makeTxDbFromGFF(system.file("extdata",
                                    "Danio_rerio.GRCz10.91.chr1.gtf.gz",
                                    package="ribosomeProfilingQC"),
                        organism = "Danio rerio",
                        chrominfo = seqinfo(Drerio)["chr1"],
                        taxonomyId = 7955)
CDS <- prepareCDS(txdb)

library(Rsamtools)
## input the bamFile from the ribosomeProfilingQC package
bamfilename <- system.file("extdata", "RPF.WT.1.bam",
                           package="ribosomeProfilingQC")
## For your own data, please set bamfilename as your file path.
yieldSize <- 10000000
bamfile <- BamFile(bamfilename, yieldSize = yieldSize)

pc <- getPsiteCoordinates(bamfile, bestpsite = 13)
readsLengths <- 20:34
fl <- FLOSS(pc, ref = danrer10.annotations$protein,
            CDS = CDS, readLengths=readsLengths, level="gene", draw = FALSE)
fl.max <- t(fl[c(1, which.max(fl$cooks.distance)), as.character(readsLengths)])
matplot(fl.max, type = "l", x=readsLengths,
        xlab="Fragment Length", ylab="Fraction of Reads",
        col = c("gray", "red"), lwd = 2, lty = 1)
legend("topright",  legend = c("ref", "selected gene"),
       col = c("gray", "red"), lwd = 2, lty = 1, cex=.5)
```

![](data:image/png;base64...)

# References

1. Ingolia, N. T. *et al.* Ribosome profiling reveals pervasive translation outside of annotated protein-coding genes. *Cell reports* **8,** 1365–1379 (2014).

2. Bazzini, A. A. *et al.* Identification of small orfs in vertebrates using ribosome footprinting and evolutionary conservation. *The EMBO journal* **33,** 981–993 (2014).

3. Mohammad, F., Green, R. & Buskirk, A. R. A systematically-revised ribosome profiling method for bacteria reveals pauses at single-codon resolution. *Elife* **8,** e42591 (2019).

4. Chung, B. Y. *et al.* The use of duplex-specific nuclease in ribosome profiling and a user-friendly software package for ribo-seq data analysis. *Rna* **21,** 1731–1745 (2015).

5. Popa, A. *et al.* RiboProfiling: A bioconductor package for standard ribo-seq pipeline processing. *F1000Research* **5,** (2016).

6. Tjeldnes, H. An atlas of the human uORFome and its regulation across tissues. (The University of Bergen, 2018).

7. Lauria, F. *et al.* RiboWaltz: Optimization of ribosome p-site positioning in ribosome profiling data. *PLoS computational biology* **14,** e1006169 (2018).

8. Ingolia, N. T., Ghaemmaghami, S., Newman, J. R. & Weissman, J. S. Genome-wide analysis in vivo of translation with nucleotide resolution using ribosome profiling. *science* **324,** 218–223 (2009).