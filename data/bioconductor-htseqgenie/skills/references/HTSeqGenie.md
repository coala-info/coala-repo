HTSeqGenie: a software package to analyse high-throughput
sequencing experiments

Gregoire Pau, Cory Barr, Jens Reeder, Michael Lawrence
Jeremiah Degenhardt, Tom Wu, Melanie Huntley, Matt Brauer

November 1, 2018

Contents

1 Introduction

2 Example analysis of two RNA-Seq experiments of lung cell lines

2.1 Analysis on a genomic region centered on TP53 . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Analysis on the full human genome . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Analysis steps
3.1 General
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Preprocessing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 Alignment . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Count genomic features
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Coverage

4 Conﬁguration
4.1 General
4.2 Conﬁguration parameters

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Session Information

2

2
2
5

6
6
6
6
8
8

9
9
9

12

1

1 Introduction

The HTSeqGenie package is a robust and eﬃcient software to analyze high-throughput sequencing experi-
ments in a reproducible manner. It supports the RNA-Seq and Exome-Seq protocols and provides: quality
control reporting (using the ShortRead package), detection of adapter contamination, read alignment versus
a reference genome (using the gmapR package), counting reads in genomic regions (using the GenomicRanges
package), and read-depth coverage computation.

2 Example analysis of two RNA-Seq experiments of lung cell lines

2.1 Analysis on a genomic region centered on TP53

In this section, we are analysing two RNA-Seq experiments of human lung cell lines (H1993 and H2073) on a
2 Mb genomic region centered on the TP53 gene. This region, not the full human genome, has been chosen
to provide a vignette that can be run in a reasonable amount of time.

We ﬁrst load the package HTSeqGenie. We then load the package LungCancerLines to get the FASTQ
ﬁles of the lung cancer cell lines we are going to analyze. These ﬁles only cover the TP53 genomic region
and have been subsampled to 2500 reads, due to vignette time constraints.

> library("HTSeqGenie")
> library("LungCancerLines")

To analyze the reads, the package needs a GmapGenome object, which contains the information needed to
align the reads to a reference genome. The package also needs a genomic features object, which is a named
list of GRanges objects containing the genomic features (gene, exon, transcript...) of the corresponding
genome. For convenience, this vignette provides the function TP53Genome, generating a 2 Mb subset of the
UCSC hg19 human genome, centered on the gene TP53, and the TP53GenomicFeatures, producing a RData
ﬁle containing the associated genomic features. The next section explains how to build custom GmapGenome
and genomic features objects.

> tp53Genome <- TP53Genome()
> tp53GenomicFeatures <- TP53GenomicFeatures()

The samples are analysed with a common set of conﬁguration parameters, speciﬁc to RNA-Seq paired-end

experiments. Details about these parameters are provided in the Conﬁguration section.

> rtp53 <- list(
+
+
+
+
+
+
+
+

## aligner
path.gsnap_genomes=path(directory(tp53Genome)),
alignReads.genome=genome(tp53Genome),

## gene model
path.genomic_features=dirname(tp53GenomicFeatures),
countGenomicFeatures.gfeatures=basename(tp53GenomicFeatures)
)

The function runPipeline runs the full analysis pipeline, using a list of conﬁguration parameters. The
following commands analyse the H1993 and H2073 samples. The function returns the path to a directory
that contains the full analysis: bams, QC reports and a results directory which include coverage and count
data.

2

rtp53,

> H1993dir <- do.call(runPipeline,
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
> H2073dir <- do.call(runPipeline,
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

rtp53,

c(## RNASeq TP53genome parameters

## input
input_file=LungCancerFastqFiles()[["H1993.first"]],
input_file2=LungCancerFastqFiles()[["H1993.last"]],
paired_ends=TRUE,
quality_encoding="illumina1.8",

## output
save_dir="H1993",
prepend_str="H1993",
alignReads.sam_id="H1993",
overwrite_save_dir="erase"
))

c(## RNASeq TP53genome parameters

## input
input_file=LungCancerFastqFiles()[["H2073.first"]],
input_file2=LungCancerFastqFiles()[["H2073.last"]],
paired_ends=TRUE,
quality_encoding="illumina1.8",

## output
save_dir="H2073",
prepend_str="H2073",
alignReads.sam_id="H2073",
overwrite_save_dir="erase"
))

