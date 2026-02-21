The REDseq user’s guide

Lihua Julie Zhu∗

October 30, 2025

Contents

1 Introduction

2 Examples of using REDseq

. . . . . . . . . . . . . . . . . . . . .
2.1 Task 1: Build a RE map for a genome
2.2 Task 2: Assign mapped sequence tags to RE site . . . . . . . . . . . . . . . .
2.3 Task 3: Visualize the distribution of cut frequency in selected genomic regions
. .
and the distance distribution of sequence tags to corresponding RE sites
2.4 Task 4: Generating count table for identifying statistically significant RE sites
2.5 Task 5: Identifying differential cut RE sites for experiment with one experi-
ment condition . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.6 Task 6: Identifying differential cut RE sites for early stage experiment without
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

replicates

3 References

4 Session Info

1

Introduction

1

2
2
3

4
7

7

7

8

8

Restriction Enzyme digestion (RED) followed by high throughput sequencing (REDseq)
enables genome wide differentiation of highly accessible regions and inaccessible regions.
Comparing the profiles of restriction enzyme (RE) digestion among different cell types, de-
velopmental stages, disease stages, or different tissues facilitates deciphering of complex
regulation network of cell differentiation, developmental control, and disease etiology and
progression. We have developed a Bioconductor package called REDSeq to address the fun-
damental upstream analysis tasks of REDseq dataset. We have implemented functions for
building genomic map of restriction enzyme sites (buildREmap), assigning sequencing tags to

∗julie.zhu@umassmed.edu

1

RE sites (assignSeq2REsite), visualizing genome-wide distribution of differentially cut re-
gions (distanceHistSeq2RE) and the distance distribution of sequence tags to corresponding
RE sites (distanceHistSeq2RE), generating count table for identifying statistically signif-
icant RE sites (summarizeByRE). We have leveraged BSgenome on implementing function
buildREmap for building genome-wide RE maps. The input data for assignSeq2REsite are
represented as GRanges, for efficiently associating sequences with RE sites. It first identifies
RE sites that have mapped sequence tags around the cut position taking consideration of
user-defined offset, sequence length and strand in the aligned sequences. The user-defined
offset guards against imperfect sticky end repair and primer addition process. These RE
sites are used as seeds for assigning the remaining tags depending on which of five strategies
the users select for partitioning sequences associated with multiple RE sites, i.e., unique,
average, estimate, best and random. For experiment with at least two conditions with bi-
ological replicates, count summary generated from summarizeByRE can be easily used for
identifying differentially cut RE sites using either DESeq or edgeR. Differentially cut RE
sites can be annotated to the nearest gene using ChIPpeakAnno. In addition, for early stage
experiments without replicates, compareREDseq outputs differentially cut RE sites between
two experimental conditions using Fisher’s Exact Test. For experiment with one experi-
mental condition, binom.test.REDseq outputs differentially cut RE sites in the genome.
Multiplicity adjustment functions from multtest package were integrated in both functions.

2 Examples of using REDseq

2.1 Task 1: Build a RE map for a genome

Given a fasta/fastq file containing the restriction enzyme recognition site and a BSgenome
object, the function buildREmap builds a genome-wide RE map.

>
>
>
>

library(REDseq)
REpatternFilePath = system.file("extdata", "examplePattern.fa", package="REDseq")
library(BSgenome.Celegans.UCSC.ce2)
myMap = buildREmap( REpatternFilePath, BSgenomeName=Celegans, outfile="example.REmap")

>>> Finding all hits in sequences chrI ...
>>> DONE searching
>>> Finding all hits in sequences chrII ...
>>> DONE searching
>>> Finding all hits in sequences chrIII ...
>>> DONE searching
>>> Finding all hits in sequences chrIV ...
>>> DONE searching
>>> Finding all hits in sequences chrV ...
>>> DONE searching
>>> Finding all hits in sequences chrX ...
>>> DONE searching
>>> Finding all hits in sequences chrM ...
>>> DONE searching

2

2.2 Task 2: Assign mapped sequence tags to RE site

