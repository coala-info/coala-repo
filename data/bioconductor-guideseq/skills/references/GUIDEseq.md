GUIDEseq user’s guide

Lihua Julie Zhu, Michael Lawrence, Ankit Gupta,
Herve Pages,

Alper Kucukural, Manuel Garber, Scot Wolfe

October 30, 2025

Contents

1

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 Workflow of GUIDE-seq data analysis . . . . . . . . . .

2.1

2.2

2.3

2.4

Step 1: Remove PCR bias and obtain unique cleavage
events . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Step 2: Summarize cleavage events . . . . . . . . . . . .

Step 3: Merge peaks from plus and minus strand . . . .

Step 4: Off target analysis of extended regions around
the identified cleavage sites . . . . . . . . . . . . . . . . .

2.5

Run all steps in one workflow function . . . . . . . . . . .

3 References . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4

Session Info . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

4

4

5

6

6

7

8

1

Introduction

The most recently developed genome editing system, CRISPR-Cas9 has greater
inherent flexibility than prior programmable nuclease platforms because sequence-
specific recognition resides primarily within the associated sgRNA, which permits
a simple alteration of its recognition sequence. The short Protospacer Adjacent
Motif (PAM), which is recognized by Cas9, is the chief constraint on the target

GUIDEseq user’s guide

site design density. Because of its simplicity and efficacy, this technology is
revolutionizing biological studies and holds tremendous promise for therapeutic
applications(Ledford, 2015; Cox et al., 2015).

However, imperfect cleavage specificity of CRISPR/Cas9 nuclease within the
genome is a cause for concern for its therapeutic application. S. pyogenes
Cas9 (SpyCas9)-based nucleases can cleave an imperfect heteroduplex formed
between the guide sequence and a DNA sequence containing a functional PAM
where the number, position and type of base mismatches can impact the level
of activity (Hsu et al., 2013; Mali et al., 2013; Fu et al., 2013). This degree
of promiscuity is problematic for therapeutic applications, since the generation
of DNA breaks at unintended (off-target) sites has the potential to alter gene
expression and function through direct mutagenesis or the generation of genomic
rearrangements. Experimentally defining the number and activity of off-target
sites for a given Cas9/sgRNA complex genome-wide is critical to assess and
improve nuclease precision.

A new suite of genome-wide off-target detection methods have recently been
described that can identify sites with low cleavage activity within a population of
nuclease-treated cells. One of the most sensitive and straightforward methods to
employ is GUIDE-seq (Tsai et al., 2015). This method relies on erroneous NHEJ-
mediated DNA repair to capture co-introduced blunt-ended double stranded
oligonucleotides (dsODNs) at Cas9-induced breakpoints within the genome.
The GUIDE-seq dsODNs display high insertion frequency (up to 50% of the
measured indel rate (Tsai et al., 2015)) at Cas9-induced DSBs, thereby tagging
these loci for selective amplification and subsequent deep sequencing. The
method is quite sensitive as off-target sites with >0.1% indel frequency can be
detected, and the frequency of dsODN insertion appears to be correlated with
the frequency of Cas9-induced lesions at each site (Tsai et al., 2015). This
method has been used successfully to evaluate the precision of Cas9 and its
variants (tru-sgRNAs (Tsai et al., 2015) or PAM variants (Kleinstiver et al.,
2015)). Given its favorable properties, GUIDE-seq could become a standard in
the nuclease field for off-target analysis.

While the GUIDE-seq method is straightforward to employ, to date no bioin-
formatic tools have been released to the community to support the analysis of
this data. We developed GUIDEseq package to faciliate the analysis of GUIDE-
seq dataset, including retaining one read per unique molecular identifier (UMI),
filtering reads lacking integration oligo sequence (dsODNs), identifying peak
locations (cleavage sites) and heights, merging cleavage sites from plus strand
and those from minus strand, and performing target and off target search of
the input gRNA. This analysis leverages our ChIPpeakAnno package (Zhu et

2

GUIDEseq user’s guide

al., 2010) for merging cleavage sites from plus strand and minus strand, and
CRISPRseek package (Zhu et al., 2014) for defining the homology of any iden-
tified off-target site to the guide sequence and Cas9 PAM specificity.

2 Workflow of GUIDE-seq data analysis

Here is the workflow of GUIDE-seq data analysis with human sequence. First
load GUIDEseq and BSgenome.Hsapiens.UCSC.hg19 .