Several quality control reports (short reads, alignment, counting) have been generated in the report/
directories of the paths pointed by H1993dir and H2073dir. The following example uses the function
getTabDataFromFile to get the read counts per gene in both cell lines. Further analysis such as diﬀerential
expression using replicates can be performed using the package DESeq.

> library("org.Hs.eg.db")
> gc1 <- getTabDataFromFile(H1993dir, "counts_gene")
> gc2 <- getTabDataFromFile(H2073dir, "counts_gene")
> entrez <- as.character(gc1$name)
> hgnc <- unlist(as.list(org.Hs.egSYMBOL)[entrez])
> hgnc <- hgnc[entrez]
> data.frame(entrez=entrez, hgnc=hgnc, H1993.count=gc1$count, H2073.count=gc2$count, row.names=NULL)

entrez
100128288
100422983
100500892
100506713
100506755

1
2
3
4
5

LOC100128288
MIR4314
<NA>
ALOX12-AS1
MIR497HG

hgnc H1993.count H2073.count
0
0
0
1
16

0
0
0
3
16

3

6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56

100529209 RNASEK-C17orf49
100529211 TMEM256-PLSCR3
SENP3-EIF4A1
100533955
MIR4521
100616406
CLEC10A
10462
CHD3
1107
SAT2
112483
GABARAP
11337
CHRNB1
1140
CNTROB
116840
RPL29P2
118432
CYB5D1
124637
KRBA2
124751
CLDN7
1366
DNAH2
146754
ODF4
146852
KCTD11
147040
SLC16A11
162515
FBXO39
162517
DLG4
1742
DVL2
1856
EFNB3
1949
EIF5A
1984
SLC16A13
201232
SPEM2
201243
FGF11
2256
ARHGEF15
22899
KDM6B
23135
CTDNEP1
23399
ELP5
23587
ALOX12
239
ALOX12B
242
ALOX12P2
245
ALOX15B
247
TMEM256
254863
BCL6B
255877
SENP3
26168
SNORA67
26781
RNF227
284023
LINC00324
284029
SLC13A5
284111
TMEM102
284114
GPS2
2874
RANGRF
29098
GUCY2D
3000
TMEM95
339168
ACADVL
37
SPEM1
374768
399512
SLC25A35
407977 TNFSF12-TNFSF13
ASGR1

432

72
33
479
0
0
112
12
56
2
27
0
17
2
30
2
0
3
0
0
4
28
4
288
5
0
7
0
8
71
23
0
0
2
0
17
1
47
2
5
0
1
2
52
16
0
0
149
0
19
22
0

42
37
471
0
0
132
6
41
0
7
0
25
3
89
3
0
7
0
0
1
25
0
300
4
0
0
0
17
50
23
2
0
1
0
26
2
79
1
0
1
0
4
43
5
0
0
148
0
5
3
0

4

0
0
79
0
13
18
39
160
0
1
15
14
0
11
47
50
1
141
0
0
13
1
0
0
0
0
14
69
19
15
32
0
8
8
67
0
4
21
1
0
23
0
33
51
92
1

57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102

433
442898
4628
482
51087
5187
5198
5430
54739
54785
55135
57048
574456
57555
57659
58485
59344
6154
643664
643904
6462
6517
652965
652966
6665
677763
6844
7157
79142
80169
81565
83659
84314
84316
84461
84667
8711
8741
8742
9196
9212
92162
9513
9526
968
9744

