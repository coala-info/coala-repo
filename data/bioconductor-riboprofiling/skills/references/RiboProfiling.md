RiboProfiling - Analysis and quality assess-
ment of Ribosome-profiling data

Alexandra Popa

October 7, 2025

Contents

1

2

3

4

5

6

7

Introduction .

Data Input .

Quick start .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Histogram of read match length .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

Read start coverage plot around the TSS .

Count reads on features .

.

.

.

Count reads on codon motifs .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

2

3

5

6

7

9

1

Introduction

Ribosome profiling, the recently developed high throughput sequencing technique, enabled
the mapping of translated regions genome-wide. This technique takes advantage of the fact
that ribosomes actively engaged in translation can protect their associated mRNA fragments
against RNAse digestion. The sequencing of these protected fragments can reveal potentially
translated sequences. RiboProfiling is a Bioconductor package that provides multiple types
of ribo-seq data analysis, starting from BAM files alone:

• Quality assessment of read match size distribution.

• Read coverage around the TSS for the definition of an offset (shift value) of ribosome

position.

• Calibrate reads by applying an offset to the read start positions along the transcript.

• Table of read start counts (shifted if specified) on the specified region (CDS, 5pUTR,

3pUTR).

• A graphical quality function for ribo-seq data, based on the previously obtained tables.

• The quantification of the frequency and coverage matrices for motifs of codons (1, 2

or 3 codons) in ORFs.

• Principal component analysis of codon motif coverage in ribosome-profiling.

The package also provides the riboSeqFromBAM function, that assembles in a global framework
some of the above analyses, allowing a quick overview of the data.

2

Data Input

As input data, the RiboProfiling package can start with a path to a ribo-seq (or other
type of) BAM to be analyzed. A list of multiple BAM files can also be provided. BAM
files from either bowtie/tophat, STAR, and Lifescope (Solid), single- and paired-end have
been validated. Many intermediate functions of the RiboProfiling package can be called for
additional modifications on the data objects.

2

Example data files provided with the RiboProfiling package are based on chromosome 1
reads from human primary BJ fibroblasts data (PMID: 23594524, SRA: http://www.ebi.ac.
uk/ena/data/view/SRP020544):

• BAM file Ctrl "http://genomique.info/data/public/RiboProfiling/ctrl.bam".

• BAM file Nutlin2h "http://genomique.info/data/public/RiboProfiling/nutlin2h.bam".

The data provided with the RiboProfiling package and accessible through the data function
consists of:

• ctrlGAlignments - a GAlignments object corresponding to the "http://genomique.

info/data/public/RiboProfiling/ctrll.bam" BAM.

• codonIndexCovCtrl - a list containing the number of reads for each codon in each

ORF.

• codonDataCtrl - a list of 2 data.frames containing the frequency of codons for each

ORF and, respectively, the read coverage for the same codons and ORFs.

3

Quick start

The fastest way to analyze a list of BAM files with the RiboProfiling package is to call the
riboSeqFromBAM function. The only input needed are the paths to the BAM files and the
genome version on which the mapping was done. Here is an example on how to use this
wrapper function on 2 BAM files.

library(RiboProfiling)

listInputBam <- c(

BamFile("http://genomique.info/data/public/RiboProfiling/ctrl.bam"),

BamFile("http://genomique.info/data/public/RiboProfiling/nutlin2h.bam")

)

covData <- riboSeqFromBAM(listInputBam, genomeName="hg19")

The following analyses and results are returned:

• a histogram of read match lengths: figures 1 and 2.

• a read start coverage plot around the TSS: figures 1 and 2.

• an automatic estimation and application of the ribosome offset position (if no

offset value is provided (listShiftValue parameter missing))

• a data.frame containing CDSs annotation and counts on the 5pUTR, CDS, and

3pUTR once the offset has been applied

• pairs and boxplots of the read counts: figures 3 and 4.

• a list of per ORF per codon coverage

3

Figure 1: Histogram of read match size and read start offset to ribosome P-site for ctrl.bam dataset.

