An overview of the girafe package

J. Toedling, C. Ciaudo, O. Voinnet, E. Heard, E. Barillot

October 30, 2017

1

Introduction

The intent of package girafe is to facilitate the functional exploration of the alignments of
multiple reads1 from next-generation sequencing (NGS) data to a genome.

It extends the functionality of the Bioconductor (Gentleman et al., 2004) packages Short-
Read (Morgan et al., 2009) and genomeIntervals.

> library("girafe")
> library("RColorBrewer")

If you use girafe for analysing your data, please cite:

(cid:136) J Toedling, C Ciaudo, O Voinnet, E Heard and E Barillot (2010) girafe – an R/Bioconductor
package for functional exploration of aligned next-generation sequencing reads. Bioin-
formatics, 26(22):2902-3.

Getting help

If possible, please send questions about girafe to the Bioconductor mailing list.
See http://www.bioconductor.org/docs/mailList.html
Their archive of questions and responses may prove helpful, too.

2 Workﬂow

We present the functionality of the package girafe using example data that was downloaded
from the Gene Expression Omnibus (GEO) database (Edgar et al., 2002, GSE10364). The
example data are Solexa reads of 26 nt length derived from small RNA proﬁling of mouse
oocytes. The data has previously been described in Tam et al. (2008).

> exDir <- system.file("extdata", package="girafe")
> ### load object describing annotated mouse genome features:
> load(file.path(exDir, "mgi_gi.RData"))

1 The package has been developed for analysing single-end reads (fragment libraries) and does not support

mate-pair reads yet.

1

2.1 Adapter trimming

We load reads that include parts of the adapter sequence.

> ra23.wa <- readFastq(dirPath=exDir, pattern=
+

"aravinSRNA_23_plus_adapter_excerpt.fastq")

> show(ra23.wa)

class: ShortReadQ
length: 1000 reads; width: 26 cycles

To removing adapter sequences, we use the function trimAdapter, which relies on the pair-
wiseAlignment function from the Biostrings package. The adapter sequence was obtained
from the GEO page of the data.

> adapter <- "CTGTAGGCACCATCAAT"
> ra23.na <- trimAdapter(ra23.wa, adapter)
> show(ra23.na)

class: ShortReadQ
length: 1000 reads; width: 23 cycles

2.2 Importing aligned reads

The reads have been mapped to the mouse genome (assembly mm9 ) using the alignment
tool Bowtie alignment tool (Langmead et al., 2009).

The resulting tab-delimited map ﬁle can be read into an object of class AlignedRead using
the function readAligned. Both, this class and this function, are deﬁned in the Biocon-
ductor package ShortRead .

<- readAligned(dirPath=exDir, type="Bowtie",

pattern="aravinSRNA_23_no_adapter_excerpt_mm9_unmasked.bwtmap")

> exA
+
> show(exA)

class: AlignedRead
length: 1689 reads; width: 23 cycles
chromosome: chr14 chr17 ... chr3 chr14
position: 115443405 13011859 ... 68813840 62250772
strand: + + ... + -
alignQuality: NumericQuality
alignData varLabels: similar mismatch

The object of class AlignedRead can be converted into an object of class AlignedGenomeIn-
tervals, which is the main class of the girafe package.

2

> exAI <- as(exA, "AlignedGenomeIntervals")
> organism(exAI) <- "Mm"

For alignments in BAM format (Li et al., 2009), there is an alternative way of importing
the data. The function agiFromBam can be used to directly create AlignedGenomeIntervals
objects from indexed and sorted BAM ﬁles, making use of functionalities in the Rsamtools
package.

2.3 Exploring the aligned reads

> show(exAI)

1,286 genome intervals with 1,689 aligned reads on 22 chromosome(s).
Organism: Mm

Which chromosomes are the intervals located on?

> table(seqnames(exAI))

chr1 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr2 chr3
62

43

87

19

50

53

60

48

112

47
chr4 chr5 chr6 chr7 chr8 chr9 chrMT chrX chrY
2

132

74

69

57

59

65

52

82

51

57

5

A subset of the intervals on a speciﬁc chromosome can be obtained using subsetting via
’

’
.