ce6,

To find BSgenome of other species, please refer to available.genomes in the
BSgenome package. For example, BSgenome.Hsapiens.UCSC.hg19 for hg19,
BSgenome.Mmusculus.UCSC.mm10 for mm10, BSgenome.Celegans.UCSC.ce6
rn5,
BSgenome.Rnorvegicus.UCSC.rn5
for
BSgenome.Drerio.UCSC.danRer7 for Zv9, and BSgenome.Dmelanogaster.UCSC.dm3
for dm3
Then specify the alignment file path as alignment.inputfile, and a umi file path
as umi.inputfile containing unique molecularidentifier for each sequence.
> library(GUIDEseq)
> umifile <- system.file("extdata", "UMI-HEK293_site4_chr13.txt",
+
package = "GUIDEseq")
> bedfile <- system.file("extdata","bowtie2.HEK293_site4_chr13.sort.bed",
package = "GUIDEseq")
+
> bamfile <- system.file("extdata","bowtie2.HEK293_site4_chr13.sort.bam",
package = "GUIDEseq")
+

for

The alignment.inputfile is an alignment file in bed format containing CIGAR
information. The alignment.inputfile contains chromosome, start, end, readID,
mapping quality, strand and CIGAR information as a tab delimited file. Here is
line.
example
an
chr13 27629253 27629403 HWI-M01326:156:1:113:4572:6938/1 44 + 150M
When fastq files are available, scripts for bin reads, remove adaptor, mapping to
genome
available
are
at http://mccb.umassmed.edu/GUIDE-seq/. Otherwise, a one-line, 6-argument
pipeline GS-Preprocess at https://github.com/umasstr/GS-Preprocess (Rodríguez
et al., 2021) can be used to generate the needed input files for GUIDEseq. The
input file for GS-Preprocess is the standard raw data output in BCL file format.

The umi.inputfile is a tab delimited file containing at least two columns, read
IDs and corresponding unique molecular identifiers (UMI). Script for creating
at
umi.inputfile
http://mccb.umassmed.edu/GUIDE-seq/getUmi.pl.
An
file
http://mccb.umassmed.edu/GUIDE-seq/testGetUmi/.
Please make sure to use R1 reads as input to getUmi.pl.

available

example

input

at

is

is

3

GUIDEseq user’s guide

2.1 Step 1: Remove PCR bias and obtain unique cleav-

age events

PCR amplification often leads to biased representation of the starting sequence
population. To track the sequence tags present in the initial sequence library,
unique molecular identifiers (UMI) are added to the 5 prime of each sequence
in the staring library. The function getUniqueCleavageEvents uses the UMI
sequence in the umi.inputfile (optionally contains umi plus the first few sequence
from R1 reads) to obtain the starting sequence library. It also filters out reads
that does not contain the integration oligo sequence, too short or not in the
right paired configuration.

settings

For detailed parameter
please type help(getUniqueCleavageEvents).
> uniqueCleavageEvents <- getUniqueCleavageEvents(bamfile, umifile, n.cores.max =1)
> #uniqueCleavageEventsOld <- getUniqueCleavageEvents(bedfile, umifile)
> uniqueCleavageEvents$cleavage.gr

for

function getUniqueCleavageEvents,

GRanges object with 3841 ranges and 2 metadata columns:

seqnames

ranges strand |

umi
total
<Rle> | <numeric> <character>
CGTATTTT
CTTATAGA
TCATCTTG
TTACCTCC
GCTGCTAT
...
GTTAAACT
ATTATTCA
GGAGTTCT
ACAACAGG
AATAAATT

[1]
[2]
[3]
[4]
[5]
...
[3837]
[3838]
[3839]
[3840]
[3841]
-------
seqinfo: 25 sequences from an unspecified genome; no seqlengths

<Rle> <IRanges>
69979989
chr13
39262929
chr13
94623776
chr13
28089785
chr13
27629410
chr13
...
...
51894561
chr13
93491789
chr13
27629409
chr13
98262510
chr13
37190177
chr13

+ |
+ |
+ |
+ |
+ |
... .
- |
- |
- |
- |
- |

1
1
1
1
1
...
1
1
1
1
1

2.2 Step 2: Summarize cleavage events

Calling the function getPeaks with the results from getUniqueCleavageEvents
outputs summarized cleavage events for each moving window with at least
min.reads of cleavage events.

