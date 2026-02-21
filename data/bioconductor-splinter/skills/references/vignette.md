SPLINTER

Diana Low

30 October 2025

Package

SPLINTER 1.36.0

Contents

1

2

3

4

5

Introduction .

.

.

.

.

.

Loading the package .

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

Initializing the genome for transcript selection .

Reading in the splicing analysis file .

4.1

Additional annotation .

.

Analyzing a specific gene .

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

.

.

.

.

.

.

.

.

3

3

3

4

5

6

6

6

6

8

9

9

9

9

Inspecting a single gene in more detail (single record) .

Finding relevant transcripts from the ENSEMBL database .

Constructing the region of interest (ROI).

Finding transcripts that contain the ROI .

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

6

Simulating alternatively spliced products .

6.1

6.2

6.3

Simulating the outcome of exon skipping by removing an exonic
region .
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

Simulating the outcome of intron retention by inserting an intronic
region .
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

Comparing sequences before and after removal/insertion of a re-
gion .
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

7

Designing primers to inspect splicing regions .

Getting the DNA of the region of interest.

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

10

10

Using Primer3 to design primers for alternative splicing identification 10

Checking primers coverage .

.

.

.

.

.

.

.

Predicting PCR results using the primers .

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

10

11

5.1

5.2

5.3

5.4

7.1

7.2

7.3

7.4

SPLINTER

8

9

Plotting results .

Session info .

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

12

13

2

SPLINTER

1

Introduction

SPLINTER provides tools to analyze alternative splicing sites, interpret outcomes based on
sequence information, select and design primers for site validiation and give visual representation
of the event to guide downstream experiments.

2

Loading the package

To load the SPLINTER package:

library(SPLINTER)

3

Initializing the genome for transcript selection

In this example, we will be utilizing the mm9 genome for mouse. You will need to install the
appropriate package (eg. BSgenome.Mmusculus.UCSC.mm9) for the genome that you will be
using.

library(BSgenome.Mmusculus.UCSC.mm9)

library(GenomicFeatures)

bsgenome <- BSgenome.Mmusculus.UCSC.mm9

We begin with full set of available transcripts to screen from, and read it into a TxDb
object. One source of this (best option to ensure compatibility) would be the GTF file that
you have used for alternative splicing analysis. For other sources of data, please refer to
GenomicFeatures).

We then extract the coding sequences (CDS), and transcripts in general (coding and non-
coding) (exons) from this object.

data_path<-system.file("extdata",package="SPLINTER")
gtf_file<-paste(data_path,"/Mus_musculus.Ensembl.NCBIM37.65.partial.gtf",sep="")

library(txdbmaker)
txdb <- makeTxDbFromGFF(file=gtf_file,chrominfo = Seqinfo(genome="mm9"))
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object

# txdb generation can take quite long, you can save the object and load it the next time
# saveDb(txdb,file="txdb_hg19.sqlite")
# txdb<-loadDb(file="txdb_hg19.sqlite")

# extract CDS and exon information from TxDb object

thecds<-cdsBy(txdb,by="tx",use.names=TRUE)

theexons<-exonsBy(txdb,by="tx",use.names=TRUE)

3

SPLINTER

4

Reading in the splicing analysis file

The output file from MATS is used here, but essentially all that is needed are coordinates of
the exons (target and flanking) involved in the splicing processt to be studied. For the case of
exon skipping, this will include the upstream, target and downstream exons. More output
types will be supported in the future.

4

SPLINTER

The following types of alternative splicing events are accepted:

Type of alternative splicing event Definition

SE
RI
MXE
A5SS
A3SS

Skipped exon
Retained intron
Mutually exclusive exon
Alternative 5’ splice site
Alternative 3’ splice site

typeofAS="SE"
mats_file<-paste(data_path,"/skipped_exons.txt",sep="")
splice_data <-extractSpliceEvents(data=mats_file, filetype='mats', splicetype=typeofAS)
splice_data$data[,c(1:10)]
ID
##

chr strand exonStart

exonEnd

Symbol

## 4825 ENSMUSG00000052337 ENSMUSG00000052337

chr6

## 17227 ENSMUSG00000023110 ENSMUSG00000023110 chr14

## 22583 ENSMUSG00000079477 ENSMUSG00000079477

chr6

## 13693 ENSMUSG00000024911 ENSMUSG00000024911 chr19

## 18826 ENSMUSG00000027940 ENSMUSG00000027940

