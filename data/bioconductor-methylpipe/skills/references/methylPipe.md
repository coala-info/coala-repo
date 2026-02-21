methylPipe

Kamal Kishore, Mattia Pelizzola

October 30, 2025

Contents

1 Introduction

2 Quick overview

3 Profiling Genome wide DNA methylation

4 Descriptive statistics of DNA methylation

5 Profiling DNA methylation on genomic ranges

6 Differential DNA methylation

7 Session Information

1

Introduction

1

1

2

5

7

9

11

In this document you can find a brief tutorial on the methylPipe package for the analysis of base-pair
resolution DNA methylation data. DNA methylation is a potentially heritable epigenetic modification of
the genomic DNA typical of most eukaryotic organisms and critical for the regulation of gene transcription.
The level of DNA methylation varies according to age, diet and environment and an appropriate control of
methylation patterns is important for the onset of cellular differentiation processes and can be deregulated
in diseases as cancer. In eukaryotic genomes the methyl group can be added to Cytosines in the CG, CHG
and CHH sequence context (H being one of A, C or T). It is nowadays possible to generate genome-wide
base-pair resolution DNA methylation maps (see Lister R et al Nature 2009). methylPipe is an R package
that includes a series of objects and methods for a memory efficient management, query, analysis and
visualization of DNA methylation data and their integration with heterogeneous data types. This package
has been developed alongwith compEpiTools which provide functions and methods for the analysis of
epigenomics data. The data package ListerEtAlBSseq has also been developed which consists of base
resolution Bisulfite sequencing data of H1 and IMR90 cell line (Lister R et al Nature 2009).

The overview section of this document will briefly walk you through the main available functionalities,
while the following sections will provide additional details on a selection of available classes and methods.

2 Quick overview

A number of classes are defined in methylPipe: BSdata, BSdataSet, GEcollection and GElist.

• BSdata is a reference class to store base resolution DNA methylation data generated from a high-

thoughput sequencing experiment for a given biological sample.

1

• The BSdataSet class allows combining DNA methylation data for several samples for the same

organism.

• The GEcollection class is used to store the DNA methylation status of a collection of genomic

regions.

• The GElist class is the list of multiple objects of class GEcollection.

methylPipe consists of methods which allows analysis and visualisation of genome wide DNA methy-
lation data. The meth.call function processes methylation information from aligned files and creates
tabular data file. BSprepare processes and tabix compresses such tabular data files for creation of a
BSdata object for each sample. The BSdataSet classe stores multiple such samples of class BSdata. The
mCsmoothing methods extracts DNA methylation data for a given genomic region and smooths/plots it.
For methylation analysis on your regions of interest GEcollection and GElist acts as a repository of
methylation data across various genomic ranges. getCpos and getCposDensity retrieves all potential
genomic cytosine positions and their density across genomic regions, repectively. mapBSdata2GRanges
allows extraction of DNA methylation information across multiple genomic ranges and profileDNAmetBin
determines the absolute and relative methylation to create a GEcollection object. Different methods for
the detection of differentially methylated regions are implemented, according to the number of samples (see
findDMR and consolidateDMRs). In addition the methylation profile can be visualised using plotMeth.
Morover, integrative analysis with other epignomics dataset can be performed by using heatmapdata,
heatmapPlot functions of the package compEpiTools.

The methods that are most demanding in terms of computational resources are optimized for low
memory fingerprint and multi-processor support. methylPipe includes a series of objects and methods
that can be used as building blocks for the creation of pipelines for the data analysis of epigenomics
data, with particular emphasis on DNA methylation, and their integration with any kind of annotation
or additional data type.

3 Profiling Genome wide DNA methylation

First of all the methylPipe and the genome sequence libraries are loaded:

library(methylPipe)
library(BSgenome.Hsapiens.UCSC.hg18)