ASGR2
MIR324
MYH10
ATP1B2
YBX2
PER1
PFAS
POLR2A
XAF1
BORCS6
WRAP53
PLSCR3
MIR497
NLGN2
ZBTB4
TRAPPC1
ALOXE3
RPL26
SLC35G6
RNF222
SHBG
SLC2A4
SNORA48
SNORD10
SOX15
SCARNA21
VAMP2
TP53
PHF23
CTC1
NDEL1
TEKT1
TMEM107
NAA38
NEURL4
HES7
TNK1
TNFSF13
TNFSF12
KCNAB3
AURKB
TMEM88
FXR2
MPDU1
CD68
ACAP1

0
0
127
0
13
3
18
153
0
2
18
11
0
0
29
36
0
207
0
0
7
0
0
0
0
0
6
82
16
25
30
0
17
12
53
1
12
1
2
0
23
0
37
58
63
0

2.2 Analysis on the full human genome

This section will be completed later.

5

3 Analysis steps

3.1 General

The pipeline consists in a set of high-level modules that are conﬁgured with a conﬁguration ﬁle. See the
Conﬁguration section for a list of all parameters.

The modules are:

(cid:136) preprocessing (preprocessReads)

(cid:136) read alignment (alignReads)

(cid:136) read counting (countGenomicFeatures)

(cid:136) computation of coverage (calculateCoverage)

The following diagram shows a high-level overview of the performed analysis steps:
The pipeline produces the directory logs/, which contains log ﬁles about the analysis:

(cid:136) logs/audit.txt: the environment used to run the analysis (pipeline version number, host, R session,

PATH, gsnap version, samtools version)

(cid:136) logs/conﬁg.txt: the expanded conﬁguration ﬁle used to run the analysis

(cid:136) logs/progress.log: the progress log

3.2 Preprocessing

The preprocessing module applies a sequence of optional steps before read alignment. These optional oper-
ations are:

(cid:136) read subsampling (randomly sample a subset of reads from input data)

(cid:136) trimming reads end to a ﬁxed size

(cid:136) ﬁltering reads based on nucleotide qualities

(cid:136) detection of (but not ﬁlter) adapter-contaminated reads

(cid:136) creation of ShortRead reports (on a random subset of reads)

Output

(cid:136) bams/processed.aligner input.fastq: processed FASTQ ﬁle(s) given to the aligner

(cid:136) results/adapter contaminated.RData: RData ﬁles containing the names of the detected adapter-contaminated

reads

(cid:136) results/summary preprocess.tab: a tab-separated ﬁle containing a summary of the preprocessing step

(cid:136) reports/shortReadReport: HTML ShortRead quality reports

3.3 Alignment

The alignment module uses the gsnap aligner to align reads, and creates the ﬁle analyzed.bam, containing
reads that are analyzed by the downstream modules. This ﬁle currently contains all uniquely mapping reads
(i.e. this is the concatenation of the *uniq.bam ﬁles).

6

Output