chr3

+

-

-

+

+

71816720 71816734

55132128 55132291

87965626 87965712

5464334

5464431

89894935 89895013

##

upstreamStart upstreamEnd downstreamStart downstreamEnd

## 4825

## 17227

## 22583

## 13693

## 18826

71813135

71813264

55130830

55130991

87963632

87963692

5464129

5464215

89893932

89894001

71818574

55133434

87995067

5464925

89903450

71818797

55133483

87995239

5465051

89904487

4.1

Additional annotation
SPLINTER assumes that the main identifier is ENSEMBL, however gene symbols can be
added.

splice_data<-addEnsemblAnnotation(data=splice_data,species="mmusculus")

# (Optional) Sorting the dataframe, if you have supporting statistical information
splice_data$data<-splice_data$data[with(splice_data$data,order(FDR,-IncLevelDifference)),]
head(splice_data$data[,c(1:10)])
##

exonEnd upstreamStart

chr strand exonStart

ID Symbol

## 1 ENSMUSG00000052337

Immt chr6

## 2 ENSMUSG00000023110 Prmt5 chr14

## 3 ENSMUSG00000079477

Rab7 chr6

## 4 ENSMUSG00000024911

Fibp chr19

## 5 ENSMUSG00000027940

Tpm3 chr3

+

-

-

+

+

71816720 71816734

55132128 55132291

87965626 87965712

5464334

5464431

89894935 89895013

71813135

55130830

87963632

5464129

89893932

##

upstreamEnd downstreamStart downstreamEnd

## 1

## 2

## 3

## 4

## 5

71813264

55130991

87963692

5464215

89894001

71818574

55133434

87995067

5464925

89903450

71818797

55133483

87995239

5465051

89904487

5

SPLINTER

5

5.1

Analyzing a specific gene

Inspecting a single gene in more detail (single record)
Once we have defined the events, we will pick 1 event to analyze.

single_id='Prmt5'
pp<-which(grepl(single_id,splice_data$data$Symbol)) # Prmt5 has 1 record

splice_data$data[pp,c(1:6)] # show all records
##

ID Symbol

chr strand exonStart

exonEnd

## 2 ENSMUSG00000023110 Prmt5 chr14

-

55132128 55132291

single_record<-splice_data$data[pp[1],]

5.2

Finding relevant transcripts from the ENSEMBL database
To reduce search complexity, we define the valid transcripts and coding sequences with regards
to our gene of interest. We find that Prmt5 has 7 transcripts, 2 of which are coding sequences.

valid_tx <- findTX(id=single_record$ID,tx=theexons,db=txdb)

valid_cds<- findTX(id=single_record$ID,tx=thecds,db=txdb)

5.3

Constructing the region of interest (ROI)
The makeROI function will create a list containing GRanges objects for the splicing event. This
will help identify and construct relevant outputs later.

This list contains the following information:

• type: type of alternative splicing event
• name: name of gene
• roi: GRanges object of the exon
• flank: GRanges object of the flanking exons
• roi_range: GRanges list containing
• GRanges object of Type 1
• GRanges object of Type 2

6

SPLINTER

Type of alternative
splicing

SE

RI

MXE

A5SS
A3SS

Type 1 representation

isoform with event exon
included
isoform with normal exon
boundaries
isoform defined 1st (leftmost)
in input
isoform with longer exon
isoform with longer exon

Type 2 representation
(annotated only)

isoform with the exon skipped

isoform with the intron retained

isoform defined 2nd in input

isoform with shorter exon
isoform with shorter exon

roi <- makeROI(single_record,type="SE")
roi

## $type

## [1] "SE"

##

## $name

## [1] "ENSMUSG00000023110"

##

## $roi

##

## GRanges object with 1 range and 1 metadata column:
ranges strand | exon_rank
<Rle> | <integer>

<IRanges>

seqnames

<Rle>

##

[1]

chr14 55132128-55132291

- |

1

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

##

##

##

##

## $flank

## GRanges object with 2 ranges and 1 metadata column:
ranges strand | exon_rank
<Rle> | <integer>

<IRanges>

seqnames

<Rle>

##

##

##

##

##

##

[1]

[2]

chr14 55133434-55133483

chr14 55130830-55130991

- |

- |

2

1

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

##
## $roi_range
## GRangesList object of length 2:

## [[1]]

## GRanges object with 3 ranges and 0 metadata columns:

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

[2]

[3]