Figure 2: Histogram of read match size and read start offset to ribosome P-site for nutlin2h.bam
dataset.

Figure 3: Pairs of shifted read counts on 5pUTR, CDS, and 3pUTR for ctrl.bam and nutlin2h.bam
dataset.

4

Figure 4: Boxplot of shifted read counts on 5pUTR, CDS, and 3pUTR for ctrl.bam and nutlin2h.bam
dataset.

All these results will be explained in detail in the following sections.

This general function only works if your species model has an ensembl table in the UCSC
database or if you provide the corresponding txdb object containing the annotations.

4

Histogram of read match length

This histogram represents both a quality control of the sequencing and an important tool to
define the match sizes of reads corresponding to ribosome footprints (around 30bp). The
histMatchLength function in the RiboProfiling package produces this histogram starting from
a GAlignment object (the loaded records of a BAM) such as the ctrlGAlignments data example
(figure 5).

One can create a GAlignments from a BAM using the readGAlignments function from the
GenomicAlignments package:

aln <- readGAlignments(

BamFile("http://genomique.info/data/public/RiboProfiling/ctrl.bam")

)

Or based on an already existing GAlignments object:

data(ctrlGAlignments)

aln <- ctrlGAlignments

matchLenDistr <- histMatchLength(aln, 0)

matchLenDistr[[2]]

Figure 5: Histogram of read match length for example data: ctrlGAlignments.

5

5

Read start coverage plot around the TSS

The initiation of protein synthesis starts with the first codon in the P-site.
In ribosome
profiling experiments, the location of the P-site codon must be inferred in order to recalibrate
the read start positions relative to the transcript. An offset is usually observed in Ribo-
seq experiments between the starting of the reads and the AUG codons of protein coding
sequences. Three functions allow the estimation of the read start position relative to the
P-site codon:

• aroundPromoter: returns the genomic positions flanking the transcript start site (TSS)

for the x% (3% default value) best expressed CDSs.

• readStartCov: returns the read start coverage around the TSS on the predefined CDSs.

• plotSummarizedCov: plots the summarized coverage in a specified range (e.g. around

TSS) for the specified match sizes.

#transform the GAlignments object into a GRanges object

#(faster processing of the object)

alnGRanges <- readsToStartOrEnd(aln, what="start")

#txdb object with annotations

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

oneBinRanges <- aroundPromoter(txdb, alnGRanges, percBestExpressed=0.001)

#the coverage in the TSS flanking region for the reads with match sizes 29:31

listPromoterCov <-

readStartCov(

alnGRanges,

oneBinRanges,

matchSize=c(29:31),

fixedInterval=c(-20, 20),

renameChr="aroundTSS",

charPerc="perc"

)

plotSummarizedCov(listPromoterCov)

## Warning in !vapply(ggl, fixed, logical(1L)) & !vapply(PlotList, is, "Ideogram",

:

longer object length is not a multiple of shorter object length

6

Figure 6: Offset around TSS for the best expressed CDSs on a subset of match sizes.

The first time you analyse a ribo-seq BAM file, it is advisable to make an offset graph for all
the previously selected read match sizes, as the offset might be different depending on the
read match size .

6

Count reads on features

The purpose of Ribosome Profiling experiments is mainly to identify RNAse resistant regions,
which might indicate that these sequences are likely to be translated. The countShiftReads
function quantifies the read start coverage on different sequence features. This function
integrates the specificity of ribo-seq data of having shifted reads starts from the P-site codon.
The countShiftReads function recalibrates the read start positions along the transcript with
the specified offset (parameter shiftValue, default 0) and returns the coverage on the 5pUTR,
CDS, 3pUTR, and a matrix of codon coverage for each ORF.

7

The counts can be used globally to see what is RNAse protected and what is not, but also
for differential analysis between conditions. The countsPlot function provides some quality
graphs for the ribo-seq data: pairs between counts on features and boxplots of counts between
conditions.

As an example, we compute the read coverage on the ctrlGAlignments example data:

#keep only the match read sizes 30-33

alnGRanges <- alnGRanges[which(!is.na(match(alnGRanges$score,30:33)))]