The DNA methylation information can be read from a text file. See the documentation of the
BSprepare on how to build data suitable to populate a BSdata object. Moreover, the methylation infor-
mation can also be read directly from the sorted SAM file(s) generated from the BISMARK aligner. The
function meth.call process the sorted SAM file. The user can specify the sequence context in which the
methylation information is read from these files either ”CpG” or ”All”. In case of whole genome Bisulfite
data especially in case of non-CG methylation the number of potential methylation sites are enormous
and vast majority of them are unmethylated. In order to avoid storing too much data while maintaining
the ability to identify methylated, unmethylated and uncovered Cytosines, methylPipe only stores and
access C positions with at least 1 mC read. Genomic regions not covered by sequencing are stored as
a GRanges object. The function meth.call produces methylation call text file and uncovered genomic
regions file for each sample in the output folder. Finally, when profiling DNA methylation unmethylated
Cs are determined as those genomic cytosines not having any methylated reads and not belogning to
uncovered genomic regions.

2

file_loc <- system.file('extdata', 'test_methcall', package='methylPipe')
meth.call(files_location=file_loc, output_folder=tempdir(), no_overlap=TRUE,

read.context="CpG", Nproc=1)

methylPipe adopts TABIX compressed indexing of flatfiles to reduce disk space which allows fast
access. The methylPipe library includes a small subset of the first two base resolution human DNA
methylomes (Lister R et al Nature 2009) for two well known human cell lines: embryonic stem cells
(H1) and fetal lung fibroblasts (IMR90). The methylation data can be stored into BSdata objects and
then collected together within a BSdataSet object. The BSprepare command is not run in the following
example since it requires a local copy of tabix software. Hence, for this example we use pre-generated
tabix indexed files from methylPipe for H1 and IMR90.

file_loc <- system.file('extdata', 'H1_chr20_CG_10k.txt', package='methylPipe')
#BSprepare(files_location=file_loc,output_folder=file_loc, tabix="/path-to-tabix/")
uncov_GR <- GRanges(Rle('chr20'), IRanges(c(14350,69251,84185), c(18349,73250,88184)))
H1data <- system.file('extdata', 'H1_chr20_CG_10k_tabix_out.txt.gz',

H1.db <- BSdata(file=H1data, uncov=uncov_GR, org=Hsapiens)
H1.db

package='methylPipe')

Context

seqnames

ranges strand |

ranges strand
<IRanges> <Rle>
*
*
*

seqnames
<Rle>
chr20 14350-18349
chr20 69251-73250
chr20 84185-88184

[1]
[2]
[3]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

## GRanges object with 3 ranges and 0 metadata columns:
##
##
##
##
##
##
##
## [1] "chr20"
## GRanges object with 6 ranges and 4 metadata columns:
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

T
<Rle> <IRanges> <Rle> | <character> <numeric> <numeric>
4
chr20
4
chr20
0
chr20
0
chr20
0
chr20
chr20
0
Significance
<numeric>
20
48
14
84
14
102

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

8179
8180
8426
8427
8432
8433

+ |
- |
+ |
- |
+ |
- |

[1]
[2]
[3]
[4]
[5]
[6]

CG
CG
CG
CG
CG
CG

2
4
1
5
1
6

C

Multiple BSdata objects can be stored in BSdataSet object by specifying group name for each sample

either as ”C” (control) or ”E” (Experiment):

3

IMR90data <- system.file('extdata', 'IMR90_chr20_CG_10k_tabix_out.txt.gz',

package='methylPipe')

IMR90.db <- BSdata(file=IMR90data, uncov=uncov_GR, org=Hsapiens)
H1.IMR90.set <- BSdataSet(org=Hsapiens, group=c("C","E"), IMR90=IMR90.db, H1=H1.db)
H1.IMR90.set

## S4 Object of class BSdataSet
##
## BSdata objects contained:

## [1] "IMR90" "H1"

##
## Groups of objects:

## [1] "C" "E"

##
## Associated organism genome:
## Homo sapiens
##