chr14 55133434-55133483

chr14 55132128-55132291

chr14 55130830-55130991

-

-

-

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

##

##

##

##

##

##

##

##

## [[2]]

## GRanges object with 2 ranges and 0 metadata columns:

7

SPLINTER

##

##

##

##

##

##

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

[2]

chr14 55133434-55133483

chr14 55130830-55130991

-

-

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

5.4

Finding transcripts that contain the ROI
At this juncture, we look for transcripts are compatible with the ROI. Compatibility is defined
as having the exact cassette (matching upstream, target, downstream) exons. In the case of
intron retention, this would just be the 2 exons flanking the intron.

We notice here that Prmt5 only has 1 compatible transcript involved in the event ROI, out of
7 transcripts (or 2 coding transcripts). There are no Type 2 transcripts, which means there
are no annotated transcripts of Prmt5 containing the alternative event.

compatible_tx<- findCompatibleEvents(valid_tx,roi=roi,verbose=TRUE)
## Checking Type 1.....

## ENSMUST00000023873

## Checking Type 2.....

## No transcripts found!

## 1 match(es) from original 7 transcripts.

compatible_cds<- findCompatibleEvents(valid_cds,valid_tx,roi=roi,verbose=TRUE)
## Checking Type 1.....

## ENSMUST00000023873

## Checking Type 2.....

## No transcripts found!

## 1 match(es) from original 2 transcripts.

8

SPLINTER

6

6.1

Simulating alternatively spliced products

Simulating the outcome of exon skipping by removing an ex-
onic region

region_minus_exon <-removeRegion(compatible_cds$hits[[1]],roi)

6.2

Simulating the outcome of intron retention by inserting an in-
tronic region

# Not relevant for this Prmt5 skipped exon example
region_plus_exon <-insertRegion(region_minus_exon,roi)

6.3

Comparing sequences before and after removal/insertion of
a region

event<-eventOutcomeCompare(seq1=compatible_cds$hits[[1]],seq2=region_minus_exon,

genome=bsgenome,direction=TRUE,fullseq=FALSE)

##

## ### ENSMUST00000023873 ###

## Nonsense mediated decay.

## -

early termination

## middle insertion GILKPK (247-252)

## middle deletion LEIGADLP (206-213)

## middle deletion EPIK (224-227)

## middle deletion KAAIL (227-231)

## multiple mismatch sites
## 3' end mismatch : ALEIGADLPSNHVIDRWLGEPIKAAILPTSIFLTNKKGFPVLSKVQQRLIFRLLKLEVQFIITGTNHHSEKEFCSYLQYLEYLSQNRPPPNAYELFAKGYEDYLQSPLQPLMDNLESQTYEVFEKDPIKYSQYQQAIYKCLLDRVPEEEKETNVQVLMVLGAGRGPLVNASLRAAKQAERRIRLYAVEKNPNAVVTLENWQFEEWGSQVTVVSSDMREWVAPEKADIIVSELLGSFADNELSPECLDGAQHFLKDDGVSIPGEYTSFLAPISSSKLYNEVRACREKDRDPEAQFEMPYVVRLHNFHQLSAPKPCFTFSHPNRDPMIDNNRYCTLEFPVEVNTVLHGFAGYFETVLYRDITLSIRPETHSPGMFSWFPIFFPIKQPITVHEGQNICVRFWRCSNSKKVWYEWAVTAPVCSSIHNPTGRSYTIGL* to VGSAVYHHGNQPPLREGVLFLPPVLGILKPKSPSTQCL*
## length : 637 AA to 242 AA

event

## $alignment

## Global-Local PairwiseAlignmentsSingleSubject (1 of 1)

## pattern:

MAAMAVGGAGGSRVSSGRDLNCVPEIADTLGA...GVL----FLP-----PVLGILKPKSPSTQCL*
## subject: [1] MAAMAVGGAGGSRVSSGRDLNCVPEIADTLGA...AILPTSIFLTNKKGFPVL------SKVQQRLI

## score: 1085.5

##

## $eventtypes

## [1] "(NMD)"

9

SPLINTER

7

Designing primers to inspect splicing regions

7.1

Getting the DNA of the region of interest

This function will return the DNA of the ROI, with exons separated by “[]” (Primer3 notation)
and the junction marked by jstart.

aa<-getRegionDNA(roi,bsgenome)

aa

## $seq