#get all CDSs by transcript

cds <- cdsBy(txdb, by="tx", use.names=TRUE)

#get all exons by transcript

exonGRanges <- exonsBy(txdb, by="tx", use.names=TRUE)

#get the per transcript relative position of start and end codons

cdsPosTransc <- orfRelativePos(cds, exonGRanges)

#compute the counts on the different features

#after applying the specified shift value on the read start along the transcript

countsDataCtrl1 <-

countShiftReads(

exonGRanges=exonGRanges[names(cdsPosTransc)],

cdsPosTransc=cdsPosTransc,

alnGRanges=alnGRanges,

shiftValue=-14

)

head(countsDataCtrl1[[1]])

listCountsPlots <- countsPlot(

list(countsDataCtrl1[[1]]),
grep("_counts$", colnames(countsDataCtrl1[[1]])),
1

)

listCountsPlots

## Warning in countShiftReads(exonGRanges[names(cdsPosTransc)], cdsPosTransc, :

Param motifSize should be an integer!

Accepted values 3, 6 or 9.

Default value

is 3.

## Warning in ggplot2::geom_abline(ggplot2::aes(color = "Diagonal", fill = "Diagonal",
:

Ignoring unknown aesthetics: fill

##

## uc001abw.1 uc001abw.1 chr1

gene chr strand transc_genomic_start transc_genomic_end
879961

861121

+

## uc031pjl.1 uc031pjl.1 chr1

## uc031pjm.1 uc031pjm.1 chr1

+

+

861302

861302

879533

879533

##

## uc001abw.1

## uc031pjl.1

## uc031pjm.1

##

## uc001abw.1

## uc031pjl.1

## uc031pjm.1

transc_length orf_start orf_end orf_length CDS_counts fiveUTR_counts
0

2554

2046

2126

81

2

2120

2084

21

21

2120

2084

2100

2064

2

2

0

0

threeUTR_counts
0

0

0

8

Figure 7: Pairs and boxplots of read coverage on genomic features.

7

Count reads on codon motifs

The previous countShiftReads function produces a second element in the list: the counts of
reads per motifs of 1, 2, or 3 codons. For each ORF, for each motif in the ORF, the Ribo-seq
coverage of the motif is reported as follows:

• for motifs of 3 nucleotides (1 codon) - the sum of read starts on the 3 nucleotides in

the codon is reported.

• consecutive motifs of 6 nucleotides (2 consecutive codons) overlap on 3 nucleotides.
The Ribo-seq coverage is reported as the coverage on the 1st codon in the motif
considered as being in the P-site.

• consecutive motifs of 9 nucleotides (3 consecutive codons) overlap on 6 nucleotides.
The Ribo-seq coverage is reported as the coverage on the 2nd codon in the motif
considered as being in the P-site.

Codon motifs in each ORF are described as the index of their position in the ORF.

Here is an example:

data(codonIndexCovCtrl)

head(codonIndexCovCtrl[[1]], n=3)

##

codonID nbrReads

## 1

## 2

## 3

1

2

3

0

0

0

The codonInfo function associates the read coverage on codons with their corresponding
codon type for each ORF. It returns a list of 2 matrices: one containing the frequency of
each codon motif type in each ORF and the second containing the coverage of each codon
motif type in each ORF.

listReadsCodon <- countsDataCtrl1[[2]]

#get the names of the expressed ORFs grouped by transcript

cds <- cdsBy(txdb, use.names=TRUE)

orfCoord <- cds[names(cds) %in% names(listReadsCodon)]

#chromosome names should correspond between the BAM,

#the annotations, and the genome

genomeSeq <- BSgenome.Hsapiens.UCSC.hg19

#codon frequency, coverage, and annotation

9

codonData <- codonInfo(listReadsCodon, genomeSeq, orfCoord)

## Warning in codonInfo(listReadsCodon, genomeSeq, orfCoord):

Param motifSize should

be an integer! Accepted values 3, 6 or 9.

Default value is 3.

