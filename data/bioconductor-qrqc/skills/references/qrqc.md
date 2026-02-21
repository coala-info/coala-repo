Using the qrqc package to gather information about
sequence qualities

Vince Buﬀalo

Bioinformatics Core
UC Davis Genome Center

vsbuffalo@ucdavis.edu

2012-02-19

Abstract

Many projects in bioinformatics begin with raw sequences from a high-throughput se-
quencer that must be quality checked before additional analysis steps can proceed. The
qrqc (Quick Read Quality Control) package is a fast and extensible package that reports
basic quality and summary statistics on FASTQ and FASTA ﬁles, including base and qual-
ity distribution by position, sequence length distribution, k-mers by position, and common
sequences.

1 Reading in a Sequence File

The qrqc package reads and processes FASTA and FASTQ ﬁles in C for speed, through the
function readSeqFile. Optionally, sequences can be hashed (also done at the C level), to see
the most frequent sequences in the ﬁle. Hashing is memory intensive (all unique sequence reads
are kept in memory once), so by default, readSeqFile will randomly sample 10% of the reads
and hash these. This proportion can be adjusted with the hash.prop. Also, k-mers are hashed
(when kmer=TRUE) with the same proportion as set by hash.prop.

> library(qrqc)
> s.fastq <- readSeqFile(system.file(

’

extdata

’

’

,

test.fastq

’

, package=

’

’

qrqc

))

Note that there is a maximum sequence length argument in readSeqFile, max.length. By
default, this is 1,000. It is used to pre-allocate the matrices in C, and could be much larger than
the largest sequence encountered without many downsides (its memory usage is relatively low).
If a sequence larger than max.length is encountered, the function will stop, and the user can
call the function again with a larger max.length.

Readseqfile produces a FASTQSummary object, which inherits from the SequenceSummary

class. Printing the object lists a very short summary:

> s.fastq

Quality Information for: test.fastq

100 sequences, 89 unique with 0.10 being sampled

1

Figure 1: A plot of quality by base position, with sequence length histogram.

mean quality: 63.673900
min sequence length: 84
max sequence length: 84

Optionally, readSeqFile can be run without hashing, with hash=FALSE. readSeqFile also

works on FASTA ﬁles, but type=FASTA must be speciﬁed.

2 Plotting Quality of FASTQSummary Objects

If the ﬁle read and summarized with readSeqFile is a FASTQ ﬁle (and thus the resulting object
is from the FASTQSummary class), quality information by position can be plotted with qualPlot,
which produces a graphic as in Figure ??:

> qualPlot(s.fastq)

If there’s variability in sequence length, one should interpret this quality plot with the se-
quence length histogram (as produced by seqlenPlot), as low quality at a particular base po-
sition is less worrisome if there are few reads with this sequence length. The grey lines indicate
the 10% and 90% quantiles, orange lines indicate the lower and upper quartiles, the blue dot is
the median, and the green dash the mean. A purple smooth curve is ﬁt through the distribu-
tions. This line is ﬁt by ﬁrst randomly drawing values from the empirical (binned) distribution
of qualities at a particular base, then using ggplot2 ’s geom_smooth with these points.

2

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll40506070020406080positionqualityFigure 2: A plot of quality by base position after being trimmed with Sickle.

qualPlot can be very useful in inspecting base qualities before and after read quality con-
trol pipelines. For example, the package contains test-trimmed.fastq, which has the same
sequences as test.fastq after being trimmed with Nik Joshi’s Sickle, a windowed adaptive
quality trimmer.

Each plot can be made separately by passing each FASTQSummary object directly to qualPlot.
However, qualPlot has methods to handle a named list of FASTQSummary objects. Each will be
plotted in a panel of its own.

> s.trimmed.fastq <- readSeqFile(system.file(
> qualPlot(list("trimmed"=s.trimmed.fastq, "untrimmed"=s.fastq))

extdata

,

test-trimmed.fastq

’

’

’

’

, package=

’

’

qrqc

))

3 Base Plots of FASTQSummary and FASTASummary Ob-

jects