## [1] "GTGGCATAACTTTCGGACTCTGTGTGACTATAGCAAGAGAATTGCAGTAG[]TTGGAAGTGCAGTTTATCATCACGGGAACCAACCACCACTCAGAGAAGGAGTTCTGTTCCTACCTCCAGTACTTGGAATACTTAAGCCAAAATCGCCCTCCACCCAATGCCTATGAGCTCTTTGCCAAAGGCTATGAAGACTATCTGCAGTCCCCACTCCAG"

##

## $jstart

## [1] 51

7.2

Using Primer3 to design primers for alternative splicing iden-
tification
We have included a helper function to run Primer3 from within R. You will need to define the
path to your Primer3 installation. Refer to ?callPrimer3 for more details.

primers<-callPrimer3(seq=aa$seq,sequence_target = aa$jstart,size_range='100-500')

primers[,c(1:4)]

##

i

## 1 0

PRIMER_LEFT_SEQUENCE PRIMER_RIGHT_SEQUENCE PRIMER_LEFT_TM
58.967
ACTTTCGGACTCTGTGTGACT TCATAGGCATTGGGTGGAGG

## 2 1

TGGCATAACTTTCGGACTCTG GGAGTGGGGACTGCAGATAG

## 3 2 GCATAACTTTCGGACTCTGTGT CTCCTTCTCTGAGTGGTGGT

## 4 3 TCGGACTCTGTGTGACTATAGC ATTGGGTGGAGGGCGATTTT

## 5 4 GGACTCTGTGTGACTATAGCAAG

GCTCATAGGCATTGGGTGG

58.027

58.673

59.056

58.322

Alternatively, primers can be entered manually with the appropriate headers.

primers <- data.frame(PRIMER_LEFT_SEQUENCE="ACTTTCGGACTCTGTGTGACT",
PRIMER_RIGHT_SEQUENCE="TCATAGGCATTGGGTGGAGG",
stringsAsFactors=FALSE)

7.3

Checking primers coverage
As a confirmation, we can run the primers against the ROI to give the genomic location of
the primer coverage.

cp<-checkPrimer(primers[1,],bsgenome,roi)

cp
## $total_span
## GRanges object with 1 range and 0 metadata columns:

##

##

##

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

chr14 55130876-55133475

*

10

SPLINTER

##

##

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

##
## $primer_left_span
## GRanges object with 1 range and 0 metadata columns:

##

##

##

##

##

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

chr14 55133455-55133475

*

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

##
## $primer_right_span
## GRanges object with 1 range and 0 metadata columns:

##

##

##

##

##

seqnames

<Rle>

ranges strand

<IRanges>

<Rle>

[1]

chr14 55130876-55130895

*

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

7.4

Predicting PCR results using the primers
getPCRsizes will give you the length of the PCR product produced by the set of primers.

pcr_result1<-getPCRsizes(cp,theexons)
pcr_result1
##

ID bp

## 1 ENSMUST00000023873 322

tx_minus_exon <-removeRegion(compatible_tx$hits[[1]],roi)
pcr_result2<-getPCRsizes(cp,tx_minus_exon)
pcr_result2
##

ID bp

## 1 ENSMUST00000023873 158

7.4.1 Selecting sizes relevant to splicing event (subset of getPCRsizes)

While getPCRsizes will return all possible PCR products for a given set of annotation,
splitPCRhit will return PCR product sizes that are relevant to the splicing event in question.

relevant_pcr_bands<-splitPCRhit(pcr_result1,compatible_tx)

relevant_pcr_bands
##

ID bp type

## 1 ENSMUST00000023873 322

1

11

SPLINTER

8

Plotting results

# reading in BAM files
mt<-paste(data_path,"/mt_chr14.bam",sep="")
wt<-paste(data_path,"/wt_chr14.bam",sep="")

# Plotting genomic range, read density and splice changes
eventPlot(transcripts=theexons,roi_plot=roi,bams=c(wt,mt),names=c('wt','mt'),

annoLabel=single_id,rspan=2000)

# Barplot of PSI values if provided
psiPlot(single_record)

12

55.13 mb55.131 mb55.132 mb55.133 mb55.134 mb55.135 mbPrmt5GeneModelENSMUST00000023873ENSMUST00000139964ENSMUST00000132227ENSMUST00000147214ENSMUST00000133552ENSMUST000001383670100200300400wt01020304050mt0.000.250.500.751.00Sample 1Sample 2ConditionPSItypeInclusionSkippedSPLINTER