## Warning in result_fetch(res@ptr, n = n):
‘dbFetch()‘ should only be used with ‘SELECT‘ queries.

‘dbGetQuery()‘, ‘dbSendQuery()‘ and

Did you mean ‘dbExecute()‘,

‘dbSendStatement()‘ or ‘dbGetRowsAffected()‘?

data("codonDataCtrl")

head(codonDataCtrl[[1]], n=3)

##

AAA AAC AAG AAT ACA ACC ACG ACT AGA AGC AGG AGT ATA ATC ATG ATT CAA

## uc010nxq.1

## uc001abv.1

## uc001abw.1

1

0

1

2

4

1

6

8 18

0

0

2

1

1

2

3

4 13

2

0

7

2

1

4

2

3

3

3

8

6

1

21

11

6

1

2

0

2

2

3

5

8

3

3

8

0

1

1

0

0

4

##

CAC CAG CAT CCA CCC CCG CCT CGA CGC CGG CGT CTA CTC CTG CTT GAA GAC

## uc010nxq.1

## uc001abv.1

7

5

5

5

2

2

3

1

9

5

0

4

4

2

## uc001abw.1 16 27

6 14 45 13

12

0

4

8

0

3

0

5

10

21

0

1

3

1

0

1

3

2

8

6

13

56

2

1

5

1

1

5

3

6

22

##

GAG GAT GCA GCC GCG GCT GGA GGC GGG GGT GTA GTC GTG GTT TAA TAC TAG

## uc010nxq.1

## uc001abv.1

6

5

## uc001abw.1 41

1

2

7

1

1

2

5

1

1

2

0

7 38 11 11

3

0

7

2

6

1

4

30

26

3

2

7

0

0

1

1

3

9

5

3

12

2

1

3

0

0

0

1

0

6

1

0

0

##

TAT TCA TCC TCG TCT TGA TGC TGG TGT TTA TTC TTG TTT

## uc010nxq.1

## uc001abv.1

## uc001abw.1

0

0

2

0

0

3

5

4 17

0

0

6

3

2

4

0

0

1

3

4

8

0

1

5

3

2

4

0

0

0

3

3

14

2

1

5

3

0

2

The codon coverage can be used to study the ribosome translation dynamics. One can test
if codon motifs accumulating ribo-seq reads represent a stalling in the ribosome progression.
In the RiboProfiling package we have implemented the codonPCA function that performs a
PCA analysis on a matrix of read density on codons (figures 8).

codonUsage <- codonData[[1]]

codonCovMatrix <- codonData[[2]]

#keep only genes with a minimum number of reads

nbrReadsGene <- apply(codonCovMatrix, 1, sum)

ixExpGenes <- which(nbrReadsGene >= 50)

codonCovMatrix <- codonCovMatrix[ixExpGenes, ]

#get the PCA on the codon coverage

codonCovMatrixTransp <- t(codonCovMatrix)

rownames(codonCovMatrixTransp) <- colnames(codonCovMatrix)

colnames(codonCovMatrixTransp) <- rownames(codonCovMatrix)

listPCACodonCoverage <- codonPCA(codonCovMatrixTransp, "codonCoverage")

listPCACodonCoverage[[2]]

## $`PC_1-2`
##
## $`PC_1-3`
##
## $`PC_1-4`

10

##
## $`PC_2-3`
##
## $`PC_2-4`

Figure 8: PCA on codon coverage for the ctrlGAlignments example data.

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:

##

##

##

##

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

## other attached packages:

11

##

##

[1] RSQLite_2.4.3
[4] Seqinfo_0.99.2
[7] S4Vectors_0.47.4

##
## [10] knitr_1.50
##

RiboProfiling_1.39.1 Biostrings_2.77.2
XVector_0.49.1
BiocGenerics_0.55.1

IRanges_2.43.5
generics_0.1.4