The data includes the chromosome, the genomic position, strand and sequence context for each methyl-
Cytosine (mC). In addition, for each mC the number of reads with C at that genomic position and strand
(supporting DNA methylation), the number of reads with T (evidence of an unmethylated C) and the
binomial p-value supporting the mC call are attached. Importantly, these data are referenced into the
BSdata but they are not actually loaded into the memory. The mCsmoothing method allow uploading
into memory the DNA methylation data for a given genomic region and to display their methylation
profile over it. The smoothing can be performed by either ”sum” or ”mean” of methylation level for each
regions.

gr <- GRanges("chr20",IRanges(1,5e5))
sres <- mCsmoothing(H1.db, gr, Scorefun='sum', Nbins=50, plot=TRUE)

4

4 Descriptive statistics of DNA methylation

methylPipe allows checking the basic stats about the methylation data such as range, mean and quantile
distribution of methylation and assess sample similarity with correlation and clustering analysis. The
methstats method computes pairwise correlation coefficients (Pearson) between the methylation profiles
across all the samples in BSdataSet object.
It outputs scatter plot matrix of correlation coefficients.
Finally, it performs (eucledian distance based) hierarchical clustering of samples and outputs the dendro-
gram. In the example below, the analysis is performed on BSdataSet object of artificially replicated H1
and IMR90.

stats.set <- BSdataSet(org=Hsapiens, group=c("C","C","E","E"), IMR_1=IMR90.db,
IMR_2=IMR90.db, H1_1=H1.db,H1_2=H1.db)
stats_res <- methstats(stats.set,chrom="chr20",mcClass='mCG', Nproc=1)

## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter
## Warning in par(usr): argument 1 does not name a graphical parameter

5

Smoothed methylation levels02040608010011000012000013000014000015e+05Genomic co−ordinatesMethylation Level (mC/total reads)## Warning in par(usr): argument 1 does not name a graphical parameter

stats_res

H1_1

IMR_2

Min.
:0.0000
1st Qu.:0.5360
Median :0.8570
Mean
:0.7136
3rd Qu.:1.0000
:1.0000
Max.

Min.
:0.0000
1st Qu.:0.5360
Median :0.8570
Mean
:0.7136
3rd Qu.:1.0000
:1.0000
Max.

## $descriptive_stats
##
IMR_1
##
##
##
##
##
##
##
## $correlation_mat
##
H1_2
## IMR_1 1.0000000 1.0000000 0.1653737 0.1653737
## IMR_2 1.0000000 1.0000000 0.1653737 0.1653737
## H1_1 0.1653737 0.1653737 1.0000000 1.0000000
## H1_2 0.1653737 0.1653737 1.0000000 1.0000000

Min.
:0.0000
1st Qu.:0.6670
Median :0.8480
Mean
:0.7497
3rd Qu.:0.9700
:1.0000
Max.

IMR_2

IMR_1

H1_1

H1_2

Min.
:0.0000
1st Qu.:0.6670
Median :0.8480
Mean
:0.7497
3rd Qu.:0.9700
:1.0000
Max.

6

IMR_10.00.40.80.00.40.80.00.40.80.00.40.8r= 1.00p<0.01IMR_2r= 0.17p<0.01r= 0.17p<0.01H1_10.00.40.80.00.40.80.00.40.8r= 0.17p<0.01r= 0.17p<0.010.00.40.8r= 1.00p<0.015 Profiling DNA methylation on genomic ranges

methylPipe allows profiling DNA methylation over a set of genomic regions and determining their absolute
or relative methylation profiles. Absolute methylation is here defined as the genomic density of mC calls
per bp, while relative methylation is the proportion of density of methylated genomic sites over the density
of potential methylation sites.

The mapBSdata2GRanges method retrieves mC calls given a BSdata object of a sample and a set of
genomic regions. In the following example we will extract the CG sites for a set of genomic regions. In
particular we will consider a GRanges object of genomic regions that spans 2Kb upstream and downstream
the TSS of the transcript ids on the first 500Kb of chromosome 20:

gr_file <- system.file('extdata', 'GR_chr20.Rdata', package='methylPipe')
load(gr_file)
resmC <- mapBSdata2GRanges(GenoRanges=GR_chr20, Sample=H1.db, context='CG')
head(resmC[[4]])

C