9

Session info

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

##

##

##

##

## other attached packages:
GenomicFeatures_1.62.0
[1] txdbmaker_1.6.0
[3] AnnotationDbi_1.72.0
Biobase_2.70.0
[5] BSgenome.Mmusculus.UCSC.mm9_1.4.0 BSgenome_1.78.0
[7] rtracklayer_1.70.0
[9] Biostrings_2.78.0
##
## [11] GenomicRanges_1.62.0
## [13] IRanges_2.44.0
## [15] BiocGenerics_0.56.0
## [17] SPLINTER_1.36.0
##

BiocIO_1.20.0
XVector_0.50.0
Seqinfo_1.0.0
S4Vectors_0.48.0
generics_0.1.4
BiocStyle_2.38.0

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

[1] RColorBrewer_1.1-3
[3] jsonlite_2.0.0
[5] farver_2.1.2
[7] vctrs_0.6.5
[9] Rsamtools_2.26.0
[11] base64enc_0.1-3
[13] htmltools_0.5.8.1
[15] progress_1.2.3
[17] SparseArray_1.10.0
[19] htmlwidgets_1.6.4
[21] Gviz_1.54.0
[23] cachem_1.1.0
[25] lifecycle_1.0.4
[27] Matrix_1.7-4

rstudioapi_0.17.1
magrittr_2.0.4
rmarkdown_2.30
memoise_2.0.1
RCurl_1.98-1.17
tinytex_0.57
S4Arrays_1.10.0
curl_7.0.0
Formula_1.2-5
plyr_1.8.9
httr2_1.2.1
GenomicAlignments_1.46.0
pkgconfig_2.0.3
R6_2.6.1

13

SPLINTER

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

MatrixGenerics_1.22.0
colorspace_2.1-2
RSQLite_2.4.3
filelock_1.0.3
httr_1.4.7
compiler_4.5.1
withr_3.0.2
S7_0.2.0
BiocParallel_1.44.0
biomaRt_2.66.0
DelayedArray_0.36.0
tools_4.5.1
nnet_7.3-20
restfulr_0.0.16
checkmate_2.3.3
gtable_0.3.6
data.table_1.17.8
xml2_1.4.1
stringr_1.5.2
BiocFileCache_3.0.0
bit_4.6.0
biovizBase_1.58.0
googleVis_0.7.3
gridExtra_2.3
ProtGenerics_1.42.0

[29] fastmap_1.2.0
[31] digest_0.6.37
[33] Hmisc_5.2-4
[35] seqLogo_1.76.0
[37] labeling_0.4.3
[39] abind_1.4-8
[41] bit64_4.6.0-1
[43] htmlTable_2.4.3
[45] backports_1.5.0
[47] DBI_1.2.3
[49] rappdirs_0.3.3
[51] rjson_0.2.23
[53] foreign_0.8-90
[55] glue_1.8.0
[57] grid_4.5.1
[59] cluster_2.1.8.1
[61] ensembldb_2.34.0
[63] hms_1.1.4
[65] pillar_1.11.1
[67] dplyr_1.1.4
[69] lattice_0.22-7
[71] deldir_2.0-4
[73] tidyselect_1.2.1
[75] knitr_1.50
[77] bookdown_0.45
[79] SummarizedExperiment_1.40.0 xfun_0.53
[81] matrixStats_1.5.0
[83] UCSC.utils_1.6.0
[85] yaml_2.3.10
[87] codetools_0.2-20
[89] interp_1.1-6
[91] BiocManager_1.30.26
[93] rpart_4.1.24
[95] Rcpp_1.1.0
[97] dbplyr_2.5.1
[99] XML_3.99-0.19
##
## [101] ggplot2_4.0.0
## [103] prettyunits_1.2.0
## [105] jpeg_0.1-11
## [107] bitops_1.0-9
## [109] VariantAnnotation_1.56.0
## [111] purrr_1.1.0
## [113] rlang_1.1.6

stringi_1.8.7
lazyeval_0.2.2
evaluate_1.0.5
cigarillo_1.0.0
tibble_3.3.0
cli_3.6.5
dichromat_2.0-0.1
GenomeInfoDb_1.46.0
png_0.1-8
parallel_4.5.1
blob_1.2.4
latticeExtra_0.6-31
AnnotationFilter_1.34.0
pwalign_1.6.0
scales_1.4.0
crayon_1.5.3
KEGGREST_1.50.0

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

14