## loaded via a namespace (and not attached):

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1] DBI_1.2.3
[2] bitops_1.0-9
[3] RBGL_1.85.0
[4] gridExtra_2.3
[5] tcltk_4.5.1
[6] rlang_1.1.6
[7] magrittr_2.0.4
[8] biovizBase_1.57.1
[9] matrixStats_1.5.0
[10] compiler_4.5.1
[11] mgcv_1.9-3
[12] GenomicFeatures_1.61.6
[13] png_0.1-8
[14] vctrs_0.6.5
[15] reshape2_1.4.4
[16] ProtGenerics_1.41.0
[17] stringr_1.5.2
[18] pkgconfig_2.0.3
[19] crayon_1.5.3
[20] fastmap_1.2.0
[21] magick_2.9.0
[22] backports_1.5.0
[23] labeling_0.4.3
[24] Rsamtools_2.25.3
[25] rmarkdown_2.30
[26] graph_1.87.0
[27] UCSC.utils_1.5.0
[28] tinytex_0.57
[29] bit_4.6.0
[30] xfun_0.53
[31] cachem_1.1.0
[32] GenomeInfoDb_1.45.12
[33] jsonlite_2.0.0
[34] blob_1.2.4
[35] highr_0.11
[36] DelayedArray_0.35.3
[37] BiocParallel_1.43.4
[38] parallel_4.5.1
[39] cluster_2.1.8.1
[40] R6_2.6.1
[41] VariantAnnotation_1.55.1
[42] stringi_1.8.7
[43] RColorBrewer_1.1-3
[44] rtracklayer_1.69.1
[45] rpart_4.1.24

12

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[46] GenomicRanges_1.61.5
[47] Rcpp_1.1.0
[48] SummarizedExperiment_1.39.2
[49] base64enc_0.1-3
[50] splines_4.5.1
[51] Matrix_1.7-4
[52] nnet_7.3-20
[53] tidyselect_1.2.1
[54] rstudioapi_0.17.1
[55] dichromat_2.0-0.1
[56] abind_1.4-8
[57] yaml_2.3.10
[58] codetools_0.2-20
[59] curl_7.0.0
[60] lattice_0.22-7
[61] tibble_3.3.0
[62] plyr_1.8.9
[63] withr_3.0.2
[64] Biobase_2.69.1
[65] KEGGREST_1.49.1
[66] S7_0.2.0
[67] evaluate_1.0.5
[68] foreign_0.8-90
[69] pillar_1.11.1
[70] BiocManager_1.30.26
[71] MatrixGenerics_1.21.0
[72] TxDb.Hsapiens.UCSC.hg19.knownGene_3.2.2
[73] checkmate_2.3.3
[74] OrganismDbi_1.51.4
[75] RCurl_1.98-1.17
[76] ensembldb_2.33.2
[77] ggplot2_4.0.0
[78] scales_1.4.0
[79] BiocStyle_2.37.1
[80] ggbio_1.57.1
[81] chron_2.3-62
[82] glue_1.8.0
[83] Hmisc_5.2-4
[84] lazyeval_0.2.2
[85] tools_4.5.1
[86] BiocIO_1.19.0
[87] data.table_1.17.8
[88] BSgenome_1.77.2
[89] GenomicAlignments_1.45.4
[90] gsubfn_0.7
[91] XML_3.99-0.19
[92] grid_4.5.1
[93] AnnotationDbi_1.71.1
[94] colorspace_2.1-2
[95] nlme_3.1-168
[96] htmlTable_2.4.3

13

##

##

[97] restfulr_0.0.16
[98] proto_1.0.0
[99] Formula_1.2-5

##
## [100] cli_3.6.5
## [101] sqldf_0.4-11
## [102] S4Arrays_1.9.1
## [103] dplyr_1.1.4
## [104] AnnotationFilter_1.33.0
## [105] gtable_0.3.6
## [106] BSgenome.Hsapiens.UCSC.hg19_1.4.3
## [107] digest_0.6.37
## [108] SparseArray_1.9.1
## [109] rjson_0.2.23
## [110] htmlwidgets_1.6.4
## [111] farver_2.1.2
## [112] memoise_2.0.1
## [113] htmltools_0.5.8.1
## [114] lifecycle_1.0.4
## [115] httr_1.4.7
## [116] bit64_4.6.0-1

14