qualPlot is the only plotting method that works only on FASTQSummary objects. Other plotting
methods work for FASTQSummary and FASTASummary objects. Base frequencies (counts) and
base proportions by position can be plotted with basePlot. When used with type=’frequency’,
basePlot produces a graphic as in Figure 3:

> basePlot(s.fastq)

3

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllltrimmeduntrimmed02040608002040608040506070positionqualityFigure 3: Base frequencies by position in sequence.

4

0255075100020406080positionfrequencybaseATCGNFigure 4: Base proportions by position in sequence.

basePlot uses a color scheme from biovizBase, which (according to their goals) make biolog-

ical sense, are aesthetically pleasing, and accommodate those that are colorblind.

By default, the color scheme is determined by biovizBase’s getBioColor with“DNA BASES N”

(which includes A, T, C, G, and N). A scheme for IUPAC codes can be used too; use colorval-
ues=getBioColor(’IUPAC_CODE_MAP’). If one is making custom graphics, these color schemes
can be more easily accessed through scale_color_dna and scale_color_iupac.

basePlot also accepts a bases parameter, which can be used to specify speciﬁc bases. This

is useful for plotting just the frequency of ‘N’.

Base proportions by position can be plotted with basePlot, with type=’proportion’. This
plot is basically identical to the plot produced with type=’frequency’ with a diﬀerent y scale.
Diﬀerent geoms (see ggplot2 for more details) can be speciﬁed too with the geom parameter. By
default, a line graph is used, but bar graphs (through geom=’bar’) and bar graphs with dodged
bars (through geom=’dodge’) can be plotted also, as in Figure 4.

> basePlot(s.fastq, bases=c("G", "C"), geom="bar", type="proportion")

Sequence length distribution can be plotted with seqlenPlot (graphic shown in Figure ??):

> seqlenPlot(s.trimmed.fastq)

The GC content can be plotted with gcPlot (graphic shown in Figure ??). Here, we can

start to see how using ggplot2 can easily add to qrqc’s plotting functions.

> gcPlot(s.fastq) + geom_hline(yintercept=0.5, color="purple")

5

0.00.20.40.6020406080positionproportionbaseCGFigure 5: Histogram of sequence lengths after quality trimming.

6

0204060020406080lengthcountFigure 6: GC content by position

7

0.00.20.40.6020406080positiongcFigure 7: Shannon Entropy for an Illumina ﬁle and a FASTA ﬁle made from uniformly and
randomly sampling bases.

4 k-mer Hashing and Investigating Contamination with

Shannon Entropy and K-L Divergence

readSeqFile also has an option to hash k-mers. By default, readSeqFile randomly selects 10%
of the reads and hashes their k-mers with k=6. The accessor function getKmer will return a data
frame of k-mer frequency by position.

The function kmerEntropyPlot will plot the Shannon entropy by position, as in Figure 7.
kmerEntropyPlot will handle any object that inherits from SequenceSummary or a named list of
such objects.

> s.rand <- readSeqFile(system.file(
> kmerEntropyPlot(list("contaminated"=s.fastq, "random"=s.rand))

random.fasta

extdata

,

, package=

’

’

’

’

’

’

qrqc

), type="fasta")

To look for possible contamination in this k-mer frequency data, the function calcKL calcu-
lates the Kullback-Leibler divergence between the distribution of k-mers at a particular positions
(for all positions) and the distribution of k-mers across all positions. The result is a data frame
of the K-L terms, of which a subset are stacked in the plot produced by kmerKLPlot, as in Figure
8.

> kmerKLPlot(s.fastq)

8

contaminatedrandom0255075025507546810positionentropyFigure 8: K-L terms for a subset of top k-mers.

9

0120204060positionK−L divergence of selected componentskmerAAGGTCACTCTGAGTTGTATCTCCCAGTTGCATAGTCTCCCGCTCTGACTGAATGCATAGGTAAGGGTTGTATAAGGTTACTCTTCTCCCTCTGAATGAATCTGTCCTTTACTCTTGTAAFigure 9: K-L terms for a subset of top k-mers for many SequenceSummary objects.