Context

seqnames

CG
CG
CG
CG
CG
CG

ranges strand |

[1]
[2]
[3]
[4]
[5]
[6]

+ |
+ |
- |
+ |
- |
- |

116504
116757
116758
116796
116797
117132

## GRanges object with 6 ranges and 4 metadata columns:
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

T
<Rle> <IRanges> <Rle> | <character> <numeric> <numeric>
25
chr20
4
chr20
12
chr20
0
chr20
1
chr20
3
chr20
Significance
<numeric>
202
227
334
564
128
132

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

18
15
24
32
8
9

To profile DNA methylation on genomic regions of interest the GEcollection class (collection of ge-
nomic regions) is used. These genomic regions can be any regions of interest such as one or more gene
loci, promoter regions, a set of transcription factor binding sites, a set of regions enriched by some his-
tone mark or a set of transposable elements. Most of these regions can be usually retrieved from either
publications or public databases like the UCSC Genome Browser and its Table Browser tools (see com-
pEpiTools for methods for generation/manipulation of these regions). The GEcollection class has data
slots and methods tailored for storing and analyzing DNA methylation data. It is an extension of the
RangedSummarizedExperiment class from the SummarizedExperiment package.

For the creation of the GEcollection, the getCpos and mapBSdata2GRanges methods are called auto-
matically to populate its various data slots. Further arguments of the latter function allows to filter the
mC sites based on the depth of sequencing, number of reads with C at that genomic position and their
binomial p-value. The profileDNAmetBin method acts as a wrapper for these methods to profile absolute
and relative DNA methylation for a set of regions within a GEcollection. In particular for each genomic
region, and possibly each bin of it, the absolute methylation density (mC/bp), the density of possible
methylation sites (C/bp) and the relative methylation level (mC/C) will be determined. For example,

7

in case of the CG context: mCG/bp, CG/bp and mCG/CG densities will be stored for each bin of each
genomic region in the binmC, binC and binrC data slots, respectively.

gec.H1 <- profileDNAmetBin(GenoRanges=GR_chr20, Sample=H1.db, mcCLASS='mCG', nbins=3)

## Warning in min(assays(object)[["binscore"]], na.rm = TRUE): no non-missing arguments to
min; returning Inf

binmC(gec.H1)[4:5,]

1

##
3
## [1,] 0.00378 0.00911 0.01440
## [2,] 0.00969 0.01170 0.00825

2

binC(gec.H1)[4:5,]

##
3
1
## [1,] 0.0075 0.0165 0.0210
## [2,] 0.0150 0.0180 0.0105

2

binrC(gec.H1)[4:5,]

##
3
1
## [1,] 50.4 55.2 68.8
## [2,] 64.6 64.8 78.6

2

GEcollection objects can be subsetted and combined. Subset can be useful to work only on the

regions on a particular strand and/or chromosome or chromosomal region.

gec1 <- gec.H1[start(gec.H1) < 153924]
gec2 <- gec.H1[start(gec.H1) > 153924]

Multiple GEcollection objects can be saved into a GElist object. This can be convenient if there are
many of them and if one would like to iteratively apply the same method to them, for example profiling
DNA methylation for their genomic regions in the same sample.

gecIMR_file <- system.file('extdata', 'gec.IMR90.Rdata', package='methylPipe')
load(gecIMR_file)
gel <- GElist(gecIMR90=gec.IMR90, gecH1=gec.H1)
print(names(gel))

## [1] "gecIMR90" "gecH1"

The GElist objects can be visualized using plotMeth. This allows methylation data of various samples
to be displayed together with the annotation information for the genomic regions of interest. Morover,
various epigenomics data tracks can also be visualized together with the methylation information. See
the documentation of the plotMeth for more details.