Given a mapped sequence tags as a GRanges and REmap as a Granges, assignSeq2REsite
function assigns mapped sequence tags to RE site depending on the strategy users select.
There are five strategies implemented, i.e., unique, average, estimate, best and random. For
details, type help(assignSeq2REsite) in a R session.

>
>
>
+
+

data(example.REDseq)
data(example.map)
r.unique = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1,
seq.length = 36, allowed.offset = 5, min.FragmentLength = 60,
max.FragmentLength = 300, partitionMultipleRE = "unique")

Thu Oct 30 02:00:29 2025 Validating input ...
Thu Oct 30 02:00:29 2025 Prepare map data ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Finished 1st round of aligning! Start the 2nd round of aligning ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Start filtering ...

>
+
+

r.best= assignSeq2REsite(example.REDseq, example.map,
cut.offset = 1, seq.length = 36, allowed.offset = 5,
min.FragmentLength = 60, max.FragmentLength = 300, partitionMultipleRE = "best")

Thu Oct 30 02:00:29 2025 Validating input ...
Thu Oct 30 02:00:29 2025 Prepare map data ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Finished 1st round of aligning! Start the 2nd round of aligning ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Start filtering ...
Thu Oct 30 02:00:29 2025 Partitioning reads over RE sites within 300 ...
Thu Oct 30 02:00:29 2025 get count for each RE ...

>
+
+

r.random = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1,
seq.length = 36, allowed.offset = 5, min.FragmentLength = 60,
max.FragmentLength = 300, partitionMultipleRE = "random")

Thu Oct 30 02:00:29 2025 Validating input ...
Thu Oct 30 02:00:29 2025 Prepare map data ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Finished 1st round of aligning! Start the 2nd round of aligning ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Start filtering ...
Thu Oct 30 02:00:29 2025 Partitioning reads over RE sites within 300 ...

>
+
+

r.average = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1,
seq.length = 36, allowed.offset = 5, min.FragmentLength = 60,
max.FragmentLength = 300, partitionMultipleRE = "average")

Thu Oct 30 02:00:29 2025 Validating input ...
Thu Oct 30 02:00:29 2025 Prepare map data ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Finished 1st round of aligning! Start the 2nd round of aligning ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Start filtering ...
Thu Oct 30 02:00:29 2025 Partitioning reads over RE sites within 300 ...

>
+
+

r.estimate = assignSeq2REsite(example.REDseq, example.map, cut.offset = 1,
seq.length = 36, allowed.offset = 5, min.FragmentLength = 60,
max.FragmentLength = 300, partitionMultipleRE = "estimate")

3

Thu Oct 30 02:00:29 2025 Validating input ...
Thu Oct 30 02:00:29 2025 Prepare map data ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Finished 1st round of aligning! Start the 2nd round of aligning ...
Thu Oct 30 02:00:29 2025 Align to chromosome 2 ...
Thu Oct 30 02:00:29 2025 Start filtering ...
Thu Oct 30 02:00:29 2025 Partitioning reads over RE sites within 300 ...
Thu Oct 30 02:00:29 2025 get count for each RE ...

>

head(r.estimate$passed.filter)

SEQid

REid Chr strand SEQstart SEQend REstart

REend
+ 3012091 3012126 3012090 3012094
+ 3012096 3012131 3012090 3012094
+ 3012300 3012335 3012299 3012303
+ 3018315 3018350 3018314 3018318
+ 3018315 3018350 3018314 3018318
+ 3018315 3018350 3018314 3018318

2 00000037 Sau96I.chr10.29
3 00000038 Sau96I.chr10.29
5 00000040 Sau96I.chr10.30
8 00000055 Sau96I.chr10.42
9 00000056 Sau96I.chr10.42
10 00000057 Sau96I.chr10.42

2
2
2
2
2
2

Distance Weight
1
1
1
6
1
1
1
1
1
1
1
1

2
3
5
8
9
10

The above examples are for single-end sequencing data. For paired-end sequencing data, please create inputS.RD and
inputE.RD from input.RD first with start(input.RD) and end(input.RD), where inputS.RD contains the start of the input.RD
and inputE.RD contains the end of the input.RD. Then call assignSeq2REsite twice with inputS.RD and inputE.RD respectively.
Please set min.FragmentLength = 0, max.FragmentLength = 1, seq.length = 1 with both calls.