Note that the total height is proportional to the actual K-L divergence; because only a subset
of the k-mers are used to avoid over plotting, this is not the full K-L divergence (it’s a subset of
the sample space of k-mers). The number of top k-mers (determined by ﬁnding the k-mers with
the highest K-L terms) is controlled by setting the number of k-mers to include with n.kmers.
Passing a list of objects that inherit from SequenceSummary will facet the K-L divergence term
plot, as in Figure 9

> contam.file <- system.file(
> s.contam <- readSeqFile(contam.file, kmer=TRUE, k=5)
> kmerKLPlot(list("contaminated"=s.fastq, "random"=s.rand,
+

"highly contaminated"=s.contam))

test-contam.fastq

extdata

,

’

’

’

’

, package=

’

’

qrqc

)

5 Customizing Graphics with ggplot2

A major motivating factor of using ggplot2 with qrqc is that it allows easy customization of plots
without requiring plotting methods to have excessive arguments. For example, if we wish to ﬂip
the coordinates of a plot, we easily with coord_flip(), as in Figure 10.

> basePlot(s.fastq, geom="bar") + coord_flip()

scale_x_continuous and scale_y_continuous can be used to change axis labels and limits
of the window. For example, one can focus on only the 3’-end bases, as in Figure 11. In this
example, we also use theme_bw() to remove ggplot2 ’s default grey background.

10

contaminatedhighly contaminatedrandom0255075100025507510002550751000123positionK−L divergence of selected componentskmerAACTTAAAGGTCACTCTGAGCACGAGTTGTATCTCCCAGTTGCATAGTCTACATCTCCCGCTCTGACTGAATGATCGCGCATAGGTAACTGTAAGGGTCCAAGTGAGGGTTGTATAAGGTTACTCTTAGATCTCTCCCTCTGAATGAATCTGTCCTTTACTCTTGCAGTTGTAAAAGGTGAGTTAGCATGACCGATTTCTAAACGCACGTGGGATGGGGGCGGTTTATTACGTATGGCGCAACGCAAGCAACGCAAGAGTAGCAGAGTGGATCAACAACGCAGAGCAGTGCGCAGGAGTAGCAGAGCAGTGGTATGTATCGTGGTTATCATCAACTGGTAFigure 10: Flipped coordinate base plot.

11

0204060800255075100frequencypositionbaseATCGNFigure 11: Controlling the x-axis.

12

lllllllllllllllllllllllll40506070606570758085positionqualityFigure 12: Accessor functions with custom ggplot2 plots.

> qualPlot(s.fastq) + scale_x_continuous(limits=c(60, 85)) + theme_bw()

6 Accessor Functions

One can access the summary data gathered by readSeqFile through the slots in an object
that inherits from SequenceSummary. However, these are straight from the C function used
by readSeqFile and not easy to work with. The accessor functions getBase, getBaseProp,
getQual, getSeqlen, getKmer, and getMCQual return data frames that can then be used directly
with ggplot2.

> ggplot(getQual(s.fastq)) + geom_linerange(aes(x=position, ymin=lower,
ymax=upper, color=mean)) + scale_color_gradient("mean quality",
+
low="red", high="green") + scale_y_continuous("quality")
+

7 HTML Report Generation

With the help of brew and xtable, qrqc can generate an HTML summary report. This is created
with makeReport. Reports are stored in their own directories, with images kept under ‘images/’
and the report is “report.html”. A speciﬁc output directory can be passed through the outputDir
argument, but the present directory is used as a default. Multiple reports generated in the same
directory will have an incremental naming scheme.

13

556065020406080positionquality57.560.062.565.0mean quality8 Working with the FASTQSummary and FASTASummary

classes

qrqc provides the FASTQSummary and FASTASummary classes for users to build functions and
applications around. Both inherit from SequenceSummary, which should not be used directly.

FASTASummary has the same slots as FASTQSummary, except the latter provides additional slots

for quality information. Both contain:

(cid:136) filename: the ﬁlename of the ﬁle read and summarized with readSeqFile.

(cid:136) base.freqs: a data frame containing the frequency counts of each base.

(cid:136) seq.lengths: a numeric vector containing the sequences lengths (counts by position).

(cid:136) hash: a numeric vector containing the counts of unique sequences (the actual sequences

are the names attribute).

(cid:136) hash.propa numeric value indicating the proportion of sequences that were sampled for