(cid:136) bams/*.bam: output aligned bam ﬁles

(cid:136) bams/*.bai: corresponding bam indexes

(cid:136) results/summary alignment.tab: a tab-separated ﬁle containing summary alignment information

(cid:136) report/reportAlignment.html: an HTML summary report about alignment

7

Junction read analysisCoverage analysisInsert length analysisSNV analysisGenomic Feature CountingAlignment phasebams/*analyzed.bambams/*.baiConvert to bam, sort and index, extract analyzed readsAlign readsbams/*.samgenerate preprocess and alignment report reports/reportAlignment.htmlPreprocessingAdapter contamination ﬁltergenerate ShortRead QA reportreports/shortReadReport_[1|2]results/*adapter_contaminated_[12].RDataRead FASTQ(optionally subsample)Quality ﬁlterTrim readsrRNA contamination ﬁlterinput_ﬁles_12.fastqbams/processed_aligner_input_12.fastqWrite FASTQCall SNVresults/variants_granges.RDataresults/ﬁltered_variants_granges.RDataresults/ﬁltered_variants.vcfgenerate variant calling report reports/reportVariants.htmlPlot histogram of insert lengthsreports/images/insert_length.pdfExtract junction endsresults/junction_end.RDataConsolidate pair readsCount genomic features(Exons, Genes, ncRNA, etc) Compute RPKMGenome and TranscriptDbresults/summary_counts.tabresults/counts.[FeatureName].tabgenerate feature counting report reports/reportFeatureCounts.htmlCalculate coverageresults/coverage.bwresults/coverage.RData3.4 Count genomic features

This module counts how many reads overlaps with the genomic intervals deﬁned in RData ﬁle pointed by
the ”countGenomicFeatures.gfeatures” parameter. On each interval, RPKM is computed using: (1e9*count)
/ (nbreads * width), where count is the number of reads overlapping with the interval, nbreads is the total
number of reads being analysed and width is the width of the interval.

The genomic features are deﬁned as:
(cid:136) A gene region is an interval (i.e. connected) and includes introns, 5’ and 3’ UTRs.

(cid:136) A gene exonic region is an interval union of all exons of a particular gene. It includes 5’ and 3’ UTRs,

but not introns.

(cid:136) A gene coding region is a gene exonic region without the 5’ and 3’ UTRs.

(cid:136) A transcript is an interval union of the exons of a particular transcript. It includes 5’ and 3’ UTRs,

but not introns.

(cid:136) Non-overlapping exonic regions (DEXSeq) are exons that have been split to remove overlapping regions.

Output

(cid:136) results/counts feature type.tab: a tab-separated ﬁle containing counts, widths and RPKMs

(cid:136) results/summary counts.tab: a tab-separated ﬁle containing summary count information

(cid:136) report/reportFeatureCounts.html: a HTML summary report about count genomic features

3.5 Coverage

This module computes coverage (read-depth) data.

8

Output

(cid:136) results/coverage.RData: a RData ﬁle containing coverage data

(cid:136) results/coverage.bw: bigwig ﬁle for IGB

4 Conﬁguration

4.1 General

Conﬁguration ﬁles are written in a DCF format, a sequence of lines containing ”<parameter>:<value>”. The
format supports comments starting with a sharp (’#’) sign and is whitespace tolerant. The HTSeqGenie
pipeline uses a templated conﬁguration framework where conﬁguration ﬁles can inherit parameters from other
conﬁguration ﬁles, through the parameter ”template conﬁg”. Parameters deﬁned after ”template conﬁg”
override parameters from the inherited templates.

Default parameters depend on the conﬁguration templates.

4.2 Conﬁguration parameters

Conﬁguration ﬁles ultimately derive from the default-conﬁg.txt conﬁguration ﬁle, which enumerates all avail-
able parameters. The following sections enumerate all available conﬁguration parameters.

Template

(cid:136) template conﬁg: An optional ﬁle name containing a template conﬁguration ﬁle. To locate it, the
software ﬁrst looks in the directory deﬁned by the environment variable HTSEQGENIE CONFIG and,
if not found, in the installed package HTSeqGenie. No default value.

Input

(cid:136) input ﬁle: The path of a FASTQ or gzipped FASTQ ﬁle containing the input reads. No default value.

(cid:136) input ﬁle2: An optional path of a FASTQ or gzipped FASTQ ﬁle containing the input paired reads in
paired-end sequencing. If present, the parameter paired ends must be set to TRUE. No default value.

(cid:136) paired ends: A logical indicating whether the reads are coming from paired-end sequencing. Default

is TRUE.

(cid:136) quality encoding: An optional string indicating which quality encoding is used. Possible values are
”sanger”, ”solexa”, ”illumina1.3”, ”illumina1.5” and ”illumina1.8”. If absent, a non-robust strategy is
tried to guess it. No default value.

(cid:136) subsample nbreads: An optional integer. If present, the preprocess module randomly subsamples the
indicated number of reads from the input ﬁles before analysis. This feature is disabled by default.

(cid:136) chunk size: An integer indicating how many reads are present in a chunk. This parameter should not

be changed. Default is 1e6.

(cid:136) max nbchunks: An optional integer. If present, it sets the maximum number of chunks to be processed.

This parameter is mostly present for debug purposes. This feature is disabled by default.

9

Output

(cid:136) save dir: A directory path indicating where the output results should be stored. No default value.

(cid:136) overwrite save dir: A string indicating how to overwrite/save data in the save dir directory. Possible
values are ”never”, ”erase” and ”overwrite”. If ”never”, the pipeline will stop if the indicated save dir is
present. If ”erase”, the save dir directory is removed before starting the analysis. Default is ”never”.

(cid:136) prepend str: A string that will be preprended to output ﬁlenames. No default value.

(cid:136) remove processedfastq: A logical indicating whether the preprocessed FASTQ ﬁles before alignment

should be removed. Default is TRUE.

(cid:136) remove chunkdir: A logical indicating whether the chunks/ subdirectory should be removed. Default

is TRUE.

(cid:136) tmp dir: A temporary directory where intermediate ﬁles will be written to. If set, this should point to a

non-replicated, non-snapshoted directory such as /gne/research/data/bioinfo/ngs analysis/CGP 3.0/cgptmp.
If not set, temporary ﬁles will be written into the save dir.

System

(cid:136) num cores: An integer indicating how many cores should be used on this machine. This value can be

overriden by the ngs pipeline calling script. Default value is 1.

Path

(cid:136) path.genomic features: A path to the directory that contains the genomic features RData ﬁles used

for counting. No default.

(cid:136) path.gsnap genomes: A path to the directory that contains Gsnap’s genomic indices. No default.

Debug

(cid:136) debug.level: A string indicating which maximal level of debug should be used in the log ﬁle. Possible

values are ”ERROR”, ”WARN”, ”INFO” and ”DEBUG”. Default is ”DEBUG”.

(cid:136) debug.tracemem: A logical indicating whether periodic memory information should be included in the

log ﬁle. Default is TRUE.

Trim reads

(cid:136) trimReads.do: A logical indicating whether the reads should be end-trimmed. Default is FALSE.

(cid:136) trimReads.length: An integer indicating to what size (in nucleotides) the reads should be trimmed to.

No default value.

Filter quality

(cid:136) ﬁlterQuality.do: A logical indicating whether the reads should be ﬁltered out based on read nucleotide
qualities. A read is kept if the fraction ”ﬁlterQuality.minFrac” of nucleotides have a quality higher than
”ﬁlterQuality.minQuality”. Default is TRUE.

(cid:136) ﬁlterQuality.minQuality: An integer. See ﬁlterQuality.do. Default is 23.

(cid:136) ﬁlterQuality.minFrac: A numeric ranging from 0.0 to 1.0. See ﬁlterQuality.do. Default is 0.7.

10

Detect adapter contamination

(cid:136) detectAdapterContam.do: A logical indicating whether reads that look contaminated by adapter se-

quences should be reported (but NOT ﬁltered). Default is TRUE.

(cid:136) detectAdapterContam.force paired end adapter: A logical indicating whether paired end adapter chem-

istry was used for single-end sequencing. Default is FALSE.

Detect ribosomal RNA

(cid:136) detectRRNA.do: A logical indicating whether ribosomal RNAs should be ﬁltered out. Default is

TRUE.

(cid:136) detectRRNA.rrna genome: A string indicating which gsnap genome index to use (-d ﬂag) to detect

ribosomal RNAs. No default value.

ShortRead report

(cid:136) shortReadReport.do: A logical indicating whether a ShortRead report should be generated from the

preprocessed reads. Default is TRUE.

(cid:136) shortReadReport.subsample nbreads: An optional integer indicating how many reads should be sub-
sampled from the preprocessed reads for generating the report. No value indicates to take all of them
(can be memory and time consuming). Default is 20e6.

Aligner

(cid:136) alignReads.genome: A string indicating which gsnap genome index to use (-d ﬂag). No default value.

(cid:136) alignReads.max mismatches: An optional integer indicating how many maximal mismatches gsnap

should use (-m ﬂag). If absent, gsnap uses an automatic value. No default value.

(cid:136) alignReads.sam id: A string (–read-group-id ﬂag). No default value.

(cid:136) alignReads.snp index: An optional string containing gsnap SNP database index (-v ﬂag). No default

value.

(cid:136) alignReads.splice index: An optional string containing gsnap splice index (-s ﬂag). No default value.

(cid:136) alignReads.static parameters: An optional string containing extra gsnap parameters. No default value.

(cid:136) alignReads.nbthreads perchunk: An optional integer indicating how many threads should be used to
process one chunk (-t ﬂag). If unspeciﬁed, the value is set to min(num cores, 4). This parameter is
mostly given for debug purposes. No default value.

Count genomic features

(cid:136) countGenomicFeatures.do: A logical indicating whether counts per genomic feature should be com-

puted. Default is TRUE.

(cid:136) countGenomicFeatures.gfeatures: A ﬁlename containing the RData ﬁle used by the counting features
module. The full path is ”path.genomic features”/ ”countGenomicFeatures.gfeatures”. No default
value.

11

Variants

(cid:136) analyzeVariants.do: A logical indicating whether variant calling should be performed. Default is TRUE.

(cid:136) analyzeVariants.use read length: FALSE

(cid:136) analyzeVariants.with qual: A logical indicating whether variant calling should take mapping quality

into account. Default is TRUE.

(cid:136) analyzeVariants.bqual: Default is 23.

(cid:136) analyzeVariants.bin fraction: Default is 0.1.

Coverage

(cid:136) coverage.extendReads: A logical whether reads should be extended in the coverage vector. Default is

FALSE

(cid:136) coverage.fragmentLength: Amount by which single ended reads should be extended. Usually deﬁned

by the fragment length. No default value.

5 Session Information

> toLatex(sessionInfo())

(cid:136) R version 3.5.1 Patched (2018-07-12 r74967), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C,
LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.5 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4, utils

(cid:136) Other packages: AnnotationDbi 1.44.0, Biobase 2.42.0, BiocGenerics 0.28.0, BiocParallel 1.16.0,

Biostrings 2.50.0, DelayedArray 0.8.0, GenomeInfoDb 1.18.0, GenomicAlignments 1.18.0,
GenomicRanges 1.34.0, HTSeqGenie 4.12.0, IRanges 2.16.0, LungCancerLines 0.20.0,
Rsamtools 1.34.0, S4Vectors 0.20.0, ShortRead 1.40.0, SummarizedExperiment 1.12.0,
VariantAnnotation 1.28.1, XVector 0.22.0, gmapR 1.24.0, matrixStats 0.54.0, org.Hs.eg.db 3.7.0

(cid:136) Loaded via a namespace (and not attached): BSgenome 1.50.0, Cairo 1.5-9, DBI 1.0.0,

GenomeInfoDbData 1.2.0, GenomicFeatures 1.34.0, Matrix 1.2-15, R6 2.3.0, RColorBrewer 1.1-2,
RCurl 1.95-4.11, RSQLite 2.1.1, Rcpp 0.12.19, VariantTools 1.24.0, XML 3.98-1.16, assertthat 0.2.0,
biomaRt 2.38.0, bit 1.1-14, bit64 0.9-7, bitops 1.0-6, blob 1.1.1, chipseq 1.32.0, compiler 3.5.1,
crayon 1.3.4, digest 0.6.18, grid 3.5.1, hms 0.4.2, httr 1.3.1, hwriter 1.3.2, lattice 0.20-35,
latticeExtra 0.6-28, magrittr 1.5, memoise 1.1.0, pkgconﬁg 2.0.2, prettyunits 1.0.2, progress 1.2.0,
rlang 0.3.0.1, rtracklayer 1.42.0, stringi 1.2.4, stringr 1.3.1, tools 3.5.1, zlibbioc 1.28.0

12