[

> detail(exAI[seqnames(exAI)=="chrMT"])

start
964

end seq_name strand reads matches
1
986
2 11613 11635
3 11613 11635
4 11613 11635
5 11613 11635

chrMT
chrMT
chrMT
chrMT
chrMT

1
10
1
1
1

sequence
1 GTTTATGAGAGGAGATAAGTTGT
2 AAGAAAGATTGCAAGAACTGCTA
2 AAGCAAGATTGCAAGAACTGCTA
2 AAGAACGATTGCAAGAACTGCTA
3 AAGAAAGATTGCAAGAACTGTTA

+
+
+
+
+

Finally, what is the number of aligned reads per chromosome?

> summary(exAI)

Number of aligned reads per chromosome:

chr1 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr2 chr3
107

131

106

139

83

56

19

61

44

51

105

48
chr4 chr5 chr6 chr7 chr8 chr9 chrMT chrX chrY
2

102

206

107

68

70

14

52

57

61

3

2.4 Processing the aligned intervals

Sometimes, users may wish to combine certain aligned intervals. One intention could be
to combine aligned reads at exactly the same position, which only diﬀer in their sequence
due to sequencing errors. Another objective could be to combine overlapping short reads
that may be (degradation) products of the same primary transcript. The function reduce
combines a set of aligned intervals into a single aligned interval, if the intervals:

(cid:136) are on the same strand,

(cid:136) are overlapping (or contained in each other) or directly adjacent to each other AND

(cid:136) have the same read match speciﬁcity (see below)

By the read match speciﬁcity r(Ii) of an interval Ii, we refer to
Read match speciﬁcity
the total number of valid alignments of reads that have been aligned to Ii, i.e. the total
numbers of intervals with the same reads aligned in the whole genome (or other set of
reference sequences). If r(Ii) = 1, the reads that were aligned to the interval Ii have no
other valid alignments in the whole genome, i.e. the interval Ii is the unique match position
of these reads. If r(Ii) = 2, the reads that were aligned to the interval Ii have exactly one
other valid alignment to another interval Ij, j (cid:54)= i. The match speciﬁcity is stored in the
matches slot of objects of the class AlignedGenomeIntervals.

We ﬁrst demonstrate the reduce using a toy example data object.

> D <- AlignedGenomeIntervals(
+
+
+
+
+
> detail(D)

start=c(1,3,4,5,8,10,11), end=c(5,5,6,8,9,11,13),
chromosome=rep(c("chr1","chr2","chr3"), c(2,2,3)),
strand=c("-","-","+","+","+","+","+"),
sequence=c("ACATT","ACA","CGT","GTAA","AG","CT","TTT"),
reads=rep(1,7), matches=c(rep(1,6),3))

1
3
4
5
8

start end seq_name strand reads matches sequence
ACATT
-
ACA
-
CGT
+
GTAA
+
AG
+
+
CT
TTT
+

5
5
6
8
9
10 11
11 13

chr1
chr1
chr2
chr2
chr3
chr3
chr3

1
1
1
1
1
1
3

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
4
5
6
7

Calling the reduce method on these example data results in the following:

> detail(reduce(D))

start end seq_name strand reads matches sequence
ACATT
-
CGTAA
+
AGCT
+
TTT
+

5
1
4
8
8 11
11 13

chr1
chr2
chr3
chr3

2
2
2
1

1
1
1
3

1
2
3
4

4

Note that the two last intervals still show overlap. However, the last interval is a non-unique
match position of the respective reads (matches= 3), in contrast to the other intervals.

Here is another example using the data introduced above.

> S <- exAI[seqnames(exAI)=="chrX" & matches(exAI)==1L & exAI[,1]>1e8]
> detail(S)

start

end seq_name strand reads matches

1 100768450 100768472
2 101311567 101311589
3 101311567 101311589
4 101311567 101311589
5 101311567 101311589
6 101311567 101311589
7 148346896 148346918

chrX
chrX
chrX
chrX
chrX
chrX
chrX

-
-
-
-
-
-
+

1
18
12
2
1
1
4

sequence
1 ATATAATACAACCTGCTAACTGT
1 TGAGGTTGGTGTACTGTGTGTGG
1 TGAGGTTGGTGTACTGTGTGTGA
1 TGAGGTTGGTGTACTGTGTGTGT
1 TGACGTTGGTGTACTGTGTGTGA
1 TGAGGTTGGTGTACTGTGTGCGG
1 TGAGGTAGTAGATTGTATAGTTT

Calling the reduce method on these data leads to the following result:

> detail(reduce(S))

start

end seq_name strand reads matches

1 100768450 100768472
2 101311567 101311589
3 148346896 148346918

chrX
chrX
chrX

-
-
+

1
34
4

sequence
1 ATATAATACAACCTGCTAACTGT
1 TGAGGTTGGTGTACTGTGTGTGG
1 TGAGGTAGTAGATTGTATAGTTT

Notice that the reads that match the same segment of the X chromosome diﬀer in their
last base. However, since most of the reads have a ’G’ as ﬁnal letter, the combined aligned
interval als has a ’G’ as the last letter.

The additional argument method="exact" can be speciﬁed if you want to solely combine
intervals that have exactly the same start and stop position (but may have reads of slightly
diﬀerent sequence aligned to them). Consider the following example:

> S2 <- exAI[seqnames(exAI)=="chr11" & matches(exAI)==1L & exAI[,1]>8e7]
> detail(S2)

start

end seq_name strand reads matches

1 86397621 86397643
2 86397621 86397643
3 86397621 86397643
4 88515338 88515360
5 96178500 96178522
6 96178501 96178523
7 108873196 108873218

chr11
chr11
chr11
chr11
chr11
chr11
chr11

-
-
-
-
+
+
-

20
1
2
1
2
1
1

> detail(reduce(S2, method="exact"))

5

sequence
1 TAGCTTATCAGACTGATGTTTAC
1 TAGATTATCAGACTGATGTTTAC
1 TAGCTTATCAGACTGATGTTCAC
1 GGTGCAGGGAGCGCCAGTGTCTC
1 TACCCTGTAGATCCGAATTTTTG
1 ACCCTGTAGATCCGAATTTGTGA
1 AGTGCGGTAACGCGACCGCTACC

start

end seq_name strand reads matches

1 86397621 86397643
2 88515338 88515360
3 96178500 96178522
4 96178501 96178523
5 108873196 108873218

chr11
chr11
chr11
chr11
chr11

-
-
+
+
-

23
1
2
1
1

sequence
1 TAGCTTATCAGACTGATGTTTAC
1 GGTGCAGGGAGCGCCAGTGTCTC
1 TACCCTGTAGATCCGAATTTTTG
1 ACCCTGTAGATCCGAATTTGTGA
1 AGTGCGGTAACGCGACCGCTACC

Notice that the 6th aligned interval in S2 is only shifted by 1 nt from the 5th one. By
default, the function reduce would merge them into one aligned genome interval. However,
when method="exact" is speciﬁed, these two intervals are not merged since they are not
at exactly the same position. There are additional methods for restricting the merging
to intervals with the same 5’- and 3’-ends (specify method="same5" and method="same3",
respectively).

2.5 Visualising the aligned genome intervals

The package girafe contains functions for visualising genomic regions with aligned reads.

> plot(exAI, mgi.gi, chr="chrX", start=50400000,
+

end=50410000, show="minus")

See the result in Figure 1.

Figure 1: A 10-kb region on the mouse X chromosome. Reads aligned to the Watson strand
in this region would be shown above the chromosome coordinate axis with the annotation of
genome elements in this region, while reads aligned to the Crick strand are shown below. In
the region shown, there are only intervals with aligned reads on the Crick strand, and these
four intervals overlap with annotated microRNA positions.

Note that the annotation of genome elements (as shown in Figure 1) has to be supplied to
the function. Here the object mgi.gi contains most annotated genes and ncRNAs for the

6

2520151050Reads on Crick strandMir450bMir450−1Mir450−2Mir542Mir351Mir503Mir3225040000050401000504020005040300050404000504050005040600050407000504080005040900050410000Chromosome chrX coordinate [bp]mouse genome (assembly: mm9 ). This object has been created beforehand2 and it is of
class Genome intervals stranded , a class deﬁned in package genomeIntervals.

2.6 Summarising the data using sliding windows

The data can be searched for regions of deﬁned interest using a sliding-window approach
implemented in the function perWindow. For each window, the number of intervals with
aligned reads, the total number of reads aligned, the number of unique reads aligned, the
fraction of intervals on the Plus-strand, and the higher number of aligned reads at a single
interval within the window are reported.

> exPX <- perWindow(exAI, chr="chrX", winsize=1e5, step=0.5e5)
> head(exPX[order(exPX$n.overlap, decreasing=TRUE),])

chr

start

942 chrX 50341103 50441102
943 chrX 50391103 50491102
1960 chrX 101241103 101341102
1961 chrX 101291103 101391102
1216 chrX 64041103 64141102
1215 chrX 63991103 64091102

end n.overlap n.reads n.unique frac.plus max.reads
28
28
18
18
2
2

55
55
34
34
5
4

18
18
5
5
4
3

18
18
5
5
4
3

0
0
0
0
0
0

first

last
50401220 50407226
942
50401220 50407226
943
1960 101311567 101311589
1961 101311567 101311589
1216 64049984 64092296
1215 64049984 64067192

2.7 Exporting the data

The package girafe also contains methods for exporting the data into tab-delimited text
ﬁles, which can be uploaded to the UCSC genome browser3 as ’custom tracks’.

Currently, there are methods for exporting the data in ’bed’ format and ’bedGraph’ format,
either writing intervals from both strands into one ﬁle or into two separate ﬁles. Details
about these track formats can be found at the UCSC genome browser web pages.

> export(exAI, con="export.bed",
+
+
+

format="bed", name="example_reads",
description="Example reads",
color="100,100,255", visibility="pack")

2See the script prepareAnnotation.R in the package scripts directory for an example of how to create

such an object.

3http://genome.ucsc.edu

7

Additional arguments to the export function, besides object, con, and format, are treated
as attributes for the track deﬁnition line, which speciﬁes details concerning how the data
should be visualised in the genome browser.

Users may also wish to consult the Bioconductor package rtracklayer for data transfer and
direct interaction between R and the UCSC genome browser.

2.8 Overlap with annotated genome features

Next, we determine the degree of overlap of the aligned reads with annotated genomic
elements. In this example, the annotated genome elements are provided as an object of
class Genome intervals stranded 4. This objects needs to be created beforehand. See the
script prepareAnnotation.R in the package scripts directory5 for an example of how to
create such an object.

> exOv <- interval_overlap(exAI, mgi.gi)

How many elements do read match positions generally overlap?

> table(listLen(exOv))

0

1

815 340 130

2 12
1

What are the 12 elements overlapped by a single match position?

> mgi.gi$ID[exOv[[which.max(listLen(exOv))]]]

[1] "Pcdha1" "Pcdha2" "Pcdha3" "Pcdha4" "Pcdha5" "Pcdha6" "Pcdha7"
[8] "Pcdha8" "Pcdha9" "Pcdha10" "Pcdha11" "Pcdha12"

And in general, what kinds of annotated genome elements are overlapped by reads?

> (tabOv <- table(as.character(mgi.gi$type)[unlist(exOv)]))

lincRNA
15

miRNA
297

ncRNA pseudogene
28

19

rRNA
10

snoRNA
1

gene
238
tRNA
4

We display these overlap classes using a pie chart.

> my.cols <- brewer.pal(length(tabOv), "Set3")
> pie(tabOv, col=my.cols, radius=0.88)

8

Figure 2: Pie chart showing what kinds of genome elements are overlapped by aligned reads.
Note that the proportions of the pie chart are given by the proportions among all annotated
genome elements that have ≥ 1 reads mapped to them and not by the total numbers of reads
mapped to elements of that class, in which case the proportion of the miRNA class would
be signiﬁcantly larger.

See the result in Figure 2.

Note that function interval.overlap only determines whether two intervals are overlap-
ping by at least one base. For restricting the result to intervals overlapping by at least a cer-
tain number of bases or by a fraction of the interval’s length, see the function fracOverlap.

3 Memory usage

At the moment, girafe and the packages that it depends on, retain all the information
concerning the read alignments in memory. This allows quick access to and swift operations
on the data, but may limit the package’s usability on machines with low amounts of RAM.

The step with the highest RAM requirements is importing the alignments and saving them
as objects of the AlignedRead class using the functionality in package ShortRead . Usually,
objects of the AlignedGenomeIntervals class are created starting from AlignedRead objects
and the AlignedRead objects can safely be discarded after this step. Since the data is
summarised in that process, AlignedGenomeIntervals objects require about 10–100 times

4Objects of class Genome intervals and AlignedGenomeIntervals are also allowed.
5system.file("scripts", package="girafe")

9

genelincRNAmiRNAncRNApseudogenerRNAsnoRNAtRNAless memory than the original AlignedRead object6. We recommend that the import of
the alignments and the generation of the AlignedGenomeIntervals are performed using a
separate script which only needs to be called once on a machine with suﬃcient RAM.

A suggestion for limiting memory usage is to perform the read alignments and import of the
results in batches of a few million reads each. The batch-wise result AlignedGenomeIntervals
objects can later be combined using the basic R function ”c”, the standard way of combining
objects, optionally followed by calls of the reduce function.

For alignments in SAM/BAM format, the Samtools software suite (Li et al., 2009) as well
as the Bioconductor package Rsamtools allow the user to access and import only selected
subsets of the data, which also leads to a lower memory footprint. For details, please refer
to the documentation of these packages.

Finally, while the processing of AlignedRead objects is the principal way of generating
AlignedGenomeIntervals objects, there is also a convenience function called
AlignedGenomeIntervals, which can be used to create these objects from simpler objects in
the work space, such as data read in using basic R functions such as scan. This convenience
function may be easier to use for importing and processing the data in manageable chunks.

When following these suggestions, most operations with the girafe package should be pos-
sible on a machine with 4 Gb of RAM, and we have not so far encountered a situation that
requires more than 12 Gb (state as of the end of 2009). However, increased throughput of
sequencing machines and longer reads will lead to increased memory requirements. Future
developments of this and other NGS-related Bioconductor packages will therefore likely
concern ways to reduce the memory footprint. One idea is to make use of packages like ﬀ ,
which provide ways of swapping data from RAM to ﬂat ﬁles on the hard disk, while still
allowing fast and direct access to the data.

4 A word about speed

For improving the run time on machines with multiple processors, some of the functions in
the girafe package have been implemented to make use of the functionality in the parallel
package.
If parallel has been attached and initialised before calling these functions, the
functions will make use of mclapply instead of the normal lapply function. The number of
cores to be used in parallel is determined by the mc.cores option (see the example below).

For example, if parallel is functional on a given system7, there should be an obvious speed
improvement in the following code example.

> library("parallel")
> options("mc.cores"=4) # adjust to your machine
> exAI.R <- reduce(exAI, mem.friendly=TRUE)

6e.g., an AlignedRead object for holding 106 reads of length 36 bp aligned to the mouse reference genome

occupies about 1.4 Gb in RAM but is processed into an AlignedGenomeIntervals object of size 66.7 Mb

7The mclapply function currently does not support Windows operating systems.

10

5 Links to other Bioconductor packages

The girafe package is mostly built upon the interval notation and implementation pro-
vided by the packages intervals and genomeIntervals. Functions from the ShortRead pack-
age (Morgan et al., 2009) are used for importing the data, and Biostrings provides help for
working with the read nucleotide sequences. girafe also makes limited use of the Rle and
IRanges classes deﬁned in the IRanges package. Furthermore, the data can be converted
between object classes deﬁned in girafe and IRanges.

We note that many of the interval operations in girafe can also be performed using classes
and functions deﬁned in the IRanges package. However, the scope of the packages is slightly
diﬀerent. While IRanges is meant to be a generic infrastructure package of the Bioconductor
project, the aim of girafe is to provide a single, comparatively lightweight, object class for
working with reads aligned to the genome, the AlignedGenomeIntervals. This class and its
methods allow easy access to such data and facilitate standard operations and workﬂows.

There is some overlap in functionality between girafe, IRanges, GenomicRanges and track-
layer . The range of interactions between these packages and new Bioconductor packages
related to next-generation sequencing is likely to increase over the releases. Our aim is to
provide users with a broad range of alternatives for selecting the classes and functions that
are most suited for their workﬂows.

Package versions

This vignette was generated using the following package versions:

(cid:136) R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu
(cid:136) Running under: Ubuntu 16.04.3 LTS
(cid:136) Matrix products: default
(cid:136) BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
(cid:136) LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so
(cid:136) Base packages: base, datasets, grDevices, graphics, grid, methods, parallel, stats, stats4, utils
(cid:136) Other packages: AnnotationDbi 1.40.0, Biobase 2.38.0, BiocGenerics 0.24.0,

BiocParallel 1.12.0, Biostrings 2.46.0, DelayedArray 0.4.0, GenomeInfoDb 1.14.0,
GenomicAlignments 1.14.0, GenomicRanges 1.30.0, IRanges 2.12.0, RColorBrewer 1.1-2,
Rsamtools 1.30.0, S4Vectors 0.16.0, ShortRead 1.36.0, SummarizedExperiment 1.8.0,
XVector 0.18.0, genomeIntervals 1.34.0, girafe 1.30.0, intervals 0.15.1, matrixStats 0.52.2,
org.Mm.eg.db 3.4.2

(cid:136) Loaded via a namespace (and not attached): DBI 0.7, GenomeInfoDbData 0.99.1,
Matrix 1.2-11, RCurl 1.95-4.8, RSQLite 2.0, Rcpp 0.12.13, bit 1.1-12, bit64 0.9-7,
bitops 1.0-6, blob 1.1.0, compiler 3.4.2, digest 0.6.12, hwriter 1.3.2, lattice 0.20-35,
latticeExtra 0.6-28, memoise 1.1.0, pkgconﬁg 2.0.1, rlang 0.1.2, tibble 1.3.4, tools 3.4.2,
zlibbioc 1.24.0

Acknowledgements

Many thanks to Nicolas Servant, Val´erie Cognat, Nicolas Delhomme, and especially Patrick Aboyoun
for suggestions and feedback on the package. Special thanks to Julien Gagneur and Richard Bourgon

11

for writing genomeIntervals and for rapidly answering all my questions regarding the package.
The plotting functions in package girafe are largely based on the function plotAlongChrom and its
auxiliary functions from package tilingArray, most of which were written by Wolfgang Huber.
Funding: This work was supported by the Institut Curie, INCa ”GepiG”.

References

R. Edgar, M. Domrachev, and A. E. Lash. Gene Expression Omnibus: NCBI gene expression and

hybridization array data repository. Nucleic Acids Res, 30(1):207–210, Jan 2002.

R. C. Gentleman, V. J. Carey, D. J. Bates, B. M. Bolstad, M. Dettling, S. Dudoit, B. Ellis, L. Gau-
tier, Y. Ge, J. Gentry, K. Hornik, T. Hothorn, W. Huber, S. Iacus, R. Irizarry, F. Leisch, C. Li,
M. Maechler, A. J. Rossini, G. Sawitzki, C. Smith, G. K. Smyth, L. Tierney, Y. H. Yang, and
J. Zhang. Bioconductor: Open software development for computational biology and bioinformat-
ics. Genome Biology, 5:R80, 2004.

B. Langmead, C. Trapnell, M. Pop, and S. L. Salzberg. Ultrafast and memory-eﬃcient alignment

of short DNA sequences to the human genome. Genome Biology, 10(3):R25, 2009.

H. Li, B. Handsaker, A. Wysoker, T. Fennell, J. Ruan, N. Homer, G. Marth, G. Abecasis, and R. D.
and. The Sequence Alignment/Map format and SAMtools. Bioinformatics, 25(16):2078–9, Aug
2009.

M. Morgan, S. Anders, M. Lawrence, P. Aboyoun, H. Pages, and R. Gentleman. ShortRead: a
Bioconductor package for input, quality assessment and exploration of high-throughput sequence
data. Bioinformatics, 25(19):2607–2608, Oct 2009.

O. H. Tam, A. A. Aravin, P. Stein, A. Girard, E. P. Murchison, S. Chelouﬁ, E. Hodges, M. Anger,
R. Sachidanandam, R. M. Schultz, and G. J. Hannon. Pseudogene-derived small interfering RNAs
regulate gene expression in mouse oocytes. Nature, 453(7194):534–538, May 2008.

J. Toedling, C. Ciaudo, O. Voinnet, E. Heard, and E. Barillot. girafe - an R/Bioconductor package
for functional exploration of aligned next-generation sequencing reads. Bioinformatics, 26(22):
2902–2903, Nov 2010.

12