hashing.

(cid:136) kmera data frame of k-mer frequency by position.

(cid:136) kan integer value indicating the k-mer size ’k’.

(cid:136) hashed: a logical indicating whether sequence hashing to count unique sequences was done.

(cid:136) kmers.hashed: a logical indicating whether k-mer hashing was done.

Additionally, FASTQSummary provides:

(cid:136) qual.freqs: a data frame containing the counts of bases of a particular quality by position.

(cid:136) mean.qual: a numeric giving the mean quality, weighted by sequence lengths.

9 Acknowledgements

Thanks to Simon Andrews for his work on FastQC (a similar program written in Java) from
which this project was inspired. Also thanks to Joseph Fass and Dawei Lin for their advice and
helpful comments.

Thanks to Heng Li for his work on kseq.h khash.h (both MIT License) which this pack-
age uses through RSamtools. More on these header ﬁles can be found at http://lh3lh3.users.
sourceforge.net/kseq.shtml and http://attractivechaos.awardspace.com/khash.h.html.
Sickle can be downloaded or cloned from the UC Davis Bioinformatics Github repository:

https://github.com/ucdavis-bioinformatics/sickle.

10 Session Info

> sessionInfo()

14

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

other attached packages:

graphics grDevices utils

datasets

[1] qrqc_1.30.0
[4] GenomicRanges_1.28.0 GenomeInfoDb_1.12.0 xtable_1.8-2
[7] brew_1.0-6

testthat_1.0.2

Rsamtools_1.28.0

[10] XVector_0.16.0
[13] BiocGenerics_0.22.0 ggplot2_2.2.1

biovizBase_1.24.0
IRanges_2.10.0

Biostrings_2.44.0
S4Vectors_0.14.0
reshape_0.8.6

loaded via a namespace (and not attached):

[1] Biobase_2.36.0
[3] AnnotationHub_2.8.0
[5] Formula_1.2-1
[7] interactiveDisplayBase_1.14.0 latticeExtra_0.6-28
[9] BSgenome_1.44.0

httr_1.2.1
splines_3.4.0
shiny_1.0.2

[11] yaml_2.1.14
[13] backports_1.0.5
[15] digest_0.6.12
[17] checkmate_1.8.2
[19] htmltools_0.3.5
[21] Matrix_1.2-9
[23] XML_3.98-1.6
[25] zlibbioc_1.22.0
[27] BiocParallel_1.10.0
[29] tibble_1.3.0
[31] AnnotationFilter_1.0.0
[33] GenomicFeatures_1.28.0
[35] lazyeval_0.2.0
[37] survival_2.41-3
[39] mime_0.5
[41] nlme_3.1-131

GenomeInfoDbData_0.99.0
RSQLite_1.1-2
lattice_0.20-35
RColorBrewer_1.1-2
colorspace_1.3-2
httpuv_1.3.3
plyr_1.8.4
biomaRt_2.32.0
scales_0.4.1
htmlTable_1.9
mgcv_1.8-17
SummarizedExperiment_1.6.0
nnet_7.3-12
crayon_1.3.2
magrittr_1.5
memoise_1.1.0
foreign_0.8-67

15

[43] BiocInstaller_1.26.0
[45] data.table_1.10.4
[47] stringr_1.2.0
[49] cluster_2.0.6
[51] AnnotationDbi_1.38.0
[53] compiler_3.4.0
[55] RCurl_1.95-4.8
[57] VariantAnnotation_1.22.0
[59] labeling_0.3
[61] base64enc_0.1-3
[63] DBI_0.6-1
[65] GenomicAlignments_1.12.0
[67] knitr_1.15.1
[69] Hmisc_4.0-2
[71] stringi_1.1.5
[73] rpart_4.1-11

tools_3.4.0
matrixStats_0.52.2
munsell_0.4.3
DelayedArray_0.2.0
ensembldb_2.0.0
grid_3.4.0
dichromat_2.0-0
htmlwidgets_0.8
bitops_1.0-6
gtable_0.2.0
R6_2.2.0
gridExtra_2.2.1
rtracklayer_1.36.0
ProtGenerics_1.8.0
Rcpp_0.12.10
acepack_1.4.1

16