library(TxDb.Hsapiens.UCSC.hg18.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg18.knownGene
gel <- GElist(gecIMR90=gec.IMR90[1:10], gecH1=gec.H1[1:10])

8

plotMeth(gel, colors=c("red","blue"), datatype=c("mC","mC"), yLim=c(.025, .025), brmeth=list(IMR90=IMR90.db, H1=H1.db),

mcContext="CG", transcriptDB=txdb, chr="chr20", start=14350, end=277370, org=Hsapiens)

6 Differential DNA methylation

The findDMR function can be used to identify differentially methylated regions (DMRs) for any sequence
context (mCG, mCHG or mCHH). DMRs can be identified comparing the mC methylation levels (the
proportion of methylated over total reads for a set of mC) between two samples or within a group of
N samples, with the Wilcoxon or the Kruskal-Wallis non parametric test, respectively. Only cytosine
positions covered in both the samples (pairwise analysis) or all the samples (multiple sample analysis) are
considered for DMR identification. The algorithm uses dynamic sliding window approach which identifies
DMRs depending on methylated cytosine frequency and their relative distance. Moreover, to perform
regions specific analysis (such as promoter or CpG island centric) genomic regions could be specified and
the alogirithm will report DMRs only within those regions, if any. In a first step, all the evaluated regions
are reported in the output with their corresponding statistical significance. The methylation difference is
determined in terms of MethDiffPerc (percentage difference between the mean methylation of experiment
and control) and log2Enrichment (log2 of mean methylation of experiment over control).

9

Chromosome 2050 kb100 kb150 kb200 kb250 kb00.0050.010.0150.020.025gecIMR9000.0050.010.0150.020.025gecH100.20.40.60.8IMR9000.20.40.60.8H1Transcriptsuc002wcw.1uc002wcy.1uc002wdf.1uc002wdg.2uc002wdh.1uc002wdi.2uc002wcz.1uc002wdc.1uc002wdd.1uc002wde.1uc002wcx.1uc002wda.1uc002wdb.1DMRs <- findDMR(object= H1.IMR90.set, Nproc=1, ROI=GR_chr20, MCClass='mCG',

dmrSize=6, dmrBp=800)

head(DMRs)

ranges strand |

[1]
[2]
[3]
[4]
[5]
[6]

* |
* |
* |
* |
* |
* |

seqnames
<Rle>
chr20 14404-15060
chr20 15001-15095
chr20 15760-15906
chr20 16170-16792
chr20 16721-17355
chr20 69287-69975

pValue MethDiff_Perc
<numeric>
37.133
41.817
8.800
40.033
35.133
40.033

<IRanges> <Rle> | <numeric>
0.036
0.036
0.787
0.059
0.059
0.059

## GRanges object with 6 ranges and 3 metadata columns:
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

[1]
[2]
[3]
[4]
[5]
[6]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

log2Enrichment
<numeric>
1.486
1.341
0.181
1.188
0.917
1.277

The consolidateDMRs function can be used to multiple-testing correct the DMRs and consolidate
them according to their relative distance, type of DMRs and thresholds of p-value/Methylation differ-
ence/log enrichment. A final GRanges object with the set of DMRs including p-value, methylation
difference and log enrichment is provided:

hyper.DMRs.conso <- consolidateDMRs(DmrGR=DMRs, pvThr=0.05, GAP=100, type="hyper")
hyper.DMRs.conso[1:4]

[1]
[2]
[3]
[4]

* |
* |
* |
* |

ranges strand |

seqnames
<Rle>
chr20 14404-15095
chr20 69927-70629
chr20 72059-72852
chr20 84742-85118

pValue MethDiff_Perc
<numeric>
39.475
32.717
52.458
36.750

<IRanges> <Rle> | <numeric>
0.010
0.036
0.010
0.036

## GRanges object with 4 ranges and 3 metadata columns:
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

[1]
[2]
[3]
[4]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

log2Enrichment
<numeric>
1.414
1.320
2.037
0.921

10

LAPACK version 3.12.0

7 Session Information

sessionInfo()

stats
base

graphics grDevices utils

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
##
##
##
##
##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4
## [7] methods
##
## other attached packages:
##
##
##
##
##
##
##
##
##
## [10] Biostrings_2.78.0
## [11] XVector_0.50.0
## [12] SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0
## [14] MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0
## [16] GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0
## [18] IRanges_2.44.0
## [19] S4Vectors_0.48.0
## [20] BiocGenerics_0.56.0
## [21] generics_0.1.4

[1] TxDb.Hsapiens.UCSC.hg18.knownGene_3.2.2
[2] GenomicFeatures_1.62.0
[3] AnnotationDbi_1.72.0
[4] BSgenome.Hsapiens.UCSC.hg18_1.3.1000
[5] BSgenome_1.78.0
[6] rtracklayer_1.70.0
[7] BiocIO_1.20.0
[8] methylPipe_1.44.0
[9] Rsamtools_2.26.0

datasets

11

[1] DBI_1.2.3
[3] deldir_2.0-4
[5] httr2_1.2.1
[7] rlang_1.1.6
[9] biovizBase_1.58.0

bitops_1.0-9
gridExtra_2.3
biomaRt_2.66.0
magrittr_2.0.4
compiler_4.5.1
png_0.1-8
ProtGenerics_1.42.0
pkgconfig_2.0.3
fastmap_1.2.0
dbplyr_2.5.1
rmarkdown_2.30
bit_4.6.0
cachem_1.1.0
GenomeInfoDb_1.46.0
progress_1.2.3
highr_0.11
BiocParallel_1.44.0
parallel_4.5.1
cluster_2.1.8.1

##
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
##
##

[11] RSQLite_2.4.3
[13] vctrs_0.6.5
[15] stringr_1.5.2
[17] crayon_1.5.3
[19] backports_1.5.0
[21] caTools_1.18.3
[23] UCSC.utils_1.6.0
[25] xfun_0.53
[27] cigarillo_1.0.0
[29] jsonlite_2.0.0
[31] blob_1.2.4
[33] DelayedArray_0.36.0
[35] jpeg_0.1-11
[37] prettyunits_1.2.0
[39] VariantAnnotation_1.56.0 R6_2.6.1
[41] stringi_1.8.7
[43] limma_3.66.0
[45] Gviz_1.54.0
[47] knitr_1.50
[49] Matrix_1.7-4
[51] tidyselect_1.2.1
[53] dichromat_2.0-0.1
[55] yaml_2.3.10
[57] codetools_0.2-20
[59] lattice_0.22-7
[61] KEGGREST_1.50.0
[63] evaluate_1.0.5
[65] BiocFileCache_3.0.0
[67] filelock_1.0.3
[69] checkmate_2.3.3
[71] ensembldb_2.34.0
[73] ggplot2_4.0.0
[75] gtools_3.9.5
[77] glue_1.8.0
[79] lazyeval_0.2.2
[81] interp_1.1-6
[83] GenomicAlignments_1.46.0 XML_3.99-0.19
[85] grid_4.5.1
[87] colorspace_2.1-2
[89] restfulr_0.0.16
[91] cli_3.6.5
[93] S4Arrays_1.10.0

RColorBrewer_1.1-3
rpart_4.1.24
Rcpp_1.1.0
base64enc_0.1-3
nnet_7.3-20
rstudioapi_0.17.1
abind_1.4-8
gplots_3.2.0
curl_7.0.0
tibble_3.3.0
S7_0.2.0
foreign_0.8-90
pillar_1.11.1
KernSmooth_2.23-26
RCurl_1.98-1.17
hms_1.1.4
scales_1.4.0
marray_1.88.0
Hmisc_5.2-4
tools_4.5.1
data.table_1.17.8

latticeExtra_0.6-31
htmlTable_2.4.3
Formula_1.2-5
rappdirs_0.3.3
dplyr_1.1.4

12

[95] AnnotationFilter_1.34.0 gtable_0.3.6
##
[97] digest_0.6.37
##
##
[99] rjson_0.2.23
## [101] farver_2.1.2
## [103] htmltools_0.5.8.1
## [105] httr_1.4.7
## [107] bit64_4.6.0-1

SparseArray_1.10.0
htmlwidgets_1.6.4
memoise_2.0.1
lifecycle_1.0.4
statmod_1.5.1

13