By default, window size is set to 20, step is set to 20, and min.reads is set
to 2. For detailed parameter settings using function getPeaks, please type
help(getPeaks).
> peaks <- getPeaks(uniqueCleavageEvents$cleavage.gr, min.reads = 80)
> peaks.gr <- peaks$peaks
> peaks.gr

GRanges object with 4 ranges and 5 metadata columns:

seqnames
<Rle>
<IRanges>
chr13 27629413-27629420

[1]

ranges strand |

bg
<Rle> | <integer> <numeric>

count

p.value
<numeric>
0.584 1.49081e-291

+ |

146

4

GUIDEseq user’s guide

+ |
- |
- |

156
103
157

0.624 3.20197e-311
0.412 5.74504e-207
0.636 2.53405e-312

[2]
[3]
[4]

chr13 39262922-39262939
chr13 27629400-27629416
chr13 39262918-39262920
SNratio adjusted.p.value
<numeric>
1.49081e-291
3.20197e-311
5.74504e-207
2.53405e-312

<numeric>
250.000
250.000
250.000
246.855

[1]
[2]
[3]
[4]
-------
seqinfo: 25 sequences from an unspecified genome; no seqlengths

2.3 Step 3: Merge peaks from plus and minus strand

Calling the function mergePlusMinusPeaks with the output from getPeaks to
merge peaks from plus strand and minus strand with specific orientation and
within certain distance apart.

By default, plus.strand.start.gt.minus.strand.end is set to TRUE and distance.threshold
is set to 40, i.e., twice of the window size. For detailed parameter settings using
function
mergePlusMinusPeaks, please type help(mergePlusMinusPeaks).
> mergedPeaks <- mergePlusMinusPeaks(peaks.gr = peaks.gr,
+
> mergedPeaks$mergedPeaks.gr

output.bedfile = "mergedPeaks.bed")

GRanges object with 2 ranges and 2 metadata columns:

chr13+:27629413:27629420:chr13-:27629400:27629416
chr13+:39262922:39262939:chr13-:39262918:39262920

ranges
seqnames
<Rle>
<IRanges>
chr13 27629400-27629420
chr13 39262918-39262939

chr13+:27629413:27629420:chr13-:27629400:27629416
chr13+:39262922:39262939:chr13-:39262918:39262920

strand |

count
<Rle> | <numeric>
249
313

+ |
+ |

chr13+:27629413:27629420:chr13-:27629400:27629416
chr13+:39262922:39262939:chr13-:39262918:39262920
-------
seqinfo: 25 sequences from an unspecified genome; no seqlengths

bg
<numeric>
0.996
1.260

> head(mergedPeaks$mergedPeaks.bed)

1
2

1
2

seqnames minStart

names
chr13 27629400 27629420 chr13+:27629413:27629420:chr13-:27629400:27629416
chr13 39262918 39262939 chr13+:39262922:39262939:chr13-:39262918:39262920

maxEnd

totalCount strand
+
249
+
313

5

GUIDEseq user’s guide

2.4 Step 4: Off target analysis of extended regions

around the identified cleavage sites

package = "CRISPRseek")

