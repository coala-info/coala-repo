Introduction to proBAMr

Xiaojing Wang

October 30, 2025

Contents

1 Why proBAM file

2 What is proBAM file

3 How to build proBAM file

.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1 Preparing annotation files .
3.2 Preparing PSMs table .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
3.3 Generate SAM file using PSMtab2SAM . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Convert SAM file to BAM and index . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.5 Visulize proteomics data in IGV . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

.
.

.
.

.

.

4 Session Information

1 Why proBAM file

1

2

3
3
4
5
6
7

7

Recent advances of sequencing technologies have reformed our conception of genomic data analysis, storage
and interpretation, instigating more research interest in exploring human proteome at a parallel scale. Shot-
gun proteomics holds this promise by surveying proteome both qualitatively and quantitatively. Over the
last years large amount of proteomics data has been accumulated, an emerging demand is to combine these
efforts to catalogue the wide dynamic range of protein expression and complexity of alternative isoforms.
However, this task is daunting due to the fact that different studies use varying databases, search engines and
assembly tools. Such a challenge calls for an efficient approach of integrating data from different proteomics
studies and even with genomic data.

Here we provide an R package, proBAMr, that maps identified PSMs to the genome in BAM format,
a binary format for efficient data storage and fast access in genomic research field. This method differs
from other approaches because of its ability of building connections between peptide and genomic location
and simultaneously maintaining spectra count information. PSMs are aligned under the same coordination
framework regardless of the annotation systems (e.g. RefSeq, ENSEMBL) of the input proteomics data,
which enables flexible protein assembly switch between different annotation or at different level (gene or
protein). When genomic/transcriptomic information of the same individual is available, this approach allows
the co-analysis with -omics data together.

1

2 What is proBAM file

Table 1: Mandatory field definition of proBAM file and compare to original BAM format for genomic
studies.

To take full advantage of tools developed for processing BAM files in genomics studies, we designed
proBAM by incorporating features from the BAM file format and other features specifically for proteomics.
Like BAM, it contains a header section and an alignment section. A full description of the BAM for-
mat is available at http://samtools.github.io/hts-specs/SAMv1.pdf. A PSGM (peptide-
spectrum-genomic location-match) is the basic unit in proBAM and is similar to a read in NGS data. In Table
1, we compared the BAM and proBAM description of each mandatory column in the alignment section.

Table 2: FLAG description in proBAM file.

proBAM allows for 5 FLAG values due to the less complicated requirements by shotgun proteomics

2

data (Table 2). For the same reason, the CIGAR tag in proBAM file only supports ’M’ for match/mismatch
and ’N’ for skipped bases on the reference.

The optional filed keep extra information from proteomics experiment platform or search engines. The
definition and value format of each optional column is descripted in Table 3. It is important to note that this
table is extendable depending on continuous development and input from the community.

Table 3: Optional field definition of proBAM file.

The optional field follow the rule TAG:TYPE:VALUE defined by BAM file. There are three type of VALUE format:
i, Singed 32-bit integer; Z, Printable string; f, Single-precision floating number.

3 How to build proBAM file

3.1 Preparing annotation files

To map proteomics data to the genome, numerous pieces of genome annotation information are needed,
such as genome elements region boundary, protein coding sequence and protein sequence et al.
It is
possible to manually download these data from different public resources (e.g. NCBI, UCSC and EN-
SEMBL) and then parse them to an appropriate format. To make this process more efficient and au-
tonomous, we provide functions to prepare the gene/transcript annotation files from UCSC, ENSEMBL and
GENCODE. The PrepareAnnotationRefseq and PrepareAnnotationEnsembl were included
in another R package customProDB http://bioconductor.org/packages/3.0/bioc/html/
customProDB.html. Here, we provide the function PrepareAnnotationGENCODE to prepare the
annotation from GENCODE. This function requires users to download GTF file, coding sequence and
protein sequence FASTA files from GENCODE ftp ftp://ftp.sanger.ac.uk/pub/gencode/
Gencode_human/. Users should use the same version of annotations through the same project annal-
ysis. All the annotations are saved to a specified directory for latter use.