2.3 Task 3: Visualize the distribution of cut frequency in selected
genomic regions and the distance distribution of sequence tags
to corresponding RE sites

> data(example.assignedREDseq)

4

> plotCutDistribution(example.assignedREDseq,example.map, chr="2",
+ xlim =c(3012000, 3020000))

Figure 1: Plot to show the distribution of cut frequency in the selected genomic-regions with
the function plotCutDistribution. The red triangle is the expected cut frequency for each
RE site.

5

301200030140003016000301800030200002468RE cut frequency distributionChromosome Location (bp)Frequency> distanceHistSeq2RE(example.assignedREDseq,ylim=c(0,25))

Figure 2: Plot to show the distribution of distance of sequence tags to associated RE sites
with the function distanceHistSeq2RE.

6

histogram of distance to assigned RE siteDistance to assigned RE siteFrequency−200−10001002000510152.4 Task 4: Generating count table for identifying statistically sig-

nificant RE sites

Once you have obtained the assigned RE sites, you can use the function summarizeByRE to
obtain a count table for identifying statistically significant RE sites using DEseq or edgeR.

> REsummary

=summarizeByRE(example.assignedREDseq,by="Weight")

2.5 Task 5: Identifying differential cut RE sites for experiment with

one experiment condition

9 Sau96I.chr10.42
6 Sau96I.chr10.43
4 Sau96I.chr10.29
3 Sau96I.chr10.50
3 Sau96I.chr10.45
2 Sau96I.chr10.30
2 Sau96I.chr10.51
1 Sau96I.chr10.40
1 Sau96I.chr10.49
1 Sau96I.chr10.47

REid cut.frequency
0.28125
0.18750
0.12500
0.09375
0.09375
0.06250
0.06250
0.03125
0.03125
0.03125

> binom.test.REDseq(REsummary)

p.value total.weight.count

1 2.804822e-47
2 9.061718e-31
3 3.595919e-20
4 4.959892e-15
5 4.959892e-15
6 4.959901e-10
7 4.959901e-10
8 3.199950e-05
9 3.199950e-05
10 3.199950e-05

BH.adjusted.p.value
2.804822e-46
4.530859e-30
1.198640e-19
9.919784e-15
9.919784e-15
7.085573e-10
7.085573e-10
3.199950e-05
3.199950e-05
3.199950e-05

1
2
3
4
5
6
7
8
9
10

2.6 Task 6: Identifying differential cut RE sites for early stage ex-

periment without replicates

> x= cbind(c("RE1", "RE2", "RE3", "RE4"), c(10,1,100, 0),c(5,5,50, 40))
> colnames(x) = c("REid", "control", "treated")
> compareREDseq(x)

1 6.233642e-16
2 1.159388e-10
3 1.035503e-01
4 2.943364e-01

p.value control.count treated.count REid control.total treated.total
100
40
RE4
100
50 RE3
100
5 RE2
100
RE1
5

111
111
111
111

0
100
1
10

odds.ratio BH.adjusted.p.value
2.493457e-15
2.318777e-10
1.380671e-01
2.943364e-01

1
Inf
2 0.1112945
3 5.7478720
4 0.5331227

7

3 References

1. Roberts, R.J., Restriction endonucleases. CRC Crit Rev Biochem, 1976. 4(2): p.

123-64.

2. Kessler, C. and V. Manta, Specificity of restriction endonucleases and DNA modifica-

tion methyltransferases a review (Edition 3). Gene, 1990. 92(1-2): p. 1-248.

3. Pingoud, A., J. Alves, and R. Geiger, Restriction enzymes. Methods Mol Biol, 1993.

16: p. 107-200.

4. bibitemAnders10 Anders, S. and W. Huber, Differential expression analysis for se-

quence count data. Genome Biol, 2010. 11(10): p. R106.

5. Robinson, M.D., D.J. McCarthy, and G.K. Smyth, edgeR: a Bioconductor package for
differential expression analysis of digital gene expression data. Bioinformatics, 2010.
26(1): p. 139-40.

6. Zhu, L.J., et al., ChIPpeakAnno: a Bioconductor package to annotate ChIP-seq and