Calling the function offTargetAnalysisOfPeakRegions with input gRNA, peaks
and genome of interest, to annotate identified cleavage sites with sequence ho-
settings using function
molgy to input gRNA. For detailed parameter
offTargetAnalysisOfPeakRegions,
please type help(offTargetAnalysisOfPeakRegions)
> library(BSgenome.Hsapiens.UCSC.hg19)
> peaks <- system.file("extdata", "T2plus100OffTargets.bed",
+
> gRNAs <- system.file("extdata", "T2.fa",
+
> outputDir <- getwd()
> offTargets <- offTargetAnalysisOfPeakRegions(gRNA = gRNAs, peaks = peaks,
+
+
+
+
+
+
+
+

format=c("fasta", "bed"),
peaks.withHeader = TRUE, BSgenomeName = Hsapiens,
upstream = 50, downstream =50, PAM.size = 3, gRNA.size = 20,
PAM = "NGG", PAM.pattern = "(NAG|NGG|NGA)$", max.mismatch = 2,
outputDir = outputDir,
orderOfftargetsBy = "predicted_cleavage_score",
allowed.mismatch.PAM = 2, overwrite = TRUE

package = "CRISPRseek")

)

search for gRNAs for input file1...
[1] "Scoring ..."
finish off-target search in sequence 2
finish off-target search in sequence 1
finish feature vector building
finish score calculation
[1] "Done!"

2.5 Run all steps in one workflow function

The function GUIDEseqAnalysis is a wrapper function that uses the UMI se-
quence or plus the first few bases of each sequence from R1 reads to estimate
the starting sequence library, piles up reads with a user defined window and step
size, identify the cleavage sites, merge cleavage sites from plus strand and minus
strand, followed by off target analysis of extended regions around the identified
cleavage sites. For detailed parameter settings using function GUIDEseqAnaly
sis,
please type help(GUIDEseqAnalysis)
> gRNA.file <- system.file("extdata","gRNA.fa", package = "GUIDEseq")
> system.time(guideSeqRes <- GUIDEseqAnalysis(
+
+
+
+
+

alignment.inputfile = bamfile,
umi.inputfile = umifile, gRNA.file = gRNA.file,
orderOfftargetsBy = "peak_score",
descending = TRUE, n.cores.max = 1,
BSgenomeName = Hsapiens, min.reads = 1))

search for gRNAs for input file1...
[1] "Scoring ..."
finish off-target search in sequence 2

6

GUIDEseq user’s guide

finish off-target search in sequence 1
finish feature vector building
finish score calculation
[1] "Done!"
Extract PAM sequence and n.PAM.mismatch.
Done with offtarget search!
Add gene and exon information to offTargets ....
Order offtargets.
Save offtargets.

user system elapsed
7.924
0.449

7.475

> names(guideSeqRes)

[1] "offTargets"
[5] "read.summary"

"merged.peaks"
"sequence.depth"

"peaks"

"uniqueCleavages"

3

References

References

[1] Cox, D.B.T. et al. Therapeutic genome editing: prospects and challenges.

Nat Med, 21, 121-131.

[2] Fu, Y. et al. High-frequency off-target mutagenesis induced by CRISPR-Cas

nucleases in human cells. Nature biotechnology, 31, 822-826.

[3] Hsu et al. DNA targeting specificity of rNA-guided Cas9 nucleases. Nat

Biotechnol. 2013. 31:827-834.

[4] Kleinstiver, B.P. et al. Engineered CRISPR-Cas9 nucleases with altered PAM

specificities. Nature. 2015

[5] Ledford, H. CRISPR, the disruptor. Nature 2015. 522, 20-24.

[6] Mali P. et al. CAS9 transcriptional activators for target specificity screening
and paired nickases for cooperative genome engineering. Nat Biotechnol.
2013. 31(9):833-8

[7] Tsai,S.Q. et al. GUIDE-seq enables genome-wide profiling of off-target cleav-
age by CRISPR-Cas nucleases. Nature biotechnology 2015. 33, 187-197.

[8] Zhu L.J. et al., 2010. ChIPpeakAnno:

a Bioconductor package to
annotate ChIP-seq and ChIP-chip data. BMC Bioinformatics 2010,
11:237doi:10.1186/1471-2105-11-237.

[9] Lihua Julie Zhu, Benjamin R. Holmes, Neil Aronin and Michael Brodsky.
CRISPRseek: a Bioconductor package to identify target-specific guide RNAs
for CRISPR-Cas9 genome-editing systems. Plos One Sept 23rd 2014

7

GUIDEseq user’s guide

[10] Lihua Julie Zhu, Michael Lawrence, Ankit Gupta, Herve Pages, Alper Ku-
cukural, Manuel Garber and Scot A. Wolfe. GUIDEseq: a bioconductor
package to analyze GUIDE-Seq datasets for CRISPR-Cas nucleases. BMC
Genomics. 2017. 18:379

[11] Rodriguez TC, Dadafarin S, Pratt HE, Liu P, Amrani N, Zhu LJ. Genome-
wide detection and analysis of CRISPR-Cas off-targets. Reprogramming the
Genome: CRISPR-Cas-based Human Disease Therapy, Volume 181 2021

4

Session Info

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics

grDevices utils

datasets

methods

[8] base

other attached packages:
[1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
[3] rtracklayer_1.70.0
[5] Biostrings_2.78.0
[7] GUIDEseq_1.40.0
[9] Seqinfo_1.0.0

BiocIO_1.20.0
XVector_0.50.0
GenomicRanges_1.62.0
IRanges_2.44.0

8

GUIDEseq user’s guide

[11] S4Vectors_0.48.0
[13] generics_0.1.4

BiocGenerics_0.56.0
knitr_1.50

loaded via a namespace (and not attached):

[1] RColorBrewer_1.1-3
[3] magrittr_2.0.4
[5] farver_2.1.2
[7] vctrs_0.6.5
[9] memoise_2.0.1
[11] RCurl_1.98-1.17
[13] htmltools_0.5.8.1
[15] progress_1.2.3
[17] curl_7.0.0
[19] SparseArray_1.10.0
[21] httr2_1.2.1
[23] cachem_1.1.0
[25] GenomicAlignments_1.46.0
[27] whisker_0.4.1
[29] mltools_0.3.5
[31] Matrix_1.7-4
[33] fastmap_1.2.0
[35] digest_0.6.37
[37] AnnotationDbi_1.72.0
[39] RSQLite_2.4.3
[41] tfruns_1.5.4
[43] abind_1.4-8
[45] withr_3.0.2
[47] S7_0.2.0
[49] DBI_1.2.3
[51] biomaRt_2.66.0
[53] rappdirs_0.3.3
[55] rjson_0.2.23
[57] tools_4.5.1
[59] glue_1.8.0
[61] restfulr_0.0.16
[63] rhdf5filters_1.22.0
[65] keras_2.16.0
[67] seqinr_4.2-36
[69] tidyr_1.3.1
[71] data.table_1.17.8
[73] pillar_1.11.1
[75] limma_3.66.0

jsonlite_2.0.0
GenomicFeatures_1.62.0
rmarkdown_2.30
multtest_2.66.0
Rsamtools_2.26.0
base64enc_0.1-3
S4Arrays_1.10.0
lambda.r_1.2.4
Rhdf5lib_1.32.0
rhdf5_2.54.0
futile.options_1.0.1
rio_1.2.4
ChIPpeakAnno_3.44.0
lifecycle_1.0.4
pkgconfig_2.0.3
R6_2.6.1
MatrixGenerics_1.22.0
patchwork_1.3.2
regioneR_1.42.0
filelock_1.0.3
httr_1.4.7
compiler_4.5.1
bit64_4.6.0-1
BiocParallel_1.44.0
tensorflow_2.20.0
MASS_7.3-65
DelayedArray_0.36.0
gtools_3.9.5
zip_2.3.3
VennDiagram_1.7.3
InteractionSet_1.38.0
grid_4.5.1
ade4_1.7-23
gtable_0.3.6
ensembldb_2.34.0
hms_1.1.4
stringr_1.5.2
splines_4.5.1

9

GUIDEseq user’s guide

[77] dplyr_1.1.4
[79] lattice_0.22-7
[81] bit_4.6.0
[83] tidyselect_1.2.1
[85] ProtGenerics_1.42.0
[87] futile.logger_1.4.3
[89] Biobase_2.70.0
[91] matrixStats_1.5.0
[93] UCSC.utils_1.6.0
[95] yaml_2.3.10
[97] codetools_0.2-20
[99] tibble_3.3.0
[101] BiocManager_1.30.26
[103] cli_3.6.5
[105] dichromat_2.0-0.1
[107] GenomeInfoDb_1.46.0
[109] zeallot_0.2.0
[111] png_0.1-8
[113] parallel_4.5.1
[115] blob_1.2.4
[117] AnnotationFilter_1.34.0
[119] pwalign_1.6.0
[121] purrr_1.1.0
[123] crayon_1.5.3
[125] rlang_1.1.6
[127] formatR_1.14

BiocFileCache_3.0.0
survival_3.8-3
universalmotif_1.28.0
RBGL_1.86.0
SummarizedExperiment_1.40.0
xfun_0.53
statmod_1.5.1
stringi_1.8.7
lazyeval_0.2.2
evaluate_1.0.5
cigarillo_1.0.0
hash_2.2.6.3
graph_1.88.0
reticulate_1.44.0
Rcpp_1.1.0
CRISPRseek_1.50.0
dbplyr_2.5.1
XML_3.99-0.19
ggplot2_4.0.0
prettyunits_1.2.0
bitops_1.0-9
scales_1.4.0
openxlsx_4.2.8
BiocStyle_2.38.0
KEGGREST_1.50.0

10