> library(proBAMr)

3

> gtfFile <- system.file("extdata", "test.gtf", package="proBAMr")
> CDSfasta <- system.file("extdata", "coding_seq.fasta", package="proBAMr")
> pepfasta <- system.file("extdata", "pro_seq.fasta", package="proBAMr")
> annotation_path <- tempdir()
> PrepareAnnotationGENCODE(gtfFile, CDSfasta, pepfasta,
+
+

annotation_path, dbsnp=NULL,
splice_matrix=FALSE, COSMIC=FALSE)

3.2 Preparing PSMs table

After preparing all the annotation files, the R package pepXMLTab is used to extract confident PSMs and
related information from pepXML files. Other tools are also applicable at this step, as long as it generates
similar tabular files, as shown below.

> passedPSM <- read.table(system.file("extdata", "passedPSM.tab",
+
> passedPSM[1:3, ]

package="proBAMr"), sep='\t', header=TRUE)

spectrum
1 00463_H12_P003361_B00L_A00_R1.9484.9484.2
2 00463_H12_P003361_B00L_A00_R1.9501.9501.2
3 00463_H12_P003361_B00L_A00_R1.9526.9526.2

1 controllerType=0 controllerNumber=1 scan=9484
2 controllerType=0 controllerNumber=1 scan=9501
3 controllerType=0 controllerNumber=1 scan=9526

spectrumNativeID start_scan end_scan
9484
9501
9526

9484
9501
9526

precursor_neutral_mass assumed_charge index retention_time_sec
5941.112
5951.951
5963.760

1945.011
1945.019
1945.016

1604
1614
1631

2
2
2

hit_rank

1 VNPTVFFDIAVDGEPLGR
1 VNPTVFFDIAVDGEPLGR
1 VNPTVFFDIAVDGEPLGR

peptide peptide_prev_aa peptide_next_aa
V
V
V

M
M
M

1
2
3

1
2
3

1 ENST00000415933.1|ENSG00000196262.9|OTTHUMG00000023687.5|OTTHUMT00000341788.1|PPIA-007|PPIA|120
2 ENST00000415933.1|ENSG00000196262.9|OTTHUMG00000023687.5|OTTHUMT00000341788.1|PPIA-007|PPIA|120
3 ENST00000415933.1|ENSG00000196262.9|OTTHUMG00000023687.5|OTTHUMT00000341788.1|PPIA-007|PPIA|120

protein

1
2
3

1
2
3

num_tot_proteins calc_neutral_pep_mass

1944.995 -0.01667663
1944.995 -0.02461120
1944.995 -0.02192565
num_missed_cleavages num_matched_ions tot_num_ions

4
4
4

massdiff num_tol_term
2
2
2

0
0
0

21
26
22

4

mvh
31 46.20442
31 60.50605
31 52.51659

mzFidelity

1
81.97849 4.276119
2 104.25397 5.334539
86.18693 5.057394
3

xcorr modification NTT
1
1
1

<NA>
<NA>
<NA>

3.3 Generate SAM file using PSMtab2SAM

The function PSMtab2SAM first finds the peptide location in protein sequences, then maps the coding
sequence of the peptide back to the genome according to the annotation.

> load(system.file("extdata/GENCODE", "exon_anno.RData", package="proBAMr"))
> load(system.file("extdata/GENCODE", "proseq.RData", package="proBAMr"))
> load(system.file("extdata/GENCODE", "procodingseq.RData", package="proBAMr"))
> options(stringsAsFactors=FALSE)
> passedPSM <- read.table(system.file("extdata", "passedPSM.tab",
+
> SAM <- PSMtab2SAM(passedPSM, XScolumn='mvh', exon, proteinseq,
+
> write.table(SAM, file=paste(tempdir(), '/test.sam', sep=''),
+
> dim(SAM)

sep='\t', quote=FALSE, row.names=FALSE, col.names=FALSE)

package="proBAMr"), sep='\t', header=TRUE)

procodingseq)