ChIP-chip data. BMC Bioinformatics, 2010. 11: p. 237.

7. Pages, H., BSgenome package. http://bioconductor.org/packages/2.8/bioc/vignettes/

BSgenome/inst/doc/GenomeSearching.pdf

8. Zhu, L.J., et al., REDseq: A Bioconductor package for Analyzing High Throughput

Sequencing Data from Restriction Enzyme Digestion. (In preparation)

4 Session Info

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

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

8

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[8] base

stats

other attached packages:

graphics

grDevices utils

datasets

methods

[1] REDseq_1.56.0
[3] multtest_2.66.0
[5] BSgenome.Celegans.UCSC.ce2_1.4.0 BSgenome_1.78.0
[7] rtracklayer_1.70.0
[9] Biostrings_2.78.0

ChIPpeakAnno_3.44.0
Biobase_2.70.0

[11] GenomicRanges_1.62.0
[13] IRanges_2.44.0
[15] BiocGenerics_0.56.0

BiocIO_1.20.0
XVector_0.50.0
Seqinfo_1.0.0
S4Vectors_0.48.0
generics_0.1.4

loaded via a namespace (and not attached):

[1] DBI_1.2.3
[3] RBGL_1.86.0
[5] formatR_1.14
[7] rlang_1.1.6
[9] matrixStats_1.5.0

bitops_1.0-9
httr2_1.2.1
biomaRt_2.66.0
magrittr_2.0.4
compiler_4.5.1
GenomicFeatures_1.62.0
vctrs_0.6.5
ProtGenerics_1.42.0
pkgconfig_2.0.3
fastmap_1.2.0
Rsamtools_2.26.0
UCSC.utils_1.6.0
bit_4.6.0
cigarillo_1.0.0
jsonlite_2.0.0
blob_1.2.4
BiocParallel_1.44.0
prettyunits_1.2.0
stringi_1.8.7
Rcpp_1.1.0

[11] RSQLite_2.4.3
[13] png_0.1-8
[15] stringr_1.5.2
[17] pwalign_1.6.0
[19] crayon_1.5.3
[21] dbplyr_2.5.1
[23] graph_1.88.0
[25] purrr_1.1.0
[27] cachem_1.1.0
[29] GenomeInfoDb_1.46.0
[31] progress_1.2.3
[33] DelayedArray_0.36.0
[35] parallel_4.5.1
[37] R6_2.6.1
[39] RColorBrewer_1.1-3
[41] SummarizedExperiment_1.40.0 VennDiagram_1.7.3
[43] Matrix_1.7-4

splines_4.5.1

9

[45] tidyselect_1.2.1
[47] abind_1.4-8
[49] codetools_0.2-20
[51] lattice_0.22-7
[53] regioneR_1.42.0
[55] KEGGREST_1.50.0
[57] lambda.r_1.2.4
[59] futile.logger_1.4.3
[61] universalmotif_1.28.0
[63] filelock_1.0.3
[65] RCurl_1.98-1.17
[67] hms_1.1.4
[69] scales_1.4.0
[71] lazyeval_0.2.2
[73] data.table_1.17.8
[75] XML_3.99-0.19
[77] tidyr_1.3.1
[79] restfulr_0.0.16
[81] rappdirs_0.3.3
[83] S4Arrays_1.10.0
[85] AnnotationFilter_1.34.0
[87] SparseArray_1.10.0
[89] farver_2.1.2
[91] lifecycle_1.0.4
[93] bit64_4.6.0-1

dichromat_2.0-0.1
yaml_2.3.10
curl_7.0.0
tibble_3.3.0
InteractionSet_1.38.0
S7_0.2.0
survival_3.8-3
BiocFileCache_3.0.0
pillar_1.11.1
MatrixGenerics_1.22.0
ensembldb_2.34.0
ggplot2_4.0.0
glue_1.8.0
tools_4.5.1
GenomicAlignments_1.46.0
grid_4.5.1
AnnotationDbi_1.72.0
cli_3.6.5
futile.options_1.0.1
dplyr_1.1.4
gtable_0.3.6
rjson_0.2.23
memoise_2.0.1
httr_1.4.7
MASS_7.3-65

10