[1] 40 21

> SAM[20:27, ]

QNAME X1

X4
X2
65622810 255
110 00463_H12_P003361_B00L_A00_R1.0.1.7307 16 chr11
44839340 255
chr7
113 00463_H12_P003361_B00L_A00_R1.0.1.7350 0
44836381 255
chr7
114 00463_H12_P003361_B00L_A00_R1.0.1.7441 0
chr7
115 00463_H12_P003361_B00L_A00_R1.0.1.7457 0
44836381 255
chr5 133509648 255
116 00463_H12_P003361_B00L_A00_R1.0.1.7898 16
chr5 133509648 255
117 00463_H12_P003361_B00L_A00_R1.0.1.7915 16
chr5 133509648 255
118 00463_H12_P003361_B00L_A00_R1.0.1.7933 16
26230237 255
chr1
119 00463_H12_P003361_B00L_A00_R1.0.1.7952 16

X3

42M *
110
113
45M *
114 12M2453N24M *
115 12M2453N24M *
51M *
116
51M *
117
51M *
118
39M *
119

X5 X6 X7 X8
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0

110

CAAAGGCTTGCCCTCCAGGGAGATGACGGCACTGCCCCCCAG

5

X9 X10

X11
* XA:Z:0

TCCATCTATGGGGAGAAATTTGAAGATGAGAACTTCATCCTAAAG
113
GTCTCCTTTGAGCTGTTTGCAGACAAGGTCCCAAAG
114
GTCTCCTTTGAGCTGTTTGCAGACAAGGTCCCAAAG
115
116 TTTGGCAATTTCCACATCAACTTCAAATATCTCTCCATCAGAACTCTGCAA
117 TTTGGCAATTTCCACATCAACTTCAAATATCTCTCCATCAGAACTCTGCAA
118 TTTGGCAATTTCCACATCAACTTCAAATATCTCTCCATCAGAACTCTGCAA
CCGAGGGCTGAGAATCAGCTCAAAAGCCTGGCCTGAGGC
119

* XA:Z:0
* XA:Z:0
* XA:Z:0
* XA:Z:0
* XA:Z:0
* XA:Z:0
* XA:Z:0
XS

XP

XC

XM
XL
NH
XP:Z:LGGSAVISLEGKPL XC:i:2 XS:f:30.6722 XM:Z:-
110 NH:i:1 XL:i:1
XP:Z:SIYGEKFEDENFILK XC:i:2 XS:f:22.4909 XM:Z:-
113 NH:i:1 XL:i:1
XP:Z:VSFELFADKVPK XC:i:2 XS:f:21.321 XM:Z:-
114 NH:i:1 XL:i:1
115 NH:i:1 XL:i:1
XP:Z:VSFELFADKVPK XC:i:2 XS:f:25.2581 XM:Z:-
116 NH:i:1 XL:i:1 XP:Z:LQSSDGEIFEVDVEIAK XC:i:2 XS:f:30.9829 XM:Z:-
117 NH:i:1 XL:i:1 XP:Z:LQSSDGEIFEVDVEIAK XC:i:2 XS:f:42.8235 XM:Z:-
118 NH:i:1 XL:i:1 XP:Z:LQSSDGEIFEVDVEIAK XC:i:2 XS:f:33.9951 XM:Z:-
XP:Z:ASGQAFELILSPR XC:i:2 XS:f:23.4655 XM:Z:-
119 NH:i:1 XL:i:1
XG
XT
XN
110 XN:i:0 XT:i:2 XG:Z:N
113 XN:i:1 XT:i:2 XG:Z:N
114 XN:i:1 XT:i:2 XG:Z:N
115 XN:i:1 XT:i:2 XG:Z:N
116 XN:i:0 XT:i:2 XG:Z:N
117 XN:i:0 XT:i:2 XG:Z:N
118 XN:i:0 XT:i:2 XG:Z:N
119 XN:i:0 XT:i:2 XG:Z:N

3.4 Convert SAM file to BAM and index

Add the header to the SAM file. Converted them to the binary BAM files using samtools http://
samtools.sourceforge.net/. Sort and index them for fast access.

The bullet list below summarizes the steps after the SAM file been generated.

> paste('cat header test.sam > test_header.sam')

[1] "cat header test.sam > test_header.sam"

> paste('samtools view -S -b test_header.sam > test_header.bam')

[1] "samtools view -S -b test_header.sam > test_header.bam"

> paste('samtools sort test_header.bam > test_header_sort')

[1] "samtools sort test_header.bam > test_header_sort"

> paste('samtools index test_header_sort')

[1] "samtools index test_header_sort"

6

3.5 Visulize proteomics data in IGV

The proBAM files can be visulized in IGV directly. Furthermore, users can co-visulize their proteomics data
with the paired genomics/transcriptomics data, as shown in Fig 1.

Figure 1: IGV snapshot of a homozygous mutation in gene ALDH1B1 in both proteomics and RNA-Seq
data (inside read box)

4 Session Information

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

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C

7

[9] LC_ADDRESS=C

LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[7] methods

stats
base

other attached packages:
[1] proBAMr_1.44.0
[4] IRanges_2.44.0
[7] generics_0.1.4

graphics

grDevices utils

datasets

AnnotationDbi_1.72.0 Biobase_2.70.0
S4Vectors_0.48.0

BiocGenerics_0.56.0

loaded via a namespace (and not attached):

[1] KEGGREST_1.50.0
[3] rjson_0.2.23
[5] lattice_0.22-7
[7] tools_4.5.1
[9] curl_7.0.0
[11] tibble_3.3.0
[13] blob_1.2.4
[15] Matrix_1.7-4
[17] cigarillo_1.0.0
[19] lifecycle_1.0.4
[21] compiler_4.5.1
[23] Biostrings_2.78.0
[25] Seqinfo_1.0.0
[27] GenomeInfoDb_1.46.0
[29] yaml_2.3.10
[31] crayon_1.5.3
[33] DelayedArray_0.36.0
[35] abind_1.4-8
[37] stringi_1.8.7
[39] restfulr_0.0.16
[41] fastmap_1.2.0
[43] cli_3.6.5
[45] magrittr_2.0.4
[47] GenomicFeatures_1.62.0
[49] prettyunits_1.2.0
[51] UCSC.utils_1.6.0
[53] bit64_4.6.0-1
[55] httr_1.4.7
[57] bit_4.6.0

SummarizedExperiment_1.40.0
httr2_1.2.1
vctrs_0.6.5
bitops_1.0-9
parallel_4.5.1
RSQLite_2.4.3
pkgconfig_2.0.3
dbplyr_2.5.1
GenomeInfoDbData_1.2.15
stringr_1.5.2
Rsamtools_2.26.0
progress_1.2.3
codetools_0.2-20
RCurl_1.98-1.17
pillar_1.11.1
BiocParallel_1.44.0
cachem_1.1.0
tidyselect_1.2.1
dplyr_1.1.4
biomaRt_2.66.0
grid_4.5.1
SparseArray_1.10.0
S4Arrays_1.10.0
XML_3.99-0.19
filelock_1.0.3
rappdirs_0.3.3
XVector_0.50.0
matrixStats_1.5.0
hms_1.1.4

8

[59] png_0.1-8
[61] GenomicRanges_1.62.0
[63] BiocFileCache_3.0.0
[65] txdbmaker_1.6.0
[67] glue_1.8.0
[69] jsonlite_2.0.0
[71] MatrixGenerics_1.22.0

memoise_2.0.1
BiocIO_1.20.0
rtracklayer_1.70.0
rlang_1.1.6
DBI_1.2.3
R6_2.6.1
GenomicAlignments_1.46.0

9

